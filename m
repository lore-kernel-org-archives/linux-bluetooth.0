Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Bartosz Chronowski <ext.bartosz.chronowski@tieto.com>
Date: Wed, 25 Oct 2017 16:05:34 +0200
Message-ID: <CAJH2EMzpFJ0cOrBu7hfNRn1JqKUuQdQhO36MNqWXOceqF5i21w@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add new NFA344A entry.
To: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
        gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change allows proper low power mode entry in suspend.

Signed-off-by: Bartosz Chronowski <ext.bartosz.chronowski@tieto.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a5c06a..513a7a5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -272,6 +272,7 @@ static const struct usb_device_id blacklist_table[] = {
  { USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME },
  { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
  { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
+ { USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME },
  { USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
  { USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
  { USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
-- 
2.7.4
