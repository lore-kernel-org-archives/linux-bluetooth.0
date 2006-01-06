Return-Path: <karl.h.beckers@gmx.net>
Subject: Re: Re: [Bluez-users] repairing required after each dialup
From: "Karl H. Beckers" <karl.h.beckers@gmx.net>
To: bluez-users@lists.sourceforge.net
Cc: marcel@holtmann.org
Content-Type: multipart/mixed; boundary="=-dmYgwpvHMzq4Q/nBi9BO"
Date: Fri, 06 Jan 2006 18:00:15 +0100
Message-Id: <1136566815.17866.2.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-users.lists.sourceforge.net>


--=-dmYgwpvHMzq4Q/nBi9BO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

attached you'll find the dumps of:
1) me doing "ifdown ppp0" which for some reason also quits rfcomm
(hcidump-drop-conn.txt)
2) me trying "rfcomm connect 0" again and getting "Connection refused"
(hcidump-conn-refused.txt)
3) same thing this time after deleting the laptop from the phone's list
before trying the connect
(hcidump-conn-repaired.txt)

Thanks,

Karl.

--=-dmYgwpvHMzq4Q/nBi9BO
Content-Disposition: attachment; filename=hcidump-conn-refused.txt
Content-Type: text/plain; name=hcidump-conn-refused.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:07:88:1A:A5 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0E:07:88:1A:A5 type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0059 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0059 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674 
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0059 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0059 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0059 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0059 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0059 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0059 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0059 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

--=-dmYgwpvHMzq4Q/nBi9BO
Content-Disposition: attachment; filename=hcidump-conn-repaired.txt
Content-Type: text/plain; name=hcidump-conn-repaired.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:07:88:1A:A5 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0E:07:88:1A:A5 type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005a scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x005a flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674 
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x005a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x005a len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x005a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0E:07:88:1A:A5
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0E:07:88:1A:A5 len 5 pin '24351'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0E:07:88:1A:A5
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:0E:07:88:1A:A5 key 31F44FC9D728DB2CE985E2FF1B95636E type 0
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 41 encrypt 0x01
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x005a len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 1
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 1 b3 0 len 9
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x005a len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1 len 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 0 len 9
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x005a len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 13
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x005a len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x005a len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x005a scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x005a scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

--=-dmYgwpvHMzq4Q/nBi9BO
Content-Disposition: attachment; filename=hcidump-drop-conn.txt
Content-Type: text/plain; name=hcidump-drop-conn.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 41 flags 0x02 dlen 97
    L2CAP(d): cid 0x0058 len 93 [psm 0]
      0000: 0b ef b3 7e 21 45 00 00  54 02 72 40 00 40 01 3f  ...~!E..T.r@.@.?
      0010: c0 0a e2 d7 18 d5 a5 40  d7 08 00 62 18 aa 46 02  .......@...b..F.
      0020: 73 9f a0 be 43 9d 46 03  00 08 09 0a 0b 0c 0d 0e  s...C.F.........
      0030: 0f 10 11 12 13 14 15 16  17 18 19 1a 1b 1c 1d 1e  ................
      0040: 1f 20 21 22 23 24 25 26  27 28 29 2a 2b 2c 2d 2e  . !"#$%&'()*+,-.
      0050: 2f 30 31 32 33 34 35 36  37 32 07 7e 9a           /012345672.~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 99
    L2CAP(d): cid 0x0040 len 95 [psm 0]
      0000: 09 ff b2 00 01 7e 21 45  00 00 54 d3 8d 00 00 32  .....~!E..T....2
      0010: 01 bc a4 d5 a5 40 d7 0a  e2 d7 18 00 00 6a 18 aa  .....@.......j..
      0020: 46 02 73 9f a0 be 43 9d  46 03 00 08 09 0a 0b 0c  F.s...C.F.......
      0030: 0d 0e 0f 10 11 12 13 14  15 16 17 18 19 1a 1b 1c  ................
      0040: 1d 1e 1f 20 21 22 23 24  25 26 27 28 29 2a 2b 2c  ... !"#$%&'()*+,
      0050: 2d 2e 2f 30 31 32 33 34  35 36 37 ad 87 7e 5c     -./01234567..~\
