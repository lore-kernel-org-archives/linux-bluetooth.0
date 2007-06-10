Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 10 Jun 2007 14:21:44 +0800 (CST)
From: =?GBK?B?t8nM7Nbt?= <wjs-198209@163.com>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
Message-ID: <10227247.9077211181456505247.JavaMail.coremail@bj163app59.163.com>
MIME-Version: 1.0
Subject: [Bluez-devel] Can't find the device in arm machine.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1138247423=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1138247423==
Content-Type: multipart/Alternative;
	boundary="----=_Part_973812_21147067.1181456505243"

------=_Part_973812_21147067.1181456505243
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable


Hello!I have compiled bluez-libs-3.11 and bluez-utils-3.11 in scratchbox fo=
r arm successfully. Then I put the library files in /usr/lib and utilities =
in /usr/bin as well .And I compressed the new target system to a scram form=
at file and downloaded the file in my machine which uses s3c2440 as its cor=
e and uses linux 2.6.12 kernel..But when I plugged my usb dongle which is p=
roduced by Integrated System Solution Corporation with HCI 1.1 version, and=
 the following error messages appeared in my DNW windows which is produced =
by SANSUM as a console.
[root@(none) /]# usb 1-1: new full speed USB device using s3c2410-ohci and =
address 6
usb 1-1: unable to read config index 0 descriptor/start
usb 1-1: can't read configurations, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 7
usb 1-1: unable to read config index 0 descriptor/start
usb 1-1: can't read configurations, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 8
usb 1-1: device descriptor read/all, error -110
usb 1-1: new full speed USB device using s3c2410-ohci and address 9
usb 1-1: unable to read config index 0 descriptor/start
usb 1-1: can't read configurations, error =A8C110
Then when I entered all the Bluetooth utilities commands such as hcitool , =
the error message emerged and they couldn=A1=AFt work at all.
[root@(none) /]# hcitool scan
Reading data from NAND FLASH without ECC is not recommended
Device is not available: No such device
Shall I have to enble some usb options in kernel configuration when compile=
 kernel? But I have enabled two usb controller option and usb siereis conve=
rter option. Is bluetooth usb driver independent on usb options? If not whi=
ch options should I enable at least? Can anyone help me to figure out the p=
roblem?=20
The booting message appeared in my console window is in the following.
CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
Machine: SMDK2410
ATAG_INITRD is deprecated; please update your bootloader.
Memory policy: ECC disabled, Data cache writeback
CPU S3C2440A (id 0x32440001)
S3C2440: core 400.000 MHz, memory 100.000 MHz, peripheral 50.000 MHz
S3C2410 Clocks, (c) 2004 Simtec Electronics
USB Control, (c) 2006 ucdragon yl2440.new
Built 1 zonelists
Kernel command line: root=3D/dev/mtdblock2 init=3D/linuxrc load_ramdisk=3D0=
 console=3DttySAC1,115200 mem=3D65536K devfs=3Dmount shp240
