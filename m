Return-Path: <cyrus@holtmann.org>
From: Laurent Almeras <lntalm@free.fr>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-cQ9wAKJNssfXwm0yIfLX"
Date: Sat, 03 May 2008 18:42:14 +0200
Message-Id: <1209832934.29676.14.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Link authentication problem with Logitech Dinovo Edge
Reply-To: lntalm@free.fr,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-cQ9wAKJNssfXwm0yIfLX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,


I'm currently experiencing connection problem with my Logitech Dinovo
keyboard. I can realise pairing via gnome bluetooth-applet (popup asks
for passkey, I type in on computer, then on keyboard => popup says all
is fine). But then, each time I type a key on the bt keyboard, I have
the following message in /var/log/messages and the connection fails (in
the gnome bluetooth program, connect icon appears for 2 seconds then
disappear).


May  3 18:00:36 localhost hcid[27281]: Link authentication failed:
Connection timed out (110)
May  3 18:00:36 localhost hcid[27281]: link_key_request
(sba=00:15:83:BB:88:3B, dba=00:07:61:74:7A:82)


This problem appear with bluez 3.30 on Fedora core 9 (dev). Fedora
patches doesn't seem to be linked with this problem.

With ubuntu & bluez 2.26 keyboard works fine.

With Fedora core 9 and old packages from core 8 (bluez 3.20), keyboard
works fine too.

I also have a bluetooth mouse which works with all the configuration
listed above (it doesn't need pin pairing).

I join hcidump -X dumps done with bluez 3.30 and 3.20 on FC9.

I try to debug hcid ; it confirms that i/o timeout is issued in hci.c,
hci_read_req, but I'm not able to understand where is the problem (this
file doesn't seem to change between 3.26 and 3.30).


If anyone is interested by this problem I can provide further
informations on demand.


Laurent

--=-cQ9wAKJNssfXwm0yIfLX
Content-Disposition: attachment; filename=hci-3.30.dump
Content-Type: text/plain; name=hci-3.30.dump; charset=utf8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.41
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 82 7a 74 61 07 00 40 25  00 01                    .zta..@%..
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 82 7a 74 61 07 00 00                              .zta...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 82 7a 74 61 07 00 00                           ..zta...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2a 00 82 7a 74 61 07  00 01 00                 .*..zta....
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 2a 00                                             *.
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 82 7a 74 61 07 00 00                              .zta...
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0048
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
      Connection successful
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2a 00 0f 00                                       *...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      MTU 185 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 2a 00 bc 02 04 38 08  00 00 00                 .*....8....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2a 00                                 ....*.
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2a 00 18 cc                                       *...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 82 7a 74 61 07 00 02 00  00 00                    .zta......
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2a 00 1e 33                                    .*..3
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0049
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0049 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
      MTU 185 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 00 28 00 00 00 00  00                       ...(.....
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  0000: 2a 00                                             *.
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 00 00 00 00 00 00  00                       .........
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 19]
      HIDP: Data: Input report
      0000: 10 00 4b 01 00 00 00                              ..K....
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 82 7a 74 61 07 00 4c  6f 67 69 74 65 63 68 20  ..zta..Logitech 
  0010: 64 69 4e 6f 76 6f 20 45  64 67 65 00 00 00 00 00  diNovo Edge.....
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: QoS Setup Complete (0x0d) plen 21
  0000: 00 2a 00 00 01 00 00 00  00 00 00 00 00 20 4e 00  .*........... N.
  0010: 00 ff ff ff ff                                    .....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 11 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 82 7a 74 61 07 00                                 .zta..
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2a 00 02 12 00                                 .*....
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0049 scid 0x0041
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 82 7a 74 61 07 00 8c 87  8a 7e 9e 36 a6 5f be 04  .zta.....~.6._..
  0010: a7 4c 71 22 2e 0b                                 .Lq"..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 82 7a 74 61  07 00                    .....zta..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0041
> HCI Event: Auth Complete (0x06) plen 3
  0000: 00 2a 00                                          .*.
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2a 00 00 00 00                                 .*....
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2a 00 02 6c 00                                 .*..l.

--=-cQ9wAKJNssfXwm0yIfLX
Content-Disposition: attachment; filename=hci-3.20.dump
Content-Type: text/plain; name=hci-3.20.dump; charset=utf8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.41
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2b 00 08                                       .+..
> HCI Event: Connect Request (0x04) plen 10
  0000: 82 7a 74 61 07 00 40 25  00 01                    .zta..@%..
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 82 7a 74 61 07 00 01                              .zta...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2c 00 82 7a 74 61 07  00 01 00                 .,..zta....
< ACL data: handle 44 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 2c 00                                             ,.
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 82 7a 74 61 07 00 00                              .zta...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 00 1b 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 00 00                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2c 00 0f 00                                       ,...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2c 00                                 ....,.
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2c 00 18 cc                                       ,...
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 2c 00 bc 02 04 38 08  00 00 00                 .,....8....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 82 7a 74 61 07 00 02 00  00 00                    .zta......
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2c 00 1e 33                                    .,..3
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 82 7a 74 61 07 00 4c  6f 67 69 74 65 63 68 20  ..zta..Logitech 
  0010: 64 69 4e 6f 76 6f 20 45  64 67 65 00 00 00 00 00  diNovo Edge.....
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Role Change (0x12) plen 8
  0000: 00 82 7a 74 61 07 00 00                           ..zta...
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 185 
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 185 
< ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 185 
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 185 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  0000: 2c 00                                             ,.
> HCI Event: QoS Setup Complete (0x0d) plen 21
  0000: 00 2c 00 00 01 00 00 00  00 00 00 00 00 20 4e 00  .,........... N.
  0010: 00 ff ff ff ff                                    .....
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 19]
      HIDP: Data: Input report
      0000: 10 00 4b 01 00 00 00                              ..K....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 11 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 82 7a 74 61 07 00                                 .zta..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 82 7a 74 61 07 00 8c 87  8a 7e 9e 36 a6 5f be 04  .zta.....~.6._..
  0010: a7 4c 71 22 2e 0b                                 .Lq"..
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 82 7a 74 61  07 00                    .....zta..
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2c 00 02 12 00                                 .,....
> HCI Event: Auth Complete (0x06) plen 3
  0000: 00 2c 00                                          .,.
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 2c 00 01                                          ,..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2a 00 00 00 00                                 .*....
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 00 2c 00 01                                       .,..
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2a 00 02 e0 01                                 .*....
< ACL data: handle 44 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Output report
      0000: 02 00 00 00 00 00 00 00                           ........
< ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 01 00 00 00 00 00 00 00  00                       .........
< ACL data: handle 44 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Output report
      0000: 03 00 00 00 00                                    .....
< ACL data: handle 44 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: ac 00                                             ..
< ACL data: handle 44 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 04 00                                             ..

--=-cQ9wAKJNssfXwm0yIfLX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-cQ9wAKJNssfXwm0yIfLX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-cQ9wAKJNssfXwm0yIfLX--
