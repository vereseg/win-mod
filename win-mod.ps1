#remove apps used for connection with other devices
Get-AppxPackage MicrosoftWindows.CrossDevice | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