irq: clearing pending ext status 00007200
irq: clearing subpending status 00000092
PID hash table entries: 512 (order: 9, 8192 bytes)
timer tcon=3D00590000, tcnt a2c1, tcfg 00000200,00000000, usec 00001eb8
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
=20
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB =3D 64MB total
Memory: 61440KB available (2712K code, 498K data, 160K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
S3C2440: Initialising architecture
S3C2440: IRQ Support
S3C2440: Clock Support, UPLL 96.000 MHz
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
S3C2410 DMA Driver, (c) 2003-2004 Simtec Electronics
DMA channel 0 at c4800000, irq 33
DMA channel 1 at c4800040, irq 34
DMA channel 2 at c4800080, irq 35
DMA channel 3 at c48000c0, irq 36
NetWinder Floating Point Emulator V0.97 (double precision)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.22 [Flags: R/W].
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
yaffs Jun 6 2007 20:36:18 Installing.
Initializing Cryptographic API
--- s3c2410fb init ---!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
pxafb_probe start!!!!!!!!!!!!!!!!!!!!!!!!!!
s3c2410-lcd s3c2410-lcd: Invalid resolution or bit depth
s3c2410-lcd: probe of s3c2410-lcd failed with error -22
Console: switching to colour frame buffer device 80x25
fb0: Virtual frame buffer device, using 1024K of video memory
in s3c2410ts init()
success get major number!!!!!!
s3c2410-ts device driver MAJOR:253
success to get adc clock source!
base_addr =3D 0xc4962000
line 535 passed!
register s3c2410-ts driver success, return code is 0
S3C2410 RTC, (c) 2004 Simtec Electronics
initialize ST16C550 on yl-2410 board, iobase =3D 0xd4000000
=20
Serial: 8250/16550 driver $Revision: 1.90 $ ,hace done serial8250_io_init!!=
!!5 ports, IRQ sharing disabled
have enter serial8250_isa_init_ports!iobase =3D 0xc4980000
line 2166 passed
line 2168 passed
before uart_configure_port!
line 1958 passed
line 1960 passed
IN!!line 1965 passed
enter uart_report_port() line 1918 passed
ttsA0 at I/O 0xc4980000 (irq =3D 57) is a 16550A
line 1967 passed
line 1974 passed
line 1976 passed
line 1984 passed
after uart_configure_port!
line 2196 passed
line 2198 passed
line 2166 passed
line 2168 passed
before uart_configure_port!
line 1958 passed
line 1960 passed
IN!!line 1965 passed
enter uart_report_port() line 1918 passed
s3c2410_serial0 at MMIO 0x50000000 (irq =3D 70) is a S3C2440
line 1967 passed
line 1974 passed
line 1976 passed
line 1984 passed
after uart_configure_port!
line 2196 passed
line 2198 passed
line 2166 passed
line 2168 passed
before uart_configure_port!
line 1958 passed
line 1960 passed
IN!!line 1965 passed
enter uart_report_port() line 1918 passed
s3c2410_serial1 at MMIO 0x50004000 (irq =3D 73) is a S3C2440
line 1967 passed
line 1974 passed
=20
line 1976 passed
after uart_configure_port!
line 2196 passed
line 2198 passed
line 2166 passed
line 2168 passed
before uart_configure_port!
line 1958 passed
line 1960 passed
IN!!line 1965 passed
enter uart_report_port() line 1918 passed
s3c2410_serial2 at MMIO 0x50008000 (irq =3D 76) is a S3C2440
line 1967 passed
line 1974 passed
line 1976 passed
line 1984 passed
after uart_configure_port!
line 2196 passed
line 2198 passed
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
ub: sizeof ub_scsi_cmd 68 ub_dev 2384 ub_lun 140
usbcore: registered new driver ub
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Cirrus Logic CS8900A driver for Linux (V0.02)
dev->base_addr=3D0xe0000300<3>line 689 passed,request_region() OK!success g=
et IO port address!
eth0: CS8900A rev E detected
BWSCON=3D2211d110
GPFCON=3D1a6aaaa
EXTINT0=3D22122242
INTMSK=3D6f7f3d9f
BWSCON=3D221dd110
GPFCON=3D1a6aaaa
EXTINT0=3D21122242
=20
INTMSK=3D6f7f3d9f
DM9000 ethernet driver V1.26 I/O: c4974300, VID: 90000a46
 success to exe register_netdev.in another word err >0,
 the last edition,new MAC address!!
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=3D=
xx
 SET CF & IDE WAIT!now BWSCON=3D225dd510
now begin cf_ide_init_default_hwifs()
have initialized interrupt for cf:EINT3
fla2612:INTMSK=3D6f7f3d95
GPFCON=3D000055aa
EXTINT0=3D00004040
GPBCON=3D00100154
GPBDAT=3D000007e2
-1:no 0:ok CF_register_hw return -1
-1:no 0:ok ide_register_hw return -1
S3C24XX NAND Driver, (c) 2004 Simtec Electronics
s3c2410-nand: mapped registers at c4b00000
s3c2410-nand: timing: Tacls 10ns, Twrph0 40ns, Twrph1 10ns
NAND device: Manufacturer ID: 0xec, Chip ID: 0x76 (Samsung NAND 64MiB 3,3V =
8-bit)
NAND_ECC_NONE selected by board driver. This is not recommended !!
Scanning device for bad blocks
Creating 4 MTD partitions on "NAND 64MiB 3,3V 8-bit":
0x00000000-0x00030000 : "Boot modified by fla in devs.c"
0x00030000-0x00200000 : "Kernel"
0x00200000-0x02000000 : "RootFileSystem"
0x02000000-0x04000000 : "ExtendFileSystem"
usbmon: debugs is not available
hello,enter new ohci-s3c2410.c
CLKDIVN =3D 0000000d
CLKSLOW =3D 00000004
CLKCON =3D 00f2eb70
UPLLCON =3D 00038021
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
usb usb1: Product: S3C24XX OHCI
usb usb1: Manufacturer: Linux 2.6.12-h1940 ohci_hcd
usb usb1: SerialNumber: s3c24xx
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
sl811: driver sl811-hcd, 19 May 2005
=20
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
s3c2440-i2c s3c2440-i2c: slave address 0x10
s3c2440-i2c s3c2440-i2c: bus frequency set to 390 KHz
s3c2440-i2c s3c2440-i2c: i2c-0: S3C I2C adapter
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
usbcore: registered new driver bcm203x
Bluetooth: Digianswer Bluetooth USB driver ver 0.8
usbcore: registered new driver bpa10x
Bluetooth: BlueFRITZ! USB driver ver 1.1
usbcore: registered new driver bfusb
line 1408 passed!
virtual address of s3c2410_va_iis=3Df0d00000.
next will do driver_register!
just enter s3c2410_uda1341_probe()
S3C2410-UDA1341 Probe
line 1322 passed!
line 1325 passed!
line 1327 passed! have set L3 mode=3DGPB2, dat=3DGPB3, clk=3DGPB4, output
line 1330 passed!
line 1332 passed!
have set IISLRCK=3DGPE0, IISSCLK=3DGPE1, CDCLK=3DGPE2, IISSDI=3DGPE3, IISSD=
O=3DGPE4
line 1336 passed! have Enable IIS clock
line 1287 passed!
line 238 passed!
line 275 passed!
line 275 passed!
line 275 passed!
line 238 passed!
line 275 passed!
line 275 passed!
line 275 passed!
line 275 passed!
line 275 passed!
line 1309 passed!
success register irq: iisout_dma_done_handler
success register irq: iisin_dma_done_handler
=20
UDA1341 audio driver initialized
driver uda1341 in /sound/oss/s3c2410-oss.c
line 1414 passed!
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Reading data from NAND FLASH without ECC is not recommended
VFS: Mounted root (cramfs filesystem) readonly.
Mounted devfs on /dev
Freeing init memory: 160K
Reading data from NAND FLASH without ECC is not recommended
Reading data from NAND FLASH without ECC is not recommended
Using /usr/usbfor2440.ko
OLD:
UPLLCON =3D 0x00078023
CLKCON =3D 0x00f3ebf0
CLKSLOW =3D 0x00000004
CLKDIVN =3D 0x0000000d
starting modifiy upllcon...
NEW:
UPLLCON =3D 0x00038021
CLKCON =3D 0x00f2eb70
CLKSLOW =3D 0x00000004
CLKDIVN =3D 0x0000000d
mount: Mounting none on /proc/bus/usb failed: No such file or directory
Please press Enter to activate this console. Reading data from NAND FLASH w=
ithout ECC is not recommended
cirrus_start: requesting interrupt 53
Invalid cs8900 irq
eth0: register interrupt 53 successfuly
ln: /dev/touchscreen/0: File exists
Could not open mime.types file, "etc/mime.types", for reading
mount: Mounting /dev/nfblock/3 on /tmp/flashdisk failed: No such file or di=
rectory
mount: Mounting /dev/nfblock/2 on /tmp/mplayer failed: No such file or dire=
ctory
Reading data from NAND FLASH without ECC is not recommended
Reading data from NAND FLASH without ECC is not recommended
Reading data from NAND FLASH without ECC is not recommended
mapping /dev/fb0: Invalid argument
Error: failed to map framebuffer device to memory.
mapping /dev/fb0: Invalid argument
Error: failed to map framebuffer device
Please press Enter to activate this console.                               =
                                Wang Jimscen                               =
                               Jun 10,2007                                 =
               
------=_Part_973812_21147067.1181456505243
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Hello!I have compiled bluez-libs-3.11 and bluez-u=
tils-3.11 in scratchbox for arm successfully. Then I put the library files =
in /usr/lib and utilities in /usr/bin as well&nbsp;.And I compressed the ne=
w target system to a scram format file and downloaded the file in my machin=
e which uses s3c2440 as its core and uses linux 2.6.12 kernel..But when I p=
lugged my usb dongle which is produced by Integrated System Solution Corpor=
ation with HCI 1.1 version, and the following error messages appeared in my=
 DNW windows which is produced by SANSUM as a console.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">[root@(none) /]# usb 1-1: new full speed USB devi=
ce using s3c2410-ohci and address 6</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: unable to read config index 0 descriptor=
/start</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: can't read configurations, error -110</F=
ONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: new full speed USB device using s3c2410-=
ohci and address 7</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: unable to read config index 0 descriptor=
/start</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: can't read configurations, error -110</F=
ONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: new full speed USB device using s3c2410-=
ohci and address 8</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: device descriptor read/all, error -110</=
FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: new full speed USB device using s3c2410-=
ohci and address 9</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: unable to read config index 0 descriptor=
/start</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb 1-1: can't read configurations, error =A8C110=
</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Then when I entered all the Bluetooth utilities c=
ommands such as hcitool , the error message emerged and they couldn=A1=AFt =
work at all.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">[root@(none) /]# hcitool scan</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Device is not available: No such device</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Shall I have to enble some usb options in kernel =
configuration when compile kernel? But I have enabled two usb controller op=
tion and usb siereis converter option. Is bluetooth usb driver independent =
on usb options? If not which options should I enable at least? Can anyone h=
elp me to figure out the problem?<SPAN style=3D"mso-spacerun: yes">&nbsp; <=
/SPAN></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">The booting message appeared in my console window=
 is in the following.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)=
