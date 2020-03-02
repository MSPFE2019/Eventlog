Add-PsSnapin Microsoft.SharePoint.Powershell –ErrorAction SilentlyContinue

CLS

$serverlist = Get-SPServer | where {$_.Role -ne "Invalid"} 

$resultsdirexist = Test-Path "D:\Scripts" 
$resultsdirparent = "D:\Scripts" 
$testpath = $resultsdirparent
$resultsdirexist = Test-Path $testpath

if ($resultsdirexist -ne "True")
{
Write-Host "Directory Does not exist."
Write-Host "Creating...."
Set-Location $resultsdirparent
New-Item -path $resultsdirparent -Name EventLog -type directory
Write-Host $testpath " has been created"
Write-Host "This is where all output from the files will be stored"
}


$report = $testpath + "\" + "SharePointEventlog" + ".htm"
Clear-Content $report

[array]$eventlogs = $null
$eventlogs += "Application"
$countarr = $eventlogs.count



Foreach ($s in $serverlist.name)
{
$progress = "."

 Add-Content $report "<html>"
Add-Content $report "<head>"
Add-Content $report "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>"
Add-Content $report '<title>Event Log Report for Server $s</title>'
add-content $report '<STYLE TYPE="text/css">'
add-content $report "<!--"
add-content $report "td {"
add-content $report "font-family: Tahoma;"
add-content $report "font-size: 11px;"
add-content $report "border-top: 1px solid #999999;"
add-content $report "border-right: 1px solid #999999;"
add-content $report "border-bottom: 1px solid #999999;"
add-content $report "border-left: 1px solid #999999;"
add-content $report "padding-top: 0px;"
add-content $report "padding-right: 0px;"
add-content $report "padding-bottom: 0px;"
add-content $report "padding-left: 0px;"
add-content $report "}"
add-content $report "body {"
add-content $report "margin-left: 5px;"
add-content $report "margin-top: 5px;"
add-content $report "margin-right: 0px;"
add-content $report "margin-bottom: 10px;"
add-content $report ""
add-content $report "table {"
add-content $report "border: thin solid #000000;"
add-content $report "}"
add-content $report "-->"
add-content $report "</style>"
Add-Content $report "</head>"
Add-Content $report "<body>"
add-content $report "<table width='100%'>"
add-content $report "<tr bgcolor='#CCCCCC'>"
add-content $report "<td colspan='7' height='25' align='center'>"
add-content $report "<font face='tahoma' color='#003399' size='4'><strong>Event Logs Collection From Server $s</strong></font>"
add-content $report "</td>"
add-content $report "</tr>"
add-content $report "</table>"

add-content $report "<table width='100%'>"
Add-Content $report "<tr bgcolor=#CCCCCC>"
Add-Content $report "<td width='20%' align='center'>Index</td>"
Add-Content $report "<td width='20%' align='center'>Time</td>"
Add-Content $report "<td width='20%' align='center'>EntryType</td>"
Add-Content $report "<td width='20%' align='center'>Source</td>"
Add-Content $report "<td width='20%' align='center'>InstanceID</td>"
Add-Content $report "<td width='20%' align='center'>Message</td>"
Add-Content $report "</tr>"

For ($count = 0; $count -lt $countarr;$count++)
{
  
  write-host "`n`nCollection Event Logs" $eventlogs[$count] "from Computer $s" -foregroundcolor yellow -backgroundcolor black
  $logs = get-eventlog -logname $eventlogs[$count] -computername $s -newest 200
  Write-host "Processing" -foregroundcolor yellow -backgroundcolor black



  Foreach ($l in $logs)
  {
  write-host $progress -nonewline -Foregroundcolor Green -backgroundcolor Black
  $index = $l.index
  $time = $l.timegenerated
  $Entrytype = $l.entrytype
  $Source = $l.source
  $InstanceID = $l.instanceID
  $Message = $l.message

  if ($entrytype -eq "Error")
  {
  
  Add-Content $report "<tr>"
  Add-Content $report "<td bgcolor='#FF5050'>$index</td>"
  Add-Content $report "<td bgcolor='#FF5050' align=center>$time</td>"
  Add-Content $report "<td bgcolor='#FF5050' align=center>$entrytype</td>"
  Add-Content $report "<td bgcolor='#FF5050' align=center>$source</td>"
  Add-Content $report "<td bgcolor='#FF5050' align=center>$InstanceID</td>"
  Add-Content $report "<td bgcolor='#FF5050' align=center>$Message</td>"
  Add-Content $report "</tr>"
  }
  
  if ($entrytype -eq "Warning")
  {
  
  Add-Content $report "<tr>"
  Add-Content $report "<td bgcolor='#FFFF00'>$index</td>"
  Add-Content $report "<td bgcolor='#FFFF00' align=center>$time</td>"
  Add-Content $report "<td bgcolor='#FFFF00' align=center>$entrytype</td>"
  Add-Content $report "<td bgcolor='#FFFF00' align=center>$source</td>"
  Add-Content $report "<td bgcolor='#FFFF00' align=center>$InstanceID</td>"
  Add-Content $report "<td bgcolor='#FFFF00' align=center>$Message</td>"
  Add-Content $report "</tr>"
  }
  
#  if ($entrytype -eq "Information")
#  {
#  Add-Content $report "<tr>"
#  Add-Content $report "<td>$index</td>"
#  Add-Content $report "<td>$time</td>"
#  Add-Content $report "<td>$entrytype</td>"
#  Add-Content $report "<td>$source</td>"
#  Add-Content $report "<td>$InstanceID</td>"
#  Add-Content $report "<td>$Message</td>"
#  Add-Content $report "</tr>"
#  }
  $progess++
  }
Add-content $report "</table>"
Add-Content $report "</body>"
Add-Content $report "</html>"
}
}

