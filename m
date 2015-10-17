Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btintel: Add diagnostic support for older controllers
Date: Sat, 17 Oct 2015 16:00:28 +0200
Message-Id: <1445090428-75287-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the older controllers like Wilkens Peak and Stone Peak, enabling the
traces requires to switch into manufacturer mode first. This patch does
exactly that, but only for these older controllers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  6 ++++++
 drivers/bluetooth/btusb.c   |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8d4891725e3b..e4496faf8cf5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -122,6 +122,42 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_diag);
 
+int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+{
+	struct sk_buff *skb;
+	u8 param[2];
+	int err;
+
+	param[0] = 0x01;
+	param[1] = 0x00;
+
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Entering Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	err = btintel_set_diag(hdev, enable);
+
+	param[0] = 0x00;
+	param[1] = 0x00;
+
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Leaving Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_set_diag_mfg);
+
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 0af06ae197c1..702a276b3c60 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -74,6 +74,7 @@ struct intel_secure_send_result {
 int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btintel_set_diag(struct hci_dev *hdev, bool enable);
+int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
@@ -101,6 +102,11 @@ static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab82c02d7e92..6f799c42cf2c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2882,9 +2882,11 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
+		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.4.3