< ACL data: handle 41 flags 0x02 dlen 87
    L2CAP(d): cid 0x0058 len 83 [psm 0]
      0000: 0b ef 9f 7e 21 45 00 00  49 89 e5 40 00 40 11 25  ...~!E..I..@.@.%
      0010: 40 0a e2 d7 18 8b 07 1e  7d 5d 82 68 00 35 00 35  @.......}].h.5.5
      0020: d4 fd 99 4a 01 00 00 01  00 00 00 00 00 00 03 32  ...J...........2
      0030: 31 35 02 36 34 03 31 36  35 03 32 31 33 07 69 6e  15.64.165.213.in
      0040: 2d 61 64 64 72 04 61 72  70 61 00 00 0c 00 01 01  -addr.arpa......
      0050: f5 7e 9a                                          .~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 191
    L2CAP(d): cid 0x0040 len 187 [psm 0]
      0000: 09 ff 6a 01 01 7e 21 45  00 00 af 94 1e 40 00 f7  ..j..~!E.....@..
      0010: 11 63 a0 8b 07 1e 7d 5d  0a e2 d7 18 00 35 82 68  .c....}].....5.h
      0020: 00 9b 77 3c 99 4a 81 80  00 01 00 01 00 02 00 02  ..w<.J..........
      0030: 03 32 31 35 02 36 34 03  31 36 35 03 32 31 33 07  .215.64.165.213.
      0040: 69 6e 2d 61 64 64 72 04  61 72 70 61 00 00 0c 00  in-addr.arpa....
      0050: 01 c0 0c 00 0c 00 01 00  00 00 2a 00 0d 03 77 77  ..........*...ww
      0060: 77 03 67 6d 78 03 6e 65  74 00 c0 10 00 02 00 01  w.gmx.net.......
      0070: 00 00 0d 2f 00 06 03 64  6e 73 c0 3d c0 10 00 02  .../...dns.=....
      0080: 00 01 00 00 0d 2f 00 0f  02 6e 73 07 73 63 68 6c  ...../...ns.schl
      0090: 75 6e 64 02 64 65 00 c0  64 00 01 00 01 00 01 48  und.de..d......H
      00a0: 5a 00 04 c3 14 e0 61 c0  52 00 01 00 01 00 00 0d  Z.....a.R.......
      00b0: 43 00 04 d5 a5 40 01 ab  eb 7e 5c                 C....@...~\
< ACL data: handle 41 flags 0x02 dlen 97
    L2CAP(d): cid 0x0058 len 93 [psm 0]
      0000: 0b ef b3 7e 21 45 00 00  54 02 73 40 00 40 01 3f  ...~!E..T.s@.@.?
      0010: bf 0a e2 d7 18 d5 a5 40  d7 08 00 e8 f7 aa 46 02  .......@......F.
      0020: 74 a2 a0 be 43 13 66 03  00 08 09 0a 0b 0c 0d 0e  t...C.f.........
      0030: 0f 10 11 12 13 14 15 16  17 18 19 1a 1b 1c 1d 1e  ................
      0040: 1f 20 21 22 23 24 25 26  27 28 29 2a 2b 2c 2d 2e  . !"#$%&'()*+,-.
      0050: 2f 30 31 32 33 34 35 36  37 ab b4 7e 9a           /01234567..~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 99
    L2CAP(d): cid 0x0040 len 95 [psm 0]
      0000: 09 ff b2 00 01 7e 21 45  00 00 54 d3 8e 00 00 32  .....~!E..T....2
      0010: 01 bc a3 d5 a5 40 d7 0a  e2 d7 18 00 00 f0 f7 aa  .....@..........
      0020: 46 02 74 a2 a0 be 43 13  66 03 00 08 09 0a 0b 0c  F.t...C.f.......
      0030: 0d 0e 0f 10 11 12 13 14  15 16 17 18 19 1a 1b 1c  ................
      0040: 1d 1e 1f 20 21 22 23 24  25 26 27 28 29 2a 2b 2c  ... !"#$%&'()*+,
      0050: 2d 2e 2f 30 31 32 33 34  35 36 37 c9 aa 7e 5c     -./01234567..~\
