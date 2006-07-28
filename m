Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 28 Jul 2006 12:37:24 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060728123724.47e76a7f@localhost.localdomain>
In-Reply-To: <1154051769.7650.20.camel@localhost>
References: <E65CD2CAB74C80498703D6EF7624BB4C023974A7@zmaex.zma.zoran.com>
	<1154051769.7650.20.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary=Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC
Subject: Re: [Bluez-users] Hci Reset Problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I guess I'm approaching the same or at least a related problem. I don't
feel like getting close the root of the problem yet but maybe the
attached output helps marcel or someone else to see clearer.

I can't pretend that the reset in the attached log is not beeing sent from a
user-application but i felt like the oops is worth posting.

Kernel used is 2.6.8.1 but i know that the thing happens also with 2.6.17.6.

Hardware used:

hci1:   Type: USB
        BD Address: 00:02:5B:00:BF:66 ACL MTU: 384:8 SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI
        BD Address: 00:02:5B:00:BF:66 ACL MTU: 384:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>=20
                <timing accuracy> <role switch> <hold mode> <sniff mode>=20
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packe=
ts>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme=
>=20
                <power control> <transparent SCO> <broadcast encrypt>=20
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>=20
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>=20
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>=
=20
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>=20
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>=20
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>=20

I don't expect any feedback on this, I'll post in this thread if I find any=
thing..

Greetings

Andy


On Fri, 28 Jul 2006 03:56:09 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Lan,
>=20
> > I try to setup openobex on my linux, but each time I send out obex
> > connect request, instead of getting a connect response, the device will
> > be reset, HCIDUMP is like below:
> >=20
> > ...
> > ...
> > ...
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 41 flags 0x02 dlen 8
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18
> > < ACL data: handle 41 flags 0x02 dlen 12
> >     L2CAP(d): cid 0x0040 len 8 [psm 3]
> >       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
> >       dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> > > ACL data: handle 41 flags 0x02 dlen 12
> >     L2CAP(d): cid 0x0040 len 8 [psm 3]
> >       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
> >       dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> > < ACL data: handle 41 flags 0x02 dlen 12
> >     L2CAP(d): cid 0x0040 len 8 [psm 3]
> >       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
> >       dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 41 flags 0x02 dlen 12
> >     L2CAP(d): cid 0x0040 len 8 [psm 3]
> >       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
> >       dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> > < ACL data: handle 41 flags 0x02 dlen 9
> >     L2CAP(d): cid 0x0040 len 5 [psm 3]
> >       RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93 credits 33
> > < ACL data: handle 41 flags 0x02 dlen 34
> >     L2CAP(d): cid 0x0040 len 30 [psm 3]
> >       RFCOMM(d): UIH: cr 1 dlci 6 pf 0 ilen 26 fcs 0x8f
> >         OBEX: Connect cmd(f): len 26 version 1.1 flags 0 mtu 1024
> >         Target (0x46) =3D Sequence length 16
> > < HCI Command: Reset (0x03|0x0003) plen 0
> >=20
> > The system I have is Linux 2.6.9-34, bluez-lib-2.25 and bluez-util-2.25,
> > bluez-hcidump-1.30, and openobex-1.0.1 version. I don't know who send
> > this reset, and why.=20
>=20
> the reset is really strange. It comes from our side. What does
> "hciconfig -a" say about your dongle.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


--=20
--=20
mit freundlichen Gr=FC=DFen / best regards,

Andreas Gaufer

Office: +49 951-700428-91
Fax: 	+49 951-700428-87
Mail: 	Andreas.Gaufer@bluecellnetworks.com

I fully agree with RFC 1855


--Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC
Content-Type: text/plain; name=oops_TestHost.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=oops_TestHost.txt

########### dmesg        ###############

