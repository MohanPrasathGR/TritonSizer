source sizer_os.tcl
source os.pci_bridge32_fast0.tcl
set svcPort 7474
proc doService {sock msg} {
    puts "got command $msg on osserver"
    puts $sock [eval "$msg"]
    flush $sock
}
proc  svcHandler {sock} {
  set l [gets $sock]
  if {[eof $sock]} {
     close $sock 
  } else {
    doService $sock $l
  }
}
proc accept {sock addr port} {
  fileevent $sock readable [list svcHandler $sock]
  fconfigure $sock -buffering line -blocking 0
  puts $sock "$addr:$port, You are connected to the os server."
  puts $sock "It is now [exec date]"
}
set hostname [info hostname]
set outFp [open hostname-${svcPort}.tmp "w"]
puts $outFp $hostname
close $outFp
catch { socket -server accept $svcPort } test
set outFp [open socket-${svcPort}.tmp "w"]
puts $outFp $test
close $outFp
if { [regexp {couldn't} $test] || [regexp {^Error} $test] } {
    [exit]
}
vwait events
