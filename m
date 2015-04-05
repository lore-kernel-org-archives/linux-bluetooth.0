Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Move Intel hardware error handling into common module
Date: Sun,  5 Apr 2015 05:02:15 -0700
Message-Id: <1428235335-18434-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the Intel specific hardware error event handling into the common
module code for all Intel devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  5 +++++
 drivers/bluetooth/btusb.c   | 42 +-----------------------------------------
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 91d54babe48a..1634251a4b09 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -93,6 +93,47 @@ int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btintel_set_bdaddr);
 
+void btintel_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct sk_buff *skb;
+	u8 type = 0x00;
+
+	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reset after Intel hardware error failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != 13) {
+		BT_ERR("%s: Intel exception info size mismatch", hdev->name);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (skb->data[0] != 0x00) {
+		BT_ERR("%s: Intel exception info command failure (%02x)",
+		       hdev->name, skb->data[0]);
+		kfree_skb(skb);
+		return;
+	}
+
+	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
+
+	kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(btintel_hw_error);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d1581150679a..6c14ef090ab8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -58,6 +58,7 @@ struct intel_boot_params {
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 #else
 
@@ -71,4 +72,8 @@ static inline int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdadd
 	return -EOPNOTSUPP;
 }
 
+static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
+{
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c06ceec13dbb..10c525e919da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2224,46 +2224,6 @@ done:
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
-	if (skb->data[0] != 0x00) {
-		BT_ERR("%s: Exception info command failure (%02x)",
-		       hdev->name, skb->data[0]);
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
@@ -2722,7 +2682,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
-		hdev->hw_error = btusb_hw_error_intel;
+		hdev->hw_error = btintel_hw_error;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
-- 
2.1.0

