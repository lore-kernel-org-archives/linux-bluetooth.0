Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <000e01c79b13$94d9e3e0$0601a8c0@shuttle>
From: "Jeppe Frandsen" <jeppe@fralle.dk>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 20 May 2007 21:18:00 +0200
MIME-Version: 1.0
Subject: [Bluez-users] SDP problem with some Sony Ericsson phones.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0937156214=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0937156214==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C79B24.58414930"

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C79B24.58414930
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a SDP problem with some Sony Ericsson phones (e.g. K710i and =
K800i) on my home made bluetooth access point running bluez-libs-2.25 =
and bluez-utils-2.25. My W950i phone (running Symbian UIQ3) and my =
computer (Windows 2000) with a Hama bluetooth USB dongle works perfect =
and I am able to discover the NAP service on the access point (see the =
hcidump below) and connect to it.=20

When I i.e. pair a K800i phone with the access point and afterwards try =
to list the services the phone says that no services are found. I can =
however see that the K800i phone (see the hcidump further down) is using =
another way of discovering services which could be the problem. But it =
actually looks like the access point is answering back to the phone with =
a SDP SSA response. =20

Is this a problem in the SDP part of bluez or is it something in the =
Sony Ericsson phones? If it is a bluez problem does anyone know how to =
solve this issue?

Thank you very much for the help :o)


Kind Regards,

Jeppe F.

Pairing and service discovery with Hama bluetooth dongle (working case):
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Link Key Notification (0x18) plen 23
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 256 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
> HCI Event: Encrypt Change (0x08) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Encrypt Change (0x08) plen 4
> ACL data: handle 256 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x0001 (SDP)
          max 65535
          cont 00
< ACL data: handle 256 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x2 len 0x8
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          cont 00
< ACL data: handle 256 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x3 len 0xc
          handle 0x10000
          max 1024
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SA Rsp: tid 0x3 len 0xd
          count 10
0          aid 0x001 (SrvClassIDList)
             < uuid-16 0x1116 (NAP) >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x%4.4x flags 0x40 result 0 clen 0
      Success
      MTU 672
> ACL data: handle 256 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          cont 00
< ACL data: handle 256 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 1024
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 22
    L2CAP(d): cid 0x0041 len 18 [psm 1]
        SDP SA Rsp: tid 0x2 len 0xd
          count 10
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1116 (NAP) >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5


Pairing and discovery with Sony Ericsson K800i phone (not working case):

> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 256 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1500
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 256 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Req: tid 0x1 len 0x18
          pat uuid-16 0x1108 (Headset)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName) 0x0302 (unknown)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Req: tid 0x1 len 0x18
          pat uuid-16 0x111e (Handsfree)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName) 0x0311 (unknown)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Req: tid 0x1 len 0x1b
          pat uuid-16 0x1105 (OBEXObjPush)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)s) =
0x0100 (SrvName) 0x0303 (SuppFormatsList)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Req: tid 0x1 len 0x18
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0009 (BTProfileDescList) 0x0100 (SrvName)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Req: tid 0x1 len 0x18
          pat uuid-16 0x1107 (IRMCSyncCmd)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0009 (BTProfileDescList) 0x0100 (SrvName)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 44
    L2CAP(d): cid 0x0040 len 40 [psm 1]
        SDP SSA Req: tid 0x1 len 0x23
          pat uuid-128 00000001-0000-1000-8000-0002ee000002
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 30
    L2CAP(d): cid 0x0040 len 26 [psm 1]
        SDP SSA Req: tid 0x1 len 0x15
          pat uuid-16 0x1101 (SP)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0100 (SrvName)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 42
    L2CAP(d): cid 0x0040 len 38 [psm 1]
        SDP SSA Req: tid 0x1 len 0x21
          pat uuid-16 0x1102 (LAN)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0101 =
(SrvDesc) 0x0200 (Ver
sionNumList)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 42
    L2CAP(d): cid 0x0040 len 38 [psm 1]
        SDP SSA Req: tid 0x1 len 0x21
          pat uuid-16 0x1113 (WAP)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0009 (BTProfileDescList) =
0x0100 (SrvName) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) =
0x0309 (unknown)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 54
    L2CAP(d): cid 0x0040 len 50 [psm 1]
        SDP SSA Req: tid 0x1 len 0x2d
          pat uuid-16 0x1113 (WAP)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
