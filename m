Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <A1F0D47583A2D711919F00600819B3A4028BB8@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] BNEP kernel oops
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 13 Aug 2004 14:52:17 -0400

Greetings Marcel,

Perhaps you can help.

I am developing an application for a single board computer running an =
X-scale processor with a BT dongle in the USB port.=20

I have the following:
Linux 2.4.26, with the patch-2.4.26-mh2.gz patch applied.=20
bluez-libs-2.8
bluez-utils-2.8

I've cross-compiled all this for the X-scale and everything seems to =
work OK for rfcomm connections.=20
However as soon as I try to create a PAN connection to a remote device, =
I get a kernel panic.=20
The remote device is an iPAQ 5550 with built-in BT, running OPIE. The =
iPAQ does not crash.

One thing I tried, was to change the /etc/bluetooth/pan/dev-up script to =
"echo hello" instead of the usual "ifconfig....."=20
This allows pand to complete OK, but doesn't start bnep. All is OK.=20
I can then type the ifconfig bnep0 10.0.0.1 command on the console and  =
this seems to work OK about 50% of the time.
When this does work, I get the kbnep process started OK and I can ping =
between the two devices. The other
50% of the time I get the panic.

Here's a dump of the oops.

Any help is greatly appreciated.

Best Regards,

Rich Williams


----------------------------------------------------------------
Initialize XScale Registers
Reset Detected
XScale ID : 69052d06
DRAM Data Bus Test
DRAM Bank1 Data Bus Test Passed
BANK1 has 64MBytes DRAM
DRAM Address Bus Test Passed!
DRAM Device Test Passed!
  BitsyX Linux Boot ROM (0x04) 4.13 PXA 64M (May 28 2004,12:58:17)
PCMCIA Socket 0 card detected and ready.
FindATADisk() There is NO ATA Drive on PCMCIA Socket 0 (6)
PCMCIA 0 not fixed disk
Ethernet chip is not present
There is no PCMCIA card on Socket 1
Number of partitions: 4
 0:    adslinux.rom,    262144,         0, 0
 1:          zImage,   1572864,    262144, 0
 2:      ramdisk.gz,   5242880,   1835008, 0
 3:        flashfs1,  26476544,   7077888, 0
Setting registers from register.txt:
 [0x48000004] =3D 0x0015b013
Kernel command line is:
   console=3DttyS1,38400 rw ramdisk_size=3D12288 initrd=3D0xA0800000,5m =
root=3D/dev/ram mtdparts=3Dpxa:256k(adslinux.rom),1536k)Memory =
configuration is:
   mem=3D64m@0xa0000000
Jump to 0xa0400000
Uncompressing =
Linux....................................................................=
.... done, booting the kernel.
Linux version 2.4.26-vrs1-adsx1 (rich@richlinux) (gcc version 3.3.2) #8 =
Fri Aug 13 13:24:08 EDT 2004
CPU: XScale-PXA255 revision 6
Machine: ADS BitsyX
Memory clock: 99.53MHz (*27)
Run Mode clock: 398.13MHz (*4)
Turbo Mode clock: 398.13MHz (*1.0, active)
On node 0 totalpages: 16384
zone(0): 256 pages.
zone(1): 16128 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS1,38400 rw ramdisk_size=3D12288 =
initrd=3D0xA0800000,5m root=3D/dev/ram mtdparts=3Dpxa:256k(a)Console: =
colour dummy device 80x30
Calibrating delay loop... 397.31 BogoMIPS
Memory: 64MB =3D 64MB total
Memory: 57248KB available (1945K code, 380K data, 92K init)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Testing write buffer: pass
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision =
1
ADS CPLD REV: 0x7
Probing for CFBUS not found.
Probing for adsbitsyx smc91x not found.
Using PXA255 frequency points.
Registering CPU frequency change support.
CPU clock: 398.131 MHz (99.000-398.100 MHz)
Starting kswapd
Journalled Block Device driver loaded
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis =
Communications AB.
i2c-core.o: i2c core module version 2.6.1 (20010830)
I2C: PXA algorithm module loaded.
I2C: Adding PXA-I2C-Adapter.
I2C: Scanning bus (20)(68)
I2C: Successfully added bus
ttyS0 at I/O 0xf0000400 (irq =3D 0) is a 16450
ttyS1 at I/O 0xf0000410 (irq =3D 0) is a 16450
ttyS2 at I/O 0xf0000420 (irq =3D 0) is a 16450
ttyS3 at I/O 0xf0000430 (irq =3D 0) is a 16450
Console: switching to colour frame buffer device 80x30
ADSmartIO ID     : 0x0010
Firmware Version : 2
Device Type      : 0x8535
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x0000 (irq =3D 15) is a PXA UART
ttyS01 at 0x0000 (irq =3D 14) is a PXA UART
ttyS02 at 0x0000 (irq =3D 13) is a PXA UART
ads784x_ts_init_module: registering char device
smartio driver initialized. version 1.14, date: 26-Mar-2004
I2C: DS1307 RTC driver successfully loaded
RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx
SCSI subsystem driver Revision: 1.00
ac97_codec: AC97 Audio codec, id: CRY115 (Cirrus Logic CS4202)
Probing PXA flash at physical address 0x04000000
cfi_cmdset_0001: Erase suspend on write enabled
Using buffer write method
Using Command Line partition definition
Creating 4 MTD partitions on "PXA flash":
0x00000000-0x00040000 : "adslinux.rom"
0x00040000-0x001c0000 : "zImage"
0x001c0000-0x006c0000 : "ramdisk.gz"
0x006c0000-0x02000000 : "flashfs1"
Linux Kernel Card Services 3.1.22
  options:  [pm]
