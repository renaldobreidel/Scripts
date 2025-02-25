<#
.DESCRIPTION
    Dit script wordt gebruikt om With-Secure geautomatiseerd te installeren. De volgende variabelen dienen eerst gevuld te worden voordat het script kan werken.

    - $vouchercode_withsecure: Dit is de subscription code. Deze kan opgehaald worden uit de With-Secure portal.
    - $profileID_withsecure: Dit is de profile code van de profile wat gekoppeld gaat worden aan de machine. Deze kan opgehaald worden uit de With-Secure portal.

    Met dit script wordt tevens Windows Defender op de machine uitgeschakeld.
    
.NOTES
    Auteur:             Renaldo Breidel
    Geschreven voor:    Ictivity
    Versie:             0.1         Eerste opzet        31-08-2023
#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


$Folder_withsecure = 'C:\Install\With-Secure'
$URL_withsecure = "https://download.withsecure.com/PSB/latest/ElementsAgentOfflineInstaller.msi"
$Destination_withsecure = "C:\Install\With-Secure\OfflineInstallerCP-PSB1.msi"
$VoucherCode_withsecure = ""
$ProfileID_withsecure = ""


Write-Verbose -Message "Bezig met de installatie van With-Secure" -Verbose

$InstallArguments = '/i ' + '"' + $Destination_withsecure + '"' + ' /qn ' + 'VOUCHER=' + $VoucherCode_withsecure + ' ' + 'PROFILE_ID=' + $ProfileID_withsecure + ' ' + 'DISABLE_DEFENDER=1'

if (!(Test-Path $Folder_withsecure -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $Folder_withsecure
}

Start-BitsTransfer -Source $URL_withsecure -Destination $Destination_withsecure
Start-Process "msiexec.exe" -Wait -ArgumentList $InstallArguments

Write-Verbose -Message "Installie is afgerond" -Verbose

Remove-Item $Destination_withsecure
Remove-Item $Folder_withsecure
