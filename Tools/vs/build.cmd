@echo off
rem Building Nuget bebop-tools Nuget package

set version=%1

cd %~dp0

SETLOCAL
SET CACHED_NUGET=%LocalAppData%\NuGet\NuGet.exe

IF EXIST %CACHED_NUGET% goto copynuget
echo Downloading latest version of NuGet.exe...
IF NOT EXIST %LocalAppData%\NuGet md %LocalAppData%\NuGet
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile '%CACHED_NUGET%'"

:copynuget
IF EXIST .nuget\NuGet.exe goto run
md .nuget
copy %CACHED_NUGET% .nuget\NuGet.exe > nul
.nuget\NuGet.exe Update -Self

:run
.nuget\NuGet.exe Pack bebop-tools.nuspec -OutputDirectory packages -Version %version%