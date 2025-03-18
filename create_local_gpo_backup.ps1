<#
.DESCRIPTION
1. Set Variables:
    Defines the URL to download LGPO.zip, the path to save the downloaded file, and the destination path to extract the files.
2. Create Folders:
    Creates directories c:\temp\Lgpo and c:\temp\Lgpo\Backup if they don't already exist.
3. Download LGPO:
    Downloads the LGPO.zip file from the specified URL and saves it to C:\temp\LGPO.zip.
4. Unzip the File:
    Extracts the contents of the downloaded LGPO.zip file to the C:\temp\Lgpo directory.
5. Make the Backup with LGPO:
    Changes the directory to C:\temp\Lgpo\LGPO_30.
    Runs LGPO.exe to create a backup of the local Group Policy Object (GPO) settings and saves the backup to c:\temp\Lgpo\Backup.
.NOTES
    Author: Renaldo Breidel
    Version: 1.0 // 18-03-2025
#>

#set variables
$sourceUrl = "https://download.microsoft.com/download/8/5/c/85c25433-a1b0-4ffa-9429-7e023e7da8d8/LGPO.zip"
$downloadPath = "C:\temp\LGPO.zip"
$destinationPath = "C:\temp\Lgpo"

#Create folders
New-Item -ItemType Directory "c:\temp\Lgpo"
New-Item -ItemType Directory "c:\temp\Lgpo\Backup"

#Download LGPO from Microsoft
Invoke-WebRequest -Uri $sourceUrl -OutFile $downloadPath

#Unzip the file
Expand-Archive -LiteralPath $downloadPath -DestinationPath $destinationPath

#Make the backup with LGPO
cd C:\temp\Lgpo\LGPO_30
.\lgpo.exe /b c:\temp\Lgpo\Backup