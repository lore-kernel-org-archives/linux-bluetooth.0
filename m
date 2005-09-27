Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <f6df51f0050927075118d4efe4@mail.gmail.com>
From: Itzhak Ben-Akiva <benakiva@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11968_26872461.1127832707304"
Subject: [Bluez-devel] PCMCIA Bluetooth Card (AnyCom CF - 300) on ARM
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
Date: Tue, 27 Sep 2005 17:51:47 +0300

------=_Part_11968_26872461.1127832707304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

May I request your help in solving a problem I have with pcmcia
bluetooth card?

I'm working on ARM Integrator/AP platform with Linux 2.6.13. And, I'm
using PCI Bus Card Drive: PCI-IF1/C (32Bit) and PCMCIA Bluetooth Card -
Anycom Blue CF - 300, which uses the driver bluecard_cs.

In my system the device is correctly detected to be usable with the
bluecard_cs driver. It then calls bluecard_attach(), which calls
pcmcia_register_client(). It then calls bluecard_event(), which calls
bluecard_config. bluecard_config, then, calls pcmcia_request_io, which
always returns REQUESTIO: resource in use.

However, cardctl and cardmgr report the card correctly:
~ # cardctl ident
Socket 0:
 product info: "BTCFCARD", "LSE139"
 manfid: 0x0264, 0x000b
 function: 6 (network)


Below is a syslog message:

