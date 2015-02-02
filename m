Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for BTUSB_INTEL_NEW
Date: Sun,  1 Feb 2015 23:57:18 -0800
Message-Id: <1422863838-32388-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Snowfield Peak Bluetooth controllers use a strict scanning
filter policy that filters based on Bluetooth device addresses and
not on RSSI.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d084856cc350..067a11c6829c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2713,6 +2713,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->setup = btusb_setup_intel_new;
 		hdev->hw_error = btusb_hw_error_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.1.0

