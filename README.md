# Eventlog

PowerShell scripts to collect and report Windows and SharePoint Server event logs across a SharePoint farm.

## Scripts

### Get_SPServer_Eventlogs.ps1

Collects the Application event log from all active SharePoint farm servers (excluding `Invalid` role servers) and generates a color-coded HTML report highlighting Errors (red) and Warnings (yellow).

**Prerequisites:**
- Must be run on a SharePoint Server machine with the SharePoint PowerShell snap-in (`Microsoft.SharePoint.Powershell`)
- Farm Administrator permissions

**Output:** `D:\Scripts\SharePointEventlog.htm` (created automatically if the directory does not exist)

**Usage:**
```powershell
.\Get_SPServer_Eventlogs.ps1
```

---

### Get_All_logs

Collects all Windows event logs (across all log names) from SharePoint farm servers within a specified time window and exports them to a text file.

**Prerequisites:**
- Must be run on a SharePoint Server machine with the SharePoint PowerShell snap-in
- Remote event log access permissions on all farm servers

**Configuration (edit before running):**
- `$StartTimestamp` / `$EndTimeStamp` — date/time range to query
- `$SkipEventLog` — comma-delimited list of event logs to exclude (e.g., `Microsoft-Windows-TaskScheduler/Operational`)
- `$OutputFilePath` — output file path (default: `C:\eventlogs.txt`)

**Usage:**
```powershell
# Edit the variables at the top of Get_All_logs, then run:
.\Get_All_logs
```

---

> **Scope:** These scripts target **SharePoint Server (on-premises)** farms only. They do not apply to SharePoint Online.  
> **Last validated:** 2026-08-17. Verify SharePoint Server PowerShell snap-in availability for your server version in [SharePoint Server documentation](https://learn.microsoft.com/en-us/sharepoint/administration/administration).