0x0101 (SrvDesc) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) =
0x0309 (unknown)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 45
    L2CAP(d): cid 0x0040 len 41 [psm 1]
        SDP SSA Req: tid 0x1 len 0x24
          pat uuid-16 0x1115 (PANU)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
0x0101 (SrvDesc) 0x030a (SecurityDescription)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 54
    L2CAP(d): cid 0x0040 len 50 [psm 1]
        SDP SSA Req: tid 0x1 len 0x2d
          pat uuid-16 0x1116 (NAP)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a (SecurityDescription) =
0x030b (NetAccessType) 0x030c (MaxNetAccessRate)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 92
    L2CAP(d): cid 0x0040 len 88 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x53
          count 80
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1116 (NAP) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0xf > <
                 uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint =
0x806 > > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1116 (NAP) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Network Access Point"
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 256 flags 0x02 dlen 48
    L2CAP(d): cid 0x0040 len 44 [psm 1]
        SDP SSA Req: tid 0x1 len 0x27
          pat uuid-16 0x1117 (GN)
          max 1500
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) =
0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) =
0x0100 (SrvName)
0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a (SecurityDescription)
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 256 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
------=_NextPart_000_000B_01C79B24.58414930
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
<BODY bgColor=3D#ffffff background=3D"">
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a SDP problem with some Sony =
Ericsson phones=20
(e.g. K710i and K800i) on my home made bluetooth&nbsp;</FONT><FONT =
face=3DArial=20
size=3D2>access point running bluez-libs-2.25 and bluez-utils-2.25. My =
W950i phone=20
(running Symbian UIQ3) and my&nbsp;computer (Windows 2000) with a Hama =
bluetooth=20
USB dongle works perfect and I am able to discover the NAP service on=20
the&nbsp;access point&nbsp;(see the&nbsp;hcidump below) and connect to =
it.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When I&nbsp;i.e. pair a K800i phone =
with the access=20
point and afterwards try to list the services&nbsp;the phone says that =
no=20
services are found.&nbsp;I can however see that the K800i phone (see=20
the&nbsp;hcidump further down) is using another way of discovering =
services=20
which could be the problem. But it actually looks like the access point =
is=20
answering back to the phone with a SDP SSA response. &nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is&nbsp;this&nbsp;a problem in the SDP =
part of=20
bluez or is it something in the Sony Ericsson phones? If it is a bluez =
problem=20
does anyone know how to solve this issue?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank you very much for the help =
:o)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kind Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Jeppe F.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>Pairing and service discovery =
with Hama=20
bluetooth dongle (working case):</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT size=3D2>
<P align=3Dleft></FONT></FONT><FONT face=3DArial size=3D2>&gt; HCI =
Event: Connect=20
Request (0x04) plen 10<BR>&lt; HCI Command: Accept Connection Request=20
(0x01|0x0009) plen 7<BR>&gt; HCI Event: Command Status (0x0f) plen =
4<BR>&gt; HCI=20
Event: Role Change (0x12) plen 8<BR>&gt; HCI Event: Link Key Request =
(0x17) plen=20
6<BR>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen =
22<BR>&gt; HCI=20
Event: Command Complete (0x0e) plen 10<BR>&gt; HCI Event: PIN Code =
Request=20
(0x16) plen 6<BR>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) =
plen=20
23<BR>&gt; HCI Event: Command Complete (0x0e) plen 10<BR>&gt; HCI Event: =
Link=20
Key Notification (0x18) plen 23<BR>&gt; HCI Event: Connect Complete =
(0x03) plen=20
11<BR>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen =
4<BR>&gt;=20
HCI Event: Command Complete (0x0e) plen 6<BR>&lt; HCI Command: Change =
Connection=20
Packet Type (0x01|0x000f) plen 4<BR>&gt; HCI Event: Command Status =
(0x0f) plen=20
4<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen =
5<BR>&gt; HCI=20
Event: Max Slots Change (0x1b) plen 3<BR>&gt; ACL data: handle 256 flags =
0x02=20
dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid =
0x0040<BR>&lt;=20
ACL data: handle 256 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): =
Connect=20
rsp: dcid 0x0040 scid 0x0040 result 0 status =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Connection successful<BR>&gt; HCI Event: Number of Completed Packets =
(0x13) plen=20
5<BR>&gt; ACL data: handle 256 flags 0x02 dlen 10<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Info req: type 2<BR>&lt; ACL data: handle 256 flags 0x02 dlen=20
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 result=20
1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not supported<BR>&gt; HCI Event: =
Number of=20
Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 256 flags 0x02 =
dlen=20
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 =
clen=20
0<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen=20
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: handle 256 =
flags=20
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 =
flags 0x00=20
clen 0<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x0040 flags=20
0x00 result 0 clen 4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672<BR>&gt; HCI Event: =
Encrypt=20
Change (0x08) plen 4<BR>&gt; HCI Event: Role Change (0x12) plen =
8<BR>&gt; HCI=20
Event: Encrypt Change (0x08) plen 4<BR>&gt; ACL data: handle 256 flags =
0x02 dlen=20
17<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len =

