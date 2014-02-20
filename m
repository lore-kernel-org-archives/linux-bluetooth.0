Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide option for changing LE advertising channel map
Date: Thu, 20 Feb 2014 11:55:56 -0800
Message-Id: <1392926156-4599-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For testing purposes it is useful to provide an option to change the
advertising channel map. So add a debugfs option to allow this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a8e22e9b25d..c0fcc041fbb5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -178,6 +178,7 @@ struct hci_dev {
 	__u16		page_scan_interval;
 	__u16		page_scan_window;
 	__u8		page_scan_type;
+	__u8		le_adv_channel_map;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
 	__u16		le_conn_min_interval;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 877330b4876f..67192867c998 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -757,6 +757,34 @@ static int conn_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
 			conn_max_interval_set, "%llu\n");
 
+static int adv_channel_map_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x01 || val > 0x07)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_channel_map = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_channel_map_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_channel_map;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
+			adv_channel_map_set, "%llu\n");
+
 static ssize_t lowpan_read(struct file *file, char __user *user_buf,
 			   size_t count, loff_t *ppos)
 {
@@ -1605,6 +1633,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_min_interval_fops);
 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
 				    hdev, &conn_max_interval_fops);
+		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
+				    hdev, &adv_channel_map_fops);
 		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
 				    &lowpan_debugfs_fops);
 	}
@@ -3264,6 +3294,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
+	hdev->le_adv_channel_map = 0x07;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
 	hdev->le_conn_min_interval = 0x0028;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5f5e388716ec..12fa6399c796 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1374,7 +1374,7 @@ static void enable_advertising(struct hci_request *req)
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
 	cp.type = get_adv_type(hdev);
 	cp.own_address_type = hdev->own_addr_type;
-	cp.channel_map = 0x07;
+	cp.channel_map = hdev->le_adv_channel_map;
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
-- 
1.8.5.3

