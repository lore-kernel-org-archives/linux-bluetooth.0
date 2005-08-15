Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A157.B62FFA44"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A8C@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Aug 2005 13:10:54 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A157.B62FFA44
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi, Peter:

     You are right about BlueZ was not initilized. After I force define =
MODULE in af_bluetooth.c , creating bluetooth socket using hciconfig is =
OK. But command "hciconfig -a" still can't read the bluetooth USB dongle =
information.=20

thanks,
Al

-----------------------
#define MODULE //Al add
#ifdef MODULE
module_init(bluez_init);
module_exit(bluez_cleanup);

MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>");
MODULE_DESCRIPTION("BlueZ Core ver " VERSION);
MODULE_LICENSE("GPL");
#endif
-----------------------

log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Linux version 2.4.20-uc0 (icc@AL30) (gcc version 3.0) #225 ?.. 8?.. 15 =
12:56:425Processor: Winbond W90N740 revision 1
Architecture: W90N740
On node 0 totalpages: 2048
zone(0): 0 pages.
zone(1): 2048 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/rom0
Calibrating delay loop... 39.83 BogoMIPS
Memory: 7MB =3D 7MB total
Memory: 5792KB available (987K code, 205K data, 48K init)
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Winbond W90N740 Serial driver version 0.9 (2001-12-27) with no serial =
options edttyS00 at 0xfff80000 (irq =3D 6) is a W90N740
Blkmem copyright 1998,1999 D. Jeff Dionne
Blkmem copyright 1998 Kenneth Albanowski
Blkmem 1 disk images:
0: 700000-7CABFF [VIRTUAL 700000-7CABFF] (RO)
RAMDISK driver initialized: 16 RAM disks of 1024K size 1024 blocksize
loop: loaded (max 8 devices)
Regiter EMC 1 W90N740
Winbond NATA1 ver0.2
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
AM29LV160 Flash Detected
usb.c: registered new driver hub
add a static ohci host controller device
: USB OHCI at membase 0xfff05000, IRQ 9
hc_alloc_ohci
usb-ohci.c: AMD756 erratum 4 workaround
hc_reset
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
bluetooth.c: USB Bluetooth support registered
usb.c: registered new driver bluetty
bluetooth.c: USB Bluetooth tty driver v0.13
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
ip_conntrack version 2.0 (56 buckets, 448 max) - 348 bytes per conntrack
In  URL Filter conntrack init
ip_ct_http: registering helper for port 53
Spec conntrack init successfully ########
Register NAT spec successfully
ip_tables: (C) 2000-2002 Netfilter core team
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
VFS: Mounted root (romfs filesystem) readonly.
Freeing init memory: 48K
Shell invoked to run file: /bin/init                                     =
                                          =20
Sash command shell (version 1.1.1)
/> new USB device :801e7a04-171d60
hub.c: new USB device 1, assigned address 2
bluetooth.c: USB Bluetooth converter detected
bluetooth.c: Bluetooth converter now attached to ttyUB0 (or usb/ttub/0 =
for devf)                                                                =
               =20
/> hciconfig -a
                                                                         =
      =20
/> hciconfig hci0 up
                                                                         =
      =20
Can't get device info: No such device
pid 10: failed 256
/>



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D


-----Original Message-----
From:	bluez-devel-admin@lists.sourceforge.net on behalf of Peter Wippich
Sent:	Fri 8/12/2005 8:34 PM
To:	bluez-devel@lists.sourceforge.net
Cc:=09
Subject:	RE: [Bluez-devel] Porting BlueZ on embedded uClinux

Hi Al,

when I remember your original posting right the error message was
something like "protokoll family not registered...". This may be the =
case
when the BlueZ is not initialized. Do you get some start up message from
BlueZ when your system boots up ??

Ciao,

Peter