</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU0: D VIVT write-back cache</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU0: I cache: 16384 bytes, associativity 64, 32 =
byte lines, 8 sets</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU0: D cache: 16384 bytes, associativity 64, 32 =
byte lines, 8 sets</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Machine: SMDK2410</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">ATAG_INITRD is deprecated; please update your boo=
tloader.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Memory policy: ECC disabled, Data cache writeback=
</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU S3C2440A (id 0x32440001)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2440: core 400.000 MHz, memory 100.000 MHz, pe=
ripheral 50.000 MHz</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2410 Clocks, (c) 2004 Simtec Electronics</FONT=
></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">USB Control, (c) 2006 ucdragon yl2440.new</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Built 1 zonelists</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Kernel command line: root=3D/dev/mtdblock2 init=
=3D/linuxrc load_ramdisk=3D0 console=3DttySAC1,115200 mem=3D65536K devfs=3D=
mount shp240</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">irq: clearing pending ext status 00007200</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">irq: clearing subpending status 00000092</FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">PID hash table entries: 512 (order: 9, 8192 bytes=
)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">timer tcon=3D00590000, tcnt a2c1, tcfg 00000200,0=
0000000, usec 00001eb8</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Console: colour dummy device 80x30</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Dentry cache hash table entries: 16384 (order: 4,=
 65536 bytes)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<?xml:namespace prefix =3D o ns =3D "urn:sc=
