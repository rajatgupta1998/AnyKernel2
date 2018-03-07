# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=LoonyKernel-v4
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=athene
device.name2=athene_f
} # end properties

# shell variables
block=/dev/block/platform/soc.0/7824900.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes
patch_fstab fstab.qcom none swap flags "zramsize=1073741824,max_comp_streams=4" "zramsize=536870912,max_comp_streams=4";
insert_line init.qcom.rc "init.qcom.power.rc" before "import init.mmi.usb.rc" "import init.qcom.power.rc";
insert_line init.rc "init.lk.rc" after "import /init.usb.rc" "import /init.lk.rc";

# end ramdisk changes

write_boot;

## end install

