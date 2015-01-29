Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Limit hardware error handling to Intel Snowfield Peak
Date: Thu, 29 Jan 2015 13:14:00 -0800
Message-Id: <1422566040-21714-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In general all Intel Bluetooth devices support retrieving of additional
exception information. However for older generations including Wilkens
Peak and Stone Peak it is not as simple. So for now only enable the
Intel specific error handling for Snowfield Peak and later devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3aa4b3c776b2..86f3d92de22a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2709,7 +2709,6 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
-		hdev->hw_error = btusb_hw_error_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
-- 
2.1.0

