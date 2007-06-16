Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <002201c7b01f$82d8a7a0$0601a8c0@shuttle>
From: "Jeppe Frandsen" <jeppe@fralle.dk>
To: <bluez-devel@lists.sourceforge.net>
References: <mailman.30991.1181967487.376.bluez-devel@lists.sourceforge.net>
Date: Sat, 16 Jun 2007 16:06:18 +0200
MIME-Version: 1.0
Subject: Re: [Bluez-devel] SDP problem with some Sony Ericsson phones.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2140809342=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============2140809342==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001F_01C7B030.4649A9E0"

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C7B030.4649A9E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your answer :o)

No, I only wanted to connect the K800i to my access point as I have =
heard it has PANU support=20
but I guess that is wrong. Should I still however not be able to =
discover the NAP service on the=20
access point or? Thanks once again.

Kind Regards,

Jeppe F.

>=20
> Hello,
>=20
> what are you trying to achive? Connect K710i and K800i to PAN access=20
> point and use its network resources? That won't work, as they lack=20
> PANU - client side of PAN profile. The K series only has NAP side=20
> implemented, whit which they only share Packed Switched data to one=20
> client - e.g. your computer. The SE smarpthones, namely P990i, M600i =
and=20
> W950i all have full PAN profile support, they can be either GN, NAP or =

