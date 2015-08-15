Return-Path: <cyrus@holtmann.org>
From: Peter Poklop <peter.poklop@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Peter Poklop <peter.poklop@gmail.com>
Subject: [PATCH] Bluetooth: btusb: mark 0c10:0000 devices with BTUSB_SWAVE
Date: Sat, 15 Aug 2015 19:59:15 +0200
Message-Id: <1439661555-4729-1-git-send-email-peter.poklop@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables quirk handling for Silicon Wave based devices and
fixes kernel bug with id 42985.

Signed-off-by: Peter Poklop <peter.poklop@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cc92b0f..b3bceb1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -322,6 +322,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Several Silicon Wave based devices */
+	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
+
 	{ }	/* Terminating entry */
 };
 
-- 
2.1.4
