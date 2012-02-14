Return-Path: <cyrus@holtmann.org>
From: rajmohan.mohanan@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: mohanan <rajmohan.mohanan@intel.com>
Subject: [PATCH] Service Discovery Collison with Lenovo T500 Laptop.
Date: Tue, 14 Feb 2012 10:19:23 +0100
Message-Id: <1329211163-25755-1-git-send-email-rajmohan.mohanan@intel.com>
In-Reply-To: <SDP_COLLISION>
References: <SDP_COLLISION>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: mohanan <rajmohan.mohanan@intel.com>

ISSUE:
1. Intiate bonding from DUT.
2. After Successfull Bonding complete, DUT and Remote device intaites Service disocvery.
3. Service Discovery from either end results a collision and L2cap Connection for SDP from DUT is rejected.
4. From DUT if we send a file ,from android application service Records are NULL
becuase service discovery from DUT didnt succeed due to collision.
5. Android application will return status as failure  and he wont intaite a fresh sdp query so OPP transfer Fails.

FIX:

After bonding complete wait for one second and Intaite Service discovery for avoiding service discovery collision if remote device intiate service discovery immediately after bonding.

HCIDUMP:

HCI sniffer - Bluetooth packet analyzer ver 1.42

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 70:F3:95:4A:A9:DA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr 70:F3:95:4A:A9:DA role 0x01

    Role: Slave

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 256 bdaddr 70:F3:95:4A:A9:DA type ACL encrypt 0x00

< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2

    handle 256

> HCI Event: Max Slots Change (0x1b) plen 3

    handle 256 slots 5

> HCI Event: Command Status (0x0f) plen 4

    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

> HCI Event: Read Remote Supported Features (0x0b) plen 11

    status 0x00 handle 256

    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83

< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3

    handle 256 page 1

> HCI Event: Command Status (0x0f) plen 4

    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1

> HCI Event: Read Remote Extended Features (0x23) plen 13

    status 0x00 handle 256 page 1 max 0

    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

< HCI Command: Authentication Requested (0x01|0x0011) plen 2

    handle 256

> HCI Event: Command Status (0x0f) plen 4

    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1

> HCI Event: Link Key Request (0x17) plen 6

    bdaddr 70:F3:95:4A:A9:DA

< HCI Command: Remote Name Request (0x01|0x0019) plen 10

    bdaddr 70:F3:95:4A:A9:DA mode 2 clkoffset 0x0000

> HCI Event: Command Status (0x0f) plen 4

    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1

< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6

    bdaddr 70:F3:95:4A:A9:DA

> HCI Event: Command Complete (0x0e) plen 10

    Link Key Request Negative Reply (0x01|0x000c) ncmd 1

    status 0x00 bdaddr 70:F3:95:4A:A9:DA

> HCI Event: IO Capability Request (0x31) plen 6

    bdaddr 70:F3:95:4A:A9:DA

> HCI Event: Remote Name Req Complete (0x07) plen 255

    status 0x00 bdaddr 70:F3:95:4A:A9:DA name 'MOHANAN-MOBL'

< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9

    bdaddr 70:F3:95:4A:A9:DA capability 0x01 oob 0x00 auth 0x03

    Capability: DisplayYesNo (OOB data not present)

    Authentication: Dedicated Bonding (MITM Protection)

> HCI Event: Command Complete (0x0e) plen 10

    IO Capability Request Reply (0x01|0x002b) ncmd 1

    status 0x00 bdaddr 70:F3:95:4A:A9:DA

> HCI Event: IO Capability Response (0x32) plen 9

    bdaddr 70:F3:95:4A:A9:DA capability 0x01 oob 0x00 auth 0x03

    Capability: DisplayYesNo (OOB data not present)

    Authentication: Dedicated Bonding (MITM Protection)

> HCI Event: User Confirmation Request (0x33) plen 10

    bdaddr 70:F3:95:4A:A9:DA passkey 770785

< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6

    bdaddr 70:F3:95:4A:A9:DA

> HCI Event: Command Complete (0x0e) plen 10

    User Confirmation Request Reply (0x01|0x002c) ncmd 1

    status 0x00 bdaddr 70:F3:95:4A:A9:DA

> HCI Event: Simple Pairing Complete (0x36) plen 7

    status 0x00 bdaddr 70:F3:95:4A:A9:DA

> HCI Event: Link Key Notification (0x18) plen 23

    bdaddr 70:F3:95:4A:A9:DA key 42139A39E0C855C9777B0392F500A3E4 type 5

    Type: Authenticated Combination Key

> HCI Event: Auth Complete (0x06) plen 3

    status 0x00 handle 256

< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3

    handle 256 encrypt 0x01

> HCI Event: Command Status (0x0f) plen 4

    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1

> HCI Event: Encrypt Change (0x08) plen 4

    status 0x23 handle 256 encrypt 0x00

    Error: LMP Error Transaction Collision

