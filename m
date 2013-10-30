Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Alexander Holler <holler@ahsoftware.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Wed, 30 Oct 2013 15:16:27 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419D0@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
 <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de>,<D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>,<D9B9EB3A112B8F489DFFA00A6D5C0FE2032419C0@AD-BR-EX-2.adroot.flemingc.local>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419C0@AD-BR-EX-2.adroot.flemingc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before someone asks...

root@linaro-server:~# cat /proc/cpuinfo
Processor	: ARMv7 Processor rev 2 (v7l)
BogoMIPS	: 59.90
Features	: swp half thumb fastmult vfp edsp neon vfpv3 tls 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x3
CPU part	: 0xc08
CPU revision	: 2

Hardware	: sun4i
Revision	: 0000
Serial		: 0000000000000000
root@linaro-server:~# lscpu
Architecture:          armv7l
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
root@linaro-server:~# uname -a
Linux linaro-server 3.4.43 #6 PREEMPT Mon Aug 19 16:40:34 EDT 2013 armv7l armv7l armv7l GNU/Linux

But this isn't the only ARM machine or only kernel I've had this problem on...

________________________________________
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org] on behalf of Tim Tisdall [tim.tisdall@flemingcollege.ca]
Sent: October 30, 2013 11:10 AM
To: Alexander Holler
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: l2cap sockets not properly multiplexed on ARM

Okay, I tried it again with the other notifications on the 2nd device shut off. (same result)  I noticed that if I shut off the 2nd gatttool the notification return back to the first running gatttool.
________________________________________
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org] on behalf of Tim Tisdall [tim.tisdall@flemingcollege.ca]
Sent: October 30, 2013 11:06 AM
To: Alexander Holler
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: l2cap sockets not properly multiplexed on ARM

Yes, confirmed with gatttool.  I used 3 terminals with one running btmon and the other 2 gatttool.  I started btmon then ran gatttool on one terminal starting the notifications.  Then I started another gatttool in another terminal and that new one then showed the results of both devices while the first gatttool stopped displaying any new notifications.  You can see in the btmon that the values are coming from 2 different connection handles but the results are all coming through the 2nd gatttool.  Here's the outputs using 3 terminals connected to the device (first listing was connected first):

So it's perfectly clear:  This all works fine on an x86 machine, but is an issue on ARM

--------------------
root@linaro-server:~# gatttool -i 0 -b 78:C5:E5:6C:47:D3 --char-write-req --handle=0x002b --value=0100 --listen
Characteristic value was written successfully
Notification handle = 0x002a value: e9
Notification handle = 0x002a value: f9
Notification handle = 0x002a value: 06
Notification handle = 0x002a value: db
Notification handle = 0x002a value: e8
Notification handle = 0x002a value: f0
Notification handle = 0x002a value: dd
Notification handle = 0x002a value: fa
Notification handle = 0x002a value: 00
Notification handle = 0x002a value: f7
Notification handle = 0x002a value: 00

