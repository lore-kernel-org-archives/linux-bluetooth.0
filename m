Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/14] Bluetooth: btintel: Add function for checking Intel default address
Date: Sun,  5 Apr 2015 03:04:49 -0700
Message-Id: <1428228299-28415-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel default address is special and for proper functionality it
needs to be verified that this one is not set. This provides a generic
function for this that can be used by multiple modules.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d78273626c61..91d54babe48a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -28,6 +28,53 @@
 
 #define VERSION "0.1"
 
+#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+
+int btintel_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		BT_ERR("%s: Reading Intel device address failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		BT_ERR("%s: Intel device address length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (bda->status) {
+		BT_ERR("%s: Intel device address result failed (%02x)",
+		       hdev->name, bda->status);
+		kfree_skb(skb);
+		return -bt_to_errno(bda->status);
+	}
+
+	/* For some Intel based controllers, the default Bluetooth device
+	 * address 00:03:19:9E:8B:00 can be found. These controllers are
+	 * fully operational, but have the danger of duplicate addresses
+	 * and that in turn can cause problems with Bluetooth operation.
+	 */
+	if (!bacmp(&bda->bdaddr, BDADDR_INTEL)) {
+		BT_ERR("%s: Found Intel default device address (%pMR)",
+		       hdev->name, &bda->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_check_bdaddr);
+
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	struct sk_buff *skb;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 550fbcdf0c47..20be247d2ff6 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -23,10 +23,16 @@
 
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
+int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 
 #else
 
+static inline int btintel_check_bdaddr(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	return -EOPNOTSUPP;
-- 
2.1.0

