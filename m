Return-Path: <lta@creativemonsters.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: =?iso-8859-1?Q?Re:_[Bluez-devel]_pand_Connection_refused(111)_when_connecting_to_a_Belkin_NAP?=
From: <lta@creativemonsters.com>
Message-Id: <27345483$110790477642094908d86d51.65090625@config17.schlund.de>
Content-Type: text/plain;
	charset="iso-8859-1"
Mime-Version: 1.0
Date: Wed,  9 Feb 2005 00:42:01 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


Hi there,


I have exactly the same problem as Dave Henriksen !!!  :-(


RFCOMM works ( connects ) fine, but PAND simply fails with "Connection
refused(111)".


My log tells me...

Feb  8 23:12:32 slave kernel: hciconfig[3728]: segfault at
00000000000000a9 rip 0000002a957d2c0c rsp 0000007fbfffef50 error 4
Feb  8 23:29:24 slave kernel: Bluetooth: BNEP (Ethernet Emulation) ver
1.2
Feb  8 23:29:24 slave kernel: Bluetooth: BNEP filters: protocol
multicast
Feb  8 23:29:24 slave pand[3760]: Bluetooth PAN daemon
Feb  8 23:29:24 slave pand[3760]: Connecting to 00:02:72:00:EB:4D
Feb  8 23:29:28 slave pand[3760]: Connect to 00:02:72:00:EB:4D failed.
Connection refused(111)


Hcidump tells me...

[root@slave ~]# hcidump -X
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 4d eb 00 72 02 00 18 cc 02 00 00 00 01            M..r.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 4d eb 00 72 02 00 01                           .M..r...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 4d eb 00 72 02 00 01 00                  .).M..r....
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 4d eb 00 72 02 00 01                              M..r...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 29 00 13                                          )..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 16


Any ideas ( Linux newbie ) ???


Many thanks in advance,


Leon