< ACL data: handle 41 flags 0x02 dlen 86
    L2CAP(d): cid 0x0058 len 82 [psm 0]
      0000: 0b ef 9d 21 45 00 00 49  8c 82 40 00 40 11 22 a3  ...!E..I..@.@.".
      0010: 0a e2 d7 18 8b 07 1e 7d  5d 82 68 00 35 00 35 0d  .......}].h.5.5.
      0020: c2 60 86 01 00 00 01 00  00 00 00 00 00 03 32 31  .`............21
      0030: 35 02 36 34 03 31 36 35  03 32 31 33 07 69 6e 2d  5.64.165.213.in-
      0040: 61 64 64 72 04 61 72 70  61 00 00 0c 00 01 22 8f  addr.arpa.....".
      0050: 7e 9a                                             ~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 191
    L2CAP(d): cid 0x0040 len 187 [psm 0]
      0000: 09 ff 6a 01 01 7e 21 45  00 00 af 94 1f 40 00 f7  ..j..~!E.....@..
      0010: 11 63 9f 8b 07 1e 7d 5d  0a e2 d7 18 00 35 82 68  .c....}].....5.h
      0020: 00 9b 54 62 60 86 81 80  00 01 00 01 00 02 00 02  ..Tb`...........
      0030: 03 32 31 35 02 36 34 03  31 36 35 03 32 31 33 07  .215.64.165.213.
      0040: 69 6e 2d 61 64 64 72 04  61 72 70 61 00 00 0c 00  in-addr.arpa....
      0050: 01 c0 0c 00 0c 00 01 00  00 00 27 00 0d 03 77 77  ..........'...ww
      0060: 77 03 67 6d 78 03 6e 65  74 00 c0 10 00 02 00 01  w.gmx.net.......
      0070: 00 00 0d 2c 00 0f 02 6e  73 07 73 63 68 6c 75 6e  ...,...ns.schlun
      0080: 64 02 64 65 00 c0 10 00  02 00 01 00 00 0d 2c 00  d.de..........,.
      0090: 06 03 64 6e 73 c0 3d c0  52 00 01 00 01 00 01 48  ..dns.=.R......H
      00a0: 57 00 04 c3 14 e0 61 c0  6d 00 01 00 01 00 00 0d  W.....a.m.......
      00b0: 40 00 04 d5 a5 40 01 c0  5c 7e 5c                 @....@..\~\
< ACL data: handle 41 flags 0x02 dlen 97
    L2CAP(d): cid 0x0058 len 93 [psm 0]
      0000: 0b ef b3 7e 21 45 00 00  54 02 74 40 00 40 01 3f  ...~!E..T.t@.@.?
      0010: be 0a e2 d7 18 d5 a5 40  d7 08 00 0d e7 aa 46 02  .......@......F.
      0020: 75 a5 a0 be 43 eb 75 03  00 08 09 0a 0b 0c 0d 0e  u...C.u.........
      0030: 0f 10 11 12 13 14 15 16  17 18 19 1a 1b 1c 1d 1e  ................
      0040: 1f 20 21 22 23 24 25 26  27 28 29 2a 2b 2c 2d 2e  . !"#$%&'()*+,-.
      0050: 2f 30 31 32 33 34 35 36  37 80 6f 7e 9a           /01234567.o~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 99
    L2CAP(d): cid 0x0040 len 95 [psm 0]
      0000: 09 ff b2 00 01 7e 21 45  00 00 54 d3 8f 00 00 32  .....~!E..T....2
      0010: 01 bc a2 d5 a5 40 d7 0a  e2 d7 18 00 00 15 e7 aa  .....@..........
      0020: 46 02 75 a5 a0 be 43 eb  75 03 00 08 09 0a 0b 0c  F.u...C.u.......
      0030: 0d 0e 0f 10 11 12 13 14  15 16 17 18 19 1a 1b 1c  ................
      0040: 1d 1e 1f 20 21 22 23 24  25 26 27 28 29 2a 2b 2c  ... !"#$%&'()*+,
      0050: 2d 2e 2f 30 31 32 33 34  35 36 37 9e 85 7e 5c     -./01234567..~\
