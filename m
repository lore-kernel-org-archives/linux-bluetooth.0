Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051206105022.97910.qmail@web32008.mail.mud.yahoo.com>
From: Paul Gustilo <pgustilo@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206015531.25270.qmail@web32002.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] problem clearing the bluetooth link after the opp transaction
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 6 Dec 2005 02:50:22 -0800 (PST)

Hi Marcel,

  Can not clear the bluetooth link after the first opp
transaction. 

HCIDUMP trace below:

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff

/ # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0F:DE:98:ED:B0 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0F:DE:98:ED:B0
type ACL encrypt 0x00
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Page Scan Repetition Mode Change (0x20)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status
0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0048
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 674
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1107 (IRMCSyncCmd)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 42
    L2CAP(d): cid 0x0040 len 38 [psm 1]
        SDP SSA Req: tid 0x0 len 0x21
          pat uuid-128
00000001-0000-1000-8000-0002ee000002
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0100 (SrvName)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName) 0x0303 (SuppFormatsList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 85
    L2CAP(d): cid 0x0048 len 81 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x4c
          count 73
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x4 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 uint 0xff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 43
    L2CAP(d): cid 0x0040 len 39 [psm 1]
        SDP SSA Req: tid 0x0 len 0x22
          pat uuid-16 0x111b (ImagingResp)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName) 0x0310 (unknown) 0x0311 (unknown) 0x0312
(unknown) 0x0313 (unknown)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 43
    L2CAP(d): cid 0x0040 len 39 [psm 1]
        SDP SSA Req: tid 0x0 len 0x22
          pat uuid-16 0x111b (ImagingResp)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName) 0x0310 (unknown) 0x0311 (unknown) 0x0312
(unknown) 0x0313 (unknown)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 43
    L2CAP(d): cid 0x0040 len 39 [psm 1]
        SDP SSA Req: tid 0x0 len 0x22
          pat uuid-16 0x111b (ImagingResp)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName) 0x0310 (unknown) 0x0311 (unknown) 0x0312
(unknown) 0x0313 (unknown)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1101 (SP)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 70
    L2CAP(d): cid 0x0048 len 66 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x3d
          count 58
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1101 (SP) uint 0x100 >
>
              aid 0x0100 (SrvName)
                 str "Serial Port"
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0F:DE:98:ED:B0 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0F:DE:98:ED:B0
type ACL encrypt 0x00
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
    handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Page Scan Repetition Mode Change (0x20)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status
0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0049
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049
result 0 status 0
      Connection successful
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 674
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTProfileDescList) 0x0100
(SrvName) 0x0303 (SuppFormatsList)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 85
    L2CAP(d): cid 0x0049 len 81 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x4c
          count 73
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x4 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 uint 0xff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0049
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0049
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0F:DE:98:ED:B0 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr 00:0F:DE:98:ED:B0
type ACL encrypt 0x00
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
    handle 43 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Page Scan Repetition Mode Change (0x20)
plen 7
    bdaddr 00:0F:DE:98:ED:B0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status
0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 43 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004a
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 674
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004a flags 0x00
result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 28
    L2CAP(d): cid 0x0040 len 24 [psm 1]
        SDP SSA Req: tid 0x0 len 0x13
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0303 (SuppFormatsList)
          cont 00
< ACL data: handle 43 flags 0x02 dlen 51
    L2CAP(d): cid 0x004a len 47 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2a
          count 39
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x4 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0303 (SuppFormatsList)
                 uint 0xff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x004b
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004b
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 674
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004b flags 0x00
result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen
4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 4
      Success
      MTU 674
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x1c
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 15
ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x004b len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs
0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 15
ack_timer 0
      frame_size 330 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs
0xc9
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0
len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1
len 10
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0
len 0
> ACL data: handle 43 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1
len 10
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 33
> ACL data: handle 43 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 7 fcs 0x46
credits 13
        OBEX: Connect cmd(f): len 7 version 1.0 flags
0 mtu 1024
< ACL data: handle 43 flags 0x02 dlen 15
    L2CAP(d): cid 0x004b len 11 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 7 fcs 0x80
        OBEX: Connect rsp(f): status 200 len 7 version
1.1 flags 0 mtu 1024
        Status 200 = Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016
        Name (0x01) = Unicode length 26
        0000: 00 44 00 53 00 43 00 30  00 30 00 30 00
30 00 38  .D.S.C.0.0.0.0.8
        0010: 00 2e 00 4a 00 50 00 47  00 00          
         ...J.P.G..
        Length (0xc3) = 210986
        Body (0x48) = Sequence length 976
        0000: ff d8 ff e1 19 da 45 78  69 66 00 00 49
49 2a 00  ......Exif..II*.
        0010: 08 00 00 00 09 00 0f 01  02 00 0e 00 00
00 7a 00  ..............z.
        0020: 00 00 10 01 02 00 06 00  00 00 9a 00 00
00 12 01  ................
        0030: 03 00 01 00 00 00 01 00  00 00 1a 01 05
00 01 00  ................
        0040: 00 00 aa 00 00 00 1b 01  05 00 01 00 00
00 b2 00  ................
        0050: 00 00 28 01 03 00 01 00  00 00 02 00 00
