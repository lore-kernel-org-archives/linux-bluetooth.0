Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Robert Hancock <hancockrwd@gmail.com>
Date: Sun, 26 Nov 2017 17:09:44 -0600
Message-ID: <CADLC3L3note6acyKcB7z__j9BjnbUZ73RJMdyhsUxXwN87fpyw@mail.gmail.com>
Subject: Bluetooth speaker (XTreme Audio Pod) not connecting
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Having some trouble getting one of these Bluetooth speakers to connect
under Fedora 27:

http://www.xtremecables.net/AudioPod-6.aspx

The host adapter is a Plugable USB adapter using Broadcom chipset:

Bus 001 Device 006: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0

The speaker seems to pair OK, but I can't actually select it as an
audio output device. The hcidump output from pairing the device and
trying to select it is below. They key part seems to me to be:

< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature

Any thoughts on what is going on?

HCI sniffer - Bluetooth packet analyzer ver 5.47
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
    bdaddr 3D:D7:E4:72:89:A0
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 27
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:03:08:BE:B1:15 (Public)
      Flags: 0x1a
      Unknown type 0xff with 10 bytes data
      RSSI: -86
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:03:08:BE:B1:15 (Public)
      RSSI: -85
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      Flags: 0x06
      Unknown type 0x06 with 16 bytes data
      Complete local name: 'LUMO*'
      TX power level: 0
      RSSI: -84
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      RSSI: -83
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 4 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
    bdaddr 18:A4:BE:72:DD:72
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 27
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:03:08:BE:B1:15 (Public)
      Flags: 0x1a
      Unknown type 0xff with 10 bytes data
      RSSI: -87
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      Flags: 0x06
      Unknown type 0x06 with 16 bytes data
      Complete local name: 'LUMO*'
      TX power level: 0
      RSSI: -82
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      RSSI: -82
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:03:08:BE:B1:15 (Public)
      RSSI: -87
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 4 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Extended Inquiry Result (0x2f) plen 255
    bdaddr 30:21:63:3B:BA:D4 mode 1 clkoffset 0x365d class 0x240408 rssi -62
    Complete local name: 'AUDIOPOD2'
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 4
    Inquiry Cancel (0x01|0x0002) ncmd 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 30:21:63:3B:BA:D4 ptype 0xcc18 rswitch 0x01 clkoffset 0x365d (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 30:21:63:3B:BA:D4 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0x3a 0x85 0xfa 0x98 0x1d 0x59 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 30:21:63:3B:BA:D4 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 30:21:63:3B:BA:D4 name 'AUDIOPOD2'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 30:21:63:3B:BA:D4
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 30:21:63:3B:BA:D4
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 30:21:63:3B:BA:D4
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 30:21:63:3B:BA:D4
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 30:21:63:3B:BA:D4 capability 0x01 oob 0x00 auth 0x03
    Capability: DisplayYesNo (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 30:21:63:3B:BA:D4
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 30:21:63:3B:BA:D4 capability 0x03 oob 0x00 auth 0x04
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: General Bonding (No MITM Protection)
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 30:21:63:3B:BA:D4 passkey 302370
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 30:21:63:3B:BA:D4
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 30:21:63:3B:BA:D4
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 30:21:63:3B:BA:D4
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 30:21:63:3B:BA:D4 key 725B8B900F9B66780A5218007B40914B type 4
    Type: Unauthenticated Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 12
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 12 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
> HCI Event: Command Complete (0x0e) plen 7
    Read Encryption Key Size (0x05|0x0008) ncmd 1
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0200
        Unicast Connectless Data Reception
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004e scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x004e flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x004e flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 24
    L2CAP(d): cid 0x004e len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x45
          count 64
          cont 02 00 40
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 40
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x45
          count 64
          cont 02 00 80
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x45
          count 64
          cont 02 00 C0
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 C0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x45
          count 64
          cont 02 01 00
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x45
          count 64
          cont 02 01 40
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 40
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 40 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x23
          count 32
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x103 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x103 > >
              aid 0x0311 (SuppFeatures)
                 uint 0x1
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) uuid-16 0x110f (AVRemCt) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x104 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x106 > >
              aid 0x0311 (SuppFeatures)
                 uint 0x1
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x104 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x106 > >
              aid 0x0311 (SuppFeatures)
                 uint 0x2
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x106 > >
              aid 0x0100 (SrvName)
                 str "Handsfree"
              aid 0x0311 (SuppFeatures)
                 uint 0x15
          record #4
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x102 > >
              aid 0x0100 (SrvName)
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 12 flags 0x00 dlen 24
    L2CAP(d): cid 0x004e len 20 [psm 1]
        SDP SSA Req: tid 0x6 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x6
          count 3
          cont 00
< ACL data: handle 12 flags 0x00 dlen 24
    L2CAP(d): cid 0x004e len 20 [psm 1]
        SDP SSA Req: tid 0x7 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
> ACL data: handle 12 flags 0x01 dlen 10
    L2CAP(d): cid 0x0040 len 74 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x45
          count 64
          cont 02 00 40
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x004e len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 40
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0x19
          count 22
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x102 > >
              aid 0x0100 (SrvName)
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Config req: dcid 0x004f flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x004f flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x004f len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(d): cid 0x004f len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 4 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 7
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x004f len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(d): cid 0x004f len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(d): cid 0x004f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 12 flags 0x00 dlen 9
    L2CAP(d): cid 0x004f len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 3
    L2CAP(d): cid 0x0041 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 0 ilen 12 fcs 0xbf
< ACL data: handle 12 flags 0x00 dlen 14
    L2CAP(d): cid 0x004f len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 6 fcs 0x65
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 8
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 8
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 6
    L2CAP(d): cid 0x0050 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0 nsp 0x00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 0 nsp 0x00
        ACP SEID 1 - Audio Sink
< ACL data: handle 12 flags 0x00 dlen 7
    L2CAP(d): cid 0x0050 len 3 [psm 25]
      AVDTP(s): All Capabilities cmd: transaction 1 nsp 0x00
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 3
    L2CAP(d): cid 0x0042 len 16 [psm 25]
      AVDTP(s): All Capabilities rsp: transaction 1 nsp 0x00
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-52
        Content Protection
          02 00
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(d): cid 0x0050 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2 nsp 0x00
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          48kHz
          JointStereo
          16 Blocks
          8 Subbands
          Loudness
          Bitpool Range 2-51
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 6
    L2CAP(d): cid 0x0042 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2 nsp 0x00
< ACL data: handle 12 flags 0x00 dlen 7
    L2CAP(d): cid 0x0050 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3 nsp 0x00
        ACP SEID 1
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 6
    L2CAP(d): cid 0x0042 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3 nsp 0x00
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0043
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0043 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0044
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0044 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
      MTU 672
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 0 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x0001
            CapabilityID: 0x03 (EventsID)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 1
    L2CAP(d): cid 0x0044 len 14 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 7 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x0001
            CapabilityID: 0x03 (EventsID)
< ACL data: handle 12 flags 0x00 dlen 27
    L2CAP(d): cid 0x0052 len 23 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 7 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x000a
            CapabilityID: 0x03 (EventsID)
            CapabilityCount: 0x08
            EventsID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
            EventsID: 0x02 (EVENT_TRACK_CHANGED)
            EventsID: 0x03 (EVENT_TRACK_REACHED_END)
            EventsID: 0x04 (EVENT_TRACK_REACHED_START)
            EventsID: 0x08 (EVENT_PLAYER_APPLICATION_SETTING_CHANGED)
            EventsID: 0x0a (EVENT_AVAILABLE_PLAYERS_CHANGED)
            EventsID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
            EventsID: 0x0d (EVENT_VOLUME_CHANGED)
> ACL data: handle 12 flags 0x02 dlen 17
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x01 dlen 3
    L2CAP(d): cid 0x0044 len 16 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 0 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x0003
            CapabilityID: 0x03 (EventsID)
            CapabilityCount: 0x01
            EventsID: 0x06 (EVENT_BATT_STATUS_CHANGED)
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 5
    L2CAP(d): cid 0x0044 len 18 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 8 pid 0x110e
        AV/C: Notify: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0005
            EventID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
            Interval: 0x00000000 (0 seconds)
< ACL data: handle 12 flags 0x00 dlen 19
    L2CAP(d): cid 0x0052 len 15 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 8 pid 0x110e
        AV/C: Interim: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0002
            EventID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
            PlayStatus: 0x00 (STOPPED)
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 5
    L2CAP(d): cid 0x0044 len 18 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 9 pid 0x110e
        AV/C: Notify: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0005
            EventID: 0x02 (EVENT_TRACK_CHANGED)
            Interval: 0x00000000 (0 seconds)
< ACL data: handle 12 flags 0x00 dlen 26
    L2CAP(d): cid 0x0052 len 22 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 9 pid 0x110e
        AV/C: Interim: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0009
            EventID: 0x02 (EVENT_TRACK_CHANGED)
            Identifier: 0xffffffffffffffff (18446744073709551615)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 17
> ACL data: handle 12 flags 0x01 dlen 5
    L2CAP(d): cid 0x0044 len 18 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 10 pid 0x110e
        AV/C: Notify: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0005
            EventID: 0x08 (EVENT_PLAYER_APPLICATION_SETTING_CHANGED)
            Interval: 0x00000000 (0 seconds)
< ACL data: handle 12 flags 0x00 dlen 19
    L2CAP(d): cid 0x0052 len 15 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 10 pid 0x110e
        AV/C: Interim: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0002
            EventID: 0x08 (EVENT_PLAYER_APPLICATION_SETTING_CHANGED)
            AttributeCount: 0x00
> ACL data: handle 12 flags 0x02 dlen 17
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x01 dlen 5
    L2CAP(d): cid 0x0044 len 18 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 11 pid 0x110e
        AV/C: Notify: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0005
            EventID: 0x0d (EVENT_VOLUME_CHANGED)
            Interval: 0x00000000 (0 seconds)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 11 pid 0x110e
        AV/C: Rejected: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0001
            Error: 0x01 (Invalid Parameter)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x004e scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004e scid 0x0040
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
    bdaddr 04:A1:75:4C:90:E8
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 27
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:03:08:BE:B1:15 (Public)
      Flags: 0x1a
      Unknown type 0xff with 10 bytes data
      RSSI: -87
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:03:08:BE:B1:15 (Public)
      RSSI: -88
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      Flags: 0x06
      Unknown type 0x06 with 16 bytes data
      Complete local name: 'LUMO*'
      TX power level: 0
      RSSI: -79
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr E7:46:64:E1:D7:F1 (Random)
      RSSI: -79
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
    Error: Unsupported Remote Feature / Unsupported LMP Feature
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 4 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