> PANU.
>=20
> br,
> m
>=20
> On Fri, 15 Jun 2007, Jeppe Frandsen wrote:
>=20
> > Hi,
> >=20
> > I have a SDP problem with some Sony Ericsson phones (e.g. K710i and =
K800i) on my home made bluetooth access point running bluez-libs-2.25 =
and bluez-utils-2.25. My W950i phone (running Symbian UIQ3) and my =
computer (Windows 2000) with a Hama bluetooth USB dongle works perfect =
and I am able to discover the NAP service on the access point (see the =
hcidump below) and connect to it.=20
> >=20
> > When I i.e. pair a K800i phone with the access point and afterwards =
try to list the services the phone says that no services are found. I =
can however see that the K800i phone (see the hcidump further down) is =
using another way of discovering services which could be the problem. =
But it actually looks like the access point is answering back to the =
phone with a SDP SSA response. =20
> >=20
> > Is this a problem in the SDP part of bluez or is it something in the =
Sony Ericsson phones? If it is a bluez problem does anyone know how to =
solve this issue?
> >=20
> > Thank you very much for the help :o)
> >=20
> >=20
> > Kind Regards,
> >=20
> > Jeppe F.
> >=20
> > Pairing and service discovery with Hama bluetooth dongle (working =
case):
> > > HCI Event: Connect Request (0x04) plen 10
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Role Change (0x12) plen 8
> > > HCI Event: Link Key Request (0x17) plen 6
> > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > > HCI Event: Command Complete (0x0e) plen 10
> > > HCI Event: PIN Code Request (0x16) plen 6
> > < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> > > HCI Event: Command Complete (0x0e) plen 10
> > > HCI Event: Link Key Notification (0x18) plen 23
> > > HCI Event: Connect Complete (0x03) plen 11
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > > HCI Event: Command Complete (0x0e) plen 6
> > < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > > HCI Event: Max Slots Change (0x1b) plen 3
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 1 scid 0x0040
> > < ACL data: handle 256 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> >       Connection successful
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 10
> >     L2CAP(s): Info req: type 2
> > < ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Info rsp: type 2 result 1
> >       Not supported
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> >       Success
> > < ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 18
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
> >       Success
> >       MTU 672
> > > HCI Event: Encrypt Change (0x08) plen 4
> > > HCI Event: Role Change (0x12) plen 8
> > > HCI Event: Encrypt Change (0x08) plen 4
> > > ACL data: handle 256 flags 0x02 dlen 17
> >     L2CAP(d): cid 0x0040 len 13 [psm 1]
> >         SDP SS Req: tid 0x1 len 0x8
> >           pat uuid-16 0x0001 (SDP)
> >           max 65535
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 18
> >     L2CAP(d): cid 0x0040 len 14 [psm 1]
> >         SDP SS Rsp: tid 0x1 len 0x9
> >           count 1
> >           handle 0x0
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 17
> >     L2CAP(d): cid 0x0040 len 13 [psm 1]
> >         SDP SS Req: tid 0x2 len 0x8
> >           pat uuid-16 0x0100 (L2CAP)
> >           max 65535
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 18
> >     L2CAP(d): cid 0x0040 len 14 [psm 1]
> >         SDP SS Rsp: tid 0x2 len 0x9
> >           count 1
> >           handle 0x10000
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 21
> >     L2CAP(d): cid 0x0040 len 17 [psm 1]
> >         SDP SA Req: tid 0x3 len 0xc
> >           handle 0x10000
> >           max 1024
> >           aid(s) 0x0001 (SrvClassIDList)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 22
> >     L2CAP(d): cid 0x0040 len 18 [psm 1]
> >         SDP SA Rsp: tid 0x3 len 0xd
> >           count 10
> > 0          aid 0x001 (SrvClassIDList)
> >              < uuid-16 0x1116 (NAP) >
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > < ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 1 scid 0x0041
> > < ACL data: handle 256 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> >       Connection successful
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
> >       Success
> > < ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 18
> >     L2CAP(s): Config rsp: scid 0x%4.4x flags 0x40 result 0 clen 0
> >       Success
> >       MTU 672
> > > ACL data: handle 256 flags 0x02 dlen 17
> >     L2CAP(d): cid 0x0040 len 13 [psm 1]
> >         SDP SS Req: tid 0x1 len 0x8
> >           pat uuid-16 0x0100 (L2CAP)
> >           max 65535
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 18
> >     L2CAP(d): cid 0x0041 len 14 [psm 1]
> >         SDP SS Rsp: tid 0x1 len 0x9
> >           count 1
> >           handle 0x10000
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 21
> >     L2CAP(d): cid 0x0040 len 17 [psm 1]
> >         SDP SA Req: tid 0x2 len 0xc
> >           handle 0x10000
> >           max 1024
> >           aid(s) 0x0001 (SrvClassIDList)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 22
> >     L2CAP(d): cid 0x0041 len 18 [psm 1]
> >         SDP SA Rsp: tid 0x2 len 0xd
> >           count 10
> >           aid 0x0001 (SrvClassIDList)
> >              < uuid-16 0x1116 (NAP) >
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >=20
> >=20
> > Pairing and discovery with Sony Ericsson K800i phone (not working =
case):
> >=20
> > > HCI Event: Connect Request (0x04) plen 10
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Role Change (0x12) plen 8
> > > HCI Event: Link Key Request (0x17) plen 6
> > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > > HCI Event: Command Complete (0x0e) plen 10
> > > HCI Event: Connect Complete (0x03) plen 11
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > > HCI Event: Command Complete (0x0e) plen 6
> > < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > > HCI Event: Max Slots Change (0x1b) plen 3
> > > ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 1 scid 0x0040
> > < ACL data: handle 256 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> >       Connection successful
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 16
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 1500
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> >       Success
> > < ACL data: handle 256 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> >       Success
> > > ACL data: handle 256 flags 0x02 dlen 33
> >     L2CAP(d): cid 0x0040 len 29 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x18
> >           pat uuid-16 0x1108 (Headset)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName) 0x0302 (unknown)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 33
> >     L2CAP(d): cid 0x0040 len 29 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x18
> >           pat uuid-16 0x111e (Handsfree)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName) 0x0311 (unknown)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 36
> >     L2CAP(d): cid 0x0040 len 32 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x1b
> >           pat uuid-16 0x1105 (OBEXObjPush)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)s) =
0x0100 (SrvName) 0x0303 (SuppFormatsList)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 33
> >     L2CAP(d): cid 0x0040 len 29 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x18
> >           pat uuid-16 0x1106 (OBEXObjTrnsf)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0009 (BTProfileDescList) 0x0100 (SrvName)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 33
> >     L2CAP(d): cid 0x0040 len 29 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x18
> >           pat uuid-16 0x1107 (IRMCSyncCmd)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0009 (BTProfileDescList) 0x0100 (SrvName)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 44
> >     L2CAP(d): cid 0x0040 len 40 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x23
> >           pat uuid-128 00000001-0000-1000-8000-0002ee000002
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 30
> >     L2CAP(d): cid 0x0040 len 26 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x15
> >           pat uuid-16 0x1101 (SP)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 42
> >     L2CAP(d): cid 0x0040 len 38 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x21
> >           pat uuid-16 0x1102 (LAN)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0101 =
(SrvDesc) 0x0200 (Ver
> > sionNumList)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 42
> >     L2CAP(d): cid 0x0040 len 38 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x21
> >           pat uuid-16 0x1113 (WAP)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0009 (BTProfileDescList) =
0x0100 (SrvName) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) =
0x0309 (unknown)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 54
> >     L2CAP(d): cid 0x0040 len 50 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x2d
> >           pat uuid-16 0x1113 (WAP)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
> > 0x0101 (SrvDesc) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) =
0x0309 (unknown)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 45
> >     L2CAP(d): cid 0x0040 len 41 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x24
> >           pat uuid-16 0x1115 (PANU)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
> > 0x0101 (SrvDesc) 0x030a (SecurityDescription)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 54
> >     L2CAP(d): cid 0x0040 len 50 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x2d
> >           pat uuid-16 0x1116 (NAP)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
> > 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a =
(SecurityDescription) 0x030b (NetAccessType) 0x030c (MaxNetAccessRate)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 92
> >     L2CAP(d): cid 0x0040 len 88 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x53
> >           count 80
> >           record #0
> >               aid 0x0001 (SrvClassIDList)
> >                  < uuid-16 0x1116 (NAP) >
> >               aid 0x0004 (ProtocolDescList)
> >                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
> >                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint =
0x806 > > >
> >               aid 0x0009 (BTProfileDescList)
> >                  < < uuid-16 0x1116 (NAP) uint 0x100 > >
> >               aid 0x0100 (SrvName)
> >                  str "Network Access Point"
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 256 flags 0x02 dlen 48
> >     L2CAP(d): cid 0x0040 len 44 [psm 1]
> >         SDP SSA Req: tid 0x1 len 0x27
> >           pat uuid-16 0x1117 (GN)
> >           max 1500
> >           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
> > 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a =
(SecurityDescription)
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > < ACL data: handle 256 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0040 len 10 [psm 1]
> >         SDP SSA Rsp: tid 0x1 len 0x5
> >           count 2
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > HCI Event: Disconn Complete (0x05) plen 4
> > 
------=_NextPart_000_001F_01C7B030.4649A9E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank you for your answer =
:o)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>No, I only wanted&nbsp;to connect the =
K800i to my=20
access point as I have heard it has </FONT><FONT face=3DArial =
size=3D2>PANU=20
</FONT><FONT face=3DArial size=3D2>support </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>but I guess that is wrong. =
S</FONT><FONT face=3DArial=20
size=3D2>hould I still however not be able to discover the NAP service =
on=20
</FONT><FONT face=3DArial size=3D2>the </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>access point or? Thanks once =
again.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kind Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Jeppe F.</FONT></DIV><BR><FONT =
face=3DArial=20
size=3D2>&gt; <BR>&gt; Hello,<BR>&gt; <BR>&gt; what are you trying to =
achive?=20
Connect K710i and K800i to PAN access <BR>&gt; point and use its network =

