Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 3 Aug 2006 01:31:58 -0300
From: redondos <redondos@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060803043158.GA13259@refinery.twat.com.ar>
Mime-Version: 1.0
Subject: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1176903641=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1176903641==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline


--m51xatjYGsM+13rf
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, list. This is my first post.

I just got myself a Bluetooth 1.2 USB dongle, listed by `lsusb' as:
Bus 004 Device 005: ID 1131:1001 Integrated System Solution Corp.
KY-BT100 Bluetooth Adapter

I have a Sony Ericsson Z520a phone, which incorporates a bluetooth and
infrared adapter.

I am using BlueZ (libs, utils) version 2.25 on a Gentoo system.

uname -a:
Linux refinery.twat.com.ar 2.6.16-suspend2-r8 #1 PREEMPT Mon Jul
31 19:05:52 ART 2006 i686 AMD Athlon(TM) XP 2400+ GNU/Linux

I have 3 main goals:
1) Transfer files between my computer and the phone.
2) Synchronize my PIM with the phone.
3) Use the phone as a modem to connect my laptop computer to the net
using GPRS.

I think you guys can help me with points 1) and 3), am I correct?
One step at a time, of course.=20

[obexftp]
I have tried to transfer simple text files between my computer and the
phone, but I have been unsuccessful. I am attaching a session log and
its corresponding dump for a simple file push from the PC to the phone.

[konqueror]
I have also installed kbluetoothd, which lets me browse the phone's
"filesystem" using the OBEX KIOSlave. Whenever I try to copy a file from
or to the phone using Konqueror, the file transfer dialog shows that
some bytes have been transferred, it even shows different data rates. It
is usually in the 10-20 KiB/s range. It apparently transfers some bytes
and then it stops with the message:=20

Connection error: Transport is broken

I have also tried with the FUSE OBEX module, but that didn't work. Of
course, it relies on obexftp.

Any thoughts will be greatly appreciated. Please let me know if I missed
something in the problem description.

Thanks.

--=20
redondos

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hcidump_konqueror.log"
Content-Transfer-Encoding: quoted-printable

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x51db (va=
lid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
< ACL data: handle 1 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 26 fcs 0x4f=20
      0000: 80 00 1a 10 00 0c 67 46  00 13 f9 ec 7b c4 95 3c  ......gF....{=
=2E.<
      0010: 11 d2 98 4e 52 54 00 dc  9e 09                    ...NRT....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 1 p 1 pt 0 xi 1 xo 1
      rtri 1 rtro 0 rtci 0 rtco 1 xon 70 xoff 0 pm 0xf913
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0x703f
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 31 fcs 0x89 credits 1
      0000: a0 00 1f 10 00 10 00 cb  00 00 00 01 4a 00 13 f9  ............J=
=2E..
      0010: ec 7b c4 95 3c 11 d2 98  4e 52 54 00 dc 9e 09     .{..<...NRT..=
=2E.
< ACL data: handle 1 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 25 fcs 0x4f=20
      0000: 85 00 19 02 00 cb 00 00  00 01 01 00 0f 00 4f 00  .............=
=2EO.
      0010: 74 00 68 00 65 00 72 00  00                       t.h.e.r..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
      0000: a0 00 03                                          ...
< ACL data: handle 1 flags 0x02 dlen 41
    L2CAP(d): cid 0x0040 len 37 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 33 fcs 0x4f=20
      0000: 83 00 21 cb 00 00 00 01  42 00 19 78 2d 6f 62 65  ..!.....B..x-=
obe
      0010: 78 2f 66 6f 6c 64 65 72  2d 6c 69 73 74 69 6e 67  x/folder-list=
ing
      0020: 00                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 283
    L2CAP(d): cid 0x0040 len 279 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 0 ilen 274 fcs 0x95=20
      0000: a0 01 12 cb 00 00 00 01  49 01 0a 3c 3f 78 6d 6c  ........I..<?=
xml
      0010: 20 76 65 72 73 69 6f 6e  3d 22 31 2e 30 22 20 65   version=3D"1=
=2E0" e
      0020: 6e 63 6f 64 69 6e 67 3d  22 55 54 46 2d 38 22 3f  ncoding=3D"UT=
F-8"?
      0030: 3e 0d 0a 3c 21 44 4f 43  54 59 50 45 20 66 6f 6c  >..<!DOCTYPE =
fol
      0040: 64 65 72 2d 6c 69 73 74  69 6e 67 20 53 59 53 54  der-listing S=
YST
      0050: 45 4d 20 22 6f 62 65 78  2d 66 6f 6c 64 65 72 2d  EM "obex-fold=
er-
      0060: 6c 69 73 74 69 6e 67 2e  64 74 64 22 3e 0d 0a 3c  listing.dtd">=
=2E.<
      0070: 21 2d 2d 0d 0a 20 58 4d  4c 20 43 6f 64 65 72 2c  !--.. XML Cod=
er,
      0080: 20 4e 6f 76 20 31 34 20  32 30 30 35 2c 20 32 33   Nov 14 2005,=
 23
      0090: 3a 34 31 3a 31 30 2c 20  28 43 29 20 32 30 30 31  :41:10, (C) 2=
001
      00a0: 20 53 6f 6e 79 20 45 72  69 63 73 73 6f 6e 20 4d   Sony Ericsso=
n M
      00b0: 6f 62 69 6c 65 20 43 6f  6d 6d 75 6e 69 63 61 74  obile Communi=
cat
      00c0: 69 6f 6e 73 20 41 42 20  0d 0a 2d 2d 3e 0d 0a 3c  ions AB ..-->=
=2E.<
      00d0: 66 6f 6c 64 65 72 2d 6c  69 73 74 69 6e 67 20 76  folder-listin=
g v
      00e0: 65 72 73 69 6f 6e 3d 22  31 2e 30 22 3e 3c 70 61  ersion=3D"1.0=
"><pa
      00f0: 72 65 6e 74 2d 66 6f 6c  64 65 72 2f 3e 0d 0a 3c  rent-folder/>=
=2E.<
      0100: 2f 66 6f 6c 64 65 72 2d  6c 69 73 74 69 6e 67 3e  /folder-listi=
ng>
      0110: 0d 0a                                             ..
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 8 fcs 0x4f=20
      0000: 81 00 08 cb 00 00 00 01                           ........
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 2
      0000: a0 00 03                                          ...
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x51db (va=
lid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013=20
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 1 encrypt 0x01
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88=20
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 0 fcs 0x89 credits 20
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
< ACL data: handle 1 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 26 fcs 0x4f=20
      0000: 80 00 1a 10 00 0c 67 46  00 13 f9 ec 7b c4 95 3c  ......gF....{=
=2E.<
      0010: 11 d2 98 4e 52 54 00 dc  9e 09                    ...NRT....
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 1 p 1 pt 0 xi 1 xo 1
      rtri 1 rtro 0 rtci 0 rtco 1 xon 70 xoff 0 pm 0xf913
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 3 fcs 0xaa mcc_len 1
      dlci 12 br 170 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0x703f
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 31 fcs 0x89 credits 1
      0000: a0 00 1f 10 00 10 00 cb  00 00 00 01 4a 00 13 f9  ............J=
=2E..
      0010: ec 7b c4 95 3c 11 d2 98  4e 52 54 00 dc 9e 09     .{..<...NRT..=
=2E.
< ACL data: handle 1 flags 0x02 dlen 41
    L2CAP(d): cid 0x0040 len 37 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 33 fcs 0x4f=20
      0000: 83 00 21 cb 00 00 00 01  42 00 19 78 2d 6f 62 65  ..!.....B..x-=
obe
      0010: 78 2f 66 6f 6c 64 65 72  2d 6c 69 73 74 69 6e 67  x/folder-list=
ing
      0020: 00                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 0 ilen 329 fcs 0x95=20
      0000: a0 01 7e cb 00 00 00 01  49 01 76 3c 3f 78 6d 6c  ..~.....I.v<?=
xml
      0010: 20 76 65 72 73 69 6f 6e  3d 22 31 2e 30 22 20 65   version=3D"1=
=2E0" e
      0020: 6e 63 6f 64 69 6e 67 3d  22 55 54 46 2d 38 22 3f  ncoding=3D"UT=
F-8"?
      0030: 3e 0d 0a 3c 21 44 4f 43  54 59 50 45 20 66 6f 6c  >..<!DOCTYPE =
fol
      0040: 64 65 72 2d 6c 69 73 74  69 6e 67 20 53 59 53 54  der-listing S=
YST
      0050: 45 4d 20 22 6f 62 65 78  2d 66 6f 6c 64 65 72 2d  EM "obex-fold=
er-
      0060: 6c 69 73 74 69 6e 67 2e  64 74 64 22 3e 0d 0a 3c  listing.dtd">=
=2E.<
      0070: 21 2d 2d 0d 0a 20 58 4d  4c 20 43 6f 64 65 72 2c  !--.. XML Cod=
er,
      0080: 20 4e 6f 76 20 31 34 20  32 30 30 35 2c 20 32 33   Nov 14 2005,=
 23
      0090: 3a 34 31 3a 31 30 2c 20  28 43 29 20 32 30 30 31  :41:10, (C) 2=
001
      00a0: 20 53 6f 6e 79 20 45 72  69 63 73 73 6f 6e 20 4d   Sony Ericsso=
n M
      00b0: 6f 62 69 6c 65 20 43 6f  6d 6d 75 6e 69 63 61 74  obile Communi=
cat
      00c0: 69 6f 6e 73 20 41 42 20  0d 0a 2d 2d 3e 0d 0a 3c  ions AB ..-->=
=2E.<
      00d0: 66 6f 6c 64 65 72 2d 6c  69 73 74 69 6e 67 20 76  folder-listin=
g v
      00e0: 65 72 73 69 6f 6e 3d 22  31 2e 30 22 3e 3c 66 6f  ersion=3D"1.0=
"><fo
      00f0: 6c 64 65 72 20 6e 61 6d  65 3d 22 50 69 63 74 75  lder name=3D"=
Pictu
      0100: 72 65 73 22 2f 3e 0d 0a  3c 66 6f 6c 64 65 72 20  res"/>..<fold=
er=20
      0110: 6e 61 6d 65 3d 22 53 6f  75 6e 64 73 22 2f 3e 0d  name=3D"Sound=
s"/>.
      0120: 0a 3c 66 6f 6c 64 65 72  20 6e 61 6d 65 3d 22 54  .<folder name=
=3D"T
      0130: 68 65 6d 65 73 22 2f 3e  0d 0a 3c 66 6f 6c 64 65  hemes"/>..<fo=
lde
      0140: 72 20 6e 61 6d 65 3d 22  56                       r name=3D"V
> ACL data: handle 1 flags 0x02 dlen 62
    L2CAP(d): cid 0x0040 len 58 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 53 fcs 0x89 credits 1
      0000: 69 64 65 6f 73 22 2f 3e  0d 0a 3c 66 6f 6c 64 65  ideos"/>..<fo=
lde
      0010: 72 20 6e 61 6d 65 3d 22  4f 74 68 65 72 22 2f 3e  r name=3D"Oth=
er"/>
      0020: 0d 0a 3c 2f 66 6f 6c 64  65 72 2d 6c 69 73 74 69  ..</folder-li=
sti
      0030: 6e 67 3e 0d 0a                                    ng>..
< ACL data: handle 1 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 25 fcs 0x4f=20
      0000: 85 00 19 02 00 cb 00 00  00 01 01 00 0f 00 4f 00  .............=
=2EO.
      0010: 74 00 68 00 65 00 72 00  00                       t.h.e.r..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
      0000: a0 00 03                                          ...
< ACL data: handle 1 flags 0x02 dlen 41
    L2CAP(d): cid 0x0040 len 37 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 33 fcs 0x4f=20
      0000: 02 00 21 cb 00 00 00 01  01 00 19 00 70 00 61 00  ..!.........p=
=2Ea.
      0010: 65 00 6c 00 6c 00 61 00  2e 00 74 00 78 00 74 00  e.l.l.a...t.x=
=2Et.
      0020: 00                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
      0000: 90 00 03                                          ...
< ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 11 fcs 0x4f=20
      0000: 02 0a 81 cb 00 00 00 01  48 0a 79                 ........H.y
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 31 29 20 50 52 45 50 41  52 41 52 20 45 4c 20 43  1) PREPARAR E=
L C
      0010: 41 4c 44 4f 20 28 64 65  62 65 20 72 65 6e 64 69  ALDO (debe re=
ndi
      0020: 72 20 63 6f 6e 20 68 6f  6c 67 75 72 61 20 65 6c  r con holgura=
 el
      0030: 20 64 6f 62 6c 65 20 64  65 6c 20 41 72 72 6f 7a   doble del Ar=
roz
      0040: 20 61 20 63 6f 6e 73 75  6d 69 72 2c 20 63 61 6c   a consumir, =
cal
      0050: 63 75 6c 61 6e 64 6f 20  31 20 74 61 7a 61 20 64  culando 1 taz=
a d
      0060: 65 20 61 72 72 6f 7a 20  70 6f 72 20 63 6f 6d 65  e arroz por c=
ome
      0070: 6e 73 61 6c 29 20 50 41  52 41 20 54 45 4e 45 52  nsal) PARA TE=
NER
      0080: 4c 4f 20 42 49 45 4e 20  43 41 4c 49 45 4e 54 45  LO BIEN CALIE=
NTE
      0090: 20 43 55 41 4e 44 4f 20  48 41 59 41 20 51 55 45   CUANDO HAYA =
QUE
      00a0: 20 56 45 52 54 45 52 4c  4f 2e 20 44 45 20 43 48   VERTERLO. DE=
 CH
      00b0: 41 55 43 48 41 53 20 28  4a 55 44 c3 8d 41 53 20  AUCHAS (JUD..=
AS=20
      00c0: 56 45 52 44 45 53 29 59  20 45 53 50 49 4e 41 43  VERDES)Y ESPI=
NAC
      00d0: 41 53 2e 20 28 59 20 44  45 53 50 4f 4a 4f 53 20  AS. (Y DESPOJ=
OS=20
      00e0: 44 45 20 50 45 53 43 41  44 4f 20 2b 20 43 c3 81  DE PESCADO + =
C..
      00f0: 53 43 41 52 41 53 20 6d  61 63 68 61 63 61 64 61  SCARAS machac=
ada
      0100: 73 20 61 6c 20 6d 6f 72  74 65 72 6f 20 44 45 20  s al mortero =
DE=20
      0110: 4c 41 4e 47 4f 53 54 49  4e 4f 53 20 6d 75 79 20  LANGOSTINOS m=
uy=20
      0120: 46 52 49 54 4f 53 20 43  4f 4e 20 6d 75 63 68 61  FRITOS CON mu=
cha
      0130: 20 53 41 4c 2c 20 53 49  20 4c 41 20 50 41 45 4c   SAL, SI LA P=
AEL
      0140: 4c 41 20 56 41 20 41 20  54                       LA VA A T
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 45 4e 45 52 20 55 4e 20  54 4f 51 55 45 20 4d 41  ENER UN TOQUE=
 MA
      0010: 52 49 4e 45 52 4f 20 29  2e 20 59 20 45 4c 20 43  RINERO ). Y E=
L C
      0020: 4f 4e 44 49 4d 45 4e 54  4f 20 3a 20 31 20 43 55  ONDIMENTO : 1=
 CU
      0030: 43 48 41 52 41 44 49 54  41 20 44 45 20 50 49 4d  CHARADITA DE =
PIM
      0040: 45 4e 54 c3 93 4e 20 44  55 4c 43 45 20 2b 20 31  ENT..N DULCE =
+ 1
      0050: 2f 32 20 44 45 20 50 49  4d 45 4e 54 c3 93 4e 20  /2 DE PIMENT.=
=2EN=20
      0060: 50 49 43 41 4e 54 45 20  6f 20 41 6a c3 ad 20 2b  PICANTE o Aj.=
=2E +
      0070: 20 32 20 44 45 20 43 75  72 63 75 6d 61 20 6f 20   2 DE Curcuma=
 o=20
      0080: 66 61 6c 73 6f 20 61 7a  61 66 72 c3 a1 6e 20 2b  falso azafr..=
n +
      0090: 20 31 20 63 61 62 65 7a  61 20 64 65 20 41 6a 6f   1 cabeza de =
Ajo
      00a0: 20 6d 61 63 68 61 63 61  64 6f 20 73 6f 62 72 65   machacado so=
bre
      00b0: 20 75 6e 20 62 75 65 6e  20 70 75 c3 b1 61 64 6f   un buen pu..=
ado
      00c0: 20 64 65 20 73 61 6c 2c  20 64 69 6c 75 69 64 6f   de sal, dilu=
ido
      00d0: 73 20 65 6e 20 31 20 74  61 7a 61 20 64 65 6c 20  s en 1 taza d=
el=20
      00e0: 63 61 6c 64 6f 2e 20 0a  0a 32 29 20 46 52 45 49  caldo. ..2) F=
REI
      00f0: 52 20 28 53 49 45 4d 50  52 45 20 43 4f 4e 20 4f  R (SIEMPRE CO=
N O
      0100: 4c 49 56 41 29 20 70 72  69 6d 65 72 6f 20 3a 20  LIVA) primero=
 :=20
      0110: 65 6c 20 73 6f 66 72 69  74 6f 20 28 20 65 6c 20  el sofrito ( =
el=20
      0120: 70 69 63 61 64 6f 20 46  69 6e 6f 20 64 65 20 33  picado Fino d=
e 3
      0130: 20 43 65 62 6f 6c 6c 61  73 20 6d 65 64 69 61 6e   Cebollas med=
ian
      0140: 61 73 20 2b 20 32 20 70  69                       as + 2 pi
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 6d 69 65 6e 74 6f 73 20  72 6f 6a 6f 73 20 2d 20  mientos rojos=
 -=20
      0010: 6d 6f 72 72 6f 6e 65 73  20 2d 20 2b 20 31 20 63  morrones - + =
1 c
      0020: 61 62 65 7a 61 20 64 65  20 61 6a 6f 29 20 68 61  abeza de ajo)=
 ha
      0030: 73 74 61 20 69 6e 69 63  69 6f 20 64 65 20 64 6f  sta inicio de=
 do
      0040: 72 61 64 6f 20 65 6e 20  6c 61 20 63 65 62 6f 6c  rado en la ce=
bol
      0050: 6c 61 20 73 65 67 75 6e  64 6f 20 3a 20 6c 61 73  la segundo : =
las
      0060: 20 76 65 72 64 75 72 61  73 20 79 20 73 65 6d 69   verduras y s=
emi
      0070: 6c 6c 61 73 20 68 61 73  74 61 20 63 61 6d 62 69  llas hasta ca=
mbi
      0080: 6f 20 64 65 20 63 6f 6c  6f 72 20 74 65 72 63 65  o de color te=
rce
      0090: 72 6f 20 79 20 66 69 6e  61 6c 20 3a 20 65 6c 20  ro y final : =
el=20
      00a0: 61 72 72 6f 7a 2c 20 72  65 6d 6f 76 69 65 6e 64  arroz, removi=
end
      00b0: 6f 6c 6f 20 73 75 61 76  65 20 79 20 70 6f 63 6f  olo suave y p=
oco
      00c0: 2c 20 68 61 73 74 61 20  76 65 72 6c 6f 20 75 6e  , hasta verlo=
 un
      00d0: 74 61 64 6f 20 2d 20 62  72 69 6c 6c 61 6e 74 65  tado - brilla=
nte
      00e0: 20 2d 74 72 61 6e 73 70  61 72 65 6e 74 65 2e 20   -transparent=
e.=20
      00f0: 44 75 72 61 6e 74 65 20  65 73 74 6f 73 20 70 61  Durante estos=
 pa
      0100: 73 6f 73 20 74 65 6e 65  72 20 65 6e 20 63 75 65  sos tener en =
cue
      0110: 6e 74 61 20 71 75 65 20  3a 20 73 65 20 72 65 74  nta que : se =
ret
      0120: 69 72 61 6e 20 79 20 72  65 73 65 72 76 61 6e 20  iran y reserv=
an=20
      0130: 65 6c 20 73 6f 66 72 69  74 6f 20 79 20 6c 75 65  el sofrito y =
lue
      0140: 67 6f 20 6c 6f 73 20 6f  74                       go los ot
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 72 6f 73 20 6d 61 74 65  72 69 61 6c 65 73 2c 20  ros materiale=
s,=20
      0010: 70 65 72 6f 20 65 6c 20  61 72 72 6f 7a 20 73 65  pero el arroz=
 se
      0020: 20 71 75 65 64 61 20 79  20 61 6c 20 66 69 6e 61   queda y al f=
ina
      0030: 6c 20 73 65 20 70 65 69  6e 61 20 79 20 61 70 6c  l se peina y =
apl
      0040: 61 6e 61 20 70 61 72 65  6a 6f 3b 20 6c 75 65 67  ana parejo; l=
ueg
      0050: 6f 20 73 65 20 73 69 65  6d 62 72 61 20 79 20 65  o se siembra =
y e
      0060: 73 70 61 72 63 65 20 70  72 6f 70 6f 72 63 69 6f  sparce propor=
cio
      0070: 6e 61 64 61 6d 65 6e 74  65 20 74 6f 64 6f 20 6c  nadamente tod=
o l
      0080: 6f 20 72 65 74 69 72 61  64 6f 20 79 20 72 65 73  o retirado y =
res
      0090: 65 72 76 61 64 6f 20 61  6e 74 65 73 2e 20 59 20  ervado antes.=
 Y=20
      00a0: 71 75 65 20 4e 4f 20 73  65 20 70 72 65 74 65 6e  que NO se pre=
ten
      00b0: 64 65 20 43 4f 43 49 4e  41 52 20 43 4f 4d 50 4c  de COCINAR CO=
MPL
      00c0: 45 54 41 4d 45 4e 54 45  20 4e 41 44 41 2c 20 73  ETAMENTE NADA=
, s
      00d0: 69 6e 6f 20 54 45 c3 91  49 52 20 65 6c 20 61 63  ino TE..IR el=
 ac
      00e0: 65 69 74 65 20 63 6f 6e  20 6c 6f 73 20 67 75 73  eite con los =
gus
      00f0: 74 6f 73 20 64 65 20 6c  6f 20 66 72 65 c3 ad 64  tos de lo fre=
=2E.d
      0100: 6f 20 70 61 72 61 20 4d  41 4e 43 48 41 52 20 63  o para MANCHA=
R c
      0110: 6f 6e 20 65 6c 6c 6f 73  20 61 6c 20 61 72 72 6f  on ellos al a=
rro
      0120: 7a 2e 20 50 6f 72 20 6c  6f 20 71 75 65 20 73 69  z. Por lo que=
 si
      0130: 20 73 65 20 63 6f 6e 73  75 6d 65 20 65 6c 20 61   se consume e=
l a
      0140: 63 65 69 74 65 20 6e 6f  20                       ceite no=20
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 64 75 64 65 20 65 6e 20  61 67 72 65 67 61 72 20  dude en agreg=
ar=20
      0010: 75 6e 20 70 6f 63 6f 20  6d c3 a1 73 2e 2e 2e 20  un poco m..s.=
=2E.=20
      0020: 0a 0a 33 29 56 45 52 54  45 4d 4f 53 20 61 6c 67  ..3)VERTEMOS =
alg
      0030: 6f 20 64 65 20 63 61 6c  64 6f 2c 20 72 65 70 61  o de caldo, r=
epa
      0040: 72 74 69 6d 6f 73 20 6c  61 20 74 61 7a 61 20 64  rtimos la taz=
a d
      0050: 65 20 43 4f 4e 44 49 4d  45 4e 54 4f 20 79 20 74  e CONDIMENTO =
y t
      0060: 65 72 6d 69 6e 61 6d 6f  73 20 64 65 20 61 67 72  erminamos de =
agr
      0070: 65 67 61 72 20 65 6c 20  72 65 73 74 6f 20 64 65  egar el resto=
 de
      0080: 6c 20 43 41 4c 44 4f 28  74 6f 74 61 6c 3d 20 64  l CALDO(total=
=3D d
      0090: 6f 62 6c 65 20 64 65 6c  20 61 72 72 6f 7a 20 6d  oble del arro=
z m
      00a0: 65 6e 6f 73 20 61 6c 67  6f 20 71 75 65 20 74 72  enos algo que=
 tr
      00b0: 61 65 6e 20 6c 61 73 20  76 65 72 64 75 72 61 73  aen las verdu=
ras
      00c0: 29 2e 20 46 75 65 67 6f  20 76 69 76 6f 20 79 20  ). Fuego vivo=
 y=20
      00d0: 64 65 73 64 65 20 65 6c  20 68 65 72 76 6f 72 2c  desde el herv=
or,
      00e0: 20 73 6f 6e 20 31 34 2d  31 35 20 6d 69 6e 75 74   son 14-15 mi=
nut
      00f0: 6f 73 20 2e 20 50 61 73  61 64 6f 73 20 6c 6f 73  os . Pasados =
los
      0100: 20 31 30 20 70 72 69 6d  65 72 6f 73 20 70 72 6f   10 primeros =
pro
      0110: 62 61 72 20 28 73 69 6e  20 72 65 6d 6f 76 65 72  bar (sin remo=
ver
      0120: 20 6e 61 64 61 21 29 20  79 20 63 6f 72 72 65 67   nada!) y cor=
reg
      0130: 69 72 20 6c 6f 20 71 75  65 20 68 61 67 61 20 66  ir lo que hag=
a f
      0140: 61 6c 74 61 20 3a 20 73  61                       alta : sa
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 6c 2c 20 70 69 63 61 6e  74 65 2c 20 63 61 6c 64  l, picante, c=
ald
      0010: 6f 2e 2e 2e 44 45 42 45  20 53 45 4e 54 49 52 53  o...DEBE SENT=
IRS
      0020: 45 20 45 4c 20 43 52 45  50 49 54 41 52 20 44 45  E EL CREPITAR=
 DE
      0030: 4c 20 46 49 4e 41 4c 20  44 45 20 4c 41 20 43 4f  L FINAL DE LA=
 CO
      0040: 43 43 49 c3 93 4e 20 59  20 41 4c 47 4f 20 44 45  CCI..N Y ALGO=
 DE
      0050: 20 4f 4c 4f 52 20 41 20  51 55 45 4d 41 44 4f 20   OLOR A QUEMA=
DO=20
      0060: 3a 20 61 68 c3 ad 20 61  70 61 67 61 72 20 65 6c  : ah.. apagar=
 el
      0070: 20 66 75 65 67 6f 20 79  20 63 75 62 72 69 72 20   fuego y cubr=
ir=20
      0080: 63 6f 6e 20 75 6e 20 72  65 70 61 73 61 64 6f 72  con un repasa=
dor
      0090: 20 70 6f 72 20 35 20 6d  69 6e 75 74 6f 73 20 70   por 5 minuto=
s p
      00a0: 61 72 61 20 71 75 65 20  73 65 20 63 75 65 7a 61  ara que se cu=
eza
      00b0: 20 61 6c 20 76 61 70 6f  72 20 6c 6f 20 64 65 20   al vapor lo =
de=20
      00c0: 61 72 72 69 62 61 2e 20  0a 0a 50 65 67 75 65 20  arriba. ..Peg=
ue=20
      00d0: 65 6c 20 67 72 69 74 6f  20 64 65 20 71 75 65 20  el grito de q=
ue=20
      00e0: 79 61 20 65 73 74 c3 a1  20 6c 69 73 74 61 2c 20  ya est.. list=
a,=20
      00f0: 79 20 63 6f 72 74 65 20  75 6e 61 73 20 66 69 6e  y corte unas =
fin
      0100: 61 73 20 72 6f 64 61 6a  61 73 20 64 65 20 4c 69  as rodajas de=
 Li
      0110: 6d c3 b3 6e 20 73 61 6a  61 6e 64 6f 20 31 20 72  m..n sajando =
1 r
      0120: 61 64 69 6f 20 70 61 72  61 20 69 6e 73 65 72 74  adio para ins=
ert
      0130: 61 72 6c 61 73 20 65 6e  20 65 6c 20 62 6f 72 64  arlas en el b=
ord
      0140: 65 20 64 65 20 6c 61 20  70                       e de la p
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 61 65 6c 6c 61 20 63 75  61 6e 64 6f 20 76 61 79  aella cuando =
vay
      0010: 61 20 61 20 73 65 72 76  69 72 2e 20 41 6e 74 65  a a servir. A=
nte
      0020: 73 20 64 65 20 74 61 70  61 72 20 6c 61 20 70 61  s de tapar la=
 pa
      0030: 65 6c 6c 61 20 70 75 65  64 65 20 64 65 63 6f 72  ella puede de=
cor
      0040: 61 72 6c 61 20 63 6f 6e  20 6c 61 73 20 63 68 61  arla con las =
cha
      0050: 75 63 68 61 73 20 64 65  6c 20 63 61 6c 64 6f 20  uchas del cal=
do=20
      0060: 79 20 63 6f 6e 20 74 69  72 69 74 61 73 20 64 65  y con tiritas=
 de
      0070: 20 70 69 6d 69 65 6e 74  6f 73 20 72 6f 6a 6f 73   pimientos ro=
jos
      0080: 20 79 20 6e 61 72 61 6e  6a 61 20 63 72 75 64 6f   y naranja cr=
udo
      0090: 73 20 6f 20 64 65 20 63  6f 6c 20 6d 6f 72 61 64  s o de col mo=
rad
      00a0: 61 20 63 72 75 64 61 20  64 69 73 70 75 65 73 74  a cruda dispu=
est
      00b0: 6f 73 20 72 61 64 69 61  6c 6d 65 6e 74 65 20 63  os radialment=
e c
      00c0: 6f 6e 73 69 67 75 69 65  6e 64 6f 20 6c 61 20 69  onsiguiendo l=
a i
      00d0: 6d 61 67 65 6e 20 64 65  20 75 6e 61 20 72 75 65  magen de una =
rue
      00e0: 64 61 20 64 65 20 63 6f  6c 6f 72 2e 20 53 69 20  da de color. =
Si=20
      00f0: 6c 65 20 76 61 20 61 20  61 67 72 65 67 61 72 20  le va a agreg=
ar=20
      0100: 66 72 75 74 6f 73 20 73  65 63 6f 73 20 28 6f 72  frutos secos =
(or
      0110: 65 6a 6f 6e 65 73 2c 20  63 69 72 75 65 6c 61 73  ejones, cirue=
las
      0120: 20 70 61 73 61 2c 20 68  69 67 6f 73 20 73 65 63   pasa, higos =
sec
      0130: 6f 73 2c 20 65 74 63 2e  29 20 6f 20 73 65 74 61  os, etc.) o s=
eta
      0140: 73 20 73 65 63 61 73 2c  20                       s secas,=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< ACL data: handle 1 flags 0x02 dlen 338
    L2CAP(d): cid 0x0040 len 334 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 329 fcs 0x4f=20
      0000: 64 65 62 65 72 c3 a1 20  68 61 62 65 72 6c 6f 73  deber.. haber=
los
      0010: 20 74 65 6e 69 64 6f 20  65 6e 20 72 65 6d 6f 6a   tenido en re=
moj
      0020: 6f 20 75 6e 61 20 62 75  65 6e 61 20 6d 65 64 69  o una buena m=
edi
      0030: 61 20 68 6f 72 61 20 61  6e 74 65 73 20 28 63 75  a hora antes =
(cu
      0040: 61 6e 64 6f 20 65 6d 70  69 65 63 65 20 61 20 70  ando empiece =
a p
      0050: 72 65 70 61 72 61 72 20  65 6c 20 63 61 6c 64 6f  reparar el ca=
ldo
      0060: 29 2c 20 65 20 69 6e 63  6f 72 70 6f 72 61 72 6c  ), e incorpor=
arl
      0070: 6f 73 20 6d 75 79 20 61  6c 20 66 69 6e 61 6c 20  os muy al fin=
al=20
      0080: 79 20 65 6e 20 6d 6f 64  65 73 74 61 20 63 61 6e  y en modesta =
can
      0090: 74 69 64 61 64 20 70 61  72 61 20 71 75 65 20 6e  tidad para qu=
e n
      00a0: 6f 20 61 70 6c 61 73 74  65 6e 20 6c 6f 73 20 6f  o aplasten lo=
s o
      00b0: 74 72 6f 73 20 73 61 62  6f 72 65 73 3b 20 73 69  tros sabores;=
 si
      00c0: 20 6c 6f 73 20 72 65 6d  6f 6a 61 20 65 6e 20 61   los remoja e=
n a
      00d0: 67 75 61 72 64 69 65 6e  74 65 20 6f 20 70 69 73  guardiente o =
pis
      00e0: 63 6f 20 6f 20 73 69 6d  69 6c 61 72 20 6f 62 74  co o similar =
obt
      00f0: 65 6e 64 72 c3 a1 20 67  75 73 74 6f 73 20 6d 75  endr.. gustos=
 mu
      0100: 79 20 70 61 72 74 69 63  75 6c 61 72 65 73 2e 20  y particulare=
s.=20
      0110: 50 65 72 6f 20 65 73 74  6f 73 20 73 6f 6e 20 64  Pero estos so=
n d
      0120: 65 74 61 6c 6c 65 73 20  3a 20 65 6c 20 67 75 73  etalles : el =
gus
      0130: 74 6f 20 79 20 6c 6f 73  20 63 6f 6c 6f 72 65 73  to y los colo=
res
      0140: 20 64 65 20 6c 61 73 20  76                        de las v
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hcidump_obexftp.log"
Content-Transfer-Encoding: quoted-printable

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:16:20:F1:47:68 mode 1 clkoffset 0x282f class 0x520204
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x282f (va=
lid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
    Error: Page Timeout
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:20:F1:47:68 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:F1:47:68
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:F1:47:68 key E0FBDF5E3EF4241A247AAFCD6331E97E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:F1:47:68
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:20:F1:47:68 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0e
    Link policy: HOLD SNIFF PARK=20
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="obex.log"
Content-Transfer-Encoding: quoted-printable

redondos@refinery.twat.com.ar ~ $ file gprs.txt=20
gprs.txt: ASCII text
redondos@refinery.twat.com.ar ~ $ hcitool scan
Scanning ...
	00:16:20:F1:47:68	Z520a
redondos@refinery.twat.com.ar ~ $ obexftp -v -b 00:16:20:F1:47:68 -p gprs.t=
xt=20
Failed to connect to SDP server: Host is down
redondos@refinery.twat.com.ar ~ $ obexftp -v -b 00:16:20:F1:47:68 -l
Failed to connect to SDP server: Connection timed out
redondos@refinery.twat.com.ar ~ $ l2ping 00:16:20:F1:47:68
Can't create socket: Operation not permitted
redondos@refinery.twat.com.ar ~ $ sudo l2ping 00:16:20:F1:47:68
Ping: 00:16:20:F1:47:68 from 00:11:67:5E:B3:04 (data size 44) ...
44 bytes from 00:16:20:F1:47:68 id 0 time 86.49ms
44 bytes from 00:16:20:F1:47:68 id 1 time 151.78ms
44 bytes from 00:16:20:F1:47:68 id 2 time 98.56ms
44 bytes from 00:16:20:F1:47:68 id 3 time 100.86ms
4 sent, 4 received, 0% loss

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Z520a_SDP.txt"

Inquiring ...
Browsing 00:16:20:F1:47:68 ...
Service Description: Sony Ericsson Z520
Service RecHandle: 0x10000
Service Class ID List:
  "PnP Information" (0x1200)

Service Name: Dial-up Networking
Service RecHandle: 0x10001
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: Serial Port
Service RecHandle: 0x10002
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2

Service Name: HF Voice Gateway
Service RecHandle: 0x10003
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Service Name: HS Voice Gateway
Service RecHandle: 0x10004
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10005
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX File Transfer
Service RecHandle: 0x10006
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: OBEX SyncML Client
Service RecHandle: 0x10007
Service Class ID List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
  "OBEX" (0x0008)

Service Name: OBEX IrMC Sync Server
Service RecHandle: 0x10008
Service Class ID List:
  "IrMC Sync" (0x1104)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
  "OBEX" (0x0008)
Profile Descriptor List:
  "IrMC Sync" (0x1104)
    Version: 0x0100

Service Name: Mouse & Keyboard
Service Description: Remote Control
Service Provider: Sony Ericsson
Service RecHandle: 0x10009
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100


--O5XBE6gyVG5Rl6Rj--

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD4DBQFE0Xw+JZ/yCc25j3IRAq7UAJdxfgWluTUTJMXWWyCvklfexReDAKCzs5rF
alGyvEP0d2wFLmV0gzK3MQ==
=+qTk
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--


--===============1176903641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1176903641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1176903641==--
