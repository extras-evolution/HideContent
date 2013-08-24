//<?php
/** * HideContent * * @category     plugin * @version     1.0 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL) * @author      Valyan * @internal    @properties * @internal    @events OnWebPagePrerender * @internal    @modx_category Login */
 

 //{hidecontent}скрытый текст{/hidecontent}
//{hidecontent groups=`Registered Users`}скрытый текст{/hidecontent}
//{hidecontent alternative=`зарегистрируйтесь, чтобы увидеть скрытый текст`}скрытый текст{/hidecontent}
function checkHide($m){
 global $modx;
 $parametrs = $m[1];
 $content = $m[2];
 preg_match ( '/groups\s*=\s*`([^`]*)`/is'  , $parametrs, $groups);
 preg_match ( '/alternative\s*=\s*`([^`]*)`/is'  , $parametrs, $alternative);
 if (empty($groups) && $modx->userLoggedIn()) {return $content;} //Temus
 $groups = explode(",", $groups[1]);
 if ($modx->isMemberOfWebGroup($groups)){
 return $content;
 }else{
 if (empty($alternative)){
 return '';  
 }else{
 $alternative = $alternative[1];
 if (strlen($alternative)<200){
 if ($content = $modx->getChunk($alternative)){
 return $content;
 }
 }
 return $alternative;
 } 
 }
}
 
$e = &$modx->Event; 
switch ($e->name) { 
 case "OnWebPagePrerender":
 $content = $modx->documentOutput;
 while($content0 != $content = preg_replace_callback('/{hidecontent([^}]*)}  ([^{}]*)  {\/hidecontent}/xs', "checkHide", $content0 = $content));
 $modx->documentOutput = $content;
 break;
}