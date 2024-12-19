# Get a list of installed applications using the Registry
Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" -Recurse | 
    Select-Object @{Name="DisplayName";Expression={$_.GetValue("DisplayName")}}, 
                 @{Name="Publisher";Expression={$_.GetValue("Publisher")}}, 
                 @{Name="InstallDate";Expression={$_.GetValue("InstallDate")}}, 
                 @{Name="Version";Expression={$_.GetValue("DisplayVersion")}} 

# Find the application in the registry
$app = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | 
    Get-ItemProperty | 
    Where-Object {$_.DisplayName -match "YourApplicationName"}

# Check if UninstallString exists
if ($app.UninstallString) {
    # Execute the UninstallString
    & $app.UninstallString
} else {
    Write-Warning "UninstallString not found for the application."
}
