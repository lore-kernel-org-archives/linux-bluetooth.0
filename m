Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH resend 2/5] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom 413c:8197
Date: Wed, 21 Jan 2015 15:59:53 +0800
Message-Id: <1421827196-25277-2-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1421827196-25277-1-git-send-email-jesse.sung@canonical.com>
References: <1421827196-25277-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This device needs an external firmware to make HSP and HFP work.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fd3ac5b..cde222b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -105,7 +105,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
-	{ USB_DEVICE(0x413c, 0x8197) },
+	{ USB_DEVICE(0x413c, 0x8197),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
-- 
2.1.0

