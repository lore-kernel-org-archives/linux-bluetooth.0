Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9c68c0a70512230043j2de1d4ccx@mail.gmail.com>
From: liang liping <lianglip@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] option "--activesync" and "--msdun"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Dec 2005 16:43:57 +0800

Hi
Can option "--activesync" and "--msdun" in "dund"  work  in  kernel
2.4.18  which has
patched patch-2.4.18-mh15.gz ?

I run the command on my arm linux:

"dund --listen --msdun -a -n call dun"

then I used a ms smartphone to conncet to my usb adaptor.
I got the following outputs:

dund[60]: Bluetooth DUN daemon version 2.21
dund[65]: New connection from 00:09:2D:12:FE:86
using channel 1
Using interface ppp0
Connect: ppp0 <--> /dev/bluetooth/rfcomm/0
sent [LCP ConfReq id=3D0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accom=
p>]
rcvd [LCP ConfReq id=3D0x0 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=3D0x0 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=3D0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accom=
p>]
rcvd [LCP ConfAck id=3D0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accom=
p>]
sent [IPCP ConfReq id=3D0x1 <addr 192.168.55.100> <compress VJ 0f 01>]
rcvd [CCP ConfReq id=3D0x0 < 12 06 00 00 00 01>]
sent [CCP ConfReq id=3D0x1]
sent [CCP ConfRej id=3D0x0 < 12 06 00 00 00 01>]
rcvd [IPCP ConfReq id=3D0x0 <compress VUnable to handle kernel NULL
pointer dereference at virtual address 00000000
pgd =3D c0004000
*pgd =3D 00000000, *pmd =3D 00000000
Internal error: Oops: ffffffff
CPU: 0
pc : [<c00274b8>]    lr : [<c00275c0>]    Not tainted
sp : c03cfcc8  ip : 00000001  fp : c03cfce8
r10: 00000020  r9 : 80000093  r8 : c3dabd6c
r7 : c03fe0a0  r6 : 00001000  r5 : 00000004  r4 : 00000004
r3 : 00000000  r2 : c3dabd6c  r1 : 000001f1  r0 : 000001f1
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C000317F  Table: 33B44000  DAC: 0000001D
Process krfcommd (pid: 9, stackpage=3Dc03cf000)
Stack: (0xc03cfcb8 to 0xc03d0000)
fca0:                                                       c00275c0 c00274=
b8
fcc0: 20000093 ffffffff 00000004 00000004 c3dabd60 c03fe0a0 c03659e0 c03cfc=
f8
fce0: c03cfcec c00275c0 c0027498 c03cfd18 c03cfcfc c0029fc0 c00275bc 000000=
04
fd00: 00000001 c03cfd8c c03fe0a0 c03cfd68 c03cfd1c c002a248 c0029f84 c03cfd=
6c
fd20: c03cfd64 00000001 00000010 00000000 c03ec800 c03cfd60 c03cfd44 c49204=
0c
fd40: c03fe0a0 c3d7ea44 c03cfd8c 00000001 00000025 00000000 c03ec800 c03cfd=
88
fd60: c03cfd6c c0029bd8 c002a174 c3d7e9c4 c3d7ea44 00000025 c3d7ea44 c03cfd=
ac
fd80: c03cfd8c c0029d60 c0029b9c 33d7ea44 c3d7ea44 c3d7ec54 303c5240 000000=
00
fda0: c03cfde4 c03cfdb0 c010562c c0029d18 00000001 00000000 00000040 000000=
01
fdc0: c3d7ec54 303c5240 c4910240 00000001 c03ec800 c3dabd20 c03cfe2c c03cfd=
e8
fde0: c0104198 c0105570 00000020 00000003 00000000 40000013 00000001 c48b07=
00
fe00: 303c5240 c3d7ec40 c0395000 c3d7ec54 00000000 00000000 c0363c84 000000=
1d
fe20: c03cfe3c c03cfe30 c00faf34 c0103cd0 c03cfe64 c03cfe40 c0119ae8 c00faf=
04
fe40: c0395194 c03cfe64 c0394440 c0395194 c0395000 00000000 c03cfe88 c03cfe=
68
fe60: c0119e5c c0119a9c c0395160 c0395000 c03cfec0 00000000 60000013 c03cfe=
a0
fe80: c03cfe8c c0119fe0 c0119bc4 c0394440 c0395000 c03cfeb8 c03cfea4 c01799=
44
fea0: c0119ec8 c3d7e640 c0395000 c03cfee0 c03cfebc c017a028 c0179898 c03944=
40
fec0: 00000004 c0395088 00000000 c01da080 00000000 c03cff00 c03cfee4 c0034d=
2c
fee0: c0179e94 00000001 c01da0d8 fffffff7 c0213bc0 c03cff24 c03cff04 c0034a=
d0
ff00: c0034cd0 c3b1a080 c0213bc0 0000001d c0213bc8 c03cff70 c03cff64 c03cff=
28
ff20: c0021668 c0034a64 c3b1a0b4 00000000 c3b1a0b8 00000008 c03cfedc c017f5=
40
ff40: c03cff68 c03cff70 0000001d c3b4f400 c03ce000 c3d7e5f8 c03cffa8 c03cff=
68
ff60: c01828fc c017f410 c3d7eae2 00000000 00000000 00000000 c03cff68 000000=
01
ff80: 00000000 00000000 00000000 c3d7e5c0 c03943a0 c3d7e5cc c0363c60 c03cff=
e0
ffa0: c03cffac c0184544 c01828b0 c0363c84 c0363520 04000000 c03ce000 c0239d=
04
ffc0: c020c118 c020c100 c01dac40 41129200 30017aa0 c03cfff4 c03cffe4 c01849=
00
ffe0: c01840d0 00000000 00000000 c03cfff8 c0022a30 c0184880 00500040 001800=
02
Backtrace:
Function entered at [<c0027488>] from [<c00275c0>]
 r8 =3D C03659E0  r7 =3D C03FE0A0  r6 =3D C3DABD60  r5 =3D 00000004
 r4 =3D 00000004
Function entered at [<c00275ac>] from [<c0029fc0>]
Function entered at [<c0029f74>] from [<c002a248>]
 r7 =3D C03FE0A0  r6 =3D C03CFD8C  r5 =3D 00000001  r4 =3D 00000004
Function entered at [<c002a164>] from [<c0029bd8>]
Function entered at [<c0029b8c>] from [<c0029d60>]
 r6 =3D C3D7EA44  r5 =3D 00000025  r4 =3D C3D7EA44
Function entered at [<c0029d08>] from [<c010562c>]
 r7 =3D 00000000  r6 =3D 303C5240  r5 =3D C3D7EC54  r4 =3D C3D7EA44
Function entered at [<c0105560>] from [<c0104198>]
Function entered at [<c0103cc0>] from [<c00faf34>]
Function entered at [<c00faef4>] from [<c0119ae8>]
Function entered at [<c0119a8c>] from [<c0119e5c>]
 r7 =3D 00000000  r6 =3D C0395000  r5 =3D C0395194  r4 =3D C0394440
Function entered at [<c0119bb4>] from [<c0119fe0>]
 r8 =3D 60000013  r7 =3D 00000000  r6 =3D C03CFEC0  r5 =3D C0395000
 r4 =3D C0395160
Function entered at [<c0119eb8>] from [<c0179944>]
 r5 =3D C0395000  r4 =3D C0394440
Function entered at [<c0179888>] from [<c017a028>]
 r5 =3D C0395000  r4 =3D C3D7E640
Function entered at [<c0179e84>] from [<c0034d2c>]
 r7 =3D 00000000  r6 =3D C01DA080  r5 =3D 00000000  r4 =3D C0395088
Function entered at [<c0034cc0>] from [<c0034ad0>]
 r7 =3D C0213BC0  r6 =3D FFFFFFF7  r5 =3D C01DA0D8  r4 =3D 00000001
Function entered at [<c0034a54>] from [<c0021668>]
 r8 =3D C03CFF70  r7 =3D C0213BC8  r6 =3D 0000001D  r5 =3D C0213BC0
 r4 =3D C3B1A080
Function entered at [<c017f400>] from [<c01828fc>]
Function entered at [<c01828a0>] from [<c0184544>]
 r7 =3D C0363C60  r6 =3D C3D7E5CC  r5 =3D C03943A0  r4 =3D C3D7E5C0
Function entered at [<c01840c0>] from [<c0184900>]
Function entered at [<c0184870>] from [<c0022a30>]
 r4 =3D 00000000
Code: e083300c e1a08002 e3530000 13a03000 (15833000)
J 0f 01> <addr 0K0.0.0> <ms-dns1e 0.0.0.0r <ms-wins 0.0.0n0> <ms-dns3
0.0e0.0> <ms-wins 0l0.0.0>]
sent [ PCP ConfRej id=3Dpx0 <ms-wins 0.0a0.0> <ms-wins 0n0.0.0>]
rcvd [iroto=3D0x8057] 01c00 00 0e 01 0a :1 d8 a2 29 4b 4  b5 67
UnsuppoAted protocol 0xi057 received
sent [LCP ProtRejeid=3D0x2 80 57 01,00 00 0e 01 0a  1 d8 a2 29 4b 4k8 b5 67=
]i
                                                                     =20
    rcvd [IPCP ConlAck id=3D0x1 <addl 192.168.55.100i <]ng interrupt
handler!
In interrupt handler - not syncing


Thank you!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
