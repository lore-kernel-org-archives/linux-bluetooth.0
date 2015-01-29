Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Sort USB_DEVICE entries for Marvell by vendor id
Date: Wed, 28 Jan 2015 19:41:42 -0800
Message-Id: <1422502903-12203-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New entries to the USB blacklist/quirk device table should be sorted
by USB vendor id. Fix the recent entry fro Marvell devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b2753d79edcf..4f5b93568ecc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -259,14 +259,15 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x16d3, 0x0002),
 	  .driver_info = BTUSB_SNIFFER | BTUSB_BROKEN_ISOC },
 
+	/* Marvell Bluetooth devices */
+	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
+	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
+
 	/* Intel Bluetooth device */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
 
-	/* Marvell device */
-	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
-	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
 
 	{ }	/* Terminating entry */
 };
-- 
2.1.0

