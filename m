Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 15 Jun 2007 21:14:05 +0200 (CEST)
From: Mitja Pufic <m@section-one.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001901c7af6e$0a578640$0601a8c0@shuttle>
Message-ID: <Pine.LNX.4.64.0706152107560.22999@cherokee.spacecom.si>
References: <001901c7af6e$0a578640$0601a8c0@shuttle>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

what are you trying to achive? Connect K710i and K800i to PAN access 
point and use its network resources? That won't work, as they lack 
PANU - client side of PAN profile. The K series only has NAP side 
implemented, whit which they only share Packed Switched data to one 
client - e.g. your computer. The SE smarpthones, namely P990i, M600i and 
W950i all have full PAN profile support, they can be either GN, NAP or 
PANU.

br,
m

On Fri, 15 Jun 2007, Jeppe Frandsen wrote:

> Hi,
> 
> I have a SDP problem with some Sony Ericsson phones (e.g. K710i and K800i) on my home made bluetooth access point running bluez-libs-2.25 and bluez-utils-2.25. My W950i phone (running Symbian UIQ3) and my computer (Windows 2000) with a Hama bluetooth USB dongle works perfect and I am able to discover the NAP service on the access point (see the hcidump below) and connect to it. 
> 
> When I i.e. pair a K800i phone with the access point and afterwards try to list the services the phone says that no services are found. I can however see that the K800i phone (see the hcidump further down) is using another way of discovering services which could be the problem. But it actually looks like the access point is answering back to the phone with a SDP SSA response.  
> 
> Is this a problem in the SDP part of bluez or is it something in the Sony Ericsson phones? If it is a bluez problem does anyone know how to solve this issue?
> 
> Thank you very much for the help :o)
> 
> 
> Kind Regards,
> 
> Jeppe F.
> 
> Pairing and service discovery with Hama bluetooth dongle (working case):
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Role Change (0x12) plen 8
> > HCI Event: Link Key Request (0x17) plen 6
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: PIN Code Request (0x16) plen 6
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Link Key Notification (0x18) plen 23
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < ACL data: handle 256 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> < ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Info rsp: type 2 result 1
>       Not supported
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 672
> > HCI Event: Encrypt Change (0x08) plen 4
> > HCI Event: Role Change (0x12) plen 8
> > HCI Event: Encrypt Change (0x08) plen 4
> > ACL data: handle 256 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x1 len 0x8
>           pat uuid-16 0x0001 (SDP)
>           max 65535
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 1]
>         SDP SS Rsp: tid 0x1 len 0x9
>           count 1
>           handle 0x0
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x2 len 0x8
>           pat uuid-16 0x0100 (L2CAP)
>           max 65535
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 1]
>         SDP SS Rsp: tid 0x2 len 0x9
>           count 1
>           handle 0x10000
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 21
>     L2CAP(d): cid 0x0040 len 17 [psm 1]
>         SDP SA Req: tid 0x3 len 0xc
>           handle 0x10000
>           max 1024
>           aid(s) 0x0001 (SrvClassIDList)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0040 len 18 [psm 1]
>         SDP SA Rsp: tid 0x3 len 0xd
>           count 10
> 0          aid 0x001 (SrvClassIDList)
>              < uuid-16 0x1116 (NAP) >
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> < ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0041
> < ACL data: handle 256 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x%4.4x flags 0x40 result 0 clen 0
>       Success
>       MTU 672
> > ACL data: handle 256 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x1 len 0x8
>           pat uuid-16 0x0100 (L2CAP)
>           max 65535
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0041 len 14 [psm 1]
>         SDP SS Rsp: tid 0x1 len 0x9
>           count 1
>           handle 0x10000
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 21
>     L2CAP(d): cid 0x0040 len 17 [psm 1]
>         SDP SA Req: tid 0x2 len 0xc
>           handle 0x10000
>           max 1024
>           aid(s) 0x0001 (SrvClassIDList)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0041 len 18 [psm 1]
>         SDP SA Rsp: tid 0x2 len 0xd
>           count 10
>           aid 0x0001 (SrvClassIDList)
>              < uuid-16 0x1116 (NAP) >
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> 
> 
> Pairing and discovery with Sony Ericsson K800i phone (not working case):
> 
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Role Change (0x12) plen 8
> > HCI Event: Link Key Request (0x17) plen 6
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < ACL data: handle 256 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 1500
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 256 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> > ACL data: handle 256 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x18
>           pat uuid-16 0x1108 (Headset)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName) 0x0302 (unknown)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x18
>           pat uuid-16 0x111e (Handsfree)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName) 0x0311 (unknown)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 36
>     L2CAP(d): cid 0x0040 len 32 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x1b
>           pat uuid-16 0x1105 (OBEXObjPush)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)s) 0x0100 (SrvName) 0x0303 (SuppFormatsList)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x18
>           pat uuid-16 0x1106 (OBEXObjTrnsf)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x18
>           pat uuid-16 0x1107 (IRMCSyncCmd)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 44
>     L2CAP(d): cid 0x0040 len 40 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x23
>           pat uuid-128 00000001-0000-1000-8000-0002ee000002
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 30
>     L2CAP(d): cid 0x0040 len 26 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x15
>           pat uuid-16 0x1101 (SP)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0100 (SrvName)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 42
>     L2CAP(d): cid 0x0040 len 38 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x21
>           pat uuid-16 0x1102 (LAN)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0101 (SrvDesc) 0x0200 (Ver
> sionNumList)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 42
>     L2CAP(d): cid 0x0040 len 38 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x21
>           pat uuid-16 0x1113 (WAP)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) 0x0309 (unknown)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 54
>     L2CAP(d): cid 0x0040 len 50 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x2d
>           pat uuid-16 0x1113 (WAP)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
> 0x0101 (SrvDesc) 0x0306 (unknown) 0x0307 (unknown) 0x0308 (unknown) 0x0309 (unknown)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 45
>     L2CAP(d): cid 0x0040 len 41 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x24
>           pat uuid-16 0x1115 (PANU)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
> 0x0101 (SrvDesc) 0x030a (SecurityDescription)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 54
>     L2CAP(d): cid 0x0040 len 50 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x2d
>           pat uuid-16 0x1116 (NAP)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
> 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a (SecurityDescription) 0x030b (NetAccessType) 0x030c (MaxNetAccessRate)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 92
>     L2CAP(d): cid 0x0040 len 88 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x53
>           count 80
>           record #0
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1116 (NAP) >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
>                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 > > >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1116 (NAP) uint 0x100 > >
>               aid 0x0100 (SrvName)
>                  str "Network Access Point"
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 256 flags 0x02 dlen 48
>     L2CAP(d): cid 0x0040 len 44 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x27
>           pat uuid-16 0x1117 (GN)
>           max 1500
>           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0006 (LangBaseAttrIDList) 0x0008 (SrvAvail) 0x0009 (BTProfileDescList) 0x0100 (SrvName)
> 0x0101 (SrvDesc) 0x0200 (VersionNumList) 0x030a (SecurityDescription)
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> < ACL data: handle 256 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x5
>           count 2
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Disconn Complete (0x05) plen 4
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