< ACL data: handle 41 flags 0x02 dlen 86
    L2CAP(d): cid 0x0058 len 82 [psm 0]
      0000: 0b ef 9d 21 45 00 00 49  8f 19 40 00 40 11 20 0c  ...!E..I..@.@. .
      0010: 0a e2 d7 18 8b 07 1e 7d  5d 82 68 00 35 00 35 c5  .......}].h.5.5.
      0020: 37 a9 10 01 00 00 01 00  00 00 00 00 00 03 32 31  7.............21
      0030: 35 02 36 34 03 31 36 35  03 32 31 33 07 69 6e 2d  5.64.165.213.in-
      0040: 61 64 64 72 04 61 72 70  61 00 00 0c 00 01 bf 19  addr.arpa.......
      0050: 7e 9a                                             ~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 191
    L2CAP(d): cid 0x0040 len 187 [psm 0]
      0000: 09 ff 6a 01 01 7e 21 45  00 00 af 94 20 40 00 f7  ..j..~!E.... @..
      0010: 11 63 9e 8b 07 1e 7d 5d  0a e2 d7 18 00 35 82 68  .c....}].....5.h
      0020: 00 9b 13 da a9 10 81 80  00 01 00 01 00 02 00 02  ................
      0030: 03 32 31 35 02 36 34 03  31 36 35 03 32 31 33 07  .215.64.165.213.
      0040: 69 6e 2d 61 64 64 72 04  61 72 70 61 00 00 0c 00  in-addr.arpa....
      0050: 01 c0 0c 00 0c 00 01 00  00 00 25 00 0d 03 77 77  ..........%...ww
      0060: 77 03 67 6d 78 03 6e 65  74 00 c0 10 00 02 00 01  w.gmx.net.......
      0070: 00 00 0d 2a 00 0f 02 6e  73 07 73 63 68 6c 75 6e  ...*...ns.schlun
      0080: 64 02 64 65 00 c0 10 00  02 00 01 00 00 0d 2a 00  d.de..........*.
      0090: 06 03 64 6e 73 c0 3d c0  52 00 01 00 01 00 01 48  ..dns.=.R......H
      00a0: 55 00 04 c3 14 e0 61 c0  6d 00 01 00 01 00 00 0d  U.....a.m.......
      00b0: 3e 00 04 d5 a5 40 01 81  9d 7e 5c                 >....@...~\
> ACL data: handle 41 flags 0x02 dlen 69
    L2CAP(d): cid 0x0040 len 65 [psm 0]
      0000: 09 ff 76 00 00 7e 21 45  00 00 34 7d 5d ff 40 00  ..v..~!E..4}].@.
      0010: 3d 06 9e 6a cf 7d 5e 6f  e1 0a e2 d7 18 00 50 cb  =..j.}^o......P.
      0020: e5 2e a0 3e e9 d9 23 06  a1 80 11 82 18 63 68 00  ...>..#......ch.
      0030: 00 01 01 08 0a 12 a6 cf  96 00 68 73 b8 a8 3c 7e  ..........hs..<~
      0040: 5c                                                \
