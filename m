Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/14] Bluetooth: btusb: Move Broadcom quirk setting into support module
Date: Sun,  5 Apr 2015 03:04:58 -0700
Message-Id: <1428228299-28415-13-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The quirks for Broadcom devices can be set from the setup function and
to keep the code simple, just move them into Broadcom support module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 4 ++++
 drivers/bluetooth/btusb.c | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index fead228a7621..5458865c0f52 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -325,6 +325,8 @@ reset:
 
 	btbcm_check_bdaddr(hdev);
 
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+
 done:
 	release_firmware(fw);
 
@@ -345,6 +347,8 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 		get_unaligned_le16(skb->data + 5));
 	kfree_skb(skb);
 
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_setup_apple);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ff3b5ecbb164..b11141aa2f4f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2705,13 +2705,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
 		hdev->setup = btbcm_setup_patchram;
 		hdev->set_bdaddr = btbcm_set_bdaddr;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BCM_APPLE) {
+	if (id->driver_info & BTUSB_BCM_APPLE)
 		hdev->setup = btbcm_setup_apple;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-	}
 #endif
 
 	if (id->driver_info & BTUSB_INTEL) {
-- 
2.1.0

