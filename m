Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Remove redundant call to btusb_free_frags()
Date: Wed, 28 Jan 2015 11:06:32 +0200
Message-Id: <1422435992-30145-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The btusb_disconnect() callback calls hci_unregister_dev() which in turn
calls btusb_close() if the HCI device is powered. The btusb_close()
function in turn will call btusb_free_frags(). It's therefore
unnecessary to have another call to btusb_free_frags() in the
btusb_disconnect() function. Besides the redundancy the second call
seems to also cause some strange stability issues which this patch then
also fixes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4fac6927ee11..271db881e793 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2762,7 +2762,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
-	btusb_free_frags(data);
 	hci_free_dev(hdev);
 }
 
-- 
2.1.0

