Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A143.476164EC"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A8A@netbe01.net.unimis>
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
Date: Mon, 15 Aug 2005 10:44:38 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A143.476164EC
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi, Peter:

Here is the log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Linux version 2.4.20-uc0 (icc@AL30) (gcc version 3.0) #220 ?.. 8?.. 15 =
10:09:055Processor: Winbond W90N740 revision 1
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
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
VFS: Mounted root (romfs filesystem) readonly.
Freeing init memory: 48K
Shell invoked to run file: /bin/init
Sash command shell (version 1.1.1)

/> new USB device :801e7a04-171d60
hub.c: new USB device 1, assigned address 2
bluetooth.c: USB Bluetooth converter detected
bluetooth.c: Bluetooth converter now attached to ttyUB0 (or usb/ttub/0 =
for devf)                                                                =
               =20
/> hciconfig
Can't open HCI socket.: Address family not supported by protocol
pid 9: failed 256
/>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

The last error message is printed from hciconfig.c while trying
to create a socket.
-----------------------------------------------------------
if ((ctl =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0)=20
{=09
		perror("Can't open HCI socket.");
		exit(1);
}
------------------------------------------------------------

Thanks for helps,

Al
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



------_=_NextPart_001_01C5A143.476164EC
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IicCAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAAPAAoALAAm
AAEAUAEBIIADAA4AAADVBwgADwAKACwAJgABAFABAQmAAQAhAAAAMkY3QjVBMDM4NjA4QTE0MEI3
Qjk1MUIzMjhENDVBQTgAFgcBA5AGANwRAAA3AAAAAwAmAAAAAAADADYAAAAAAEAAOQDsZGFHQ6HF
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAvAAAAYz11czthPSA7cD11bmltaXM7bD1ORVRC
RTAxLTA1MDgxNTAyNDQzOFotMTAxNwAAHgBJAAEAAAA0AAAAUkU6IFtCbHVlei1kZXZlbF0gUG9y
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
GuTXkIzQOC9KEGYvYsEpIDg6tWCo4E39riVvGu8cXx1jNuWb4AwZmlOLUGrnASI0UkUqYO5bnoIb
hXIQUPYhN8LEtM9iQY+hdFB4EnVDNaGFIP0VmkiM0GzwF1sBANChj0D3hGCPklrxeRzRZGAZBlkg
/1VkzfRjoE1h/ntZcK4VHMCfbiBjoDfCNaBeMCAi9rPea42R9SqhGDihIjjA/dD/ZwFu4L5QmVAu
c6ugj+Arab8ugsS0ZwH1onPJOMBEY+D/LMF9Ib2BMEGMIp9xWRD+t///8sRaK8Msw9YkQzDl4WcQ
qTixPz8VmkN0AG8XWwsekxWafT8QAB4ANRABAAAAPAAAADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5
QTY3OEQ5REQ3MzAxMUE4QUBuZXRiZTAxLm5ldC51bmltaXM+AB4ARxABAAAADwAAAG1lc3NhZ2Uv
cmZjODIyAAALAPIQAQAAAB8A8xABAAAAdAAAAFIARQAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABl
AHYAZQBsAF0AIABQAG8AcgB0AGkAbgBnACAAQgBsAHUAZQBaACAAbwBuACAAZQBtAGIAZQBkAGQA
ZQBkACAAdQBDAGwAaQBuAHUAeAAuAEUATQBMAAAACwD2EAAAAABAAAcwkBDZIEKhxQFAAAgw8LJv
R0OhxQEDAN4/5AQAAAMA8T8JBAAAHgD4PwEAAAADAAAAQWwAAAIB+T8BAAAAXQAAAAAAAADcp0DI
wEIQGrS5CAArL+GCAQAAAAAAAAAvTz1VTklNSVMvT1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JP
VVAvQ049UkVDSVBJRU5UUy9DTj1BTC5JU1NDAAAAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlz
dHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9
P7YDAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAACAAAAEFMLklTU0MA
HgAxQAEAAAAIAAAAQUwuSVNTQwAeADJAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAHgAzQAEAAAAXAAAAcGV3aUBndy1pbnN0cnVtZW50cy5kZQAAHgA4QAEA
AAAIAAAAQUwuSVNTQwAeADlAAQAAAAIAAAAuAAAACwApAAAAAAALACMAAAAAAAMABhC8HB6OAwAH
EOYMAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEksUEVURVI6SEVSRUlTVEhFTE9HOj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PUxJ
TlVYVkVSU0lPTjI0MjAtVUMwKAAAAAACAX8AAQAAADwAAAA8RTY0QkFENUE4QUQ0Njc0MDgyODA2
OUE2NzhEOURENzMwMTFBOEFAbmV0YmUwMS5uZXQudW5pbWlzPgBvrw==

------_=_NextPart_001_01C5A143.476164EC--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
