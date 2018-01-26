$date = Get-Date
$driveLetter = Read-Host -Prompt 'Enter Drive Letter of external followed by colon(Ex. D: for D Drive)'
$User = $env:USERNAME
$userComputerName = $env:USERNAME
mkdir $driveLetter\$User
mkdir $driveLetter\$User\Apps
mkdir $driveLetter\$User\Downloads
mkdir $driveLetter\$User\Desktop
mkdir $driveLetter\$User\Favs
mkdir $driveLetter\$User\NetworkLocations
mkdir $driveLetter\$User\PSTs
mkdir $driveLetter\$User\SysCerts
mkdir $driveLetter\$User\Printers
$dataTransferProceed = Read-Host -Prompt 'Do you want to transfer files?(Y/N)'
If ($dataTransferProceed -eq 'Y' -or $dataTransferProceed -eq ''){
Write-Host "Stopping Skype and Outlook Processes`n.....................................`n....................................."

Stop-Process -processname lync
Stop-Process -processname outlook
Write-Host 'Starting transfer'
Write-Host '.....................................'
Copy-Item -Path C:\Apps\* -Destination $driveLetter\$User\Apps -recurse

Copy-Item -Path C:\Users\$userComputerName\Downloads\* -Destination $driveLetter\$User\Downloads -recurse

$defaultPrinter = Get-WmiObject win32_printer | %{if ($_.default) {$_}}
$allPrinters = Get-WMIObject -Class Win32_Printer
"Default Printer $defaultPrinter ******** All Printers $allPrinters" | Out-File $driveLetter\$User\Printers\Printers.txt

Write-Host "Transfer is Complete........... `n.......Now restarting Skype and Outlook Processes"
Start-Process -FilePath lync.exe
Start-Process -FilePath outlook.exe
}
If ($dataTransferProceed -eq 'N'){
Write-Host 'Data Transfer Cancelled'
}