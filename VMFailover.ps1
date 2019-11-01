##############################################
# Automated VM Failover script by Vincent W. #
#                                            #
# To use: Configure quoted strings for your  #
# network and run on your HyperV server with #
# Administrator privileges.                  #
#                                            #
# Note: VMs must be running at all times.    #
#                                            #
# Add or remove systems at #System comments  #
# Don't forget to add or remove $count for   #
# system just below this comment box.        #
##############################################
$count1 = 0
$count2 = 0
$count3 = 0
$count4 = 0
function Get-Heartbeat {
 
    process {
        #System1
        if ([bool](Test-Connection -ComputerName "192.168.1.1" -Count 1 -ErrorAction SilentlyContinue)) { #Ensures VM Host is connected to main network.
            if ([bool](Test-Connection -ComputerName "192.168.1.1" -Source "SERVER" -Count 1 -ErrorAction SilentlyContinue)) { #Checks if physical system is connected to main network.
                Disconnect-VMNetworkAdapter "SCCM-VM" #If physical system is online -> disconnect VM from network.
                $sys1 = "System Online."
                $global:count1 = 0
            }
            else { 
                $global:count1 += 1
                $sys1 = "Retry $count1"
                if ($count1 -gt 3) {
                    Connect-VMNetworkAdapter -VMName "SCCM-VM" -SwitchName "VNet" #Connects VM to vitrual switch. -> Settings > Network Adapter > Virtual Switch
                    $sys1 = "Failover Online."
                }
            }
        }
        else {
            $sys1 = "NO NETWORK" #if VM Host is disconnected from network -> do nothing and present error.
        }

        #System2
        if ([bool](Test-Connection -ComputerName "192.168.1.1" -Count 1 -ErrorAction SilentlyContinue)) {
            if ([bool](Test-Connection -ComputerName "192.168.1.1" -Source "SERVER" -Count 1 -ErrorAction SilentlyContinue)) {
                Disconnect-VMNetworkAdapter "SCCM-VM"
                $sys2 = "System Online."
                $global:count2 = 0
            }
            else { 
                $global:count2 += 1
                $sys2 = "Retry $count2"
                if ($count2 -gt 3) {
                    Connect-VMNetworkAdapter -VMName "SCCM-VM" -SwitchName "VNet"
                    $sys2 = "Failover Online."
                }
            }
        }
        else {
            $sys2 = "NO NETWORK"
        }

        #System3
        if ([bool](Test-Connection -ComputerName "192.168.1.1" -Count 1 -ErrorAction SilentlyContinue)) {
            if ([bool](Test-Connection -ComputerName "192.168.1.1" -Source "SERVER" -Count 1 -ErrorAction SilentlyContinue)) {
                Disconnect-VMNetworkAdapter "SCCM-VM"
                $sys3 = "System Online."
                $global:count3 = 0
            }
            else { 
                $global:count3 += 1
                $sys3 = "Retry $count3"
                if ($count3 -gt 3) {
                    Connect-VMNetworkAdapter -VMName "SCCM-VM" -SwitchName "VNet"
                    $sys3 = "Failover Online."
                }
            }
        }
        else {
            $sys3 = "NO NETWORK"
        }

        #System4
        if ([bool](Test-Connection -ComputerName "192.168.1.1" -Count 1 -ErrorAction SilentlyContinue)) {
            if ([bool](Test-Connection -ComputerName "192.168.1.1" -Source "SERVER" -Count 1 -ErrorAction SilentlyContinue)) {
                Disconnect-VMNetworkAdapter "SCCM-VM"
                $sys4 = "System Online."
                $global:count4 = 0
            }
            else { 
                $global:count4 += 1
                $sys4 = "Retry $count4"
                if ($count4 -gt 3) {
                    Connect-VMNetworkAdapter -VMName "SCCM-VM" -SwitchName "VNet"
                    $sys4 = "Failover Online."
                }
            }
        }
        else {
            $sys4 = "NO NETWORK"
        }

        #Color Text
        if ( ($sys1 -eq "System Online.") -and ($sys2 -eq "System Online.") -and ($sys3 -eq "System Online.") -and ($sys4 -eq "System Online.")) {
            $Host.UI.RawUI.ForegroundColor = 'Green'
        }
        else {
            if ( ($sys1 -eq "Failover Online.") -or ($sys2 -eq "Failover Online.") -or ($sys3 -eq "Failover Online.") -or ($sys4 -eq "Failover Online.")) {
                $Host.UI.RawUI.ForegroundColor = 'Yellow'
            }
            else {
                $Host.UI.RawUI.ForegroundColor = 'Red'
            }
        }

        #Organize
        #new-object psobject -prop  @{ # Work on PowerShell V2 and below
        [pscustomobject] [ordered] @{ # Only if on PowerShell V3
            '-   System 1   -' = $sys1
            '-   System 2   -' = $sys2
            '-   System 3   -' = $sys3
            '-   System 4   -' = $sys4
        }
    }
}

while ($true) {
    Get-Random #Generate a random number to keep the terminal from appearing frozen.
    Get-Heartbeat | ft -AutoSize
    start-sleep -s 3
}
