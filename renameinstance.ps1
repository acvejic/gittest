﻿
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# This Script Renames the instance to AWSAD01 and Also it schedule Job for another script to promote it to domain controller

# Rename the computer
Rename-Computer AWSAD01

# Sets a Registery Key & also execute the Script to promote to domain controller.
 
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -NoExit -executionPolicy Unrestricted -File ' + "C:\DeployAD.ps1" )

# Allows the Instance to save above registery 
Start-Sleep -Seconds 10

# Restarts the computer 
Restart-Computer
