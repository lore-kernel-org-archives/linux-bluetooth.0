Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andrea Benazzo <dolphin@slacky.it>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2818761.R3ztAJzm1J";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200502031010.56642.dolphin@slacky.it>
Subject: [Bluez-users] Problem with rfcomm connect
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
Date: Thu, 3 Feb 2005 10:10:50 +0000

--nextPart2818761.R3ztAJzm1J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everyone!


I own a Belkin F8T001 as a Bluetooth device (=3D>I installed the related=20
firmware), but I get an error during the rfcomm connect command

here is my procedure (since only yesterdy I began playing with it, perhaps=
=20
there is a previous error I make)

1) bluefw usb 001/00X
2) modprobe l2cap
3) modprobe rfcomm
4) mknod /dev/rfcomm0 c 216 0
5) hciconfig hci0 up
6) hciconfig
7) hcitool scan
8) l2ping 00:01:E3:06:FB:AF
9) added the following lines to /etc/bluetooth/rfcomm.conf:

rfcomm0 {
  bind yes;
  # Bluetooth address of the device
  device 00:01:E3:06:FB:AF;
  # RFCOMM channel for the connection
  channel 0;
  # Description of the connection
  comment "S55";
 }
10) rfcomm connect rfcomm0 00:01:E3:06:FB:AF

Everything has worked perfectly till now, but this last command returns "Ca=
n't=20
connect RFCOMM socket: Resource temporarily unavailable" or "Can't connect=
=20
RFCOMM socket: Function not implemented"

only during the latest command, I launched hcidump -X to get more info of w=
hat=20
was going on (but I can't decode it's meaning alas):


HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: af fb 06 e3 01 00 18 cc  02 00 00 00 01           .......
=2E.....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 af fb 06 e3 01  00 01 00                 .).....
=2E...
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 statu
s 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen
4
    MTU 1024
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 339
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen
0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 334 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 334 max_retrans 0 credits 2
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Link Key Request (0x17) plen 6
  0000: af fb 06 e3 01 00                                 ......
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 1f                                       .)..


does anyone recognize my error?

thank you very much



Andrea Benazzo

=2D-=20
www.risingphoenix.it

--nextPart2818761.R3ztAJzm1J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCAfiwCI3r8suNd+8RApeLAKDKycnUWiHO59xocACQlxVFv0+G9ACgv6+o
lBwrj6m9HXpEC4LT0RXcSA4=
=3NCo
-----END PGP SIGNATURE-----

--nextPart2818761.R3ztAJzm1J--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
