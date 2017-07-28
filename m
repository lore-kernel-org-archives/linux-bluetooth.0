Return-Path: <briannorris@chromium.org>
From: Brian Norris <briannorris@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,
	Miao-chen Chou <mcchou@chromium.org>,
	Waldemar Rymarkiewicz <ext.waldemar.rymarkiewicz@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Bluetooth: btusb: add ID for LiteOn 04ca:3016
Date: Fri, 28 Jul 2017 16:16:23 -0700
Message-Id: <20170728231623.25232-1-briannorris@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Contains a QCA6174A-5 chipset, with USB BT. Let's support loading
firmware on it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1cefff772cd0..24cc8383fdd4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -269,6 +269,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.14.0.rc0.400.g1c36432dff-goog
