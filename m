Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41474247.8090602@uni-paderborn.de>
Date: Tue, 14 Sep 2004 21:11:03 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de> <1095186861.5695.193.camel@pegasus>
In-Reply-To: <1095186861.5695.193.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel & List!

Marcel Holtmann schrieb:

>run "hcidump -x" as root and show us the problematic parts. What kind of
>dongles are you using? Do you changed any of hcid.conf settings or do
>you set the master/rswitch on the listening L2CAP socket?
>  
>
I'm using Acer BT600 Class II dongles (CSR chipset I think).
00:02:72:B1:1D:6C is a listening server (master).
00:02:72:B1:1D:62 is also a listening server (master).
00:02:72:B1:59:46 is the connecting client (slave).

The client connects to the servers sequentially, so the slave should not 
be connected to two masters at the same time. But I don't know how fast 
the ACL link is disconnected after closing the L2CAP socket. This could 
be a problem. Although my dongles should be able to manage 1 slave 
connected to 2 masters, I think it's not a good idea. I don't like to 
switch the master-slave role, since then, the server could not handle 
more than 2 clients (if at all).

Ok, here comes the hcidump. The first few rounds are ok. Then I put my 
hand around the dongle 00:02:72:B1:1D:62 so the client 00:02:72:B1:59:46 
can't connect to it anymore. But the connection attempts to 
00:02:72:B1:1D:6C are also affected by that. They fail almost always. 
Can anyone see why?

Regards
Stefan

HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 29 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 29 00 FF
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0029 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0029 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2D 00 62 1D B1 72 02 00 01 00
< ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2D 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2D 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2D 00 05
 > ACL data: handle 0x002d flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002d flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > ACL data: handle 0x002d flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002d flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002d flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2D 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2D 00 FB
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2D 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2D 00 FF
< ACL data: handle 0x002d flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002d flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002d flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002d flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > ACL data: handle 0x002d flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > ACL data: handle 0x002d flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002d flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002d flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002d flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002d flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
 > ACL data: handle 0x002d flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002d flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002d flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002d flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2D 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2D 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2D 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2A 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2A 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2A 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2A 00 05
 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2A 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2A 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2A 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2A 00 FF
< ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002a flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002a flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002a flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002a flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002a flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002a flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002a flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002a flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002a flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2A 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2A 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2F 00 62 1D B1 72 02 00 01 00
< ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2F 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2F 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2F 00 05
 > ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002f flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2F 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2F 00 FC
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2F 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2F 00 FF
< ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002f flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002f flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002f flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002f flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002f flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002f flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002f flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002f flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002f flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002f flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2F 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2F 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2B 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2B 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2B 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Max Slots Change(0x1b) plen 3
  2B 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2B 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2B 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2B 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2B 00 FF
< ACL data: handle 0x002b flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002b flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002b flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002b flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 02 00
 > ACL data: handle 0x002b flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002b flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002b flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002b flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002b flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002b flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002b flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002b flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2B 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2B 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 62 1D B1 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 29 00 FA
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  29 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 29 00 FF
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0029 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0029 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2A 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2A 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2A 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2A 00 05
 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2A 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2A 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2A 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2A 00 FF
< ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002a flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002a flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002a flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002a flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002a flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002a flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002a flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002a flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002a flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
 > ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2A 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2A 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 30 00 62 1D B1 72 02 00 01 00
< ACL data: handle 0x0030 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  30 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 30 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  30 00 05
 > ACL data: handle 0x0030 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0030 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > ACL data: handle 0x0030 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0030 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0030 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  30 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 30 00 FD
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  30 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 30 00 FF
< ACL data: handle 0x0030 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
< ACL data: handle 0x0030 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0030 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0030 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > ACL data: handle 0x0030 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > ACL data: handle 0x0030 flags 0x02 dlen 17
 > ACL data: handle 0x0030 flags 0x01 dlen 17
 > ACL data: handle 0x0030 flags 0x01 dlen 17
 > ACL data: handle 0x0030 flags 0x01 dlen 17
 > ACL data: handle 0x0030 flags 0x01 dlen 13
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0030 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0030 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0030 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0030 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0030 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
 > ACL data: handle 0x0030 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0030 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0030 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x0030 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0030 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 30 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  30 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 30 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2C 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x002c flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2C 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2C 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2C 00 05
 > ACL data: handle 0x002c flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002c flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > ACL data: handle 0x002c flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002c flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002c flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2C 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2C 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2C 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2C 00 FF
< ACL data: handle 0x002c flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002c flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002c flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002c flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > ACL data: handle 0x002c flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > ACL data: handle 0x002c flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002c flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002c flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002c flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002c flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002c flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
 > ACL data: handle 0x002c flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002c flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002c flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002c flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002c flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2C 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2C 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2C 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2F 00 62 1D B1 72 02 00 01 00
< ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2F 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2F 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2F 00 05
 > ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002f flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002f flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2F 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2F 00 FE
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2F 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2F 00 FF
< ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
< ACL data: handle 0x002f flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002f flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x002f flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 13
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002f flags 0x02 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 17
 > ACL data: handle 0x002f flags 0x01 dlen 11
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002f flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002f flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002f flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002f flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
 > ACL data: handle 0x002f flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002f flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002f flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2F 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2F 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2F 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2B 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2B 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2B 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2B 00 05
 > ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x002b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x002b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  2B 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 2B 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  2B 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 2B 00 FF
< ACL data: handle 0x002b flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x002b flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x002b flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
< ACL data: handle 0x002b flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x002b flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x002b flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x002b flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x002b flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x002b flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
 > ACL data: handle 0x002b flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x002b flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x002b flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x002b flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2B 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  2B 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 2B 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  0C 01 05 04
 > HCI Event: Connect Complete(0x03) plen 11
  04 00 00 62 1D B1 72 02 00 01 00
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 29 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 29 00 FC
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0029 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0029 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  0C 01 05 04
 > HCI Event: Connect Complete(0x03) plen 11
  04 00 00 62 1D B1 72 02 00 01 00
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 29 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  29 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 29 00 FF
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0029 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0029 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  0C 01 05 04
 > HCI Event: Connect Complete(0x03) plen 11
  04 00 00 62 1D B1 72 02 00 01 00
< HCI Command: Create Connection(0x01|0x0005) plen 13
  6C 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change(0x12) plen 8
  00 6C 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 6C 1D B1 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 136 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  6C 1D B1 72 02 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 255
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< HCI Command: Read RSSI(0x05|0x0005) plen 2
  29 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 05 14 00 29 00 00
< HCI Command: Get Link Quality(0x05|0x0003) plen 2
  29 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete(0x0e) plen 7
  01 03 14 00 29 00 FF
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
< ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x40 len 48 [psm 136]
      73 72 00 21 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 71 75 65 73 74 A1 D5 1D
      42 10 6E 06 E0 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
< ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 136]
      AC ED 00 05
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 81
    L2CAP(d): cid 0x40 len 77 [psm 136]
      73 72 00 22 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 4E 61 6D 65 52 65 73 70 6F 6E 73 65 76 7D
      F4 5B 1B FE 13 06 02 00 01 4C 00 04 6E 61 6D 65 74 00 12 4C
      6A 61 76 61 2F 6C 61 6E 67 2F 53 74 72 69 6E 67 3B
 > ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 136]
      78 72 00 1A 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 65 73 73 61 67 65 0B 5E 4A 75 9F 43 6E A7 02 00
      00
 > ACL data: handle 0x0029 flags 0x02 dlen 6
    L2CAP(d): cid 0x40 len 2 [psm 136]
      78 70
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 136]
      74 00 0A 54 65 73 74 53 65 72 76 65 72
< ACL data: handle 0x0029 flags 0x02 dlen 55
    L2CAP(d): cid 0x40 len 51 [psm 136]
      73 72 00 24 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 71 75 65 73 74
      19 0D EF 40 73 87 D4 D5 02 00 00
< ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 01
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 71
    L2CAP(d): cid 0x40 len 67 [psm 136]
      73 72 00 25 64 65 2E 75 70 62 2E 6A 74 6F 6F 74 68 2E 64 65
      6D 6F 2E 4D 73 67 43 6F 6E 74 65 6E 74 52 65 73 70 6F 6E 73
      65 D0 C0 0F B1 05 F4 9F D7 02 00 01 4C 00 07 63 6F 6E 74 65
      6E 74 71 00 7E 00 01
 > ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 136]
      78 71 00 7E 00 02
 > ACL data: handle 0x0029 flags 0x02 dlen 123
    L2CAP(d): cid 0x40 len 119 [psm 136]
      74 00 74 3C 68 74 6D 6C 3E 0A 3C 68 65 61 64 3E 0A 3C 68 31
      3E 54 68 69 73 20 70 61 67 65 20 77 65 6E 74 20 6F 6E 20 61
      69 72 21 21 21 3C 2F 68 31 3E 0A 3C 2F 68 65 61 64 3E 0A 3C
      62 6F 64 79 3E 0A 54 65 73 74 50 61 67 65 20 73 75 63 63 65
      73 73 66 75 6C 6C 79 20 74 72 61 6E 73 6D 69 74 74 65 64 21
      21 21 0A 3C 2F 62 6F 64 79 3E 0A 3C 2F 68 74 6D 6C 3E 0A
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
< HCI Command: Create Connection(0x01|0x0005) plen 13
  62 1D B1 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
 > HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16
 > HCI Event: Role Change(0x12) plen 8
  00 62 1D B1 72 02 00 01
 > HCI Event: Connect Complete(0x03) plen 11
  00 2D 00 62 1D B1 72 02 00 01 00
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  2D 00 0F 00
 > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  62 1D B1 72 02 00 01
 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2D 00
 > HCI Event: Max Slots Change(0x1b) plen 3
  2D 00 05 