resources? That won't work, as they lack <BR>&gt; PANU - client side of =
PAN=20
profile. The K series only has NAP side <BR>&gt; implemented, whit which =
they=20
only share Packed Switched data to one <BR>&gt; client - e.g. your =
computer. The=20
SE smarpthones, namely P990i, M600i and <BR>&gt; W950i all have full PAN =
profile=20
support, they can be either GN, NAP or <BR>&gt; PANU.<BR>&gt; <BR>&gt;=20
br,<BR>&gt; m<BR>&gt; <BR>&gt; On Fri, 15 Jun 2007, Jeppe Frandsen=20
wrote:<BR>&gt; <BR>&gt; &gt; Hi,<BR>&gt; &gt; <BR>&gt; &gt; I have a SDP =
problem=20
with some Sony Ericsson phones (e.g. K710i and K800i) on my home made =
bluetooth=20
access point running bluez-libs-2.25 and bluez-utils-2.25. My W950i =
phone=20
(running Symbian UIQ3) and my computer (Windows 2000) with a Hama =
bluetooth USB=20
dongle works perfect and I am able to discover the NAP service on the =
access=20
point (see the hcidump below) and connect to it. <BR>&gt; &gt; <BR>&gt; =
&gt;=20
When I i.e. pair a K800i phone with the access point and afterwards try =
to list=20
the services the phone says that no services are found. I can however =
see that=20
the K800i phone (see the hcidump further down) is using another way of=20
discovering services which could be the problem. But it actually looks =
like the=20
access point is answering back to the phone with a SDP SSA =
response.&nbsp;=20
<BR>&gt; &gt; <BR>&gt; &gt; Is this a problem in the SDP part of bluez =
or is it=20
something in the Sony Ericsson phones? If it is a bluez problem does =
anyone know=20
how to solve this issue?<BR>&gt; &gt; <BR>&gt; &gt; Thank you very much =
for the=20
help :o)<BR>&gt; &gt; <BR>&gt; &gt; <BR>&gt; &gt; Kind Regards,<BR>&gt; =
&gt;=20
<BR>&gt; &gt; Jeppe F.<BR>&gt; &gt; <BR>&gt; &gt; Pairing and service =
discovery=20
with Hama bluetooth dongle (working case):<BR>&gt; &gt; &gt; HCI Event: =
Connect=20
Request (0x04) plen 10<BR>&gt; &gt; &lt; HCI Command: Accept Connection =
Request=20
(0x01|0x0009) plen 7<BR>&gt; &gt; &gt; HCI Event: Command Status (0x0f) =
plen=20
4<BR>&gt; &gt; &gt; HCI Event: Role Change (0x12) plen 8<BR>&gt; &gt; =
&gt; HCI=20
Event: Link Key Request (0x17) plen 6<BR>&gt; &gt; &lt; HCI Command: =
Link Key=20
Request Reply (0x01|0x000b) plen 22<BR>&gt; &gt; &gt; HCI Event: Command =

