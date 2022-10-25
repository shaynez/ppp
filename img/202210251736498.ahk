;全局变量
; Hotkeys for JEFFMEME at 20121010
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2   
SetTitleMatchMode, Slow    ;wintext不支持npotpad++ 等多标签页
DetectHiddenWindows, On
DetectHiddenText, On   
SetTitleMatchMode RegEx

;StartUP
ProcessExist(Name)
{
 Process,Exist,%Name%
 return Errorlevel
}


Activate(t)
{
  IfWinActive,%t%
  {
    ;WinMinimize
    ;Msgbox, alreadyopen
    Return 1
  }
  SetTitleMatchMode 2    
  DetectHiddenWindows,on
  IfWinExist,%t%
  {
    WinShow
    WinActivate  
    Return 1	
  }
  Return 0
}

ActivateAndOpen(t,p)
{  
  if Activate(t)==0
  {
    Run %p%
    WinActivate
    Return 
  }
  Return 
}


;^h::
;  send {Backspace}
;Return


;EverNote
#i:: 
 Send #+f
 Loop {   
   ;IfWinActive, Evernote
   IfWinActive ahk_class ENMainFrame
    break
 } 
 sleep, 300 
 Send intit
 sleep, 100
 send le::
Return

;EverNote
#+e:: 
 Send #+f
 Loop {   
  ;IfWinActive, Evernote
  IfWinActive ahk_class ENMainFrame
  break
 } 
 sleep, 300
 Send "
Return



;paste without ap
#+INS::  
  prevClipboard := ClipboardAll 
  Clipboard := RegExReplace(Clipboard, " ",".*")
  send %Clipboard% 
  Clipboard := prevClipboard
Return




; Program in common use
;#a::ActivateAndOpen("Chrome","C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe")



#+s::Send #!+s
return





;Everything+DeskTop
#+o::   
  sleep, 100
  ActivateAndOpen("Everything","C:\Program Files\Everything\Everything.exe")
  sleep, 100
  Send ^f	
  Loop {   
   IfWinActive, Everything
       break
   } 
  Send C:\Users\Shaynez\Desktop\{space}
  ;send ^s
return



;按键映射
;<!SPACE::Send #r
;Return

;<!\::Send ^zz 
;Return



;搜索---------------------------------

;百度
#b::
  prevClipboard := ClipboardAll 
  sleep, 100
  Send ^c   
  sleep, 100
  ClipWait, 1
  if !(ErrorLevel)  { 
    Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "(^\s+|\s+$)")
    If SubStr(ClipBoard,1,7)="http://"
      Run, % Clipboard
    else 
      Run https://www.baidu.com/#wd=%Clipboard%
  } 
  Clipboard := prevClipboard
Return

;Google
#g::
 prevClipboard := ClipboardAll
  sleep, 100
  Send ^c   
  sleep, 100
  ClipWait, 1
  if !(ErrorLevel)  { 
    Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "(^\s+|\s+$)")
    If SubStr(ClipBoard,1,7)="http://"
      Run, % Clipboard
    else 
      Run https://www.google.com//search?hl=en&q=%Clipboard%
  } 
  Clipboard := prevClipboard
Return






;WebSite
#Space::
 prevClipboard := ClipboardAll
  sleep, 100
  Send ^c   
  sleep, 100
  ClipWait, 1
  if !(ErrorLevel)  { 
    Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "(^\s+|\s+$)")
    Run, % Clipboard    
  } 
  Clipboard := prevClipboard
Return










	
	
;Windows 10 虚拟桌面自动切换

#Persistent
$ctrl::
if ctrl_presses > 0 ; SetTimer 已经启动，所以我们记录按键。
{
ctrl_presses += 1
return
}
;否则，这是新一系列按键的首次按键。将计数设为 1 并启动定时器：
ctrl_presses = 1
SetTimer, Keyctrl, 500 ;在 500 毫秒内等待更多的按键。
return
Keyctrl:
SetTimer, Keyctrl, off
if ctrl_presses = 1 ;该键已按过一次。
{
Gosub singleClick
}
else if ctrl_presses = 2 ;该键已按过两次。
{
Gosub doubleClick
}
else if ctrl_presses = 3
{
Gosub trebleClick
}
;不论上面哪个动作被触发，将计数复位以备下一系列的按键：

ctrl_presses = 0
return
singleClick:
send {ctrl}
return

doubleClick:
send #^{right}
return

trebleClick:
send #^{left}
return

;不论上面哪个动作被触发，将计数复位以备下一系列的按键：
SPACE_presses = 0
return
singleClick2:
send {SPACE}
return

doubleClick2:
send {enter}
return


;Temp keymap
#z:: 
  Send p sizeof(
  Send +{Insert}
  Send )
  Send {enter}
return

