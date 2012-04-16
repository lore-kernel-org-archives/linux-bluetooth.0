Return-Path: <cyrus@holtmann.org>
Message-ID: <4F8C6238.2040809@tu-ilmenau.de>
Date: Mon, 16 Apr 2012 20:17:28 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: connection problem with pand command
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I think I didn't asked my question "the smart way", so I try to do it

now:
I already searched the internet and asked in forums, but I didn't find

an answer to my question. And I have to say that english isn't my native

language, so I hope you understand what I try to say.
The problem is that since I installed BlueZ-4.99 and the sspdebug mode

patch, my connection via "pand"-command doesn't work (With BlueZ-4.98 &

without this patch it worked!)
I have two gentoo-PCs and try to connect this way:
PC2 # sdptool add NAP
PC2 # pand -s -r NAP -M
PC1 # pand -c <bd-address>

You find the whole hcidump message down below in this email. It looks

like a security block problem. But I don't know how to change my

security configuration. I found this file:

/usr/src/linux/include/net/bluetooth/bluetooth.h

and uncommented this line:

define BT_SECURITY_LOW    1

But this dind't helped.
So I hope you can tell me how I can set up my security configuration

appropriately or something else to get this pand-connection worked.

Thanks and best regards,
Steffen



hcidump:

HCI sniffer - Bluetooth packet analyzer ver 2.3
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:72:24:02:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:24:02:04 role 0x01
     Role: Slave
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 12 bdaddr 00:02:72:24:02:04 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 12
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 12 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 12
     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 12 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 12 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:02:72:24:02:04 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:02:72:24:02:04 name 'bluetooth2-0'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
     handle 12
 > HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:24:02:04
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
     bdaddr 00:02:72:24:02:04
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 00:02:72:24:02:04
 > HCI Event: IO Capability Request (0x31) plen 6
     bdaddr 00:02:72:24:02:04
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
     bdaddr 00:02:72:24:02:04 capability 0x03 oob 0x00 auth 0x00
     Capability: NoInputNoOutput (OOB data not present)
     Authentication: No Bonding (No MITM Protection)
 > HCI Event: Command Complete (0x0e) plen 10
     IO Capability Request Reply (0x01|0x002b) ncmd 1
     status 0x00 bdaddr 00:02:72:24:02:04
 > HCI Event: IO Capability Response (0x32) plen 9
     bdaddr 00:02:72:24:02:04 capability 0x03 oob 0x00 auth 0x00
     Capability: NoInputNoOutput (OOB data not present)
     Authentication: No Bonding (No MITM Protection)
 > HCI Event: User Confirmation Request (0x33) plen 10
     bdaddr 00:02:72:24:02:04 passkey 841201
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
     bdaddr 00:02:72:24:02:04
 > HCI Event: Command Complete (0x0e) plen 10
     User Confirmation Request Reply (0x01|0x002c) ncmd 1
     status 0x00 bdaddr 00:02:72:24:02:04
 > HCI Event: Simple Pairing Complete (0x36) plen 7
     status 0x00 bdaddr 00:02:72:24:02:04
 > HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:02:72:24:02:04 key 9274E71DA45B54A19A6614DED3E4DA9D type 4
     Type: Unauthenticated Combination Key
 > HCI Event: Auth Complete (0x06) plen 3
     status 0x00 handle 12
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
     handle 12 encrypt 0x01
 > HCI Event: Command Status (0x0f) plen 4
     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 12 encrypt 0x01
< ACL data: handle 12 flags 0x00 dlen 10
     L2CAP(s): Info req: type 2
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x00b8
         Enhanced Retransmission mode
         Streaming mode
         FCS Option
         Fixed Channels
< ACL data: handle 12 flags 0x00 dlen 10
     L2CAP(s): Info req: type 3
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Fixed channel list 0x00000002
         L2CAP Signalling Channel
< ACL data: handle 12 flags 0x00 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
       Connection pending - No futher information available
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x00b8
         Enhanced Retransmission mode
         Streaming mode
         FCS Option
         Fixed Channels
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Fixed channel list 0x00000002
         L2CAP Signalling Channel
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
       Connection refused - security block
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 12 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 12 reason 0x16
     Reason: Connection Terminated by Local Host
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
     bdaddr 00:02:72:24:02:04 all 0
 > HCI Event: Command Complete (0x0e) plen 6
     Delete Stored Link Key (0x03|0x0012) ncmd 1
     status 0x00 deleted 0
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:72:24:02:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:24:02:04 role 0x01
     Role: Slave
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 12 bdaddr 00:02:72:24:02:04 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 12
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 12 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 12
     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 12 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 12 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:02:72:24:02:04 mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x00 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
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
< ACL data: handle 12 flags 0x00 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
       Connection pending - No futher information available
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
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:02:72:24:02:04 name 'bluetooth2-0'
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
       RFC 0x00 (Basic)
 > ACL data: handle 12 flags 0x02 dlen 23
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
       RFC 0x00 (Basic)
< ACL data: handle 12 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 12 flags 0x00 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 676
     L2CAP(d): cid 0x0040 len 672 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x29b
           count 656
           cont 08 8C 30 84 4F 90 02 00 00
< ACL data: handle 12 flags 0x00 dlen 32
     L2CAP(d): cid 0x0040 len 28 [psm 1]
         SDP SSA Req: tid 0x1 len 0x17
           pat uuid-16 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 08 8C 30 84 4F 90 02 00 00
 > ACL data: handle 12 flags 0x02 dlen 81
     L2CAP(d): cid 0x0040 len 77 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x48
           count 69
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
< uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio)

 >
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
< uuid-16 0x1116 (NAP) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0xf > <
                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x10 uint 0x20

uint 0x30 uint 0x40 > > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1116 (NAP) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Network Access Point Service"
           record #5
               aid 0x0000 (SrvRecHndl)
                  uint 0x10005
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1116 (NAP) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0xf > <
                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint

0x806 > > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
< uint 0x656e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1116 (NAP) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Network Access Point"
               aid 0x0101 (SrvDesc)
                  str "BlueZ PAN Service"
               aid 0x0102 (ProviderName)
                  str "BlueZ PAN"
               aid 0x030a (SecurityDescription)
                  uint 0x0
               aid 0x030b (NetAccessType)
                  uint 0xfffe
               aid 0x030c (MaxNetAccessRate)
                  uint 0x0
           record #6
               aid 0x0000 (SrvRecHndl)
                  uint 0x10006
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1116 (NAP) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0xf > <
                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x10 uint 0x20

uint 0x30 uint 0x40 > > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1116 (NAP) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Network Access Point Service"
           cont 00
< ACL data: handle 12 flags 0x00 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x2 len 0xf
           pat uuid-16 0x1200 (PNPInfo)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x2 len 0x5
           count 2
           cont 00
< ACL data: handle 12 flags 0x00 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 12 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 12 reason 0x16
     Reason: Connection Terminated by Local Host


