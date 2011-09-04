Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] btusb.c: add support for 2011 mac mini
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 04 Sep 2011 18:01:42 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315152103.2441.6.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Today I noticed that the usb bluetooth adapter (BCM2046B1) on my 2011
mac mini was not working. I've created a patch to get it going.

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ef4760..8d807c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacBookPro8,2 */
 	{ USB_DEVICE(0x05ac, 0x821a) },
 
+	/* Apple MacMini5,1 */
+	{ USB_DEVICE(0x05ac, 0x8281) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },

Patch is against current kernel git.

Jurgen