Linux version 2.6.13-git2 (root@gilnx13-1) (gcc version 3.4.2 (release)
(CodeSourcery ARM Q3 2004)) #14 Mon Sep 26 12:35:25
CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)
Machine: ARM-Integrator
Warning: bad configuration page, trying to continue
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
Built 1 zonelists
Kernel command line: console=3DttyAM0,38400n8 mem=3D126M rw nohalt
root=3D/dev/nfs ip=3D10.0.0.11:10 <http://10.0.0.11:10>.0.0.2::::eth0:off
nfsroot=3D10.k
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 126MB =3D 126MB total
Memory: 125056KB available (2027K code, 622K data, 96K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
PCI: Bridge: 0000:00:09.0
 IO window: disabled.
 MEM window: disabled.
 PREFETCH window: disabled.
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
 IO window: 00006000-000060ff
 IO window: 00006400-000064ff
 PREFETCH window: 10000000-11ffffff
 MEM window: 00000000-01ffffff
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Serial: AMBA driver $Revision: 1.41 $
ttyAM0 at MMIO 0x16000000 (irq =3D 1) is a AMBA
ttyAM1 at MMIO 0x17000000 (irq =3D 2) is a AMBA
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: 0000:00:0a.0, 00:0E:0C:6C:3A:1E, IRQ 14.
 Board assembly 751767-007, Physical connectors present: RJ45
 Primary interface chip i82555 PHY #1.
 Secondary interface chip i82555.
 General self-test: passed.
 Serial sub-system self-test: passed.
 Internal registers self-test: passed.
 ROM checksum self-test: passed (0x3258698e).
PPP generic driver version 2.4.2
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
IP-Config: Guessing netmask 255.0.0.0 <http://255.0.0.0>
IP-Config: Complete:
 device=3Deth0, addr=3D10.0.0.11 <http://10.0.0.11>,
mask=3D255.0.0.0<http://255.0.0.0>,
gw=3D255.255.255.255 <http://255.255.255.255>,
 host=3D10.0.0.11 <http://10.0.0.11>, domain=3D, nis-domain=3D(none),
 bootserver=3D10.0.0.2 <http://10.0.0.2>, rootserver=3D10.0.0.2<http://10.0=
.0.2>,
rootpath=3D
Looking up port of RPC 100003/2 on 10.0.0.2 <http://10.0.0.2>
Looking up port of RPC 100005/1 on 10.0.0.2 <http://10.0.0.2>
VFS: Mounted root (nfs filesystem).
yenta_socket: Unknown symbol pccard_nonstatic_ops
PCI: enabling device 0000:00:0b.0 (0140 -> 0143)
Yenta: CardBus bridge found at 0000:00:0b.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0b.0, mfunc 0x00001c02, devctl 0x62
Yenta: ISA IRQ mask 0x0000, PCI irq 15
Socket status: 30000010
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x4fffffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x5fffffff
cs: memory probe 0x40000000-0x4fffffff: excluding 0x40000000-0x427fffff
cs: memory probe 0x50000000-0x5fffffff: excluding 0x50000000-0x5fffffff
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
bluecard_config is about to be called in bluecard_event
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x300 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x340 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x380 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x3c0 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x200 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x240 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x280 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x2c0 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x100 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x140 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x180 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x1c0 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x40 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0x80 align 0x40
pcmcia_resource: pcmcia_socket0: odd IO request: base 0xc0 align 0x40
BT_DEBUG: pcmcia_request_io failed in bluecard_config
0.0: RequestIO: Resource in use
Uninitialised timer!
This is just a warning. Your computer is OK
function=3D0x00000000, data=3D0x0
[<c0025c84>] (dump_stack+0x0/0x14) from [<c003f598>] (check_timer_failed
+0x4c/0x6c)
[<c003f54c>] (check_timer_failed+0x0/0x6c) from [<c003f6fc>] (del_timer
+0x28/0x80)
 r4 =3D C79CFC88
[<c003f6d4>] (del_timer+0x0/0x80) from [<bf047da4>] (bluecard_release
+0x2c/0x64 [bluecard_cs])
 r5 =3D C79CFBE0 r4 =3D C79CFBE0
[<bf047d78>] (bluecard_release+0x0/0x64 [bluecard_cs]) from [<bf048478>]
(bluecard_event+0x4ec/0x5b4 [bluecard_cs])
 r5 =3D C79CFBE0 r4 =3D C79CFBE0
[<bf047f8c>] (bluecard_event+0x0/0x5b4 [bluecard_cs]) from [<bf0153b0>]
(pcmcia_register_client+0x1f4/0x224 [pcmcia])
[<bf0151bc>] (pcmcia_register_client+0x0/0x224 [pcmcia]) from
[<bf047f30>] (bluecard_attach+0xb8/0x114 [bluecard_cs])
[<bf047e78>] (bluecard_attach+0x0/0x114 [bluecard_cs]) from [<bf01431c>]
(pcmcia_device_probe+0x80/0x108 [pcmcia])
 r7 =3D 00000000 r6 =3D C7DA423C r5 =3D C7DA4200 r4 =3D BF04999C
[<bf01429c>] (pcmcia_device_probe+0x0/0x108 [pcmcia]) from [<c01473c4>]
(driver_probe_device+0x5c/0xa8)
 r7 =3D BF0499B0 r6 =3D BF0499B0 r5 =3D 00000000 r4 =3D C7DA423C
[<c0147368>] (driver_probe_device+0x0/0xa8) from [<c0147508>]
(__driver_attach+0x4c/0x78)
 r6 =3D C01474BC r5 =3D C7C25DBC r4 =3D C7DA42E4
[<c01474bc>] (__driver_attach+0x0/0x78) from [<c0146ae4>]
(bus_for_each_dev+0x50/0x84)
 r4 =3D 00000000
[<c0146a94>] (bus_for_each_dev+0x0/0x84) from [<c0147554>]
(driver_attach+0x20/0x28)
 r7 =3D BF01BB9C r6 =3D BF049944 r5 =3D BF0499B0 r4 =3D BF0499C4
[<c0147534>] (driver_attach+0x0/0x28) from [<c0146f58>] (bus_add_driver
+0x6c/0x138)
[<c0146eec>] (bus_add_driver+0x0/0x138) from [<c014790c>]
(driver_register+0x34/0x38)
[<c01478d8>] (driver_register+0x0/0x38) from [<bf0141d8>]
(pcmcia_register_driver+0xf8/0x114 [pcmcia])
 r4 =3D BF04999C
[<bf0140e0>] (pcmcia_register_driver+0x0/0x114 [pcmcia]) from
[<bf04b014>] (init_bluecard_cs+0x14/0x1c [bluecard_cs])
 r7 =3D C02218D0 r6 =3D BF049A60 r5 =3D BF049A60 r4 =3D C02218E0
[<bf04b000>] (init_bluecard_cs+0x0/0x1c [bluecard_cs]) from [<c0051a74>]
(sys_init_module+0x155c/0x16bc)
[<c0050518>] (sys_init_module+0x0/0x16bc) from [<c0020d00>]
(ret_fast_syscall+0x0/0x2c)


Many thanks in advance,
Itzhak

------=_Part_11968_26872461.1127832707304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<tt>Hi all,</tt><br>

<br>

<tt>May I request your help in solving a problem I have with pcmcia</tt><br=
>

<tt>bluetooth card?</tt><br>

<br>

<tt>I'm working on ARM Integrator/AP platform with Linux 2.6.13. And, I'm</=
tt><br>

<tt>using PCI Bus Card Drive: PCI-IF1/C (32Bit) and PCMCIA Bluetooth Card -=
</tt><br>

<tt>Anycom Blue CF - 300, which uses the driver bluecard_cs.</tt><br>

<br>

<tt>In my system the device is correctly detected to be usable with the</tt=
><br>

<tt>bluecard_cs driver. It then calls bluecard_attach(), which calls</tt><b=
r>

<tt>pcmcia_register_client(). It then calls bluecard_event(), which calls</=
tt><br>

<tt>bluecard_config. bluecard_config, then, calls pcmcia_request_io, which<=
/tt><br>

<tt>always returns REQUESTIO: resource in use.</tt><br>

<br>

<tt>However, cardctl and cardmgr report the card correctly:</tt><br>

<tt>~ # cardctl ident</tt><br>

<tt>Socket 0:</tt><br>

<tt>&nbsp; product info: &quot;BTCFCARD&quot;, &quot;LSE139&quot;</tt><br>

<tt>&nbsp; manfid: 0x0264, 0x000b</tt><br>

<tt>&nbsp; function: 6 (network)</tt><br>

<br>

<br>

<tt>Below is a syslog message:</tt><br>

<br>

<tt>Linux version 2.6.13-git2 (root@gilnx13-1) (gcc version 3.4.2 (release)=
</tt><br>

<tt>(CodeSourcery ARM Q3 2004)) #14 Mon Sep 26 12:35:25</tt><br>

<tt>CPU: ARM920Tid(wb) [41129200] revision 0 (ARMv4T)</tt><br>

<tt>Machine: ARM-Integrator</tt><br>

<tt>Warning: bad configuration page, trying to continue</tt><br>

<tt>Memory policy: ECC disabled, Data cache writeback</tt><br>

<tt>CPU0: D VIVT write-back cache</tt><br>

<tt>CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets</tt=
><br>

<tt>CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets</tt=
><br>

<tt>Built 1 zonelists</tt><br>

<tt>Kernel command line: console=3DttyAM0,38400n8 mem=3D126M rw nohalt</tt>=
<br>

<tt>root=3D/dev/nfs ip=3D<a href=3D"http://10.0.0.11:10">10.0.0.11:10</a>.0=
.0.2::::eth0:off nfsroot=3D10.k</tt><br>

<tt>PID hash table entries: 512 (order: 9, 8192 bytes)</tt><br>

<tt>Console: colour dummy device 80x30</tt><br>

<tt>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)</tt><br>

