Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 22 Dec 2012 06:48:58 +0200
Message-ID: <CAGXs5wXEEnO084sg1Er-SgB3-TU+W5HtjsKnY7CdT9Hsw+jjew@mail.gmail.com>
Subject: setting BT connection over RFCOMM
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I am trying to establish BT connections between two PCs over RFCOMM serial port.
I ran on both:
sdptool add --channel=15 SP

then, on the server, I ran:
rfcomm listen rfcomm0 15

Waiting for connection on channel 15

and on the client, I ran:
hcitool scan
Scanning ...
	00:23:4E:E5:70:3A	n-0
	
rfcomm connect rfcomm0 00:23:4E:E5:70:3A

I got: (after a while)
Can't connect RFCOMM socket: Connection refused
shouldn't it work?

hcidump on the server gives this:

[root@n ~]\>hcidump
HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:AA:FB:94 class 0x500100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:AA:FB:94 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:02:72:AA:FB:94 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:02:72:AA:FB:94 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:02:72:AA:FB:94 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:72:AA:FB:94 name 'h-0'
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 00:02:72:AA:FB:94 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 00:02:72:AA:FB:94
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 00:02:72:AA:FB:94 capability 0x03 oob 0x00 auth 0x00
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 00:02:72:AA:FB:94
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:02:72:AA:FB:94 passkey 215699
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:02:72:AA:FB:94
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:02:72:AA:FB:94
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:02:72:AA:FB:94
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:02:72:AA:FB:94 key 774160EF3B5C52E709937AF2D82885F4 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 27
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
      MTU 1013
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 27
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
      MTU 1013
      RFC 0x00 (Basic)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
      RFC 0x00 (Basic)
> ACL data: handle 12 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
      RFC 0x00 (Basic)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 24
    L2CAP(d): cid 0x0041 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 11
      RFC 0x00 (Basic)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 672
> ACL data: handle 12 flags 0x02 dlen 676
    L2CAP(d): cid 0x0041 len 672 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x29b
          count 656
          cont 08 E7 35 D5 50 90 02 00 00
< ACL data: handle 12 flags 0x00 dlen 32
    L2CAP(d): cid 0x0041 len 28 [psm 1]
        SDP SSA Req: tid 0x1 len 0x17
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 08 E7 35 D5 50 90 02 00 00
> ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 12 flags 0x00 dlen 676
    L2CAP(d): cid 0x0042 len 672 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x29b
          count 656
          cont 08 5A 28 D5 50 90 02 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 100
    L2CAP(d): cid 0x0041 len 96 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5b
          count 88
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xc > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x102 > >
              aid 0x0100 (SrvName)
                 str "Headset Audio Gateway"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >
              aid 0x0100 (SrvName)
                 str "Hands-Free Audio Gateway"
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0311 (SuppFeatures)
                 uint 0x0
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x103 > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          record #4
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
              aid 0x0002 (SrvRecState)
                 uint 0x1234
              aid 0x0003 (SrvID)
                 uuid-16 0x1101 (SP)
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xf > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0007 (SrvInfoTimeToLive)
                 uint 0xffff
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1101 (SP) uint 0x100 > >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Serial Port"
              aid 0x0101 (SrvDesc)
                 str "COM Port"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #5
              aid 0x0000 (SrvRecHndl)
                 uint 0x10005
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x9 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint
0x6 uint 0xff >
          record #6
              aid 0x0000 (SrvRecHndl)
                 uint 0x10006
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1106 (OBEXObjTrnsf) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xa > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX File Transfer"
          cont 00
> ACL data: handle 12 flags 0x02 dlen 32
    L2CAP(d): cid 0x0042 len 28 [psm 1]
        SDP SSA Req: tid 0x1 len 0x17
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 08 5A 28 D5 50 90 02 00 00
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 129
    L2CAP(d): cid 0x0042 len 125 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x78
          count 117
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xc > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x102 > >
              aid 0x0100 (SrvName)
                 str "Headset Audio Gateway"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >
              aid 0x0100 (SrvName)
                 str "Hands-Free Audio Gateway"
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0311 (SuppFeatures)
                 uint 0x0
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x103 > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          record #4
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
              aid 0x0002 (SrvRecState)
                 uint 0x1234
              aid 0x0003 (SrvID)
                 uuid-16 0x1101 (SP)
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xf > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0007 (SrvInfoTimeToLive)
                 uint 0xffff
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1101 (SP) uint 0x100 > >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Serial Port"
              aid 0x0101 (SrvDesc)
                 str "COM Port"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #5
              aid 0x0000 (SrvRecHndl)
                 uint 0x10005
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
              aid 0x0002 (SrvRecState)
                 uint 0x1234
              aid 0x0003 (SrvID)
                 uuid-16 0x1101 (SP)
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xf > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0007 (SrvInfoTimeToLive)
                 uint 0xffff
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1101 (SP) uint 0x100 > >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Serial Port"
              aid 0x0101 (SrvDesc)
                 str "COM Port"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          cont 00
< ACL data: handle 12 flags 0x00 dlen 24
    L2CAP(d): cid 0x0041 len 20 [psm 1]
        SDP SSA Req: tid 0x2 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x5
          count 2
          cont 00
> ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x2 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 12 flags 0x00 dlen 14
    L2CAP(d): cid 0x0042 len 10 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0042
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x13
    Reason: Remote User Terminated Connection
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:02:72:AA:FB:94 all 0
> HCI Event: Command Complete (0x0e) plen 6
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x00 deleted 0

rgs,
Kevin
