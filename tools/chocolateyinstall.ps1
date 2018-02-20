$ErrorActionPreference = 'Stop'; # stop on all errors


$packageName= 'STS-Bundle' # arbitrary name for the package, used in messages
$packageVersion = '3.9.2'
$eclipseMajorMinorVersion = 'e4.7'
$eclipseFixVersion='.2'
$PTCVersion='3.2.8'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "http://download.springsource.com/release/STS/$packageVersion.RELEASE/dist/$eclipseMajorMinorVersion/spring-tool-suite-$packageVersion.RELEASE-$eclipseMajorMinorVersion$eclipseFixVersion-win32.zip"
$url64      = "http://download.springsource.com/release/STS/$packageVersion.RELEASE/dist/$eclipseMajorMinorVersion/spring-tool-suite-$packageVersion.RELEASE-$eclipseMajorMinorVersion$eclipseFixVersion-win32-x86_64.zip"

$global:installLocation = "C:\tools\sts\v$packageVersion"

$checksum64     = "3C2DD5EF05551C5FAE550E6A32E270F4864C3883"

Write-Host "$toolsDir"
Write-Host "$(Split-Path -Leaf $url64)"

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\UtilFunctions.ps1"

#Parse-Parameters
Install-ZipPackage $packageName $url64 $global:installLocation $url64 -specificFolder "sts-bundle\sts-$packageVersion.RELEASE\*" -checksum64 "$checksum64" -checksumType64 "sha1"
$finalLocationSTS = $(Join-Path $global:installLocation "sts-bundle\sts-$packageVersion.RELEASE")
WriteInstalledFiles $global:installLocation


$stsExecutable = $(Join-Path $finalLocationSTS "STS.exe")
Install-ChocolateyDesktopLink "$stsExecutable"