0x8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16 0x0001=20
(SDP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt;=20
ACL data: handle 256 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): =
cid=20
0x0040 len 14 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x1 len =
0x9<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle=20
0x0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle=20
256 flags 0x02 dlen 17<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x2 len =

0x8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16 0x0100=20
(L2CAP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt;=20
ACL data: handle 256 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): =
cid=20
0x0040 len 14 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x2 len =
0x9<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle=20
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont=20
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
ACL=20
data: handle 256 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040=20
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: =
tid 0x3=20
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle =

0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1024<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; cont=20
00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 22<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 18 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x3 len =

0xd<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
10<BR>0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x001=20
(SrvClassIDList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP)=20
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle=20
256 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid =
0x0040=20
scid 0x0040<BR>&lt; ACL data: handle 256 flags 0x02 dlen=20
12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid =
0x0040<BR>&gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle=20
256 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm =
1 scid=20
0x0041<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
16<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status=20
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<BR>&gt; HCI =
Event:=20
Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: handle 256 =
flags=20
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 =
flags 0x00=20
clen 0<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen=20
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL data: handle 256 =
flags=20
0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 =
flags 0x00=20
clen 0<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x%4.4x=20
flags 0x40 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Success<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 17<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len =

0x8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16 0x0100=20
(L2CAP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
65535<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt;=20
ACL data: handle 256 flags 0x02 dlen 18<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): =
cid=20
0x0041 len 14 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x1 len =
0x9<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle=20
0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont=20
00<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; =
ACL=20
data: handle 256 flags 0x02 dlen 21<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040=20
len 17 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: =
tid 0x2=20
len 0xc<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle =

0x10000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1024<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; cont=20
00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 22<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0041 len 18 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x2 len =

0xd<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
10<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001=20
(SrvClassIDList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP)=20
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5</FONT></P></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>Pairing and discovery with Sony =
Ericsson=20
K800i phone (not working case):</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&gt; HCI Event: Connect Request (0x04) =
plen=20
10<BR>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen =
7<BR>&gt;=20
HCI Event: Command Status (0x0f) plen 4<BR>&gt; HCI Event: Role Change =
(0x12)=20
plen 8<BR>&gt; HCI Event: Link Key Request (0x17) plen 6<BR>&lt; HCI =
Command:=20
Link Key Request Reply (0x01|0x000b) plen 22<BR>&gt; HCI Event: Command =
Complete=20
(0x0e) plen 10<BR>&gt; HCI Event: Connect Complete (0x03) plen =
11<BR>&lt; HCI=20
Command: Write Link Policy Settings (0x02|0x000d) plen 4<BR>&gt; HCI =
Event:=20
Command Complete (0x0e) plen 6<BR>&lt; HCI Command: Change Connection =
Packet=20
Type (0x01|0x000f) plen 4<BR>&gt; HCI Event: Command Status (0x0f) plen=20
4<BR>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen =
5<BR>&gt; HCI=20
Event: Max Slots Change (0x1b) plen 3<BR>&gt; ACL data: handle 256 flags =
0x02=20
dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid =
0x0040<BR>&lt;=20
ACL data: handle 256 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): =
Connect=20
rsp: dcid 0x0040 scid 0x0040 result 0 status =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Connection successful<BR>&gt; HCI Event: Number of Completed Packets =
(0x13) plen=20
5<BR>&gt; ACL data: handle 256 flags 0x02 dlen 16<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen=20
4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1500<BR>&lt; ACL data: handle =
256 flags=20
0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 =
flags 0x00=20
result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<BR>&lt; ACL =
data:=20
handle 256 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Config =
req: dcid=20
0x0040 flags 0x00 clen 0<BR>&gt; HCI Event: Number of Completed Packets =
(0x13)=20
plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen =
5<BR>&gt; ACL=20
data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): =
Config rsp:=20
scid 0x0040 flags 0x00 result 0 clen 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

