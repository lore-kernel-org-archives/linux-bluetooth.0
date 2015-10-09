Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: Add support for enabling tracing functionality
Date: Fri,  9 Oct 2015 14:42:08 +0200
Message-Id: <1444394528-17016-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Intel controllers with firmware that allows tracing of baseband
functionality this allows enabling it via set_diag driver callback.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c   | 32 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h   |  6 ++++++
 drivers/bluetooth/btusb.c     |  1 +
 drivers/bluetooth/hci_intel.c |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 7047fe6a6a2b..95652aa12454 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -91,6 +91,38 @@ int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btintel_set_bdaddr);
 
+int btintel_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct sk_buff *skb;
+	u8 param[3];
+	int err;
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	if (enable) {
+		param[0] = 0x03;
+		param[1] = 0x03;
+		param[2] = 0x03;
+	} else {
+		param[0] = 0x00;
+		param[1] = 0x00;
+		param[2] = 0x00;
+	}
+
+	skb = __hci_cmd_sync(hdev, 0xfc43, 3, param, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Changing Intel diagnostic mode failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_set_diag);
+
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index f0655c476fd2..0af06ae197c1 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -73,6 +73,7 @@ struct intel_secure_send_result {
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+int btintel_set_diag(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
@@ -95,6 +96,11 @@ static inline int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdadd
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 247b1062cb9a..5e9ae0eb3728 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2685,6 +2685,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
 		hdev->hw_error = btintel_hw_error;
+		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 2952107e3bae..c5e69e08788a 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -557,6 +557,7 @@ static int intel_setup(struct hci_uart *hu)
 
 	bt_dev_dbg(hdev, "start intel_setup");
 
+	hu->hdev->set_diag = btintel_set_diag;
 	hu->hdev->set_bdaddr = btintel_set_bdaddr;
 
 	calltime = ktime_get();
-- 
2.4.3