hemas-microsoft-com:office:office" /><o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Inode-cache hash table entries: 8192 (order: 3, 3=
2768 bytes)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Memory: 64MB =3D 64MB total</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Memory: 61440KB available (2712K code, 498K data,=
 160K init)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Mount-cache hash table entries: 512</FONT></SPAN>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CPU: Testing write buffer coherency: ok</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NET: Registered protocol family 16</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2440: Initialising architecture</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2440: IRQ Support</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2440: Clock Support, UPLL 96.000 MHz</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">SCSI subsystem initialized</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver usbfs</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver hub</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: Core ver 2.7</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NET: Registered protocol family 31</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: HCI device and connection manager init=
ialized</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: HCI socket layer initialized</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2410 DMA Driver, (c) 2003-2004 Simtec Electron=
ics</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">DMA channel 0 at c4800000, irq 33</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">DMA channel 1 at c4800040, irq 34</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">DMA channel 2 at c4800080, irq 35</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">DMA channel 3 at c48000c0, irq 36</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NetWinder Floating Point Emulator V0.97 (double p=
recision)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csir=
o.au)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">devfs: boot_options: 0x1</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NTFS driver 2.1.22 [Flags: R/W].</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, =
Inc.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">yaffs Jun<SPAN style=3D"mso-spacerun: yes">&nbsp;=
 </SPAN>6 2007 20:36:18 Installing. </FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Initializing Cryptographic API</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">--- s3c2410fb init ---!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">pxafb_probe start!!!!!!!!!!!!!!!!!!!!!!!!!!</FONT=
