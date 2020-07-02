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
	echo Compiling...
	echo.
	cd %gameFolder%
	(FOR /r %%F IN (*.lua) DO (
		echo "%%F"
		cd "%compilerFolder%bin"
		luajit.exe -b "%%F" "%%Fc"
		echo --------------
	))
EXIT /B 0

:CompileFile
	echo Compiling...
	cd "%compilerFolder%bin"
	luajit.exe -b "%gameFolder%" "%gameFolder%c"
EXIT /B 0