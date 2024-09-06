
Write-Host "`n`t`t`thttps://github.com/sasa00elsaedy/`n" -ForegroundColor Yellow


$dirName = Read-Host -Prompt "Enter the directory name"

New-Item -Path $dirName -ItemType Directory
#   networks
mkdir .\$dirName\networks
(Get-NetTCPConnection | Out-String)  >   .\$dirName\networks\TCPConnections.txt
(Get-NetUDPEndpoint | Out-String) > .\$dirName\networks\UDPConnections.txt
(NETSTAT.EXE -anob | Out-String) > .\$dirName\networks\netstat.txt
(ARP.EXE -a | Out-String) > .\$dirName\networks\arp-table.txt
(ipconfig.exe /displaydns | Out-String)  > .\$dirName\networks\dnsCache.txt
(net.exe share | Out-String) > .\$dirName\networks\share_files.txt

#   users and shared folders
mkdir .\$dirName\"users and shared folders"
(query.exe  user | Out-String) > .\$dirName\"users and shared folders"\logged_in_users.txt
(net.exe user | Out-String) > .\$dirName\"users and shared folders"\all_users.txt
(net.exe session | Out-String) > .\$dirName\"users and shared folders"\sessions.txt 

#   system info
mkdir .\$dirName\"system info"
(systeminfo | Out-String) > .\$dirName\"system info"\systemData.txt
(Get-ChildItem Env: | Out-String) > .\$dirName\"system info"\sets.txt

#   logs
mkdir .\$dirName\logs
mkdir .\$dirName\logs\"scurity logs"
(wevtutil.exe qe Application /f:text | Out-String) > .\$dirName\logs\application_logs.txt
(wevtutil.exe qe System /f:text | Out-String) > .\$dirName\logs\system_logs.txt
(wevtutil.exe qe Security "/q:*[System[(EventID=4624 or EventID=4625)]]" /f:text | Out-String) > .\$dirName\logs\"scurity logs"\security_logs.txt
(Defender\Get-MpThreat | Out-String) > .\$dirName\logs\"scurity logs"\nowThreat.txt

#   tasks
mkdir .\$dirName\tasks
(net.exe start | Out-String) > .\$dirName\tasks\services.txt
(schtasks.exe /query /fo LIST /v  | Out-String) > .\$dirName\tasks\scheduled_tasks.txt
(tasklist.exe /V | Out-String) > .\$dirName\tasks\nowTasks.txt

#   programs
mkdir .\$dirName\programs
(WMIC.exe product get name,version | Out-String) > .\$dirName\programs\installed_programs.txt
(reg.exe query HKLM\Software\Microsoft\Windows\CurrentVersion\Run | Out-String) > .\$dirName\programs\autorun_programs.txt