--------------------
root@linaro-server:~# gatttool -i 0 -b 78:C5:E5:6C:47:A2  --char-write-req --handle=0x002b --value=0100 --listen
Characteristic value was written successfully
Notification handle = 0x002e value: fa
Notification handle = 0x0032 value: c1
Notification handle = 0x002a value: 0b
Notification handle = 0x002e value: e7
Notification handle = 0x0032 value: da
Notification handle = 0x002a value: 9d
Notification handle = 0x002e value: 80
Notification handle = 0x0032 value: 80
Notification handle = 0x002a value: ff
Notification handle = 0x002e value: fa
Notification handle = 0x0032 value: c8
Notification handle = 0x0032 value: c1
Notification handle = 0x002a value: 43
Notification handle = 0x002a value: f4
Notification handle = 0x002a value: ee
Notification handle = 0x002a value: e0
Notification handle = 0x002a value: f0
Notification handle = 0x002a value: fe
Notification handle = 0x002a value: 04
Notification handle = 0x002a value: fe
Notification handle = 0x002a value: 17
Notification handle = 0x002e value: 35
Notification handle = 0x0032 value: 83
Notification handle = 0x002a value: 07
Notification handle = 0x002e value: f5
Notification handle = 0x0032 value: c1
Notification handle = 0x0032 value: ca
Notification handle = 0x002e value: 11
Notification handle = 0x0032 value: c4
Notification handle = 0x002e value: 06
Notification handle = 0x0032 value: ba
Notification handle = 0x002a value: fc
Notification handle = 0x002e value: fb
Notification handle = 0x0032 value: c6
Notification handle = 0x0032 value: c0
Notification handle = 0x002a value: e3
Notification handle = 0x002a value: f7
Notification handle = 0x002a value: b4
Notification handle = 0x002a value: f8
Notification handle = 0x002a value: 03
Notification handle = 0x002a value: f5
Notification handle = 0x002a value: 0d
Notification handle = 0x002a value: 04
Notification handle = 0x002a value: fc
Notification handle = 0x002a value: 02
Notification handle = 0x002a value: ae
Notification handle = 0x002e value: 9f
Notification handle = 0x0032 value: a5
Notification handle = 0x002a value: 14
Notification handle = 0x002e value: fb
Notification handle = 0x0032 value: b2
Notification handle = 0x002a value: e8
Notification handle = 0x0032 value: a8
Notification handle = 0x002a value: 08
Notification handle = 0x002e value: 0e
Notification handle = 0x0032 value: c4
Notification handle = 0x002a value: 57
Notification handle = 0x002e value: 7a
Notification handle = 0x002a value: fd
Notification handle = 0x002e value: f9
Notification handle = 0x002a value: 10
Notification handle = 0x002a value: ea
Notification handle = 0x002a value: 22
Notification handle = 0x002a value: ff
Notification handle = 0x002a value: 4d
Notification handle = 0x002e value: df
Notification handle = 0x0032 value: d8
Notification handle = 0x002a value: 03
Notification handle = 0x002e value: ff
Notification handle = 0x0032 value: b6
Notification handle = 0x002a value: 19
Notification handle = 0x002e value: 08
Notification handle = 0x0032 value: f8
Notification handle = 0x002a value: f4
Notification handle = 0x002e value: fb
Notification handle = 0x0032 value: ea
Notification handle = 0x002a value: 01
Notification handle = 0x0032 value: ba
Notification handle = 0x0032 value: c2