></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-lcd s3c2410-lcd: Invalid resolution or bi=
t depth</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-lcd: probe of s3c2410-lcd failed with err=
or -22</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Console: switching to colour frame buffer device =
80x25</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">fb0: Virtual frame buffer device, using 1024K of =
video memory</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">in s3c2410ts init()</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">success get major number!!!!!!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-ts device driver MAJOR:253</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">success to get adc clock source!</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">base_addr =3D 0xc4962000</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 535 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">register s3c2410-ts driver success, return code i=
s 0</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2410 RTC, (c) 2004 Simtec Electronics</FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">initialize ST16C550 on yl-2410 board, iobase =3D =
0xd4000000</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Serial: 8250/16550 driver $Revision: 1.90 $ ,hace=
 done serial8250_io_init!!!!5 ports, IRQ sharing disabled</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">have enter serial8250_isa_init_ports!iobase =3D 0=
xc4980000</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2166 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2168 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">before uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1958 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1960 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">IN!!line 1965 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">enter uart_report_port() line 1918 passed</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">ttsA0 at I/O 0xc4980000 (irq =3D 57) is a 16550A<=
/FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1967 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1974 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1976 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1984 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">after uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2196 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2198 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2166 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2168 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">before uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1958 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1960 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">IN!!line 1965 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">enter uart_report_port() line 1918 passed</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410_serial0 at MMIO 0x50000000 (irq =3D 70) i=
s a S3C2440</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1967 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1974 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1976 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1984 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">after uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2196 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2198 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2166 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2168 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">before uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1958 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1960 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">IN!!line 1965 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">enter uart_report_port() line 1918 passed</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410_serial1 at MMIO 0x50004000 (irq =3D 73) i=
s a S3C2440</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1967 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1974 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1976 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">after uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2196 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2198 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2166 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2168 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">before uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1958 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1960 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">IN!!line 1965 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">enter uart_report_port() line 1918 passed</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410_serial2 at MMIO 0x50008000 (irq =3D 76) i=
s a S3C2440</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1967 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1974 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1976 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1984 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">after uart_configure_port!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2196 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 2198 passed</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">io scheduler noop registered</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">io scheduler anticipatory registered</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">io scheduler deadline registered</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">io scheduler cfq registered</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">RAMDISK driver initialized: 16 RAM disks of 4096K=
 size 1024 blocksize</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">loop: loaded (max 8 devices)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">nbd: registered device at major 43</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">ub: sizeof ub_scsi_cmd 68 ub_dev 2384 ub_lun 140<=
/FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver ub</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">PPP generic driver version 2.4.2</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">PPP Deflate Compression module registered</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">PPP BSD Compression module registered</FONT></SPA=
N></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NET: Registered protocol family 24</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Cirrus Logic CS8900A driver for Linux (V0.02)</FO=
NT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">dev-&gt;base_addr=3D0xe0000300&lt;3&gt;line 689 p=
assed,request_region() OK!success get IO port address!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">eth0: CS8900A rev E detected</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">BWSCON=3D2211d110</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">GPFCON=3D1a6aaaa</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">EXTINT0=3D22122242</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">INTMSK=3D6f7f3d9f</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">BWSCON=3D221dd110</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">GPFCON=3D1a6aaaa</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">EXTINT0=3D21122242</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">INTMSK=3D6f7f3d9f</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">DM9000 ethernet driver V1.26 I/O: c4974300, VID: =
90000a46 </FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>su=
ccess to exe register_netdev.in another word err &gt;0,</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>th=
e last edition,new MAC address!!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Linux video capture interface: v1.00</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Uniform Multi-Platform E-IDE driver Revision: 7.0=
0alpha2</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">ide: Assuming 50MHz system bus speed for PIO mode=
s; override with idebus=3Dxx</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>SE=
T CF &amp; IDE WAIT!now BWSCON=3D225dd510</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">now begin cf_ide_init_default_hwifs()</FONT></SPA=
N></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">have initialized interrupt for cf:EINT3</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">fla2612:INTMSK=3D6f7f3d95</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">GPFCON=3D000055aa</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">EXTINT0=3D00004040</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">GPBCON=3D00100154</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">GPBDAT=3D000007e2</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">-1:no 0:ok CF_register_hw return -1</FONT></SPAN>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">-1:no 0:ok ide_register_hw return -1</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C24XX NAND Driver, (c) 2004 Simtec Electronics<=
/FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-nand: mapped registers at c4b00000</FONT>=
</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-nand: timing: Tacls 10ns, Twrph0 40ns, Tw=
rph1 10ns</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NAND device: Manufacturer ID: 0xec, Chip ID: 0x76=
 (Samsung NAND 64MiB 3,3V 8-bit)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NAND_ECC_NONE selected by board driver. This is n=
ot recommended !!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Scanning device for bad blocks</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Creating 4 MTD partitions on "NAND 64MiB 3,3V 8-b=
it":</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">0x00000000-0x00030000 : "Boot modified by fla in =
devs.c"</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">0x00030000-0x00200000 : "Kernel"</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">0x00200000-0x02000000 : "RootFileSystem"</FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">0x02000000-0x04000000 : "ExtendFileSystem"</FONT>=
</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbmon: debugs is not available</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">hello,enter new ohci-s3c2410.c</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKDIVN =3D 0000000d</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKSLOW =3D 00000004</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKCON =3D 00f2eb70</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">UPLLCON =3D 00038021</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-ohci s3c2410-ohci: S3C24XX OHCI</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-ohci s3c2410-ohci: new USB bus registered=
, assigned bus number 1</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000=
000</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb usb1: Product: S3C24XX OHCI</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb usb1: Manufacturer: Linux 2.6.12-h1940 ohci_h=
cd</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usb usb1: SerialNumber: s3c24xx</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">hub 1-0:1.0: USB hub found</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">hub 1-0:1.0: 2 ports detected</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">sl811: driver sl811-hcd, 19 May 2005</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver usbserial</FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">drivers/usb/serial/usb-serial.c: USB Serial suppo=
rt registered for Generic</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver usbserial_generic<=
/FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">drivers/usb/serial/usb-serial.c: USB Serial Drive=
r core v2.0</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mice: PS/2 mouse device common for all mice</FONT=
></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">i2c /dev entries driver</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2440-i2c s3c2440-i2c: slave address 0x10</FONT=
></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2440-i2c s3c2440-i2c: bus frequency set to 390=
 KHz</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">s3c2440-i2c s3c2440-i2c: i2c-0: S3C I2C adapter</=
FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: HCI USB driver ver 2.8</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver hci_usb</FONT></SP=
AN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: Broadcom Blutonium firmware driver ver=
 1.0</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver bcm203x</FONT></SP=
