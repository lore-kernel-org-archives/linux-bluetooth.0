Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add support for setting SSP debug mode
Date: Sat, 19 Oct 2013 02:13:20 -0700
Message-Id: <1382174000-18946-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enabling and disabling SSP debug mode is useful for development. This
adds a debugfs entry that allows to configure the SSP debug mode.

On purpose this has been implemented as debugfs entry and not a public
API since it is really only useful during testing and development.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  2 ++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 53 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |  2 ++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 77a971a..ac9c4a7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1043,6 +1043,8 @@ struct hci_rp_write_remote_amp_assoc {
 	__u8     phy_handle;
 } __packed;
 
+#define HCI_OP_WRITE_SSP_DEBUG_MODE	0x1804
+
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
 struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0daac39..f621c5b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -169,6 +169,7 @@ struct hci_dev {
 	__u8		page_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
+	__u8		ssp_debug_mode;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 94d5342..8aae80b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -296,6 +296,54 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static int ssp_debug_mode_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+	struct sk_buff *skb;
+	__u8 mode;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	hci_req_lock(hdev);
+	mode = val;
+	skb = __hci_cmd_sync(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE, sizeof(mode),
+			     &mode, HCI_CMD_TIMEOUT);
+	hci_req_unlock(hdev);
+
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	if (skb->data[0]) {
+		u8 status = skb->data[0];
+		kfree_skb(skb);
+		return -bt_to_errno(status);
+	}
+
+	hci_dev_lock(hdev);
+	hdev->ssp_debug_mode = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int ssp_debug_mode_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->ssp_debug_mode;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ssp_debug_mode_fops, ssp_debug_mode_get,
+			ssp_debug_mode_set, "%llu\n");
+
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1192,9 +1240,12 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &voice_setting_fops);
 	}
 
-	if (lmp_ssp_capable(hdev))
+	if (lmp_ssp_capable(hdev)) {
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
+		debugfs_create_file("ssp_debug_mode", 0644, hdev->debugfs,
+				    hdev, &ssp_debug_mode_fops);
+	}
 
 	if (lmp_sniff_capable(hdev)) {
 		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8480452..83478da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -198,6 +198,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	memset(hdev->scan_rsp_data, 0, sizeof(hdev->scan_rsp_data));
 	hdev->scan_rsp_data_len = 0;
+
+	hdev->ssp_debug_mode = 0;
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.3.1

