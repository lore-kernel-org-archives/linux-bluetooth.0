Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Hon Weng Chong <honwchong@gmail.com>
Subject: [PATCH 1/2] bluetooth: btusb: Add device ID for RTL8822BE
Date: Sun, 11 Feb 2018 12:24:32 -0600
Message-Id: <20180211182433.591-2-Larry.Finger@lwfinger.net>
In-Reply-To: <20180211182433.591-1-Larry.Finger@lwfinger.net>
References: <20180211182433.591-1-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

The Asus Z370-I contains a Realtek RTL8822BE device with an associated
BT chip using a USB ID of 0b05:185c. This device is added to the driver.

Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a55380ad730..82a100f7a6ad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -373,6 +373,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
-- 
2.16.1