--------------------
root@linaro-server:~# /usr/src/bluez-4.101/monitor/btmon
Bluetooth monitor ver 4.101
[hci0] 14:59:31.455948 = New Index: 00:02:72:3E:7F:9B (BR/EDR,USB,hci0)
[hci0] 14:59:37.419288 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
            60 00 30 00 00 00 d3 47 6c e5 c5 78 00 28 00 38  `.0....Gl..x.(.8
            00 00 00 2a 00 00 00 00 00                       ...*.....
[hci0] 14:59:37.426536 > HCI Event: Command Status (0x0f) plen 4
            00 01 0d 20                                      ...
[hci0] 14:59:39.342084 > HCI Event: LE Meta Event (0x3e) plen 19
            01 00 40 00 00 00 d3 47 6c e5 c5 78 36 00 00 00  ..@....Gl..x6...
            2a 00 05                                         *..
{hci0} 14:59:39.342742 @ Device Connected: 78:C5:E5:6C:47:D3 (1) flags 0x0000
[hci0] 14:59:39.356628 < ACL Data: handle 64 flags 0x00 dlen 9
            05 00 04 00 12 2b 00 01 00                       .....+...
[hci0] 14:59:39.511039 > ACL Data: handle 64 flags 0x02 dlen 16
            0c 00 05 00 12 07 08 00 10 00 20 00 00 00 2c 01  .......... ...,.
[hci0] 14:59:39.513756 < ACL Data: handle 64 flags 0x00 dlen 10
            06 00 05 00 13 07 02 00 00 00                    ..........
[hci0] 14:59:39.513982 < HCI Command: LE Connection Update (0x08|0x0013) plen 14
            40 00 10 00 20 00 00 00 2c 01 01 00 01 00        @... ...,.....
[hci0] 14:59:39.515988 > HCI Event: Command Status (0x0f) plen 4
            00 01 13 20                                      ...
[hci0] 14:59:39.578489 > ACL Data: handle 64 flags 0x02 dlen 5
            01 00 04 00 13                                   .....
[hci0] 14:59:39.645900 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 e9                          .....*..
[hci0] 14:59:39.647117 > HCI Event: Number of Completed Packets (0x13) plen 5
            01 40 00 02 00                                   .@...
[hci0] 14:59:39.781014 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f9                          .....*..
[hci0] 14:59:39.915999 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 06                          .....*..
[hci0] 14:59:39.983479 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 db                          .....*..
[hci0] 14:59:40.185988 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 e8                          .....*..
[hci0] 14:59:40.253477 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f0                          .....*..
[hci0] 14:59:40.590870 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 dd                          .....*..
[hci0] 14:59:40.595926 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fa                          .....*..
[hci0] 14:59:40.793513 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 00                          .....*..
[hci0] 14:59:46.452653 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
            60 00 30 00 00 00 a2 47 6c e5 c5 78 00 28 00 38  `.0....Gl..x.(.8
            00 00 00 2a 00 00 00 00 00                       ...*.....
[hci0] 14:59:46.454025 > HCI Event: Command Status (0x0f) plen 4
            00 01 0d 20                                      ...
[hci0] 14:59:47.507002 > HCI Event: LE Meta Event (0x3e) plen 19
            01 00 41 00 00 00 a2 47 6c e5 c5 78 2d 00 00 00  ..A....Gl..x-...
            2a 00 05                                         *..
[hci0] 14:59:47.516637 < ACL Data: handle 65 flags 0x00 dlen 9
            05 00 04 00 12 2b 00 01 00                       .....+...
{hci0} 14:59:47.507516 @ Device Connected: 78:C5:E5:6C:47:A2 (1) flags 0x0000
[hci0] 14:59:47.964127 > HCI Event: Disconn Complete (0x05) plen 4
            00 41 00 08                                      .A..
{hci0} 14:59:47.974180 @ Device Disconnected: 78:C5:E5:6C:47:A2 (1)
[hci0] 14:59:54.564158 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 b4                          .....*..
[hci0] 14:59:54.698625 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 05                          .....*..
[hci0] 14:59:54.766114 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f7                          .....*..
[hci0] 14:59:54.968591 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 00                          .....*..
[hci0] 14:59:55.171092 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 14                          .....*..
[hci0] 14:59:55.306083 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 02                          .....*..
[hci0] 14:59:55.441107 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ee                          .....*..
[hci0] 14:59:55.508612 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f8                          .....*..
[hci0] 14:59:55.576088 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 03                          .....*..
[hci0] 14:59:55.711106 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 1b                          .....*..
[hci0] 14:59:55.778607 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fe                          .....*..
[hci0] 14:59:55.913607 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 0f                          .....*..
[hci0] 14:59:55.981116 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 04                          .....*..
[hci0] 14:59:56.183619 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fe                          .....*..
[hci0] 15:00:24.952798 < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
            01 10 00 10 00 00 00                             .......
[hci0] 15:00:24.954958 > HCI Event: Command Complete (0x0e) plen 4
            01 0b 20 00                                      .. .
[hci0] 15:00:24.959834 < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
            01 01                                            ..
[hci0] 15:00:24.962354 > HCI Event: Command Complete (0x0e) plen 4
            01 0c 20 00                                      .. .
{hci0} 15:00:24.963556 @ Discovering: 0x01 (0)
[hci0] 15:00:25.074841 > HCI Event: LE Meta Event (0x3e) plen 15
            02 01 00 00 a2 47 6c e5 c5 78 03 02 01 05 a2     .....Gl..x.....
[hci0] 15:00:25.077321 > HCI Event: LE Meta Event (0x3e) plen 25
            02 01 04 00 a2 47 6c e5 c5 78 0d 0c 09 4f 42 50  .....Gl..x...OBP
            34 32 35 2d 34 37 41 32 a4                       425-47A2.
{hci0} 15:00:25.075571 @ Device Found: 78:C5:E5:6C:47:A2 (1) rssi -94 flags 0x0000
            02 01 05                                         ...
{hci0} 15:00:25.078879 @ Device Found: 78:C5:E5:6C:47:A2 (1) rssi -92 flags 0x0000
            0c 09 4f 42 50 34 32 35 2d 34 37 41 32           ..OBP425-47A2
[hci0] 15:00:29.259153 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f7                          .....*..
[hci0] 15:00:29.394528 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 00                          .....*..
[hci0] 15:00:30.976520 < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
            00 01                                            ..
[hci0] 15:00:30.982418 > HCI Event: Command Complete (0x0e) plen 4
            01 0c 20 00                                      .. .
{hci0} 15:00:30.983404 @ Discovering: 0x00 (0)
[hci0] 15:00:33.275402 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
            60 00 30 00 00 00 a2 47 6c e5 c5 78 00 28 00 38  `.0....Gl..x.(.8
            00 00 00 2a 00 00 00 00 00                       ...*.....
[hci0] 15:00:33.279443 > HCI Event: Command Status (0x0f) plen 4
            00 01 0d 20                                      ...
[hci0] 15:00:33.592636 > HCI Event: LE Meta Event (0x3e) plen 19
            01 00 41 00 00 00 a2 47 6c e5 c5 78 2d 00 00 00  ..A....Gl..x-...
            2a 00 05                                         *..
{hci0} 15:00:33.593285 @ Device Connected: 78:C5:E5:6C:47:A2 (1) flags 0x0000
[hci0] 15:00:33.606593 < ACL Data: handle 65 flags 0x00 dlen 9
            05 00 04 00 12 2b 00 01 00                       .....+...
[hci0] 15:00:33.639078 > ACL Data: handle 65 flags 0x02 dlen 16
            0c 00 05 00 12 01 08 00 10 00 20 00 00 00 2c 01  .......... ...,.
[hci0] 15:00:33.645585 < ACL Data: handle 65 flags 0x00 dlen 10
            06 00 05 00 13 01 02 00 00 00                    ..........
[hci0] 15:00:33.645863 < HCI Command: LE Connection Update (0x08|0x0013) plen 14
            41 00 10 00 20 00 00 00 2c 01 01 00 01 00        A... ...,.....
[hci0] 15:00:33.659465 > HCI Event: Command Status (0x0f) plen 4
            00 01 13 20                                      ...
[hci0] 15:00:33.695413 > ACL Data: handle 65 flags 0x02 dlen 5
            01 00 04 00 13                                   .....
[hci0] 15:00:33.751539 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 fa                          ........
[hci0] 15:00:33.752586 > HCI Event: Number of Completed Packets (0x13) plen 5
            01 41 00 02 00                                   .A...
[hci0] 15:00:33.752835 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c1                          .....2..
[hci0] 15:00:34.820181 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 0b                          .....*..
[hci0] 15:00:34.821134 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 e7                          ........
[hci0] 15:00:34.821273 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 da                          .....2..
[hci0] 15:00:34.932695 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 9d                          .....*..
[hci0] 15:00:34.934604 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 80                          ........
[hci0] 15:00:34.934743 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 80                          .....2..
[hci0] 15:00:35.045312 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ff                          .....*..
[hci0] 15:00:35.045539 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 fa                          ........
[hci0] 15:00:35.047351 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c8                          .....2..
[hci0] 15:00:35.157812 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c1                          .....2..
[hci0] 15:00:36.279077 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 43                          .....*.C
[hci0] 15:00:36.414070 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f4                          .....*..
[hci0] 15:00:36.481571 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ee                          .....*..
[hci0] 15:00:36.616574 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 e0                          .....*..
[hci0] 15:00:36.684053 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f0                          .....*..
[hci0] 15:00:36.886559 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fe                          .....*..
[hci0] 15:00:37.021553 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 04                          .....*..
[hci0] 15:00:37.494080 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fe                          .....*..
[hci0] 15:00:38.870323 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 17                          .....*..
[hci0] 15:00:38.875497 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 35                          .......5
[hci0] 15:00:38.875625 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 83                          .....2..
[hci0] 15:00:38.926466 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 07                          .....*..
[hci0] 15:00:38.927533 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 f5                          ........
[hci0] 15:00:38.927672 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c1                          .....2..
[hci0] 15:00:39.151579 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 ca                          .....2..
[hci0] 15:00:39.263964 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 11                          ........
[hci0] 15:00:39.265848 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c4                          .....2..
[hci0] 15:00:39.265989 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 06                          ........
[hci0] 15:00:39.266111 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 ba                          .....2..
[hci0] 15:00:39.320324 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fc                          .....*..
[hci0] 15:00:39.321448 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 fb                          ........
[hci0] 15:00:39.321573 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c6                          .....2..
[hci0] 15:00:40.022479 > HCI Event: LE Meta Event (0x3e) plen 10
            03 00 40 00 1e 00 00 00 2c 01                    ..@.....,.
[hci0] 15:00:41.345357 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c0                          .....2..
[hci0] 15:00:42.572098 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 e3                          .....*..
[hci0] 15:00:42.722098 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f7                          .....*..
[hci0] 15:00:43.096607 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 b4                          .....*..
[hci0] 15:00:43.171601 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f8                          .....*..
[hci0] 15:00:43.284093 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 03                          .....*..
[hci0] 15:00:44.971623 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f5                          .....*..
[hci0] 15:00:45.084106 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 0d                          .....*..
[hci0] 15:00:45.234114 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 04                          .....*..
[hci0] 15:00:45.271610 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fc                          .....*..
[hci0] 15:00:45.497127 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 02                          .....*..
[hci0] 15:00:46.632779 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ae                          .....*..
[hci0] 15:00:46.634611 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 9f                          ........
[hci0] 15:00:46.634738 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 a5                          .....2..
[hci0] 15:00:46.745405 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 14                          .....*..
[hci0] 15:00:46.747312 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 fb                          ........
[hci0] 15:00:46.747446 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 b2                          .....2..
[hci0] 15:00:46.801502 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 e8                          .....*..
[hci0] 15:00:46.802618 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 a8                          .....2..
[hci0] 15:00:46.970391 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 08                          .....*..
[hci0] 15:00:46.973070 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 0e                          ........
[hci0] 15:00:46.973195 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c4                          .....2..
[hci0] 15:00:47.026653 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 57                          .....*.W
[hci0] 15:00:47.027765 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 7a                          .......z
[hci0] 15:00:47.139021 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 fd                          .....*..
[hci0] 15:00:47.140909 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 f9                          ........
[hci0] 15:00:50.071664 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 10                          .....*..
[hci0] 15:00:50.184154 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ea                          .....*..
[hci0] 15:00:50.296659 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 22                          .....*."
[hci0] 15:00:50.371649 > ACL Data: handle 64 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 ff                          .....*..
[hci0] 15:00:50.795432 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 4d                          .....*.M
[hci0] 15:00:50.801677 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 df                          ........
[hci0] 15:00:50.801815 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 d8                          .....2..
[hci0] 15:00:50.851667 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 03                          .....*..
[hci0] 15:00:50.852711 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 ff                          ........
[hci0] 15:00:50.852851 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 b6                          .....2..
[hci0] 15:00:50.907932 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 19                          .....*..
[hci0] 15:00:50.909037 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 08                          ........
[hci0] 15:00:50.909177 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 f8                          .....2..
[hci0] 15:00:51.020415 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 f4                          .....*..
[hci0] 15:00:51.022325 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2e 00 fb                          ........
[hci0] 15:00:51.022470 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 ea                          .....2..
[hci0] 15:00:51.132937 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 2a 00 01                          .....*..
[hci0] 15:00:51.134846 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 ba                          .....2..
[hci0] 15:00:51.245438 > ACL Data: handle 65 flags 0x02 dlen 8
            04 00 04 00 1b 32 00 c2                          .....2..
[hci0] 15:00:58.766551 < HCI Command: Disconnect (0x01|0x0006) plen 3
            40 00 13                                         @..
[hci0] 15:00:58.772294 > HCI Event: Command Status (0x0f) plen 4
            00 01 06 04                                      ....
[hci0] 15:00:58.773594 > HCI Event: Disconn Complete (0x05) plen 4
            00 40 00 16                                      .@..
{hci0} 15:00:58.774541 @ Device Disconnected: 78:C5:E5:6C:47:D3 (1)
[hci0] 15:01:02.796566 < HCI Command: Disconnect (0x01|0x0006) plen 3
            41 00 13                                         A..
[hci0] 15:01:02.803369 > HCI Event: Command Status (0x0f) plen 4
            00 01 06 04                                      ....
[hci0] 15:01:03.170637 > HCI Event: Disconn Complete (0x05) plen 4
            00 41 00 22                                      .A."
{hci0} 15:01:03.179209 @ Device Disconnected: 78:C5:E5:6C:47:A2 (1)



________________________________________
From: Alexander Holler [holler@ahsoftware.de]
Sent: October 30, 2013 10:16 AM
To: Tim Tisdall
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: l2cap sockets not properly multiplexed on ARM

Am 30.10.2013 14:15, schrieb Tim Tisdall:

> The problem exists on the other end of the socket; the kernel side.

Do you have tried using gattool to verify that?

Regards,

Alexander Holler

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
