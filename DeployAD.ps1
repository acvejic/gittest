﻿###########################################################
# AUTHOR  : seve kodra
# DATE    : 25-02-2015 
# COMMENT : This script install Active Directory role
# VERSION : 1.0
###########################################################
# ERROR REPORTING ALL
Rename-Computer AWSAD11 -restart
Set-StrictMode -Version latest
#Import PowerShell Module 
Try
{
Import-Module -Name ServerManager 
}
Catch
{
    Write-Host "[ERROR] Module couldn't be loaded. Script will stop!"
    Exit 1
}
#Install Windows Backup and SNMP Features
try
{
Install-WindowsFeature SNMP-Service, SNMP-WMI-Provider, Windows-Server-Backup -Verbose -Confirm
}
Catch
{
    Write-Host "[ERROR] Couldn't be install feature. Script will stop!"
}
#Input Domain Name
$dcname = Read-Host "Digital.travelex.net"
#Install AD-DS role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose
#Create forest and install ad dc,dns
Install-ADDSForest -domainname $dcname -DomainMode Win2012R2 -ForestMode Win2012R2 -NoRebootOnCompletion:$false -Confirm -Verbose