Complete (0x0e) plen 10<BR>&gt; &gt; &gt; HCI Event: PIN Code Request =
(0x16)=20
plen 6<BR>&gt; &gt; &lt; HCI Command: PIN Code Request Reply =
(0x01|0x000d) plen=20
23<BR>&gt; &gt; &gt; HCI Event: Command Complete (0x0e) plen 10<BR>&gt; =
&gt;=20
&gt; HCI Event: Link Key Notification (0x18) plen 23<BR>&gt; &gt; &gt; =
HCI=20
Event: Connect Complete (0x03) plen 11<BR>&gt; &gt; &lt; HCI Command: =
Write Link=20
Policy Settings (0x02|0x000d) plen 4<BR>&gt; &gt; &gt; HCI Event: =
Command=20
Complete (0x0e) plen 6<BR>&gt; &gt; &lt; HCI Command: Change Connection =
Packet=20
Type (0x01|0x000f) plen 4<BR>&gt; &gt; &gt; HCI Event: Command Status =
(0x0f)=20
plen 4<BR>&gt; &gt; &gt; HCI Event: Connection Packet Type Changed =
(0x1d) plen=20
5<BR>&gt; &gt; &gt; HCI Event: Max Slots Change (0x1b) plen 3<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 12<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Connect req: psm 1 scid 0x0040<BR>&gt; &gt; &lt; ACL data: =
handle 256=20
flags 0x02 dlen 16<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): =
Connect rsp:=20
dcid 0x0040 scid 0x0040 result 0 status 0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; =
&gt; &gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; &gt; &gt; =
ACL data:=20
handle 256 flags 0x02 dlen 10<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(s):=20
Info req: type 2<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen=20
12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 =
result=20
1<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not supported<BR>&gt; =
&gt;=20
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; &gt; =
&gt; ACL=20
data: handle 256 flags 0x02 dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =

