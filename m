Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose debugfs settings for LE connection interval
Date: Sat, 19 Oct 2013 05:44:49 -0700
Message-Id: <1382186689-49123-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For testing purposes expose the default LE connection interval values
via debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  5 ++--
 net/bluetooth/hci_core.c         | 62 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d50cc7a..8c0ab3d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -169,6 +169,8 @@ struct hci_dev {
 	__u8		page_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
+	__u16		le_conn_min_interval;
+	__u16		le_conn_max_interval;
 	__u8		ssp_debug_mode;
 
 	__u16		devid_source;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 974d7bc..ba5366c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -558,11 +558,12 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	cp.own_address_type = conn->src_type;
-	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
-	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
+	cp.conn_interval_min = cpu_to_le16(hdev->le_conn_min_interval);
+	cp.conn_interval_max = cpu_to_le16(hdev->le_conn_max_interval);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
+
 	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 
 	err = hci_req_run(&req, create_le_conn_complete);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e30352a..26e9dfd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -580,6 +580,62 @@ static const struct file_operations long_term_keys_fops = {
 	.release	= single_release,
 };
 
+static int conn_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_min_interval= val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
+			conn_min_interval_set, "%llu\n");
+
+static int conn_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_conn_max_interval= val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_conn_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
+			conn_max_interval_set, "%llu\n");
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1344,6 +1400,10 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &own_address_type_fops);
 		debugfs_create_file("long_term_keys", 0400, hdev->debugfs,
 				    hdev, &long_term_keys_fops);
+		debugfs_create_file("conn_min_interval", 0644, hdev->debugfs,
+				    hdev, &conn_min_interval_fops);
+		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
+				    hdev, &conn_max_interval_fops);
 	}
 
 	return 0;
@@ -2809,6 +2869,8 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
+	hdev->le_conn_min_interval = 0x0028;
+	hdev->le_conn_max_interval = 0x0038;
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
-- 
1.8.3.1

