$exes = Get-ChildItem -recurse "C:\games\*.exe" |select name,fullname

Write-Host "[*] This will block outbound connections to all the following executables:"
foreach ($exe in $exes) {
    Write-Host "  -" $exe.fullname
}

$confirmation = Read-Host "[?] Are you sure? (type 'yes, please' to confirm, anything else to cancel)"
if ($confirmation -eq 'yes, please') {
    foreach ($exe in $exes) {
        Write-Host "[-] Blocking outbound connections for: " $exe.name
        New-NetFirewallRule -Direction Outbound -Program $exe.fullname -Action Block -Profile Any -DisplayName $("Block " + $exe.name) -Description $("Block " + $exe.name) | out-null
    }
    Write-Host "[+] Finished."
}
