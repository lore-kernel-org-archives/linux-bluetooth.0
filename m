Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Stefan Torkel <nephlim@gmx.de>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1102478181.8447.52.camel@pegasus>
References: <1102381335.13235.8.camel@nephlim.homenet>
	 <1102406104.8447.15.camel@pegasus>
	 <1102438800.21032.3.camel@nephlim.homenet>
	 <1102478181.8447.52.camel@pegasus>
Content-Type: text/plain
Message-Id: <1102553068.22127.5.camel@nephlim.homenet>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 01:44:27 +0100

Hi Marcel,

> is the ACL link still open? Check with "hcitool con". Run "hcidump -X"
> as root as I told you.


no there are no active connections.

Here is the output for the successful transfer:

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  C4 0F 15 ED 0E 00 0C 02 50 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  C4 0F 15 ED 0E 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> HCI Event: Connect Complete (0x03) plen 11
  00 01 00 C4 0F 15 ED 0E 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  01 00 0F 00
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  01 00 18 CC
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 01 00 18 CC
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x1105 (OBEXObjPush)
          max 0xffff
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          tot 0x1 cur 0x1 hndl 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          hndl 0x10002
          max 0x400
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 36
    L2CAP(d): cid 0x40 len 32 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x1b
          cnt 0x18
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x3 > <
             uuid-16 0x0008 (OBEX) > >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 23
    L2CAP(d): cid 0x40 len 19 [psm 1]
        SDP SS Req: tid 0x3 len 0xe
          pat uuid-16 0x0003 (RFCOMM) uuid-16 0x0100 (L2CAP) uuid-16
0x1105 (OBEXObjPush)
          max 0xffff
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 1]
        SDP SS Rsp: tid 0x3 len 0x9
          tot 0x1 cur 0x1 hndl 0x10002
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x4 len 0xc
          hndl 0x10002
          max 0x400
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 22
    L2CAP(d): cid 0x40 len 18 [psm 1]
        SDP SA Rsp: tid 0x4 len 0xd
          cnt 0xa
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1105 (OBEXObjPush) >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x5 len 0xc
          hndl 0x10002
          max 0x400
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 36
    L2CAP(d): cid 0x40 len 32 [psm 1]
        SDP SA Rsp: tid 0x5 len 0x1b
          cnt 0x18
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x3 > <
             uuid-16 0x0008 (OBEX) > >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x6 len 0xc
          hndl 0x10002
          max 0x400
          aid(s) 0x0009 (BTProfileDescList)
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 27
    L2CAP(d): cid 0x40 len 23 [psm 1]
        SDP SA Rsp: tid 0x6 len 0x12
          cnt 0xf
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x7 len 0xc
          hndl 0x10002
          max 0x400
          aid(s) 0x0303 (SuppFormatsList)
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 33
    L2CAP(d): cid 0x40 len 29 [psm 1]
        SDP SA Rsp: tid 0x7 len 0x18
          cnt 0x15
          aid 0x0303 (SuppFormatsList)
             < uint 0xff uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5
uint 0x6 >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 672
> ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
667 max_retrans 0 credits 3
< ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size
667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3
< ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  C4 0F 15 ED 0E 00 02 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0001 flags 0x02 dlen 9
    L2CAP(d): cid 0x41 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49 credits 33
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(d): cid 0x41 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 7 fcs 0x93 credits 4
      80 00 07 10 00 0F A0
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 C4 0F 15 ED 0E 00 47 61 6C 69 6E 64 6F 72 00 00 00 00 00
  00 AA 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04
  3A 37 00 4A 01 0A 00 82 03 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 11 00 00 09 42 6C 75 65 5A 20 28 30 29 00 00
  00 00 00 00 00 00 00 00 00 00 00 09 04 07 C4 0F 15 ED 0E 00
  01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 80 05
  04 00 01 00 13 03 15 ED 0E 00 01 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
< ACL data: handle 0x0001 flags 0x02 dlen 15
    L2CAP(d): cid 0x41 len 11 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 7 fcs 0x55
      A0 00 07 11 00 04 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 85
    L2CAP(d): cid 0x41 len 81 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 76 fcs 0x93 credits 1
      02 00 4C 01 00 23 00 41 00 6C 00 6C 00 65 00 20 00 6E 00 6F
      00 72 00 6D 00 61 00 6C 00 2E 00 76 00 63 00 66 00 00 C3 00
      00 00 44 42 00 0F 74 65 78 74 2F 58 2D 76 43 61 72 64 44 00
      12 32 30 30 34 31 32 30 38 54 30 31 33 37 30 30
< ACL data: handle 0x0001 flags 0x02 dlen 11
    L2CAP(d): cid 0x41 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 3 fcs 0x55
      90 00 03
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 83
    L2CAP(d): cid 0x41 len 79 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 74 fcs 0x93 credits 1
      82 00 4A 49 00 47 42 45 47 49 4E 3A 56 43 41 52 44 0D 0A 56
      45 52 53 49 4F 4E 3A 32 2E 31 0D 0A 4E 3A 41 6C 6C 65 20 6E
      6F 72 6D 61 6C 0D 0A 54 45 4C 3B 43 45 4C 4C 3A 23 23 32 31
      23 0D 0A 45 4E 44 3A 56 43 41 52 44 0D 0A
< ACL data: handle 0x0001 flags 0x02 dlen 11
    L2CAP(d): cid 0x41 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 3 fcs 0x55
      A0 00 03
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 3 fcs 0x93 credits 1
      81 00 03
< ACL data: handle 0x0001 flags 0x02 dlen 11
    L2CAP(d): cid 0x41 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 3 fcs 0x55
      A0 00 03
> ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32
< ACL data: handle 0x0001 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
< HCI Command: Disconnect (0x01|0x0006) plen 3
  01 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 01 00 13


and here is the output, when I try it again:

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  C4 0F 15 ED 0E 00 0C 02 50 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  C4 0F 15 ED 0E 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0046
> HCI Event: Connect Complete (0x03) plen 11
  00 01 00 C4 0F 15 ED 0E 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  01 00 0F 00
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  01 00 18 CC
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 01 00 18 CC
> HCI Event: Disconn Complete (0x05) plen 4
  00 01 00 13


Can you see what is wrong? What could it be?

Best regards

Stefan



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
