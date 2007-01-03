Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167844461.20568.18.camel@violet>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost> <1167816533.20568.12.camel@violet>
	<1167843929.3164.1.camel@localhost> <1167844461.20568.18.camel@violet>
Date: Wed, 03 Jan 2007 15:04:21 -0500
Message-Id: <1167854661.3145.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1628380893=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1628380893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rERxkWiZGXuFWYLcEEir"


--=-rERxkWiZGXuFWYLcEEir
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-01-03 at 18:14 +0100, Marcel Holtmann wrote:
> did you reload the driver or reboot your system? This would have been
> the first Broadcom chip where the values are correct. Can you
> check /sys/class/module/parameters/* that no quirk is actually active.

Oops, my bad! When I restored my original modprobe file it had my
initial force scofix quirk in it.

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN=20
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

The session dump is:
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:EE:E0:AB:CA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:12:EE:E0:AB:CA type ACL encrypt 0x00
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 12 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK=20
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 12
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:12:EE:E0:AB:CA mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 100=20
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 4
      Success
      MTU 100=20
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:12:EE:E0:AB:CA name 'HBH-610a'
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0051 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 27
> ACL data: handle 12 flags 0x01 dlen 27
> ACL data: handle 12 flags 0x01 dlen 27
> ACL data: handle 12 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 102 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x61
          count 94
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "SonyEricsson Headset Service"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 1 status 1
      Connection pending - Authentication pending
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:12:EE:E0:AB:CA
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:12:EE:E0:AB:CA key FDA84C7E01635351CE60FF683AEDE32F
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:12:EE:E0:AB:CA
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 4
      MTU 1013=20
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 56=20
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      Success
      MTU 56=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 51 max_retrans 0 credits 7
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 50 max_retrans 0 credits 0
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59=20
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 12 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0052 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 20
      0000: 41 54 2a 45 43 42 50 3d  3f 0d                    AT*ECBP=3D?.
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40=20
      0000: 41 54 2b 43 4c 49 50 3d  31 0d                    AT+CLIP=3D1.
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 26
    L2CAP(d): cid 0x0041 len 22 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 16 fcs 0x5c credits 1
      0000: 41 54 2b 43 53 43 53 3d  22 55 54 46 2d 38 22 0d  AT
+CSCS=3D"UTF-8".
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> ACL data: handle 12 flags 0x02 dlen 27
> ACL data: handle 12 flags 0x01 dlen 5
    L2CAP(d): cid 0x0041 len 28 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 22 fcs 0x5c credits 1
      0000: 41 54 2a 53 45 41 4d 3d  22 48 42 48 2d 36 31 30
AT*SEAM=3D"HBH-610
      0010: 61 22 2c 31 33 0d                                 a",13.
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 9 fcs 0x5c credits 1
      0000: 41 54 2b 43 4c 41 4e 3f  0d                       AT+CLAN?.
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 3
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x02 interval 2048
    Mode: Sniff
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 12 ptype 0x00e0
    Packet type: HV1 HV2 HV3=20
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:12:EE:E0:AB:CA type SCO encrypt 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:12:EE:E0:AB:CA mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:12:EE:E0:AB:CA name 'HBH-610a'
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 9 fcs 0x5c credits 2
      0000: 41 54 2b 56 47 53 3d 36  0d                       AT+VGS=3D6.
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0052 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a=20
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x00 interval 0
    Mode: Active
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0x0080
    Packet type: HV3=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x02 interval 2048
    Mode: Sniff

Same end results with aplay hanging.

Cheers,

Jon.

--=-rERxkWiZGXuFWYLcEEir
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFnAxFu2cEic/xsEARAm4nAJ9VxWNU4GP7pVXLPTrlMH4lEVJfFgCg4M9c
9sXD2XVZCRHeqDH323xIFg8=
=FP0o
-----END PGP SIGNATURE-----

--=-rERxkWiZGXuFWYLcEEir--



--===============1628380893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1628380893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1628380893==--
