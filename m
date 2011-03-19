Return-Path: <cyrus@holtmann.org>
Message-ID: <4D8477B8.4010803@cs.drexel.edu>
Date: Sat, 19 Mar 2011 05:30:32 -0400
From: Lee Trager <lt73@cs.drexel.edu>
MIME-Version: 1.0
To: marcel@holtmann.org, padovan@profusion.mobi
CC: linux-bluetooth@vger.kernel.org
Subject: [PATCH] ath3k: Add ASUS BT Support
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

The ASUS USB Bluetooth module that comes with my motherboard(ASUS P8P67
Pro) is simply a re-branded Atheros AR3011. This patch add support for
it in the driver

Signed-off-by: Lee Trager <lt73@cs.drexel.edu>

--- drivers/bluetooth/ath3k.c.old	2011-03-18 04:27:26.160161039 -0400
+++ drivers/bluetooth/ath3k.c	2011-03-18 04:29:05.853945455 -0400
@@ -36,9 +36,12 @@
 	/* Atheros AR3011 */
 	{ USB_DEVICE(0x0CF3, 0x3000) },

-	/* Atheros AR3011 with sflash firmware*/
+	/* Atheros AR3011 with sflash firmware */
 	{ USB_DEVICE(0x0CF3, 0x3002) },

+	/* ASUS branded Atheros AR3011 */
+	{ USB_DEVICE(0x0B05, 0x179C) },
+
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