00 32 01  ..(...........2.
        0060: 02 00 14 00 00 00 ba 00  00 00 13 02 03
00 01 00  ................
        0070: 00 00 02 00 00 00 69 87  04 00 01 00 00
00 ce 00  ......i.........
        0080: 00 00 4a 02 00 00 53 6f  6e 79 20 45 72
69 63 73  ..J...Sony Erics
        0090: 73 6f 6e 00 00 00 00 00  00 00 00 00 00
00 00 00  son.............
        00a0: 00 00 00 00 00 00 53 37  30 30 69 00 00
00 00 00  ......S700i.....
        00b0: 00 00 00 00 00 00 48 00  00 00 01 00 00
00 48 00  ......H.......H.
        00c0: 00 00 01 00 00 00 32 30  30 35 3a 30 38
3a 31 30  ......2005:08:10
        00d0: 20 31 34 3a 33 38 3a 33  35 00 16 00 9a
82 05 00   14:38:35.......
        00e0: 01 00 00 00 dc 01 00 00  9d 82 05 00 01
00 00 00  ................
        00f0: e4 01 00 00 27 88 03 00  01 00 00 00 40
06 00 00  ....'.......@...
        0100: 00 90 07 00 04 00 00 00  30 32 32 30 03
90 02 00  ........0220....
        0110: 14 00 00 00 ec 01 00 00  04 90 02 00 14
00 00 00  ................
        0120: 00 02 00 00 01 91 07 00  04 00 00 00 01
02 03 00  ................
        0130: 01 92 0a 00 01 00 00 00  14 02 00 00 04
92 0a 00  ................
        0140: 01 00 00 00 1c 02 00 00  07 92 03 00 01
00 00 00  ................
        0150: 03 00 00 00 08 92 03 00  01 00 00 00 00
00 00 00  ................
        0160: 09 92 03 00 01 00 00 00  00 00 00 00 00
a0 07 00  ................
        0170: 04 00 00 00 30 31 30 30  01 a0 03 00 01
00 00 00  ....0100........
        0180: 01 00 00 00 02 a0 04 00  01 00 00 00 00
05 00 00  ................
        0190: 03 a0 04 00 01 00 00 00  c0 03 00 00 05
a0 04 00  ................
        01a0: 01 00 00 00 2c 02 00 00  01 a4 03 00 01
00 00 00  ....,...........
        01b0: 00 00 00 00 02 a4 03 00  01 00 00 00 00
00 00 00  ................
        01c0: 03 a4 03 00 01 00 00 00  00 00 00 00 04
a4 05 00  ................
        01d0: 01 00 00 00 24 02 00 00  06 a4 03 00 01
00 00 00  ....$...........
        01e0: 00 00 00 00 00 00 00 00  01 00 00 00 07
00 00 00  ................
        01f0: 04 00 00 00 01 00 00 00  32 30 30 35 3a
30 38 3a  ........2005:08:
        0200: 31 30 20 31 34 3a 33 38  3a 33 35 00 32
30 30 35  10 14:38:35.2005
        0210: 3a 30 38 3a 31 30 20 31  34 3a 33 38 3a
33 35 00  :08:10 14:38:35.
        0220: 02 00 00 00 01 00 00 00  00 00 00 00 0a
00 00 00  ................
        0230: 00 01 00 00 8c 00 00 00  02 00 01 00 02
00 04 00  ................
        0240: 00 00 52 39 38 00 02 00  07 00 04 00 00
00 30 31  ..R98.........01
        0250: 30 30 00 00 00 00 07 00  03 01 03 00 01
00 00 00  00..............
        0260: 06 00 00 00 12 01 03 00  01 00 00 00 01
00 00 00  ................
        0270: 1a 01 05 00 01 00 00 00  a4 02 00 00 1b
01 05 00  ................
        0280: 01 00 00 00 ac 02 00 00  28 01 03 00 01
00 00 00  ........(.......
        0290: 02 00 00 00 01 02 04 00  01 00 00 00 b4
02 00 00  ................
        02a0: 02 02 04 00 01 00 00 00  1e 17 00 00 00
00 00 00  ................
        02b0: 48 00 00 00 01 00 00 00  48 00 00 00 01
00 00 00  H.......H.......
        02c0: ff d8 ff db 00 84 00 08  06 06 07 06 05
08 07 07  ................
        02d0: 07 09 09 08 0a 0c 14 0d  0c 0b 0b 0c 19
12 13 0f  ................
        02e0: 14 1d 1a 1f 1e 1d 1a 1c  1c 20 24 2e 27
20 22 2c  ......... $.' ",
        02f0: 23 1c 1c 28 37 29 2c 30  31 34 34 34 1f
27 39 3d  #..(7),01444.'9=
        0300: 38 32 3c 2e 33 34 32 01  09 09 09 0c 0b
0c 18 0d  82<.342.........
        0310: 0d 18 32 21 1c 21 32 32  32 32 32 32 32
32 32 32  ..2!.!2222222222
        0320: 32 32 32 32 32 32 32 32  32 32 32 32 32
32 32 32  2222222222222222
        0330: 32 32 32 32 32 32 32 32  32 32 32 32 32
32 32 32  2222222222222222
        0340: 32 32 32 32 32 32 32 32  ff c0 00 11 08
00 78 00  22222222......x.
        0350: a0 03 01 21 00 02 11 01  03 11 01 ff c4
01 a2 00  ...!............
        0360: 00 01 05 01 01 01 01 01  01 00 00 00 00
00 00 00  ................
        0370: 00 01 02 03 04 05 06 07  08 09 0a 0b 10
00 02 01  ................
        0380: 03 03 02 04 03 05 05 04  04 00 00 01 7d
01 02 03  ............}...
        0390: 00 04 11 05 12 21 31 41  06 13 51 61 07
22 71 14  .....!1A..Qa."q.
        03a0: 32 81 91 a1 08 23 42 b1  c1 15 52 d1 f0
24 33 62  2....#B...R..$3b
        03b0: 72 82 09 0a 16 17 18 19  1a 25 26 27 28
29 2a 34  r........%&'()*4
        03c0: 35 36 37 38 39 3a 43 44  45 46 47 48 49
4a 53 54  56789:CDEFGHIJST
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 55 56 57 58 59 5a 63 64  65 66 67 68 69
6a 73 74  UVWXYZcdefghijst
        0010: 75 76 77 78 79 7a 83 84  85 86 87 88 89
8a 92 93  uvwxyz..........
        0020: 94 95 96 97 98 99 9a a2  a3 a4 a5 a6 a7
a8 a9 aa  ................
        0030: b2 b3 b4 b5 b6 b7 b8 b9  ba c2 c3 c4 c5
c6 c7 c8  ................
        0040: c9 ca d2 d3 d4 d5 d6 d7  d8 d9 da e1 e2
e3 e4 e5  ................
        0050: e6 e7 e8 e9 ea f1 f2 f3  f4 f5 f6 f7 f8
f9 fa 01  ................
        0060: 00 03 01 01 01 01 01 01  01 01 01 00 00
00 00 00  ................
        0070: 00 01 02 03 04 05 06 07  08 09 0a 0b 11
00 02 01  ................
        0080: 02 04 04 03 04 07 05 04  04 00 01 02 77
00 01 02  ............w...
        0090: 03 11 04 05 21 31 06 12  41 51 07 61 71
13 22 32  ....!1..AQ.aq."2
        00a0: 81 08 14 42 91 a1 b1 c1  09 23 33 52 f0
15 62 72  ...B.....#3R..br
        00b0: d1 0a 16 24 34 e1 25 f1  17 18 19 1a 26
27 28 29  ...$4.%.....&'()
        00c0: 2a 35 36 37 38 39 3a 43  44 45 46 47 48
49 4a 53  *56789:CDEFGHIJS
        00d0: 54 55 56 57 58 59 5a 63  64 65 66 67 68
69 6a 73  TUVWXYZcdefghijs
        00e0: 74 75 76 77 78 79 7a 82  83 84 85 86 87
88 89 8a  tuvwxyz.........
        00f0: 92 93 94 95 96 97 98 99  9a a2 a3 a4 a5
a6 a7 a8  ................
        0100: a9 aa b2 b3 b4 b5 b6 b7  b8 b9 ba c2 c3
c4 c5 c6  ................
        0110: c7 c8 c9 ca d2 d3 d4 d5  d6 d7 d8 d9 da
e2 e3 e4  ................
        0120: e5 e6 e7 e8 e9 ea f2 f3  f4 f5 f6 f7 f8
f9 fa ff  ................
        0130: da 00 0c 03 01 00 02 11  03 11 00 3f 00
f3 bf dd  ...........?....
        0140: f3 9e 3f 0a 97 f7 4e 39  65 04 76 23 15
03 15 d1  ..?...N9e.v#....
        0150: 0f 45 53 cf 25 89 3f d3  e9 42 48 43 7c
ac b8 c7  .ES.%.?..BHC|...
        0160: 20 12 33 f8 d3 10 14 01  b7 85 19 ff 00
7b a5 3d   .3..........{.=
        0170: 09 75 6c 83 91 d3 2d c5  00 38 44 39 cc
80 2f 6c  .ul...-..8D9../l
        0180: 86 e3 fc f1 4f 48 c3 29  66 c0 5f 6f c2
80 14 00  ....OH.)f._o....
        0190: cc 36 e0 76 5c a0 19 fd  69 8f 14 ae 78
0a 71 8c  .6.v\...i...x.q.
        01a0: 6e 8f ad 00 39 e4 93 05  37 30 53 c6 de
c3 8a 6c  n...9...70S....l
        01b0: 68 76 1d a4 27 6e 4f f4  a3 60 25 d8 41
5e 32 7a  hv..'nO..`%.A^2z
        01c0: 36 18 8a 81 a1 40 c5 95  62 40 b8 18 2d
93 fc e8  6....@..b@..-...
        01d0: 40 06 36 70 46 ec e4 74  24 50 04 a5 19
3c b1 9c  @.6pF..t$P...<..
        01e0: f2 49 eb f8 d1 a0 86 79  53 02 31 b0 03
d4 02 56  .I.....yS.1....V
        01f0: 91 e0 50 77 9c 83 9c e7  77 4f 7c 75 a0
63 96 32  ..Pw....wO|u.c.2
        0200: c3 1e 5c 9c 7b f1 f9 7e  14 8f 0e c0 5c
71 df 05  ..\.{..~....\q..
        0210: 48 c7 e9 8a 62 21 0d 26  3f 74 30 be 9b
e9 e5 98  H...b!.&?t0.....
        0220: 3f 0a ea d8 ea 58 91 fa  8a 5a 0c 54 12
07 f9 95  ?....X...Z.T....
        0230: 88 3d 72 4f 3f 85 3d 5f  cc 62 a2 3e 4f
63 df f4  .=rO?.=_.b.>Oc..
        0240: a1 01 24 a8 40 fb 81 7e  a3 6e 28 46 2a
e3 61 04  ..$.@..~.n(F*.a.
        0250: 74 c1 f9 a9 80 28 25 8b  0c 0e ff 00 36
3f 97 6a  t....(%.....6?.j
        0260: 7c b1 12 bb 87 3d b8 50  bf 9e 29 3d 04
28 51 83  |....=.P..)=.(Q.
        0270: 88 d7 a6 3e eb 1f d4 71  4a b1 64 67 e5
c6 38 50  ...>...qJ.dg..8P
        0280: a7 1f ca 98 c1 08 31 80  b1 87 39 e0 e0
0f f1 a7  ......1...9.....
        0290: a2 ab 27 fa a0 bd 32 18  7f 2e 45 20 17
6a 97 65  ..'...2...E .j.e
        02a0: 03 1e c1 07 1f 8e 7d aa  3d 8c 99 09 16
7d 9b fc  ......}.=....}..
        02b0: 0d 00 24 61 d9 76 b4 41  08 ea cc 09 fe
54 ef 2d  ..$a.v.A.....T.-
        02c0: 37 06 0c 98 f4 e7 fa d3  10 d3 0c 05 b2
d3 85 cf  7...............
        02d0: 41 ce 3f 95 0f 12 6e c1  94 30 e9 c2 e2
90 c1 17  A.?...n..0......
        02e0: 0e 15 48 2b db e5 07 1f  99 a8 32 43 ba
10 37 e3  ..H+......2C..7.
        02f0: 81 eb 40 88 57 80 31 8c  e7 ae 28 f2 d6
3c 02 54  ..@.W.1...(..<.T
        0300: 1f 42 a0 93 fa d0 51 27  96 3e ff 00 ee
c6 ee 06  .B....Q'.>......
        0310: 40 5a 93 ca 9f 04 34 2b  f2 fa 7a 7f 5a
04 3a 36  @Z....4+..z.Z.:6
        0320: de 42 60 03 8c 1c e7 8f  6e 4d 3c c6 58
61 5d 15  .B`.....nM<.Xa].
        0330: 7a 1f 7f ce 80 14 01 b8  15 32 8c 13 8c
b0 1b 71  z........2.....q
        0340: 42 da 92 e4 91 99 01 ea  08 cf f3 a0 44
bf 32 b1  B...........D.2.
        0350: 56 20 1c 67 e6 24 f4 f6  a4 2e d8 ff 00
5a 57 3f  V .g.$.......ZW?
        0360: dc 07 b5 00 2b cc b9 04  c9 d3 a2 f6 3f
5e 41 a6  ....+.......?^A.
        0370: 34 85 8e 06 dc 0e 00 53  8c fd 71 4c 62
97 3f c4  4......S..qLb.?.
        0380: 09 e8 73 e6 7f f5 f1 42  e2 4c 60 04 61
e8 e0 f1  ..s....B.L`.a...
        0390: ef d6 80 01 1a a7 dd 25  73 d7 8c 7f 4a
9d 76 40  .......%s...J.v@
        03a0: bc 3a b6 79 db b0 71 fe  7d e9 08 8b 69
90 10 24  .:.y..q.}...i..$
        03b0: 0c 7b 8d a3 9f ca 9c aa  e4 10 32 fe e3
27 f2 c5  .{........2..'..
        03c0: 00 56 96 31 8e 62 70 7a  12 14 e0 d3 42
18 d1 b1  .V.1.bpz....B...
        03d0: 90 be f1 81 f4 a0 64 1b  70 7e 69 30 4e
06 39 19  ......d.p~i0N.9.
        03e0: a4 61 96 dc 4b 37 39 dd  eb fa 66 81 8f
03 05 80  .a..K79...f.....
        03f0: e0 67                                   
         .g
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: a6 ef cb 9a 15 08 6f ba  a7 8e 77 0d d8
fe 74 d0  ......o...w...t.
        0010: 89 96 3c e3 2c bc f7 03  a7 e4 29 cd 04
40 61 99  ..<.,.....)..@a.
        0020: 03 75 3f 2f 6f 5e 94 80  98 24 68 a5 8c
aa 7b fb  .u?/o^...$h...{.
        0030: e3 fe f9 a6 ab 44 cd 85  7c 8c 76 1f fd
6a 10 13  .....D..|.v..j..
        0040: 0c 28 fd d9 dc 41 ed b4  0a 50 ce 77 2b
83 8c e0  .(...A...P.w+...
        0050: fc c3 19 fc 29 80 d2 f2  33 9d a0 03 db
63 12 0f  ....)...3....c..
        0060: d7 ad 28 f3 37 1e 13 db  38 39 a0 05 25
e2 2a cb  ..(.7...89..%.*.
        0070: 86 6c f2 11 86 3f 20 0f  eb 4d fb ec 4e
18 8c f3  .l...? ..M..N...
        0080: d7 f3 ed e9 48 04 2c ad  24 6a 56 33 b7
a1 04 90  ....H.,.$jV3....
        0090: 3f ad 3c 2b 6e f5 21 78  e1 86 7f 2a 60
40 d9 3b  ?.<+n.!x...*`@.;
        00a0: b1 2c 7c fd d5 2d c7 ea  2a ce 9b 65 26
a1 3f 90  .,|..-..*..e&.?.
        00b0: a0 6e c8 e3 7a 81 df 93  e8 30 39 34 80
d8 bf b7  .n..z....094....
        00c0: 5b 79 be c2 ad 14 92 63  77 99 b9 76 a1
cf 4f e2  [y.....cw..v..O.
        00d0: dd c6 3b 8e b8 e7 bc 77  1e 1e bc be 8c
dc b4 50  ..;....w.......P
        00e0: c3 2b 3b 31 11 80 aa 41  e9 80 38 18 e7
a5 26 d2  .+;1...A..8...&.
        00f0: b5 8b 84 1c b6 39 24 c1  e8 ea 0e 3a 7f
91 4f 65  .....9$....:..Oe
        0100: da 49 65 0e 4f f1 63 14  12 38 23 92 30
18 7b 01  .Ie.O.c..8#.0.{.
        0110: c5 49 1c 6c 80 fc 81 d9  ba e4 60 7e 3c
53 b8 85  .I.l......`~<S..
        0120: 11 32 6c 51 08 f7 07 2b  4f 0c aa 38 8f
0f c0 3d  .2lQ...+O..8...=
        0130: b0 3f 3a 10 12 86 25 41  f9 14 8f af f5
a1 00 7e  .?:...%A.......~
        0140: 49 cf be 71 4c 07 b6 01  c6 fc fa 8c e7
fa d3 97  I..qL...........
        0150: cb 52 15 d4 9e d9 00 e3  fc fb d0 02 b0
0a 3e 51  .R............>Q
        0160: 18 ee 1b 8a 47 c2 93 b8  29 07 19 c0 eb
f9 51 60  ....G...).....Q`
        0170: 10 98 8b f3 17 24 e3 2b  c6 3f 1c 54 a2
31 36 59  .....$.+.?.T.16Y
        0180: 4b f0 39 f9 81 fe be bf  ca 8b 80 c7 2e
9f 28 0a  K.9...........(.
        0190: 41 e3 24 0c fe 9d 2a 3d  b2 7f 14 80 0f
67 cf f5  A.$...*=.....g..
        01a0: a0 0a ec 09 38 0c 98 c7  19 19 39 f6 ab
ba 15 d3  ....8.....9.....
        01b0: c1 af 42 aa d1 2a c8 ad  17 0a 00 c9 04
0e a3 df  ..B..*..........
        01c0: 1f 8d 20 46 96 af 6b 73  1e b0 24 69 18
0d b0 ba  .. F..ks..$i....
        01d0: a1 39 dc 0a 8c fa 1e 30  47 4c 7b f4 cf
71 70 d1  .9.....0GL{..qp.
        01e0: a6 8c 15 53 73 43 16 e6  da 39 c0 19 27
f9 9a ca  ...SsC...9..'...
        01f0: 5a a5 63 aa 86 97 67 8e  aa 1e 48 0b 9e
bc 67 23  Z.c...g...H...g#
        0200: e9 53 ca 8c 30 1f 79 62  32 32 ac 3f 9d
6a 73 0d  .S..0.yb22.?.js.
        0210: 44 66 da 40 c0 c7 5d a7  14 f1 1f 6d c3
23 8f e2  Df.@..]....m.#..
        0220: 18 a0 43 f1 f3 fc c5 df  07 d3 00 fe b4
ed d2 28  ..C............(
        0230: c2 ab 05 1d 46 4e 3e 9d  69 80 e7 69 3a
f9 45 c7  ....FN>.i..i:.E.
        0240: 62 01 e3 34 e5 94 aa ed  c6 01 ea b9 38
fc bf 0a  b..4........8...
        0250: 40 39 18 48 ff 00 20 03  03 04 13 d3 df
34 e5 01  @9.H.. ......4..
        0260: 70 a3 d7 ef 06 a0 00 9c  30 2c 77 63 95
21 86 6a  p.......0,wc.!.j
        0270: 55 9f 70 db f3 f5 fe f8  c7 ea 29 80 8b
2e 0e 42  U.p.......)....B
        0280: b7 3c f0 41 c7 e9 c5 39  59 1d 77 85 fa
e0 ad 00  .<.A...9Y.w.....
        0290: 32 40 01 22 38 88 39 e4  e0 63 f4 14 c6
8c 00 77  2@."8.9..c.....w
        02a0: 60 12 31 c3 27 f2 ed 48  0a cc aa 8c 0a
bb 00 3a  `.1.'..H.......:
        02b0: 1d ca 08 18 f6 15 52 4e  2e 16 44 6c 38
21 83 1c  ......RN..Dl8!..
        02c0: 71 83 c5 30 3b 4b f9 d2  e3 49 b3 97 cb
5f 3f 1c  q..0;K...I..._?.
        02d0: 4c e9 c3 02 06 33 91 c8  e0 8f c7 eb 55
e4 bc d4  L....3......U...
        02e0: 9e d9 12 d8 96 72 19 64  c3 85 2c a7 82
0f e0 7d  .....r.d..,....}
        02f0: fa 9a c5 3b 32 b9 9f 43  9e fe c4 98 a0
22 f6 3f  ...;2..C.....".?
        0300: ae d3 57 b4 b8 6e 2d ae  cc 37 0e 24 81
c6 14 ae  ..W..n-..7.$....
        0310: 4e d6 ff 00 eb d6 71 af  19 d9 58 e8 96
1e 51 d4  N.....q...X...Q.
        0320: d4 9b 4a b6 9b 2a d6 cd  ea 76 c4 47 ea
2b 2a e6  ..J..*...v.G.+*.
        0330: cf 4f 8d d9 55 ae 14 a9  fb 88 09 c1 fa
1e 6b 6e  .O..U.........kn
        0340: 6b 23 1e 5b e8 55 fe cb  96 48 96 48 25
ca 1e 77  k#.[.U...H.H%..w
        0350: 49 0b 28 fc c6 45 34 69  93 8d f8 b8 b5
04 77 2f  I.(..E4i......w/
        0360: 54 a6 99 2e 0d 16 97 41  be 95 32 24 8c
a6 38 ee  T......A..2$..8.
        0370: 2a 58 bc 3b 7e a4 62 48  c7 d0 1a 69 a1
58 9d 3c  *X.;~.bH...i.X.<
        0380: 39 7a cb 93 34 6a 7b 80  a7 9a 91 7c 37
79 83 8b  9z..4j{....|7y..
        0390: 88 c7 3c 0d 86 8b a1 58  91 7c 37 76 ab
81 70 8a  ..<....X.|7v..p.
        03a0: 3b e0 37 d3 d6 9c 3c 37  74 ac ac 2f 3a
0f ee 1f  ;.7...<7t../:...
        03b0: f1 a2 e8 2c 2b 78 76 e5  97 fe 3e 94 9f
78 73 4c  ...,+xv...>..xsL
        03c0: 6f 0f 5c 8e 0c e8 7d bc  9f fe bd 17 41
62 3f f8  o.\...}.....Ab?.
        03d0: 46 ee 01 1b ae 41 03 b1  8c f1 fa d4 32
78 7e 72  F....A......2x~r
        03e0: 06 6e 54 0c 63 fd 5f 4f  d6 8b 85 88 9b
42 b9 24  .nT.c._O.....B.$
        03f0: 37 da                                   
         7.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 23 e3 8e 23 ff 00 eb d5  79 f4 2b c2 dc
4b f4 c2  #..#....y.+..K..
        0010: 81 8a 2e 16 26 5b cf b0  a5 bd 8d fb 6f
81 01 c2  ....&[......o...
        0020: 16 61 c1 f4 c7 4f 5e 9d  7a e4 71 56 b4
6b 9b 59  .a...O^.z.qV.k.Y
        0030: 04 11 5c df 30 5c 96 06  38 c3 33 71 d3
92 38 e3  ..\.0\..8.3q..8.
        0040: a7 d6 b0 93 49 e8 5f 2b  b1 8b 0d c4 92
2b 80 ac  ....I._+.....+..
        0050: 9b 31 d0 f5 eb 5b 1e 1e  b6 9e 6f b5 c8
ac b8 8e  .1...[....o.....
        0060: 3c 32 b1 c6 49 3c 76 e7  a1 ac a3 15 09
6a 76 cd  <2..I<v......jv.
        0070: de 9e 86 f5 a4 97 17 0c  d1 ca 00 8c 7c
a5 8e 33  ............|..3
        0080: fa e7 20 d5 ab 98 11 58  3b 8f 2c 11 b7
92 07 15  .. ....X;.,.....
        0090: 56 b3 30 86 ba 32 b2 30  10 18 d5 c1 75
70 14 ee  V.0..2.0....up..
        00a0: 03 83 d3 3c 55 1d 78 88  a0 f2 9d 11 cc
91 90 57  ...<U.x........W
        00b0: fb ab fe 3f e1 55 0d c6  d5 f6 39 9f 0b
59 5f 6a  ...?.U....9..Y_j
        00c0: 57 62 28 2e 0c 0b 19 c3  c8 09 e0 1e 83
de bb 77  Wb(............w
        00d0: b6 7b 46 65 41 2d dc d1  a7 c9 1b 37 de
eb d4 9a  .{FeA-.....7....
        00e0: a9 3e 84 a8 f5 2c 0b 49  ee b4 9b ab a7
b7 92 d9  .>...,.I........
        00f0: d2 2c b4 71 0e 49 1c e4  63 fa 75 15 c6
cb aa e1  .,.q.I..c.u.....
        0100: 84 52 ea 33 c2 ca 01 dd  32 ba 06 cf 61
b4 b1 fc  .R.3....2...a...
        0110: c5 38 3d 35 22 71 bb d0  96 39 af ee 0a
08 6e 4c  .8=5"q...9....nL
        0120: f9 fb a9 1c e0 b1 fa a8  24 fe 62 9c d7
77 90 3b  ........$.b..w.;
        0130: 25 c1 99 0f 71 b8 67 3f  43 5a a4 8c 9d
d6 e5 73  %...q.g?CZ.....s
        0140: 7d 3b 38 fd fb 05 1d 39  3f d2 91 6e a5
23 2d 2b  };8....9?..n.#-+
        0150: 8f a3 9a 2c 00 65 95 be  ed c3 60 8e 8c
72 69 be  ...,.e....`..ri.
        0160: 64 8a a4 b4 a4 8e 39 6d  c3 9f c2 80 28
4f 29 1c  d.....9m....(O).
        0170: f9 bb fe 80 9c 55 7f 34  a6 30 7e 6e c3
a5 30 36  .....U.4.0~n..06
        0180: 7c 18 f7 ef af b8 82 03  2a 3a 7e f4 ed
e1 40 e8  |.......*:~...@.
        0190: 79 f5 e4 7e 15 e8 37 37  bf 62 b7 b8 95
64 85 4a  y..~..77.b...d.J
        01a0: e1 80 da 3a 6d ed 5c 95  1a 72 e5 ea 6b
14 d4 6e  ...:m.\..r..k..n
        01b0: 79 d5 bd bb c5 69 2c 92  a1 42 cd 8a e8
fc 1d c5  y....i,..B......
        01c0: bd f9 76 c4 6f 28 45 47  e5 46 06 49 c7
be 47 e4  ..v.o(EG.F.I..G.
        01d0: 2b 2a 9a 49 b3 ad 6b 04  6d 6a 9a 52 ea
ed 0c 2b  +*.I..k.mj.R...+
        01e0: 32 46 54 16 c3 0c 86 3c  60 62 99 69 e1
3f 22 75  2FT....<`b.i.?"u
        01f0: 56 b8 b6 0d b7 e5 88 28  fd e7 e7 d0 7d
05 75 c1  V......(....}.u.
        0200: de 28 e6 71 b3 1f a9 f8  6a 68 74 f8 5e
19 44 12  .(.q....jht.^.D.
        0210: 23 ee 21 3e e1 fa f4 cd  72 3a 8e a5 b6
3b 98 af  #.!>....r:...;..
        0220: e6 53 73 36 e5 8d 00 e1  06 71 e9 c6 46
7f c9 a9  .Ss6.....q..F...
        0230: b7 bc 2d 8c bd 27 52 93  43 bc 79 92 31
2a 32 fc  ..-..'R.C.y.1*2.
        0240: e8 1b 6e 48 e8 73 83 ef  f9 d7 6f a7 ea
37 37 b6  ..nH.s....o..77.
        0250: cd 23 46 9b a5 21 81 5e  31 ed 59 55 7c
ac de 9a  .#F..!.^1.YU|...
        0260: e6 5a 1d 05 96 b9 66 90  9b 41 a6 5c 48
c0 6d 9b  .Z....f..A.\H.m.
        0270: 0c c0 12 00 ce 30 dd 39  ff 00 eb 53 b5
4f 04 e9  .....0.9...S.O..
        0280: 7e 26 8a 19 64 b6 96 cd  c6 d5 12 ac a5
8e c1 9f  ~&..d...........
        0290: 97 07 81 d7 af 3d 05 70  7b 59 d3 95 ef
72 e5 1d  .....=.p{Y...r..
        02a0: 2c 62 5d 7c 23 36 0e b7  56 d7 4d 77 6a
99 32 44  ,b]|#6..V.Mwj.2D
        02b0: 57 6c 80 7b 1c f3 df d2  b6 5e 2d 36 cb
43 10 ca  Wl.{.....^-6.C..
        02c0: e2 00 07 97 19 da 18 06  20 e0 15 3c 1e
9d c5 12  ........ ..<....
        02d0: c5 54 9c e2 e1 a0 a3 08  b8 bb 9c e4 71
5b c9 2a  .T..........q[.*
        02e0: 26 a7 e1 f8 d9 3c ad c2  ee cf 74 2a 7b
1e 3e e9  &....<....t*{.>.
        02f0: 3e dc 74 ab 51 78 5b 44  be 8c 2e 9f ab
35 bc 87  >.t.Qx[D.....5..
        0300: 8f 2e ed 70 d9 ec 01 04  02 7e 99 af 5a
15 39 95  ...p.....~..Z.9.
        0310: d1 c7 28 d9 d8 c8 d6 fc  1d ab 68 76 d2
dd c9 22  ..(.......hv..."
        0320: c9 04 64 6e 08 4f 03 38  e9 f8 8a b5 a7
5b 59 49  ..dn.O.8.....[YI
        0330: a2 59 a5 cd 94 52 bc 8a  64 76 60 43 72
78 c1 07  .Y...R..dv`Crx..
        0340: 3d 05 5d ee 4c 56 a2 dc  78 6b c3 f3 b6
fd b3 c1  =.].LV..xk......
        0350: c7 dd 8e 50 40 ff 00 be  81 fe 75 ce b7
86 ec 25  ...P@.....u....%
        0360: 77 02 ee fe 04 53 d6 5b  34 23 f3 0f 93
f8 0a 57  w....S.[4#.....W
        0370: 65 38 ae 86 c6 81 a7 d9  e9 2b 73 14 9a
d4 66 2b  e8.......+s...f+
        0380: a5 50 ac b1 ca 8c 08 cf  aa e3 bf af 15
6f 5d d2  .P...........o].
        0390: e2 d4 2c 59 62 bb 89 e4  89 58 47 89 57
e6 25 47  ..,Yb....XG.W.%G
        03a0: a9 f6 f6 ed e9 5c 8e 0f  da f3 74 35 ba
f6 7c a6  .....\....t5..|.
        03b0: 35 fd d7 f6 84 76 ec 03  24 8e 32 d0 94
2b 82 3b  5....v..$.2..+.;
        03c0: f3 f4 a5 f0 cf 99 6e 93  23 34 80 b4 c5
b3 1e 1b  ......n.#4......
        03d0: 8e 9f d2 ae 51 b9 a4 65  d0 db de ef a8
65 64 2c  ....Q..e.....ed,
        03e0: f1 80 15 8f ca 54 77 07  d2 a4 92 7b e8
a2 33 f9  .....Tw....{..3.
        03f0: 2c d3                                   
         ,.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 09 17 6c 87 92 31 8a da  0b 4b 19 4b 76
48 fa d5  ..l..1...K.KvH..
        0010: ec f0 49 05 dc ca 19 71  81 80 0e 79 15
cd eb 28  ..I....q...y...(
        0020: 8b 66 c5 8a 89 58 ae fc  e3 73 71 c1 38
fe b5 2b  .f...X...sq.8..+
        0030: e2 1c ad ca 61 5a 5b bc  f7 11 22 67 7b
38 20 fd  ....aZ[..."g{8 .
        0040: 39 fe 95 e9 36 10 6c 8e  21 e5 ae e5 3c
f5 50 79  9...6.l.!...<.Py
        0050: ef 8a e3 c5 d3 bc d4 93  b5 bf 13 a3 0e
fd d2 68  ...............h
        0060: 56 52 f7 91 41 27 d9 da  69 a4 09 2e 01
e4 0c 06  VR..A'..i.......
        0070: c7 b6 07 19 ed 5a 1e 0d  d5 92 f2 c7 fb
2d 75 78  .....Z.......-ux
        0080: ae f5 08 8b b2 6f 0d f3  1e d9 27 ef 01
c7 4e d5  .....o....'...N.
        0090: 84 a0 9c 1e 9b 30 9b b3  5e 86 ee 8d 3f
88 93 47  .....0..^...?..G
        00a0: bd 1e 20 86 14 b8 46 fd  cb c2 46 1b f2
f7 aa ba  .. ...F...F.....
        00b0: d8 b3 b8 b6 6b 89 ad a3  92 e2 32 19 4e
d0 49 3d  ....k.....2.N.I=
        00c0: 3f 3c 13 5c 33 7c b5 3d  c7 a1 74 69 f3
45 b3 9a  ?<.\3|.=..ti.E..
        00d0: d4 2e 65 92 c6 2b 24 85  a2 8d 18 3e d3
c9 3f a7  ..e..+$....>..?.
        00e0: e9 4e b2 d3 a2 95 70 f8  2f d4 8c 71 5e
e6 0e d1  .N....p./..q^...
        00f0: a6 97 7d 4e 4a f7 6f 6d  8a 5e 31 69 ac
fc 38 60  ..}NJ.om.^1i..8`
        0100: 49 9d 60 79 15 0c 7d 57  1c 9e 07 6e 47
6c 56 1d  I.`y..}W...nGlV.
        0110: bc 92 48 f0 da 5b 29 91  c2 ac 68 a0 fa
0c 57 56  ..H..[)...h...WV
        0120: 88 c1 1e 8d a0 68 ff 00  66 48 a4 b8 86
31 29 5c  .....h..fH...1)\
        0130: f2 72 6b a0 4f 2c 9f 2c  2a e3 d6 bc aa
f5 1b 96  .rk.O,.,*.......
        0140: 87 4c 63 a1 8d af f8 1b  49 d7 ad 18 c9
6d 0c 77  .Lc.....I....m.w
        0150: 24 10 b3 a4 6b b8 1f c7  a8 ff 00 3c 57
94 ea 5a  $...k......<W..Z
        0160: 76 a3 a2 2b 58 31 05 a0  21 73 1b 1c bf
d7 9c e3  v..+X1..!s......
        0170: 18 ad b0 b5 5c af 06 29  ad 2e 54 d3 75
05 8d e3  ....\..)..T.u...
        0180: 37 04 c0 a6 42 8d 3c 68  1f 0b d4 af 23
8c f1 5b  7...B.<h....#..[
        0190: 3a 70 44 32 ba ce 97 0a  cc 19 25 55 d8
19 4b 71  :pD2......%U..Kq
        01a0: c7 d0 57 4c f6 26 3b 97  1e 39 24 ba 93
c9 74 2a  ..WL.&;..9$...t*
        01b0: aa 03 05 6c 95 c7 40 47  e3 9f ca b5 ac
2f 2d a0  ...l..@G...../-.
        01c0: b3 7f b5 5d 04 21 b1 be  46 18 27 fb a0
fe 15 49  ...].!..F.'....I
        01d0: ab 0f 5b 9c d6 bd 79 a5  4b aa 07 49 e5
70 a1 b7  ..[...y.K..I.p..
        01e0: 18 88 0a 4f 1c f5 e4 60  11 d3 9c d5 1b
eb a8 6e  ...O...`.......n
        01f0: ec d6 e1 4e 63 2d 8f 4f  ce 95 fd eb 93
6d 08 74  ...Nc-.O.....m.t
        0200: 7b 8b 78 b5 58 d3 70 00  ab 10 71 d0 f1
5d 75 9d  {.x.X.p...q..]u.
        0210: d3 dc de 2c 71 ca 17 b2  9e 80 d7 36 26
4a 37 6c  ...,q......6&J7l
        0220: e8 a0 af 64 8b 97 96 f2  e9 66 d2 e0 c8
67 48 25  ...d.....f...gH%
        0230: 79 26 85 4f cf b5 b3 c8  1e 83 3f d4 f7
35 97 e0  y&.O......?..5..
        0240: 8b 6d 33 44 d7 ff 00 b5  ae 2f 62 8e df
6b 18 77  .m3D...../b..k.w
        0250: b2 96 c1 e3 a0 39 3c 71  d3 bd 72 c2 af
35 29 72  .....9<q..r..5)r
        0260: ad ce ca f8 59 49 41 c5  6b b1 dc df f8
b2 d2 fe  ....YIA.k.......
        0270: 58 ad e3 dd 14 2d 28 51  24 9c 06 ff 00
0f c6 96  X....-(Q$.......
        0280: da 15 2c d2 4e 4e 5b 2c  b9 1c 6d ec 47
e7 5e 75  ..,.NN[,..m.G.^u
        0290: 78 b8 68 6d 3c 3c b0 b4  f9 25 bb 30 bc
5d 7f 6d  x.hm<<...%.0.].m
        02a0: 6d 71 13 a1 39 71 fc 3c  67 06 b0 2d 2e
6e e5 99  mq..9q.<g..-.n..
        02b0: 24 62 ca 38 50 03 b2 e7  8e bc 57 65 09
ce 14 d6  $b.8P.....We....
        02c0: a7 0f 2a 94 ac c9 3c 69  3e ed 0e 24 66
de cb 32  ..*...<i>..$f..2
        02d0: c8 40 f9 8e 06 7f 3a c5  f0 73 ad ed cd
e9 b7 b9  .@....:..s......
        02e0: 45 ba 10 e2 32 39 da 4e  79 c7 e5 5e 9d
2a ce a5  E...29.Ny..^.*..
        02f0: 1e 69 6e 72 d4 a6 a1 53  95 1e ab e1 e8
6e a2 d3  .inr...S.....n..
        0300: 60 8b 51 9d 6e 6e 40 fd  e4 aa b8 07 9a
a9 a7 69  `.Q.nn@........i
        0310: 5a 8e 9b ae ea 17 17 5a  81 b8 b3 95 b7
40 84 9f  Z......Z.....@..
        0320: 90 7a 63 38 e3 a5 71 4d  c6 f2 d0 b4 9d
91 d2 c3  .zc8..qM........
        0330: 78 a1 00 39 c5 72 3e 31  d2 60 d4 91 ee
50 38 b8  x..9.r>1.`...P8.
        0340: 8c 15 52 a8 cd b8 67 be  05 63 87 9b 8d
44 c2 51  ..R...g..c...D.Q
        0350: d0 f2 3d 79 3f b3 ee a3  82 df c9 e1 18
9d 84 64  ..=y?..........d
        0360: 74 3c 8f ca a7 d3 ef ae  2d d2 cd 24 95
51 99 7c  t<......-..$.Q.|
        0370: bf 28 c7 c6 d0 3a e7 f0  15 eb 4b 64 89
5d 59 a5  .(...:....Kd.]Y.
        0380: 35 d4 31 4c 97 2d 21 91  ca 8c 46 a7 00
c9 8c 86  5.1L.-!...F.....
        0390: eb cb 60 63 e9 c5 73 7a  9c d7 fa 80 47
16 f3 2a  ..`c..sz....G..*
        03a0: 47 9d a0 83 b5 49 ea 41  ef ff 00 d6 aa
52 d2 e4  G....I.A.....R..
        03b0: 5b 5b 0c b5 8a 5b 88 d6  18 d3 33 93 b7
69 e4 f3  [[...[....3..i..
        03c0: db e9 ef 5d 5e 9d a2 b2  d8 cb 0c f1 23
48 91 e5  ...]^.......#H..
        03d0: 63 50 08 1f e7 b7 4e bd  ea 7b 6a 57 7b
19 36 ca  cP....N..{jW{.6.
        03e0: 97 3a 8c b1 43 07 94 d0  82 39 5c 64 f1
5a 9a 35  .:..C....9\d.Z.5
        03f0: fd bd                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 96 a7 e4 de 31 11 ba 11  bb 6e 40 3e fc
fd 6b 0c  ....1....n@>..k.
        0010: 4c 5c af ca 74 61 e4 a3  66 cd 7b ad 52
d4 3a c5  L\..ta..f.{.R.:.
        0020: 63 74 d7 57 2f d0 b4 7b  55 17 af 3e bc
0a ba 9e  ct.W/..{U..>....
        0030: 09 b8 5b 65 bb 02 37 94  f2 22 db b7 03
fb b9 07  ..[e..7.."......
        0040: 8e bd 2b 8a 2b d9 ab 3d  2e 7d 05 2c 64
29 59 4d  ..+.+..=.}.,d)YM
        0050: 6a ff 00 04 74 de 16 b6  d1 26 9c a4 ba
72 41 7c  j...t....&...rA|
        0060: 9c 6d 7e 41 c0 ea 07 f9  e9 5b fa f6 97
25 dd ab  .m~A.....[...%..
        0070: bd ac 8b 1c e1 70 a4 8c  83 8e 70 7d ab
96 b2 6a  .....p....p}...j
        0080: 6b 9c f2 f1 f3 ac b1 36  a9 2b ae 9e 87
8b 6a 6b  k......6.+....jk
        0090: 72 da 9c ff 00 6d 0e b2  a1 2a 51 bb 67
d2 97 46  r....m...*Q.g..F
        00a0: 02 cf c4 3f d9 2b 67 30  8a e0 ee 13 07
c8 5e 39  ...?.+g0......^9
        00b0: 20 74 c6 6b be 2b dc 7e  9f 91 c1 27 69
22 ce a1   t.k.+.~...'i"..
        00c0: a6 cd a7 db 7d 8e 4b b9  2e db 2c d9 7c
65 46 3a  ....}.K...,.|eF:
        00d0: 0f 6a e4 2c 61 97 c3 da  cc 17 76 57 48
ad 34 81  .j.,a.....vWH.4.
        00e0: 7e cd b7 19 56 c1 c0 3d  3d 31 ff 00 d6
ae bc 34  ~...V..==1.....4
        00f0: 1c e2 dd ac 99 95 57 66  bb a3 d6 74 af
1c 45 3c  ......Wf...t..E<
        0100: 58 0b 97 5e 1f a8 fd 2b  59 75 95 d4 1d
76 11 b4  X..^...+Yu...v..
        0110: 8a e3 ad 4a 51 6d 33 58  49 3d 51 75 65
c0 f9 4f  ...JQm3XI=Que..O
        0120: 23 d2 a1 9e f1 20 d3 a5  67 20 0d cd 92
7d 01 35  #.... ..g ...}.5
        0130: cf 18 97 23 e7 5d d2 b5  e2 fd a9 49 0c
73 21 27  ...#.].....I.s!'
        0140: 05 bd 79 ae de f9 e0 36  e7 16 49 13 8c
02 fd 80  ..y....6..I.....
        0150: fa fa 62 bd aa 9a 3b a4  72 c3 6b 0f 8b
49 96 ea  ..b...;.r.k..I..
        0160: c4 34 36 d3 3b 29 ca 82  0e 0f 1d 40 3e
d4 96 d7  .46.;).....@>...
        0170: 9a 7e 99 67 3a 4a 26 8a  e4 a7 cc 26 1b
98 f0 06  .~.g:J&....&....
        0180: d1 e8 33 93 ed 51 18 b6  ac 5d d2 77 39
13 3b c3  ..3..Q...].w9.;.
        0190: 7e 92 23 ed e4 15 f9 b1  91 d3 af e5 5d
64 fa ee  ~.#.........]d..
        01a0: 9f 0d 94 2d 69 74 e2 f2  30 ab 91 16 14
af 03 80  ...-it..0.......
        01b0: 30 3f cf d2 b4 9c 7b 19  26 ec 55 d3 24
6b 8d 6a  0?....{.&.U.$k.j
        01c0: 59 41 66 df 18 c2 91 f3  13 c6 6a 49 21
8e 39 24  YAf.......jI!.9$
        01d0: 9d f0 ac cf 8d c4 74 3f  c8 74 1f 5c d7
3c 93 3b  ......t?.t.\.<.;
        01e0: 70 95 21 49 f3 4d 5f b7  a9 bb e1 df 28
c7 33 30  p.!I.M_.....(.30
        01f0: 8d a5 c3 00 02 e7 24 8f  fe b8 ae e2 c3
54 9a 34  ......$......T.4
        0200: 86 d2 50 19 ce 06 49 eb  ef 5c 35 e2 cb
73 75 1f  ..P...I..\5..su.
        0210: 33 ea 68 5d e9 d0 df 20  2e a1 64 1d 1d
7a 8a 86  3.h]... ..d..z..
        0220: 2d 4e ea c9 52 d5 f1 20  63 b6 36 27 fc
f4 ae 38  -N..R.. c.6'...8
        0230: c9 54 5c b2 e8 75 a6 aa  d3 f6 73 e9 b1
67 55 d3  .T\..u....s..gU.
        0240: 2d a5 b5 32 cd 1a 38 b8  50 93 06 51 c8
ed cf 6c  -..2..8.P..Q...l
        0250: 13 fa d7 8f 6b 52 db 68  5a 87 92 04 93
dc c6 d8  ....kR.hZ.......
        0260: 0e 8a 43 28 ed 92 08 ea  3b 7b d7 5e 0d
ca 72 70  ..C(....;{.^..rp
        0270: 38 2a 5b d9 a9 8b a7 6b  b6 af 79 6d 79
74 cd 32  8*[....k..ymyt.2
        0280: 20 6d f1 b1 f9 ba 74 e7  eb 4e 4f 22 69
15 9a dc   m....t..NO"i...
        0290: a2 ca ca 3e 64 05 58 63  20 83 8e a3 71
1f 95 7d  ...>d.Xc ...q..}
        02a0: 06 16 0a ca 2d 1c 35 9e  a8 bb ad 5a d9
68 72 43  ....-.5....Z.hrC
        02b0: 73 6e ce a2 65 55 65 03  3f 36 01 27 8e
83 d8 f7  sn..eUe.?6.'....
        02c0: 06 bb 5d 0a ee da e3 4d  8d a3 48 f6 ed
03 03 a1  ..]....M..H.....
        02d0: 15 c3 8f 8e f6 46 98 77  74 8c 2f 14 78
8e e7 47  .....F.wt./.x..G
        02e0: 8b fd 18 22 31 60 a8 5b  90 3d eb 8d b9
d5 b5 1b  ..."1`.[.=......
        02f0: c8 8a 5d 5f fc bc 90 3b  1e 79 e0 62 b2
c3 52 8a  ..]_...;.y.b..R.
        0300: 8f 33 2a ac dd ec 53 f1  f7 f6 73 78 92
2b 5d 18  .3*...S...sx.+].
        0310: 2c 90 41 02 a3 79 78 c1  6c e4 e0 8f bd
db 9a 04  ,.A..yx.l.......
        0320: 12 c9 a7 a0 95 d9 b1 18  04 03 9e 40 ed
5d 76 f7  ...........@.]v.
        0330: 52 64 5f 56 ce af c0 3e  27 fb 4c e6 0d
46 e5 62  Rd_V...>'.L..F.b
        0340: 78 be 64 77 75 40 ca 06  00 39 1d cf 27
9e c3 de  x.dwu@...9..'...
        0350: ac f8 ce cf 4c d6 34 69  f5 6d 3f c9 92
f2 02 a1  ....L.4i.m?.....
        0360: dd 09 cb 0c 81 83 d8 e3  d7 da b0 85 e1
56 dd 0d  .............V..
        0370: 65 69 53 3c da 18 6e 23  df 2d c2 46 70
a4 01 9c  eiS<..n#.-.Fp...
        0380: 91 c1 ff 00 3f 85 74 5e  0d d2 2c 35 36
96 3b 80  ....?.t^..,56.;.
        0390: c5 98 e0 05 c0 3c 6d c6  09 fa e3 f1 ad
aa ca d1  .....<m.........
        03a0: ba 31 84 6e ec 5a bb 48  74 29 e1 59 2d
5c 83 2e  .1.n.Z.Ht).Y-\..
        03b0: e0 cc 31 b1 06 3f c4 d4  b8 d3 f0 ce 2d
65 60 c0  ..1..?......-e`.
        03c0: f2 25 6c 91 f9 f4 ac 92  76 f5 34 6d 1b
3a 1e 91  .%l.....v.4m.:..
        03d0: 0c b1 c5 a8 c6 ce be 5b  1c 23 36 78 e3
3d 47 b0  .......[.#6x.=G.
        03e0: ad db 75 6b bf 10 5b b4  23 e4 88 16 63
8f 62 3f  ..uk..[.#...c.b?
        03f0: ad 71                                   
         .q
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 57 69 a9 35 d8 de 0a d6  b9 d4 6b 77 51
69 56 2a  Wi.5......kwQiV*
        0010: 77 aa cf 31 d9 12 67 92  7b 9f c0 56 56
9b a7 6a  w..1..g.{..VV..j
        0020: 77 37 89 71 75 6f 22 c2  06 17 24 02 3d
f1 5c 34  w7.quo"...$.=.\4
        0030: e2 a3 4d c9 ee ca 55 55  b5 34 fc 53 77
f6 4d 36  ..M...UU.4.Sw.M6
        0040: 08 02 bb b3 be 7e 44 27  85 1d fd 3b 57
9c ea 06  .....~D'...;W...
        0050: 19 e7 69 e5 b4 32 48 f8  2c 41 c1 38 e3
d2 bb 70  ..i..2H.,A.8...p
        0060: 90 b2 e7 32 73 bd 3e 5f  99 cb df 30 9e
53 15 bc  ...2s.>_...0.S..
        0070: 62 22 cc 11 62 27 2c de  a4 fa 0a db f0
de a8 da  b"..b',.........
        0080: 44 b2 5a 5d c3 66 eb 12  96 2c f8 49 53
1d b7 63  D.Z].f...,.IS..c
        0090: 2d f4 35 ec ba 71 f6 5a  be db 1c f4 f5
99 a9 77  -.5..q.Z.......w
        00a0: 71 a7 f8 b5 a4 b9 2d f6  67 87 11 46 a9
18 0b b3  q.....-.g..F....
        00b0: a8 ef 92 79 1f 9d 59 b7  f0 fe ad a5 5b
37 d9 27  ...y..Y.....[7.'
        00c0: 57 8d 72 76 14 e7 f0 e6  b0 af 4d 41 db
a3 1d 36  W.rv......MA...6
        00d0: fa 1c 77 89 6d 75 3b c5  2d 39 6c af 2a
36 91 5c  ..w.mu;.-9l.*6.\
        00e0: 9a 82 70 4e 4e 3d 6a a9  ab 22 64 f5 3d
52 0f 87  ..pNN=j.."d.=R..
        00f0: af 1f fa df 3e 59 0f 25  d8 55 c5 f0 2f
ee f6 b4  ....>Y.%.U../...
        0100: 2f f9 56 4e b1 a2 82 33  3f e1 58 4d 13
1f b3 48  /.VN...3?.XM...H
        0110: d1 af a3 c5 bf 07 d8 e6  b5 2c 3c 07 75
6d 6f 34  .........,<.umo4
        0120: 57 17 0f 30 94 8c a2 c6  11 78 f6 ef 4a
55 53 e8  W..0.....x..JUS.
        0130: 0a 16 25 3e 01 8d c1 56  81 88 61 83 d2
a7 d2 fc  ..%>...V..a.....
        0140: 0c 34 98 5e 3b 20 d1 2b  b0 72 1d 43 72
3d fa e3  .4.^; .+.r.Cr=..
        0150: 8e 99 c7 35 2e a5 f4 12  8d b5 2e ea 9e
0f 4d 59  ...5..........MY
        0160: 60 fb 54 3b cc 59 c6 df  91 49 3d 4e 07
5e 82 a3  `.T;.Y...I=N.^..
        0170: 5f 05 28 18 58 58 7e 22  97 3b b5 8a d3
72 54 f0  _.(.XX~".;...rT.
        0180: 7c b1 c2 56 12 d1 92 7d  70 0f d7 15 d3
69 76 d2  |..V...}p....iv.
        0190: 58 d9 45 6c 6d 97 29 81  90 c3 1e e7 f1
35 cd 5e  X.Elm.)......5.^
        01a0: 94 aa 2d 0a e6 56 b1 9b  ac 68 57 9a ae
a7 6d 79  ..-..V...hW...my
        01b0: e6 46 a2 dc 82 91 f5 1c  1c f5 f7 c7 a5
6f 42 d3  .F...........oB.
        01c0: aa 7c d1 46 09 eb 87 ce  3f 4a ca 58 76
f9 6d d0  .|.F....?J.Xv.m.
        01d0: 4d c5 ab 15 ae 6c 9e 76  0d 26 1c fb 91
c5 51 7d  M....l.v.&....Q}
        01e0: 0d 64 63 be 04 23 dc 83  5b d3 84 a2 ac
1c ea d6  .dc..#..[.......
        01f0: 2b cb e1 8b 69 07 36 91  03 ea a4 29 fc
c5 4b 6d  +...i.6....)..Km
        0200: a0 2d ac 61 22 81 42 81  8e 5c 31 fc c9
cd 74 73  .-.a".B..\1...ts
        0210: cf 97 95 b2 3d db de c3  57 c3 76 eb 2f
9c b6 56  ....=...W.v./..V
        0220: e2 4c e4 b8 55 07 f3 ab  eb a7 c8 06 30
07 fc 08  .L..U.......0...
        0230: 54 4d ca 5b 82 69 6c 35  f4 c6 65 3c 0c
ff 00 bc  TM.[.il5..e<....
        0240: 2a 11 a5 b8 3f ea d0 ff  00 c0 85 25 74
53 69 ad  *...?......%tSi.
        0250: 4f ff d9 00 ff db 00 84  00 06 04 05 06
05 04 06  O...............
        0260: 06 05 06 07 07 06 08 0a  10 0a 0a 09 09
0a 14 0e  ................
        0270: 0f 0c 10 17 14 18 18 17  14 16 16 1a 1d
25 1f 1a  .............%..
        0280: 1b 23 1c 16 16 20 2c 20  23 26 27 29 2a
29 19 1f  .#... , #&')*)..
        0290: 2d 30 2d 28 30 25 28 29  28 01 07 07 07
0a 08 0a  -0-(0%()(.......
        02a0: 13 0a 0a 13 28 1a 16 1a  28 28 28 28 28
28 28 28  ....(...((((((((
        02b0: 28 28 28 28 28 28 28 28  28 28 28 28 28
28 28 28  ((((((((((((((((
        02c0: 28 28 28 28 28 28 28 28  28 28 28 28 28
28 28 28  ((((((((((((((((
        02d0: 28 28 28 28 28 28 28 28  28 28 ff dd 00
04 00 00  ((((((((((......
        02e0: ff c0 00 11 08 03 c0 05  00 03 01 21 00
02 11 01  ...........!....
        02f0: 03 11 01 ff c4 01 a2 00  00 01 05 01 01
01 01 01  ................
        0300: 01 00 00 00 00 00 00 00  00 01 02 03 04
05 06 07  ................
        0310: 08 09 0a 0b 10 00 02 01  03 03 02 04 03
05 05 04  ................
        0320: 04 00 00 01 7d 01 02 03  00 04 11 05 12
21 31 41  ....}........!1A
        0330: 06 13 51 61 07 22 71 14  32 81 91 a1 08
23 42 b1  ..Qa."q.2....#B.
        0340: c1 15 52 d1 f0 24 33 62  72 82 09 0a 16
17 18 19  ..R..$3br.......
        0350: 1a 25 26 27 28 29 2a 34  35 36 37 38 39
3a 43 44  .%&'()*456789:CD
        0360: 45 46 47 48 49 4a 53 54  55 56 57 58 59
5a 63 64  EFGHIJSTUVWXYZcd
        0370: 65 66 67 68 69 6a 73 74  75 76 77 78 79
7a 83 84  efghijstuvwxyz..
        0380: 85 86 87 88 89 8a 92 93  94 95 96 97 98
99 9a a2  ................
        0390: a3 a4 a5 a6 a7 a8 a9 aa  b2 b3 b4 b5 b6
b7 b8 b9  ................
        03a0: ba c2 c3 c4 c5 c6 c7 c8  c9 ca d2 d3 d4
d5 d6 d7  ................
        03b0: d8 d9 da e1 e2 e3 e4 e5  e6 e7 e8 e9 ea
f1 f2 f3  ................
        03c0: f4 f5 f6 f7 f8 f9 fa 01  00 03 01 01 01
01 01 01  ................
        03d0: 01 01 01 00 00 00 00 00  00 01 02 03 04
05 06 07  ................
        03e0: 08 09 0a 0b 11 00 02 01  02 04 04 03 04
07 05 04  ................
        03f0: 04 00                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 01 02 77 00 01 02 03 11  04 05 21 31 06
12 41 51  ..w.......!1..AQ
        0010: 07 61 71 13 22 32 81 08  14 42 91 a1 b1
c1 09 23  .aq."2...B.....#
        0020: 33 52 f0 15 62 72 d1 0a  16 24 34 e1 25
f1 17 18  3R..br...$4.%...
        0030: 19 1a 26 27 28 29 2a 35  36 37 38 39 3a
43 44 45  ..&'()*56789:CDE
        0040: 46 47 48 49 4a 53 54 55  56 57 58 59 5a
63 64 65  FGHIJSTUVWXYZcde
        0050: 66 67 68 69 6a 73 74 75  76 77 78 79 7a
82 83 84  fghijstuvwxyz...
        0060: 85 86 87 88 89 8a 92 93  94 95 96 97 98
99 9a a2  ................
        0070: a3 a4 a5 a6 a7 a8 a9 aa  b2 b3 b4 b5 b6
b7 b8 b9  ................
        0080: ba c2 c3 c4 c5 c6 c7 c8  c9 ca d2 d3 d4
d5 d6 d7  ................
        0090: d8 d9 da e2 e3 e4 e5 e6  e7 e8 e9 ea f2
f3 f4 f5  ................
        00a0: f6 f7 f8 f9 fa ff da 00  0c 03 01 00 02
11 03 11  ................
        00b0: 00 3f 00 f1 d8 0c cc bf  20 39 cf 53 49
74 1e 47  .?...... 9.SIt.G
        00c0: 55 45 f9 c7 5a cd 4b 97  42 ae 45 1a c9
23 10 3e  UE..Z.K.B.E..#.>
        00d0: 5c 77 a9 7e d8 e8 3c 88  80 dc bd ea 93
b9 36 bb  \w.~..<.......6.
        00e0: 24 88 14 39 2f fb c7 1c  8a 80 cd 3c 13
79 5e 5e  $..9/......<.y^^
        00f0: d2 7a 35 0e 37 34 89 38  69 65 85 8b 1c
01 d7 14  .z5.74.8ie......
        0100: d5 2c 19 3e cc 77 0e e4  d2 8a 48 24 b5
2f da da  .,.>.w....H$./..
        0110: cc 5f 74 98 c9 e8 29 57  cc 47 91 59 42
d3 68 bf  ._t...)W.G.YB.h.
        0120: 66 ad a0 a6 24 48 37 e4  e7 d2 a1 31 79
ad b9 5b  f...$H7....1y..[
        0130: 81 d4 7a 51 25 a5 8c b6  d0 82 e0 ba fc
aa e3 07  ..zQ%...........
        0140: a9 14 96 c9 22 29 0d 92  1b a1 f4 a7 15
64 4d ec  ....").......dM.
        0150: ec 30 43 23 12 aa 72 6b  53 4e 78 ad c1
47 1b 4f  .0C#..rkSNx..G.O
        0160: e9 59 d9 dc 76 19 79 75  1c cf e5 22 61
bd 45 53  .Y..v.yu..."a.ES
        0170: 91 64 55 f2 f3 94 6e a7  d2 aa 2d bd 18
08 62 95  .dU...n...-...b.
        0180: 42 90 c3 68 a7 7c b2 48  43 ae 14 77 a3
99 de c1  B..h.|.HC..w....
        0190: 62 c4 36 d0 4d 19 1b f2  0f 00 9e d4 db
ab 75 b7  b.6.M.........u.
        01a0: 54 11 90 e0 75 15 57 be  c5 42 dd 4a 9f
67 56 98  T...u.W..B.J.gV.
        01b0: 7c c5 77 76 a9 12 d5 d2  e0 08 7a 0e a4
d2 bd 90  |.wv......z.....
        01c0: 92 bb 2d 58 f9 99 97 cc  5d c4 74 a7 dc
49 2c 31  ..-X....].t..I,1
        01d0: ef 41 91 e9 46 fa b1 c9  5b 43 3e 19 9a
e9 8c 93  .A..F...[C>.....
        01e0: 2e d5 1d ab 45 3c bb 65  59 3c b3 b4 f6
a6 c8 26  ....E<.eY<.....&
        01f0: 37 3b 1c 3e c1 83 c8 a0  6a 39 24 11 87
ec 28 49  7;.>....j9$...(I
        0200: 30 d8 24 bd 7f 2c ee 19  93 d6 a8 9b cb
89 7e 5f  0.$..,........~_
        0210: 4e d5 56 0d c4 4b 89 10  15 2a 08 3d a9
b2 cc 37  N.V..K...*.=...7
        0220: 83 e5 e3 3c 13 48 51 56  12 53 28 4d 81
f3 09 a8  ...<.HQV.S(M....
        0230: 44 7e 52 6f ce 47 63 4a  fd 06 49 03 21
72 5b 21  D~Ro.GcJ..I.!r[!
        0240: fb 1a 90 db 82 a5 d9 c1  ff 00 66 89 3b
0c 99 6f  ..........f.;..o
        0250: 1e 35 54 4c a8 15 34 37  12 3c 64 06 19
f5 ac ed  .5TL..47.<d.....
        0260: a0 b9 ae 36 69 66 29 c3  f3 53 45 3c d1
00 5d bb  ...6if)..SE<..].
        0270: 56 91 15 88 a4 bd dd 26  0b 52 a5 cc 96
e9 bf 20  V......&.R.....
        0280: 23 74 a6 32 33 75 28 98  79 a7 2b ed 53
99 25 1b  #t.23u(.y.+.S.%.
        0290: 5e 39 30 0f 6a 56 19 05  d2 bc 8d b8 8c
fa e2 9a  ^90.jV..........
        02a0: 2d c0 c2 01 8e 3a 54 b6  c6 a4 b6 1a b1
24 4c 70  -....:T......$Lp
        02b0: c6 a7 33 c8 ca a1 0f cb  4d 36 21 93 2c
bc 07 6d  ..3.....M6!.,..m
        02c0: cb 4c 5b f7 8d 7c ac 1d  a3 bd 52 11 34
33 4a d2  .L[..|....R.43J.
        02d0: 6e 0d c6 3b d4 12 19 91  64 c9 e5 fb d2
94 ac 03  n..;....d.......
        02e0: ad dd ad d0 16 24 a7 7c  d3 92 f0 dc bb
04 60 22  .....$.|......`"
        02f0: 14 6e 31 aa 59 92 46 8f  71 41 51 41 72
d2 a3 09  .n1.Y.F.qAQAr...
        0300: 06 d0 38 06 9a d0 09 23  90 a2 af 1c 7a
d4 b2 b2  ..8....#....z...
        0310: 6e 56 94 9c 9e 82 92 62  2a ba 88 ee 37
3b 1c 1e  nV.....b*...7;..
        0320: 8b 56 1e 72 00 8c e4 31  e9 4d 8c 83 32
c5 2e e9  .V.r...1.M..2...
        0330: 58 b0 ed 4f 8d 64 66 2c  49 d9 e8 28 40
3e 08 8c  X..O.df,I..(@>..
        0340: af 85 ca 81 52 c9 13 33  a3 6c 38 53 d6
93 76 42  ....R..3.l8S..vB
        0350: b0 d9 7c c7 9c 33 ee 20  74 35 1c a2 41
82 bf 33  ..|..3. t5..A..3
        0360: 7a 54 a9 01 24 71 b0 fd  e2 93 9e fe d4
d1 e6 2c  zT..$q.........,
        0370: c8 91 b9 cb 75 35 60 f6  26 9a 49 43 ed
8d 8e 7d  ....u5`.&.IC...}
        0380: ea 02 d3 a9 2c c7 a5 3e  6e 50 45 98 e6
77 40 64  ....,..>nPE..w@d
        0390: 6c 0a 89 9a 68 24 c8 93  28 7a 54 39 a1
58 74 b3  l...h$..(zT9.Xt.
        03a0: bb a8 13 b6 45 52 b9 b7  39 04 7c a0 f4
aa 45 24  ....ER..9.|...E$
        03b0: 49 0c 4c c8 44 80 ee 3c  0f 7a 94 da 88
e1 21 87  I.L.D..<.z....!.
        03c0: ce 7a 01 53 a8 f9 48 16  d7 6b 85 38 c7
7a 70 46  .z.S..H..k.8.zpF
        03d0: 8d c0 45 ce 7b d5 12 5a  8a 66 b4 c0 49
06 5b b5  ..E.{..Z.f..I.[.
        03e0: 49 2e a1 70 00 65 20 ad  4b 68 11 3a 5e
48 76 b3  I..p.e .Kh.:^Hv.
        03f0: 9c 9f                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 41 4f 4d 56 64 97 cb 75  cc 6d d2 9a 00
6d 48 80  AOMVd..u.m...mH.
        0010: e8 c9 8f 43 55 a1 d4 ee  25 25 18 8d a2
8b 24 04  ...CU...%%....$.
        0020: 33 5c 3c db b7 70 c3 a1  aa bf 66 79 15
8c 87 0c  3\<..p....fy....
        0030: 7a 1a 51 60 88 e3 85 98  ec ec 3a 93 53
2f ca d8  z.Q`......:.S/..
        0040: 51 b8 81 8a 52 9d b4 40  48 f1 ec 88 3e
71 ea b5  Q...R..@H...>q..
        0050: 72 35 b6 5b 70 e5 7e 73  e9 4e d7 02 44
78 02 86  r5.[p.~s.N..Dx..
        0060: db 8c d2 bc a9 36 02 26  00 ef 45 ad a0
6e 57 b8  .....6.&..E..nW.
        0070: 92 38 c1 c4 63 70 a5 d9  0b 5b ab 88 ce
49 e9 42  .8..cp...[...I.B
        0080: 8a 40 43 a8 18 8c 6b 95  fc 2a 7b 1f b2
18 43 5c  .@C...k..*{...C\
        0090: 0c 0e c2 9f 2a 60 43 74  f1 79 9b 21 87
03 d6 9f  ....*`Ct.y.!....
        00a0: 09 8f cc c4 a3 e5 a4 a3  6d 00 91 05 b8
9c 71 c5  ........m.....q.
        00b0: 3e ee 78 d5 f6 42 02 9f  5a 5c a0 30 df
4b 3c 1e  >.x..B..Z\.0.K<.
        00c0: 40 60 ae bd 4d 53 9d a3  96 15 5c 90 47
53 56 80  @`..MS....\.GSV.
        00d0: 8a 0b 60 5c f9 67 e5 f5  f5 a5 9e c9 5f
6e 0e d3  ..`\.g......_n..
        00e0: dc 50 04 71 c3 1a cc 15  c1 20 d2 dc c1
1c 77 21  .P.q..... ....w!
        00f0: 63 07 6e 3a 52 2a fa 09  1d aa 48 18 39
da bd 85  c.n:R*....H.9...
        0100: 34 d9 00 8c a8 09 a1 b7  d0 92 68 ed 96
18 40 61  4.........h...@a
        0110: 83 e9 4f 86 e4 44 15 19  49 56 f4 a1 20
2e 4c 60  ..O..D..IV.. .L`
        0120: 0a a4 47 bb 3e 9d aa 39  ee ad 04 7b 16
22 5e b3  ..G.>..9...{."^.
        0130: 94 5b d8 52 76 44 7f 6b  6d 8b 13 e3 61
e8 3d 2a  .[.RvD.km...a.=*
        0140: 48 a6 6f 2d 95 59 73 da  b4 4b 40 8a ba
ba 21 c2  H.o-.Ys..K@...!.
        0150: 48 36 cc a3 8a ac 14 bb  9d 89 b3 1d 3d
e9 58 64  H6..........=.Xd
        0160: aa 03 46 56 52 01 a2 02  f6 aa 64 89 81
5a 39 80  ..FVR.....d..Z9.
        0170: 71 d4 65 66 c4 84 e3 f4  a8 9c 9b 99 38
19 43 d2  q.ef........8.C.
        0180: 84 d1 57 7b 0b 6b 18 8a  46 3e 58 2e 3d
6a 53 70  ..W{.k..F>X.=jSp
        0190: 8b 70 0b 26 0f b5 36 ae  49 24 93 79 a8
4a a9 1e  .p.&..6.I$.y.J..
        01a0: 95 24 4e 92 27 96 f9 0c  07 43 49 c1 30
4c 86 22  .$N.'....CI.0L."
        01b0: a0 b1 0a 38 ed 55 a5 48  88 de 89 86 27
9a c5 37  ...8.U.H....'..7
        01c0: cd 61 dc 9e dd ad e3 88  38 27 23 b5 36
42 8f 96  .a......8'#.6B..
        01d0: 57 21 9b f4 ae 81 14 d7  7b 3e c6 76 27
d4 d5 ab  W!......{>.v'...
        01e0: 76 78 e5 d8 dc af 63 40  12 b4 ce 58 80
72 47 63  vx....c@...X.rGc
        01f0: 4b 0d ee d8 9c 60 03 ea  6a 14 ba 32 9b
ba b0 c4  K....`..j..2....
        0200: bc 92 58 f6 b3 60 03 da  89 6e 36 8c 21
c3 7a d3  ..X..`...n6.!.z.
        0210: eb a1 29 0d 13 c8 e0 22  bf 35 05 e9 72
c1 44 98  ..)....".5..r.D.
        0220: 27 82 45 26 da 02 16 8f  c9 5d 8b 92 9d
e9 86 34  '.E&.....].....4
        0230: 79 15 9c e0 0f ba 2a 63  76 ee c3 72 cc
61 4f dd  y.....*cv..r.aO.
        0240: 51 82 39 a6 2c 08 11 8c  ad 90 7a 63 b5
54 9a 02  Q.9.,.....zc.T..
        0250: 64 63 04 7f bb 7c ad 4e  25 9a 5b 72 e8
41 1d 31  dc...|.N%.[r.A.1
        0260: 54 9d c0 65 ab 14 81 83  3f ef 3d a8 9a
6f dc 2a  T..e....?.=..o.*
        0270: ee cc 94 24 05 71 2f ef  15 58 90 c3 9a
9e e2 e6  ...$.q/..X......
        0280: 54 84 36 78 a9 71 ea 05  4f b7 2b 15 18
23 71 eb  T.6x.q..O.+..#q.
        0290: 53 5d 0b 87 0a 24 27 1d  88 ab 8a b8 12
44 91 91  S]...$'......D..
        02a0: b5 8e 5f b9 aa f2 59 24  92 12 ab c0 a5
61 44 92  .._...Y$.....aD.
        02b0: db 6c 24 86 25 5c 76 a4  9d 3c c7 df 13
1f a5 36  .l$.%\v..<.....6
        02c0: ac b4 07 a2 1c 17 0b 96  3c 9a 71 01 48
25 b6 fb  ........<.q.H%..
        02d0: 54 46 ed ea 52 d8 80 fd  fc 6f 2c 0f 6a
22 8d 55  TF..R....o,.j".U
        02e0: 99 1f 24 1e 82 9b 8d dd  c4 4d 71 22 f9
61 0e 48  ..$......Mq".a.H
        02f0: 1d a9 23 61 26 dd 8a 70  3b 1a 6f 40 22
82 5c b6  ..#a&..p;.o@".\.
        0300: 47 ca 2a 19 af 3c 82 5c  29 7d dc 70 29
4a 0a 40  G.*..<.\)}.p)J.@
        0310: 49 05 d2 79 24 ca bb 45  42 ef 1c a8 5a
01 84 f5  I..y$..EB...Z...
        0320: a2 2a da 14 99 34 26 37  83 6e d3 e6 0e
f4 4a af  .*...4&7.n....J.
        0330: 2a a6 ee 76 d4 54 6d 6c  54 60 e4 11 31
48 d8 0f  *..v.TmlT`..1H..
        0340: bb dc 55 85 89 7c b4 10  90 33 ce 69 46
ed 89 c7  ..U..|...3.iF...
        0350: 94 9e 51 28 65 92 39 30  aa 31 4a aa 24
8f cc 95  ..Q(e.90.1J.$...
        0360: be ef 5f 7a d8 92 03 7c  24 46 3e 59 54
1d 32 2a  .._z...|$F>YT.2*
        0370: 1b 67 2e 5d 80 20 7f 3a  4d 5c 07 cb 6a
cf 12 31  .g.]. .:M\..j..1
        0380: 18 e7 81 52 bb ca a4 36  06 14 7d da 85
2b 3b 15  ...R...6..}..+;.
        0390: 2b 15 e3 32 4b 39 75 1b  54 76 a2 e6 6c
0c 46 bb  +..2K9u.Tv..l.F.
        03a0: 8f 7a 27 2e 52 44 80 4d  e5 b4 ae 9b 73
c0 ab 10  .z'.RD.M....s...
        03b0: 5b f9 bf 33 c9 85 51 de  8e 6b 6c 0b 52
5f 28 00  [..3..Q..kl.R_(.
        03c0: 01 39 43 d2 a5 fb 37 c8  37 15 2a dd 00
a6 e4 b6  .9C...7.7.*.....
        03d0: 0b 81 b1 64 51 81 b3 d2  a0 6b 69 07 0c
72 07 35  ...dQ....ki..r.5
        03e0: 49 59 05 b4 1b 3d b3 36  c9 53 90 3a 8f
4a 98 00  IY...=.6.S.:.J..
        03f0: 08 24                                   
         .$
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: e3 bd 31 2d 01 91 e4 61  e5 b8 0c dd 31
50 de e2  ..1-...a....1P..
        0010: 0c 46 58 99 3b 9e d4 b7  29 ea 41 16 d4
c3 13 c7  .FX.;...).A.....
        0020: 75 ab 37 37 27 62 7c 87  69 ec 45 29 47
99 09 e8  u.77'b|.i.E)G...
        0030: 55 6b b3 27 ca 13 05 78  02 88 66 6d ff
00 3c 5f  Uk.'...x..fm..<_
        0040: 37 ad 10 8f 2a 15 cb 2a  93 ca d9 c0 00
f4 15 2c  7...*..*.......,
        0050: 56 37 0c d8 00 2b 0e b4  49 d9 15 61 5b
4e 98 6e  V7...+..I..a[N.n
        0060: 03 e6 6f 51 51 45 68 e4  98 e4 1c fa d2
8c ae 2b  ..oQQEh........+
        0070: 58 68 d3 a7 28 eb bc 05  1c d4 36 d6 b2
c9 6e cb  Xh..(.....6...n.
        0080: bb e6 53 d0 d0 ef 7d 00  49 2d 65 40 5d
88 c8 fe  ..S...}.I-e@]...
        0090: 11 4a b0 ca 23 05 81 20  fa 76 ab 6a e0
4e 60 33  .J..#.. .v.j.N`3
        00a0: 43 80 c0 05 aa 4f 1d ca  11 9f 97 d2 95
f4 2a c9  C....O........*.
        00b0: 23 42 d2 d2 79 20 dd 23  8d e2 9e 6d 9a
59 54 34  #B..y .#...m.YT4
        00c0: a1 48 ed 49 09 46 fa 0d  82 cf ca 95 9a
56 52 bd  .H.I.F.......VR.
        00d0: aa 69 a0 32 44 03 e0 2f  a5 50 49 58 ad
26 9e 64  .i.2D../.PIX.&.d
        00e0: 56 fd e8 08 3a 55 64 86  48 8e 23 72 53
d4 d0 49  V...:Ud.H.#rS..I
        00f0: a7 a6 15 0a 56 63 9c d4  f7 16 e8 59 0c
6e 37 7a  ....Vc.....Y.n7z
        0100: d4 ea 16 2a 5e db 33 b9  0a 47 4e d5 0a
d9 c9 00  ...*^.3..GN.....
        0110: 4c 48 37 1f e1 aa d8 09  3e c7 36 e6 6d
f8 6f 4a  LH7.....>.6.m.oJ
        0120: 84 5b 15 4f de b0 de 4f  4a 4e fd 06 1e
54 e2 60  .[.O...OJN...T.`
        0130: ab 8d 9e b4 4c 8d e7 c6  77 67 1d ab 27
19 5c 45  ....L...wg..'.\E
        0140: 89 ec 5e 6f e3 da b8 e9  53 e9 9a 7a 42
18 90 0e  ..^o....S..zB...
        0150: 07 4a a4 e4 34 5a 09 6e  14 ec 21 49 ea
2a b9 b5  .J..4Z.n..!I.*..
        0160: 80 e7 23 19 ed 56 c9 6c  56 8e d8 05 56
18 c7 6a  ..#..V.lV...V..j
        0170: 8d e2 8e 46 04 a8 21 68  4a c5 29 10 cb
e4 09 09  ...F..!hJ.).....
        0180: 08 5d 87 4a b0 a2 15 88  4c c9 96 fe 54
5a c0 42  .].J....L...TZ.B
        0190: 66 88 03 e6 2f cb d8 d3  52 64 21 44 03
9e f9 a6  f.../...Rd!D....
        01a0: 80 7a 5e ec 76 41 1e 24  f5 a9 a0 bb 79
22 6f dd  .z^.vA.$....y"o.
        01b0: e0 0e a6 86 84 3a 0d 41  5d 18 08 81 03
bd 41 2c  .....:.A].....A,
        01c0: bf 21 96 28 f0 c2 a3 95  00 eb 4b d8 e3
8d 8c aa  .!.(......K.....
        01d0: 32 4d 48 65 8e 32 64 d8  0a e3 a5 53 57
5a 00 fb  2MHe.2d....SWZ..
        01e0: 6b a8 99 f2 d1 d4 ad 71  68 03 21 40 db
bf 4a 9b  k......qh.!@..J.
        01f0: 5d 81 12 bd b8 21 55 37  2f a5 36 e6 78
4a 6c f2  ]....!U7/.6.xJl.
        0200: f0 a3 a1 a4 e9 eb 70 4c  74 09 68 40 79
7e 6c 74  ......pLt.h@y~lt
        0210: 14 c7 9a 0b 89 76 2a e0  8e 95 48 03 74
6b 20 55  .....v*...H.tk U
        0220: 19 61 de 95 a6 8d 9d c8  5c b0 15 43 b9
52 d5 e2  .a......\..C.R..
        0230: 6b cc 38 39 35 ab fb 84  27 80 0d 4c 95
c9 4c 6c  k.895...'..L..Ll
        0240: c2 d9 f8 f2 46 7d 6b 2e  75 40 e5 36 90
be d5 31  ....F}k.u@.6...1
        0250: a7 62 ee 5b dd 6b 04 69  b0 e6 a4 86 4b
67 21 88  .b.[.k.i....Kg!.
        0260: e9 eb 56 d5 c9 23 bc 7b  76 71 b4 80 4d
56 58 90  ..V..#.{vq..MVX.
        0270: cc ac ae 00 1d 45 4b 4c  09 8d ab c8 58
8c 2a d4  .....EKL....X.*.
        0280: 29 1c 85 f6 a3 02 ab d7  9a 6b 4d 00 98
5b 3b f0  )........kM..[;.
        0290: a4 60 fa 54 2b 63 24 6c  4e f0 05 16 01
6e 62 77  .`.T+c$lN....nbw
        02a0: 40 11 80 06 96 df 4f 91  22 dc 65 04 fa
52 d5 30  @.....O.".e..R.0
        02b0: 2c ad 96 eb 7c 48 e3 70  ee 2a 57 b3 10
db e1 5c  ,...|H.p.*W....\
        02c0: 12 d4 f7 0b 19 f7 36 92  84 19 70 58 f7
a9 56 27  ......6...pX..V'
        02d0: 11 aa 24 83 23 ad 37 74  81 21 86 c2 69
66 19 61  ..$.#.7t.!..if.a
        02e0: b3 d6 a6 6d 39 80 da 31  93 d3 d2 94 65
70 1b 2d  ...m9..1....ep.-
        02f0: ac 85 92 06 60 08 ef 4e  4b 40 17 66 e1
f5 aa 65  ....`..NK@.f...e
        0300: 5c ad 79 67 3e f0 51 c6  df 6a 2d f4 a9
db 2c d2  \.yg>.Q..j-...,.
        0310: 7c a7 a5 44 a5 62 2d d4  73 e9 37 02 4c
2c 80 2f  |..D.b-.s.7.L,./
        0320: 7a 3f b1 ee 12 3d db be  53 4e 32 ba 19
0d a5 9d  z?...=..SN2.....
        0330: cc 33 e0 1e 47 41 45 dc  57 45 dc ed c5
3b 81 46  .3..GAE.WE...;.F
        0340: 28 6e f3 99 01 03 b1 a5  fb 15 dc d3 82
09 db eb  (n..............
        0350: 44 5d f7 02 73 65 76 d2  28 0d 8d b5 79
23 92 de  D]..sev.(...y#..
        0360: 22 65 c6 ef 5a 13 0b 2d  c7 08 24 90 06
e1 81 e9  "e..Z..-..$.....
        0370: 4e 09 e4 af cf 1a d3 b5  c6 02 78 12 26
00 72 7a  N.........x.&.rz
        0380: 55 4d a1 a1 2c 14 02 3b  d2 4a c2 dc 84
da bc fb  UM..,..;.J......
        0390: 1c b0 00 7a 54 d6 90 c3  1c 84 c8 4e 28
57 b8 12  ...zT......N(W..
        03a0: c4 d6 cb 39 69 9b f7 7e  b4 eb b9 6d dc
13 10 c2  ...9i..~...m....
        03b0: fa d0 90 14 0c 51 ca db  95 8e 07 53 53
45 6a d7  .....Q.....SSEj.
        03c0: 23 6c 6f b5 45 2b 76 02  74 b1 0e 0a c8
cb 81 c5  #lo.E+v.t.......
        03d0: 3a 3b 41 00 20 1f 94 74  a8 82 6f 70 27
31 31 f9  :;A. ..t..op'11.
        03e0: 91 79 c5 2a c9 19 88 03  00 de 28 b4 ae
34 48 8a  .y.*......(..4H.
        03f0: bb 4b                                   
         .K
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 48 a1 71 d2 ab 4e 12 49  03 01 87 f5 15
6a ed 6a  H.q..N.I.....j.j
        0010: 21 d0 ac 7b 48 db f3 9a  89 ad 82 46 c1
40 cd 1c  !..{H......F.@..
        0020: a9 0c 62 81 18 55 48 83  39 eb 49 3c 1b
a3 75 45  ..b..UH.9.I<..uE
        0030: c4 94 f5 03 3e 56 68 50  2b 8c 38 a9 a1
77 65 56  ....>VhP+.8..weV
        0040: db f8 d3 02 0b a9 65 67  63 8d bd b2 2a
ac a9 39  ......egc...*..9
        0050: 88 2a fc c0 f7 a4 d5 c4  68 58 58 32 c2
be 74 83  .*......hXX2..t.
        0060: 2d da ae c1 a5 0f 3f 9c  ed f7 ac e1 75
b8 22 cc  -.....?.....u.".
        0070: ba 4a 44 e4 a3 8c b0 e0  d6 7a e9 8a 25
67 92 4c  .JD......z..%g.L
        0080: e3 a2 e6 87 26 f4 b0 de  a3 1e da 20 c5
9a 40 17  ....&...... ..@.
        0090: d3 35 5d 23 8d ae 76 ee  1b 71 c5 54 5b
25 21 cf  .5]#..v..q.T[%!.
        00a0: 11 8e 37 48 cf 5e b4 db  28 08 b7 65 76
dd 9f 5a  ..7H.^..(..ev..Z
        00b0: 25 1b 89 2b 00 b6 55 f9  01 3b e9 1a d6
e1 4e d8  %..+..U..;....N.
        00c0: 5f 0a 6a e3 a2 14 65 cc  5a b5 d3 cb 2e
eb 89 36  _.j...e.Z......6
        00d0: b7 41 4e bc b3 10 80 43  67 1d ea 27 27
1d 8b 20  .AN....Cg..''..
        00e0: 96 d4 1d 92 ee 0c 4f 61  56 da d7 e5 06
42 0a 91  ......OaV....B..
        00f0: c2 fa 54 a9 48 65 59 2c  ad d0 a8 2f 8a
86 e1 64  ..T.HeY,.../...d
        0100: e1 16 5c a8 ad 23 22 64  ae 8b fa 72 2a
95 2d 82  ..\..#"d...r*.-.
        0110: 3b 93 56 64 92 06 62 b1  60 63 bd 29 b7
6d 06 b4  ;.Vd..b.`c.).m..
        0120: 2b 5c b4 57 71 8c 61 64  1c 67 d6 ab 98
05 a9 c0  +\.Wq.ad.g......
        0130: 6d cc df a5 67 4e a5 d6  a0 de 84 bf 65
0a bb b7  m...gN......e...
        0140: 86 04 55 1f b3 bc 92 92  ec 78 ad 22 ee
08 b2 a8  ..U......x."....
        0150: bb 37 2a 70 bd e9 65 8e  3d a2 45 6e 4d
51 3c dd  .7*p..e.=.EnMQ<.
        0160: 07 47 0c 6c bb e4 e0 8f  d6 ac a5 ed ac
6a bf bb  .G.l.........j..
        0170: c6 78 a4 d5 c6 9d ca 2a  22 39 2c 98 22
a4 81 60  .x.....*"9,."..`
        0180: c9 ca 0c f6 14 0d 11 ce  90 5c 65 00 da
47 5c 54  .........\e..G\T
        0190: 90 c3 6f 6d b0 37 cc 87  b0 a9 72 d2 e3
4c 93 31  ..om.7....r..L.1
        01a0: c4 ec 12 3f 94 f7 a8 e7  9e 35 2a 90 80
4b 77 a1  ...?.....5*..Kw.
        01b0: 34 cd 21 51 c4 54 58 91  1b 72 fe f0 f6
a6 17 58  4.!Q.TX..r.....X
        01c0: f3 98 c6 31 54 92 e8 4c  a4 e4 28 9e 3f
2c 44 d9  ...1T..L..(.?,D.
        01d0: 39 e4 0a 64 b2 89 23 11  a1 2a c3 b5 2e
75 7b 04  9..d..#..*...u{.
        01e0: 23 76 4b e6 0f b3 2e f4  00 f4 c5 46 8c
de 5b 14  #vK........F..[.
        01f0: 50 00 ef 54 37 1d 47 41  2c de 51 6c 03
e8 0d 47  P..T7.GA,.Ql...G
        0200: e5 ca ca 5c 9c 16 ed 50  a1 ad d9 0c 92
d0 83 98  ...\...P........
        0210: c8 39 f5 a1 18 44 e6 35  8b 39 ee 68 7c
b2 d1 8a  .9...D.5.9.h|...
        0220: c5 b4 8f 72 81 31 c0 ec  2a bd da 2e dc
20 60 3d  ...r.1..*.... `=
        0230: 2a 62 ac ca e5 b1 30 85  04 11 05 25 98
f5 f6 a5  *b....0....%....
        0240: 94 24 52 2f 0c 40 f4 ab  76 5a 8a c2 de
dd 32 c4  .$R/.@..vZ....2.
        0250: 02 36 e0 dd fd 2a a8 99  67 60 9b c8 da
39 35 3c  .6...*..g`...95<
        0260: e0 3a 1b b8 bf d5 31 c2  ff 00 7a 92 49
54 4b b5  .:....1...z.ITK.
        0270: 57 2b d8 fa d5 df 41 12  da c8 b1 c8 46
dc 3f 5c  W+....A.....F.?\
        0280: 9a 59 1a 3b 89 70 e8 07  bd 0b b8 e3 37
b1 4a fd  .Y.;.p......7.J.
        0290: 15 1d 41 52 ad 9e 31 57  2e 9f ce 86 34
5c 0c 0a  ..AR..1W....4\..
        02a0: 57 be c3 8d af a9 4a 28  17 cd 23 78 0d
52 bc 61  W.....J(..#x.R.a
        02b0: 59 4e e2 dc d5 09 db a1  76 79 44 51 24
8a 7e 70  YN......vyDQ$.~p
        02c0: 38 14 91 df 48 cc 36 0f  99 87 35 2e db
08 9c 5e  8...H.6...5....^
        02d0: b4 43 f7 63 93 d4 55 53  27 9a cc 4b 15
35 31 8d  .C.c..US'..K.51.
        02e0: 98 d9 4f 74 ae e4 47 21  da 3a 8f 5a b4
80 af 21  ..Ot..G!.:.Z...!
        02f0: f6 9c 76 aa 72 26 e8 8c  ca 1b 68 3f 7b
3d 6a 4f  ..v.r&....h?{=jO
        0300: 35 91 b0 47 5e 94 f9 8a  43 40 2e e4 a7
1d c8 a9  5..G^...C@......
        0310: 1a 45 68 70 c4 13 4a d7  43 51 b8 cf 31
02 0c 39  .Ehp..J.CQ..1..9
        0320: 03 da 95 b6 79 46 4d d9  c5 50 35 61 88
e5 82 b3  ....yFM..P5a....
        0330: 12 55 bb 54 a6 5f 34 98  f2 40 1d 05 43
77 12 43  .U.T._4..@..Cw.C
        0340: 44 4d b3 04 9f a5 4b 0b  24 b1 94 09 b4
ad 52 05  DM....K.$.....R.
        0350: a3 1a a4 47 2e cc f2 47  7e d4 9f 68 47
6f 2f 92  ...G...G~..hGo/.
        0360: 47 71 4c 1b b9 34 11 81  29 72 e4 71 de
aa 97 12  GqL..4..)r.q....
        0370: 4c f9 6e 9d e8 1d ac 38  6e 2c a3 cd c8
ef 56 5a  L.n....8n,....VZ
        0380: d5 1f e6 12 8c d0 24 c9  2e 23 f2 2d 03
15 c8 23  ......$..#.-...#
        0390: a8 aa 96 c8 ad 16 f3 d4  50 0d 91 0b 87
91 9f 24  ........P......$
        03a0: a9 1c 0c d3 ad e5 98 67  24 90 29 73 21
0f 49 c6  .......g$.)s!.I.
        03b0: c3 81 86 cf 7a 59 65 79  40 c8 3b d7 d2
86 f4 02  ....zYey@.;.....
        03c0: 36 8e 46 28 c2 4c 93 d4  55 b5 3b 21 24
0e 7a 1c  6.F(.L..U.;!$.z.
        03d0: d4 29 e9 a8 d0 d8 e3 3b  83 02 3e 95 3c
36 db f7  .).....;..>.<6..
        03e0: 09 1c 63 ae 28 bb 63 76  22 6b 45 98 f5
02 30 78  ..c.(.cv"kE...0x
        03f0: 1e b4                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 97 36 52 5b c6 08 c6 d3  d3 15 68 1d ac
2c 16 12  .6R[......h..,..
        0010: 4e 77 2b 00 7b d4 97 16  be 4a 10 d2 ed
5e e0 52  Nw+.{....J...^.R
        0020: 6d f4 05 6b 05 b8 b6 30  65 18 71 4b 28
89 97 e5  m..k...0e.qK(...
        0030: 90 63 d2 92 4e f7 11 53  fd 1a 76 1b b8
0a 79 15  .c..N..S..v...y.
        0040: 62 38 12 49 f2 af f2 a8  e2 ae c0 4a f1
c4 25 dc  b8.I.......J..%.
        0050: 8c 09 03 91 55 11 23 63  21 07 07 b5 2b
76 06 84  ....U.#c!...+v..
        0060: 8e 68 90 05 0c 3c cf 5a  8d fe 7c ef 3f
fd 7a 13  .h...<.Z..|.?.z.
        0070: b9 28 7c 73 c4 84 6f 18  c0 e0 55 78 ca
bc e5 94  .(|s..o...Ux....
        0080: e2 9a 56 18 af 27 95 38  3b f8 a9 12 78
fc c2 37  ..V..'.8;...x..7
        0090: 72 d4 00 d1 e5 44 f9 dd  93 eb e9 52 cd
1b c8 14  r....D.....R....
        00a0: 47 2f 5e 49 a6 09 58 b7  69 14 bb 70 18
b0 1e b4  G/^I..X.i..p....
        00b0: db e5 95 42 85 00 fa 9a  91 a7 63 3a 3e
26 2a 79  ...B......c:>&*y
        00c0: 15 2c 8b 21 88 ac 3c 66  93 6d 06 e5 49
17 25 41  .,.!..<f.m..I.%A
        00d0: 63 b9 7b d4 f6 b8 f3 46  ee 00 ef 4d 3b
ec 0d 16  c.{....F...M;...
        00e0: d6 e1 19 ca 82 76 f4 a8  24 89 63 56 f2
1c 82 7a  .....v..$.cV...z
        00f0: d1 71 12 5a 23 a6 41 9b  83 4a c1 dd b6
07 e4 77  .q.Z#.A..J.....w
        0100: a3 51 95 e4 65 8f 9d c4  81 d6 a5 90 80
80 ac 84  .Q..e...........
        0110: 96 1c 01 52 a5 ad 84 84  12 ba c4 23 dc
c0 9a 16  ...R.......#....
        0120: 77 53 87 25 bf a5 58 04  d2 c3 b4 6d 91
b7 fb d2  wS.%..X....m....
        0130: 70 40 2a ff 00 52 2a 53  b8 13 ad d8 74
d8 a7 95  p@*..R*S....t...
        0140: ed 44 d3 ca d1 29 47 3c  7a 53 7a 01 13
48 f2 30  .D...)G<zSz..H.0
        0150: 69 03 07 23 86 a6 5b dc  6d 66 8d c1 2f
d8 9a 39  i..#..[.mf../..9
        0160: 90 0f 6b b0 15 57 6b 6e  15 30 9a 48 d1
64 df 95  ..k..Wkn.0.H.d..
        0170: 1f c3 52 d7 30 ed 70 92  f4 cd 20 3f 74
fa 54 c6  ..R.0.p... ?t.T.
        0180: fe 42 bb 15 70 07 ad 5a  d1 08 67 9a ed
22 37 21  .B..p..Z..g.."7!
        0190: c7 6a 5f b4 3b 16 2c bf  36 6a 6f 77 60
12 39 b7  .j_.;.,.6jow`.9.
        01a0: 6e 12 6d 20 f4 a4 49 c2  c0 e8 c4 02 3a
11 55 62  n.m ..I.....:.Ub
        01b0: 5f 62 bd b5 d0 5c e5 b7  33 1c 53 67 dc
72 5d fe  _b...\..3.Sg.r].
        01c0: 41 da 80 e5 1e d2 3a 44  8c 92 6d 03 b5
57 ba 69  A.....:D..m..W.i
        01d0: 24 51 b9 ce 0d 4d ef b1  43 ed e1 5d 83
e6 07 6d  $Q...M..C..]...m
        01e0: 4d 1c 88 3c c4 09 f7 aa  96 a0 90 b6 90
88 91 b2  M..<............
        01f0: d9 27 a7 b5 44 fb 4c 98  2d f2 d4 b7 60
22 11 2b  .'..D.L.-...`".+
        0200: ee 00 e5 68 8a 37 93 31  20 c2 fa d1 cc
05 84 b4  ...h.7.1 .......
        0210: 58 a5 58 8b 02 1a a5 78  21 8a 55 48 e5
c3 7a 0a  X.X....x!.UH..z.
        0220: 6a e3 26 fb 14 6b 86 49  7e 63 ef 49 35
a1 91 73  j.&..k.I~c.I5..s
        0230: 14 a4 11 d4 7a d4 c9 be  80 28 f3 54 20
79 02 8e  ....z....(.T y..
        0240: 95 3f 92 02 85 2e 32 7b  8a 15 d2 d4 4d
a2 a5 d1  .?....2{....M...
        0250: 68 03 29 cb e6 b3 cc 92  a9 de c0 82 3a
62 9c 65  h.).........:b.e
        0260: 70 16 19 e4 56 67 76 da  3b 53 3e dc ac
49 c9 c8  p...Vgv.;S>..I..
        0270: aa 4e e4 a7 71 cd 79 b7  e6 04 06 a7 ad
eb 2b 6e  .N..q.y.......+n
        0280: 71 92 47 6a 0a 21 b9 92  3e 18 90 ec dd
bd 29 1a  q.Gj.!..>.....).
        0290: 74 8f 0a 87 70 23 a7 a5  2d 10 15 8c e2
26 db f7  t...p#..-....&..
        02a0: 95 ba e6 ae 43 2c 2e 85  53 18 1d aa 63
7e a3 24  ....C,..S...c~.$
        02b0: 8d 1a 55 26 20 42 8e 73  56 be d4 cc 8b
ba 42 30  ..U& B.sV.....B0
        02c0: 31 8a b1 25 61 b1 ca ec  41 2e 4a f6 15
5a f8 4b  1..%a...A.J..Z.K
        02d0: 2b fe ec 15 7f 5a 49 a6  3b 5c ac 2c 9c
cd be 52  +....ZI.;\.,...R
        02e0: c4 81 d2 84 81 5a 40 c5  58 38 e8 29 8f
95 a4 39  .....Z@.X8.)...9
        02f0: 90 16 2d 21 28 07 eb 4f  8d 19 a2 12 10
42 8e 80  ..-!(..O.....B..
        0300: 52 6e c4 92 c7 17 9c cc  cb 90 54 52 8c
b4 27 cb  Rn........TR..'.
        0310: 6d a7 bd 4a 93 b8 b9 48  5c b8 d8 18 b1
f4 35 24  m..J...H\.....5$
        0320: 8e 4b aa b9 ca 8f 5a a6  ae 36 ae 81 50
a9 2d 10  .K....Z..6..P.-.
        0330: 38 f4 35 14 f3 bb 32 8c  15 ed 4c 16 c3
d7 69 fd  8.5...2...L...i.
        0340: d3 a9 23 ae ea 7b 5b 00  bf 21 3e d5 9b
b8 c8 d9  ..#..{[..!>.....
        0350: da 20 63 61 b7 23 ad 43  6a ce c1 81 8c
e0 77 ab  . ca.#.Cj.....w.
        0360: 8a b0 31 ef b5 30 7c b6  1f 4a 49 a7 49
48 31 b6  ..1..0|..JI.IH1.
        0370: d6 1c 10 69 fb ab 42 5a  b9 3c 3e 4e 3e
69 0f 3e  ...i..BZ.<>N>i.>
        0380: b5 3a 5b c6 91 10 26 04  b5 2b 58 69 58
59 99 61  .:[...&..+XiXY.a
        0390: 88 44 a3 70 3d 4d 47 e4  a9 81 42 2f 06
9a 15 f5  .D.p=MG...B/....
        03a0: b1 15 dc 60 c5 b5 0e 18  76 aa d1 02 59
12 55 c3  ...`....v...Y.U.
        03b0: 7a 50 2e 5b 32 ec 91 8d  c1 01 19 22 a1
9a 35 85  zP.[2......"..5.
        03c0: 54 b1 fd e0 ea 05 2d 8d  7c 8a 9e 7b 87
2b 14 27  T.....-.|..{.+.'
        03d0: e6 ee 6a 68 ce c8 b0 70  65 f7 a1 59 e8
4b 8f 28  ..jh...pe..Y.K.(
        03e0: 79 d2 98 08 75 f9 cd 43  0a bc 8c 00 4c
2a f3 9a  y...u..C....L*..
        03f0: 5c a8                                   
         \.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 01 44 d7 57 4c 73 85 1c  66 92 e6 39 c3
a2 38 3b  .D.WLs..f..9..8;
        0010: 3b 11 52 a1 61 ee 5a 86  dc 86 cb 29 1c
70 4d 49  ;.R.a.Z....).pMI
        0020: f6 66 da 64 61 c8 ef 47  2a 5a 8d 3b 6c
24 31 ad  .f.da..G*Z.;l$1.
        0030: ca b3 ee f9 d7 b1 a4 4f  3e 45 11 79 58
1e b4 d4  .......O>E.yX...
        0040: 97 51 c9 df 61 1a 09 15  36 92 42 0e e2
a5 b7 88  .Q..a...6.B.....
        0050: bf 0c c7 03 a5 4c 65 76  45 85 8d 9e 19
cb 32 02  .....LevE.....2.
        0060: a3 a0 a4 b8 b8 73 22 95  8b 8e f5 56 48
36 1d 2d  .....s"....VH6.-
        0070: ec c3 6a 98 80 4e e4 d3  25 bc 51 1a ec
01 a9 a8  ..j..N..%.Q.....
        0080: 93 29 bb d8 58 ef 8a 90  65 8f 60 35 33
eb 16 dc  .)..X...e.`53...
        0090: 43 b3 04 f5 34 4e 3c cb  41 ad 8c fb e9
02 11 b0  C...4N<.A.......
        00a0: 7c 87 9a 6c 4d 0c 8a 02  0f de 1e c2 92
8d 95 81  |..lM...........
        00b0: 26 c7 4e 85 86 d5 8f 04  75 a7 88 f3 6c
bb 49 24  &.N.....u...l.I$
        00c0: 55 2d 81 26 b7 21 5d ef  cc 8d 86 1d 05
56 9e e2  U-.&.!]......V..
        00d0: 64 c3 a0 24 29 e7 14 fa  14 dd cb 24 bd
d7 97 20  d..$)......$...
        00e0: 70 40 eb 53 dc 43 b5 55  d1 f9 3d 45 44
11 24 13  p@.S.C.U..=ED.$.
        00f0: 46 23 45 92 33 97 ef 49  18 90 28 60 40
cf 63 54  F#E.3..I..(`@.cT
        0100: 09 58 b7 25 ca f9 41 59  3e 71 c7 d6 a3
6b 91 1b  .X.%..AY>q...k..
        0110: a8 54 f9 7b fb 52 b2 dc  0b a2 78 c8 57
38 19 a8  .T.{.R....x.W8..
        0120: 53 c8 92 72 c1 f2 07 6a  1a 7b a0 2c af
94 a5 98  S..r...j.{.,....
        0130: 28 df d8 0a 8c 18 dc 3f  96 a7 7f 70 7b
50 90 9c  (......?...p{P..
        0140: 2f a9 4d 90 a3 af 96 32  7b d4 f2 4e 19
94 63 e6  /.M....2{..N..c.
        0150: 14 34 86 89 8b 22 be e8  47 cc 47 22 b3
d9 98 dc  .4..."..G.G"....
        0160: 12 17 e5 ee 29 c4 7b 16  a2 68 fc cd 92
26 14 f4  ....).{..h...&..
        0170: a8 6e 41 59 c8 88 66 3f  41 4c 19 6a c2
48 59 0a  .nAY..f?AL.j.HY.
        0180: cd f2 e3 b5 3a 47 89 09  f2 c8 24 74 ac
1c 1a 77  ....:G....$t...w
        0190: 04 ec 48 26 0d 18 25 70  d5 28 31 f9 40
b0 da c2  ..H&..%p.(1.@...
        01a0: b5 7a 21 22 8d fc 89 3c  67 cb e1 fd 45
47 6f 18  .z!"...<g...EGo.
        01b0: 58 d0 ff 00 10 eb 49 5e  c0 8b d3 48 86
20 08 20  X.....I^...H. .
        01c0: 1e 31 54 45 ab bb 15 51  85 a7 7b 68 c0
8a 5b 39  .1TE...Q..{h..[9
        01d0: 22 6e 18 e1 bd 2a 7b 74  48 22 31 33 93
21 e9 54  "n...*{tH"13.!.T
        01e0: 1b 12 ac ae bf ba 91 f2  08 e8 68 50 07
cb 1f 1f  ..........hP....
        01f0: 5a 57 e8 09 dc 8c 29 76  21 c0 18 a4 8c
4e 26 23  ZW....)v!....N&#
        0200: a2 1e 86 95 92 63 27 08  85 0a 11 f3 0e
f5 14 32  .....c'........2
        0210: 3c 4c ca 70 58 d3 d1 80  46 aa 1b 70 63
bc 54 c3  <L.pX...F..pc.T.
        0220: cc 65 2a e3 20 fa 56 4d  59 83 12 35 90
29 75 04  .e*. .VMY..5.)u.
        0230: 81 53 45 1c 93 8e 01 15  aa 68 07 0b 69
08 0c 84  .SE......h..i...
        0240: 80 a7 a5 3a 43 31 07 2a  4a d3 11 12 3c
a7 1e 56  ...:C1.*J...<..V
        0250: 54 0e b4 97 11 4a d2 7e  f1 49 14 9b b0
d2 b9 1c  T....J.~.I......
        0260: 56 ce 59 8a c7 83 8e 94  c3 6c d1 e4 b2
95 3d 85  V.Y......l....=.
        0270: 30 b1 25 a5 aa b2 b9 28  43 7a 53 64 49
2d 94 88  0.%....(CzSdI-..
        0280: d0 92 7b fa 56 7c cd 3b  30 19 02 0d a5
83 1d fd  ..{.V|.;0.......
        0290: c5 2c 76 fe 69 c8 6c 11  da b4 0b 11 4b
68 01 21  .,v.i.l.....Kh.!
        02a0: 81 56 ed 48 60 63 18 50  c7 02 81 0c 9a
00 f1 ae  .V.H`c.P........
        02b0: e6 21 a9 a2 d7 e5 cc 2f  9f 5a 10 9b 48
05 b3 15  .!...../.Z..H...
        02c0: c9 ce 7d 28 4b 25 39 65  7c 91 d4 52 92
6f 61 ad  ..}(K%9e|..R.oa.
        02d0: 45 fb 18 28 1c bf 07 b5  5d b6 8a 18 4a
fe f3 71  E..(....]...J..q
        02e0: 3e f4 6c 80 b9 75 74 b0  db ee 84 8d de
83 bd 51  >.l..ut........Q
        02f0: fb 54 92 c0 7e 6c 13 d7  3d a8 b5 c4 8a
5b 5f 27  .T..~l..=....[_'
        0300: 19 c8 e8 45 5f b6 46 31  83 2b e0 fa 50
d5 d5 86  ...E_.F1.+..P...
        0310: 59 58 ed e4 8c 9e 09 1d  68 82 3b 74 53
19 60 55  YX......h.;tS.`U
        0320: bf 4a ce 34 da ea 00 b0  db 23 00 0f 20
f1 49 71  .J.4.....#.. .Iq
        0330: 14 2b 2e f5 39 3e 95 4e  2d b0 12 31 6e
92 07 cf  .+..9>.N-..1n...
        0340: 1d c5 49 2b 5a 9c 32 1a  ab 30 bd 86 ff
00 a2 6c  ..I+Z.2..0.....l
        0350: da cb c1 a1 56 df 21 a1  19 c7 4a 4e e0
4b 1a c4  ....V.!...JN.K..
        0360: e3 2d 80 47 5a af 3c 29  1c 85 d1 81 43
da a2 77  .-.GZ.<)....C..w
        0370: b0 19 a6 db cd ba 62 46  07 a0 a8 9c 34
0c c0 02  ......bF....4...
        0380: 73 d0 55 53 56 42 48 ae  ab 70 8e 18 a1
0d 9e b5  s.USVBH..p......
        0390: b5 63 38 85 82 cc 00 0c  39 35 5e 43 b1
64 6a 11  .c8.....95^C.dj.
        03a0: 2b 14 75 1b 3b 1a 7a 2c  12 ca a5 b0 00
e4 1a cd  +.u.;.z,........
        03b0: d3 10 f9 c4 0c f9 84 29  ec 6a 3c 40 23
03 03 03  .......).j<@#...
        03c0: ad 57 2b 4b 42 87 aa d9  b7 2a 32 45 10
4b 6f 24  .W+KB....*2E.Ko$
        03d0: e0 1e dc 62 a6 d2 02 f2  cb 6f 19 67 c2
9c 74 1d  ...b.....o.g..t.
        03e0: ea ac c6 39 a0 72 d8 4d  de 95 4a 02 31
d2 d5 7c  ...9.r.M..J.1..|
        03f0: cc 79                                   
         .y
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: d9 41 57 5e ca 34 1e 62  be e5 c5 53 02
bf d8 a1  .AW^.4.b...S....
        0010: 0c ac 5f 19 f4 ed 55 ee  ad 16 49 42 43
29 20 54  .._...U...IBC) T
        0020: d9 b0 1e 6d 37 11 99 3e  41 56 23 8a dc
8f 99 8e  ...m7..>AV#.....
        0030: d5 eb 56 05 83 1d aa 28  68 ce 73 d2 99
21 b7 74  ..V....(h.s..!.t
        0040: 01 5b 64 9d 28 02 66 5b  78 91 06 ec b6
39 35 5e  .[d.(.f[x....95^
        0050: da da d8 bb 17 93 af 4a  ce 50 6d dd 00
f2 90 44  .......J.Pm....D
        0060: c1 50 82 0d 2b 84 55 d9  19 00 0e b4 72
58 4e e5  .P..+.U.....rXN.
        0070: 29 ed a3 91 95 a3 95 83  1f 7a 54 b5 87
2c 7c df  )........zT..,|.
        0080: 9d 7b d5 6a 32 15 03 27  12 1d d9 e2 a4
79 ae 20  .{.j2..'.....y.
        0090: 21 c1 0c a7 a8 15 43 b1  0c ec e6 23 26
e2 73 db  !.....C....#&.s.
        00a0: d2 a0 b5 69 d4 ab 07 62  3d e9 39 2b d8
9b 5d 97  ...i...b=.9+..].
        00b0: a6 b9 79 20 60 dc 30 ef  54 3c e9 9e 0e
b8 a1 58  ..y `.0.T<.....X
        00c0: 7b 0c 8c 36 e5 49 1b 39  ab 4e 62 51 e5
04 eb de  {..6.I.9.NbQ....
        00d0: 9a 44 fa 15 e4 85 22 6c  31 c9 6a 76 d0
88 70 dc  .D...."l1.jv..p.
        00e0: e2 a6 cd 94 98 fb 78 11  ad d9 89 1b bd
6a 38 b6  ......x......j8.
        00f0: aa e0 a8 07 fb d4 4b 62  5c 84 75 85 13
2c 32 33  ......Kb\.u..,23
        0100: d4 53 63 85 11 19 f7 63  3c 8c 51 15 64
52 77 d4  .Sc....c<.Q.dRw.
        0110: bb 0c e4 da 98 e3 70 1c  d3 5e 37 58 86
30 cc 78  ......p..^7X.0.x
        0120: aa bd 89 72 41 09 96 05  45 c0 3e f5 33
5e 3e 46  ...rA...E.>.3^>F
        0130: d4 0c 4f 15 29 6a 38 b6  91 23 de 49 6f
82 53 76  ..O.)j8..#.Io.Sv
        0140: 69 d6 b7 eb bf 71 88 12  7a 55 5a c6 8a
4d e8 54  i....q..zUZ..M.T
        0150: bb f3 26 66 dd 8d 80 e7  14 5b c8 e4 83
ff 00 2c  ..&f.....[.....,
        0160: c7 18 ac af 79 13 62 7f  b4 f9 52 e0 00
10 8a a0  ....y.b...R.....
        0170: 62 76 95 e4 84 9d bd 4d  0a 2d 48 69 5c
b9 63 3b  bv.....M.-Hi\.c;
        0180: b0 f9 d0 10 28 9d 3e d0  ec d1 0c 30 1c
0a d4 23  ....(.>....0...#
        0190: a0 5a cd 24 71 ed 2b 96  1d 6a 60 d1 bc
61 d9 40  .Z.$q.+..j`..a.@
        01a0: c1 e9 41 23 a5 90 31 0a  a8 30 69 9f 6b
36 e8 55  ..A#..1..0i.k6.U
        01b0: d0 1d bd 28 1d ca 17 ae  6e 40 91 97 6b
e7 a5 5e  ...(....n@..k..^
        01c0: b7 95 e3 b6 28 14 11 53  bb 04 ec 2a 5c
ef 60 8e  ....(..S...*\.`.
        01d0: 83 07 a7 15 4a ea 01 e7  ef 0b d2 8b 6a
02 35 b7  ....J.......j.5.
        01e0: da 11 4e 42 90 7a 0e f4  c9 2c b6 38 90
39 18 e8  ..NB.z...,.8.9..
        01f0: 29 82 2e 4e 14 47 18 2d  8c 8e 5a a0 86
66 8c 98  )..N.G.-..Z..f..
        0200: fe 62 bd 88 a1 bb 02 4a  e3 5e 3f dd ee
59 37 31  .b.....J.^?..Y71
        0210: 34 91 6e 47 26 5e 73 fc  5e 94 45 77 09
5a fa 12  4.nG&^s.^.Ew.Z..
        0220: a3 6e 38 ce 08 e8 6a 31  3c 9f 3c 73 2e
09 e8 c6  .n8...j1<.<s....
        0230: 8b ad 8a 4a fb 09 1b 00  84 b3 82 eb d3
de 9a 1f  ...J............
        0240: ce 94 3a a1 00 76 a8 9e  81 27 71 64 77
2c 54 21  ..:..v...'qdw,T!
        0250: c5 41 f6 96 5e 91 9d 9d  0d 66 dc b6 45
45 24 ae  .A..^....f..EE$.
        0260: c9 a6 95 56 14 f2 01 52  7a d4 91 5d ba
46 5a 40  ...V...Rz..].FZ@
        0270: 1b 1d 01 aa 50 77 b9 0d  f6 1f 77 73 24
e1 4a 30  ....Pw....ws$.J0
        0280: 0b 8e 45 24 77 4c ab b4  92 54 76 ad 89
15 18 bb  ..E$wL...Tv.....
        0290: 64 0d a3 b0 15 37 9c fc  1c e1 bb 2d 4c
a0 98 c4  d....7.....-L...
        02a0: 69 ae a5 8c 92 a3 03 b7  ad 49 06 f3 11
62 a5 49  i........I...b.I
        02b0: e3 e9 49 41 2d 86 b5 2b  88 25 67 df 13
16 03 ae  ..IA-..+.%g.....
        02c0: 69 63 91 d4 bf 19 6f 7a  5c 96 77 1c 90
c6 2f 2b  ic....oz\.w.../+
        02d0: 64 83 83 d6 9a b1 ed 70  ac 99 4e d8 a3
9a fa 21  d......p..N....!
        02e0: 4a 28 92 48 41 8c 99 32  4f 61 8a aa b6
32 99 84  J(.HA..2Oa...2..
        02f0: bb 3e 51 da 93 97 26 8c  56 b9 29 c9 18
f2 fe 5e  .>Q...&.V.)....^
        0300: 99 34 c8 2d cc 32 86 41  c7 ad 69 17 74
3b 58 7a  .4.-.2.A..i.t;Xz
        0310: f9 c9 23 15 5d ea dd e9  8c f3 22 18 e3
53 82 79  ..#.]....."..S.y
        0320: 6f 4a 25 b1 4e f2 44 d1  41 20 8f e7 5d
c7 b1 a9  oJ%.N.D.A ..]...
        0330: ad 6d 15 d9 a3 2b b4 91  de b3 d4 8b 58
64 36 6c  .m...+......Xd6l
        0340: 85 a3 50 02 83 4d 96 de  69 8e 63 e1 57
ad 3e 71  ..P..M..i.c.W.>q
        0350: 58 6a c3 2b 49 80 a3 6d  45 73 e6 99 15
4c 67 03  Xj.+I..mEs...Lg.
        0360: b8 ab 4e e8 a8 c5 bd 87  15 95 c8 54 41
b4 0e 4d  ..N........TA..M
        0370: 24 cb 94 5c af 19 ea 2a  65 a0 b9 47 bc
88 bb 71  $..\...*e..G...q
        0380: 1e 56 95 55 65 73 2a 2e  cd bd 00 ef 42
93 61 62  .V.Ues*.....B.ab
        0390: 63 22 44 03 93 86 6a 46  25 5d 59 3a b7
5a b0 23  c"D...jF%]Y:.Z.#
        03a0: bc de 8c a1 78 cd 30 cc  a5 7e 61 89 57
a5 29 6c  ....x.0..~a.W.)l
        03b0: 01 1d c7 97 80 dc b1 ef  4e 66 44 60 23
04 96 ea  ........NfD`#...
        03c0: 6a 60 f9 90 84 91 d0 32  7c c2 87 96 38
e4 0c 0e  j`.....2|...8...
        03d0: 50 f5 a5 af 30 20 76 8a  59 17 6f 07 d6
ac c7 e5  P...0 v.Y.o.....
        03e0: b3 f1 80 ab fa d6 80 c9  36 33 32 ec 20
a9 ab 17  ........632. ...
        03f0: 51 09                                   
         Q.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 00 f2 87 cc a3 9a 97 2e  80 55 8e d4 aa
37 cb f2  .........U...7..
        0010: 9a 4b 48 a5 47 38 4c a5  1b 20 51 15 c4
b2 31 60  .KH.G8L.. Q...1`
        0020: 98 51 4c 77 b8 42 7e 53  f4 a7 74 c6 81
1e 5c 86  .QLw.B~S..t...\.
        0030: 74 24 0e d4 bf 65 79 24  59 55 08 cd 31
58 93 c8  t$...ey$YU..1X..
        0040: 67 93 0d 19 c8 ef 52 cd  69 3f ca 62 5f
98 51 60  g.....R.i?.b_.Q`
        0050: 21 68 6e 82 33 98 f2 d5  1e e9 1e 35 56
3b 08 ea  !hn.3......5V;..
        0060: 28 6a e3 b1 20 80 ec 0a  1b 93 56 6e ad
22 86 14  (j.. .....Vn."..
        0070: 2c c3 3d ea 62 ac 24 50  49 11 98 f9 58
0a 3b 9a  ,.=.b.$PI...X.;.
        0080: 7c 97 12 22 6d 41 cf 6a  1d 82 c4 b0 4f
32 44 09  |.."mA.j....O2D.
        0090: 00 e6 97 ed 77 28 c1 00  00 9e a6 9a b0
ac c9 4d  ....w(.........M
        00a0: fc d1 05 5c 03 8f d6 a0  fe d3 b8 33 15
55 c2 9e  ...\.......3.U..
        00b0: b9 14 ef 61 92 b5 cc cf  22 ed 40 80 53
25 bf 9d  ...a....".@.S%..
        00c0: 65 29 80 4f 63 e9 4b 46  31 12 fa e8 31
d8 83 23  e).Oc.KF1...1..#
        00d0: a9 a6 dc 5e 5c 4e 53 2a  03 50 90 b5 27
b7 bd 91  ...^\NS*.P..'...
        00e0: 4f 97 22 f3 ea 05 3e e6  e4 b6 d4 8c 66
a1 c2 ee  O."...>.....f...
        00f0: e3 1d 04 68 91 13 2a 80  3a 9a 92 59 a1
44 f3 2d  ...h..*.:..Y.D.-
        0100: d3 27 1d 2b 40 12 19 61  b9 84 b5 c6 14
8e 94 c5  .'.+@..a........
        0110: 10 f2 40 e3 b5 24 84 20  16 f3 23 36 36
e2 b3 06  ..@..$. ..#66...
        0120: e4 66 f2 50 85 cf 5a 76  0b 1a 12 42 7e
ce b2 44  .f.P..Zv...B~..D
        0130: 99 7a a4 8b 22 92 bb 31  bb a9 a8 52 e8
34 8b ff  .z.."..1...R.4..
        0140: 00 64 85 d1 53 7e 01 ef  49 fd 99 67 02
e5 a5 2c  .d..S~..I..g...,
        0150: ff 00 5a 69 b6 c9 6e c4  90 e9 d6 d2 36
56 43 8f  ..Zi..n.....6VC.
        0160: 7a 8e 6b 68 fc e3 1c 78  00 7a 53 4c 68
12 dd 91  z.kh...x.zSLh...
        0170: 4a 00 31 eb 4e 4b 70 1c  e4 f0 7b d1 70
1a b6 98  J.1.NKp...{.p...
        0180: 43 93 88 c7 71 de a3 f2  78 dc bc 45 42
63 d2 c3  C...q...x..EBc..
        0190: 97 cb 67 50 cc 38 ed 55  9c fe f5 ca 3f
d0 51 6d  ..gP.8.U....?.Qm
        01a0: 44 4d 0a 5b b2 16 b8 6d  ac 7b 54 b0 c5
69 e5 90  DM.[...m.{T..i..
        01b0: 1f e6 06 a5 a6 d8 0e 7b  58 58 62 37 c9
3d aa 2b  .......{XXb7.=.+
        01c0: b8 96 cc 22 c4 d9 76 eb  4d a1 91 a4 2e
79 c1 da  ..."..v.M....y..
        01d0: 69 0a ca 5b 08 3e 41 d7  35 5b 81 62 ce
1f 31 59  i..[.>A.5[.b..1Y
        01e0: 9f e5 1e b5 64 d8 5b bc  6a ca d9 35 1a
a6 22 19  ....d.[.j..5..".
        01f0: ac f3 26 dd c0 2d 2c 5a  76 f3 86 19 51
d2 9c 97  ..&..-,Zv...Q...
        0200: 51 8d 6b 20 4b 2b 46 08  1d 29 4d 9b 2c
41 8f 4e  Q.k K+F..)M.,A.N
        0210: c2 a7 99 d8 03 ec 80 23  0e 43 9f 4a 8e
3b 1d 91  .......#.C.J.;..
        0220: 6d 49 37 b1 eb ed 4a 32  6c 69 e8 3b ec
92 c5 1e  mI7...J2li.;....
        0230: e0 bc d5 69 37 43 87 0b  86 ef 5a 27 71
11 f9 a8  ...i7C....Z'q...
        0240: 53 cc c9 0d 9e 46 6a 19  2f 49 90 aa 02
47 a5 31  S....Fj./I...G.1
        0250: 05 cc a4 08 c2 2f 27 a8  ab 76 71 4d 2a
ed 46 c2  ...../'..vqM*.F.
        0260: 7a 13 40 1a 2b a6 e2 32  43 64 e2 aa 2d
99 8c 33  z.@.+..2Cd..-..3
        0270: 28 c0 3d 4d 4f 35 80 8d  2d 1e 4c 82 76
81 de a1  (.=MO5..-.L.v...
        0280: b9 85 e3 4c 46 73 eb 54  05 54 f3 65 70
b9 db 8e  ...LFs.T.T.ep...
        0290: d5 72 1b 56 07 33 91 b3  d6 86 ec 04 f2
59 b3 82  .r.V.3.......Y..
        02a0: 44 83 cb a5 4b 48 cc 5b  0b e3 de 93 63
27 5b 5b  D...KH.[....c'[[
        02b0: 65 41 96 c3 0e f4 d9 6d  ed c2 02 58 9c
fa 52 57  eA.....m...X..RW
        02c0: 68 1d 88 fc a8 03 82 d2  00 07 6a 8e 58
ad 04 c1  h.........j.X...
        02d0: 96 4c 03 d4 66 88 ab 08  7a 26 9e 08 4f
30 03 eb  .L..f...z&..O0..
        02e0: 49 e4 5b 3b 49 e4 c9 b8  53 d8 69 d8 af
1d a4 51  I.[;I...S.i....Q
        02f0: 48 03 3e f4 7e be d5 62  18 ad e3 0e 33
85 a8 5e  H.>.~..b....3..^
        0300: f0 b9 d0 c9 22 84 a9 c3  82 05 40 90 43
2a 14 3c  ....".....@.C*.<
        0310: 0f 6a bf 85 0d 0d 16 90  49 28 56 62 19
7a 54 ad  .j......I(Vb.zT.
        0320: 61 0a b8 3e 67 34 27 72  bd db 08 96 56
f3 83 bd  a..>g4'r....V...
        0330: 8e e0 7a d5 e8 ad 2d 0c  65 4b 0e 07 5a
1d c8 1b  ..z...-.eK..Z...
        0340: f6 5b 48 14 1c f0 6a b3  45 64 c4 a2 e7
1e b5 94  .[H...j.Ed......
        0350: e3 27 6b 05 91 5d ad a0  56 64 63 80 6a
01 a7 a3  .'k..]..Vdc.j...
        0360: cb b1 24 da b8 e0 1a d5  05 ac 39 74 e1
1b 14 2e  ..$.......9t....
        0370: 4e 7a 54 e6 ca 54 88 15  6e 47 45 34 36
16 42 c8  NzT..T..nGE46.B.
        0380: 1f cb 40 eb 82 7b 52 24  33 2b 12 8a 33
42 77 02  ..@..{R$3+..3Bw.
        0390: 0b ab 83 0c 81 71 96 6e  a3 d2 a4 40 63
40 40 3f  .....q.n...@c@@?
        03a0: 37 b5 0d 5c 6d 8c ba 06  35 52 a7 9e f5
58 5c 93  7..\m...5R...X\.
        03b0: 20 56 6c 25 25 14 80 94  cb e6 49 b7 6f
02 ac 45   Vl%%.....I.o..E
        03c0: 3b 98 d9 12 2f 90 7b 55  21 5c 88 4a d0
12 44 79  ;.../.{U!\.J..Dy
        03d0: 56 eb ed 4b 0d ca c6 5b  0d 80 7a 51 60
1c 64 54  V..K...[..zQ`.dT
        03e0: 1b 8e 49 a9 24 9a 16 8d  58 b8 e9 d0 76
a2 c0 35  ..I.$...X...v..5
        03f0: 0a ba                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 23 09 80 5c d5 a8 ad d1  a3 72 f2 2e e3
d2 84 ac  #..\.....r......
        0010: 02 9b 78 04 40 b3 82 c2  a2 95 1c c4 1a
32 00 f4  ..x.@........2..
        0020: a9 bd 85 cc ba 05 9c 73  84 20 20 39 ea
69 5e 0b  .......s.  9.i^.
        0030: 95 12 6e 8c 32 1e 86 85  34 2d f6 1d 69
6f 3b 45  ..n.2...4-..io;E
        0040: bc c7 b1 47 4a 6c f6 b3  e7 69 19 27 b5
3b 94 20  ...GJl...i.'.;.
        0050: d3 2e 2e 23 c3 1e 9d 05  48 34 c9 22 b7
50 ac 33  ...#....H4.".P.3
        0060: dc 51 a6 c2 4a c3 e4 b0  48 54 3a 0d cd
8e 6a 94  .Q..J...HT:...j.
        0070: 52 47 20 74 9b af a0 a9  bd 9d 87 63 3d
83 c7 31  RG t.......c=..1
        0080: 2e d8 5e d4 24 e2 4d c2  42 5a ab 46 5f
c2 c4 89  ..^.$.M.BZ.F_...
        0090: 56 45 2f 8d bb 78 15 6a  09 bc 96 0a 48
20 54 c6  VE/..x.j....H T.
        00a0: ef 71 4b 73 41 a7 42 bb  d4 02 7d 05 57
f3 63 55  .qKsA.B...}.W.cU
        00b0: 2c a8 0a 31 e7 3d aa c4  49 22 c3 b5 0c
64 10 7b  ,..1.=..I"...d.{
        00c0: 1a a8 d2 43 24 b2 07 5c  10 30 31 d2 93
dc 7b 11  ...C$..\.01...{.
        00d0: 42 61 3f 28 cf 1d ea 78  e5 8d 79 55 c9
14 48 49  Ba?(...x..yU..HI
        00e0: 92 4d 71 1c 48 1a 15 cb  37 51 42 dc a2
98 e4 96  .Mq.H...7QB.....
        00f0: 2c 37 b5 44 5b 6c 7a 58  98 de 46 23 de
a3 92 7a  ,7.D[lzX..F#...z
        0100: 51 36 a0 a2 21 1c 4b 80  7a e6 b4 b0 26
91 14 37  Q6..!.K.z...&..7
        0110: 92 ba e2 35 55 51 db d6  9d 2d d2 c5 19
2c 80 cb  ...5UQ...-...,..
        0120: 53 2b 35 61 b8 d9 11 dc  5e 6f 84 28 4d
8d 49 1d  S+5a....^o.(M.I.
        0130: ef 94 88 4a 0c f6 cf 7a  51 8d 89 b0 93
6a 3e 6c  ...J...zQ....j>l
        0140: e1 d5 14 11 c6 05 59 5b  a6 0a a8 e0 79
8d d0 52  ......Y[....y..R
        0150: 71 b8 58 81 5e 67 77 8a  45 00 f6 14 b0
48 c7 31  q.X.^gw.E....H.1
        0160: c8 80 2a d5 ec 09 d8 92  19 55 64 60 72
17 1d 2a  ..*......Ud`r..*
        0170: 16 9d 91 70 13 82 68 93  b2 d0 2e 22 5d
bf 9c 51  ...p..h...."]..Q
        0180: c6 d5 c7 5a b4 66 dc 23  29 d7 b9 a9 6f
41 a6 32  ...Z.f.#)...oA.2
        0190: e6 58 83 17 2c 55 07 61  4d 8a e1 0c 44
ab ed 53  .X..,U.aM...D..S
        01a0: d3 de 85 6e 83 e8 57 79  4c 41 5f 7e 49
3d 29 cd  ...n..WyLA_~I=).
        01b0: 72 5f e4 ce 33 de ac 94  da d8 b5 12 2a
28 0c c7  r_..3.......*(..
        01c0: 2d e9 4d 3b 22 62 b2 1f  94 f4 a8 9a b8
5c 85 65  -.M;"b.......\.e
        01d0: 8c 06 c0 24 7a 53 a1 90  26 dd ab 80 4d
35 1b 08  ...$zS..&...M5..
        01e0: 35 08 89 65 90 2e 56 a6  46 8a 38 b7 6d
dc 7b 53  5..e..V.F.8.m.{S
        01f0: 4e e3 1a fe 5c 89 b8 fd  e3 d2 a8 25 b0
2c db 99  N...\......%.,..
        0200: b7 7a d3 4d 30 2c 2c 69  13 a2 a8 dc 1b
ae 7b 55  .z.M0,,i......{U
        0210: df f4 7f 30 28 00 91 4a  da 68 22 96 a9
6b 0e fd  ...0(..J.h"..k..
        0220: f1 f2 4f 61 54 be ce eb  06 07 3e 82 a5
ca c3 48  ..OaT.....>....H
        0230: 54 b7 67 08 09 f9 8f 6f  4a 91 a3 72 44
47 23 6f  T.g....oJ..rDG#o
        0240: 4c 77 aa 8e a8 04 48 ee  b7 84 0c 54 8e
95 a4 f2  Lw....H....T....
        0250: ca 10 02 72 e0 73 ef 49  b4 84 24 32 cf
25 b4 9b  ...r.s.I..$2.%..
        0260: 40 ca fa d3 60 b8 9b cb  52 a7 e5 e8 69
3b 34 32  @...`...R...i;42
        0270: 53 70 f1 21 20 82 3d 29  ef 7b fb a5 e0
64 f5 35  Sp.! .=).{...d.5
        0280: 49 58 45 98 ee 13 ca 09  81 f3 77 a6 7d
b1 90 88  IXE.......w.}...
        0290: 42 fc be b4 c0 72 5f 15  93 1b 38 14 f1
7e b1 ce  B....r_...8..~..
        02a0: 0f 55 3d 45 4b d1 0e c3  46 a0 5e e4 94
4f dd 7a  .U=EK...F.^..O.z
        02b0: 55 4b a9 92 69 b7 14 38  3c 71 4d 6c 04
f6 e2 18  UK..i..8<qMl....
        02c0: dc 31 c9 5f 5a 56 16 f7  2e c4 31 20 76
a0 40 2c  .1._ZV....1 v.@,
        02d0: ad b1 90 70 be 95 30 b5  85 e2 0d b7 91
c5 64 93  ...p..0.......d.
        02e0: b8 ee 5a 8a ca 31 12 80  3b e7 9a 5b 8b
48 fe f0  ..Z..1..;..[.H..
        02f0: 5c 9e 98 a4 94 93 02 85  c6 9f 14 4b e6
3b fd 2a  \..........K.;.*
        0300: a4 ef 1e d5 e9 b9 7a 62  b4 8a 6c 45 37
bc 12 cc  ......zb..lE7...
        0310: 32 0a 85 ed 4f 82 e6 11  23 0c 75 f5 ab
b5 c6 58  2...O...#.u....X
        0320: b7 25 dc ac 04 10 69 d2  c6 6d e3 31 cc
46 f6 e7  .%....i..m.1.F..
        0330: 23 b5 26 ec 1b 05 a6 66  51 e5 63 2b c6
6a 56 b5  #.&....fQ.c+.jV.
        0340: 90 1d ca 70 d4 5f b0 d9  65 6d a4 78 4a
f5 26 9b  ...p._..em.xJ.&.
        0350: f6 29 23 87 2a 30 7a 62  84 c9 21 7d 3d
f7 02 5b  .)#.*0zb..!}=..[
        0360: e5 3d 45 32 e4 f9 03 23  1b 57 b5 34 05
48 6e d2  .=E2...#.W.4.Hn.
        0370: 7d ff 00 2e 12 9d 0c c8  0b 02 72 3b 2d
00 58 8a  }.........r;-.X.
        0380: f1 c2 90 41 0a 3a 0a 8a  19 cb ac 81 c1
cf 61 52  ...A.:........aR
        0390: d0 10 ab b6 4a 86 20 0e  d5 23 f3 b5 18
9e 6a 92  ....J. ..#....j.
        03a0: b0 58 95 a4 58 8a a9 72  a4 77 15 1a bb
89 8b c6  .X..X..r.w......
        03b0: 77 67 b9 a0 09 1e f9 43  85 3c 3f 7a 56
9b 6c 78  wg.....C.<?zV.lx
        03c0: 91 fe 56 f4 a2 d7 01 22  b8 c4 4c a1 be
5e d9 a8  ..V...."..L..^..
        03d0: dd 9a 38 f0 ad 9c f6 a9  f8 40 36 2a ba
80 bf bc  ..8......@6*....
        03e0: 3d 4d 45 2a 05 94 a2 63  79 a2 2e e3 0f
20 34 81  =ME*...cy.... 4.
        03f0: 26 7c                                   
         &|
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 1f 4a 7c 28 ab 38 50 32  a2 9b d3 51 16
12 17 32  .J|(.8P2...Q...2
        0010: 97 8f f2 14 d9 f8 90 65  49 23 a9 34 2d
40 59 6e  .......eI#.4-@Yn
        0020: 5f 6a 6d 04 0a 27 95 84  39 0a 7e 82 96
b7 00 0e  _jm..'..9.~.....
        0030: e6 35 2c 48 52 3e e8 a9  62 94 85 18 e0
76 14 db  .5,HR>..b....v..
        0040: b0 c6 c7 26 eb 80 1c 9c  0a 7c d7 33 6e
25 1c 2a  ...&.....|.3n%.*
        0050: 8a 2e 81 a1 05 db 1c 2a  b1 de 7d 7b d3
04 f7 07  .......*..}{....
        0060: 2b 29 da 16 9a 25 3b 91  49 79 36 dd c8
dc 54 36  +)...%;.Iy6...T6
        0070: f7 0e bb 8c 6d 86 63 f3  66 84 32 d4 b7
73 26 d4  ....m.c.f.2..s&.
        0080: 2d b9 0f 4a 69 59 ee 0e  de a2 93 76 01
92 d8 3f  -..JiY.....v...?
        0090: 00 8e 07 5c 53 a2 b7 08  fb 91 32 31 ce
6a 64 dd  ...\S.....21.jd.
        00a0: ae 86 25 cc 18 75 28 3e  6f e5 44 31 ce
84 32 82  ..%..u(>o.D1..2.
        00b0: 47 7c 51 19 5c 12 27 37  53 47 84 19 da
dd e9 ab  G|Q.\.'7SG......
        00c0: 33 92 f1 92 4a d5 08 ad  1d e3 b1 68 41
c2 8e a6  3...J......hA...
        00d0: 9c f3 80 9b b1 85 03 1f  5a 63 2b c3 24
6e d9 8c  ........Zc+.$n..
        00e0: 31 61 56 07 9c ec 3c d0  70 7a 0a 4d d8
07 b2 4c  1aV...<.pz.M...L
        00f0: 92 a7 04 27 a0 a6 c8 8f  24 c7 6e 71 ed
59 c1 dd  ...'....$.nq.Y..
        0100: 88 9d 6c 27 23 32 b1 f6  a9 05 94 f1 47
b9 8f d2  ..l'#2......G...
        0110: b5 b8 c8 45 8b 5c 60 b8  2a 7f 9d 25 de
94 7c b0  ...E.\`.*..%..|.
        0120: 10 7c d5 37 b8 8a d7 9a  67 97 68 3e 5f
98 d4 76  .|.7....g.h>_..v
        0130: b0 98 22 1b 33 9e e2 92  d4 08 c3 96 76
c1 20 d3  ..".3.......v. .
        0140: 52 77 85 ff 00 7d f7 4d  52 d0 8e 45 7b
92 70 f2  Rw...}.MR..E{.p.
        0150: 05 87 95 34 e4 53 e7 2a  21 23 1d 68 72
45 97 25  ...4.S.*!#.hrE.%
        0160: b2 91 9f 20 8c 63 ad 56  f9 e2 24 49 92
a3 bd 4a  ... .c.V..$I...J
        0170: 92 7b 12 dd 89 21 98 08  d9 90 6e 1e b4
c3 97 03  .{...!....n.....
        0180: 6e 47 a9 ab 1a 77 12 79  0a 00 b8 2e b5
22 4c bf  nG...w.y....."L.
        0190: 66 cf 94 7f 2e 94 58 a4  53 99 99 80 6c
12 7b 0a  f.....X.S...l.{.
        01a0: 99 e3 9d 84 6f 1a 72 3b  d2 d8 9b 5c b4
be 63 95  ....o.r;...\..c.
        01b0: d9 b7 7f 73 45 c2 dc 02  25 76 0a 3a 0c
53 29 2e  ...sE...%v.:.S).
        01c0: 84 6c 1e 55 ca 12 5c 76  a9 61 8a 61 ce
71 eb 40  .l.U..\v.a.a.q.@
        01d0: 11 4f 62 67 70 e1 78 f7  ab 05 65 8d 50
ed 0c a3  .Obgp.x...e.P...
        01e0: 8c 52 8b b8 34 47 3c 2c  ea 59 a3 ca 1f
d2 ab ad  .R..4G<,.Y......
        01f0: 9c 6a ac e6 32 47 6a 9d  6f a8 58 8e 1b
76 86 71  .j..2Gj.o.X..v.q
        0200: 23 9c 29 ed 5a 71 5e 22  06 c4 63 6d 59
2d 23 36  #.).Zq^"..cmY-#6
        0210: e2 64 95 5c a7 4f 41 51  25 a0 98 2a a0
fa 54 b7  .d.\.OAQ%..*..T.
        0220: 67 61 a6 b6 1d 71 04 90  44 4b 9f 9c 74
5a 22 b1  ga...q..DK..tZ".
        0230: 56 84 33 2e 0b d5 0d ab  0c 5b 42 92 a4
41 4e cc  V.3......[B..AN.
        0240: d5 89 e2 0d 28 58 c9 c2  ff 00 0d 02 60
f9 12 28  ....(X......`..(
        0250: c7 03 b5 22 4a 63 b8 5d  e7 70 3d 16 93
d8 4a 29  ..."Jc.].p=...J)
        0260: 17 62 9d a3 de 03 01 ed  53 bd ee cb 5d
e4 82 be  .b......S...]...
        0270: 94 94 50 da b3 2b 47 7d  2c fb 4c 4d 98
c7 6f 4a  ..P..+G},.LM..oJ
        0280: 74 97 13 97 56 5c 0c 74  aa b5 80 1a ea
e4 b9 e8  t...V\.t........
        0290: aa 07 6a 69 bd 78 50 6f  6d db bf 4a 2c
86 88 5e  ..ji.xPom..J,..^
        02a0: 79 4b 61 4e 51 bb 52 47  02 42 e4 11 cb
f7 3d aa  yKaNQ.RG.B....=.
        02b0: 6e 21 27 b7 89 59 59 9b  2a 2a 24 b7 8e
49 31 16  n!'..YY.**$..I1.
        02c0: d0 5a a7 7d 8b 72 d4 91  ed c4 63 6b e3
27 8a 48  .Z.}.r....ck.'.H
        02d0: ed ad 83 0f 9f 9a 6a ef  e2 1f c4 48 90
43 f3 18  ......j....H.C..
        02e0: 9f 1d b9 aa d7 90 62 22  51 bf 01 4e 5a
2d 0c de  ......b"Q..NZ-..
        02f0: 84 56 d6 f3 3c 3b 4b 02  7d a9 81 0a c9
e5 ab 03  .V..<;K.}.......
        0300: 9a 4d be 53 4e 4b ab 8f  9e d2 65 2b 8c
0f 61 4e  .M.SNK....e+..aN
        0310: 9d 61 8d 63 55 90 2c a3  ef 56 70 4e 5b
91 6b 13  .a.cU.,..VpN[.k.
        0320: 4a 90 c6 51 95 81 07 d2  a6 81 61 79 80
76 05 6b  J..Q......ay.v.k
        0330: 5d b6 02 56 8e d6 36 cb  30 e7 81 4f 85
2d f2 ea  ]..V..6.0..O.-..
        0340: c5 49 23 8a 69 dc bb dd  15 1a 5b 68 a3
65 de 03  .I#.i.....[h.e..
        0350: 83 4f 4f 24 c2 42 90 ee  c3 af a5 43 88
9c ae 36  .OO$.B.....C...6
        0360: 63 17 96 a8 46 5c 77 a6  49 b6 68 d5 5c
01 8e 86  c...F\w.I.h.\...
        0370: 8a 62 65 61 14 68 fb 22  56 27 ae 6a 71
04 93 b2  .bea.h."V'.jq...
        0380: c8 c7 cb 65 e9 9a bb 12  9d dd 8b 31 5b
13 21 79  ...e.......1[.!y
        0390: 1f e6 f5 a9 62 b1 c3 ef  67 ca d3 1b 56
18 1e 15  ....b...g...V...
        03a0: b8 f2 ce 38 e9 44 d0 2b  39 1b 80 5e b5
9b 93 4c  ...8.D.+9..^...L
        03b0: 44 46 de 07 88 82 fc fa  d0 91 a6 d3 1a
b7 4e 95  DF............N.
        03c0: 4d ab 00 7d 8a 22 30 f2  02 4d 3f ec 36
69 0a ef  M..}."0..M?.6i..
        03d0: 93 91 d8 54 c2 2b 71 95  0c 51 79 b8 ce
40 e9 52  ...T.+q..Qy..@.R
        03e0: 93 14 8b b4 80 18 74 14  4d ab 8d 32 67
b8 58 95  ......t.M..2g.X.
        03f0: 4b 26                                   
         K&
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 1e a4 da 93 c6 1f 01 88  ed 5a 58 2d 71
04 02 46  .........ZX-q..F
        0010: f9 54 2a d4 fe 5b c5 1e  51 55 88 a0 44
26 e3 c9  .T*..[..QU..D&..
        0020: 42 b2 20 64 6e a0 76 a2  0b 88 25 85 91
63 e7 b0  B. dn.v...%..c..
        0030: a4 e3 71 11 1b 88 3e 58  de 23 c7 a5 3e
39 e0 2a  ..q...>X.#..>9.*
        0040: 77 2e 07 6f 5a 98 c2 c0  dd 90 49 73 6b
21 11 46  w..oZ.....Isk!.F
        0050: a4 10 3e f5 52 2e 56 52  84 8e 6a ed 61
27 71 6e  ..>.R.VR..j.a'qn
        0060: 06 c6 8d a2 cb 7a d1 39  62 06 d2 03 2f
6a 96 b5  .....z.9b.../j..
        0070: 29 0d 2c cb 16 ec 61 bd  6a 44 79 49 49
0e 36 8a  ).,...a.jDyII.6.
        0080: 6e fd 01 12 35 d3 bc ca  15 47 e5 57 5d
a3 f9 77  n...5....G.W]..w
        0090: 0f c4 54 f2 5f 71 a6 88  a5 75 1b 96 3c
8c d3 36  ..T._q...u..<..6
        00a0: 8c 0e 76 a8 ed eb 55 6b  68 49 59 95 bc
dd db 49  ..v...UkhIY....I
        00b0: 1e 94 c7 90 09 42 85 c7  b6 29 8c 72 ba
42 e5 dd  .....B...).r.B..
        00c0: 89 3d 94 54 df 6a 1e 53  ee 18 63 d2 80
18 b3 2a  .=.T.j.S..c....*
        00d0: c7 f2 64 bd 44 67 0a c1  ca 91 eb 9a 4d
5c 48 7a  ..d.Dg......M\Hz
        00e0: 5e 08 f3 81 f2 b5 4e b3  86 8c ac 40 10
7a d6 6e  ^.....N....@.z.n
        00f0: 4d 68 02 86 76 41 1a 81  81 da 9d 14 ea
a7 08 bf  Mh..vA..........
        0100: 3f 7a 12 d2 e0 88 5b ce  92 75 2a 4f 1d
45 5d 8e  ?z....[..u*O.E].
        0110: e1 a2 4c b1 e9 da b4 5a  83 44 72 5f 4a
ac 24 66  ..L....Z.Dr_J.$f
        0120: c2 f6 02 a6 5d 4a 50 a4  b6 36 f6 a6 05
7b cb a1  ....]JP..6...{..
        0130: 70 8a a0 fd 45 43 98 f8  56 53 bc d2 bd
86 b4 23  p...EC..VS.....#
        0140: 68 90 29 07 01 bd 6a 6d  b0 6c 5f dd e5
fa 70 29  h.)...jm.l_...p)
        0150: 6a 04 9f 67 64 da d1 7c  9e d4 db 80 1c
a8 2c 7c  j..gd..|......,|
        0160: ce f9 a5 7b e8 26 3a 09  3c a3 88 d3 69
f5 a6 fd  ...{.&:.<...i...
        0170: a2 76 90 f9 64 92 3b d3  49 a1 92 2c f7
65 c3 44  .v..d.;.I..,.e.D
        0180: df 77 ad 3e ea ee e9 b6  94 3f 51 8a 69
88 92 02  .w.>.....?Q.i...
        0190: 7c b3 21 72 7d 45 52 9f  37 05 80 52 16
98 0c 8e  |.!r}ER.7..R....
        01a0: dd 63 8d 46 d3 9c f4 ab  02 0f 26 45 63
1e 54 fb  .c.F......&Ec.T.
        01b0: 54 b9 a4 ec 03 d5 98 3b  61 41 5f 4a 70
70 a7 7a  T......;aA_Jpp.z
        01c0: 27 5f 6a 52 77 01 a4 28  1e 63 20 e6 9c
f2 27 cb  '_jRw..(.c ...'.
        01d0: ba 3c 9e dc 55 47 60 09  1a 17 52 0c 5f
35 57 f2  .<..UG`...R._5W.
        01e0: 31 11 c3 6d 27 a0 a6 05  3b 98 1d 4a 8e
0b 1e f5  1..m'...;..J....
        01f0: 2b c2 fe 58 57 fb b8 e2  98 d9 4e 55 76
c0 43 c8  +..XW.....NUv.C.
        0200: ec 2a 54 12 97 4e 0e 6a  5a 11 76 2b c4
b7 90 ef  .*T..N.jZ.v+....
        0210: 4d e4 0a 9e 1b bb 59 7f  7d 22 60 8a 23
1b 0c a9  M.....Y.}"`.#...
        0220: a8 dc c6 cd 98 d3 83 d1  aa 89 33 2b 2e
cc 96 34  ..........3+...4
        0230: c4 68 da dc 4b 0a 92 0e  33 d7 35 21 b8
77 72 c7  .h..K...3.5!.wr.
        0240: 07 1d 2a 5b b2 16 e3 e0  be c4 4c 65 8c
6e ec 2a  ..*[......Le.n.*
        0250: 78 ae 11 90 33 27 07 ad  11 68 63 a4 ba
b7 44 63  x...3'...hc...Dc
        0260: 12 64 fb d5 3b 6b b0 03  33 27 07 a0 a1
c1 30 2c  .d..;k..3'....0,
        0270: 4f 34 36 e8 24 11 9c b7  6a 74 77 56 d8
5d e8 79  O46.$...jtwV.].y
        0280: ed 4b 91 0c a7 7f 7d 0c  92 85 82 3d ac
bd 0e 29  .K....}....=...)
        0290: b0 34 d3 02 49 fc c5 54  55 84 49 e5 28
40 a3 97  .4..I..TU.I.(@..
        02a0: 3d 7d aa 44 48 b6 15 92  33 81 fc 42 99
4e 36 57  =}.DH...3..B.N6W
        02b0: 15 da 01 b4 28 ca 8a b3  6f 7b 00 60 4a
e2 a6 f6  ....(...o{.`J...
        02c0: dc 86 ec 4d 05 f4 2c f2  00 32 45 56 3a
84 46 37  ...M..,..2EV:.F7
        02d0: 75 4c 30 a7 61 88 9a 8c  26 1d ee 00 34
d1 a9 88  uL0.a...&...4...
        02e0: 97 21 3e 56 a4 a1 67 70  1d 1e a3 03 65
7c ac af  .!>V..gp....e|..
        02f0: bd 45 1e a0 86 42 9e 56  13 d6 aa c0 32
07 b5 2f  .E...B.V....2../
        0300: 26 57 00 f7 a2 47 84 10  a1 37 a0 a4 e3
74 34 11  &W...G...7...t4.
        0310: cb 1c 39 31 c6 14 1e f8  a6 9b a6 dc 18
e0 f1 52  ..91...........R
        0320: ac b4 02 a5 dd e4 ed b4  03 81 9e 95 0c
97 37 2b  ..............7+
        0330: b7 ca 38 23 af 15 6b c8  45 99 2e ee df
6f cf 9f  ..8#..k.E....o..
        0340: 5a 9a 2d 52 50 04 72 1d  c0 50 80 75 c5
ec db 91  Z.-RP.r..P.u....
        0350: a3 39 1e 83 b5 45 2d ec  c1 83 34 87 69
a6 16 1d  .9...E-...4.i...
        0360: 3d c4 d2 bc 6a c4 95 3d  c5 31 a4 60 ac
91 f2 ff  =...j..=.1.`....
        0370: 00 4a ca 4f 53 37 16 c9  22 09 19 5d ca
0b 91 cd  .J.OS7.."..]....
        0380: 39 d9 17 fd 64 61 cf 61  43 8f 31 a1 25
ac 91 c6  9...da.aC.1.%...
        0390: 8c c6 1c 48 3a 52 8b 88  19 3c c2 b8 71
d8 55 72  ...H:R...<..q.Ur
        03a0: 2b 58 09 4d d0 b8 b7 ca  02 b8 ed 55 59
8b a7 ef  +X.M.......UY...
        03b0: 00 d9 e9 52 a9 a4 00 97  10 46 55 52 3e
07 6a 59  ...R.....FUR>.jY
        03c0: 66 05 d4 04 da 0d 5a 56  02 76 9e 28 c2
a2 a0 27  f.....ZV.v.(...'
        03d0: e9 48 b7 23 6b 05 8c 0c  f5 18 a3 46 04
42 41 0c  .H.#k......F.BA.
        03e0: 7b b6 a9 07 d4 74 a3 ed  df 26 40 c8 1d
85 2e 54  {....t...&@....T
        03f0: 32 17                                   
         2.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 90 30 0c 8a c0 7b 54 ed  22 cd 1a ab 64
62 9e db  .0...{T."...db..
        0010: 8a f6 1e b1 c7 1e 1e 36  fd ef e9 4d c8
39 f3 1c  .......6...M.9..
        0020: 87 a6 17 23 7b 86 18 c1  e9 d2 92 2b b9
18 1c b0  ...#{......+....
        0030: 1e d8 a9 e6 01 45 ec d1  b7 94 c0 10 47
5a 67 9d  .....E......GZg.
        0040: 36 46 ec 04 1d 05 3d d0  22 2b b9 8c e7
61 e0 f6  6F....=."+...a..
        0050: c5 57 82 29 c0 3f 36 40  ea 28 bd 80 12
d9 84 6d  .W.).?6@.(.....m
        0060: 2c 60 85 3d a8 8c 5c 23  2b fd dc 76 ac
9b 6a 44  ,`.=..\#+..v..jD
        0070: 47 72 7b d8 e5 25 65 2d  90 7a fb 54 f1
cc c1 02  Gr{..%e-.z.T....
        0080: 81 90 47 e5 5a de e5 d8  6d b8 75 97 93
95 f5 ab  ..G.Z...m.u.....
        0090: 51 ec 1b e5 0b 97 14 c2  c4 0c 41 21 99
70 4d 47  Q.........A!.pMG
        00a0: 35 a2 4c 01 07 0e 3d 28  02 bf 96 ca de
5b 6e 6c  5.L...=(.....[nl
        00b0: f7 15 15 c4 52 c5 f7 c1  d8 3b 52 7a 00
b6 f2 3a  ....R....;Rz...:
        00c0: e3 62 6c 46 f6 a9 e5 df  11 42 b9 d8 7b
53 01 91  .blF.....B..{S..
        00d0: fd a1 e7 23 07 67 6a 82  79 e5 82 5c 34
79 3e 98  ...#.gj.y..\4y>.
        00e0: a4 ec 02 b4 b2 1d a5 32  0b 76 f4 a9 94
48 15 84  .......2.v...H..
        00f0: ce 09 ed 4d 05 86 cc 0c  b2 07 47 38 f4
a6 f9 6f  ...M......G8...o
        0100: 0a b4 9c 96 1d 85 65 05  66 02 19 0d c2
07 c3 67  ......e.f......g
        0110: bd 32 de 3d 85 96 42 cc  7b 55 a9 26 3d
89 58 b8  .2.=..B.{U.&=.X.
        0120: 8f 95 28 1b 81 4d d9 20  22 2d cc 72 3e
f5 36 c0  ..(..M. "-.r>.6.
        0130: 58 26 78 1c c5 b4 8f f6  bd 69 b1 5a 99
26 76 8f  X&x......i.Z.&v.
        0140: 20 8e 4e 69 6d a0 5c 93  6c ee ea 49 20
2f ad 36   .Nim.\.l..I /.6
        0150: fa 05 6f bd 16 41 fe 21  54 80 61 22 18
82 95 25  ..o..A.!T.a"...%
        0160: 7b 52 db c7 bb e6 c9 00  74 a0 a5 b5 84
96 de 49  {R......t......I
        0170: 18 b0 63 83 c0 1e 95 2a  db b2 28 0f 92
c3 d2 a5  ..c....*..(.....
        0180: 3b 6e 4c bc 86 5c 59 99  5a 39 36 6c 3d
3e b5 6e  ;nL..\Y.Z96l=>.n
        0190: 3b 4c 64 83 82 3b 0a 95  76 c1 3d 07 ad
a3 34 65  ;Ld..;..v.=...4e
        01a0: f3 81 e8 6a 29 21 6d 80  a7 dc 1d 45 17
5d 07 71  ...j)!m....E.].q
        01b0: f0 a7 39 4f 94 7b d3 98  3b c8 01 39 14
e3 34 c9  ..9O.{..;..9..4.
        01c0: 1d 35 bc a8 70 af b8 91  f9 52 44 2e 40
0a 4e 07  .5..p....RD.@.N.
        01d0: ad 29 4e cf 41 8a b6 b8  98 b4 f8 27 a8
34 86 29  .)N.A......'.4.)
        01e0: 0b 17 8f e6 5e f5 51 7c  c8 56 19 05 a3
a8 72 e4  ....^.Q|.V....r.
        01f0: 80 7a 0a ae 03 20 75 c9  02 93 d3 40 27
b4 8f 7c  .z... u....@'..|
        0200: 44 1e 00 e7 24 d4 b1 c0  ae 98 56 0d e9
4b 5e 80  D...$.....V..K^.
        0210: 23 5a 6d c1 03 73 d4 6b  a7 b2 ca 49 39
6e bf 4a  #Zm..s.k...I9n.J
        0220: 5c b7 63 42 cf 85 21 73  e6 13 fa 54 31
02 18 a4  \.cB..!s...T1...
        0230: 4d f3 77 15 a8 cb 08 49  25 43 e3 6d 3c
06 70 5e  M.w....I%C.m<.p^
        0240: 39 38 1d 45 45 dd ec 2b  11 49 10 65 0d
1b 64 77  98.EE..+.I.e..dw
        0250: 14 f8 a1 58 a4 dd b8 0c  d3 6e c0 87 98
17 cc 0c  ...X.....n......
        0260: 70 40 1d 6a 27 85 27 52  c0 ed 3d 80 a6
d0 9e a4  p@.j'.'R..=.....
        0270: 6b 03 26 4e 01 0b d6 9e  2d 44 c8 24 db
b5 45 12  k.&N....-D.$..E.
        0280: 5a 01 62 0b 31 39 0d bc  28 1d 07 ad 3e
e3 4d 19  Z.b.19..(...>.M.
        0290: dc 1b 07 d2 a5 5e c3 4c  81 2d 1b 3f bd
65 db da  .....^.L.-.?.e..
        02a0: a6 93 4e 32 2f ee 98 60  7e 54 36 c0 92
3b 45 c2  ..N2/..`~T6..;E.
        02b0: e3 6f 4c 66 ac fd 8c 28  03 23 35 4b 61
0c 36 0b  .oLf...(.#5Ka.6.
        02c0: 2e 03 48 14 0e f4 92 d8  2e 02 89 43 28
a9 4e ec  ..H........C(.N.
        02d0: 07 c7 6b 10 3c 10 29 97  2b 68 91 8c 85
de 3b d2  ..k.<.).+h....;.
        02e0: 7c cd e8 17 b9 41 a5 b5  8d 4e e8 b2 e7
a6 69 2d  |....A...N....i-
        02f0: da 09 03 19 13 04 ff 00  0d 5d ac 33 46
d7 ec a1  .........].3F...
        0300: 42 ec 50 3d e9 2f 52 d6  e2 51 1a 05 5c
75 c5 16  B.P=./R..Q..\u..
        0310: 02 93 d8 5a ab 6d 0f 93  e9 55 d0 01 33
22 0f 95  ...Z.m...U..3"..
        0320: 7a 1a 56 4d 88 8f 33 b3  12 9c 13 56 ac
50 29 f9  z.VM..3....V.P).
        0330: 86 7d 4d 3b 26 05 e5 9e  00 3f 75 18 de
3a d5 47  .}M;&....?u..:.G
        0340: 9d 26 97 ee 80 07 5a 2d  61 dc 9d 1a d9
c7 97 e5  .&....Z-a.......
        0350: 83 48 52 de 58 d8 14 c6  de 98 a7 60 4c
8e 24 8d  .HR.X......`L.$.
        0360: 81 74 4c 11 d4 53 25 05  e0 c2 28 46 f5
a9 94 6e  .tL..S%...(F...n
        0370: 3e 6d 2c 20 8f 60 53 3e  0d 5a 8a e2 0b
65 0e 63  >m, .`S>.Z...e.c
        0380: 0c a7 a5 4c 6f d4 92 49  ae 62 00 39 1f
29 aa 93  ...Lo..I.b.9.)..
        0390: 04 b9 60 61 e0 fa d5 e8  03 21 8e 55 f9
5f bf 7a  ..`a.....!.U._.z
        03a0: b3 b5 62 7d 91 00 38 f9  8d 31 a2 33 70
b0 b6 57  ..b}..8..1.3p..W
        03b0: 85 3d 69 56 e4 b4 b9 da  02 e3 f3 a1 20
64 49 70  .=iV........ dIp
        03c0: 0c c3 03 08 4e 36 d5 e7  96 28 e3 0b 12
a9 34 5a  ....N6...(....4Z
        03d0: e2 5a 0c 6b a4 20 14 41  91 d7 34 ff 00
b4 e0 06  .Z.k. .A..4.....
        03e0: 2a 0f b5 43 a7 1b dc 64  72 4c aa 43 a2
f2 dd 47  *..C...drL.C...G
        03f0: a5 46                                   
         .F
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 6e 11 8f ca a0 a8 f4 a7  ca 8a dc 77 9f
13 aa 86  n..........w....
        0010: 00 91 fc 34 e7 b9 87 68  21 46 e1 da 9e
c8 80 82  ...4...h!F......
        0020: ee de 67 25 57 0d de a1  9b 6b b1 d8 db
0d 2d d6  ..g%W....k....-.
        0030: 80 55 28 ed 85 f4 3f 7a  ac 33 99 14 44
c3 04 7f  .U(...?z.3..D...
        0040: 15 34 02 a4 10 f4 dc 03  0e a6 ac 7d 9a
32 c0 c6  .4.........}.2..
        0050: e0 8f 6a 06 44 f6 88 43  12 46 7d 6a 07
8a 28 a1  ..j.D..C.F}j..(.
        0060: f9 39 cd 31 11 46 23 95  82 49 80 3d 2a
dc d0 47  .9.1.F#..I.=*..G
        0070: 0c 7b d0 83 b6 81 8c 53  0c f0 07 38 0f
fd da 91  .{.....S...8....
        0080: ad 58 2a 32 e0 27 71 49  ab ab 00 f8 e1
b6 92 4f  .X*2.'qI.......O
        0090: 91 c7 d2 a4 2b 14 0e 23  dc 09 6a c1 d3
9f 40 1b  ....+..#..j...@.
        00a0: 2a 5b aa b0 6e 95 1c 5f  65 58 72 00 df
e9 5b 45  *[..n.._eXr...[E
        00b0: 34 b5 10 5e 4b 1b c4 9f  26 5b d0 53 21
ba 84 46  4..^K...&[.S!..F
        00c0: 43 c5 f3 fd 29 d9 05 ec  54 92 68 c3 92
b1 82 7b  C...)...T.h....{
        00d0: 8a b3 16 a0 55 0e cb 70  46 3d 28 48 7b
88 97 b1  ....U..pF=(H{...
        00e0: aa 16 f2 f2 e6 a7 8e f7  cd 84 c6 21 0a
3d 69 94  ...........!.=i.
        00f0: a5 a5 8a ad 76 91 b8 53  0f 06 90 5e 46
b2 80 d0  ....v..S...^F...
        0100: e1 29 59 32 1b 2f 47 1c  53 23 32 81 18
35 52 5d  .)Y2./G.S#2..5R]
        0110: 3a 4c 91 1c a3 69 e6 9d  ac 03 63 d2 63
0c 0c f2  :L...i....c.c...
        0120: e0 76 1e f5 65 6c 4e e5  1b 86 c5 a9 52
b8 ec 49  .v..elN.....R..I
        0130: 2e 9e 84 16 0e 15 7d 29  a2 c1 14 64 c8
08 35 2b  ......})...d..5+
        0140: 98 a6 95 86 36 9a 85 88  f3 40 14 f8 6c
e3 58 d8  ....6....@..l.X.
        0150: 23 ee 3d ea ae c8 2c 45  67 13 40 77 10
d8 e8 2b  #.=...,Eg.@w...+
        0160: 3d ed e2 f3 38 6c 54 38  b7 aa 19 11 78
52 41 19  =...8lT8....xRA.
        0170: 4d c7 d6 83 82 77 ec ca  74 ab 8a b0 89
fc a8 44  M....w..t......D
        0180: 7b 87 03 d2 a3 55 83 70  55 43 cf 53 8a
69 01 60  {....U.pUC.S.i.`
        0190: 18 b7 ec 44 18 c5 2b 41  14 a0 2b 05 50
3b d3 b0  ...D..+A..+.P;..
        01a0: 5c 00 8e 38 cb 71 85 a6  41 77 13 b6 5a
dc 63 d6  \..8.q..Aw..Z.c.
        01b0: a5 40 04 32 c6 a1 c2 a0  e6 92 da 68 b8
f3 63 c0  .@.2.......h..c.
        01c0: ec 4d 55 82 f6 24 96 ea  07 97 ca 0b b7
df d6 95  .MU..$..........
        01d0: 56 d6 16 20 80 d9 ed 52  d3 0b 8e 69 ed
c4 5f bb  V.. ...R...i.._.
        01e0: 50 01 e2 85 8a 19 23 03  70 19 a1 46 c3
5a 09 2c  P.....#.p..F.Z.,
        01f0: 76 e8 42 81 96 5f e2 a8  e7 11 b3 29 ce
48 a1 ca  v.B.._.....).H..
        0200: da 0d eb a8 8b 2c 40 ed  28 37 f6 35 2c
49 16 f1  .....,@.(7.5,I..
        0210: 23 90 73 d6 a7 95 f4 24  5b ab 78 c8 0d
26 36 7b  #.s....$[.x..&6{
        0220: 54 36 d0 db 14 66 dd f2  af 6a 71 56 dc
64 0d 31  T6...f...jqV.d.1
        0230: 93 7a c0 98 8c 77 35 17  ef 26 4f 94 60
2f 5a 7c  .z...w5..&O.`/Z|
        0240: b7 02 c1 75 f2 42 a9 20  8e f4 fb 34 49
a3 63 3b  ...u.B. ...4I.c;
        0250: 6c 23 d7 bd 4c 93 e8 16  1a 3c a2 40 e0
11 d0 fa  l#..L....<.@....
        0260: d2 fd 9e 2f 30 cb 9e 07  55 a8 e4 60 24
2f 6c 03  .../0...U..`$/l.
        0270: 39 e7 3d 05 42 ae 93 31  18 23 1e b5 b4
55 91 36  9.=.B..1.#...U.6
        0280: 2a c1 12 cb 3b 88 db 05  6b 46 d5 52 04
72 c7 76  *...;...kF.R.r.v
        0290: 69 8c b4 bf 67 6b 6d aa  7e b4 df 21 1a
20 22 70  i...gkm.~..!. "p
        02a0: d8 eb 51 7e 6d 00 4f 26  1c e0 b6 57 1c
8a 92 18  ..Q~m.O&...W....
        02b0: 6d 4c 7b 95 b8 1d aa bd  06 2c d3 5a c6
06 40 3e  mL{......,.Z..@>
        02c0: c2 9b 1d c5 a2 80 76 e0  b7 6a 62 1e d2
5a 23 aa  ......v..jb..Z#.
        02d0: b0 0d 9f 4e d5 34 66 d0  60 8c 28 34 98
0c 3e 40  ...N.4f.`.(4..>@
        02e0: 98 95 01 42 f4 f7 aa d2  5e 46 66 2b 24
41 a9 34  ...B....^Ff+$A.4
        02f0: a4 32 84 f7 49 2a b2 c5  1e d0 3d aa 33
74 ae a2  .2..I*....=.3t..
        0300: 16 5e bd e8 56 8e 82 34  60 ba 86 28 02
14 c3 0f  .^..V..4`..(....
        0310: e2 aa f7 53 86 2a 4c 4a  73 dc 52 94 2f
b0 0d 48  ...S.*LJs.R./..H
        0320: d4 0f ba 32 de bd aa 99  b6 c4 be 5b 12
ce 7b d3  ...2.......[..{.
        0330: 8a 6b 71 8b a5 85 dd 23  13 c2 8e 05 36
de f3 33  .kq....#....6..3
        0340: c8 ac b9 fe 94 9a d0 bb  2e 52 58 ae 3c
9d ec 54  .........RX.<..T
        0350: 6d fe 75 1f db 4a cc 25  31 0d b4 46 09
10 dd cb  m.u..J.%1..F....
        0360: 33 5e 79 c1 3e 41 8e d4  c3 3b 49 84 44
50 07 eb  3^y.>A...;I.DP..
        0370: 54 90 30 9a e4 a3 2a c9  10 f6 35 2c 37
06 29 07  T.0...*...5,7.).
        0380: 98 80 03 43 57 0b 0d 9e  e4 30 66 0b 91
ed 55 e3  ...CW....0f...U.
        0390: b9 69 81 2a 4a 85 ec 69  f9 0e d6 d4 71
b8 56 52  .i.*J..i....q.VR
        03a0: 18 2f 14 89 31 10 10 80  6d a4 dd 85 b9
20 9b 16  ./..1...m.... ..
        03b0: a0 ed ce 29 a4 c9 e6 24  8a 72 3f bb 49
ab 92 d1  ...)...$.r?.I...
        03c0: 30 96 79 b7 6e 4f 94 74  15 10 9c a4 6c
1f e5 73  0.y.nO.t....l..s
        03d0: c6 68 8a 5d 00 9e e2 e5  8d aa 46 a3 9e
e4 75 aa  .h.]......F...u.
        03e0: cd b9 00 25 8e de f5 93  97 2b b1 4b 51
c9 72 2e  ...%.....+.KQ.r.
        03f0: 23 66                                   
         #f
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 88 0f 97 b0 a0 48 10 06  69 07 d2 b4 e5
4d 68 21  .....H..i....Mh!
        0010: 6d ef 88 25 8f dd f5 a7  cb 7f f2 6d 00
0c f4 14  m..%.......m....
        0020: f9 10 31 8d 29 6c 79 ac  51 69 91 de 7d
96 4d c0  ..1.)ly.Qi..}.M.
        0030: 9f 2c fe b4 f4 45 46 3a  16 22 b9 9a 79
4c 98 02  .,...EF:."..yL..
        0040: 21 d0 54 17 29 24 d3 06  0b 85 14 f4 11
22 c1 2a  !.T.)$.......".*
        0050: a3 3b a9 08 69 f6 b1 1d  c0 a0 20 0e f4
05 ac 4c  .;..i..... ....L
        0060: 26 70 c7 68 c0 a8 e5 f3  42 31 8c e0 9a
5b 01 4a  &p.h....B1...[.J
        0070: 29 3e f4 78 f9 bd 45 49  12 34 51 b3 a2
96 27 bd  )>.x..EI.4Q...'.
        0080: 4b 9a 1c 55 c6 a5 bb 30  df 26 e5 6f 41
56 02 95  K..U...0.&.oAV..
        0090: 55 31 f1 ea 29 29 5c 25  12 11 1c 8f 21
0a ac 07  U1..))\%....!...
        00a0: b7 4a b3 0c 0f 8f 9b 9a  a5 a8 ad 62 35
86 e1 65  .J.........b5..e
        00b0: 72 01 db e9 44 10 34 3f  bc 73 c1 fd 2a
84 2c a0  r...D.4?.s..*.,.
        00c0: a2 33 c6 f9 07 b5 44 65  91 42 82 7e 53
da 93 43  .3....De.B.~S..C
        00d0: b6 84 90 b2 32 b6 d9 70  eb da a6 6b b3
26 d0 48  ....2..p...k.&.H
        00e0: 2c 38 a9 82 7d 49 51 b1  11 94 c4 fc 8d
ca 7b 7a  ,8..}IQ.......{z
        00f0: 51 f6 a6 41 e5 ab 70 dd  aa c6 39 24 6e
11 72 71  Q..A..p...9$n.rq
        0100: e9 4e 32 dc 48 df bc ca  85 fb b5 32 97
28 21 e6  .N2.H......2.(!.
        0110: 29 64 8c 0f 9b 26 9e d2  3c 41 62 58 59
87 73 4d  )d...&..<AbXY.sM
        0120: 3b ab 80 d9 04 b1 2e e7  c8 5e c0 d5 4b
9d b3 11  ;........^..K...
        0130: 83 cd 25 2b ec 24 ac 2b  79 4e 8a 19 81
64 f4 aa  ..%+.$.+yN...d..
        0140: e9 76 24 76 ca e0 af 71  55 61 8f 7b 92
c9 c0 c1  .v$v...qUa.{....
        0150: ed 53 d9 c6 66 cb b3 05  3e 94 05 86 61
92 72 db  .S..f...>...a.r.
        0160: 1a ad 1f 37 cb 2c 90 e3  f0 a0 0a 6a d7
22 60 c6  ...7.,.....j."`.
        0170: 12 07 d2 af 41 6b 33 2b  48 14 ae 7a d4
ca 49 0d  ....Ak3+H..z..I.
        0180: 10 cb 6b 2c 11 f9 91 ee  62 dd a8 8e de
50 a0 b2  ..k,....b....P..
        0190: 63 34 46 4a 4b 40 68 6c  99 b7 73 b4 e4
91 d3 d2  c4FJK@hl..s.....
        01a0: a2 b3 9b 12 e1 9c 02 7b  1a a2 55 8d 11
b5 18 90  .......{..U.....
        01b0: c3 61 1c e2 a1 58 15 b2  3c c0 41 3c 7b
50 32 c3  .a...X..<.A<{P2.
        01c0: e9 ca 54 06 98 72 3a d4  71 d9 19 01 5f
30 60 70  ..T..r:.q..._0`p
        01d0: 0d 26 80 96 5d 3f 7a aa  19 05 52 8f 4f
9e d2 46  .&..]?z...R.O..F
        01e0: 75 90 15 f4 a4 d5 c0 75  c1 78 d3 7e 77
36 78 02  u......u.x.~w6x.
        01f0: ab f9 cd 2b 07 74 2a c3  a8 aa 02 69 2d
da 58 95  ...+.t*....i-.X.
        0200: 4e 02 f5 cd 47 35 9d c9  c0 42 36 8e 98
a3 60 23  N...G5...B6...`#
        0210: 8e da e1 32 c5 4e 7b 54  8b 1c fb f2 50
86 3d 6b  ...2.N{T....P.=k
        0220: 3f 6b 10 25 4b 49 d8 f0  54 1a 7d a5 ac
cd 26 d7  ?k.%KI..T.}...&.
        0230: 60 a4 56 89 82 64 d2 da  b3 ca 55 08 e3
b5 33 ec  `.V..d....U...3.
        0240: 93 46 ed b4 00 08 e9 53  ca 31 22 8e 34
27 77 32  .F.....S.1".4'w2
        0250: 2f 5c 52 d9 24 73 4c ca  eb 84 f5 34 3d
81 21 ef  /\R.$sL....4=.!.
        0260: 6b 0a e4 40 e3 6f 7a 96  08 a2 d8 03 e1
80 ef 53  k..@.oz........S
        0270: 4d 34 b5 07 e4 23 c2 b3  ab 18 1c 05 f4
a8 2e 6d  M4...#.........m
        0280: 25 48 c1 03 75 52 d0 45  54 b6 9d f8 2b
80 6a c5  %H..uR.ET...+.j.
        0290: ad ab c7 29 40 70 4d 1c  c8 09 c5 8d cf
9c 52 53  ...)@pM.......RS
        02a0: fb b6 e8 45 3e 7d 38 2c  2a a1 be 60 69
39 a5 a0  ...E>}8,*..`i9..
        02b0: c8 86 97 b4 ac 99 f9 8d  47 79 64 55 c0
df f2 9a  ........GydU....
        02c0: b4 22 94 c5 6d c7 18 2c  3a 01 4e 86 fa
59 3f 76  ."..m..,:.N..Y?v
        02d0: ca d8 35 2d ea 34 ae 3e  d5 04 8e ca aa
55 bd 6a  ..5-.4.>.....U.j
        02e0: c9 b7 91 9c 16 18 61 de  9c 9d 90 12 8b
52 c8 77  ......a......R.w
        02f0: 30 cd 46 b6 64 02 4e 33  ea 2a 14 ad b8
88 65 69  0.F.d.N3.*....ei
        0300: 61 65 09 16 e2 78 cd 4d  1d b3 f2 ee 07
cd da af  ae...x.M........
        0310: 46 03 9a cc 44 0b aa 86  3e 95 1b 47 35
b9 67 64  F...D...>..G5.gd
        0320: f9 5b a0 a7 60 23 b6 85  e6 99 55 63 c2
9e b5 35  .[..`#....Uc...5
        0330: d4 6d 13 15 c6 10 76 a4  f6 02 aa cb c1
ca fc 83  .m....v.........
        0340: bd 2b f9 6f 0e f5 23 3e  95 29 0e c5 7f
35 82 12  .+.o..#>.)...5..
        0350: 5c e2 a6 b7 9f 76 37 37  1e d5 62 19 71
32 f9 80  \....v77..b.q2..
        0360: 17 ca ff 00 2a 7b de 05  2a aa c7 18 eb
52 b4 02  ....*{..*....R..
        0370: 39 e6 90 c7 91 92 69 5a  e1 fc b8 c1 52
09 aa 0b  9.....iZ....R...
        0380: 13 6e 95 8e 02 12 7d 69  f1 17 da cb 1a
90 c3 ef  .n....}i........
        0390: 52 6d 09 2b 15 5e ed a1  7d bc ab 7a 54
de 70 92  Rm.+.^..}..zT.p.
        03a0: 3c 90 37 1a 94 db 06 ec  3a 48 84 4f 13
2a ee 07  <.7.....:H.O.*..
        03b0: ad 24 be 62 72 9c 03 d8  d5 82 2d da c0
24 88 e4  .$.br.....-..$..
        03c0: e0 fa 53 e4 b3 29 b4 07  00 9a 4c a1 cf
66 14 29  ..S..)....L..f.)
        03d0: 0f f3 b7 5a 64 d6 38 60  de 68 da bd a8
8d c4 92  ...Zd.8`.h......
        03e0: 2a 5d 6d 4e 4f dd ee 2a  b4 b3 ec 19 80
65 68 e6  *]mNO..*.....eh.
        03f0: b6 80                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: d2 62 5b 09 65 52 ee 3e  98 ed 4e 47 7d
9b 64 5c  .b[.eR.>..NG}.d\
        0010: 85 3c 62 98 8a b2 ac ef  39 38 c2 f6 ab
0a 93 07  .<b.....98......
        0020: 55 0a 06 7d 68 4e e0 5b  6b 46 16 fb 1b
01 8d 40  U..}hN.[kF.....@
        0030: f1 cd 1b 22 32 65 7d 45  26 ec 08 98 c4
c1 94 ca  ..."2e}E&.......
        0040: d8 4f 4a 9a 28 56 46 22  39 07 1e b4 68
ca 8f 98  .OJ.(VF"9...h...
        0050: e9 ad e2 ca b3 48 a0 d4  4f 15 ba 01 b2
6c 83 d6  .....H..O....l..
        0060: 94 9b 5b 03 62 ca 63 2a  15 65 cf b5 32
da 38 63  ..[.b.c*.e..2.8c
        0070: 8d c1 90 73 da 9c 5d c4  47 6c 8d e6 b0
57 52 9e  ...s..].Gl...WR.
        0080: 95 6d 6c db 61 31 b0 e7  b5 37 a0 c4 36
6c 24 c0  .ml.a1...7..6l$.
        0090: 23 a7 4a 58 ed de 47 55  99 30 a2 b2 75
2c c1 bb  #.JX..GU.0..u,..
        00a0: 93 ff 00 66 ab b9 2a 7e  51 50 c9 66 e8
cc cc 42  ...f..*~QP.f...B
        00b0: a1 e3 34 d3 72 11 55 ed  d5 27 40 08 e9
46 3c c4  ..4.r.U..'@..F<.
        00c0: 78 ce d0 de a2 b4 43 43  1d a1 b7 80 6d
00 b9 eb  x.....CC....m...
        00d0: 8a 84 33 3a 9f 2c e0 fa  52 bd 84 44 93
ac 64 23  ..3:.,..R..D..d#
        00e0: b0 04 f5 c5 5c f3 63 55  02 2c 8c f7 15
32 d3 54  ....\.cU.,...2.T
        00f0: 03 4b 33 4a a1 10 e7 bf  bd 4b 2c c2 33
98 90 f4  .K3J.....K,.3...
        0100: e4 53 8c ae 3b 0d 40 d3  28 29 11 f7 35
25 be 9e  .S..;.@.()..5%..
        0110: cc 4b 39 f9 45 37 7e 82  25 16 67 19 09
f2 7a d2  .K9.E7~.%.g...z.
        0120: 2d a4 cd 2a 87 18 85 68  02 1b b9 11 65
31 bb e0  -..*...h....e1..
        0130: 0e 95 4a 39 d1 a5 67 46  ce 38 c5 4c 6e
b7 02 bd  ..J9..gF.8.Ln...
        0140: c4 cf 2c 80 40 98 23 af  bd 34 34 ee a1
c4 27 03  ..,.@.#..44...'.
        0150: ad 5d 90 9b 64 de 7b bb  28 28 4a fa 55
e4 4d d1  .]..d.{.((J.U.M.
        0160: 8e 36 83 d3 3d a8 1a f3  26 fb 04 f3 80
a1 82 a8  .6..=...&.......
        0170: ee 28 7b 45 85 d5 7c cc  b0 15 9d 49 f2
ea 69 ee  .({E..|....I..i.
        0180: b3 02 27 b8 32 80 a3 68  34 f6 8d a2 91
dd 9c 07  ..'.2..h4.......
        0190: 6e d5 a1 9a 4e c4 72 6f  28 ab 26 42 f6
34 f5 0c  n...N.ro(.&B.4..
        01a0: 22 c6 7e 5f 53 41 5d 0b  d0 5a ac 90 ae
64 07 d1  ".~_SA]..Z...d..
        01b0: 6a 37 41 04 9c be 1c 74  14 3d 04 d9 60
c3 1c 91  j7A....t.=..`...
        01c0: 8f 3e 4e 1b bd 35 84 03  31 24 db 9b 18
06 a1 5e  .>N..5..1$.....^
        01d0: e5 a9 25 1b 14 e5 8a e2  2f 90 1c a9 a9
ad d8 23  ..%...../......#
        01e0: 00 07 c9 8c 31 c5 36 fa  10 4d 77 0c 62
1c 45 8d  ....1.6..Mw.b.E.
        01f0: cd d0 d5 58 2d 08 83 0d  2f 3d c5 29 c7
99 17 0e  ...X-.../=.)....
        0200: c5 db 48 d5 01 8e 46 18  3d 0d 48 d3 47
12 90 40  ..H...F.=.H.G..@
        0210: e3 bd 38 ab 2b 13 2d c6  5a 5f 20 95 95
8f 5e 94  ..8.+.-.Z_ ...^.
        0220: fb a3 6e 17 f7 98 0e 7b  54 46 9b 4f 72
6c 88 ae  ..n....{TF.Orl..
        0230: e2 06 38 e4 85 c0 c5 27  96 24 b7 fd e3
8e 7a 8a  ..8....'.$....z.
        0240: d5 53 4d 5c 69 d8 86 18  52 06 22 22 40
61 8a 51  .SM\i...R.""@a.Q
        0250: 6a 33 97 39 5a 2d 61 11  98 82 82 b1 9f
dd 1e a6  j3.9Z-a.........
        0260: a7 b4 b6 82 49 01 c9 25  6a 5c 6e c0 b1
b7 2e f1  ....I..%j\n.....
        0270: 84 dc a7 a6 7b 53 3c 90  d1 14 92 3f 95
7a 53 d1  ....{S<....?.zS.
        0280: 0c 84 99 61 65 05 0e c3  c0 c5 4a 92 cf
6e 49 91  ...ae.....J..nI.
        0290: 72 ad 4e e5 46 cc 95 a6  98 c5 cf dd 3d
16 a0 82  r.N.F.......=...
        02a0: 79 98 ed ce d5 1d a8 4e  e2 64 d2 19 24
88 48 bc  y......N.d..$.H.
        02b0: 63 b5 22 4b 28 4c 10 30  68 24 ab 2e 56
60 f1 8f  c."K(L.0h$..V`..
        02c0: ad 68 5b de 14 8f 26 31  b4 54 4a 23 48
89 75 13  .h[...&1.TJ#H.u.
        02d0: e6 02 d1 7c 8d ea 2a 43  76 bf 30 48 f0
6a 92 b0  ...|..*Cv.0H.j..
        02e0: 0b 16 a2 37 80 a0 0e c4  55 81 73 19 42
aa 40 34  ...7....U.s.B.@4
        02f0: c1 6a 53 5b 89 46 41 e8  69 de 5b 3a 05
90 90 28  .jS[.FA.i.[:...(
        0300: 45 49 25 b1 4e 78 0a 31  4f 33 e5 ec 2a
06 49 9d  EI%.Nx.1O3..*.I.
        0310: 41 63 80 0e 28 6c 92 7b  78 15 78 60 54
1e a6 ad  Ac..(l.{x.x`T...
        0320: 47 6d 02 4b b8 31 22 94  44 29 86 16 9b
a9 d9 4e  Gm.K.1".D).....N
        0330: 90 5b 09 02 af fa cf 4a  49 34 31 f1 c9
1c 64 ed  .[.....JI41...d.
        0340: 5c 37 7a b1 1d e4 02 1f  de 2e e2 4f 14
38 dc 44  \7z........O.8.D
        0350: a2 f1 4b 8d 98 51 8a 8d  af 59 64 e4 0f
4c e2 9d  ..K..Q...Yd..L..
        0360: 90 58 ab 7d 3b 4c a4 3b  83 8e c2 ab 35
99 92 05  .X.};L.;....5...
        0370: 68 3b f5 a1 24 86 40 f6  8d bd 48 ca 95
fb de f5  h;..$.@...H.....
        0380: 6d 60 b6 18 00 63 de a6  4c 45 59 2d 84
f2 ed de  m`...c..LEY-....
        0390: 15 16 b4 ad 16 28 ce 1b  9c 0a 6a 2d 01
2f da a3  .....(....j-./..
        03a0: 0e 55 80 f9 7a 0a 75 ae  a7 16 f2 5c 00
a3 b5 52  .U..z.u....\...R
        03b0: d4 02 5d 41 9c b1 8d 14  01 da 9d 0e a3
ba 02 a7  ..]A............
        03c0: 01 bd 29 38 dc 05 37 41  13 2c 46 0f 6a
88 dc ca  ..)8..7A.,F.j...
        03d0: 62 cf 18 3d 29 46 09 03  d8 a5 f6 6f 32
6f 9d f9  b..=)F.....o2o..
        03e0: a2 e2 c6 03 32 8e 8c 3b  8a a2 63 1b 0f
f2 11 a3  ....2..;..c.....
        03f0: 68 c3                                   
         h.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 1c 55 51 68 e3 0c 1c 8c  50 59 33 ee 95
76 e5 94  .UQh....PY3..v..
        0010: 0a 7c 72 c8 a8 b1 a9 c8  5e f4 01 2c 9f
68 76 53  .|r.....^..,.hvS
        0020: 19 38 ef 52 88 a4 67 04  e5 87 a5 02 21
36 f3 ac  .8.R..g.....!6..
        0030: bb 62 52 50 f5 27 b5 24  b6 77 3b f7 08
c9 c7 b5  .bRP.'.$.w;.....
        0040: 4f 30 12 db c1 26 dd ae  71 9e d5 18 f3
c4 a5 54  O0...&..q......T
        0050: fc bd 29 dc 0b 06 3b 9f  31 32 c0 ed e9
4f 41 23  ..)...;.12...OA#
        0060: 4a c4 91 9a c9 a5 cc 04  32 17 8d 88 3c
0f 51 50  J.......2...<.QP
        0070: 3c e5 a5 50 cd 81 ed 5b  21 25 60 49 7c
a9 7f d6  <..P...[!%`I|...
        0080: 64 9e 86 9b 35 d4 c5 f8  6c d0 dd 86 4f
1d bc c4  d...5...l...O...
        0090: a9 c0 0c 7a d3 c5 a4 af  bc 21 0a 07 34
ae 04 29  ...z.....!..4..)
        00a0: 0c c1 18 a6 36 d5 9b 5b  67 9e d9 b7 36
c6 1d a9  ....6..[g...6...
        00b0: 35 75 a0 0a 2d 56 db 6e  c7 f9 8f e5 52
c8 2e 4b  5u..-V.n....R..K
        00c0: 06 38 db 4f a6 a3 1f 2c  73 2a 2b 47 86
15 05 c3  .8.O...,s*+G....
        00d0: 34 12 2c 8e 3a 8e be 94  95 96 82 08 af
dd 94 a0  4.,.:...........
        00e0: 39 a8 e3 69 59 cb 0c b0  f4 a1 c5 31 92
6c b8 91  9..iY......1.l..
        00f0: 4b 93 8f 45 15 14 d6 b3  b1 1b f3 c8 e1
6a b6 11  K..E.........j..
        0100: 48 69 b2 86 26 65 20 f6  cd 68 88 be 54
1e 58 de  Hi..&e ..h..T.X.
        0110: 07 61 4b 70 25 12 14 5c  24 20 31 e3 38
a8 2e 44  .aKp%..\$ 1.8..D
        0120: ea 51 50 1c 1e a6 89 34  80 af 32 5c c4
03 ae 48  .QP....4..2\...H
        0130: ee 29 91 8b a6 5f dd e7  61 3d e8 ba 63
1f 72 97  .)..._..a=..c.r.
        0140: 9e 58 6d b8 22 94 9b 96  85 06 d2 5a 95
ec 22 5d  .Xm."......Z.."]
        0150: 93 a4 41 d8 f0 3b 50 f7  ec 63 1e 71 18
1d 05 50  ..A..;P..c.q...P
        0160: 6c 45 06 a3 e5 37 ca 38  26 a4 79 9e e9
98 9c 05  lE...7.8&.y.....
        0170: 14 35 71 5f 51 2d ce ec  83 16 00 ed 55
6e ed 40  .5q_Q-......Un.@
        0180: dd 22 02 3b 60 54 5d ad  0a 23 82 d2 49
60 2a 40  .".;`T]..#..I`*@
        0190: c7 ad 4b 15 aa c4 06 57  01 7b d5 82 44
72 59 8b  ..K....W.{..DrY.
        01a0: 8c b2 af cc 7a 53 e4 b2  f2 e3 5f 93 95
ed 50 ae  ....zS...._...P.
        01b0: 98 12 c6 09 da 5e 3c 27  d2 9d 2c de 5b
05 68 78  .....^<'..,.[.hx
        01c0: 3f 74 e2 ad 08 05 cc e9  28 c4 78 53 ed
52 0b b7  ?t......(.xS.R..
        01d0: 60 ca b1 85 27 a9 c5 4f  2a 40 8a 2f 11
95 d9 d9  `...'..O*@./....
        01e0: 46 e1 de a7 b6 b6 4f 28  a9 3f 3f 61 4d
79 01 32  F.....O(.??aMy.2
        01f0: 39 50 32 32 57 b5 36 e1  e4 9c 82 13 01
7d 3b d3  9P22W.6......};.
        0200: 1d 88 8c 93 ef db b7 6a  fa d5 79 2e 27
90 ed 55  .......j..y.'..U
        0210: 62 47 15 3c cb 60 2c 23  4e c5 57 04 a8
ea 69 c5  bG.<.`,#N.W...i.
        0220: e5 0a ca 11 98 7a d5 0a  c5 55 86 46 39
da c7 eb  .....z...U.F9...
        0230: 53 47 69 21 52 cd 19 0a  2a 14 07 62 78
ad 65 89  SGi!R...*..bx.e.
        0240: 0b 20 f9 4f 6a 8c c6 e3  72 b1 18 35 49
08 8a 16  . .Oj...r..5I...
        0250: 2a e1 1f 18 1d 2a ea 42  a5 c0 96 50 3d
28 b0 0e  *....*.B...P=(..
        0260: 97 c8 69 d5 4c 9d 2a 40  8a 93 80 64 0c
ac 29 34  ..i.L.*@...d..)4
        0270: 09 91 5c 5b c6 25 18 7f  97 de 9e f6 b0
ec 6f 25  ..\[.%........o%
        0280: c0 72 2a 65 7e 85 b9 2b  19 f3 c3 11 45
8c c9 96  .r*e~..+....E...
        0290: 1d 79 a6 a4 11 74 8c f3  4d 37 d4 81 1e
15 46 0f  .y...t..M7....F.
        02a0: 1f cd 8e b4 b2 45 13 a6  f1 d4 f6 f4 ab
b0 58 8a  .....E........X.
        02b0: 3b 75 f3 b2 ae 76 8e d9  a9 d5 e5 c1 31
92 a7 d2  ;u...v......1...
        02c0: 91 5c ba 00 92 50 a0 3b  10 fd 8d 5a 92
ee e3 60  .\...P.;...Z...`
        02d0: 41 ca 81 c9 a2 c8 2d 62  13 7b 3c 20 14
6c ad 36  A.....-b.{< .l.6
        02e0: ea f6 5b 98 95 58 7c a7  ae 29 68 21 91
85 57 55  ..[..X|..)h!..WU
        02f0: 8f 2c 31 d4 d3 ca 45 bf  72 e4 37 7a 76
11 0f d9  .,1...E.r.7zv...
        0300: bc c9 06 39 cf 7a 64 96  ee 92 15 07 06
8b 01 62  ...9.zd........b
        0310: de ce 01 1b 34 8b ba 46  e9 4b f2 28 45
0a 3e 5e  ....4..F.K.(E.>^
        0320: 0d 0c 76 1c 26 0b f2 c4  01 27 bf a5 2c
d7 26 2c  ..v.&....'..,.&,
        0330: 01 18 6c f5 e2 94 74 1e  c4 89 7e 62 4d
aa 9c 1e  ..l...t...~bM...
        0340: d5 2c f7 ff 00 b9 40 ab  86 f4 a6 e5 62
46 bd d5  .,....@.....bF..
        0350: c3 34 68 a0 00 47 4a 6c  d7 52 34 6c 81
be 65 ea  .4h..GJl.R4l..e.
        0360: 2a 27 2b 01 55 96 39 c8  42 b9 7f 5a 86
eb 4f 0a  *'+.U.9.B..Z..O.
        0370: ab e4 7c be b8 aa 52 21  26 99 2d 92 88
e2 2a 47  ..|...R!&.-...*G
        0380: cc 3b e2 9d b9 8c 67 ca  2a 41 35 45 dc
87 64 d6  .;....g.*A5E..d.
        0390: f3 01 81 96 1d 68 7b b6  6c 45 22 1c 7a
81 4f 4b  .....h{.lE".z.OK
        03a0: 01 38 9a 65 60 91 b1 55  c7 5a ae 2e d9
a6 c0 39  .8.e`..U.Z.....9
        03b0: 75 ef eb 58 4d 73 31 5c  4d ad b9 49 8b
9f 4c 53  u..XMs1\M..I..LS
        03c0: 1c 47 e6 03 24 59 27 a7  b5 68 d6 86 8d
db 42 31  .G..$Y'..h....B1
        03d0: 2c 4d 37 97 34 65 a3 1e  d5 61 e2 85 d1
59 57 e5  ,M7.4e...a...YW.
        03e0: 5e d4 27 d0 70 6b a9 59  ee 2d d6 e3 2a
4c 64 76  ^.'.pk.Y.-..*Ldv
        03f0: a9 dc                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 43 72 73 23 80 7b 62 a8  97 6e 83 d0 47
36 22 27  Crs#.{b..n..G6"'
        0010: 84 e9 8e f5 14 d6 83 cf  0d 12 f4 a4 f4
24 7c c2  .............$|.
        0020: 50 f1 b0 4c b0 fe 11 53  bc 25 b0 eb 1f
1f c4 b4  P..L...S.%......
        0030: 27 73 48 c6 e8 46 8d 2e  00 65 8c 85 1c
71 4c 5b  'sH..F...e...qL[
        0040: 32 9c a9 3b 4d 3b d8 2d  ca 48 ba 73 b3
97 72 70  2..;M;.-.H.s..rp
        0050: 78 02 98 d6 23 26 36 63  9a 41 cf 7d d1
44 5a 79  x...#&6c.A.}.DZy
        0060: 12 30 4c 93 d8 9a 9e 3b  73 32 13 37 ce
e3 a6 29  .0L....;s2.7...)
        0070: 37 a1 0d dc 2d ac 99 37  09 66 c2 7f 77
35 3c 10  7...-..7.f..w5<.
        0080: c1 1e 56 49 33 9f ba 28  8c ae 4a b9 23
47 14 51  ..VI3..(..J.#G.Q
        0090: 36 4f 22 aa 8b b8 09 3c  12 a3 8a 76 b8
c7 97 8e  6O"....<...v....
        00a0: 3b 66 70 b9 53 da a7 b6  96 36 89 36 20
07 a8 a6  ;fp.S....6.6 ...
        00b0: 38 d9 92 49 26 f0 5d 17  6b 0e d5 12 3c
b3 a9 2a  8..I&.].k...<..*
        00c0: 98 22 b9 25 17 ce 37 67  b1 3e c9 9d 94
30 18 a8  .".%..7g.>...0..
        00d0: ee 63 72 f8 3c 9e c2 ba  77 d0 9b 58 ac
52 e7 8d  .cr.<...w..X.R..
        00e0: cb 9c 76 a6 aa dc b1 6c  c6 00 a6 b4 1e
e5 88 92  ..v....l........
        00f0: 64 4c 32 64 1a ae 25 93  71 42 99 51 d2
98 58 96  dL2d..%.qB.Q..X.
        0100: 44 63 12 b0 42 33 db 14  b1 a4 8b 19 05
7e 82 84  Dc..B3.......~..
        0110: 08 25 0d 26 d6 92 30 02  f6 14 ff 00 30
31 04 a6  .%.&..0.....01..
        0120: 07 40 2a 25 3b 68 54 95  86 3c 0a 92 12
eb 8d dd  .@*%;hT..<......
        0130: 29 5a 06 58 d4 32 e0 f6  c5 55 f4 14 52
ea 24 ed  )Z.X.2...U..R.$.
        0140: 28 0b f2 00 05 4b 1b 4b  22 60 01 8a 5c
c0 c8 96  (....K.K"`..\...
        0150: 32 ea 37 26 5f 3d aa 62  8a b8 3b 77 30
ec 2a 66  2.7&_=.b..;w0.*f
        0160: da d8 22 3d 23 32 a9 52  b8 7f 4f 4a 46
b6 97 6b  .."=#2.R..OJF..k
        0170: 05 5c 11 57 70 95 9b d0  64 99 fb 20 e0
06 53 c9  .\.Wp...d.. ..S.
        0180: aa e6 7b 72 c3 68 fd f7  ad 1b 8a e8 6d
c3 c6 41  ..{r.h......m..A
        0190: 21 c8 90 0e 6a 4b 67 0e  8a 53 a0 eb 46
c8 1b 15  !...jKg..S..F...
        01a0: f7 33 36 17 e5 1d 31 52  2b ee 8f 63 61
4e 38 26  .36...1R+..caN8&
        01b0: 81 11 32 21 8f 00 e6 51  d4 d5 a1 34 76
d1 46 8b  ..2!...Q...4v.F.
        01c0: 9d c7 ad 0d 5f 51 8d b8  96 36 70 57 e5
1d ea a3  ...._Q...6pW....
        01d0: 48 52 6c 8f 9d 7b 51 6b  86 e4 d1 9b 7d
a5 ce 72  HRl..{Qk....}..r
        01e0: 4f 2b 52 31 84 ba fc c4  0a 60 10 fd 9b
73 3c 80  O+R1.....`...s<.
        01f0: b3 76 35 0c f1 2f 98 04  58 da 7a fb 50
b4 11 3d  .v5../..X.z.P..=
        0200: aa a2 1c 06 07 d8 d4 13  29 05 c0 eb d4
51 7b 89  ........)....Q{.
        0210: 3b 95 f1 2b 46 09 e5 aa  cc 01 e6 55 de
f8 c7 6a  ;..+F......U...j
        0220: 49 dc 63 25 47 57 25 5f  9a 06 f4 65 32
3f 06 9d  I.c%GW%_...e2?..
        0230: 80 d0 b0 30 07 2c ec 3e  95 62 47 b4 29
fb b2 09  ...0.,.>.bG.)...
        0240: 3d a9 34 04 52 45 13 00  91 fd e3 de 89
ed c2 a0  =.4.RE..........
        0250: d8 40 f7 f5 a6 86 24 57  46 24 2a 54 30
1d 4d 49  .@....$WF$*T0.MI
        0260: 1d ec 68 86 48 c6 49 ed  40 87 d9 6a 6a
62 63 22  ..h.H.I.@..jjbc"
        0270: 80 41 f4 a9 e7 d5 52 18  81 3b 49 6e d4
92 03 2a  .A....R..;In...*
        0280: ee e4 4b 06 f8 db 6b 7b  55 75 9a 46 8c
61 be 6a  ..K...k{Uu.F.a.j
        0290: a5 a0 21 04 d7 6d 22 e1  b0 47 6a 52 66
f3 89 2e  ..!..m"..GjRf...
        02a0: 43 7a 0a 9e 64 d8 0e b7  76 2c c9 31 c9
34 bf 67  Cz..d...v,.1.4.g
        02b0: 8d 43 1e 49 3f a5 30 20  8e 18 f8 0e 4f
06 96 58  .C.I?.0 ....O..X
        02c0: ca 48 a6 2c ec 35 0e f7  b8 22 ec 93 3a
00 58 f2  .H.,.5..."..:.X.
        02d0: 07 14 c5 79 64 c1 59 08  cf 18 ab 01 12
39 51 fc  ...yd.Y......9Q.
        02e0: a3 26 6a 33 73 22 4c d0  82 43 0a 4e 56
02 78 a5  .&j3s"L..C.NV.x.
        02f0: 95 d7 6b 2e 68 92 5b a4  20 7f 00 a4 de
80 11 dd  ..k.h.[. .......
        0300: ce cd 85 e0 0a 86 e2 4b  a9 f7 2b 8c ad
38 ec 34  .......K..+..8.4
        0310: 45 1c 0f 91 b3 28 de b5  27 9b 72 84 28
18 3d 33  E....(..'.r.(.=3
        0320: 47 31 a4 ac d1 62 19 6e  62 fe 3d de d4
f8 ef 6e  G1...b.nb.=....n
        0330: 64 93 28 b9 61 dc d1 74  64 86 35 c5 dc
ac c6 55  d.(.a..td.5....U
        0340: 21 07 71 4c 4b b9 62 3b  80 c9 f7 a1 58
63 d2 ee  !.qLK.b;....Xc..
        0350: 49 78 56 c1 3d 8d 58 8e  e5 81 d9 2f 2b
d8 d3 11  IxV.=.X..../+...
        0360: 23 5c 85 88 c4 c4 64 d2  ac ca ab 1a 28
a2 c3 12  #\....d.....(...
        0370: ea f1 63 90 23 02 57 e9  50 f9 e5 d8 95
3b 46 38  ..c.#.W.P....;F8
        0380: a0 45 77 b8 76 b7 23 77  7a 8c 45 03 8c
bb 64 d0  .Ew.v.#wz.E...d.
        0390: 25 72 c3 c5 6e 91 c7 b1  6a 77 16 c1 41
c1 56 ed  %r..n...jw..A.V.
        03a0: 41 49 00 78 98 aa 86 c3  54 e1 6d d9 4c
7b b9 3e  AI.x....T.m.L{.>
        03b0: b4 08 85 21 8d 24 3f 39  55 14 97 08 ae
be 5a c9  ...!.$?9U.....Z.
        03c0: 85 3c d0 04 31 a8 0a a8  af 82 0f 5a b2
f1 c9 1a  .<..1......Z....
        03d0: 33 ab 07 04 77 a2 f6 03  39 e4 9e 38 f7
49 8f 61  3...w...9..8.I.a
        03e0: 51 c7 73 24 a7 74 8a 09  5e 82 a5 4a e2
49 97 ec  Q.s$.t..^..J.I..
        03f0: af 12                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 76 2b 2a 01 b6 9c 82 16  62 c0 f1 9c 11
54 d5 ca  v+*.....b....T..
        0010: 27 6b 7b 66 0a a1 ba d4  4d 67 0c 6e 1a
39 32 29  'k{f....Mg.n.92)
        0020: 25 60 b9 20 7b 50 bb 73  9c 75 a9 fc db
65 44 64  %`. {P.s.u...eDd
        0030: 23 6d 31 5e e5 6b a9 22  1c a0 04 1a af
31 58 70  #m1^.k.".....1Xp
        0040: d1 91 96 ac f9 2f b8 10  0b 86 56 64 07
92 3a 54  ...../....Vd..:T
        0050: f6 73 b4 47 6c 80 6d 3e  d5 6a 29 6c 0d
d8 12 f8  .s.Gl.m>.j)l....
        0060: f9 ac aa 80 0f a5 0f a8  ca 18 c6 a8 36
50 9d c0  ............6P..
        0070: ad 2d cd c3 10 b9 d8 83  9a 8a 36 2f 13
ee 53 bb  .-........6/..S.
        0080: b1 a6 04 12 46 c5 93 a8  ab 8c 62 57 8d
5f 2c d4  ....F.....bW._,.
        0090: 01 3b 88 22 c8 74 c9 3d  0d 3a 39 61 38
00 63 14  .;.".t.=.:9a8.c.
        00a0: 9a ba 04 ac 2c 57 16 d2  48 ca ca 4e 3b
d4 85 6d  ....,W..H..N;..m
        00b0: 57 95 62 47 b5 09 59 01  51 52 d0 c8 77
02 29 56  W.bG..Y.QR..w.)V
        00c0: da de 29 72 ce 40 6e 94  35 72 5c 94 4b
11 db c0  ..)r.@n.5r\.K...
        00d0: 90 be c3 55 22 b3 02 60  c5 f1 9e 8b da
92 d3 43  ...U"..`.......C
        00e0: 58 cd 58 59 6d 90 b3 38  72 ae bd 85 3b
ec ac 51  X.XYm..8r...;..Q
        00f0: 5c 48 43 e2 9a 77 17 3d  d5 88 9a d8 80
1a 69 39  \HC..w.=......i9
        0100: f6 a9 e3 89 5d 48 49 7a  d3 b2 15 de c5
65 8e 31  ....]HIz.....e.1
        0110: 3f 93 bc 16 35 2f d9 23  0f e5 89 45 4b
48 06 47  ?...5/.#...EKH.G
        0120: b6 19 4a ee ca 8e f5 24  86 10 8d 27 98
08 3d a9  ..J....$...'..=.
        0130: dd 12 da 42 59 a8 23 97  c0 3d 2a 49 a3
89 4f 32  ...BY.#..=*I..O2
        0140: 82 0f 53 4c 77 27 ff 00  43 8d 11 56 4c
bf ad 43  ..SLw'..C..VL..C
        0150: 39 b4 c8 0a c7 71 ea 6a  5c 58 d5 45 b1
42 e2 5b  9....q.j\X.E.B.[
        0160: 78 5c a2 e4 93 de ab a5  ef ef f6 0f 99
7d 68 8c  x\...........}h.
        0170: 6c 39 3b 87 db 37 48 40  00 81 de ae db
32 88 c3  l9;..7H@.....2..
        0180: 4c 33 9e 95 5b 93 18 d9  0c 9a e0 fd a4
22 7d f0  L3..[........"}.
        0190: 38 a8 19 d8 31 2c a7 7b  75 34 59 31 8b
6f 77 b6  8...1,.{u4Y1.ow.
        01a0: eb 21 03 15 15 2c 77 b2  b4 ac c6 3e 33
c7 b5 26  .!...,w....>3..&
        01b0: 26 84 9a 69 65 12 46 10  29 c7 06 aa 69
d1 4b 1f  &..ie.F.)...i.K.
        01c0: 32 31 0a 0d 2e 6d 6c 2d  89 e6 b8 92 47
6d a3 00  21...ml-....Gm..
        01d0: 74 15 34 2e cd 6f b5 63  1b c7 5a 6d d9
0c 6c b7  t.4..o.c..Zm..l.
        01e0: 12 18 49 2a 3e 5e 29 90  05 45 0f 1a 8d
e7 ae 6b  ..I*>^)..E.....k
        01f0: 3d 6f 74 16 24 8e f0 b2  91 c0 18 e0 d5
41 76 d1  =ot.$........Av.
        0200: be 1c 02 07 7a d5 bb 14  a3 72 77 96 22
37 b1 55  ....z....rw."7.U
        0210: 51 4d 12 a0 80 98 88 c9  a5 64 f5 06 ac
53 92 2b  QM.......d...S.+
        0220: 79 58 4f d5 c7 04 52 2d  b0 0a f2 33 63
8e 29 b0  yXO...R-...3c.).
        0230: 88 db 69 7c af 99 5b 22  ae 0b 89 4b 2b
29 01 07  ..i|..["...K+)..
        0240: 5a 04 e2 59 93 53 58 ee  23 55 50 17 1c
9a b0 b3  Z..Y.SX.#UP.....
        0250: 19 e4 0f 0b 03 ea 28 6e  c0 9d 81 a4 92
27 65 8c  ......(n.....'e.
        0260: a9 0d d7 da aa b5 d9 b5  75 f3 4f 5e b4
59 31 da  ........u.O^.Y1.
        0270: fa 92 c9 ab 46 e0 08 64  19 1d 2a 37 bd
d8 9f bc  ....F..d..*7....
        0280: 19 76 f4 a6 49 10 90 30  cb 30 e6 92 d9
9a 36 24  .v..I..0.0....6$
        0290: 1f 94 f4 a4 34 82 e6 1f  31 82 e4 96 eb
9a 8a 35  ....4...1......5
        02a0: 0f 2e d2 40 65 ee 68 04  ae 4e 57 cc 8c
92 e3 68  ...@e.h..NW....h
        02b0: ef 51 32 db b0 01 48 a2  e0 c9 76 09 76
aa 7d d3  .Q2...H...v.v.}.
        02c0: 52 45 1b a0 68 d0 7c c3  a1 a9 4e ec 2c
3e d2 19  RE..h.|...N.,>..
        02d0: 5a 62 a5 b9 3d aa 6b 82  61 89 96 37 00
f7 a7 6e  Zb..=.k.a..7...n
        02e0: a1 6b 0e 31 33 40 92 79  bc 01 d3 35 58
c8 ce 4b  .k.13@.y...5X..K
        02f0: 12 57 d0 d1 71 08 97 32  c4 a7 73 02 4d
24 97 4d  .W..q..2..s.M$.M
        0300: 30 55 84 e0 8f bc 69 8c  73 5c 48 f0 b0
46 c0 5e  0U....i.s\H..F.^
        0310: f5 1d ac a5 90 12 46 57  bd 17 48 41 25
e3 30 66  ......FW..HA%.0f
        0320: 67 00 2f 00 0a 92 0b a6  2a ac c4 15 f4
a7 7b 8d  g./.....*.....{.
        0330: 21 93 5c 9d e3 19 c7 a5  34 bb 90 d2 32
9c 2f dd  !.\.....4...2./.
        0340: c5 65 cb ef 12 f5 64 69  2c f3 00 66 e3
9f 94 54  .e....di,..f...T
        0350: f3 4b 34 60 07 3f 37 6a  d1 21 91 33 ca
ce a2 62  .K4`.?7j.!.3...b
        0360: 79 14 b1 cb b7 78 dc 40  1d a9 31 90 c5
3c ca 46  y....x.@..1..<.F
        0370: 32 06 6a 77 96 41 30 30  b6 57 b9 a6 24
4e b2 39  2.jw.A00.W..$N.9
        0380: e4 36 1c 77 a5 91 ee 26  c3 ac 80 63 82
29 6c 02  .6.w...&...c.)l.
        0390: 18 7c c8 8e 64 e7 bd 53  11 0c ae c5 e4
77 a1 47  .|..d..S.....w.G
        03a0: 5b a0 1d 22 2b 4a a0 ae  33 d4 d5 84 8d
11 5b 63  [.."+J..3.....[c
        03b0: 00 b4 9d d0 13 5a 6d 9d  76 83 8d bd 7d
e9 24 b7  .....Zm.v...}.$.
        03c0: 13 31 0e 71 18 e9 eb 52  e3 d8 08 d6 35
24 80 08  .1.q...R....5$..
        03d0: c7 7a 96 04 49 33 e6 10  48 e9 55 15 64
03 a7 8d  .z..I3..H.U.d...
        03e0: 58 01 81 bb f9 d5 25 da  97 0b b8 e3 da
aa e1 73  X.....%........s
        03f0: 4a 5b                                   
         J[
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 1f 34 ac 89 b4 1f 6a 61  b3 02 51 b8 8d
b5 13 92  .4....ja..Q.....
        0010: 48 64 d1 d8 2a 9c 87 04  30 e9 e9 51 45
61 32 4a  Hd..*...0..QEa2J
        0020: c2 30 1c 77 a5 7b ad 01  6a 41 71 69 24
17 0a c5  .0.w.{..jAqi$...
        0030: 4e 4f a5 4a 8a 19 08 97  8f 4a ae 74 b7
04 40 d1  NO.J.....J.t..@.
        0040: ec 60 a0 93 9a 3e cb 27  9a 10 1d aa 7b
d3 e6 44  .`...>.'....{..D
        0050: b5 72 63 14 61 84 59 24  8e a6 92 48 16
42 11 86  .rc.a.Y$...H.B..
        0060: 31 d2 8e 64 35 a1 5e 78  c4 2d fb be dd
6a 5b 33  1..d5.^x.-...j[3
        0070: 02 90 e0 64 9a 4d 5c 2e  59 59 31 26 e4
03 06 94  ...d.M\.YY1&....
        0080: 4b e7 cc 56 41 80 bd 31  d2 9a 56 0b 8c
9e 05 39  K..VA..1..V....9
        0090: 58 d8 60 d4 06 c6 58 76  85 60 54 f7 a1
00 f8 ec  X.`...Xv.`T.....
        00a0: 9d 9b 6b 38 5c d3 97 4f  2d 3e 2e 58 05
1f 74 fa  ..k8\..O->.X..t.
        00b0: d3 02 2b a2 96 d2 2a 05  dc be d4 df 39
63 99 46  ..+...*.....9c.F
        00c0: ce 1b a7 b5 26 ae 04 c5  d6 29 81 23 24
f7 a6 35  ....&....).#$..5
        00d0: cc 24 36 dc 97 ed 53 18  d8 09 2d a4 b6
8e 12 d2  .$6...S...-.....
        00e0: 9c 3b 77 35 66 31 00 88  b6 ff 00 bd d3
35 60 9d  .;w5f1.......5`.
        00f0: c8 4c f6 c8 36 94 dc c3  bd 58 b5 9a da
68 ca 91  .L..6....X...h..
        0100: 82 29 01 46 e1 40 dc 73  95 ed 54 77 4a
09 50 ac  .).F.@.s..TwJ.P.
        0110: 0f 6c 51 70 26 b4 49 d8  96 e4 b0 a8 da
37 17 1e  .lQp&.I......7..
        0120: 63 12 ce 7b 0a 4e c0 4b  6d f6 a8 67 24
9c a1 e9  c..{.N.Km..g$...
        0130: ed 5a f1 37 da 3a 8c 11  d4 53 d1 80 d9
af 6d 6d  .Z.7.:...S....mm
        0140: 8a 80 99 7a 80 ea 11 64  b4 43 83 f7 a8
8c 6c 02  ...z...d.C....l.
        0150: 3e a5 0e 00 d9 c9 a8 ae  af b6 aa 80 a0
03 47 2a  >.............G*
        0160: 02 c6 9f 2c 6e ac 48 f9  fb 55 a4 56 db
88 f6 ef  ...,n.H..U.V....
        0170: ee 28 e5 40 47 39 b9 5c  14 40 ca 7b 56
75 c4 a7  .(.@G9.\.@.{Vu..
        0180: e6 47 8c 87 ed 8a 76 19  48 b4 d8 12 14
23 1d 31  .G....v.H....#.1
        0190: 56 22 7b 9b 88 f6 c4 9c  f7 26 80 01 6b
74 49 66  V"{......&..ktIf
        01a0: 05 88 e9 50 f9 d7 3c aa  a3 6f 1e d4 5c
2c 38 3d  ...P..<..o..\,8=
        01b0: cb 6c 0f 1b 33 0e a7 15  20 6b 86 98 14
8c 98 fe  .l..3... k......
        01c0: 94 08 9d e2 98 a3 01 18  c1 ed 8a a3 04
73 42 ec  .............sB.
        01d0: 59 09 6f 4a 84 d3 19 30  92 e6 42 13 ca
38 ed c5  Y.oJ...0..B..8..
        01e0: 38 09 43 1f 31 4e f1 d0  55 a0 11 4c ca
5a 43 19  8.C.1N..U..L.ZC.
        01f0: cf a5 35 e4 94 94 90 a1  1f 85 00 44 f7
77 13 3e  ..5........D.w.>
        0200: c5 8c 84 f5 c5 4f 24 ce  88 bf 29 18 ef
40 ac 44  .....O$...)..@.D
        0210: 6e 58 01 95 3b 3b 91 56  45 e3 2c 7c 1c
e7 a0 a6  nX..;;.VE.,|....
        0220: 16 22 9a 66 21 44 aa 6a  12 f8 1b e1 ce
45 24 0d  .".f!D.j.....E$.
        0230: 09 f6 89 25 c8 09 b0 0e  a6 9f 15 d8 8a
16 c0 f9  ...%............
        0240: 8f 7a 04 88 22 b9 60 e3  6c 85 9d bb 56
c5 b5 e4  .z..".`.l...V...
        0250: 71 af 97 2a 90 e7 ad 00  87 b4 f0 2a 94
08 39 ef  q..*.......*..9.
        0260: 59 f7 93 f9 8e 23 89 76  c7 49 21 90 99
27 c8 04  Y....#.v.I!..'..
        0270: 1c 2d 36 7b 99 9a 74 fd  d9 0b 4c 09 62
72 ed 92  .-6{..t...L.br..
        0280: 30 c7 bd 3d 7c c8 dc b4  8c 18 2f 41 45
c2 c4 f0  0..=|...../AE...
        0290: 5c a4 a0 b3 21 0d e9 55  7c e9 5e e1 c4
6a 71 d8  \...!..U|.^..jq.
        02a0: 52 4a c0 36 17 96 47 75  94 1c 0a 16 49
d5 f9 52  RJ.6..Gu....I..R
        02b0: 14 74 14 d0 d1 76 da ee  30 a0 ba fc dd
e9 e9 75  .t...v..0......u
        02c0: 69 1b 33 ba 96 cf 43 e9  40 89 da fe dd
50 1f 2b  i.3...C.@....P.+
        02d0: 78 22 8b 6b 9b 73 0b b7  95 8f 63 49 ab
81 0d bc  x".k.s....cI....
        02e0: f0 2a c8 ac 9b 41 ef 48  f7 10 c7 0e c8
97 93 d0  .*...A.H........
        02f0: d2 69 d8 0a 4b 24 f3 e5  02 01 8e a6 97
32 98 d5  .i..K$.......2..
        0300: 0c 7b 97 b1 a2 31 b0 9a  4c b6 1a 58 e1
1f bb 27  .{...1..L..X...'
        0310: d4 54 6b 71 20 98 3f 96  76 63 a1 ed 4d
5f a8 c8  .Tkq .?.vc..M_..
        0320: e5 95 c3 79 9b 09 f6 a9  52 47 b8 21 09
d8 4d 3b  ...y....RG.!..M;
        0330: 92 96 a3 e7 83 60 55 04  b0 a6 45 0b ef
3b 41 0a  .....`U...E..;A.
        0340: 28 28 62 c3 b5 da 40 a4  52 79 40 80 ca
c5 49 ea  ((b...@.Ry@...I.
        0350: 4d 2b 5f 71 8f 06 21 1b  46 17 39 ea 6a
31 0a 1d  M+_q..!.F.9.j1..
        0360: ab 8c 0f 4a 97 14 85 61  ee 4b 00 aa 36
a8 e3 a5  ...J...a.K..6...
        0370: 29 b5 12 83 b4 16 db 55  1d 85 6b 09 e4
14 45 05  )......U..k...E.
        0380: 32 df 4e 94 c9 15 63 73  b9 72 29 29 5c
2c 83 ca  2.N...cs.r))\,..
        0390: 88 1f 31 97 39 1c 52 18  e1 87 9d a0 67
ad 12 4d  ..1.9.R.....g..M
        03a0: ab 0c 48 a0 84 2e 59 70  0f 4f 7a 25 ba
28 e2 35  ..H...Yp.Oz%.(.5
        03b0: 4c 2f 6a 88 ae 52 f9 b4  b0 b1 0c be ed
b9 7f 5a  L/j..R.........Z
        03c0: 91 01 98 94 65 da f5 5c  fd 88 09 6d d6
d9 77 b7  ....e..\...m..w.
        03d0: cb 9e f5 54 b0 8e 64 c3  fc b4 e2 f9 86
c9 b5 2b  ...T..d........+
        03e0: b8 56 15 f2 be f7 71 55  2d 2e 0c df ba
93 23 3f  .V....qU-.....#?
        03f0: 76 9a                                   
         v.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 8a 42 34 e0 b7 56 51 92  3c c1 d2 9f 24
b1 c2 e3  .B4..VQ.<...$...
        0010: ce e1 fa 60 53 01 00 b5  55 20 92 cc c7
34 ad 12  ...`S...U ...4..
        0020: 63 f7 2b 92 7a fb 52 db  61 27 73 38 5b
c6 e9 98  c.+.z.R.a's8[...
        0030: df 24 75 15 9f 70 f1 ef  e1 4b 62 a5 dd
a1 bb a5  .$u..p...Kb.....
        0040: a0 d7 b7 79 40 69 1b 6c  46 91 ed 9e 34
01 5c e3  ...y@i.lF...4.\.
        0050: b1 a9 52 7b 0b 59 23 42  d6 d1 4a 16 04
1e 3f 3a  ..R{.Y#B..J...?:
        0060: a4 e2 67 2c b9 f9 3a 11  56 ae d8 e1 1b
21 8f 18  ..g,..:.V....!..
        0070: 85 15 53 23 3d a9 c8 84  46 c8 58 8c d5
5c ad c5  ..S#=...F.X..\..
        0080: fb 2b 48 ca 33 d3 bd 5a  83 6d b2 11 1b
10 c3 f5  .+H.3..Z.m......
        0090: a9 52 4c 4d 58 92 3d cd  19 f9 88 63 50
cd 11 97  .RLMX.=....cP...
        00a0: 0a ed c5 50 22 23 62 b1  a8 10 91 b8 75
a7 a4 6f  ...P"#b.....u..o
        00b0: 9f 98 fe 34 ae 56 89 0d  f2 1d 10 b3 82
55 bb d1  ...4.V.......U..
        00c0: 31 51 02 f2 c3 1d 05 32  59 3d 89 2f 90
e4 86 c7  1Q.....2Y=./....
        00d0: ca 6a 3f b2 31 59 5d 9b  e6 53 4a 4e c0
b7 1c 32  .j?.1Y]..SJN...2
        00e0: b1 05 43 fb b3 d6 aa 18  d9 ae 0f 95 9d
be d5 9b  ..C.............
        00f0: bb 2a 51 2e c4 af 0a 06  2d c5 38 99 10
f9 a9 26  .*Q.....-.8....&
        0100: ec ff 00 0d 54 23 62 4b  30 31 c1 32 36
24 3e 95  ....T#bK01.26$>.
        0110: 0c 9b bc e1 bb 25 3d 6a  f7 10 b3 43 21
c8 82 4c  .....%=j...C!..L
        0120: 02 3a 66 a1 89 65 3f 23  36 58 56 72 52
e8 03 5d  .:f..e?#6XVrR..]
        0130: 5d 98 a8 e4 9f d2 a6 82  01 13 03 bf 05
ba d0 9c  ]...............
        0140: ba 81 79 6d 60 da 76 3f  5e a2 a0 68 a0
80 05 07  ..ym`.v?^..h....
        0150: ad 5c 95 d0 0e 5b 18 73  b9 dc 63 d2 9d
15 ac 39  .\...[.s..c....9
        0160: e1 c6 7b 54 41 34 32 cc  90 c4 a8 ac fb
4b 0a 21  ..{TA42......K.!
        0170: 58 65 72 c5 c2 e3 f8 69  34 d0 0b b2 39
9f 18 0a  Xer....i4...9...
        0180: 57 d2 ab dc 40 05 ce 7c  c1 bb b0 ad 16
c0 06 16  W...@..|........
        0190: 64 26 66 0a 7b 1a 82 de  d9 21 52 cc 43
92 7a d2  d&f.{....!R.C.z.
        01a0: d4 19 6d 2d 17 ef 16 01  48 e4 53 60 82
d5 55 c8  ..m-....H.S`..U.
        01b0: 7c c7 de aa f6 40 91 6e  08 ad 5a 3c 87
18 f5 a7  |....@.n..Z<....
        01c0: cf 69 07 96 ad 19 c5 45  ee 22 11 a6 07
02 48 65  .i.....E."....He
        01d0: ca f7 15 14 d6 85 01 01  80 18 a6 a4 de
c5 5c 82  ..............\.
        01e0: de c4 3e 0c f2 e4 8a 59  22 82 37 31 2b
6e 66 e9  ..>....Y".71+nf.
        01f0: 54 dd c9 d8 b1 05 9a 40  55 9a 4e 0f a5
3e 51 02  T......@U.N..>Q.
        0200: 49 e6 39 f9 7b 0a 98 b6  d0 c4 b8 bf 89
a1 31 ac  I.9.{.........1.
        0210: 58 38 ea 05 61 33 b0 61  b5 8e 73 4d 21
3d 4b 32  X8..a3.a..sM!=K2
        0220: 07 f2 94 ef f9 aa 3b 6b  66 67 33 4a c4
8a 61 62  ......;kfg3J..ab
        0230: ec 13 4c b2 61 0e 57 b5  3a f2 57 10 95
27 e6 3d  ..L.a.W.:.W..'.=
        0240: c5 2e 54 0d 14 e0 17 2a  e1 de 52 be 82
b4 b4 fd  ..T....*..R.....
        0250: 46 54 2f bc fb 0a 2e 90  46 24 cf a9 2a
a8 59 17  FT/.....F$..*.Y.
        0260: 74 87 f4 a6 4b 74 81 57  62 06 3d 71 53
28 45 bb  t...Kt.Wb.=qS(E.
        0270: b1 91 49 a9 c4 b8 51 07  cd 41 d4 77 20
2f 18 1e  ..I...Q..A.w /..
        0280: 95 5c a8 43 24 b9 24 2e  d5 01 bb 9a 67
f6 81 59  .\.C$.$.....g..Y
        0290: 32 63 cf 6a 5c a8 65 39  9a 4b 89 9b 69
2a 0f 5a  2c.j\.e9.K..i*.Z
        02a0: 90 46 f1 a2 ac 7c fb d3  ba b8 81 22 9d
a6 11 ab  .F...|....."....
        02b0: 10 bd cd 4f 79 14 ea aa  20 e9 d2 84 f5
b0 11 f9  ...Oy... .......
        02c0: 37 44 22 9c 92 7d 2a ef  93 74 eb b4 9c
00 38 a6  7D"..}*..t....8.
        02d0: 04 62 da e9 59 77 13 b8  76 a9 1e 0b 82
c0 48 49  .b..Yw..v.....HI
        02e0: 1d 8d 26 ec 34 8a 72 ac  a1 88 0b f3 8a
8c a4 bc  ..&.4.r.........
        02f0: 79 87 2c 7f 4a 5c e8 09  64 89 e2 5d bc
b1 a7 5b  y.,.J\..d..]...[
        0300: c4 ae 0e 17 6b 50 d7 51  01 b0 73 9f 30
12 28 ba  ....kP.Q..s.0.(.
        0310: 86 5f 29 3c 90 4a ad 55  ee 05 8b 68 36
95 2e 87  ._)<.J.U...h6...
        0320: 71 1d 31 48 f0 9d e4 22  15 24 f6 a5 64
80 bd 1d  q.1H...".$..d...
        0330: bc 46 2d ad f7 94 51 14  d6 89 95 d8 0b
e3 9a 52  .F-...Q........R
        0340: 43 01 73 14 68 c8 b1 f5  a8 63 68 82 b3
04 19 3d  C.s.h....ch....=
        0350: a8 e5 5b 8a e3 96 e6 24  da 02 83 eb 50
ad c2 a5  ..[....$....P...
        0360: c1 6f e1 3e 94 f4 40 56  9f f7 92 ee 45
e0 f7 a8  .o.>..@V....E...
        0370: 05 a9 57 73 bb 39 ec 28  d4 62 c5 1b 1c
ab 01 91  ..Ws.9.(.b......
        0380: d2 98 b0 1c 48 1c 67 d0  d3 b0 12 20 d8
a8 8a d8  ....H.g.... ....
        0390: 6a b9 6c ce a5 98 39 dd  40 87 7d ae 69
57 00 e0  j.l...9.@.}.iW..
        03a0: 8a 04 82 43 9c 29 61 d6  a5 ab 80 5c 4f
fb bd a9  ...C.)a....\O...
        03b0: 18 da 3d a9 8b 76 ed 1e  22 40 8a 07 cc
71 45 ac  ..=..v.."@...qE.
        03c0: 04 b6 f7 32 2e d2 06 54  55 88 af 60 69
8b 34 40  ...2...TU..`i.4@
        03d0: 1f a5 43 87 36 e0 5d b6  bb b6 52 db d1
40 3e d4  ..C.6.]...R..@>.
        03e0: c6 b8 b5 8d c9 00 08 fd  2a 94 2c 09 dc
82 49 e2  ........*.,...I.
        03f0: 2c 1d                                   
         ,.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 0f c8 69 ff 00 69 80 2e  f2 aa 40 ea 68
8a 43 43  ..i..i....@.h.CC
        0010: 56 f6 26 51 e5 46 33 eb  8a 82 e2 ed 23
7d cc 81  V.&Q.F3.....#}..
        0020: bf 0a ae 50 1d f6 c8 59  54 b2 70 de d4
97 73 2e  ...P...YT.p...s.
        0030: 14 24 63 6e 3d 28 e5 42  20 8a f2 15 8f
06 20 09  .$cn=(.B ..... .
        0040: ef 8a 4b 9f 2a 44 0a 17  39 f4 a6 95 80
86 38 63  ..K.*D..9.....8c
        0050: d9 b0 00 71 50 0b 7d b3  65 cf cb da 93
d8 76 2c  ...qP.}.e.....v,
        0060: 48 fe 74 65 63 45 0c 38  c9 ac b8 d6 58
8b 2b f4  H.tecE.8....X.+.
        0070: ef 4a 2a c2 24 5d c4 82  c3 6a 1e fe b5
64 40 8d  .J*.$]...j...d@.
        0080: 16 3e 5a 52 bb d0 a8 8c  86 1b 71 fb cc
00 54 d5  .>ZR......q...T.
        0090: af dd 30 77 5c 16 c5 56  c4 94 e3 60 10
93 8d d9  ..0w\..V...`....
        00a0: a9 89 4d 83 e5 19 34 c9  e7 44 b1 a2 aa
61 4e 58  ..M...4..D...aNX
        00b0: d0 6c a6 93 68 90 0c 76  38 e9 52 d9 49
dd 13 3d  .l..h..v8.R.I..=
        00c0: 9c b0 20 d8 a1 cf d2 9e  da 79 11 ab 81
96 ea 45  .. ......y.....E
        00d0: 28 f7 02 36 8d 94 6d 55  1b 8f 7c 74 a1
12 44 63  (..6..mU..|t..Dc
        00e0: b9 06 7f bd 8a 2e d9 a2  6a c4 28 b2 ee
38 03 39  ........j.(..8.9
        00f0: eb 52 4f 0b a2 0c a6 41  ef 8a 87 a3 33
6a fb 11  .RO....A....3j..
        0100: 46 99 61 94 ca e2 a1 68  1f 7e dd 9f 26
6a ec ad  F.a....h.~..&j..
        0110: 71 5c 9d ed 64 0c a5 57  80 29 f0 a3 94
70 46 0d  q\..d..W.)...pF.
        0120: 28 cc 13 10 a3 1d 8a a9  90 3a f1 4f 78
f7 20 2d  (........:.Ox. -
        0130: 1e 3d 85 5f 41 89 1c 2e  63 77 8e 32 31
4f 45 79  .=._A...cw.21OEy
        0140: 10 28 52 a1 7a d4 ab 81  2c 93 c8 88 06
ce 0f 19  .(R.z...,.......
        0150: c5 2b 31 f2 b6 b4 59 07  a9 02 86 c0 4e
4e c8 d5  .+1...Y.....NN..
        0160: 30 0f a8 a5 ca c6 c4 49  1f cc 3a 71 51
78 f4 01  0......I..:qQx..
        0170: 27 bc 5d bf ea 4e 4f 19  c5 58 d3 a5 8f
04 32 fe  '.]..NO..X....2.
        0180: 62 ab 99 03 42 cb 3c 01  9a 3d 99 3f 4a
a9 3c f0  b...B.<..=.?J.<.
        0190: ed 0a 91 e4 8a 7a 80 dd  c8 c8 b8 8c 6e
34 f9 65  .....z......n4.e
        01a0: 81 23 00 c7 b8 fa 8a b1  dc 61 be 86 16
c7 96 08  .#.......a......
        01b0: 22 a4 fe d3 8e 15 0c b1  00 4d 43 6d 30
11 b5 68  "........MCm0..h
        01c0: d0 06 30 e7 3e d4 f9 3c  ab b8 83 aa 85
cf 6a a4  ..0.>..<......j.
        01d0: 90 ae 36 28 21 40 12 6e  41 e8 71 d2 a1
be 7b 65  ..6(!@.nA.q...{e
        01e0: 99 54 ae e5 ef 8a 00 64  93 5a 80 12 15
de c3 9c  .T.....d.Z......
        01f0: 7a 54 50 4f 15 c4 fc c6  06 29 e8 05 f8
ee 61 49  zTPO.....)....aI
        0200: c2 6c 5f ad 52 bd ba 59  26 29 12 ed 7e
c7 d6 b2  .l_.R..Y&)..~...
        0210: e4 b3 b8 ca 7f 68 96 64  74 98 70 38 e6
aa 6d 73  .....h.dt.p8..ms
        0220: 20 53 ca f6 35 6a 4b a0  3d 47 25 ac 8c
5f 7f 07   S..5jK.=G%.._..
        0230: de ad 6c 86 18 fe 6c 64  0e 0d 5b 26 2a
c4 91 4c  ..l...ld..[&*..L
        0240: e5 10 c6 bc 8e fe b4 92  97 9c e4 2e 1c
7a d2 04  .............z..
        0250: 40 37 88 c8 5c 6f ef ed  56 52 29 c4 41
a2 93 19  @7..\o..VR).A...
        0260: eb cd 03 28 ac 6f 6e ca  15 be f7 43 4f
c2 89 30  ...(.on....CO..0
        0270: 54 73 d6 96 e8 69 d8 1d  d2 49 42 b0 c4
6b da 92  Ts...i...IB..k..
        0280: 47 50 bb 4a 90 87 b5 4a  7a 0d 2b b1 90
ac 87 22  GP.J...Jz.+...."
        0290: 1c 85 14 38 08 0a e0 99  4f a5 59 4e 9d
88 22 72  ...8....O.YN.."r
        02a0: 99 69 17 7b 8e 83 d2 a5  4d 87 e7 6c ee
3d aa 2c  .i.{....M..l.=.,
        02b0: 4f 91 38 b8 50 09 2b 8d  a3 f3 aa b1 ca
24 90 bb  O.8.P.+......$..
        02c0: 7d d1 d0 55 72 92 38 dc  e1 89 7c 0c f4
14 b1 4c  }..Ur.8...|....L
        02d0: 7c cc 48 40 6f e1 a9 69  a5 a0 c9 43 40
f9 5d df  |.H@o..i...C@.].
        02e0: 3f 73 57 61 82 3d ab b9  c1 f6 a8 f7 99
4e 29 04  ?sWa.=.......N).
        02f0: 91 c4 24 0a d3 61 7b 0e  d4 f6 82 de 4c
46 58 79  ..$..a{.....LFXy
        0300: 9e b4 a9 a9 b7 76 09 26  25 c5 bf 96 44
68 40 38  .....v.&%...Dh@8
        0310: eb 48 96 e8 61 d8 f2 0e  bd 6b 67 a2 07
65 b0 e5  .H..a....kg..e..
        0320: b5 8d 57 6c 6c 0f 6e 69  d6 da 79 8d ca
02 a3 7f  ..Wll.ni..y.....
        0330: 7a 85 79 2b 87 30 d9 2d  22 8e 6f 28 c9
c0 ea 4d  z.y+.0.-".o(...M
        0340: 42 d6 f0 2b 12 25 03 07  a5 5c 76 26 4c
94 47 1b  B..+.%...\v&L.G.
        0350: ca 36 37 6a 55 85 4a ba  33 e1 7d 68 7a
01 1f d9  .67jU.J.3.}hz...
        0360: e3 29 b8 49 c0 ab 11 db  42 53 29 20 e7
a9 a1 6a  .).I....BS) ...j
        0370: 80 64 56 f0 23 30 f3 77  13 52 c5 6b 12
12 d3 38  .dV.#0.w.R.k...8
        0380: 20 f4 f6 a4 9d c0 23 5b  67 25 55 f1 52
49 6d 66   .....#[g%U.RImf
        0390: 54 2b 4b 96 1e 94 3b df  41 a4 ac 29 b5
8b 61 2b  T+K...;.A..)..a+
        03a0: dc 74 35 0b e9 e8 e8 8b  1b e0 e7 9a a2
49 64 b0  .t5..........Id.
        03b0: 40 84 89 49 65 f5 a5 8a  d6 07 40 cc 70
de d5 9c  @..Ie.....@.p...
        03c0: 9b 29 59 20 86 d3 64 8c  77 e4 54 7f 66
f9 cb b9  .)Y ..d.w.T.f...
        03d0: cb 76 aa dd 68 0e c3 2e  6d e4 91 90 2f
43 48 2d  .v..h...m.../CH-
        03e0: d4 2b 72 72 9d 7d 2a 84  84 60 f2 14 60
70 a7 8c  .+rr.}*..`..`p..
        03f0: 52 cb                                   
         R.
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 6a 80 04 00 e1 bb 0a 9e  62 9d b6 42 35
9b 46 e0  j.......b..B5.F.
        0010: 00 55 3d aa 65 81 b7 84  f3 0e d2 38 aa
93 48 96  .U=.e......8..H.
        0020: 86 ce 24 85 76 c4 d8 03  a8 a0 b2 cf 00
13 12 3d  ..$.v..........=
        0030: 2a 39 d1 24 51 42 c6 42  a8 7e 61 d2 a6
4b 2f 35  *9.$QB.B.~a..K/5
        0040: 77 1c 2b af eb 55 7b a1  a2 59 2d e5 2a
37 05 09  w.+..U{..Y-.*7..
        0050: 8e b5 4e 68 78 01 9c 60  52 69 f4 02 35
78 f9 0a  ..Nhx..`Ri..5x..
        0060: d9 6a 7c 36 6a fb 98 0e  69 dc 64 6d 6e
47 c8 41  .j|6j...i.dmnG.A
        0070: 2e 4d 39 84 9b 7c b0 bc  ad 25 24 c0 5b
28 26 69  .M9..|...%$.[(&i
        0080: 31 8c 21 ea 7d 2b 4e 3d  32 37 94 29 97
2a 7b 9a  1.!.}+N=27.).*{.
        0090: ce 4d f3 59 01 56 ee d6  48 ee 0c 68 bb
91 7a 13  .M.Y.V..H..h..z.
        00a0: 55 de 39 01 07 cb 04 e7  a5 69 ca ac 05
a1 68 5d  U.9......i....h]
        00b0: 97 20 02 d5 56 f1 5a de  e4 2a a8 61 e8
29 72 f7  . ..V.Z..*.a.)r.
        00c0: 26 4a fb 11 36 f7 94 83  0b 6d 23 b0 a9
e2 4d aa  &J..6....m#...M.
        00d0: aa e9 83 db 34 ee 9e 83  4a c8 90 c7 10
46 66 ce  ....4...J....Ff.
        00e0: 7d 29 b0 08 76 67 69 34  3d 63 61 8f d9
1b e0 86  })..vgi4=ca.....
        00f0: 19 3d 07 a5 56 31 4a 93  b0 8d 49 6f 4a
21 1b 21  .=..V1J...IoJ!.!
        0100: 13 4e 24 8a 14 91 7f d6  9e ab 4e 8e 46
55 2d bb  .N$.......N.FU-.
        0110: 2c 3b 53 b2 43 42 9b 96  8e 30 41 1b 8d
4b f6 c3  ,;S.CB...0A..K..
        0120: 1d b8 39 e4 f7 a7 61 09  f6 b6 21 58 63
eb 44 b7  ..9...a...!Xc.D.
        0130: af 12 f3 86 06 a5 c6 e0  9a 64 71 5e 23
62 42 9c  .........dq^#bB.
        0140: 9e 29 05 d4 7f 69 09 22  8c 9e 98 a6 a2
90 16 27  .)...i.".......'
        0150: 98 06 f9 f6 ed a8 61 b9  47 7c 28 03 6f
7a 60 5a  ......a.G|(.oz`Z
        0160: 6d 45 11 86 d5 04 d4 4f  7e 89 20 dc 80
66 84 86  mE.....O~. ..f..
        0170: 2a 6a 39 94 b6 d1 e9 53  1b c0 0e f0 06
29 58 43  *j9....S.....)XC
        0180: a4 94 00 65 65 e4 8e 82  b1 5b 7a 4d e7
05 3c 9e  ...ee....[zM..<.
        0190: 86 8b a7 a0 0b 75 24 88  44 c9 dc 72 29
b0 4e 63  .....u$.D..r).Nc
        01a0: 8f 7e 72 5b b7 a5 3d 82  c4 66 66 24 95
42 6a cd  .~r[..=..ff$.Bj.
        01b0: bb 17 dc c1 30 b8 a5 a3  19 59 ee e5 2a
c9 04 7c  ....0....Y..*..|
        01c0: 0e a6 9f 04 ce a0 2e c2  49 e8 45 27 24
b4 0b 36  ........I.E'$..6
        01d0: 5c b4 b5 69 b0 db f0 3b  e6 ad 35 b2 2a
b2 b4 83  \..i...;..5.*...
        01e0: 1d a9 dc 45 19 2d c4 2e  ac 58 3f a6 3b
53 24 12  ...E.-...X?.;S$.
        01f0: b4 df ba 61 b6 98 f4 16  18 65 76 d8 0e
3d 4d 58  ...a.....ev..=MX
        0200: 16 4f bc 88 8f cc 3a 8a  8e 7d 6c 08 9d
2c 2e 4c  .O....:..}l..,.L
        0210: 79 03 be 39 a8 e4 82 58  b2 ae a3 e9 eb
4d 58 ab  y..9...X.....MX.
        0220: a2 01 14 e1 c1 c0 09 d8  52 c9 04 d2 3e
55 39 c5  ........R...>U9.
        0230: 3b a2 06 a5 a5 c3 82 a0  e0 0a 98 5b b0
65 57 04  ;..........[.eW.
        0240: f1 40 58 86 e5 26 86 06  7d a0 44 3a 54
70 ca 8d  .@X..&..}.D:Tp..
        0250: 10 42 d9 53 c9 a5 cb ad  c6 86 25 d3 20
60 23 60  .B.S......%. `#`
        0260: b9 e2 9a f3 3b a6 00 aa  06 9a 2d 44 c7
ec 85 88  ....;.....-D....
        0270: 04 2d 3e 2b d1 e5 06 31  f1 ef 48 06 3c
d0 48 46  .->+...1..H.<.HF
        0280: 3a 77 02 9b 21 45 f9 a3  25 45 09 58 45
94 88 4a  :w..!E..%E.XE..J
        0290: 13 cb 3d 7a 9a 9e 4b 1d  e4 10 e3 2b fc
34 b9 90  ..=z..K....+.4..
        02a0: d3 b1 04 9a 3c b3 b6 ef  37 62 8e 9b 69
0e 95 21  ....<...7b..i..!
        02b0: 84 87 71 91 d0 d3 4e e3  d0 59 b4 b2 2d
82 3c 83  ..q...N..Y..-.<.
        02c0: 03 a5 42 da 52 b4 63 33  1d c0 50 ef d0
48 a9 f6  ..B.R.c3..P..H..
        02d0: 65 86 dc 86 7d c6 a8 66  48 59 84 64 9a
61 61 63  e...}..fHY.d.aac
        02e0: b7 95 c0 6c 95 cd 59 8a  09 37 61 d8 9c
52 64 38  ...l..Y..7a..Rd8
        02f0: 26 58 b1 79 3e d2 4e dc  af 6a bd 73 79
2c 44 1c  &X.y>.N..j.sy,D.
        0300: 06 5f 6a 63 4a da 0d 97  58 62 80 c7 16
dc 75 cd  ._jcJ...Xb....u.
        0310: 3a 3d 59 9e 32 cc 98 3d  bd e8 43 2b ff
00 69 48  :=Y.2..=..C+..iH
        0320: df 30 88 05 a5 6d 59 db  19 87 6a 0e b4
ac 4a b9  .0...mY...j...J.
        0330: 31 d4 a2 ca 34 71 64 1f  41 53 5c ea e1
61 45 30  1...4qd.AS\..aE0
        0340: fc a7 da 8e 54 ca 22 92  72 ec ad 14 7b
50 d4 52  ....T.".r...{P.R
        0350: 5e bf 9c 04 71 64 0f 6a  2c 80 b6 97 4f
b4 16 40  ^...qd.j,...O..@
        0360: 33 da ac 79 a8 10 fe ec  64 d1 ca 80 86
1d 45 16  3..y....d.....E.
        0370: 6f 2c c2 30 3a d4 6d a8  32 19 0f 90 30
7a 71 4e  o,.0:.m.2...0zqN
        0380: c2 7a 0c 83 56 2f 9c 47  b4 0e b4 8b aa
19 18 af  .z..V/.G........
        0390: 95 b4 0f e2 15 36 44 ab  8e 1a aa b8 55
8e 20 c5  .....6D.....U. .
        03a0: 7a e4 71 56 46 a8 23 85  9b c9 07 3d b1
47 2a d8  z.qVF.#....=.G*.
        03b0: b1 90 ea 22 64 de f0 85  c7 43 4d 6b e4
91 41 64  ..."d....CMk..Ad
        03c0: 04 83 c1 a8 74 97 41 92  7d a9 1b fd 6c
63 6f 6a  ....t.A.}...lcoj
        03d0: 7c 97 50 a2 a9 54 1f 85  1e c9 12 c6 33
5b 9c 1d  |.P..T......3[..
        03e0: cb f3 54 92 ad b4 28 01  01 8b 7a 55 a4
32 1c db  ..T...(...zU.2..
        03f0: c7 cc                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 6d 93 de a3 89 10 b3 15  6c 93 da 9e b7
01 91 c1  m.......l.......
        0010: 04 97 04 c8 c3 03 b5 3c  c5 6c 49 32 36
47 40 2a  .......<.lI26G@*
        0020: 66 52 57 12 58 e3 8d 01  52 31 da 96 d2
28 e5 43  fRW.X...R1...(.C
        0030: f3 e3 34 41 09 b2 29 ee  11 47 97 d7 1d
cd 47 0a  ..4A..)..G....G.
        0040: 43 e6 6e 2d 90 7a 8a ab  3b 82 1f 04 56
62 77 74  C.n-.z..;...Vbwt
        0050: 6f 98 76 ab 69 05 ac 6a  cf c6 e6 1d a9
35 d4 0c  o.v.i..j.....5..
        0060: d9 9e 18 1f ca 9b ab 74  35 1c d3 c5 b7
69 5c 11  .......t5....i\.
        0070: f7 5a 9a 77 15 ac 3a ca  48 2e 13 6d c9
00 8e 98  .Z.w..:.H..m....
        0080: ef 56 1b ec e1 44 49 85  ef 9a 87 0e c5
44 85 ed  .V...DI......D..
        0090: 83 ab 11 2f 3e 95 0b 59  a2 a6 26 90 7f
bb 56 26  .../>..Y..&...V&
        00a0: 6a 5b 47 6a 96 aa 62 20  9f 7a 86 fa e2
dc 46 a1  j[Gj..b .z....F.
        00b0: 40 04 f7 14 a4 ec 22 94  c9 6e a0 14 73
93 d7 35  @....."..n..s..5
        00c0: 3d a3 46 80 bc 87 03 b0  a2 32 6c 87 1d
6e 67 44  =.F......2l..ngD
        00d0: ac e7 93 95 ec 69 e6 30  8e 55 d8 31 6e
95 46 f2  .....i.0.U.1n.F.
        00e0: b1 0c 71 b6 fc 4c 3e 45  35 70 4f 1b 31
2b 1e 42  ..q..L>E5pO.1+.B
        00f0: fa d4 45 6a 2e 5d 2e 49  0c d0 ee 0c bf
28 3d aa  ..Ej.].I.....(=.
        0100: 0b b0 ae 4c 91 ae d7 1d  e9 bb d8 57 63
a2 78 a0  ...L.......Wc.x.
        0110: 50 4a 82 ec 3a 9a 8a 3b  a8 9d f6 b2 02
3b e0 52  PJ..:..;.....;.R
        0120: 8c 7a 83 d4 75 c8 49 b2  6d 93 e5 ef 9a
a5 02 6d  .z..u.I.m......m
        0130: 90 a9 42 05 68 24 b5 25  8e d2 39 64 2f
21 c5 45  ..B.h$.%..9d/!.E
        0140: e4 2f 9e c7 69 64 1c 66  93 76 2e 69 74
1a b6 e5  ./..id.f.v.it...
        0150: 25 2c a3 f7 67 bd 5b 31  ab a6 41 23 d0
8a 13 b9  %,..g.[1..A#....
        0160: 00 d6 fb f6 a3 b0 dc 3a  1a 46 57 8f 6e
c2 19 c7  .......:.FW.n...
        0170: 71 54 9d 82 e4 32 b4 c6  52 58 b1 f6 a9
1e 26 91  qT...2..RX....&.
        0180: 56 46 dc a3 d2 a2 5b 02  1e e0 b2 8d 8c
57 6d 3e  VF....[......Wm>
        0190: 39 e7 c8 ce 40 ec 4d 4a  d0 6d 2e 84 6c
b2 ca e4  9...@.MJ.m..l...
        01a0: 9e 73 51 cd 6c 41 0a a0  b1 ee 7d 2a ee
0a 37 2d  .sQ.lA....}*..7-
        01b0: 5b a1 5c 30 ce 00 e9 4f  69 b0 46 71 83
da 8b 03  [.\0...Oi.Fq....
        01c0: 8d 8a ca 88 b3 3c ac c7  cb fe ed 36 15
dc 1c 23  .....<.....6...#
        01d0: 11 19 a8 8b 60 92 ea 2c  11 95 07 2d 81
da a5 f9  ....`..,...-....
        01e0: 46 10 b1 3e f4 b5 4f 40  d0 9e d2 d9 48
66 03 93  F..>..O@....Hf..
        01f0: 4d 8e dc ee 27 22 a9 bb  21 58 b2 91 c9
28 20 64  M...'"..!X...( d
        0200: 32 f4 14 8a 92 2c c0 9c  86 f4 a7 17 74
04 cd 14  2....,......t...
        0210: b1 3b ef 04 ab 0e 08 a2  3b 6f dd 61 5b
e6 3d bd  .;......;o.a[.=.
        0220: 2a 5c b5 b0 58 90 45 34  51 11 d4 d0 2d
a5 78 32  *\..X.E4Q...-.x2
        0230: 1b 0c 7d 6a ae 90 11 cf  67 32 c4 b8 97
93 ef 55  ..}j....g2.....U
        0240: ed 59 90 34 32 b8 00 77  f5 a6 9d c4 3c
34 45 b2  .Y.42..w....<4E.
        0250: ee 15 3b 54 af 8d aa 7c  c1 c7 43 45 81
30 99 c3  ..;T...|..CE.0..
        0260: 3a 62 61 93 d6 89 56 2c  00 67 c1 a4 d5
ca be 84  :ba...V,.g......
        0270: 53 2c 67 0a 25 fc 68 86  10 11 bc d9 01
07 ee d2  S,g.%.h.........
        0280: e5 56 24 5b 78 3c a6 ce  fe 5b 81 ed 49
25 bc 91  .V$[x<...[..I%..
        0290: ab 1f 3f 71 f6 a7 62 95  89 22 92 46 b7
30 ee 24  ..?q..b..".F.0.$
        02a0: fa d3 56 c9 08 f9 df 2f  8e 94 d8 8a ab
64 62 b8  ..V..../.....db.
        02b0: 2e 8b 95 14 e8 2e 26 2e  e1 54 62 92 13
26 90 b9  ......&..Tb..&..
        02c0: 84 c8 c4 2b 8e f5 0c 92  48 a1 59 08 23
bd 16 42  ...+....H.Y.#..B
        02d0: 6e c4 be 7c ac 80 29 08  a6 9f 05 d4 ac
db 72 15  n..|..).......r.
        02e0: 57 bd 3b 0d 0d 96 f2 4c  91 21 e7 d4 51
67 74 65  W.;....L.!..Qgte
        02f0: 05 71 d3 bd 00 2f da 8c  52 ed 75 24 f6
a9 54 c7  .q.../..R.u$..T.
        0300: e7 09 09 c9 34 0c 96 3b  a1 e6 b0 0a 31
55 ef 2e  ....4..;....1U..
        0310: 5a 6c 18 d3 1b 4f 4f 5a  85 1b 3b 88 a7
34 93 93  Zl...OOZ..;..4..
        0320: ca e3 3d b1 52 5a ca 48  6c 8d a7 d0 8a
77 40 32  ..=.RZ.Hl....w@2
        0330: 38 f3 71 bd 0f 4e d5 70  4f 24 6d e6 00
19 ba 55  8.q..N.pO$m....U
        0340: 26 34 36 46 96 46 0e c0  6e fe 55 55 e2
26 5c 86  &46F.F..n.UU.&\.
        0350: e5 ba e2 80 15 6d 25 79  58 15 27 8e 31
50 2d ac  .....m%yX.'.1P-.
        0360: c1 8a b6 48 cf 22 a5 49  0a c4 e6 d9 ce
04 79 db  ...H.".I......y.
        0370: de a4 92 c3 0a 10 33 16  6a 77 b8 24 89
6d 6c a4  ......3.jw.$.ml.
        0380: 8d 48 75 ca d2 47 a7 96  9c 9c 71 fc a8
b8 0a 34  .Hu..G....q....4
        0390: e7 92 56 8c b6 41 a9 16  c3 cb 06 21 80
7d 69 39  ..V..A.....!.}i9
        03a0: 76 01 b2 69 92 60 14 23  8a 94 d8 33 95
59 31 91  v..i.`.#...3.Y1.
        03b0: d0 d3 43 1b 1d 86 d9 09  23 81 56 20 d2
43 16 91  ..C.....#.V .C..
        03c0: 98 ed 1c 81 49 ca c0 ac  4b 6f 6b e6 cb
96 6c 01  ....I...Kok...l.
        03d0: c0 06 99 73 04 49 21 67  71 9e d4 d6 a0
ec 82 1b  ...s.I!gq.......
        03e0: 5b 37 ca b4 c3 9e a3 35  1c f6 96 48 0e
24 5d a3  [7.....5...H.$].
        03f0: b5 0d                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 5c 69 93 db 5b da bc 20  23 ad 41 3c 56
f1 c8 c8  \i..[.. #.A<V...
        0010: 8d f2 e3 93 59 c6 0d 32  6e 57 b6 58 90
ba a8 1b  ....Y..2nW.X....
        0020: 0f 53 48 64 11 30 10 a0  68 cf 7a 12 d7
51 dc 91  .SHd.0..h.z..Q..
        0030: 8c 9c 32 80 17 d2 aa c9  6c 66 dc de 61
53 e9 56  ..2.....lf..aS.V
        0040: f4 d8 56 ea 10 d9 ba db  1f 9b 2c 4d 2b
da 30 55  ..V.......,M+.0U
        0050: 40 fb 01 ea 69 dc 04 b6  12 5b 33 04 6f
30 0e f5  @...i....[3.o0..
        0060: 25 a5 d5 c4 77 5b c8 18  6a 1a 40 5f 6d
42 e1 9b  %...w[..j.@_mB..
        0070: 6e 30 a3 a0 15 1d c5 d0  95 42 63 f7 87
bd 25 04  n0.......Bc...%.
        0080: 81 6c 56 9e 67 40 a0 b7  22 ac 89 cb 42
0a 1f 9c  .lV.g@.."...B...
        0090: 75 14 ec 04 7e 7b 36 01  f9 4d 0b 3b 34
c4 03 93  u...~{6..M.;4...
        00a0: 8e b4 c0 8a ef 2d 18 49  1f 23 d0 55 58
22 85 32  .....-.I.#.UX".2
        00b0: e0 8c 0a 2f d0 69 96 c4  aa 17 1b 41 1e
b8 a8 7c  .../.i.....A...|
        00c0: b5 61 e6 01 b4 0e d4 03  77 1f bc 38 0a
8b 8f 5e  .a......w..8...^
        00d0: 29 67 8c 08 94 ff 00 0f  a0 15 2a ed dc
57 21 58  )g........*..W!X
        00e0: 11 00 54 5c 06 ea 4d 3e  68 c1 5d 80 7c
a6 92 95  ..T\..M>h.].|...
        00f0: dd 80 75 bc c6 18 3c a8  d4 91 9e b4 b1
93 bc ee  ..u...<.........
        0100: 7c 66 9f 28 16 20 91 e3  53 18 7c af 63
49 14 93  |f.(. ..S.|.cI..
        0110: 4c cf 1b 83 b5 7a 1a 7a  20 18 eb 24 e3
1f 36 57  L....z.z ..$..6W
        0120: a0 ab 10 da c8 c3 2e 31  81 45 c7 60 3a
5a 5c 36  .......1.E.`:Z\6
        0130: ec e0 d2 c9 a4 c6 ab c3  0f 32 b3 bb 6e
c0 12 69  .........2..n..i
        0140: c7 cb 5d 8c 09 5e c2 a3  fb 13 02 07 1f
37 5a d2  ..]..^.......7Z.
        0150: f6 11 27 d8 04 70 30 56  c1 a8 52 c1 84
38 66 f9  ..'..p0V..R..8f.
        0160: 4f 73 49 49 31 8a 6c 48  5c 60 30 34 47
64 dc 2f  OsII1.lH\`04Gd./
        0170: cb f4 aa 4a c2 19 3d a4  6b f2 86 05 bd
28 96 d8  ...J..=.k....(..
        0180: 3a ed e3 8e b4 00 e4 b4  8d 42 f9 45 40
f4 34 f7  :........B.E@.4.
        0190: b3 cc 67 24 60 77 a4 dd  86 36 da 16 91
0a 3b 61  ..g$`w...6....;a
        01a0: 7b 1a 12 c5 c9 c3 3a 80  3a 53 42 1d e4
08 dd 96  {.....:.:SB.....
        01b0: 57 1d 3e 5a 8b c9 96 42  00 70 05 2b 81
04 d6 ef  W.>Z...B.p.+....
        01c0: 1c ea 14 ee 07 ae 28 75  75 93 27 e6 8c
76 a6 08  ......(uu.'..v..
        01d0: 82 29 23 7d c1 57 68 27  9a 49 a4 8a 3c
c6 ac 00  .)#}.Wh'.I..<...
        01e0: 35 2d 5c 09 e0 92 d8 22  a4 6c 32 7a 9a
b1 b2 08  5-\....".l2z....
        01f0: 4e 1e 41 83 49 26 80 99  6d a0 96 3d a2
50 07 5e  N.A.I&..m..=.P.^
        0200: b5 2c 76 f6 62 30 8c eb  93 e9 4f 56 32
59 6d 2d  .,v.b0....OV2Ym-
        0210: f0 10 c8 30 07 06 a3 4b  7b 37 8f 1e 60
f7 a2 cc  ...0...K{7..`...
        0220: 34 09 2d 6c 5a 23 b6 41  81 de 96 28 ad
9b e7 32  4.-lZ#.A...(...2
        0230: 00 80 75 35 5a 88 ae d0  c0 b1 33 c6 c3
04 f5 35  ..u5Z.....3....5
        0240: 58 30 86 4c f5 5f 51 de  93 40 34 dd c1
91 84 23  X0.L._Q..@4....#
        0250: d6 94 ce 8a fb 44 63 cb  61 d4 d3 01 ad
32 a9 11  .....Dc.a....2..
        0260: f9 64 8a 55 ba 54 9c 22  46 7d f1 da 80
b1 4d e5  .d.U.T."F}....M.
        0270: 12 ce f1 94 cf 3c 62 ac  5b b0 04 ab 46
36 8a 01  .....<b.[...F6..
        0280: 96 19 2d 66 42 51 76 91  dc 52 47 34 71
8c 15 cb  ..-fBQv..RG4q...
        0290: 1e 94 9d c1 08 f1 db b4  a8 f3 fc d8 e7
15 1d f3  ................
        02a0: 47 31 dc 22 0a 83 a0 c5  09 0c ab e5 45
c0 55 c5  G1."........E.U.
        02b0: 4d 73 1c 6a 91 f1 8f f6  a9 3b a1 15 18
ab cd c3  Ms.j.....;......
        02c0: e2 31 dc 54 be 54 2e ac  c6 5c e3 b9 ef
4f 50 1a  .1.T.T...\...OP.
        02d0: 26 53 1f ee 06 71 c1 a7  2c 60 46 85 c6
73 d2 86  &S...q..,`F..s..
        02e0: ec 05 39 44 6f 72 44 99  51 9e 31 57 a4
74 08 9b  ..9DorD.Q.1W.t..
        02f0: 93 01 7a 53 43 b1 48 c7  2c 53 79 41 f2
1b b7 a5  ..zSC.H.,SyA....
        0300: 59 5d 34 8d 98 97 af 52  69 58 2e 30 44
7e d0 d0  Y]4....RiX.0D~..
        0310: ef dc 87 f8 bd 28 9e 29  63 3e 5c 2c 1d
7b 9a 16  .....(.)c>\,.{..
        0320: 88 d2 ee 4a c8 8e 3f 31  06 c7 5e 01 eb
52 c9 1b  ...J..?1..^..R..
        0330: 4a 36 96 c6 7a 53 7a a3  31 b7 01 22 da
8c 0b e0  J6..zSz.1.."....
        0340: 73 56 2d 1e d4 46 1d a3  00 8e 95 10 4e
d6 65 36  sV-..F......N.e6
        0350: 9a 2c 79 b6 c0 ee 52 02  b7 5a 88 4b 68
03 02 c0  .,y...R..Z.Kh...
        0360: 8c d5 58 84 3a e2 5b 24  41 e8 7b d3 77
59 08 b7  ..X.:.[$A.{.wY..
        0370: 79 80 83 fc 35 32 87 31  ad e3 60 8d 6d
5a d5 cb  y...52.1..`.mZ..
        0380: c8 00 3d 01 a8 ed 6e 21  b7 b7 71 2e 36
76 14 46  ..=...n!..q.6v.F
        0390: 1c a4 37 71 e2 4b 59 23  57 03 9f 41 da
9b 14 b6  ..7q.KY#W..A....
        03a0: a9 b8 29 c9 3d a9 25 27  b9 23 8c f6 c8
0b f0 48  ..).=.%'.#.....H
        03b0: ed 4a 97 f6 af 1e 0a e0  0a 2d 2d 82 2f
b9 5e ee  .J.......--./.^.
        03c0: 7b 4d a4 93 c7 b5 49 1d  d5 a9 86 31 9d
e7 b1 f4  {M....I....1....
        03d0: a6 a0 32 58 a4 85 1f 0b  d2 97 cf 80 c8
70 d8 f6  ..2X.........p..
        03e0: ab 45 73 31 56 68 23 dc  7a 83 d4 0a 44
92 da 48  .Es1Vh#.z...D..H
        03f0: 89 44                                   
         .D
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: e4 1a 52 76 15 ee f5 23  65 8a 47 21 46
14 75 e2  ..Rv...#e.G!F.u.
        0010: 83 14 72 8d 91 36 df 5a  68 24 f5 2b cd
6e fe 5f  ..r..6.Zh$.+.n._
        0020: 96 8d c0 ea d5 14 76 f2  e3 6a 36 54 77
34 ae ae  ......v..j6Tw4..
        0030: 2b 0f 8a ee e6 26 29 8e  3b 54 29 2d ce
fc e0 8e  +....&).;T)-....
        0040: 6a 5b bb b0 d1 75 6f 27  85 c1 dc 0e 7b
55 f7 bf  j[...uo'....{U..
        0050: 75 8b 3b 17 71 ab 4a c0  a2 d8 e7 be 69
21 8d 80  u.;.q.J.....i!..
        0060: 1b c7 6a 8a 6b 99 4b ee  51 b4 77 c5 27
61 c9 58  ..j.k.K.Q.w.'a.X
        0070: 64 b7 8d 80 aa 49 6a 95  66 64 8f 0e d8
18 eb e9  d....Ij.fd......
        0080: 43 49 e8 49 00 98 38 39  94 b0 a8 a5 63
2e 07 96  CI.I..89....c...
        0090: 47 b8 a4 b4 d0 08 ee ad  d0 46 b8 24 b7
a5 4b 6f  G........F.$..Ko
        00a0: 18 31 0d ea d4 a4 ec 24  86 cb 67 e6 bf
ca 4a 81  .1.....$..g...J.
        00b0: df 35 1b ed 8f 11 e0 bf  bd 35 24 31 c8
23 7c 04  .5.......5$1.#|.
        00c0: 53 bb a1 ab 97 71 c7 1c  6a 4e 77 f6 c5
12 bf 40  S....q..jNw....@
        00d0: 20 49 0b 1f 9d 5b 38 ab  49 03 24 5b c8
24 f6 15   I...[8.I.$[.$..
        00e0: 31 bf 51 13 45 6b 2a 28  75 50 01 e4 8a
25 84 48  1.Q.Ek*(uP...%.H
        00f0: cb e4 48 33 de a9 b0 26  10 95 8f 62 9c
fa d4 26  ..H3...&...b...&
        0100: c5 a3 62 d1 9c d2 52 5b  0c ad 35 85 dc
87 9c 04  ..b...R[..5.....
        0110: 6e d5 42 ea 29 ad e4 08  ff 00 73 da ac
56 b8 8f  n.B.).....s..V..
        0120: 27 99 b5 23 07 72 d4 f0  48 a4 81 32 90
7a 62 81  '..#.r..H..2.zb.
        0130: 5c 9d ad 4c c4 f9 6b fb  ba b9 69 a6 95
81 88 eb  \..L..k...i.....
        0140: d8 54 b1 de e5 2d 48 5c  5b 6d fd d8 60
7b d3 e1  .T...-H\[m..`{..
        0150: 31 c8 8a b2 0d af 8c e0  55 00 f5 96 14
70 ae 70  1.......U....p.p
        0160: 07 7a 72 cb 68 f2 7e ec  e0 0e 69 24 03
9a ee ce  .zr.h.~...i$....
        0170: 69 17 71 00 ad 4c 4d 8d  c3 07 04 2b 74
a8 74 ae  i.q..LM....+t.t.
        0180: 17 16 da d2 cc 4c 5d 65  ce 7b 54 e2 ca
04 dc db  .....L]e.{T.....
        0190: c1 cf 4a 95 4f 97 5b 8d  68 42 96 a1 4b
30 3f 29  ..J.O.[.hB..K0?)
        01a0: a6 c7 6b 0a a1 6c e0 8f  5a 6a e9 04 99
3c 6c 1a  ..k..l..Zj...<l.
        01b0: 30 a8 c1 49 aa d7 09 24  52 01 18 0d ba
9c 63 6d  0..I...$R.....cm
        01c0: c4 88 52 4b 84 3b 1e 3d  b8 e7 a7 5a 4f
b7 4e 26  ..RK.;.=...ZO.N&
        01d0: f9 e3 1e 50 ef 56 84 fc  86 4f 79 3a a1
20 7c a7  ...P.V...Oy:. |.
        01e0: a5 39 6f 1d 21 07 07 71  eb 4c 68 64 52
4b bc 3e  .9o.!..q.LhdRK.>
        01f0: e2 2a 59 4c 92 9d ea 48  a0 09 6d e7 75
c2 ca 4e  .*YL...H..m.u..N
        0200: da 80 dc ce 2e 0a a9 3e  5f 6a 57 01 c7
ed 2e c7  .......>_jW.....
        0210: 04 e2 a7 8e e6 e8 45 91  90 05 17 40 46
d2 cf 22  ......E....@F.."
        0220: e6 30 72 7a d4 4d 6f 24  b1 e6 46 6c 8e
d4 5c 08  .0rz.Mo$..Fl..\.
        0230: 96 d3 07 2b bb 22 a2 68  0e ec 90 c6 8b
8c d0 85  ...+.".h........
        0240: 62 89 01 da 41 35 61 1a  c8 b2 82 0f 1d
68 0d 01  b...A5a......h..
        0250: c4 01 98 c6 07 97 8e 95  0c 2b 08 8d 9d
4e 57 b2  .........+...NW.
        0260: d0 d5 c1 f9 15 d6 76 67  39 4e 07 6a 53
7d 0f 96  ......vg9N.jS}..
        0270: 43 47 82 29 a1 0f b6 ba  49 62 23 6e 05
12 4f 0c  CG.)....Ib#n..O.
        0280: cb b4 82 02 f4 34 9a 02  d2 0b 53 6e 59
7e 52 05  .....4....SnY~R.
        0290: 62 4c d2 19 77 a0 f9 47  43 4f 61 8f fb
54 cf 82  bL..w..GCOa..T..
        02a0: 89 82 3d 29 aa 67 57 df  20 c3 7a 54 39
76 02 75  ..=).gW. .zT9v.u
        02b0: dd 71 70 a2 61 b4 0a d6  48 a0 52 bb 48
1d aa c9  .qp.a...H.R.H...
        02c0: ba 1f 2c 16 72 10 a0 fe  f3 da a3 16 f6
b6 c4 ae  ..,.r...........
        02d0: 0e 71 c9 a9 51 b1 a5 e2  d1 59 a2 b7 76
e8 70 69  .q..Q....Y..v.pi
        02e0: 0d bd ba f0 ab f5 c5 2b  6a 49 61 12 cf
c8 da 78  .......+jIa....x
        02f0: a8 4c b6 d1 26 54 02 07  6a 76 62 1e f7
56 fb 43  .L..&T..jvb..V.C
        0300: f9 40 0c 76 14 b1 dc c4  b1 f9 8d 18 da
7a 2d 11  .@.v.........z-.
        0310: bf 50 26 32 5b 5c 2a b1  4d 87 d2 a1 96
7b 55 97  .P&2[\*.M....{U.
        0320: 10 a6 fd a3 9a 8f 66 ef  7b 80 82 ea 05
e4 47 8f  ......f.{.....G.
        0330: c2 9a c6 d0 9c a9 cb 1e  b5 a8 5c 36 db
44 bb b9  ..........\6.D..
        0340: db 42 4b 18 7c 96 c0 3d  30 2a 79 40 12
50 8c c4  .BK.|..=0*y@.P..
        0350: 12 7d 38 aa b7 77 d3 c5  32 ec 39 43 d6
ac 62 3e  .}8..w..2.9C..b>
        0360: a5 2b 48 02 b6 c6 ec 29  8d 73 71 e6 e5
cd 4d c4  .+H....).sq...M.
        0370: 85 8a e6 e5 91 bc b7 f9  f3 d2 95 ef 67
e0 37 de  ............g.7.
        0380: a1 58 62 fd ba 69 08 01  b0 40 fc ea 28
2e 6e 9e  .Xb..i...@..(.n.
        0390: 42 b2 9c 20 e8 3d 69 88  9a 5b c9 d8 31
3f 2e ce  B.. .=i..[..1?..
        03a0: 80 77 a8 ad 5a 67 86 49  5a 5c 39 e8 a4
d4 a9 dc  .w..Zg.IZ\9.....
        03b0: 12 b1 51 cd ca 46 58 36  e6 fa d5 88 a6
91 ed f7  ..Q..FX6........
        03c0: 33 10 47 5c 55 00 b2 2c  92 c0 0c 52 10
dd a9 f6  3.G\U..,...R....
        03d0: ff 00 6a d9 89 18 ed 14  9b b2 01 c6 79
d0 30 51  ..j.........y.0Q
        03e0: c0 1c 53 33 70 51 59 b7  0f 7a 95 3b a0
1b e5 cb  ..S3pQY..z.;....
        03f0: 22 f9                                   
         ".
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 8e c4 b0 a5 8d a4 7c 86  62 a7 b0 a7 17
70 15 65  ......|.b....p.e
        0010: 6b 76 24 b1 67 3d cd 59  42 cc a4 02 09
3d 6a 80  kv$.g=.YB....=j.
        0020: 80 c4 be 76 30 14 54 77  51 c0 70 ac 39
f5 a9 69  ...v0.TwQ.p.9..i
        0030: f4 00 b7 d3 e2 75 dc 84  a8 1d 45 34 59
af 9a 5d  .....u....E4Y..]
        0040: 99 8c 7e b5 0d bd 86 48  23 8d 53 22 4e
3b 0c d2  ..~....H#.S"N;..
        0050: 42 17 25 d8 f0 3a 73 55  f0 88 d1 8a ce
59 80 62  B.%..:sU.....Y.b
        0060: dc 63 80 2a 13 65 22 b9  e0 85 3d aa af
7d 80 68  .c.*.e"...=..}.h
        0070: b5 70 a6 22 87 69 a8 a6  b4 99 46 c4 ce
c1 db 34  .p.".i....F....4
        0080: 6d b8 c9 7e c9 38 b6 02  5e 11 ba 62 9a
90 cf 1a  m..~.8..^..b....
        0090: 18 82 06 1e a6 87 24 22  09 6d 1a 36 55
91 40 0d  ......$".m.6U.@.
        00a0: de a6 30 7c a8 8e 7e 86  b3 d5 b1 a5 72
1d 86 39  ..0|..~.....r..9
        00b0: 8e c6 dc f5 23 48 91 f3  80 5b 1c d6 88
06 41 17  ....#H...[....A.
        00c0: 99 20 96 1c 2b 77 cd 32  59 53 ce 64 cf
5e e2 86  . ..+w.2YS.d.^..
        00d0: 22 7b 78 95 10 23 c9 b5  0f 5a ba 52 cf
cb ca f2  "{x..#...Z.R....
        00e0: ab de 98 ca a6 ea d4 4d  92 07 96 2a 41
75 63 2a  .......M...*Auc*
        00f0: 6f 62 01 14 00 24 b6 4e  87 90 49 f4 a2
e8 d9 dc  ob...$.N..I.....
        0100: c0 23 2e 00 4f 4a ce 50  6c 45 19 62 d3
c2 05 89  .#..OJ.PlE.b....
        0110: cd 52 78 21 1f 28 93 11  9f d2 aa 29 a5
a8 13 a4  .Rx!.(.....)....
        0120: 2b 10 db 09 25 88 ea 7a  1a 7d a5 bc 8d
2e d9 5f  +...%..z.}....._
        0130: 20 73 8a 7b e8 05 e6 b6  b6 67 52 e0 10
3b 0a 8e   s.{.....gR..;..
        0140: e9 20 91 41 6f 95 07 4a  cd f3 5e c0 99
9b e5 b0  . .Ao..J..^.....
        0150: 61 31 3c 8e f4 d5 95 99  9f 24 e3 d4 56
b7 b0 0b  a1<......$..V...
        0160: 6d 13 a8 29 08 2c 0f 53  4a 62 96 03 87
38 dd d3  m..).,.SJb...8..
        0170: 14 16 a5 a5 90 d0 ec ac  52 62 31 8c 83
4e b5 59  ........Rb1..N.Y
        0180: 1d b0 ae 09 3f a5 4b 7c  a1 18 39 12 cf
04 8a c8  ....?.K|..9.....
        0190: 5c fe 55 1d ea 0d b9 1d  3d aa 93 b9 3b
15 00 5c  \.U.....=...;..\
        01a0: 98 d4 e5 a9 92 24 25 43  21 c3 77 14 08
92 7f 29  .....$%C!.w....)
        01b0: 23 8e 47 6d cb fd da 74  76 b0 32 ac c0
65 4f f0  #.Gm...tv.2..eO.
        01c0: 8e d5 2b 71 8f 36 e8 ec  cd 27 2b d8 0e
d4 e3 6e  ..+q.6...'+....n
        01d0: 3c 92 8f 19 2b d8 d2 b6  ba 0e 2d 20 8a
d9 ec c0  <...+.....- ....
        01e0: 38 c8 6e d5 1e d0 b2 19  51 30 dd c1 ab
1c ad 6d  8.n.....Q0.....m
        01f0: 04 09 1c d2 f2 a5 1b d2  a5 48 63 8e 26
50 b9 6f  .........Hc.&P.o
        0200: 7a 99 3b 22 08 cc 11 94  c4 8a 30 d5 2b
59 5b c5  z.;"......0.+Y[.
        0210: 10 31 36 d3 53 16 d8 db  43 ac ed 59 f2
cc e3 6f  .16.S...C..Y...o
        0220: ad 58 36 2b 1b 02 31 cd  57 52 92 d0 70
b5 d9 20  .X6+..1.WR..p..
        0230: 0a 46 5b d6 92 4d 3e 45  de d1 c8 a3 d8
55 12 95  .F[..M>E.....U..
        0240: c7 59 c5 2c 7c 48 17 26  9d f6 63 13 87
00 1c f5  .Y.,|H.&..c.....
        0250: 15 3c da d8 69 6b a8 c4  b7 91 a6 73 c8
43 da 92  .<..ik.....s.C..
        0260: 38 36 39 04 e3 1d 3d 0d  3b 16 9a d8 79
89 25 39  869...=.;...y.%9
        0270: 56 01 87 5a 49 22 68 93  25 83 51 75 72
64 ac 45  V..ZI"h.%.Qurd.E
        0280: 1d b3 4a be 69 18 f4 a8  8a c9 1c df 37
26 84 ee  ..J.i.......7&..
        0290: 4a 76 2e 5a 4d 14 72 13  28 1f 4a 9c 5e
44 cc d8  Jv.ZM.r.(.J.^D..
        02a0: 51 81 52 e1 77 70 bd c7  c7 71 6a 41 6d
81 58 54  Q.R.wp...qjAm.XT
        02b0: 52 cb 6e d1 b9 ea a7 ad  3b 0d 90 db b5
bf 96 c1  R.n.....;.......
        02c0: 53 03 b5 3e ce e5 0f c8  7e 94 3b 06 96
1f 24 1e  S..>....~.;...$.
        02d0: 69 62 30 1b b5 25 ba 4a  89 86 65 6f 7a
51 5d c9  ib0..%.J..eozQ].
        02e0: 23 36 f3 32 99 0b 80 b4  3d b3 08 f7 a1
15 0a 36  #6.2....=......6
        02f0: 77 0b 11 5a 5b 5c a4 aa  c7 1b 49 a9 ef
ec ee 08  w..Z[\....I.....
        0300: dd b9 41 ec 2b 54 ee 84  91 5e 51 71 1a
28 24 03  ..A.+T...^Qq.($.
        0310: 8a 7d ad fc e1 42 11 f3  0e d4 5d 21 92
ad d5 cd  .}...B....]!....
        0320: c4 ac 07 cb b4 60 8a a5  1c 6f 1b c8 e1
ce 7d 05  .....`...o....}.
        0330: 0b 50 14 b5 d6 03 89 30  a7 b5 4a b7 37
39 c6 fc  .P.....0..J.79..
        0340: 2d 16 40 5a 7b 99 a4 54  1e 60 52 29 93
f9 9b 40  -.@Z{..T.`R)...@
        0350: c0 61 dd a9 dc 10 91 84  03 28 54 1e f4
91 c8 8c  .a.......(T.....
        0360: e1 59 46 7b 1a 9d d8 58  b4 97 46 04 65
24 63 d4  .YF{...X..F.e$c.
        0370: 50 fa 8c ed 10 38 0a 83  d3 bd 50 92 b0
d5 9e 49  P....8....P....I
        0380: 00 66 03 61 f5 a8 ae 14  42 7c c5 60 64
3c 00 68  .f.a....B|.`d<.h
        0390: b8 ca f1 88 8b 6d 7c 97  6e 4f b5 0b 02
c3 21 09  .....m|.nO....!.
        03a0: f7 5b af b5 16 02 58 2c  ad f2 4e 41 3d
8d 47 04  .[....X,..NA=.G.
        03b0: 2b 1d c3 29 20 ff 00 2a  97 2b 01 2a 41
f7 88 23  +..) ..*.+.*A..#
        03c0: af 6a bf 1c 91 14 08 ed  f3 01 4e d7 1e
c1 1c f1  .j........N.....
        03d0: b8 da a4 e0 53 de 78 98  7d de 9c 53 6e
c2 bd cc  ....S.x.}..Sn...
        03e0: d7 0c f2 e5 09 50 0f 19  a9 60 7b 89 25
c1 20 28  .....P...`{.%. (
        03f0: e8 d4                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: b9 8a 4a e8 d0 dd 39 8f  0c 55 bd 0d 53
fb 3c ce  ..J...9..U..S.<.
        0010: 0c 65 94 82 68 4e e4 93  46 91 a3 88 65
50 48 e9  .e..hN..F...ePH.
        0020: 53 46 21 57 25 d3 22 84  b5 0b 8e 30 65
1e 55 8f  SF!W%."....0e.U.
        0030: 2b da ab 49 79 14 50 01  b0 97 e9 8a 60
41 2d fa  +..Iy.P.....`A-.
        0040: 3a 28 64 e9 d6 97 ed 70  99 11 42 12 07
71 4b 95  :(d....p..B..qK.
        0050: 01 ad 04 ea eb b5 10 7b  d3 27 9c 27 c8
10 60 d2  .......{.'.'..`.
        0060: e5 04 ac 44 93 2c 76 ed  94 03 3e 95 51
2f 1e 42  ...D.,v...>.Q/.B
        0070: 42 45 c0 ef 47 28 16 23  b9 f9 36 18 f0
7f 9d 21  BE..G(.#..6....!
        0080: 91 98 00 b1 62 aa c0 4a  65 51 16 66 8f
04 55 59  ....b..JeQ.f..UY
        0090: 2e ed 55 49 f2 c9 3e d4  05 88 57 52 b4
77 08 50  ..UI..>...WR.w.P
        00a0: 8e d4 f7 be b2 49 55 10  f0 7b 51 60 2d
ac b6 93  .....IU..{Q`-...
        00b0: b8 8e 26 02 43 d6 a7 3a  4c 2c 7e f0 38
e7 35 0f  ..&.C..:L,~.8.5.
        00c0: 46 31 89 a5 44 8a 48 7e  4d 39 b4 b4 09
96 22 aa  F1..D.H~M9....".
        00d0: e1 72 74 b0 87 ec f8 20  7c dd 29 22 b4
86 23 b5  .rt.... |.)"..#.
        00e0: d7 28 2a 5a b8 9b 1d 0d  ad b8 72 40 0a
9d f3 50  .(*Z......r@...P
        00f0: 5c a5 92 4d e6 3b 64 74  02 9c 60 90 10
de dc da  \..M.;dt..`.....
        0100: c7 0f ee 54 33 11 c5 54  d2 a6 8a 79 3c
b9 39 93  ...T3..T...y<.9.
        0110: b1 a2 5b 68 25 66 6b 08  a1 8d 8b c8 00
65 ef 50  ..[h%fk......e.P
        0120: 4d 77 6b e7 03 29 04 1a  ce 3c cc 60 b2
d9 60 9c  Mwk..)...<.`..`.
        0130: f0 7f 4a 72 3d 9c 63 76  e1 b7 d6 9c 62
d3 1d cc  ..Jr=.cv....b...
        0140: eb cb bb 11 21 04 64 7a  0a ad 2d dd a3
c3 90 08  ....!.dz..-.....
        0150: 03 a0 ad 44 42 97 6a 40  59 30 13 f9 55
c5 bd b6  ...DB.j@Y0..U...
        0160: f2 81 db 95 5e f4 01 5a  7b d8 8f 4c 9c
f4 c5 5f  ....^..Z{..L..._
        0170: b5 96 d5 61 e3 89 0f 5c  d2 dc 09 44 70
98 b0 a4  ...a...\...Dp...
        0180: 12 dd ea 29 a0 8a da 0d  a8 b9 63 d4 d1
b0 18 fe  ...)......c.....
        0190: 5d cb 3b 00 df bb 3d 05  6b db 3c 51 42
91 ba 6e  ].;...=.k.<QB..n
        01a0: 7a 7b 81 3a b4 09 92 07  cd e8 2a 9d da
47 38 f9  z{.:......*..G8.
        01b0: 78 6e c2 80 33 27 b5 70  73 23 00 e3 ee
e2 92 28  xn..3'.ps#.....(
        01c0: e6 63 cb 64 f4 34 00 d3  05 c4 04 b8 62
0f 6a bb  .c.d.4......b.j.
        01d0: 66 c5 54 99 c0 25 bb d2  4e e0 5c 55 b7
56 0a cb  f.T..%..N.\U.V..
        01e0: 92 dc e4 55 8d f6 cb 22  ef 1f 28 a4 fb
20 23 bb  ...U..."..(.. #.
        01f0: 96 df 80 13 24 f7 15 09  b7 49 18 6d 04
7b d4 f2  ....$....I.m.{..
        0200: b4 52 68 9e db 4f 8c 92  09 cb 52 0d 2f
60 65 de  .Rh..O....R./`e.
        0210: 00 6e d5 69 88 8d 74 e9  02 6c 57 0a 47
43 48 89  .n.i..t..lW.GCH.
        0220: 74 14 c7 20 1c 74 6f 5a  97 2e 81 62 68
03 a0 db  t.. .toZ...bh...
        0230: 24 60 d2 cb 2b f9 65 12  2e 0f ad 38 a5
d0 42 5a  $`..+.e....8..BZ
        0240: db ba f0 eb c7 a5 3e 6b  75 da 0e cc 1a
6a c8 06  ......>ku....j..
        0250: f9 11 4c e2 36 50 0f ad  4a 2d 04 47 69
18 27 a5  ..L.6P..J-.Gi.'.
        0260: 4b 98 c9 5e d5 48 c2 80  48 1c d6 74 e6
de 39 02  K..^.H..H..t..9.
        0270: b0 0d 25 38 bb 88 b2 b2  5b c4 bf 38 e4
8e 82 aa  ..%8....[..8....
        0280: cd 77 6c eb b0 64 27 7a  7c a1 71 cc ba
71 b7 22  .wl..d'z|.q..q."
        0290: 32 72 07 5a c8 f9 23 21  8b 12 b9 e0 0a
2c 05 e8  2r.Z..#!.....,..
        02a0: 6e a5 12 81 1b 10 07 ad  4b 73 a8 ca 17
31 90 4d  n.......Ks...1.M
        02b0: 55 ac 02 a5 e3 cd 08 50  f8 3d cd 44 6e
e4 0e 56  U......P.=.Dn..V
        02c0: 33 bb 1d 4d 43 92 d8 04  17 b3 be 54 83
91 d3 3d  3..MC......T...=
        02d0: 2a 73 34 9e 58 2e db 4d  3e 50 bd 83 cc
89 90 1b  *s4.X..M>P......
        02e0: 87 25 bb 0a 95 e4 85 a3  00 03 f8 50 f4
1d ec 40  .%.........P...@
        02f0: 3e ce 92 65 58 ee 34 c4  16 e5 e4 f3 38
3d a8 4f  >..eX.4.....8=.O
        0300: a1 31 95 c1 52 14 4c ee  60 a7 b8 aa b7
16 48 9b  .1..R.L.`.....H.
        0310: 5a 36 ea 78 a5 27 62 ee  ac 32 74 62 e1
58 f1 4f  Z6.x.'b..2tb.X.O
        0320: b8 e2 25 86 2e 87 bd 36  ec b4 25 0d 16
b8 51 19  ..%....6..%...Q.
        0330: c6 71 92 4d 40 f6 b1 f9  47 27 bf 6e f4
a3 26 d0  .q.M@...G'.n..&.
        0340: c7 db db 04 ff 00 54 a4  9f 7a 77 96 ad
30 68 d7  ......T..zw..0h.
        0350: 00 f0 d5 42 4c 79 b6 55  05 40 1b 4f 7a
8f 6c 31  ...BLy.U.@.Oz.l1
        0360: 32 ab ae 40 fd 68 01 d7  b7 0d 32 46 62
40 8a 38  2..@.h....2Fb@.8
        0370: 18 a6 cb 23 82 a1 09 07  1c d2 4c 86 c6
89 bc 90  ...#......L.....
        0380: 19 89 c9 a9 3c c6 9e 12  02 1c 53 2a 2f
43 3c f9  ....<.....S*/C<.
        0390: f3 6e 2a fb 63 1c ed a7  9d ab 6e b2 46
df 31 e0  .n*.c.....n.F.1.
        03a0: 8a 9b a7 a1 ab 85 91 6a  c6 e4 24 64 1e
17 bd 49  .......j..$d...I
        03b0: 75 73 1c 91 85 5e 31 dc  d2 72 5d 08 44
32 db 2c  us...^1..r].D2.,
        03c0: d0 23 ef e4 53 23 29 6d  26 ec 9c 9a ab
5c bb b8  .#..S#)m&....\..
        03d0: 93 45 33 dc 46 cd bb 81  c0 14 d1 2c 8c
a5 4a 82  .E3.F......,..J.
        03e0: 83 ae 6a 55 d3 25 6b a9  02 48 bb d8 43
18 1c 7d  ..jU.%k..H..C..}
        03f0: e3 4d                                   
         .M
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 44 54 8c 97 50 73 de ad  a1 26 3a 24 8a
40 57 6e  DT..Ps...&:$.@Wn
        0010: 48 e4 1a 7b 02 ae be 5f  cb ed da a6 fa
e8 03 1e  H..{..._........
        0020: e4 41 92 fd 4d 59 b5 9d  86 25 63 ba 23
db d2 a9  .A..MY...%c.#...
        0030: 03 d4 b5 3d ec 2c 77 6d  ce 05 51 33 07
cf 4c 9e  ...=.,wm..Q3..L.
        0040: 95 32 57 d8 76 b9 7c cf  12 79 5f bb 50
fd cd 4b  .2W.v.|..y_.P..K
        0050: 2c d6 8a 37 38 1e 65 2b  25 b8 d9 57 7d
b5 cf ca  ,..78.e+%..W}...
        0060: 4e 0e 7b 55 8f b1 db 9c  0d db 81 1d a8
f8 55 c4  N.{U..........U.
        0070: 27 d8 a3 44 07 cc c2 03  d2 91 51 8b 16
32 02 3f  '..D......Q..2.?
        0080: 86 9c 5d d1 52 64 8a 80  94 12 30 fa e6
9d f6 6d  ..].Rd....0....m
        0090: 8c c4 3e 57 eb 4d ab 93  19 72 bb 88 ca
c0 8d 87  ..>W.M...r......
        00a0: 83 ea 69 c5 5b cb 1b 79  3d ea 5c 44 e5
cc 4a 37  ..i.[..y=.\D..J7
        00b0: 6e 54 1f 52 2a bd d4 c8  ec 23 0b 85 f5
aa 5b 08  nT.R*....#....[.
        00c0: ce db 2a 97 58 cf 04 f1  4f f2 2e 1e 20
ac f8 3d  ..*.X...O... ..=
        00d0: c5 66 a3 67 72 d4 6e 2c  11 4e 92 2c 42
5e 3b 8a  .f.gr.n,.N.,B^;.
        00e0: b1 25 9d c3 97 f2 c8 c8  f5 ab 4f a9 2d
58 8e da  .%........O.-X..
        00f0: c1 b7 1f 30 e6 4f 4a 22  b4 2a ce 49 c3
76 15 49  ...0.OJ".*.I.v.I
        0100: dc 44 76 b0 c8 d2 30 65  20 8e a0 f7 a7
4f 6b b0  .Dv...0e ....Ok.
        0110: 12 01 c1 ed 51 6d 40 72  83 04 6a 42 6e
35 10 fd  ....Qm@r..jBn5..
        0120: e7 cf 1a 60 8e d5 0e 3a  dc a7 b1 23 4a
db 43 26  ...`...:...#J.C&
        0130: 78 ea 2a 33 21 dc a6 22  d8 3d 45 6c 49
2c 33 44  x.*3!..".=ElI,3D
        0140: ea cb bd 81 3d 45 35 24  90 2c 81 18 f9
63 a5 4d  ....=E5$.,...c.M
        0150: d6 c5 25 74 4c 2e 8c 71  46 58 9c 53 65
ba 59 08  ..%tL..qFX.Se.Y.
        0160: 73 21 66 1d 05 50 9a b0  d6 bd 49 06 5b
19 5e f4  s!f..P....I.[.^.
        0170: c8 65 12 3e f5 00 63 bd  4b 8a 62 1f 3d
c4 51 00  .e.>..c.K.b.=.Q.
        0180: 11 b2 cd d7 15 32 08 d9  77 29 c6 7a 9a
ad 80 af  .....2..w).z....
        0190: 24 de 54 9b 70 31 fa 53  9e 78 d9 8f 03
8f 4a 86  $.T.p1.S.x....J.
        01a0: ae 34 56 4b 94 95 98 8e  8b 57 a1 63 2c
41 51 b2  .4VK.....W.c,AQ.
        01b0: ad c1 a7 b2 10 f5 d3 18  60 07 c7 bd 37
ec 1e 58  ........`...7..X
        01c0: cb c8 33 50 af 7d 00 96  3b 05 7c 03 20
da 3a d4  ..3P.}..;.|. .:.
        01d0: ad 64 9c 04 71 e5 77 ad  18 c8 d6 cc ec
90 2c 83  .d..q.w.......,.
        01e0: 6f 6a 74 1a 74 66 0d d2  4c 19 fd 33 52
93 11 08  ojt.tf..L..3R...
        01f0: b3 8d 59 dd 65 01 ba 73  48 20 f2 a1 3b
e4 07 75  ..Y.e..sH ..;..u
        0200: 58 11 c7 68 23 71 99 7e  53 da a1 96 dc
86 3b 1f  X..h#q.~S.....;.
        0210: 8a 4c 0b 56 b6 92 bc 60  09 00 51 fa d3
c5 99 33  .L.V...`..Q....3
        0220: 65 5f 0f 4c 07 a5 9c 9e  69 60 c0 63 f2
a8 c5 bc  e_.L....i`.c....
        0230: f8 38 60 58 9a 97 a8 c2  55 d8 04 73 1c
39 e9 8a  .8`X....U..s.9..
        0240: 8a 08 26 32 f9 51 49 90  7b 54 eb b0 17
0d b4 e9  ..&2.QI.{T......
        0250: 18 52 c4 54 4d 15 cc 4e  a4 13 93 d0 d6
89 58 06  .R.TM..N......X.
        0260: 5d 79 c0 29 90 8d e3 b8  a6 1b dd b8 c6
5b 1e d4  ]y.).........[..
        0270: 9b b0 ad 72 cc 77 93 48  9b 63 6c 7b 55
6b 99 93  ...r.w.H.cl{Uk..
        0280: 7a f9 8a 43 0f 41 4d 0e  c2 0d 82 33 c6
59 a9 d0  z..C.AM....3.Y..
        0290: 6d 03 11 91 9a 96 f5 02  c8 8a e1 47 99
03 64 1e  m..........G..d.
        02a0: a2 a8 de cd 70 1d 43 36  00 aa 4c 4d 08
be 7f 0d  ....p.C6..LM....
        02b0: e6 6f 8c f6 ab 03 cc 74  0b 09 c6 7b 8a
57 15 87  .o.....t...{.W..
        02c0: c0 93 ac a1 64 6c fb e2  a5 b7 37 22 e1
94 0c af  ....dl....7"....
        02d0: 6a 57 b9 4e 36 25 79 dd  64 c4 c0 30 ee
2a 55 31  jW.N6%y.d..0.*U1
        02e0: 3b 03 b1 40 23 a5 50 8c  db d5 8e 30 fb
11 77 76  ;..@#.P....0..wv
        02f0: 35 4a 3b 78 db 06 4c 06  35 2e fd 00 d2
86 15 8b  5J;x..L.5.......
        0300: 6e 23 3b bb 11 52 9b 99  a2 6c 1c e0 d3
6d 22 9b  n#;..R...l...m".
        0310: b8 e8 ee 89 56 3b b0 69  bf 6b 92 38 c0
67 27 75  ....V;.i.k.8.g'u
        0320: 32 49 e4 bc 6f b3 85 63  80 3a 1a ab 2d
c4 ed 09  2I..o..c.:..-...
        0330: 1e 66 41 e9 40 58 a9 be  72 02 19 08 f4
a8 e4 f3  .fA.@X..r.......
        0340: 04 6c ac 72 d4 30 0b 78  5e 30 7e 60 ec
7b 52 c3  .l.r.0.x^0~`.{R.
        0350: 0b 99 37 2f c8 e3 a6 29  5c 12 26 42 f2
bb 24 d2  ..7/...)\.&B..$.
        0360: 9d c3 a5 41 f6 13 23 1f  39 ba 74 a2 e3
4a e3 a4  ...A..#.9.t..J..
        0370: b5 30 c4 37 31 20 fa 53  9a 19 23 8c 6d
42 d1 9e  .0.71 .S..#.mB..
        0380: 94 5e e0 d5 88 ae ec cb  46 8d b7 69 3d
ea 28 d9  .^......F..i=.(.
        0390: 6d d4 29 8b 78 1d f1 49  3e 82 b1 33 2a
c8 cb 22  m.).x..I>..3*.."
        03a0: c6 76 91 c8 c5 34 e1 8e  c4 8f 09 4d 2b
00 f8 2c  .v...4.....M+..,
        03b0: 24 90 06 55 03 69 e2 ae  dc d9 3a 2a e1
32 5b ae  $..U.i....:*.2[.
        03c0: 05 2e 75 7b 00 ef b2 cc  11 0f 2a be 94
dc cb 21  ..u{......*....!
        03d0: 2a 46 40 ef 45 d3 1d 88  04 89 14 bb 0b
8e 9d 6a  *F@.E..........j
        03e0: 8c f7 66 39 0f 94 72 a4  d3 44 ea 5f b7
b8 56 4f  ..f9..r..D._..VO
        03f0: 98 8c                                   
         ..
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
        OBEX: Put rsp(f): status 100 len 3
        Status 100 = Continue
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
        OBEX: Put cmd(c): len 1016 (continue)
        Body (0x48) = Sequence length 1010
        0000: 62 a9 cf 74 d6 f2 15 45  dc 1b bf a5 30
57 2e c1  b..t...E....0W..
        0010: 01 bc 84 63 af ad 58 b7  d3 db 71 5d c0
28 ef 40  ...c..X...q].(.@
        0020: d6 a4 bf 63 2d 81 23 a9  5a 49 ad 95 4e
c4 65 39  ...c-.#.ZI..N.e9
        0030: e8 2b 34 dd ec 05 46 8e  54 98 7c a3 68
a4 60 41  .+4...F.T.|.h.`A
        0040: 39 5e 0f 4a d2 dd 40 6a  ee 0a 40 4c e2
a7 8a 39  9^.J..@j..@L...9
        0050: 1e 30 db b1 ea 28 bd 86  49 6f 24 82 26
f9 b6 e3  .0...(..Io$.&...
        0060: b9 aa bf da 20 39 0d 26  0a d2 5a 8d 22
78 35 14  .... 9.&..Z."x5.
        0070: 99 4a 03 8f 7a 7b 5e 96  89 57 ef 05 34
28 92 3c  .J..z{^..W..4(.<
        0080: c8 f2 b0 60 08 51 da ac  33 c8 4a 39 8f
23 d0 53  ...`.Q..3.J9.#.S
        0090: 4a c0 4a d3 ba c8 00 8f  e5 23 f2 aa f7
77 12 a9  J.J......#...w..
        00a0: 5c ae 52 a6 48 68 85 6f  22 da 64 58 f9
4a 4f ed  \.R.Hh.o".dX.JO.
        00b0: 15 b9 1b 80 f9 85 1c 88  06 8b bd a4 86
ce e2 2a  ...............*
        00c0: 22 6d e4 65 66 42 1c 9e  b4 f4 42 bf 42
79 24 b5  "m.efB....B.By$.
        00d0: 52 01 5d c6 a2 59 22 59  32 d0 ae d6 a6
9d c6 3d  R.]..Y"Y2......=
        00e0: 3e c7 2b 85 f2 f6 2d 4e  b0 58 34 a6 32
00 1d a9  >.+...-N.X4.2...
        00f0: 31 0d 9e 1b 7d db 21 2b  b8 54 4f 61 1c
91 83 bc  1...}.!+.TOa....
        0100: 07 1d a9 6a 01 25 aa 46  53 61 1c f5 a6
4d 68 c7  ...j.%.FSa...Mh.
        0110: e5 85 71 9e a6 b3 84 3a  b1 8f fb 1c a0
2a 12 31  ..q....:.....*.1
        0120: 8e 0d 32 5d 3e 79 0a a3  30 00 56 ae 56
11 1c 96  ..2]>y..0.V.V...
        0130: 92 2b 6c 40 1f 15 25 ad  a4 91 12 d2 11
bb b0 34  .+l@..%........4
        0140: 5d 0f 42 b9 88 ee 4c 0f  5a a5 05 99 7f
32 10 18  ].B...L.Z....2..
        0150: 11 df d6 a8 81 bf d9 ac  a0 02 36 91 e9
57 2c ed  ..........6..W,.
        0160: 02 03 f8 48 03 f5 05 ee  39 ee 3c f4 60
72 ac bd  ...H....9.<.`r..
        0170: 6a 18 84 d2 60 04 24 ff  00 09 a6 82 c0
56 e1 81  j...`.$......V..
        0180: 66 5e 87 06 a7 96 dd d9  15 89 e8 38 a0
43 a2 8d  f^.........8.C..
        0190: fe 47 90 f4 ed 57 25 be  84 b2 ae c0 0e
3a d4 e8  .G...W%......:..
        01a0: c1 2b 14 ef 5c 4f 6e d1  86 2a de 95 9f
05 9b 88  .+..\On..*......
        01b0: b6 9c b3 76 f6 a1 e8 32  d4 56 3b 06 43
e1 8f 51  ...v...2.V;.C..Q
        01c0: 50 bd a8 49 c6 1c 15 3d  56 9d c4 23 41
14 72 01  P..I...=V..#A.r.
        01d0: e6 16 43 d5 7d 2a 45 11  10 7c b6 da 82
a1 b4 8a  ..C.}*E..|......
        01e0: 8b b0 dd f0 6e 0c 41 27  d6 ad 9b 98 0a
04 cf 1e  ....n.A'........
        01f0: 95 69 24 2b 8c 51 0c 87  38 e3 d2 9f fd
a1 02 03  .i$+.Q..8.......
        0200: 08 8c 83 8e f4 ec 27 a1  59 11 19 5c f9
78 06 9b  ......'.Y..\.x..
        0210: 37 9b 0c 04 b2 0d 8b d0  d4 a9 5c 13 b9
1c 52 99  7.........\...R.
        0220: 21 0e 23 e6 ae 24 d2 49  18 72 a2 32 3a
01 de 98  !.#..$.I.r.2:...
        0230: d2 b8 e1 7f 20 61 e6 a6  71 44 fa a1 db
b1 57 02  .... a..qD....W.
        0240: 9d 81 ab 15 53 50 61 2f  ee b0 07 71 4b
71 a9 49  ....SPa/...qKq.I
        0250: 1b 60 72 48 fc a8 7e 42  2b a5 b5 cd d9
dd 3b ed  .`rH..~B+.....;.
        0260: 4e a2 88 a0 98 12 cb 2e  40 38 c5 05 58
92 e0 cc  N.......@8..X...
        0270: ce a0 1a ba ae d1 5b aa  cb f3 67 a5 2d
c3 94 49  ......[...g.-..I
        0280: ae a3 44 04 70 fe 94 e8  6e 15 57 74 71
8d c7 a9  ..D.p...n.Wtq...
        0290: a7 62 4b 69 71 04 28 09  43 9a af 1d cb
24 8f 2b  .bKiq.(.C....$.+
        02a0: 28 65 3d 3d a8 b0 0a 2e  fe 6c 18 c6 c3
52 fd a2  (e==.....l...R..
        02b0: 17 52 36 e1 80 a4 d5 c6  56 6f b3 ed 49
15 72 41  .R6.....Vo..I.rA
        02c0: e6 9f 1d d5 9a b8 2a a7  22 9d ac 1b 97
16 e6 39  ......*."......9
        02d0: 98 33 63 d8 53 a4 b8 b6  6c 99 57 ee d2
b0 99 12  .3c.S...l.W.....
        02e0: 5c da 4a 41 54 e4 53 e4  ba 81 48 57 8f
24 f7 c5  \.JAT.S...HW.$..
        02f0: 16 04 ee 24 77 76 69 38  41 11 05 bb 9a
96 46 b5  ...$wvi8A.....F.
        0300: 8d f7 04 03 77 5a 12 02  36 8e dd 06 ff
00 e1 3e  ....wZ..6......>
        0310: b5 13 47 6e cc 16 3c 60  f5 34 c0 a0 3c
98 6e b0  ..Gn..<`.4..<.n.
        0320: 5b 29 ed 5a 2f 6e b3 85  65 60 17 d2 93
7d 80 8e  [).Z/n..e`...}..
        0330: 3b 34 0f 86 6d 86 ac 43  1c 11 31 59 70
72 38 34  ;4..m..C..1Ypr84
        0340: b7 02 18 60 58 e5 93 f7  80 0e a2 a1 6b
74 9c 83  ...`X.......kt..
        0350: e6 0c e6 84 ed b8 13 9b  38 14 0d cf b9
6a 39 ad  ........8....j9.
        0360: 51 98 79 24 6e 14 a5 a8  15 8d bb c4 b2
48 cf bb  Q.y$n........H..
        0370: d2 a3 d3 a1 8d ed dd ae  5b e7 a8 8c f5
b3 1d 80  ........[.......
        0380: 47 6e 0b 28 c6 4f 43 4f  85 6d d1 0c 6f
f7 bf bd  Gn.(.OCO.m..o...
        0390: 8a b4 ae ee 21 eb 35 b8  21 19 b2 c3 a6
2a d3 5b  ....!.5.!....*.[
        03a0: da 6d de c4 64 f7 a6 e3  70 20 8d ad 97
25 5b af  .m..d...p ...%[.
        03b0: 15 23 49 6f 6e a5 09 c9  34 28 a0 23 0d
01 18 59  .#Ion...4(.#...Y
        03c0: 00 06 a7 12 5b a2 79 79  0c c7 bd 39 2b
a0 05 9a  ....[.yy...9+...
        03d0: cd 63 68 81 cd 46 21 89  f6 90 e0 20 ed
53 18 d8  .ch..F!.... .S..
        03e0: 69 83 b4 72 38 21 80 55  a9 02 c3 2b e5
a4 00 2f  i..r8!.U...+.../
        03f0: f0 d5                                   
         ..
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80



Is there any abnormal transaction from the lower
layer(bluetooth layers)?
I have to kill everything so that I can send another
opp request. The phone is saying the bluetooth is
busy...Is there any problems with RFCOMM and/or l2cap
that the phone can not properly close connection?

Thanks 

Paul







		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
