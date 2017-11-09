Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510226875.1765.5.camel@zoho.eu>
Subject: invalid packet size with bluetooth keyboard
From: Bbo Wuff <bbo2adwuff@zoho.eu>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Nov 2017 12:27:55 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all,

I have a Microsoft Sculpt Mobile Keyboard, which is a bluetooth
keyboard. It worked fine before, but since bluez 5.47 not anymore. And
I don't seem to be the only one:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878181#15

Connecting works fine, but after some time (can be a few seconds, a few
minutes, or even up to an hour) it just doesn't take any input anymore.
Here the logs:

btmon -t
----------------------------
Bluetooth monitor ver 5.47
= Note: Linux version 4.13.11-1-ARCH (x86_64) 09:48:16.561451
= Note: Bluetooth subsystem version 2.22 09:48:16.561454
.............................................
> ACL Data RX: Handle 256 flags 0x02 dlen 14 #39 [hci0] 09:50:35.918767

Channel: 65 len 10 [PSM 0 mode 0] {chan 0}
a1 01 00 00 00 00 00 00 00 00 ..........

.............................................
.............................................
> HCI Event: Vendor (0xff) plen 7 #168 [hci0] 09:51:49.994675

Intel Bootup (0x02)
Zero: 0x00
Number of packets: 2
Source: Operational firmware (0x01)
Reset type: Soft software reset (0x02)
Reset reason: System exception (0x05)
DDC status: Persistent RAM (0x02)
> HCI Event: Vendor (0xff) plen 189 #169 [hci0] 09:51:49.997592

Intel System Exception (0x29)
invalid packet size
01 00 00 00 00 00 00 00 00 47 01 01 5c 2c 01 50 .........G..\,.P
e6 5e 0b 00 00 47 01 01 06 00 00 00 00 00 00 00 .^...G..........
00 00 00 00 00 00 00 00 ff 35 f3 b0 18 c5 bf b6 .........5......
c2 04 84 00 e0 1c 01 50 00 40 00 00 00 00 00 00 .......P.@......
00 00 00 00 04 00 00 00 02 00 00 00 05 00 00 00 ................
f8 ff 00 00 fc ff 00 00 f9 ff 00 00 14 00 00 50 ...............P
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00 00 00 00 00 00 00 00 00 00 00 00 4c 1b 00 50 ............L..P
f8 ff 00 00 66 56 0b 00 5c 16 00 50 b0 8c 05 00 ....fV..\..P....
60 f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00 `...............
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
ef ef ef ef ef ef ef ef ef ef ef ef ............

.............................................
.............................................
.............................................



I posted the bug also at:
https://bugs.archlinux.org/task/56277

How to deal with this problem?

Thanks and best regards
Wuff