> HCI Event: Encrypt Change (0x08) plen 4

    status 0x00 handle 256 encrypt 0x01

< ACL data: handle 256 flags 0x00 dlen 10

    L2CAP(s): Info req: type 2

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 256 flags 0x00 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 0

      Connection pending - No futher information available

< ACL data: handle 256 flags 0x00 dlen 10

    L2CAP(s): Info req: type 2

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Info rsp: type 2 result 1

      Not supported

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Info rsp: type 2 result 1

      Not supported

< ACL data: handle 256 flags 0x00 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0

      Connection successful

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4

      MTU 1024

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 0

      Connection pending - No futher information available

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0

      Connection successful

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1024

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

< ACL data: handle 256 flags 0x00 dlen 18

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4

      MTU 1024

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0

< ACL data: handle 256 flags 0x00 dlen 18

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4

      MTU 1024

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0

      Connection refused - no resources available

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0

      Success

> ACL data: handle 256 flags 0x02 dlen 24

    L2CAP(d): cid 0x0041 len 20 [psm 1]

        SDP SSA Req: tid 0x0 len 0xf

          pat uuid-16 0x0100 (L2CAP)

          max 1016

          aid(s) 0x0000 - 0xffff

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

< ACL data: handle 256 flags 0x00 dlen 339

< ACL data: handle 256 flags 0x01 dlen 214

    L2CAP(d): cid 0x0040 len 549 [psm 1]

        SDP SSA Rsp: tid 0x0 len 0x220

          count 541

          record #0

              aid 0x0000 (SrvRecHndl)

                 uint 0x10001

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x110a (AudioSource) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <

                 uuid-16 0x0019 (AVDTP) uint 0x100 > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "Audio Source"

              aid 0x0311 (SuppFeatures)

                 uint 0xf

          record #1

              aid 0x0000 (SrvRecHndl)

                 uint 0x10002

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x110c (AVRemTarget) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <

                 uuid-16 0x0017 (AVCTP) uint 0x100 > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x110e (AVRemote) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "AVRCP TG"

              aid 0x0311 (SuppFeatures)

                 uint 0xf

          record #2

              aid 0x0000 (SrvRecHndl)

                 uint 0x10003

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xa > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >

              aid 0x0100 (SrvName)

                 str "Voice Gateway"

              aid 0x0301 (SuppDataStoresList)

                 uint 0x1

              aid 0x0311 (SuppFeatures)

                 uint 0x7

          record #3

              aid 0x0000 (SrvRecHndl)

                 uint 0x10004

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xb > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1108 (Headset) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "Voice Gateway"

              aid 0x0301 (SuppDataStoresList)

                 uint 0x1

              aid 0x0311 (SuppFeatures)

                 uint 0x17

          record #4

              aid 0x0000 (SrvRecHndl)

                 uint 0x10005

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1105 (OBEXObjPush) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xc > <

                 uuid-16 0x0008 (OBEX) > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "OBEX Object Push"

              aid 0x0303 (SuppFormatsList)

                 < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6 uint 0xff >

          record #5

              aid 0x0000 (SrvRecHndl)

                 uint 0x10006

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x112f (PBAP PSE) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0x13 > <

                 uuid-16 0x0008 (OBEX) > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1130 (PBAP) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "OBEX Phonebook Access Server"

              aid 0x0314 (SuppRepositories)

                 uint 0x1

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 2

> ACL data: handle 256 flags 0x02 dlen 24

    L2CAP(d): cid 0x0041 len 20 [psm 1]

        SDP SSA Req: tid 0x1 len 0xf

          pat uuid-16 0x1200 (PNPInfo)

          max 1016

          aid(s) 0x0000 - 0xffff

          cont 00

< ACL data: handle 256 flags 0x00 dlen 88

    L2CAP(d): cid 0x0040 len 84 [psm 1]

        SDP SSA Rsp: tid 0x1 len 0x4f

          count 76

          record #0

              aid 0x0000 (SrvRecHndl)

                 uint 0x10000

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1200 (PNPInfo) >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1200 (PNPInfo) uint 0x102 > >

              aid 0x0200 (VersionNumList)

                 uint 0x102

              aid 0x0201 (SrvDBState)

                 uint 0xa

              aid 0x0202 (unknown)

                 uint 0x0

              aid 0x0203 (unknown)

                 uint 0x0

              aid 0x0204 (unknown)

                 bool 0x1

              aid 0x0205 (unknown)

                 uint 0x2

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0042

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

< ACL data: handle 256 flags 0x00 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0

      Connection successful

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1024

< ACL data: handle 256 flags 0x00 dlen 18

    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4

      MTU 1024

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

> ACL data: handle 256 flags 0x02 dlen 24

    L2CAP(d): cid 0x0040 len 20 [psm 1]

        SDP SSA Req: tid 0x0 len 0xf

          pat uuid-16 0x0100 (L2CAP)

          max 1016

          aid(s) 0x0000 - 0xffff

          cont 00

