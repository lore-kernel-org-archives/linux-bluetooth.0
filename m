Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 3 Feb 2012 11:20:41 +0800
Message-ID: <CAFJbRW5M8qLvcjV1gaCnHaB1GbNiLSrDue8LJ6tY78wzaotAVw@mail.gmail.com>
Subject: Issue about rfcomm connection establish on bluez 4.60
From: Jiancong Xie <jianc.xie@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

Hello everyone. This is my first time to be here.

I've met some problems when using bluetooth dongle on my board to
connect to my bluetooth remote controller. I've ported bluez 4.60 to
my board which runs on an OS with android honeycomb 3.2. The source
code of bluez 4.60 is running on ubuntu 10.04 which is works fine for
my laptop.

I captured the connection establish process of my board with hcidump.
It's like following,

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:21:4F:C3:0E:6D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 40 bdaddr 00:21:4F:C3:0E:6D type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 40
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:21:4F:C3:0E:6D mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 40 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:21:4F:C3:0E:6D mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 40
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 40 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:21:4F:C3:0E:6D name 'ALPS_SPP-Module'
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 40 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 40
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:21:4F:C3:0E:6D
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:21:4F:C3:0E:6D
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:21:4F:C3:0E:6D
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 00:21:4F:C3:0E:6D
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 00:21:4F:C3:0E:6D capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 00:21:4F:C3:0E:6D
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 00:21:4F:C3:0E:6D capability 0x03 oob 0x00 auth 0x04
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: General Bonding (No MITM Protection)
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:21:4F:C3:0E:6D passkey 111087
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:21:4F:C3:0E:6D
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:21:4F:C3:0E:6D
< HCI Command: User Confirmation Request Negative Reply (0x01|0x002d) plen 6
    bdaddr 00:21:4F:C3:0E:6D
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Negative Reply (0x01|0x002d) ncmd 1
    status 0x0c bdaddr 00:21:4F:C3:0E:6D
    Error: Command Disallowed
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:21:4F:C3:0E:6D
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:21:4F:C3:0E:6D key 5FABBE1FD28579835CF7577BFBF3D345 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 40
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 40 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 40 encrypt 0x01
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      MTU 1013
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0048 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 650 max_retrans 0 credits 0
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0048 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0048 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0048 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 3
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(d): cid 0x0048 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 8 fcs 0x9a
      FF 80 04 84 00 1F 00 64
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 40 flags 0x02 dlen 192
    L2CAP(d): cid 0x0040 len 188 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 183 fcs 0x40
      FF 8F 1D 92 00 1F 00 01 81 FC 84 FC 94 FC BE 02 FF BC 00 43
      00 21 00 00 00 00 00 00 00 E7 30 01 00 FF 8C 02 8E 00 1A FF
      85 02 87 02 22 FF 93 42 D1 4D 41 47 20 47 41 49 4E 20 78 7A
      20 78 79 20 79 7A 20 79 78 20 7A 79 20 7A 78 3A 20 7B 30 78
      39 43 2C 20 30 78 38 33 2C 20 30 78 38 30 2C 20 30 78 37 45
      2C 20 30 78 37 37 2C 20 30 78 37 42 7D 00 00 FF 93 40 D3 4D
      41 47 20 53 45 4E 53 20 78 20 79 20 7A 20 28 4C 53 42 2F 4D
      53 42 29 3A 20 7B 30 78 34 46 2C 20 30 78 30 32 2C 20 30 78
      36 31 2C 20 30 78 30 32 2C 20 30 78 37 31 2C 20 30 78 30 32
      7D 00 00

>From my captured log from laptop, after RFCOMM UIH packet, it should
be other user data sent. But I don't know why my board loss all these
data.

Do you guys have some suggests?

Thanks and regards,
Jiancong
