source ./sizer_os.tcl
set design  "pci_bridge32_fast"
set lib_path ". ./lib_contest"
set lib_file_list []
lappend lib_file_list ./lib_contest/contest_hvt.lib
set lib_list [list * contest]
set verilog_input ./pci_bridge32_fast.v
set sdc ./pci_bridge32_fast.sdc
OSLoadDesign
