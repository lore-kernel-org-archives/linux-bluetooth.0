Return-Path: <cyrus@holtmann.org>
From: Rick Dunn <rick@rickdunn.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rick Dunn <rick@rickdunn.com>
Subject: [PATCH] Add 0b05:17cf line for BCM4352 combo card BCM20702A0 chip
Date: Thu, 15 Jan 2015 15:13:24 -0500
Message-Id: <1421352804-24516-2-git-send-email-rick@rickdunn.com>
In-Reply-To: <1421352804-24516-1-git-send-email-rick@rickdunn.com>
References: <1421352804-24516-1-git-send-email-rick@rickdunn.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index af122e2..0725003 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -107,6 +107,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0b05, 0x17cb) },
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0489, 0xe042) },
+	{ USB_DEVICE(0x0b05, 0x17cf), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
-- 
1.9.1