< ACL data: handle 41 flags 0x02 dlen 65
    L2CAP(d): cid 0x0058 len 61 [psm 0]
      0000: 0b ef 73 21 45 00 00 34  63 26 40 00 40 06 b6 43  ..s!E..4c&@.@..C
      0010: 0a e2 d7 18 cf 7d 5e 6f  e1 cb e5 00 50 d9 23 06  .....}^o....P.#.
      0020: a1 2e a0 3e ea 80 10 06  ea c2 47 00 00 01 01 08  ...>......G.....
      0030: 0a 00 68 90 07 12 a6 cf  96 b3 a9 7e 9a           ..h........~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 68
    L2CAP(d): cid 0x0040 len 64 [psm 0]
      0000: 09 ff 74 00 01 7e 21 45  00 00 34 7d 5e 00 40 00  ..t..~!E..4}^.@.
      0010: 3d 06 27 7b d4 3a e2 13  0a e2 d7 18 00 50 d5 4f  =.'{.:.......P.O
      0020: 28 e0 0f 0a d9 e9 7f 5d  80 11 82 18 97 4a 00 00  (......].....J..
      0030: 01 01 08 0a 12 a6 d0 c1  00 68 7a 6f 81 eb 7e 5c  .........hzo..~\
< ACL data: handle 41 flags 0x02 dlen 65
    L2CAP(d): cid 0x0058 len 61 [psm 0]
      0000: 0b ef 73 7e 21 45 00 00  34 08 6e 40 00 40 06 9a  ..s~!E..4.n@.@..
      0010: 0d 0a e2 d7 18 d4 3a e2  13 d5 4f 00 50 d9 e9 7f  ......:...O.P...
      0020: 5d 28 e0 0f 0b 80 10 27  a4 d8 d7 00 00 01 01 08  ](.....'........
      0030: 0a 00 68 93 56 12 a6 d0  c1 85 ca 7e 9a           ..h.V......~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
< ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0058 len 18 [psm 0]
      0000: 0b ef 1d c0 21 09 7d 5d  00 08 a5 76 39 0f 37 e0  ....!.}]...v9.7.
      0010: 7e 9a                                             ~.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 27
    L2CAP(d): cid 0x0040 len 23 [psm 0]
      0000: 09 ff 22 00 02 7e ff 03  c0 21 0a 7d 5d 00 08 3d  .."..~...!.}]..=
      0010: b4 d3 54 c4 94 7e 5c                              ..T..~\
< ACL data: handle 41 flags 0x02 dlen 37
    L2CAP(d): cid 0x0058 len 33 [psm 0]
      0000: 0b ef 3b 7e ff 7d 23 c0  21 7d 25 7d 22 7d 20 7d  ..;~.}#.!}%}"} }
      0010: 30 55 73 65 72 20 72 65  71 75 65 73 74 53 33 7e  0User requestS3~
      0020: 9a                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 09 ff 18 00 01 7e ff 03  c0 21 06 02 00 04 94 0d  .....~...!......
      0010: 7e 5c                                             ~\
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 00 5c                                    ....\
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0058 len 8 [psm 0]
      0000: 03 ef 09 e3 05 0b 89 70                           .......p
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 0]
      0000: 01 ef 08 00 e1 05 0b 89  aa                       .........
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 0]
      0000: 01 ef 08 00 e3 05 0b 0d  aa                       .........
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0058 len 8 [psm 0]
      0000: 03 ef 09 e1 05 0b 0d 70                           .......p
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0058 len 4 [psm 0]
      0000: 0b 53 01 b8                                       .S..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 0]
      0000: 09 ff 1c 00 00 0d 0a 4e  4f 20 43 41 52 52 49 45  .......NO CARRIE
      0010: 52 0d 0a 5c                                       R..\
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 0b 73 01 92                                       .s..
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0058 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0058 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0058 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

--=-dmYgwpvHMzq4Q/nBi9BO--