cs.c 1.279 2001/10/13 00:08:28 (David Hinds)
Intel PXA250/210 PCMCIA (CS release 3.1.22)
cs: register_ss_entry(2, 0xc042101c)
cs: pcmcia_register_socket(0xc042101c)
cs: pcmcia_register_socket(0xc042101c)
pxa_cs: initialization complete
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
hcd/ohci-sa1111.c: ohci-hcd (SA-1111) at 0xf4000400, irq 148
                                                                         =
                                            =20
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 1 port detected
hub.c: no over-current condition exists
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module =
version 8.11 loaded.
pwc Also supports the Askey VC010, various Logitech Quickcams, Samsung =
MPC-C10 and MPC-C30,
pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and =
VCS-UM100.
usb.c: registered new driver Philips webcam
ov511.c: Error: /proc/video/ does not exist
usb.c: registered new driver ov511
ov511.c: v1.65 : ov511 USB Camera Driver
ov511_decomp.c: v1.6 : OV511 Decompression Module
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NetWinder Floating Point Emulator V0.97 (double precision)
port 1, portstatus 101, change 1
cs: bind_device(): client 0xc01cda60, sock 0, dev Driver Services
cs: setup_socket(c059d800): applying power
hub.c: new USB device sa1111-1, assigned address 2
cs: resetting socket c059d800
usb.c: USB device 2 (vend/prod 0xa12/0x1) is not claimed by any active =
driver.
cs: reset done on socket c059d800
cs: send_event(sock 0, event 4, pri 0)
cs: register_client(): client 0xc01cda60, sock 0, dev Driver Services
cs: bind_device(): client 0xc01cde60, sock 1, dev Driver Services
cs: register_client(): client 0xc01cde60, sock 1, dev Driver Services
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 5120K
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 92K
INIT: version 2.74 booting
Ramdisk Version: 2.4.26-vrs1-adsx1
Setting system time from RTC
INIT: Entering runlevel: 3
Starting system logger:  syslogd
Starting modutils Loading modules:

Starting network Setup Network Configuration DHCP enabled with 20 sec =
timeout
dhcpcd: No such file or directory

Starting portmapper:  portmap

$Starting Bluetooth: Using =
/lib/modules/2.4.26-vrs1-adsx1/kernel/net/bluetooth/bluez.o
BlueZ Core ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Using /lib/modules/2.4.26-vrs1-adsx1/kernel/drivers/bluetooth/hci_usb.o
BlueZ HCI USB driver ver 2.7 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
Using /lib/modules/2.4.26-vrs1-adsx1/kernel/net/bluetooth/l2cap.o
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Using =
/lib/modules/2.4.26-vrs1-adsx1/kernel/net/bluetooth/rfcomm/rfcomm.o
BlueZ RFCOMM ver 1.1
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
Using /lib/modules/2.4.26-vrs1-adsx1/kernel/net/bluetooth/bnep/bnep.o
BlueZ BNEP ver 1.2
Copyright (C) 2001,2002 Inventel Systemes
Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
Written 2001,2002 by David Libault <david.libault@inventel.fr>
Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
Starting INET services:  inetd



