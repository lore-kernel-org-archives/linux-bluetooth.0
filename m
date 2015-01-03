Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Use HCI_QUIRK_FIXUP_INQUIRY_MODE for Silicon Wave devices
Date: Fri,  2 Jan 2015 23:35:20 -0800
Message-Id: <1420270520-32581-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Silicon Wave based devices do support Inquiry Result with RSSI and
so let the core know to enable them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 833881392ce1..1ea63518d130 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2084,8 +2084,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-	if (id->driver_info & BTUSB_SWAVE)
+	if (id->driver_info & BTUSB_SWAVE) {
+		set_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
+	}
 
 	if (id->driver_info & BTUSB_INTEL_BOOT)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
-- 
2.1.0

