Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8723BU
Date: Mon, 26 Jun 2017 13:42:45 -0500
Message-Id: <20170626184245.2701-1-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

This device is not recognized by the driver.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7fa373b428f8..5eb4a7446426 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -356,6 +356,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3416), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8723BU Bluetooth devices */
+	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.12.3