AN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: Digianswer Bluetooth USB driver ver 0.=
8</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver bpa10x</FONT></SPA=
N></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: BlueFRITZ! USB driver ver 1.1</FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">usbcore: registered new driver bfusb</FONT></SPAN=
></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1408 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">virtual address of s3c2410_va_iis=3Df0d00000.</FO=
NT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">next will do driver_register!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">just enter s3c2410_uda1341_probe()</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">S3C2410-UDA1341 Probe</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1322 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1325 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1327 passed! have set L3 mode=3DGPB2, dat=3D=
GPB3, clk=3DGPB4, output</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1330 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1332 passed! </FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">have set IISLRCK=3DGPE0, IISSCLK=3DGPE1, CDCLK=3D=
GPE2, IISSDI=3DGPE3, IISSDO=3DGPE4</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1336 passed! have Enable IIS clock</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1287 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 238 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 238 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 275 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1309 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">success register irq: iisout_dma_done_handler</FO=
NT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">success register irq: iisin_dma_done_handler</FON=
T></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">UDA1341 audio driver initialized</FONT></SPAN></P=
>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">driver uda1341 in /sound/oss/s3c2410-oss.c</FONT>=
</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">line 1414 passed!</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NET: Registered protocol family 2</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">IP: routing cache hash table of 512 buckets, 4Kby=
tes</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">TCP established hash table entries: 4096 (order: =
3, 32768 bytes)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">TCP bind hash table entries: 4096 (order: 2, 1638=
4 bytes)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">TCP: Hash tables configured (established 4096 bin=
d 4096)</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NET: Registered protocol family 1</FONT></SPAN></=
P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: L2CAP ver 2.7</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: L2CAP socket layer initialized</FONT><=
/SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: SCO (Voice Link) ver 0.4</FONT></SPAN>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: SCO socket layer initialized</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: RFCOMM ver 1.5</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: RFCOMM socket layer initialized</FONT>=
</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: RFCOMM TTY layer initialized</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: BNEP (Ethernet Emulation) ver 1.2</FON=
T></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Bluetooth: HIDP (Human Interface Emulation) ver 1=
.1</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">VFS: Mounted root (cramfs filesystem) readonly.</=
FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Mounted devfs on /dev</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Freeing init memory: 160K</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Using /usr/usbfor2440.ko</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">OLD:</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">UPLLCON =3D 0x00078023</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKCON =3D 0x00f3ebf0</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKSLOW =3D 0x00000004</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKDIVN =3D 0x0000000d</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">starting modifiy upllcon...</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">NEW:</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">UPLLCON =3D 0x00038021</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKCON =3D 0x00f2eb70</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKSLOW =3D 0x00000004</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">CLKDIVN =3D 0x0000000d</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mount: Mounting none on /proc/bus/usb failed: No =
such file or directory</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Please press Enter to activate this console. Read=
ing data from NAND FLASH without ECC is not recommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">cirrus_start: requesting interrupt 53</FONT></SPA=
N></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Invalid cs8900 irq</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">eth0: register interrupt 53 successfuly</FONT></S=
PAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">ln: /dev/touchscreen/0: File exists</FONT></SPAN>=
</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Could not open mime.types file, "etc/mime.types",=
 for reading</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mount: Mounting /dev/nfblock/3 on /tmp/flashdisk =
failed: No such file or directory</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mount: Mounting /dev/nfblock/2 on /tmp/mplayer fa=
iled: No such file or directory</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Reading data from NAND FLASH without ECC is not r=
ecommended</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mapping /dev/fb0: Invalid argument</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Error: failed to map framebuffer device to memory=
.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">mapping /dev/fb0: Invalid argument</FONT></SPAN><=
/P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Error: failed to map framebuffer device </FONT></=
SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US><FONT=
 face=3D"Times New Roman">Please press Enter to activate this console.</FON=
T></SPAN></P></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wang Jims=
cen</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;Jun&nbsp;10,2007&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; </DIV>
<DIV>&nbsp;</DIV><br><!-- footer --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1" target=
=3D"_blank"><span style=3D"text-decoration:underline; color:blue">150 =CD=
=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =D3=CE=A3=AC=C4=E3 =B2=
=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF </span> </a>
------=_Part_973812_21147067.1181456505243--



--===============1138247423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1138247423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1138247423==--
