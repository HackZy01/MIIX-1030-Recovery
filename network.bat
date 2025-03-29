@echo off
REM Script to download and unpack CAB drivers for Lenovo MIIX 3-1030 (Type 80HV) into same directory.

REM Check if expand.exe exists
where /Q expand.exe
if %errorlevel% neq 0 (
    echo expand.exe not found. Please ensure it is in your PATH.
    echo It is typically located in C:\Windows\System32.
    exit /b 1
)

REM Create the download directory
mkdir -s "RTL8723BS" 2>nul
if %errorlevel% neq 0 (
    echo Failed to create directory miix3-1030-drivers
    exit /b 1
)

REM Set the download directory variable
set DOWNLOAD_DIR="RTL8723BS"

REM Driver download URLs and filenames (from the README)
set WIFI_BT_URL="https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2018/01/7080faf1-49a2-4824-9efe-5bb1e861a6d3_a53ce31521064547847ccbd18243fbed75e79280.cab"
set WIFI_BT_FILENAME="modem.cab"

REM Download the drivers WIFI Driver
echo Downloading %WIFI_BT_FILENAME% from %WIFI_BT_URL%...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%WIFI_BT_URL%', '%DOWNLOAD_DIR%/%WIFI_BT_FILENAME%')"
if %errorlevel% neq 0 (
    echo Failed to download %WIFI_BT_FILENAME%
    exit /b %errorlevel%
)

REM Unpack cab file to same directory
echo Unpacking %WIFI_BT_FILENAME% to %DOWNLOAD_DIR%...
expand "%DOWNLOAD_DIR%/%WIFI_BT_FILENAME%" -F:* "%DOWNLOAD_DIR%"
if %errorlevel% neq 0 (
    echo Failed to unpack %WIFI_BT_FILENAME%
    exit /b %errorlevel%
)

echo.
echo Downloaded and Unpacked successfully.

echo.
echo Drivers has been downloaded and unpacked to: %DOWNLOAD_DIR%

REM Pause to see the results
pause