<tt>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)</tt><br>

<tt>Memory: 126MB =3D 126MB total</tt><br>

<tt>Memory: 125056KB available (2027K code, 622K data, 96K init)</tt><br>

<tt>Mount-cache hash table entries: 512</tt><br>

<tt>CPU: Testing write buffer coherency: ok</tt><br>

<tt>NET: Registered protocol family 16</tt><br>

<tt>PCI: bus0: Fast back to back transfers disabled</tt><br>

<tt>PCI: bus1: Fast back to back transfers enabled</tt><br>

<tt>PCI: Bridge: 0000:00:09.0</tt><br>

<tt>&nbsp; IO window: disabled.</tt><br>

<tt>&nbsp; MEM window: disabled.</tt><br>

<tt>&nbsp; PREFETCH window: disabled.</tt><br>

<tt>PCI: Bus 2, cardbus bridge: 0000:00:0b.0</tt><br>

<tt>&nbsp; IO window: 00006000-000060ff</tt><br>

<tt>&nbsp; IO window: 00006400-000064ff</tt><br>

<tt>&nbsp; PREFETCH window: 10000000-11ffffff</tt><br>

<tt>&nbsp; MEM window: 00000000-01ffffff</tt><br>

<tt>NetWinder Floating Point Emulator V0.97 (double precision)</tt><br>