L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<BR>&gt; &gt; &lt; =
ACL data:=20
handle 256 flags 0x02 dlen 14<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(s):=20
Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; &gt; &lt; ACL =
data:=20
handle 256 flags 0x02 dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(s):=20
Config req: dcid 0x0040 flags 0x00 clen 0<BR>&gt; &gt; &gt; HCI Event: =
Number of=20
Completed Packets (0x13) plen 5<BR>&gt; &gt; &gt; HCI Event: Number of =
Completed=20
Packets (0x13) plen 5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 =
dlen=20
18<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x0040 flags=20
0x00 result 0 clen 4<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Success<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672<BR>&gt; =
&gt;=20
&gt; HCI Event: Encrypt Change (0x08) plen 4<BR>&gt; &gt; &gt; HCI =
Event: Role=20
Change (0x12) plen 8<BR>&gt; &gt; &gt; HCI Event: Encrypt Change (0x08) =
plen=20
4<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 17<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 =
len=20
0x8<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat=20
uuid-16 0x0001 (SDP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
18<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 14 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 =
len=20
0x9<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 1<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
handle 0x0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 17<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 13 [psm 1]<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x2 =
len=20
0x8<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat=20
uuid-16 0x0100 (L2CAP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
18<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 14 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x2 =
len=20
0x9<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 1<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
handle 0x10000<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 21<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 17 [psm 1]<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x3 =
len=20
0xc<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
handle 0x10000<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1024<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 22<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 18 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x3 =
len=20
0xd<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 10<BR>&gt; &gt; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid 0x001 (SrvClassIDList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP) &gt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 12<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<BR>&gt; &gt; &lt; ACL =
data:=20
handle 256 flags 0x02 dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(s):=20
Disconn rsp: dcid 0x0040 scid 0x0040<BR>&gt; &gt; &gt; HCI Event: Number =
of=20
Completed Packets (0x13) plen 5<BR>&gt; &gt; &gt; ACL data: handle 256 =
flags=20
0x02 dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: =
psm 1=20
scid 0x0041<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
16<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid =
0x0041=20
result 0 status 0<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Connection=20
successful<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets =
(0x13) plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 12<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags =
0x00 clen=20
0<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags =
0x00 result=20
0 clen 0<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Success<BR>&gt; &gt;=20
&lt; ACL data: handle 256 flags 0x02 dlen 12<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags =
0x00 clen=20
0<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 18<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Config rsp: scid 0x%4.4x flags 0x40 result 0 clen 0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672<BR>&gt; &gt; &gt; ACL =
data:=20
handle 256 flags 0x02 dlen 17<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(d): cid=20
0x0040 len 13 [psm 1]<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 =
len=20
0x8<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat=20
uuid-16 0x0100 (L2CAP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
18<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 =
len=20
0x9<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 1<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
handle 0x10000<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 21<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 17 [psm 1]<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x2 =
len=20
0xc<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
handle 0x10000<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1024<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 22<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 18 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 =
len=20
0xd<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 10<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid =
0x0001=20
(SrvClassIDList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP) &gt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt;=20
<BR>&gt; &gt; <BR>&gt; &gt; Pairing and discovery with Sony Ericsson =
K800i phone=20
(not working case):<BR>&gt; &gt; <BR>&gt; &gt; &gt; HCI Event: Connect =
Request=20
(0x04) plen 10<BR>&gt; &gt; &lt; HCI Command: Accept Connection Request=20
(0x01|0x0009) plen 7<BR>&gt; &gt; &gt; HCI Event: Command Status (0x0f) =
plen=20
4<BR>&gt; &gt; &gt; HCI Event: Role Change (0x12) plen 8<BR>&gt; &gt; =
&gt; HCI=20
Event: Link Key Request (0x17) plen 6<BR>&gt; &gt; &lt; HCI Command: =
Link Key=20
Request Reply (0x01|0x000b) plen 22<BR>&gt; &gt; &gt; HCI Event: Command =

Complete (0x0e) plen 10<BR>&gt; &gt; &gt; HCI Event: Connect Complete =
(0x03)=20
plen 11<BR>&gt; &gt; &lt; HCI Command: Write Link Policy Settings =
(0x02|0x000d)=20
plen 4<BR>&gt; &gt; &gt; HCI Event: Command Complete (0x0e) plen =
6<BR>&gt; &gt;=20
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen =
4<BR>&gt;=20
&gt; &gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; &gt; &gt; HCI =
Event:=20
Connection Packet Type Changed (0x1d) plen 5<BR>&gt; &gt; &gt; HCI =
Event: Max=20
Slots Change (0x1b) plen 3<BR>&gt; &gt; &gt; ACL data: handle 256 flags =
0x02=20
dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm =
1 scid=20
0x0040<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen 16<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid =
0x0040=20
result 0 status 0<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Connection=20
successful<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets =
(0x13) plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 16<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags =
0x00 clen=20
4<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1500<BR>&gt; &gt; =
&lt;=20
ACL data: handle 256 flags 0x02 dlen 14<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&gt; &gt; &lt; ACL =
data:=20
handle 256 flags 0x02 dlen 12<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
L2CAP(s):=20
Config req: dcid 0x0040 flags 0x00 clen 0<BR>&gt; &gt; &gt; HCI Event: =
Number of=20
Completed Packets (0x13) plen 5<BR>&gt; &gt; &gt; HCI Event: Number of =
Completed=20
Packets (0x13) plen 5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 =
dlen=20
14<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x0040 flags=20
0x00 result 0 clen 0<BR>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Success<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen =
33<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x18<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1108 (Headset)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 =
(SrvName) 0x0302=20
(unknown)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 33<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x18<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x111e (Handsfree)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 =
(SrvName) 0x0311=20
(unknown)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 36<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 32 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x1b<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1105 (OBEXObjPush)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)s) 0x0100 =
(SrvName)=20
0x0303 (SuppFormatsList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 33<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x18<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1106 (OBEXObjTrnsf)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009=20
(BTProfileDescList) 0x0100 (SrvName)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 33<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x18<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1107 (IRMCSyncCmd)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009=20
(BTProfileDescList) 0x0100 (SrvName)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 44<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 40 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x23<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-128 00000001-0000-1000-8000-0002ee000002<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100=20
(SrvName)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 30<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 26 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x15<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1101 (SP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100=20
(SrvName)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 42<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 38 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x21<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1102 (LAN)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0008 =
(SrvAvail)=20
0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0101 (SrvDesc) 0x0200 =
(Ver<BR>&gt;=20
&gt; sionNumList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 42<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 38 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x21<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1113 (WAP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0009 (BTProfileDescList) 0x0100 =
(SrvName)=20
0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) 0x0309 =
(unknown)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 54<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 50 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x2d<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1113 (WAP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006=20
(LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 =

(SrvName)<BR>&gt; &gt; 0x0101 (SrvDesc) 0x0306 (unknown) 0x0307 =
(unknown) 0x0308=20
(unknown) 0x0309 (unknown)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 45<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 41 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x24<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1115 (PANU)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006=20
(LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 =

(SrvName)<BR>&gt; &gt; 0x0101 (SrvDesc) 0x030a =
(SecurityDescription)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; ACL data: handle 256 flags 0x02 dlen 54<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 50 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x2d<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1116 (NAP)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006=20
(LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 =

(SrvName)<BR>&gt; &gt; 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a=20
(SecurityDescription) 0x030b (NetAccessType) 0x030c =
(MaxNetAccessRate)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 92<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 88 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x53<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 80<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record=20
#0<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
aid 0x0001 (SrvClassIDList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP) &gt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
aid 0x0004 (ProtocolDescList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; &lt; uuid-16 0x0100 (L2CAP) uint 0xf &gt; &lt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
uuid-16 0x000f (BNEP) uint 0x100 &lt; uint 0x800 uint 0x806 &gt; &gt;=20
&gt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
aid 0x0009 (BTProfileDescList)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; &lt; uuid-16 0x1116 (NAP) uint 0x100 &gt; &gt;<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
aid 0x0100 (SrvName)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
str "Network Access Point"<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
&gt; &gt;=20
ACL data: handle 256 flags 0x02 dlen 48<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 44 [psm 1]<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid =
0x1 len=20
0x27<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1117 (GN)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006=20
(LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 =

(SrvName)<BR>&gt; &gt; 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a=20
(SecurityDescription)<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
&gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<BR>&gt; =

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid =
0x1 len=20
0x5<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 2<BR>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) =
plen=20
5<BR>&gt; &gt; &gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>&gt;=20
&gt; &gt; HCI Event: Disconn Complete (0x05) plen 4<BR>&gt; &gt;=20
</FONT></BODY></HTML>

------=_NextPart_000_001F_01C7B030.4649A9E0--



--===============2140809342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2140809342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2140809342==--
