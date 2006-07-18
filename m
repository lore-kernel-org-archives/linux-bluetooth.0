Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Kamil =?iso-8859-2?q?Kami=F1ski?= <kamilkaminski@1liceum.pl>
To: bluez-devel@lists.sourceforge.net
References: <200607171807.03528.kamilkaminski@1liceum.pl>
	<1153220114.4639.19.camel@localhost>
In-Reply-To: <1153220114.4639.19.camel@localhost>
MIME-Version: 1.0
Date: Tue, 18 Jul 2006 16:37:21 +0200
Message-Id: <200607181639.36560.kamilkaminski@1liceum.pl>
Subject: Re: [Bluez-devel] Bluex 3.x pairing devices
Reply-To: Kamil =?iso-8859-2?q?Kami=F1ski?= <kamilkaminski@1liceum.pl>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1028384038=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1028384038==
Content-Type: multipart/signed; boundary="nextPart2420484.Z5cSmEPUe6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2420484.Z5cSmEPUe6
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia wtorek, 18 lipca 2006 12:55, napisa=B3e=B6:
> Hi Kamil,
>
> > Maybe this question is stupid, but.. how to pair devices using blueZ 3.x
> > (have latest) and kde 3.5.x (svn)? Since I have installed 3.x I cannot
> > pair devices anymore. My friend hace the same problem, but he simply
> > deletes keyfile and other made by hcid and then pairing works (once)...=
 I
> > cannot :/ Is there my problem or something with kde / blueZ? :>
>
> show us the output of "hcidump -X -V" when the pairing fails.
>
> Regards
>
> Marcel

Here it is :-) :
=2D------------------------------------------------------------------------=
=2D------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0F:DE:EB:B6:D4 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr 00:0F:DE:EB:B6:D4 type ACL encrypt 0x00
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 43 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1013
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 43
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0F:DE:EB:B6:D4 mode 2 clkoffset 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xff 0x3b 0x01 0x00 0x00 0x00 0x00 0x00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0F:DE:EB:B6:D4 name 'Kamil's K700i'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 14 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 14 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0F:DE:EB:B6:D4
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:0F:DE:EB:B6:D4
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:0F:DE:EB:B6:D4
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x2c
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0046 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0046 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 14 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 14 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0046 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x2c
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0046 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 14 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 14 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
=2D------------------------------------------------------------------------=
=2D--
Phone is asking for the passkey and telling me that I've typed wrong one...=
=20
all the time... (Computer is not even trying to ask for a password). I had=
=20
this problem on old blueZ with DBUS enabled, but now DBUS is the only metho=
d=20
(I think) of authorization...
Regards,
Kamil
=2D-=20
// Kamil Kami=F1ski // kamilkaminski@1liceum.pl // mrblur // mr.blur@wp.pl =
//
// GG: 4136690    // Jabber: mrblur@chrome.pl // Skype: kamilkaminski87  //
// ICQ: 195874088 // Tlen: mrblur // Tel: 506471821 // MSN: mrblur@wp.pl //
// Idea: There are three kinds of lies: Lies, Damn Lies, and Statistics. //

--nextPart2420484.Z5cSmEPUe6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBEvPKn5DG9fCDGmXoRAnffAKCX1ZnGQr0pxIEZY8jWKK1vbB2KNQCcCuAN
qtynMAwzqQOy2HaVSQ4Ojw0=
=I9Jd
-----END PGP SIGNATURE-----

--nextPart2420484.Z5cSmEPUe6--


--===============1028384038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1028384038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1028384038==--
