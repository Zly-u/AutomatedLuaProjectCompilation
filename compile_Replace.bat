@echo off
title LuaJit project compiler

set compilerFolder=%~dp0
set gameFolder=%~1


IF "%gameFolder%"=="" (
	echo You need to drag and drop folder or single script file!
	pause
	exit
) else (
	if exist "%gameFolder%"\* (
		set fileType=Directory
	) else (
		set fileType=File
	)
)

echo Target game %fileType%: %gameFolder%
echo --------------
echo Compiling...
if "%fileType%"=="Directory" (
	CALL :CompileDir
) else if "%fileType%"=="File" (
	CALL :CompileFile
)

echo.
echo ============================
echo I guess it's done idk
echo.
pause
EXIT /B %ERRORLEVEL%

:CompileDir
	echo.
	cd %gameFolder%
	(FOR /r %%F IN (*.lua) DO (
		echo "%%F"
		cd "%compilerFolder%bin"
		luajit.exe -b "%%F" "%%F"
		echo --------------
	))
EXIT /B 0

:CompileFile
	cd "%compilerFolder%bin"
	luajit.exe -b "%gameFolder%" "%gameFolder%"
EXIT /B 0