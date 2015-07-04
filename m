Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: btintel: Add generic function for handling hardware errors
Date: Sat,  4 Jul 2015 15:15:21 +0200
Message-Id: <1436015723-43145-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The handling of hardware error has support for providing a vendor
specific callback to deal with the error. Move the Intel specific
function out of the USB driver into the generic module so that it
can also be utilized by the UART driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 828f2f8d1568..8b160858f7e8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -89,6 +89,40 @@ int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
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
+		BT_ERR("%s: Reset after hardware error failed (%ld)",
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
+		BT_ERR("%s: Exception info size mismatch", hdev->name);
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
index 4bda6ab34f60..c4680cd44011 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -73,6 +73,7 @@ struct intel_secure_send_result {
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 #else
 
@@ -86,4 +87,8 @@ static inline int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdadd
 	return -EOPNOTSUPP;
 }
 
+static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
+{
+}
+
 #endif
-- 
2.4.3