<tt>Installing knfsd (copyright (C) 1996 <a href=3D"mailto:okir@monad.swb.d=
e">okir@monad.swb.de</a>).</tt><br>

<tt>Initializing Cryptographic API</tt><br>

<tt>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enable=
d</tt><br>

<tt>Serial: AMBA driver $Revision: 1.41 $</tt><br>

<tt>ttyAM0 at MMIO 0x16000000 (irq =3D 1) is a AMBA</tt><br>

<tt>ttyAM1 at MMIO 0x17000000 (irq =3D 2) is a AMBA</tt><br>

<tt>io scheduler noop registered</tt><br>

<tt>io scheduler anticipatory registered</tt><br>

<tt>io scheduler deadline registered</tt><br>

<tt>io scheduler cfq registered</tt><br>

<tt>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize</=
tt><br>

<tt>loop: loaded (max 8 devices)</tt><br>

<tt>eepro100.c:v1.09j-t 9/29/99 Donald Becker</tt><br>

<tt><a href=3D"http://www.scyld.com/network/eepro100.html">http://www.scyld=
.com/network/eepro100.html</a></tt><br>

<tt>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochki=
n</tt><br>

<tt>&lt;<a href=3D"mailto:saw@saw.sw.com.sg">saw@saw.sw.com.sg</a>&gt; and =
others</tt><br>

<tt>eth0: 0000:00:0a.0, 00:0E:0C:6C:3A:1E, IRQ 14.</tt><br>

<tt>&nbsp; Board assembly 751767-007, Physical connectors present: RJ45</tt=
><br>

<tt>&nbsp; Primary interface chip i82555 PHY #1.</tt><br>

<tt>&nbsp;&nbsp;&nbsp; Secondary interface chip i82555.</tt><br>

<tt>&nbsp; General self-test: passed.</tt><br>

<tt>&nbsp; Serial sub-system self-test: passed.</tt><br>

<tt>&nbsp; Internal registers self-test: passed.</tt><br>

<tt>&nbsp; ROM checksum self-test: passed (0x3258698e).</tt><br>

<tt>PPP generic driver version 2.4.2</tt><br>

<tt>mice: PS/2 mouse device common for all mice</tt><br>

<tt>NET: Registered protocol family 2</tt><br>

<tt>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)</tt><br>

<tt>TCP established hash table entries: 4096 (order: 3, 32768 bytes)</tt><b=
r>

<tt>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)</tt><br>

<tt>TCP: Hash tables configured (established 4096 bind 4096)</tt><br>

<tt>TCP reno registered</tt><br>

<tt>TCP bic registered</tt><br>

<tt>NET: Registered protocol family 1</tt><br>

<tt>NET: Registered protocol family 17</tt><br>

<tt>802.1Q VLAN Support v1.8 Ben Greear &lt;<a href=3D"mailto:greearb@cande=
latech.com">greearb@candelatech.com</a>&gt;</tt><br>

<tt>All bugs added by David S. Miller &lt;<a href=3D"mailto:davem@redhat.co=
m">davem@redhat.com</a>&gt;</tt><br>

<tt>IP-Config: Guessing netmask <a href=3D"http://255.0.0.0">255.0.0.0</a><=
/tt><br>

<tt>IP-Config: Complete:</tt><br>

<tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D<a href=3D"http://=
10.0.0.11">10.0.0.11</a>, mask=3D<a href=3D"http://255.0.0.0">255.0.0.0</a>=
, gw=3D<a href=3D"http://255.255.255.255">255.255.255.255</a>,</tt><br>

<tt>&nbsp;&nbsp;&nbsp;&nbsp; host=3D<a href=3D"http://10.0.0.11">10.0.0.11<=
/a>, domain=3D, nis-domain=3D(none),</tt><br>

<tt>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D<a href=3D"http://10.0.0.2">10.0.=
0.2</a>, rootserver=3D<a href=3D"http://10.0.0.2">10.0.0.2</a>, rootpath=3D=
</tt><br>

<tt>Looking up port of RPC 100003/2 on <a href=3D"http://10.0.0.2">10.0.0.2=
</a></tt><br>

<tt>Looking up port of RPC 100005/1 on <a href=3D"http://10.0.0.2">10.0.0.2=
</a></tt><br>

