Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Expose default supervision timeout setting via debugfs
Date: Mon, 30 Jun 2014 12:16:10 +0200
Message-Id: <1404123370-56018-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The controller has a default value for the supervision timeout. Expose
this via debugfs for testing purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 79d292cfb867..6c28687c9286 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -879,6 +879,34 @@ static int conn_latency_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_latency_fops, conn_latency_get,
 			conn_latency_set, "%llu\n");
 
+static int supervision_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x000a || val > 0x0c80)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_supv_timeout = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int supervision_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_supv_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(supervision_timeout_fops, supervision_timeout_get,
+			supervision_timeout_set, "%llu\n");
+
 static int adv_channel_map_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1738,6 +1766,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_max_interval_fops);
 		debugfs_create_file("conn_latency", 0644, hdev->debugfs,
 				    hdev, &conn_latency_fops);
+		debugfs_create_file("supervision_timeout", 0644, hdev->debugfs,
+				    hdev, &supervision_timeout_fops);
 		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
 				    hdev, &adv_channel_map_fops);
 		debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
-- 
1.9.3