------_=_NextPart_001_01C5A157.B62FFA44
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjcFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAAPAA0ACgA2
AAEAQQEBIIADAA4AAADVBwgADwANAAoANgABAEEBAQmAAQAhAAAANzY3Q0U0RDRBNkFERkI0MjlE
N0NGQjg5RUQyQjA1QUMAmAcBA5AGAJQSAAA3AAAAAwAmAAAAAAADADYAAAAAAEAAOQBE+i+2V6HF
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAvAAAAYz11czthPSA7cD11bmltaXM7bD1ORVRC
RTAxLTA1MDgxNTA1MTA1NFotMTAzMwAAHgBJAAEAAAA0AAAAUkU6IFtCbHVlei1kZXZlbF0gUG9y
dGluZyBCbHVlWiBvbiBlbWJlZGRlZCB1Q2xpbnV4AEAATgCANsIiOp/FAR4AWgABAAAAKAAAAGJs
dWV6LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAACAVsAAQAAAG0AAAAAAAAAgSsf
pL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQA
U01UUABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAt
AAAAU01UUDpCTFVFWi1ERVZFTC1BRE1JTkBMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAAAAHgBdAAEA
AAAOAAAAUGV0ZXIgV2lwcGljaAAAAAIBXgABAAAAQgAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAA
AFBldGVyIFdpcHBpY2gAU01UUABwZXdpQGd3LWluc3RydW1lbnRzLmRlAAAAAgFfAAEAAAAcAAAA
U01UUDpQRVdJQEdXLUlOU1RSVU1FTlRTLkRFAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAo
AAAAYmx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AaAABAAAABQAAAFNN
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
L48NVflcIG4nsgBUILIAEPUH8Ht8YE9ATojB4pDD4LLacH+qQGbBT0CrYAKh1QBOkDb/D+Y4Gjga
R6837zj/SFo6ev1Cw0/6oQfwhjFfAOLQdRI/Q5gEQAJARMByAcdDei2nW0FZ0CQwZG0H8EDVgX3B
QC6C4FHwefB8YVQgLt+CYYlAB1C+MHWwbJpQmkG+UK2B5KBPYMQgI7Bog0VPZNE91ARAsbA4L04g
L7OHoUygODraQM3ATdMF/zJQPe4/T0BTW8XAwD3jg0VNsDBqGFFC9FJFT0Bb9xnSPnWW8FDBIXpi
6ZSHIee0gZkwnPJ1Q1qBqgA6etZIsbCR0Cw6end1gAdQ77QgqUC0cn/ReT/BiUA79v9+AHpE+qQZ
cHJBuNDMsZMA/zyTiFD+0Ds0guCTABlwemKzmQCDECAip9DN8Wuycb80MT8Q4yEbEMRqXYEijsD+
VFNwi/CTwOMwvjBRY6qQ/7TATllRcumUi+FVMpipjsD+RIjAT7ExY1MisQLEUSsw/VIHZgIx6TpO
s0+zAtTHQKcZUYvwW6E/Pzp6Q5jgLm9N60GDOnp9YgAAAAAeADUQAQAAADwAAAA8RTY0QkFENUE4
QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFBOENAbmV0YmUwMS5uZXQudW5pbWlzPgAeAEcQAQAA
AA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQAQAAAHQAAABSAEUAJQAzAEEAIABbAEIA
bAB1AGUAegAtAGQAZQB2AGUAbABdACAAUABvAHIAdABpAG4AZwAgAEIAbAB1AGUAWgAgAG8AbgAg
AGUAbQBiAGUAZABkAGUAZAAgAHUAQwBsAGkAbgB1AHgALgBFAE0ATAAAAAsA9hAAAAAAQAAHMIiV
BUJWocUBQAAIMJyDObZXocUBAwDeP+QEAAADAPE/CQQAAB4A+D8BAAAAAwAAAEFsAAACAfk/AQAA
AF0AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089VU5JTUlTL09VPUZJUlNUIEFETUlO
SVNUUkFUSVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049QUwuSVNTQwAAAAAeAPo/AQAAABUAAABT
eXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEA
AAAAAAAALgAAAAMA/T+2AwAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAA
AAgAAABBTC5JU1NDAB4AMUABAAAACAAAAEFMLklTU0MAHgAyQAEAAAAoAAAAYmx1ZXotZGV2ZWwt
YWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AM0ABAAAAFwAAAHBld2lAZ3ctaW5zdHJ1bWVu
dHMuZGUAAB4AOEABAAAACAAAAEFMLklTU0MAHgA5QAEAAAACAAAALgAAAAsAKQAAAAAACwAjAAAA
AAADAAYQ/bwv0gMABxDLDQAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLFBFVEVSOllP
VUFSRVJJR0hUQUJPVVRCTFVFWldBU05PVElOSVRJTElaRURBRlRFUklGT1JDRURFRklORU1PRFVM
RUlOQUZCTFVFVE9PVEhDLENSRUFUSU5HQkxVRVRPT1QAAAAAAgF/AAEAAAA8AAAAPEU2NEJBRDVB
OEFENDY3NDA4MjgwNjlBNjc4RDlERDczMDExQThDQG5ldGJlMDEubmV0LnVuaW1pcz4AABk=

------_=_NextPart_001_01C5A157.B62FFA44--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