<tt>VFS: Mounted root (nfs filesystem).</tt><br>

<tt>yenta_socket: Unknown symbol pccard_nonstatic_ops</tt><br>

<tt>PCI: enabling device 0000:00:0b.0 (0140 -&gt; 0143)</tt><br>

<tt>Yenta: CardBus bridge found at 0000:00:0b.0 [0000:0000]</tt><br>

<tt>Yenta: Enabling burst memory read transactions</tt><br>

<tt>Yenta: Using CSCINT to route CSC interrupts to PCI</tt><br>

<tt>Yenta: Routing CardBus interrupts to PCI</tt><br>

<tt>Yenta TI: socket 0000:00:0b.0, mfunc 0x00001c02, devctl 0x62</tt><br>

<tt>Yenta: ISA IRQ mask 0x0000, PCI irq 15</tt><br>

<tt>Socket status: 30000010</tt><br>

<tt>pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x4fffffff</tt><b=
r>

<tt>pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x5fffffff</tt><b=
r>

<tt>cs: memory probe 0x40000000-0x4fffffff: excluding 0x40000000-0x427fffff=
</tt><br>

<tt>cs: memory probe 0x50000000-0x5fffffff: excluding 0x50000000-0x5fffffff=
</tt><br>

<tt>Bluetooth: Core ver 2.7</tt><br>

<tt>NET: Registered protocol family 31</tt><br>

<tt>Bluetooth: HCI device and connection manager initialized</tt><br>

<tt>Bluetooth: HCI socket layer initialized</tt><br>

<tt>Bluetooth: L2CAP ver 2.7</tt><br>

<tt>Bluetooth: L2CAP socket layer initialized</tt><br>

<tt>Bluetooth: RFCOMM ver 1.5</tt><br>

<tt>Bluetooth: RFCOMM socket layer initialized</tt><br>

<tt>Bluetooth: RFCOMM TTY layer initialized</tt><br>

<tt>Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1</tt><br>

<tt>bluecard_config is about to be called in bluecard_event</tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x300 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x340 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x380 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x3c0 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x200 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x240 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x280 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x2c0 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x100 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x140 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x180 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x1c0 align 0x40<=
/tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x40 align 0x40</=
tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0x80 align 0x40</=
tt><br>

<tt>pcmcia_resource: pcmcia_socket0: odd IO request: base 0xc0 align 0x40</=
tt><br>

<tt>BT_DEBUG: pcmcia_request_io failed in bluecard_config</tt><br>

<tt>0.0: RequestIO: Resource in use</tt><br>

<tt>Uninitialised timer!</tt><br>

<tt>This is just a warning.&nbsp; Your computer is OK</tt><br>

<tt>function=3D0x00000000, data=3D0x0</tt><br>

<tt>[&lt;c0025c84&gt;] (dump_stack+0x0/0x14) from [&lt;c003f598&gt;] (check=
_timer_failed</tt><br>

<tt>+0x4c/0x6c)</tt><br>

<tt>[&lt;c003f54c&gt;] (check_timer_failed+0x0/0x6c) from [&lt;c003f6fc&gt;=
] (del_timer</tt><br>

<tt>+0x28/0x80)</tt><br>

<tt>&nbsp;r4 =3D C79CFC88</tt><br>

<tt>[&lt;c003f6d4&gt;] (del_timer+0x0/0x80) from [&lt;bf047da4&gt;] (blueca=
rd_release</tt><br>

<tt>+0x2c/0x64 [bluecard_cs])</tt><br>

<tt>&nbsp;r5 =3D C79CFBE0&nbsp; r4 =3D C79CFBE0</tt><br>

<tt>[&lt;bf047d78&gt;] (bluecard_release+0x0/0x64 [bluecard_cs]) from [&lt;=
bf048478&gt;]</tt><br>

<tt>(bluecard_event+0x4ec/0x5b4 [bluecard_cs])</tt><br>

<tt>&nbsp;r5 =3D C79CFBE0&nbsp; r4 =3D C79CFBE0</tt><br>

<tt>[&lt;bf047f8c&gt;] (bluecard_event+0x0/0x5b4 [bluecard_cs]) from [&lt;b=
f0153b0&gt;]</tt><br>

<tt>(pcmcia_register_client+0x1f4/0x224 [pcmcia])</tt><br>

