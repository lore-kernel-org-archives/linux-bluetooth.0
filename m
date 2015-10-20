Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: Enable extra Intel vendor events
Date: Tue, 20 Oct 2015 23:23:16 +0200
Message-Id: <1445376196-93930-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Bluetooth controllers can emit extra vendor specific events in
error conditions or for debugging purposes. To make the life easier for
engineers, enable them by default. When the vendor_diag options has been
enabled, then additional debug events are also enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h | 12 +++++++++
 drivers/bluetooth/btusb.c   | 21 ++++++++++++---
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e4496faf8cf5..1f13e617bf56 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -111,13 +111,15 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		if (err == -ENODATA)
-			return 0;
+			goto done;
 		BT_ERR("%s: Changing Intel diagnostic mode failed (%d)",
 		       hdev->name, err);
 		return err;
 	}
 	kfree_skb(skb);
 
+done:
+	btintel_set_event_mask(hdev, enable);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_diag);
@@ -283,6 +285,64 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 }
 EXPORT_SYMBOL_GPL(btintel_load_ddc_config);
 
+int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
+{
+	u8 mask[8] = { 0x87, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	struct sk_buff *skb;
+	int err;
+
+	if (debug)
+		mask[1] |= 0x62;
+
+	skb = __hci_cmd_sync(hdev, 0xfc52, 8, mask, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Setting Intel event mask failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_set_event_mask);
+
+int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
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
+	err = btintel_set_event_mask(hdev, debug);
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
+EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 702a276b3c60..07e58e05a7fa 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -81,6 +81,8 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
+int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
+int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -128,6 +130,16 @@ static inline int btintel_load_ddc_config(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bbe25e397f41..958809c80c27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1788,8 +1788,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
 		hdev->name);
 
-	btintel_check_bdaddr(hdev);
-	return 0;
+	goto complete;
 
 exit_mfg_disable:
 	/* Disable the manufacturer mode without reset */
@@ -1804,8 +1803,7 @@ exit_mfg_disable:
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
 
-	btintel_check_bdaddr(hdev);
-	return 0;
+	goto complete;
 
 exit_mfg_deactivate:
 	release_firmware(fw);
@@ -1825,6 +1823,12 @@ exit_mfg_deactivate:
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
 		hdev->name);
 
+complete:
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation.
+	 */
+	btintel_set_event_mask_mfg(hdev, false);
+
 	btintel_check_bdaddr(hdev);
 	return 0;
 }
@@ -2339,6 +2343,15 @@ done:
 	 */
 	btintel_load_ddc_config(hdev, fwname);
 
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation. It
+	 * does not enable any debugging related events.
+	 *
+	 * The device will function correctly without these events enabled
+	 * and thus no need to fail the setup;
+	 */
+	btintel_set_event_mask(hdev, false);
+
 	return 0;
 }
 
-- 
2.4.3

