Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for Broadcom devices
Date: Sun,  2 Nov 2014 20:52:24 +0100
Message-Id: <1414957944-22818-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth controllers from Broadcom use a strict scanning filter
policy that filters based on Bluetooth device addresses and not on
RSSI. So tell the core about this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03ce301fca92..c85426d6e33d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2035,6 +2035,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
 		hdev->setup = btusb_setup_bcm_patchram;
 		hdev->set_bdaddr = btusb_set_bdaddr_bcm;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL) {
-- 
1.9.3