<tt>[&lt;bf0151bc&gt;] (pcmcia_register_client+0x0/0x224 [pcmcia]) from</tt=
><br>

<tt>[&lt;bf047f30&gt;] (bluecard_attach+0xb8/0x114 [bluecard_cs])</tt><br>

<tt>[&lt;bf047e78&gt;] (bluecard_attach+0x0/0x114 [bluecard_cs]) from [&lt;=
bf01431c&gt;]</tt><br>

<tt>(pcmcia_device_probe+0x80/0x108 [pcmcia])</tt><br>

<tt>&nbsp;r7 =3D 00000000&nbsp; r6 =3D C7DA423C&nbsp; r5 =3D C7DA4200&nbsp;=
 r4 =3D BF04999C</tt><br>

<tt>[&lt;bf01429c&gt;] (pcmcia_device_probe+0x0/0x108 [pcmcia]) from [&lt;c=
01473c4&gt;]</tt><br>

<tt>(driver_probe_device+0x5c/0xa8)</tt><br>

<tt>&nbsp;r7 =3D BF0499B0&nbsp; r6 =3D BF0499B0&nbsp; r5 =3D 00000000&nbsp;=
 r4 =3D C7DA423C</tt><br>

<tt>[&lt;c0147368&gt;] (driver_probe_device+0x0/0xa8) from [&lt;c0147508&gt=
;]</tt><br>

<tt>(__driver_attach+0x4c/0x78)</tt><br>

<tt>&nbsp;r6 =3D C01474BC&nbsp; r5 =3D C7C25DBC&nbsp; r4 =3D C7DA42E4</tt><=
br>

<tt>[&lt;c01474bc&gt;] (__driver_attach+0x0/0x78) from [&lt;c0146ae4&gt;]</=
tt><br>

<tt>(bus_for_each_dev+0x50/0x84)</tt><br>

<tt>&nbsp;r4 =3D 00000000</tt><br>

<tt>[&lt;c0146a94&gt;] (bus_for_each_dev+0x0/0x84) from [&lt;c0147554&gt;]<=
/tt><br>

<tt>(driver_attach+0x20/0x28)</tt><br>

<tt>&nbsp;r7 =3D BF01BB9C&nbsp; r6 =3D BF049944&nbsp; r5 =3D BF0499B0&nbsp;=
 r4 =3D BF0499C4</tt><br>

<tt>[&lt;c0147534&gt;] (driver_attach+0x0/0x28) from [&lt;c0146f58&gt;] (bu=
s_add_driver</tt><br>

<tt>+0x6c/0x138)</tt><br>

<tt>[&lt;c0146eec&gt;] (bus_add_driver+0x0/0x138) from [&lt;c014790c&gt;]</=
tt><br>

<tt>(driver_register+0x34/0x38)</tt><br>

<tt>[&lt;c01478d8&gt;] (driver_register+0x0/0x38) from [&lt;bf0141d8&gt;]</=
tt><br>

<tt>(pcmcia_register_driver+0xf8/0x114 [pcmcia])</tt><br>

<tt>&nbsp;r4 =3D BF04999C</tt><br>

<tt>[&lt;bf0140e0&gt;] (pcmcia_register_driver+0x0/0x114 [pcmcia]) from</tt=
><br>

<tt>[&lt;bf04b014&gt;] (init_bluecard_cs+0x14/0x1c [bluecard_cs])</tt><br>

<tt>&nbsp;r7 =3D C02218D0&nbsp; r6 =3D BF049A60&nbsp; r5 =3D BF049A60&nbsp;=
 r4 =3D C02218E0</tt><br>

<tt>[&lt;bf04b000&gt;] (init_bluecard_cs+0x0/0x1c [bluecard_cs]) from [&lt;=
c0051a74&gt;]</tt><br>

<tt>(sys_init_module+0x155c/0x16bc)</tt><br>

<tt>[&lt;c0050518&gt;] (sys_init_module+0x0/0x16bc) from [&lt;c0020d00&gt;]=
</tt><br>

<tt>(ret_fast_syscall+0x0/0x2c)</tt><br>

<br>

<br>

<tt>Many thanks in advance,</tt><br>

<tt>Itzhak</tt><br>

<br>


------=_Part_11968_26872461.1127832707304--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