< ACL data: handle 256 flags 0x00 dlen 339

< ACL data: handle 256 flags 0x01 dlen 214

    L2CAP(d): cid 0x0042 len 549 [psm 1]

        SDP SSA Rsp: tid 0x0 len 0x220

          count 541

          record #0

              aid 0x0000 (SrvRecHndl)

                 uint 0x10001

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x110a (AudioSource) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <

                 uuid-16 0x0019 (AVDTP) uint 0x100 > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "Audio Source"

              aid 0x0311 (SuppFeatures)

                 uint 0xf

          record #1

              aid 0x0000 (SrvRecHndl)

                 uint 0x10002

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x110c (AVRemTarget) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <

                 uuid-16 0x0017 (AVCTP) uint 0x100 > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x110e (AVRemote) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "AVRCP TG"

              aid 0x0311 (SuppFeatures)

                 uint 0xf

          record #2

              aid 0x0000 (SrvRecHndl)

                 uint 0x10003

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xa > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >

              aid 0x0100 (SrvName)

                 str "Voice Gateway"

              aid 0x0301 (SuppDataStoresList)

                 uint 0x1

              aid 0x0311 (SuppFeatures)

                 uint 0x7

          record #3

              aid 0x0000 (SrvRecHndl)

                 uint 0x10004

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xb > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1108 (Headset) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "Voice Gateway"

              aid 0x0301 (SuppDataStoresList)

                 uint 0x1

              aid 0x0311 (SuppFeatures)

                 uint 0x17

          record #4

              aid 0x0000 (SrvRecHndl)

                 uint 0x10005

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1105 (OBEXObjPush) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0xc > <

                 uuid-16 0x0008 (OBEX) > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "OBEX Object Push"

              aid 0x0303 (SuppFormatsList)

                 < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6 uint 0xff >

          record #5

              aid 0x0000 (SrvRecHndl)

                 uint 0x10006

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x112f (PBAP PSE) >

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) > <

                 uuid-16 0x0003 (RFCOMM) uint 0x13 > <

                 uuid-16 0x0008 (OBEX) > >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1130 (PBAP) uint 0x100 > >

              aid 0x0100 (SrvName)

                 str "OBEX Phonebook Access Server"

              aid 0x0314 (SuppRepositories)

                 uint 0x1

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 2

> ACL data: handle 256 flags 0x02 dlen 24

    L2CAP(d): cid 0x0040 len 20 [psm 1]

        SDP SSA Req: tid 0x1 len 0xf

          pat uuid-16 0x1200 (PNPInfo)

          max 1016

          aid(s) 0x0000 - 0xffff

          cont 00

< ACL data: handle 256 flags 0x00 dlen 88

    L2CAP(d): cid 0x0042 len 84 [psm 1]

        SDP SSA Rsp: tid 0x1 len 0x4f

          count 76

          record #0

              aid 0x0000 (SrvRecHndl)

                 uint 0x10000

              aid 0x0001 (SrvClassIDList)

                 < uuid-16 0x1200 (PNPInfo) >

              aid 0x0005 (BrwGrpList)

                 < uuid-16 0x1002 (PubBrwsGrp) >

              aid 0x0009 (BTProfileDescList)

                 < < uuid-16 0x1200 (PNPInfo) uint 0x102 > >

              aid 0x0200 (VersionNumList)

                 uint 0x102

              aid 0x0201 (SrvDBState)

                 uint 0xa

              aid 0x0202 (unknown)

                 uint 0x0

              aid 0x0203 (unknown)

                 uint 0x0

              aid 0x0204 (unknown)

                 bool 0x1

              aid 0x0205 (unknown)

                 uint 0x2

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

> ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0042

< ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0042

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

< HCI Command: Disconnect (0x01|0x0006) plen 3

    handle 256 reason 0x13

    Reason: Remote User Terminated Connection

> HCI Event: Command Status (0x0f) plen 4

    Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 256 reason 0x16

    Reason: Connection Terminated by Local Host

Change-Id: I874fea5e23505c716c26baf0d08a2811f3ef556d
---
 src/device.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5328db9..fe11569 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2020,16 +2020,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 	 * before SDP. This is due to potential IOP issues if the other
 	 * end starts doing SDP at the same time as us */
 	if (bonding) {
-		/* If we are initiators remove any discovery timer and just
-		 * start discovering services directly */
-		if (device->discov_timer) {
-			g_source_remove(device->discov_timer);
-			device->discov_timer = 0;
-		}
-
-		device_browse(device, bonding->conn, bonding->msg,
-				NULL, FALSE);
-
+		debug("Setting timer for Intiator service discovery");
+		device->discov_timer = g_timeout_add(
+							1000,
+							start_discovery,
+							device);
+		
 		bonding_request_free(bonding);
 	} else {
 		if (!device->browse && !device->discov_timer &&
-- 
1.7.0.4

