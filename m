Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 11 Oct 2009 15:20:10 -0300
Message-ID: <1e9e22610910111120p25a850bflcc31794f7e29192e@mail.gmail.com>
Subject: Failed to connect to SDP server / Connection reset by peer
From: Addo Del Grossi <addo.delgrossi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I upgraded to Ubuntu Karmic and found problems when using the command sdptool.
I was found that the problem only when use the kernel 2.6.31,
using the old 2.6.28 Kernel sdptool the command works correctly.

Note: We also did the test by downloading the Vanilla kernel
kernel.org site and the same error was found.

The commands sequence above reproduce the scenario:

Kernel: 2.6.31-10-generic

root@suporte-desktop:/home/suporte# uname -a
Linux suporte-desktop 2.6.31-10-generic #34-Ubuntu SMP Wed Sep 16
00:23:19 UTC 2009 i686 GNU/Linux

root@suporte-desktop:/home/suporte# dpkg -l | grep bluez
ii  bluez                                4.51-0ubuntu1
             Bluetooth tools and daemons
ii  bluez-alsa                           4.51-0ubuntu1
             Bluetooth audio support
ii  bluez-gstreamer                      4.51-0ubuntu1
             Bluetooth GStreamer support

root@suporte-desktop:/home/suporte# sdptool -i hci0 search --bdaddr
00:0E:6D:70:B9:A6 opush
Failed to connect to SDP server on 00:0E:6D:70:B9:A6: Connection reset by peer

---------------------------------------------------------------------------------------

Kernel: 2.6.28-15-generic

root@suporte-desktop:/home/suporte# uname -a
Linux suporte-desktop 2.6.28-15-generic #49-Ubuntu SMP Wed Sep 16
00:33:34 UTC 2009 i686 GNU/Linux

root@suporte-desktop:/home/suporte# dpkg -l | grep bluez
ii  bluez                                4.51-0ubuntu1
             Bluetooth tools and daemons
ii  bluez-alsa                           4.51-0ubuntu1
             Bluetooth audio support
ii  bluez-gstreamer                      4.51-0ubuntu1
             Bluetooth GStreamer support

root@suporte-desktop:/home/suporte# sdptool -i hci0 search --bdaddr
00:0E:6D:70:B9:A6 opush
Searching for opush on 00:0E:6D:70:B9:A6 ...
Service Name: OBEX Object Push
Service RecHandle: 0x10003
Service Class ID List:
 "OBEX Object Push" (0x1105)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 9
 "OBEX" (0x0008)
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "OBEX Object Push" (0x1105)
   Version: 0x0100

Thanks,
Addo
