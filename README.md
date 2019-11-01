# Automated-Physical-to-VM-Failover

This script will monitor physical system connection to your network. If the physical system has no connection after 3 attempts to connect, the script will momentarily enable network connection for the VM to take over on your network. The script will continue attempting to connect to your physical system on each cycle. Once a connection to your physical system is established, the script will disable the network connection to the VM and continue monitoring the physical system.

>To use:
>- Set up VM clones of your physical systems.
>- Configure the strings in quoted parts of script to match your infrastructure.
>- Spin up your VMs and keep them running. (This is important)
>- Run this script on your HyperV Server as Administrator.

>Notes:
>- VMs need to be left running for the failover to be effective.
>- Once script starts and establishes connection to physical system the VM counterpart's network will be disabled.
>- The disabled network for the VM happens at HyperV's level and not inside the virtual container.
