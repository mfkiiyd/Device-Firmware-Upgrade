@echo off
rem ==============================================================
rem  UB32 Bootloader WinUSB driver - one-click installer
rem  driver_installer.exe (libwdi) borrowed from UBEST Toolbox
rem
rem  Equivalent to running, for every device in drivers.txt:
rem    driver_installer.exe -n "UB32 Bootloader" -v 0xVVVV -p 0xPPPP -d winusb -i -f
rem
rem  Usage: put this script and driver_installer.exe in the SAME
rem  folder, then double-click this script. Administrator rights
rem  are required (UAC prompt will appear).
rem ==============================================================

rem --- self-elevate to administrator ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator rights, please confirm the UAC prompt...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

if not exist "driver_installer.exe" (
    echo.
    echo [ERROR] driver_installer.exe was not found next to this script.
    echo         Please download BOTH files from the web page into the
    echo         SAME folder, then run this script again.
    echo.
    pause
    exit /b 1
)

echo.
echo Installing WinUSB driver, device will show as "UB32 Bootloader" ...
echo USB IDs are listed in drivers.txt, including 2E3C:DF11 ...
echo.

driver_installer.exe --all --force "%~dp0drivers.txt"

echo.
echo ==============================================================
echo Done. If installation succeeded, go back to the web page and
echo click "Retry Upgrade".
echo Tip: if it still fails, replug the keyboard or re-enter DFU
echo mode, then retry.
echo ==============================================================
pause