Success<BR>&gt; ACL data: handle 256 flags 0x02 dlen =
33<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 29 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x18<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1108 =
(Headset)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName) 0x0302=20
(unknown)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 33<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x18<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x111e =
(Handsfree)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName) 0x0311=20
(unknown)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 36<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 32 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x1b<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1105 =
(OBEXObjPush)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
aid(s) 0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList)s) 0x0100 (SrvName) 0x0303=20
(SuppFormatsList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; cont=20
00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 33<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x18<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1106 =
(OBEXObjTrnsf)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

max 1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
aid(s) 0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList) =
0x0100=20
(SrvName)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 33<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 29 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x18<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1107 =
(IRMCSyncCmd)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
aid(s) 0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList) =
0x0100=20
(SrvName)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 44<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 40 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x23<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-128=20
00000001-0000-1000-8000-0002ee000002<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
max 1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
aid(s) 0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100=20
(SrvName)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 30<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 26 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x15<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1101 (SP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100=20
(SrvName)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 42<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 38 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x21<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1102 (LAN)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0008 (SrvAvail) 0x0009=20
(BTProfileDescList) 0x0100 (SrvName) 0x0101 (SrvDesc) 0x0200=20
(Ver<BR>sionNumList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
cont 00<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 42<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 38 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x21<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1113 (WAP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0306 =
(unknown)=20
0x0307 (unknown) 0x0308 (unknown) 0x0309=20
(unknown)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 54<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 50 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x2d<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1113 (WAP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) =
0x0008=20
(SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)<BR>0x0101 =
(SrvDesc)=20
0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) 0x0309=20
(unknown)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =

00<BR>&lt; ACL data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; =

L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 45<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 41 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x24<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1115 (PANU)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) =
0x0008=20
(SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)<BR>0x0101 =
(SrvDesc)=20
0x030a=20
(SecurityDescription)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
cont 00<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle 256=20
flags 0x02 dlen 54<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 50 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x2d<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1116 (NAP)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) =
0x0008=20
(SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)<BR>0x0101 =
(SrvDesc)=20
0x0200 (VersionNumList) 0x030a (SecurityDescription) 0x030b =
(NetAccessType)=20
0x030c=20
(MaxNetAccessRate)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
cont 00<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
92<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 88 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x53<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
80<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record=20
#0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
aid 0x0001=20
(SrvClassIDList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; uuid-16 0x1116 (NAP)=20
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
aid 0x0004=20
(ProtocolDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; &lt; uuid-16 0x0100 (L2CAP) uint 0xf &gt;=20
&lt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
uuid-16 0x000f (BNEP) uint 0x100 &lt; uint 0x800 uint 0x806 &gt; &gt;=20
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
aid 0x0009=20
(BTProfileDescList)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt; &lt; uuid-16 0x1116 (NAP) uint 0x100 &gt;=20
&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
aid 0x0100=20
(SrvName)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
str "Network Access=20
Point"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt;=20
HCI Event: Number of Completed Packets (0x13) plen 5<BR>&gt; ACL data: =
handle=20
256 flags 0x02 dlen 48<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 44 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 =
len=20
0x27<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat =
uuid-16=20
0x1117 (GN)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
max=20
1500<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) =
0x0001=20
(SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) =
0x0008=20
(SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)<BR>0x0101 =
(SrvDesc)=20
0x0200 (VersionNumList) 0x030a=20
(SecurityDescription)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
cont 00<BR>&lt; ACL data: handle 256 flags 0x02 dlen =
14<BR>&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 10 [psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&lt; ACL data: =
handle 256=20
flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 =
len=20
0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt; ACL=20
data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040=20
len 10 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA =
Rsp: tid=20
0x1 len 0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt; ACL=20
data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040=20
len 10 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA =
Rsp: tid=20
0x1 len 0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&lt; ACL=20
data: handle 256 flags 0x02 dlen 14<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040=20
len 10 [psm 1]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA =
Rsp: tid=20
0x1 len 0x5<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
count=20
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00<BR>&gt; HCI=20
Event: Number of Completed Packets (0x13) plen 5<BR>&gt; HCI Event: =
Number of=20
Completed Packets (0x13) plen 5<BR>&gt; HCI Event: Disconn Complete =
(0x05) plen=20
4</FONT></DIV></BODY></HTML>

------=_NextPart_000_000B_01C79B24.58414930--



--===============0937156214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0937156214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0937156214==--
