Return-Path: <cyrus@holtmann.org>
Message-ID: <50B6F8A3.7040908@globaledgesoft.com>
Date: Thu, 29 Nov 2012 11:24:43 +0530
From: Deepthi <deepthi.pv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, bluefrog2012@gmail.com
Subject: Sco issue:iogear dongle
Content-Type: multipart/mixed;
 boundary="------------030502000906030901090500"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030502000906030901090500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Thank you for the reply. Here I have attached  the hcidump logs from 
both sides (server & client side).

Please help,

-- 
Thanks & Regards,
Deepthi Elizabeth P V


--------------030502000906030901090500
Content-Type: text/plain;
 name="sco_connreq_hcidump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco_connreq_hcidump.txt"


2012-11-29 11:05:11.821785 > ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2012-11-29 11:05:11.821803 < ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic) 
2012-11-29 11:05:11.825534 > ACL data: handle 12 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic) 
2012-11-29 11:05:11.825545 < ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
2012-11-29 11:05:11.830534 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
2012-11-29 11:05:11.831286 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
2012-11-29 11:05:12.002285 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
2012-11-29 11:05:12.100652 < HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 12
2012-11-29 11:05:12.102283 > HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 12 rssi -15
2012-11-29 11:05:12.102317 < HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 12
2012-11-29 11:05:12.103284 > HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 12 lq 255
2012-11-29 11:05:12.103314 < HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 12 type 0 (current)
2012-11-29 11:05:12.104285 > HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 12 level 3
2012-11-29 11:05:12.830703 < ACL data: handle 12 flags 0x00 dlen 132
    L2CAP(d): cid 0x0040 len 128 [psm 4113]
      0000: 52 49 46 46 e2 0f 00 00  57 41 56 45 66 6d 74 20  RIFF....WAVEfmt 
      0010: 10 00 00 00 01 00 01 00  44 ac 00 00 88 58 01 00  ........D....X..
      0020: 02 00 10 00 64 61 74 61  b8 0f 00 00 00 00 00 00  ....data........
      0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
2012-11-29 11:05:12.850154 > ACL data: handle 12 flags 0x02 dlen 132
    L2CAP(d): cid 0x0040 len 128 [psm 4113]
      0000: 52 49 46 46 e2 0f 00 00  57 41 56 45 66 6d 74 20  RIFF....WAVEfmt 
      0010: 10 00 00 00 01 00 01 00  44 ac 00 00 88 58 01 00  ........D....X..
      0020: 02 00 10 00 64 61 74 61  b8 0f 00 00 00 00 00 00  ....data........
      0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
2012-11-29 11:05:12.850236 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 12 voice setting 0x0060 ptype 0x0008
2012-11-29 11:05:12.851279 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2012-11-29 11:05:12.874279 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 6 bdaddr 00:02:72:D6:AB:AD type eSCO
    Air mode: CVSD


--------------030502000906030901090500
Content-Type: text/plain;
 name="sco_connaccept_hcidump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco_connaccept_hcidump.txt"

1354166949.194632 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
1354166949.194637 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4113 scid 0x0040
1354166949.194654 < ACL data: handle 11 flags 0x00 dlen 16
    0000: 0c 00 01 00 03 03 08 00  40 00 40 00 01 00 00 00  ........@.@.....
1354166949.194656 < ACL data: handle 11 flags 0x00 dlen 10
    0000: 06 00 01 00 0a 01 02 00  02 00                    ..........
1354166949.230631 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
1354166949.231632 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
1354166949.231641 < ACL data: handle 11 flags 0x00 dlen 10
    0000: 06 00 01 00 0a 02 02 00  03 00                    ..........
1354166949.247632 > ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Unknown (len 8)
1354166949.247642 < ACL data: handle 11 flags 0x00 dlen 16
    0000: 0c 00 01 00 03 03 08 00  40 00 40 00 00 00 00 00  ........@.@.....
1354166949.247645 < ACL data: handle 11 flags 0x00 dlen 23
    0000: 13 00 01 00 04 03 0f 00  40 00 00 00 04 09 00 00  ........@.......
    0010: 00 00 00 00 00 00 00                              .......
1354166949.298632 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
1354166949.298636 > ACL data: handle 11 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic) 
1354166949.298647 < ACL data: handle 11 flags 0x00 dlen 18
    0000: 0e 00 01 00 05 04 0a 00  40 00 00 00 00 00 01 02  ........@.......
    0010: a0 02                                             ..
1354166949.306632 > ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
1354166949.307631 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
1354166949.566793 < HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 0b 00                                             ..
1354166949.568632 > HCI Event: Command Complete (0x0e) plen 7
  0000: 01 05 14 00 0b 00 f0                              .......
1354166949.568729 < HCI Command: Read Link Quality (0x05|0x0003) plen 2
  0000: 0b 00                                             ..
1354166949.570631 > HCI Event: Command Complete (0x0e) plen 7
  0000: 01 03 14 00 0b 00 ff                              .......
1354166949.570661 < HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
  0000: 0b 00 00                                          ...
1354166949.572631 > HCI Event: Command Complete (0x0e) plen 7
  0000: 01 2d 0c 00 0b 00 03                              .-.....
1354166950.319635 > ACL data: handle 11 flags 0x02 dlen 132
    L2CAP(d): cid 0x0040 len 128 [psm 0]
      0000: 52 49 46 46 e2 0f 00 00  57 41 56 45 66 6d 74 20  RIFF....WAVEfmt 
      0010: 10 00 00 00 01 00 01 00  44 ac 00 00 88 58 01 00  ........D....X..
      0020: 02 00 10 00 64 61 74 61  b8 0f 00 00 00 00 00 00  ....data........
      0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
      0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
1354166950.319679 < ACL data: handle 11 flags 0x00 dlen 132
    0000: 80 00 40 00 52 49 46 46  e2 0f 00 00 57 41 56 45  ..@.RIFF....WAVE
    0010: 66 6d 74 20 10 00 00 00  01 00 01 00 44 ac 00 00  fmt ........D...
    0020: 88 58 01 00 02 00 10 00  64 61 74 61 b8 0f 00 00  .X......data....
    0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0080: 00 00 00 00                                       ....
1354166950.329632 > HCI Event: Connect Request (0x04) plen 10
  0000: 79 97 d6 72 02 00 00 01  18 02                    y..r......
1354166950.329660 < HCI Command: Accept Synchronous Connection (0x01|0x0029) plen 21
  0000: 79 97 d6 72 02 00 40 1f  00 00 40 1f 00 00 ff ff  y..r..@...@.....
  0010: 60 00 ff 08 00                                    `....
1354166950.331633 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 29 04                                       ..).
1354166950.350635 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
  0000: 00 06 00 79 97 d6 72 02  00 02 22 00 aa 00 aa 00  ...y..r...".....
  0010: 02                                                .


--------------030502000906030901090500--
