@ECHO OFF

:Start

:InstallVJoy
ECHO Installing vJoy...
".\assets\vJoySetup.exe"

:OpenConfig
ECHO Starting Config...
ECHO Please make your vJoy Config look like the example, then exit the program.

".\assets\configReference.png"
"%PROGRAMFILES%\vJoy\x64\vJoyConf.exe"

:CreateShortcut
ECHO Creating Shortcut...
SETLOCAL ENABLEDELAYEDEXPANSION
SET LinkName=joycon-driver
SET Esc_LinkDest=.\joycon-driver.lnk
SET Esc_LinkTarget=%~dp0\assets\joycon-driver\joycon-driver.exe
SET Esc_LinkStartIn=%~dp0\assets\joycon-driver\
SET cSctVBS=CreateShortcut.vbs
SET LOG=".\%~N0_runtime.log"
((
  echo Set oWS = WScript.CreateObject^("WScript.Shell"^) 
  echo sLinkFile = oWS.ExpandEnvironmentStrings^("!Esc_LinkDest!"^)
  echo Set oLink = oWS.CreateShortcut^(sLinkFile^) 
  echo oLink.TargetPath = oWS.ExpandEnvironmentStrings^("!Esc_LinkTarget!"^)
  echo oLink.WorkingDirectory = oWS.ExpandEnvironmentStrings^("!Esc_LinkStartIn!"^)
  echo oLink.Save
)1>!cSctVBS!
cscript //nologo .\!cSctVBS!
DEL !cSctVBS! /f /q
)1>>!LOG! 2>>&1

ECHO.
ECHO.

:FinalPrompt
ECHO Please Connect Joycons via Bluetooth.
ECHO If Steam asks to register new controllers, press Cancel for each prompt.
PAUSE
ECHO.
ECHO Run Connect.bat
ECHO Then, open and start joycon-driver.
ECHO.
GOTO Finish

:Finish
ECHO Script Finished, Closing.
PAUSE
GOTO End

:End