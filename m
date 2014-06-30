Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Expose default connection latency setting via debugfs
Date: Mon, 30 Jun 2014 12:16:09 +0200
Message-Id: <1404123370-56018-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The controller has a default value for the connection latency. Expose
this via debugfs for testing purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 94551c33c4c6..79d292cfb867 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -851,6 +851,34 @@ static int conn_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
 			conn_max_interval_set, "%llu\n");
 
+static int conn_latency_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val > 0x01f3)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_latency = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_latency_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_latency;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_latency_fops, conn_latency_get,
+			conn_latency_set, "%llu\n");
+
 static int adv_channel_map_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1708,6 +1736,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_min_interval_fops);
 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
 				    hdev, &conn_max_interval_fops);
+		debugfs_create_file("conn_latency", 0644, hdev->debugfs,
+				    hdev, &conn_latency_fops);
 		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
 				    hdev, &adv_channel_map_fops);
 		debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
-- 
1.9.3