Linux login: root
                                                                         =
                                            =20
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$tail -f /var/log/messages&
[1] 200
[root@Linux /root]$Jan  3 03:59:09 Linux daemon.info cardmgr[170]: =
executing: 'modprobe orinoco'
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: + insmod: orinoco.o: no =
module by that name found
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: modprobe exited with =
status 1
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: module =
/lib/modules/2.4.26-vrs1-adsx1/pcmcia/orinoco.o not available
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: executing: 'modprobe =
spectrum_cs'
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: + insmod: spectrum_cs.o: =
no module by that name found
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: modprobe exited with =
status 1
Jan  3 03:59:09 Linux daemon.info cardmgr[170]: module =
/lib/modules/2.4.26-vrs1-adsx1/pcmcia/spectrum_cs.o not availae
Jan  3 03:59:10 Linux daemon.info cardmgr[170]: get dev info on socket 0 =
failed: Resource temporarily unavailable
Jan  3 03:59:12 Linux auth.info login[166]: root login  on `ttyS1'
                                                                         =
                                            =20
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$ hcid=20
[root@Linux /root]$ sdpd
[root@Linux /root]$Jan  3 03:59:32 Linux local7.notice bluetooth: hcid =
startup succeeded
Jan  3 03:59:32 Linux daemon.info hcid[219]: Bluetooth HCI daemon
Jan  3 03:59:32 Linux daemon.err hcid[219]: parse error line 64
Jan  3 03:59:32 Linux daemon.err hcid[219]: Can't open PIN file =
/etc/bluetooth/pin. No such file or directory(2)
Jan  3 03:59:32 Linux daemon.info hcid[219]: HCI dev 0 up
Jan  3 03:59:32 Linux daemon.info hcid[219]: Starting security manager 0
Jan  3 03:59:32 Linux daemon.info sdpd[238]: Bluetooth SDP daemon
Jan  3 03:59:32 Linux local7.notice bluetooth: sdpd startup succeeded
                                                                         =
                                            =20
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$
[root@Linux /root]$pand --connect 08:00:17:1D:4B:28
[root@Linux /root]$
Jan  3 03:59:53 Linux daemon.info pand[248]: Bluetooth PAN daemon
Jan  3 03:59:53 Linux daemon.info pand[248]: Connecting to =
08:00:17:1D:4B:28
Unable to handle kernel NULL pointer dereference at virtual address =
00000000
pgd =3D c0204000
[00000000] *pgd=3D00000000, *pmd =3D 00000000
Internal error: Oops: 8f5
CPU: 0
pc : [<c0227398>]    lr : [<000001f1>]    Not tainted
sp : c38fdcc0  ip : c0436280  fp : c38fdce4
r10: 80000093  r9 : 00000020  r8 : 00000000
r7 : c0201220  r6 : 00000004  r5 : c0203fe0  r4 : 00001000
r3 : 00000000  r2 : c081144c  r1 : 00001000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A0804000  DAC: 0000001D
Process kbnepd bnep0 (pid: 250, stack limit =3D 0xc38fc368)
Stack: (0xc38fdcc0 to 0xc38fe000)
dcc0: c0811440 c0203fe0 00000004 c0201220 c0201220 80000093 c38fdd04 =
c38fdce8
dce0: c02c027c c0227374 00000004 c0203fe0 00000001 c0203fe0 c38fdd54 =
c38fdd08
dd00: c02c04a8 c02c023c c38fdd58 c38fdd18 c0265770 c03ccd7c c017f006 =
c38fdd64
dd20: 00000000 c38fddb4 c0527920 c0811420 c0201220 00000024 00000024 =
00000001
dd40: 00000001 c08764a4 c38fdd80 c38fdd58 c022a318 c02c0408 a00fcc00 =
a08764a4
dd60: c08764a4 00000024 80000093 00000001 c08113e0 c38fdda4 c38fdd84 =
c022a4d4
dd80: c022a2a8 c08764a4 c0876534 00000024 00000000 c08113e0 c38fddd8 =
c38fdda8
dda0: c034a4a0 c022a494 c01e8800 c01e8800 c08113e4 c0876534 00000001 =
00000001
ddc0: c08113e0 c88ce0c0 c01e8800 c38fde14 c38fdddc c034af44 c034a3f8 =
00000000
dde0: 00000000 40000013 c0010200 c08764a4 c0876534 00000000 c0876538 =
c01e8cb4
de00: c0909ebc c01cdb60 c38fde3c c38fde18 c0348c18 c034ac9c c0876534 =
c0876520
de20: c01cfe00 c01cff40 60000013 c0436288 c38fde4c c38fde40 c033f47c =
c03488c4
de40: c38fde74 c38fde50 c88dd764 c033f448 c88de2bc c88dd06c c01cff70 =
c0c6c080
de60: c01cfe00 c01cff40 c38fde94 c38fde78 c88dd900 c88dd71c c01cff40 =
c01cfe00
de80: c0414020 00000000 c38fdeac c38fde98 c88ddad0 c88dd83c c0c6c080 =
c01cfe00
dea0: c38fdec4 c38fdeb0 c88d686c c88dd9bc c0a9cdc0 c01cfe00 c38fdeec =
c38fdec8
dec0: c88d6e14 c88d67d4 c08764ac 00000004 c01cfe84 00000000 c0414020 =
00000000
dee0: c38fdf0c c38fdef0 c0233d3c c88d6d6c 00000001 c0414078 fffffff7 =
c0436280
df00: c38fdf30 c38fdf10 c0233af0 c0233cdc c08700a0 c0436280 0000001c =
c0436280
df20: c0892028 c38fdf70 c38fdf34 c0221448 c0233a84 c08700d0 c0414020 =
00000008
df40: 00000008 c0436280 c88e1418 0000001c c0c6c120 c0892000 0000001c =
00000001
df60: c3d8b400 c38fdfbc c38fdf74 c88f12b8 c88e12ec c38f0ea0 0080a000 =
c3d8b41c
df80: 00000000 c0412000 c38fdfbc c022c4d4 c0414000 00000000 c0892000 =
c08700a0
dfa0: c38fc000 c0892064 c0909ebc c38fdfc0 c38fdff4 c38fdfc0 c88f06e4 =
c88f1144
dfc0: 00000000 c38fc000 c38f0ebc c38f0ebc 00000000 c0908000 c0892064 =
c38f0ea0
dfe0: c0909f28 c0909eb4 00000000 c38fdff8 c0222d2c c88f05a8 4010ecec =
4011f98c
Backtrace:
Function entered at [<c0227368>] from [<c02c027c>]
Function entered at [<c02c0230>] from [<c02c04a8>]
 r7 =3D C0203FE0  r6 =3D 00000001  r5 =3D C0203FE0  r4 =3D 00000004
Function entered at [<c02c03fc>] from [<c022a318>]
Function entered at [<c022a29c>] from [<c022a4d4>]
Function entered at [<c022a488>] from [<c034a4a0>]
 r8 =3D C08113E0  r7 =3D 00000000  r6 =3D 00000024  r5 =3D C0876534
 r4 =3D C08764A4
Function entered at [<c034a3ec>] from [<c034af44>]
Function entered at [<c034ac90>] from [<c0348c18>]
Function entered at [<c03488b8>] from [<c033f47c>]
Function entered at [<c033f43c>] from [<c88dd764>]
Function entered at [<c88dd710>] from [<c88dd900>]
 r7 =3D C01CFF40  r6 =3D C01CFE00  r5 =3D C0C6C080  r4 =3D C01CFF70
Function entered at [<c88dd830>] from [<c88ddad0>]
 r7 =3D 00000000  r6 =3D C0414020  r5 =3D C01CFE00  r4 =3D C01CFF40
Function entered at [<c88dd9b0>] from [<c88d686c>]
 r5 =3D C01CFE00  r4 =3D C0C6C080
Function entered at [<c88d67c8>] from [<c88d6e14>]
 r5 =3D C01CFE00  r4 =3D C0A9CDC0
Function entered at [<c88d6d60>] from [<c0233d3c>]
 r7 =3D 00000000  r6 =3D C0414020  r5 =3D 00000000  r4 =3D C01CFE84
Function entered at [<c0233cd0>] from [<c0233af0>]
 r7 =3D C0436280  r6 =3D FFFFFFF7  r5 =3D C0414078  r4 =3D 00000001
Function entered at [<c0233a78>] from [<c0221448>]
 r8 =3D C0892028  r7 =3D C0436280  r6 =3D 0000001C  r5 =3D C0436280
 r4 =3D C08700A0
Function entered at [<c88e12e0>] from [<c88f12b8>]
Function entered at [<c88f1138>] from [<c88f06e4>]
Function entered at [<c88f059c>] from [<c0222d2c>]
Code: e1a08003 e3500000 e1a04001 13a03000 (15833000)
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing











Richard B. Williams
Vitronics, Inc.
An MTC Technologies Company
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@vitronics.com



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
