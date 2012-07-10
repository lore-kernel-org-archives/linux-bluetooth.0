Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@bitmath.se>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH v2] Bluetooth: Add MacBookPro10,1 support
Date: Tue, 10 Jul 2012 12:46:41 +0200
Message-Id: <1341917201-4705-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the 2012 15'' MacBook Pro Retina, also known as
MacBookPro10,1. The bluetooth device presents itself as

Bus 002 Device 008: ID 05ac:8286 Apple, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x05ac Apple, Inc.
  idProduct          0x8286
  bcdDevice            0.74
  iManufacturer           1 Apple Inc.
  iProduct                2 Bluetooth USB Host Controller
  iSerial                 0
  bNumConfigurations      1

Patch originally written and tested by clipcarl (forums.opensuse.org).

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83ebb24..6cc54da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -84,6 +84,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacMini5,1 */
 	{ USB_DEVICE(0x05ac, 0x8281) },
 
+	/* Apple MacBookPro10,1 */
+	{ USB_DEVICE(0x05ac, 0x8286) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },
 
-- 
1.7.11.1

