Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Set manufacturer for Intel bootloader devices
Date: Wed, 21 Oct 2015 01:31:45 +0200
Message-Id: <1445383905-18051-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Intel bootloader devices, set the manufacturer information so that
it becomes possible to decode the boot process.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 408773f802ff..af6409a7aa0c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2944,8 +2944,10 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_INTEL_BOOT)
+	if (id->driver_info & BTUSB_INTEL_BOOT) {
+		hdev->manufacturer = 2;
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+	}
 
 	if (id->driver_info & BTUSB_ATH3012) {
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-- 
2.4.3