hci_acl_tx_to: hci2 ACL tx timeout
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c015531f
*pde = 00000000
Oops: 0000 [#3]
PREEMPT 
Modules linked in: ftdi_sio usbserial uhci_hcd agpgart cryptoloop loop rfcomm l2cap hci_usb bluetooth 
usbcore tun rtc
CPU:    0
EIP:    0060:[<c015531f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17.6 #3) 
EIP is at pipe_writev+0xdf/0x3f0
eax: 00000000   ebx: c38ba9e0   ecx: 00000000   edx: 00000000
esi: 00000016   edi: 00000016   ebp: c5972d28   esp: c46a9f18
ds: 007b   es: 007b   ss: 0068
Process sed (pid: 18895, threadinfo=c46a8000 task=c5464ab0)
Stack: c013af4e 00000000 c39a0b7c 00000000 00000000 00000016 00000000 00000000 
       c5972c00 c6464698 c38ba9e0 00000016 b7f81000 c46a9fa4 c0155655 c38ba9e0 
       c46a9f64 00000001 c46a9fa4 b7f81000 00000016 c0149cb8 c38ba9e0 b7f81000 
Call Trace:
 <c013af4e> do_anonymous_page+0x10e/0x140  <c0155655> pipe_write+0x25/0x30
 <c0149cb8> vfs_write+0x88/0x120  <c0149dfb> sys_write+0x3b/0x70
 <c0102d87> syscall_call+0x7/0xb 
Code: 0f 84 d5 00 00 00 03 42 0c 48 83 e0 0f 6b c0 14 8d 6c 10 10 8b 4d 0c 89 4c 24 10 8b 45 08 89 44 24 0c 
8b 55 04 01 d0 89 44 24 0c <83> 39 00 0f 84 a7 00 00 00 01 f8 3d 00 10 00 00 0f 87 9a 00 00 
EIP: [<c015531f>] pipe_writev+0xdf/0x3f0 SS:ESP 0068:c46a9f18
 <6>usb 1-1.3: configuration #1 chosen from 1 choice
hub 1-1:1.0: port 4 disabled by hub (EMI?), re-enabling...
usb 1-1.4: USB disconnect, address 18
usb 1-1.4: new full speed USB device using uhci_hcd and address 21
usb 1-1.4: configuration #1 chosen from 1 choice
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c015531f
*pde = 00000000
Oops: 0000 [#4]
PREEMPT 
Modules linked in: ftdi_sio usbserial uhci_hcd agpgart cryptoloop loop rfcomm l2cap hci_usb bluetooth 
usbcore tun rtc
CPU:    0
EIP:    0060:[<c015531f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17.6 #3) 
EIP is at pipe_writev+0xdf/0x3f0
eax: 00000000   ebx: c11834a0   ecx: 00000000   edx: 00000000
esi: 00000016   edi: 00000016   ebp: c4f4c728   esp: c4c37f18
ds: 007b   es: 007b   ss: 0068
Process sed (pid: 19026, threadinfo=c4c36000 task=c1155ad0)
Stack: c013af4e 00000000 c51d3b7c 00000000 00000000 00000016 00000000 00000000 
       c4f4c600 c6df3344 c11834a0 00000016 b7f72000 c4c37fa4 c0155655 c11834a0 
       c4c37f64 00000001 c4c37fa4 b7f72000 00000016 c0149cb8 c11834a0 b7f72000 
Call Trace:
 <c013af4e> do_anonymous_page+0x10e/0x140  <c0155655> pipe_write+0x25/0x30
 <c0149cb8> vfs_write+0x88/0x120  <c0149dfb> sys_write+0x3b/0x70
 <c0102d87> syscall_call+0x7/0xb 
Code: 0f 84 d5 00 00 00 03 42 0c 48 83 e0 0f 6b c0 14 8d 6c 10 10 8b 4d 0c 89 4c 24 10 8b 45 08 89 44 24 0c 
8b 55 04 01 d0 89 44 24 0c <83> 39 00 0f 84 a7 00 00 00 01 f8 3d 00 10 00 00 0f 87 9a 00 00 
EIP: [<c015531f>] pipe_writev+0xdf/0x3f0 SS:ESP 0068:c4c37f18


########### In the Shell ###############


< ACL data: handle 48 flags 0x02 dlen 339
    L2CAP(d): cid 0x03a1 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 330 fcs 0x4f 
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Reset (0x03|0x0003) plen 0
Receive failed: Broken pipe
root@TestHost:~# 
Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: PREEMPT 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: EIP is at pipe_writev+0xdf/0x3f0

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: Oops: 0000 [#1]

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: CPU:    0

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: eax: 00000000   ebx: c3d96da0   ecx: 00000000   edx: 00000000

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: esi: 00000016   edi: 00000016   ebp: c5972928   esp: c2d71f18

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: Process sed (pid: 18063, threadinfo=c2d70000 task=c3b495d0)

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: Stack: c013af4e 00000000 c4050b7c 00000000 00000000 00000016 00000000 000000
00 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel:        c5972800 c6eb2228 c3d96da0 00000016 b7f8a000 c2d71fa4 c0155655 c3d96d
a0 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel:        c2d71f64 00000001 c2d71fa4 b7f8a000 00000016 c0149cb8 c3d96da0 b7f8a0
00 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: Call Trace:

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel:  <c013af4e> do_anonymous_page+0x10e/0x140  <c0155655> pipe_write+0x25/0x30

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel:  <c0149cb8> vfs_write+0x88/0x120  <c0149dfb> sys_write+0x3b/0x70

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel:  <c0102d87> syscall_call+0x7/0xb 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: Code: 0f 84 d5 00 00 00 03 42 0c 48 83 e0 0f 6b c0 14 8d 6c 10 10 8b 4d 0c 8
9 4c 24 10 8b 45 08 89 44 24 0c 8b 55 04 01 d0 89 44 24 0c <83> 39 00 0f 84 a7 00 00 00 01 f8
 3d 00 10 00 00 0f 87 9a 00 00 

Message from syslogd@TestHost at Fri Jul 28 12:05:41 2006 ...
TestHost kernel: EIP: [<c015531f>] pipe_writev+0xdf/0x3f0 SS:ESP 0068:c2d71f18


--Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Multipart_Fri__28_Jul_2006_12_37_24_+0200_N_ChpsepapbZzxfC--
