Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609261815w6acd7ccex7e4d106a21956e75@mail.gmail.com>
Date: Wed, 27 Sep 2006 09:15:28 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159259956.1235.3.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
	<1159259956.1235.3.camel@localhost>
Subject: Re: [Bluez-devel] Can I search two services at the same time?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0954418542=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0954418542==
Content-Type: multipart/alternative;
	boundary="----=_Part_18752_20142301.1159319728583"

------=_Part_18752_20142301.1159319728583
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My test device is Nokia E61 with bluetooth chip which
is from Texas Instrument Inc (13) LMP version: 1.2 LMP subversion is 0xdb0

When I used kbluetoothd to  browse 00:12:D1:D1:08:47 ,
we found the OBEX push(record# 9) and CPS (record# 13).
so the remote device has the records.
HCIDUMP -X -V :
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:D1:D1:08:47 ptype 0xcc18 rswitch 0x01 clkoffset 0x35a7
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:12:D1:D1:08:47 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:12:D1:D1:08:47 mode 2 clkoffset 0x0000
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 1 flags 0x02 dlen 26
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00000000-0000-0000-0000-000000000000
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:12:D1:D1:08:47 name 'hehe'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 1 flags 0x02 dlen 36
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 1 flags 0x02 dlen 26
    L2CAP(d): cid 0x0041 len 22 [psm 1]
        SDP SSA Req: tid 0x0 len 0x11
          pat uuid-32 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 676
    L2CAP(d): cid 0x0041 len 672 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x29b
          count 654
          cont 0A 00 00 02 8E 00 00 06 82 00 00
< ACL data: handle 1 flags 0x02 dlen 36
    L2CAP(d): cid 0x0041 len 32 [psm 1]
        SDP SSA Req: tid 0x1 len 0x1b
          pat uuid-32 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 0A 00 00 02 8E 00 00 06 82 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 676
    L2CAP(d): cid 0x0041 len 672 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x29b
          count 654
          cont 0A 00 00 05 1C 00 00 06 82 00 00
< ACL data: handle 1 flags 0x02 dlen 36
    L2CAP(d): cid 0x0041 len 32 [psm 1]
        SDP SSA Req: tid 0x2 len 0x1b
          pat uuid-32 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 0A 00 00 05 1C 00 00 06 82 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 370
    L2CAP(d): cid 0x0041 len 366 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x169
          count 358
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1000 (SDServer) >
              aid 0x0002 (SrvRecState)
                 uint 0x0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1000 (SDServer) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0007 (SrvInfoTimeToLive)
                 uint 0x4b0
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0100 (SrvName)
                 str "SDP Server"
              aid 0x0101 (SrvDesc)
                 str "Provides local service information for remote
devices."
              aid 0x0102 (ProviderName)
                 str "Symbian Ltd."
              aid 0x0200 (VersionNumList)
                 < uint 0x100 uint 0x101 >
              aid 0x0201 (SrvDBState)
                 uint 0x23
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x100 uint 0xf00 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0100 (SrvName)
                 str "AVRCP Target"
              aid 0x0101 (SrvDesc)
                 str "Audio Video Remote Control"
              aid 0x0102 (ProviderName)
                 str "Symbian Software Ltd."
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000c
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
              aid 0x0002 (SrvRecState)
                 uint 0x8
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1c > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111f (Handsfree AG) uint 0x101 > >
              aid 0x0100 (SrvName)
                 str "Hands-Free Audio Gateway"
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000d
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1d > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Headset Audio Gateway"
          record #4
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000e
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 00000002-0000-1000-8000-0002ee000002 >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xa > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-128 00000002-0000-1000-8000-0002ee000002 uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "SyncMLClient"
          record #5
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000f
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1106 (OBEXObjTrnsf) >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xb > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX File Transfer"
          record #6
              aid 0x0000 (SrvRecHndl)
                 uint 0x10010
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 00005005-0000-1000-8000-0002ee000001 >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xc > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-128 00005005-0000-1000-8000-0002ee000001 uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "Nokia OBEX PC Suite Services"
          record #7
              aid 0x0000 (SrvRecHndl)
                 uint 0x10011
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 00000004-0000-1000-8000-0002ee000002 >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-128 00000004-0000-1000-8000-0002ee000002 uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "SyncML DM Client"
          record #8
              aid 0x0000 (SrvRecHndl)
                 uint 0x10012
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 00005601-0000-1000-8000-0002ee000001 >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xe > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-128 00005601-0000-1000-8000-0002ee000001 uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "Nokia SyncML Server"
          record #9
              aid 0x0000 (SrvRecHndl)
                 uint 0x10013
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0002 (SrvRecState)
                 uint 0x7
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x9 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 < uint 0xff >
          record #10
              aid 0x0000 (SrvRecHndl)
                 uint 0x10014
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1103 (DUN) >
              aid 0x0002 (SrvRecState)
                 uint 0x6
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1103 (DUN) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Dial-Up Networking"
          record #11
              aid 0x0000 (SrvRecHndl)
                 uint 0x10015
              aid 0x0001 (SrvClassIDList)
                 < < uuid-128 00005557-0000-1000-8000-0002ee000001 > >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0005 (BrwGrpList)
                 < < uuid-16 0x1002 (PubBrwsGrp) > >
          record #12
              aid 0x0000 (SrvRecHndl)
                 uint 0x10016
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111b (ImagingResp) >
              aid 0x0002 (SrvRecState)
                 uint 0xa
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xf > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x454e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111a (Imaging) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Imaging"
              aid 0x0310 (SuppCapabilities)
                 uint 0x1
              aid 0x0311 (SuppFeatures)
                 uint 0x1
              aid 0x0312 (SuppFunctions)
                 uint 0xb
              aid 0x0313 (SuppTotalCapacity)
                 uint 0x400000400000000
          record #13
              aid 0x0000 (SrvRecHndl)
                 uint 0x10017
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x2222 >
              aid 0x0002 (SrvRecState)
                 uint 0x2
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x3 > >
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0100 (SrvName)
                 str "CPS"
              aid 0x0101 (SrvDesc)
                 str "Symbian91#2#1#320#240#"
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host



2006/9/26, Marcel Holtmann <marcel@holtmann.org>:

> Hi,
>
> >
> >    I have seen that there is a function named sdp_service_search_req,
> >    So,I append two service uuid such as obexpush's uuid and another
> > service's uuid into the search list, I want to get the two services'
> > info only call search func once.
> >   and then set the max_rec_num = 2,
> >   then call
> >        sdp_service_search_req(session,search_list,2,&rsp_list);
> >  but ,I have seen that the func return 0, but the rsp_list is NULL.
>
> this works, but your remote device does not contain any of these records
> and so it reports non back to you. What kind of remote device is it you
> are testing with.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
With respects,
   Mingfan.Lu

------=_Part_18752_20142301.1159319728583
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My test device is Nokia E61 with bluetooth chip which <br>is from Texas Instrument Inc (13)
<div><span class="gmail_quote">LMP version: 1.2 LMP subversion is 0xdb0</span></div>
<div><span class="gmail_quote"></span>&nbsp;</div>
<div><span class="gmail_quote">When I used kbluetoothd to&nbsp;</span><span class="gmail_quote">&nbsp;browse 00:12:D1:D1:08:47 ,</span></div>
<div><span class="gmail_quote">we found the OBEX push(record# 9) and CPS (record# 13).</span></div>
<div><span class="gmail_quote">so the remote device has the records.</span></div>
<div><span class="gmail_quote">HCIDUMP -X -V :</span></div>
<div><span class="gmail_quote">HCI sniffer - Bluetooth packet analyzer ver 1.32<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:12:D1:D1:08:47 ptype 0xcc18 rswitch 0x01 clkoffset 0x35a7 (valid)
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 bdaddr 00:12:D1:D1:08:47 type ACL encrypt 0x00
<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&nbsp;&nbsp;&nbsp; handle 1 policy 0x0f<br>&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK 
<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1<br>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:12:D1:D1:08:47 mode 2 clkoffset 0x0000
<br>&gt; ACL data: handle 1 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Info req: type 2<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 result 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not supported<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp; handle 1 slots 5<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 ptype 0xcc18<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 28
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - Authorization pending<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful
<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&gt; ACL data: handle 1 flags 0x02 dlen 26<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672 <br>&lt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 1 flags 0x02 dlen 38<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 34 [psm 1]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0x1d<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-128 00000000-0000-0000-0000-000000000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; HCI Event: Remote Name Req Complete (0x07) plen 255
<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:12:D1:D1:08:47 name 'hehe'<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1
<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 2
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0041<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040<br>&gt; ACL data: handle 1 flags 0x02 dlen 36
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - Authorization pending<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0<br>&lt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 18
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672 <br>&lt; ACL data: handle 1 flags 0x02 dlen 26<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 22 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0x11
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x0100 (L2CAP)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 676
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 672 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x29b<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 654<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 0A 00 00 02 8E 00 00 06 82 00 00<br>&lt; ACL data: handle 1 flags 0x02 dlen 36<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 32 [psm 1]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0x1b<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x0100 (L2CAP)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 0A 00 00 02 8E 00 00 06 82 00 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 676<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 672 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x29b<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 654<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 0A 00 00 05 1C 00 00 06 82 00 00
<br>&lt; ACL data: handle 1 flags 0x02 dlen 36<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 32 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x2 len 0x1b<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x0100 (L2CAP)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 0A 00 00 05 1C 00 00 06 82 00 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 370<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 366 [psm 1]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x2 len 0x169<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 358<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1000 (SDServer) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1000 (SDServer) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0007 (SrvInfoTimeToLive)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x4b0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0008 (SrvAvail)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0xff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;SDP Server&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0101 (SrvDesc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Provides local service information for remote devices.&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Symbian Ltd.&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0200 (VersionNumList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x100 uint 0x101 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0201 (SrvDBState)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x23<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x110e (AVRemote) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) uint 0x17 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0017 (AVCTP) uint 0x100 uint 0xf00 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;AVRCP Target&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0101 (SrvDesc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Audio Video Remote Control&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Symbian Software Ltd.&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1000c<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x1c &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x111f (Handsfree AG) uint 0x101 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Hands-Free Audio Gateway&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0301 (SuppDataStoresList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0311 (SuppFeatures)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0xf<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1000d
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x1d &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1108 (Headset) uint 0x100 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Headset Audio Gateway&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1000e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-128 00000002-0000-1000-8000-0002ee000002 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xa &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-128 00000002-0000-1000-8000-0002ee000002 uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;SyncMLClient&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1000f<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1106 (OBEXObjTrnsf) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xb &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX File Transfer&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10010<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-128 00005005-0000-1000-8000-0002ee000001 &gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xc &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-128 00005005-0000-1000-8000-0002ee000001 uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Nokia OBEX PC Suite Services&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #7<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10011<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-128 00000004-0000-1000-8000-0002ee000002 &gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xd &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-128 00000004-0000-1000-8000-0002ee000002 uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;SyncML DM Client&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10012<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-128 00005601-0000-1000-8000-0002ee000001 &gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xe &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-128 00005601-0000-1000-8000-0002ee000001 uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Nokia SyncML Server&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10013<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1105 (OBEXObjPush) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x7<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x9 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1105 (OBEXObjPush) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0303 (SuppFormatsList)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0xff &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10014<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1103 (DUN) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x2 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1103 (DUN) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Dial-Up Networking&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #11<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10015<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-128 00005557-0000-1000-8000-0002ee000001 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #12<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10016<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x111b (ImagingResp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0xa<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0xf &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x454e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x111a (Imaging) uint 0x100 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Imaging&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0310 (SuppCapabilities)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0311 (SuppFeatures)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0312 (SuppFunctions)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0xb<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0313 (SuppTotalCapacity)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x400000400000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #13<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10017<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x2222 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0002 (SrvRecState)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x3 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0008 (SrvAvail)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0xff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;CPS&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0101 (SrvDesc)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;Symbian91#2#1#320#240#&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3
<br>&nbsp;&nbsp;&nbsp; handle 1 reason 0x13<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Disconnect (0x01|0x0006) status 0x00 ncmd 1<br>&gt; HCI Event: Disconn Complete (0x05) plen 4
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 reason 0x16<br>&nbsp;&nbsp;&nbsp; Reason: Connection Terminated by Local Host</span></div>
<div><span class="gmail_quote"></span>&nbsp;</div>
<div>&nbsp;</div>
<div><span class="gmail_quote"></span>&nbsp;</div>
<div><span class="gmail_quote">2006/9/26, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span></div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I have seen that there is a function named sdp_service_search_req,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;So,I append two service uuid such as obexpush's uuid and another
<br>&gt; service's uuid into the search list, I want to get the two services'<br>&gt; info only call search func once.<br>&gt;&nbsp;&nbsp; and then set the max_rec_num = 2,<br>&gt;&nbsp;&nbsp; then call<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sdp_service_search_req(session,search_list,2,&amp;rsp_list);
<br>&gt;&nbsp;&nbsp;but ,I have seen that the func return 0, but the rsp_list is NULL.<br><br>this works, but your remote device does not contain any of these records<br>and so it reports non back to you. What kind of remote device is it you
<br>are testing with.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_18752_20142301.1159319728583--


--===============0954418542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0954418542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0954418542==--
