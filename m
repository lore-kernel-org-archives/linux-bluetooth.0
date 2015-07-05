Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: btusb: Use hardware error handler from Intel module
Date: Sun,  5 Jul 2015 14:37:39 +0200
Message-Id: <1436099860-77732-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel specific Bluetooth module provides now an exported function
for the hardware error. Use that instead of duplicating it inside the
driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b4cf8d9c9dac..21bdb89da6eb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2291,39 +2291,6 @@ done:
 	return 0;
 }
 
-static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
-{
-	struct sk_buff *skb;
-	u8 type = 0x00;
-
-	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Reset after hardware error failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return;
-	}
-	kfree_skb(skb);
-
-	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return;
-	}
-
-	if (skb->len != 13) {
-		BT_ERR("%s: Exception info size mismatch", hdev->name);
-		kfree_skb(skb);
-		return;
-	}
-
-	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
-
-	kfree_skb(skb);
-}
-
 static int btusb_shutdown_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2783,7 +2750,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
-		hdev->hw_error = btusb_hw_error_intel;
+		hdev->hw_error = btintel_hw_error;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
-- 
2.4.3

