# Get a list of installed applications using the Registry
Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" -Recurse | 
    Select-Object @{Name="DisplayName";Expression={$_.GetValue("DisplayName")}}, 
                 @{Name="Publisher";Expression={$_.GetValue("Publisher")}}, 
                 @{Name="InstallDate";Expression={$_.GetValue("InstallDate")}}, 
                 @{Name="Version";Expression={$_.GetValue("DisplayVersion")}} 
