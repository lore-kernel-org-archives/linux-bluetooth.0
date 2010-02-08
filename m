Return-Path: <cyrus@holtmann.org>
Message-ID: <4B708725.5040804@chocky.org>
Date: Mon, 08 Feb 2010 13:50:29 -0800
From: Peter Naulls <peter@chocky.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Support for Belkin dongle
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I have a Belkin bluetooth dongle:

Bus 002 Device 005: ID 050d:0084 Belkin Components F8T003v2 Bluetooth

I believe this was supported in Linux long ago, but is no longer
recognized.  The following patch seems sufficient against 2.6.32.7.

The device is found, but I have not tested it in any meaningful
way.

Cheers.


hci0:   Type: USB
         BD Address: 00:0A:3A:5B:19:3C ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN
         RX bytes:738 acl:0 sco:0 events:28 errors:0
         TX bytes:109 acl:0 sco:0 commands:27 errors:0


--- bluetooth/btusb.c.orig      2010-02-08 13:20:15.000000000 -0800
+++ bluetooth/btusb.c   2010-02-08 13:20:46.000000000 -0800
@@ -113,6 +113,7 @@
         /* Belkin F8T012 and F8T013 devices */
         { USB_DEVICE(0x050d, 0x0012), .driver_info = BTUSB_WRONG_SCO_MTU },
         { USB_DEVICE(0x050d, 0x0013), .driver_info = BTUSB_WRONG_SCO_MTU },
+        { USB_DEVICE(0x050d, 0x0084), .driver_info = BTUSB_WRONG_SCO_MTU },

         /* Asus WL-BTD202 device */
         { USB_DEVICE(0x0b05, 0x1715), .driver_info = BTUSB_WRONG_SCO_MTU },


Please forgive the obviously broken line wrap here, but it's only
single line.
