Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403161342.44687.cijoml@volny.cz>
Subject: [Bluez-users] bthid errors
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 13:42:44 +0100

Hi,

I am sending hcidump when my keyboard connects via bthid -c 

notas:/home/cijoml# hcidump
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0041 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0041 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x0000 clen 0
> HCI Event: QoS Setup Complete(0x0d) plen 21
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0047 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 4
> ACL data: handle 0x0029 flags 0x01 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 9
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 4
> ACL data: handle 0x0029 flags 0x01 dlen 10
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 13
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0042 result 1 status 2
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0042 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 4
    MTU 48
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x48 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10001
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1200 (PNPInfo) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
               uuid-16 0x0200 > >

ERROR: Unexpected syntax

          cont
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 32
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 18
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 01 09 00 09 35 08 35 06 19 12 00 09 01 00 09 02 00 09 01 00 09 
02 01 09 04 5E 09 02 02 09 00 7B 09 02 03 09 00 02 00 0C
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 0C
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 7
    L2CAP(d): cid 0x42 len 20 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0xf
          cnt 0xc

ERROR: Unexpected syntax
          cont 09 02 04 28 01 09 02 05 09 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x48 len 20 [psm 1]
        SDP SSA Req: tid 0x4 len 0xf
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x41 len 3 [psm 19]
      HIDP: Data: Input report
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1124 (HID) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
               uuid-16 0x0202 > >

ERROR: Unexpected syntax

          cont
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 02 23
> ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x41 len 3 [psm 19]
      HIDP: Data: Input report
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 11 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 00 09 35 08 35 
06 19 11 24 09 01 00 09 00 0D 35 0F 35 0D 35 06 02 01 FD
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x6 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 FD
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 01 00 09 00 13 35 03 19 00 11 09 01 00 25 39 4D 69 63 72 6F 73 
6F 66 74 20 57 69 72 65 6C 65 73 73 20 4F 70 74 02 01 D7
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x7 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 D7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 63 61 6C 20 44 65 73 6B 74 6F 70 20 66 6F 72 20 42 6C 75 65 74 
6F 6F 74 68 20 4B 65 79 62 6F 61 72 64 09 01 01 02 01 B1
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 B1
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 42 6C 75 65 74 6F 6F 74 68 20 6B 65 79 62 6F 61 72 64 09 01 02 
25 09 4D 69 63 72 6F 73 6F 66 74 09 02 00 09 02 01 8B
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x9 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 8B
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x9 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 00 09 02 01 09 01 11 09 02 02 08 40 09 02 03 08 33 09 02 04 28 
01 09 02 05 28 01 09 02 06 36 01 37 36 01 34 08 02 01 65
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xa len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 65
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xa len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 26 01 2F 05 01 09 06 A1 01 85 01 05 08 19 01 29 03 15 00 25 01 
75 01 95 03 91 02 09 4B 95 01 91 02 95 04 91 01 02 01 3F
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xb len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 3F
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xb len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 19 E0 29 E7 95 08 81 02 75 08 95 01 81 01 19 00 29 91 26 FF 00 
95 06 81 00 C0 05 0C 09 01 A1 01 85 02 05 0C 02 01 19
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xc len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 01 19
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xc len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 25 01 75 01 95 1C 09 E2 09 B7 09 CD 09 EA 09 E9 09 B6 09 B5 0A 
83 01 0A 1A 02 0A 79 02 0A AB 01 0A 08 02 0A 02 00 F3
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xd len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 F3
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xd len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 02 0A 03 02 0A 07 02 0A 01 02 0A 92 01 0A 9C 01 09 95 0A 23 02 
0A 89 02 0A 8B 02 0A 8C 02 0A 8A 01 0A 99 01 0A 02 00 CD
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xe len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 CD
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xe len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 0A B7 01 81 02 75 01 95 04 81 01 06 00 FF 0A 02 FF 26 FF 00 95 
01 75 08 81 02 C0 05 01 09 80 A1 01 02 00 A7
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0xf len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 A7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0xf len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 19 81 29 83 25 01 95 03 75 01 81 02 95 05 81 01 C0 05 0C 09 01 
A1 01 85 04 05 01 09 06 A1 02 06 00 FF 15 00 02 00 81
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x10 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 81
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x10 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 95 01 75 02 0A 01 FE 81 02 75 06 81 01 C0 C0 05 0C 09 01 A1 01 
85 05 05 01 09 06 A1 02 06 00 FF 25 01 75 01 02 00 5B
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x11 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 5B
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x11 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 0A 03 FE 0A 04 FE 81 02 95 06 81 01 C0 C0 05 0C 09 01 A1 01 85 
FF 05 06 95 01 75 02 19 24 29 26 81 02 75 06 02 00 35
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x12 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 35
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
> ACL data: handle 0x0029 flags 0x01 dlen 25
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x12 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          cont 01 C0 09 02 07 35 08 35 06 09 03 09 09 01 00 09 02 08 28 00 09 
02 09 28 01 09 02 0A 28 01 09 02 0B 09 01 00 09 02 00 0F
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x48 len 22 [psm 1]
        SDP SSA Req: tid 0x13 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 0F
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 27
    L2CAP(d): cid 0x42 len 23 [psm 1]
        SDP SSA Rsp: tid 0x13 len 0x12
          cnt 0xf

ERROR: Unexpected syntax
          cont 0C 09 1F 40 09 02 0D 28 00 09 02 0E 28 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x46 len 3 [psm 19]
      HIDP: Data: Output report
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0042
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0042
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
