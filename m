Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use BTUSB_BROKEN_ISOC flag for CSR USB sniffer devices
Date: Mon,  7 Jul 2014 00:12:04 +0200
Message-Id: <1404684724-21367-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of setting data->isoc manually, use BTUSB_BROKEN_ISOC to
indicate that isochronous endpoints are not needed for CSR USB
sniffer devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b7d0fed3417f..ef4375d5c4ed 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -230,10 +230,12 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
 
 	/* CSR BlueCore Bluetooth Sniffer */
-	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = BTUSB_SNIFFER },
+	{ USB_DEVICE(0x0a12, 0x0002),
+	  .driver_info = BTUSB_SNIFFER | BTUSB_BROKEN_ISOC },
 
 	/* Frontline ComProbe Bluetooth Sniffer */
-	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
+	{ USB_DEVICE(0x16d3, 0x0002),
+	  .driver_info = BTUSB_SNIFFER | BTUSB_BROKEN_ISOC },
 
 	/* Intel Bluetooth device */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
@@ -1804,8 +1806,6 @@ static int btusb_probe(struct usb_interface *intf,
 		/* New sniffer firmware has crippled HCI interface */
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x997)
 			set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
-
-		data->isoc = NULL;
 	}
 
 	if (id->driver_info & BTUSB_INTEL_BOOT) {
-- 
1.9.3

