Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 1/5] Bluetooth: Add conn info lifetime parameters to debugfs
Date: Wed, 14 May 2014 12:49:39 +0200
Message-ID: <1400064583-12623-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds conn_info_min_age and conn_info_max_age parameters to
debugfs which determine lifetime of connection information. Actual
lifetime will be random value between min and max age.

Default values for min and max age are 1000ms and 3000ms respectively.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h |  6 ++++
 net/bluetooth/hci_core.c         | 63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 211bad6..4623f45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -145,6 +145,10 @@ struct oob_data {
 /* Default LE RPA expiry time, 15 minutes */
 #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
 
+/* Default min/max age of connection information (1s/3s) */
+#define DEFAULT_CONN_INFO_MIN_AGE	1000
+#define DEFAULT_CONN_INFO_MAX_AGE	3000
+
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
@@ -200,6 +204,8 @@ struct hci_dev {
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__u16		discov_interleaved_timeout;
+	__u16		conn_info_min_age;
+	__u16		conn_info_max_age;
 	__u8		ssp_debug_mode;
 
 	__u16		devid_source;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d31f144..313bd1c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -579,6 +579,62 @@ static int sniff_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
 			sniff_max_interval_set, "%llu\n");
 
+static int conn_info_min_age_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val > hdev->conn_info_max_age)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->conn_info_min_age = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_info_min_age_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->conn_info_min_age;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
+			conn_info_min_age_set, "%llu\n");
+
+static int conn_info_max_age_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val < hdev->conn_info_min_age)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->conn_info_max_age = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_info_max_age_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->conn_info_max_age;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
+			conn_info_max_age_set, "%llu\n");
+
 static int identity_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1754,6 +1810,11 @@ static int __hci_init(struct hci_dev *hdev)
 			    &blacklist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
+	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
+			    &conn_info_min_age_fops);
+	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
+			    &conn_info_max_age_fops);
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
@@ -3789,6 +3850,8 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
+	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
+	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
-- 
1.9.3

