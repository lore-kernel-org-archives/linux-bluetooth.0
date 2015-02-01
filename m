Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose remote OOB information as debugfs entry
Date: Sat, 31 Jan 2015 21:01:07 -0800
Message-Id: <1422766867-29086-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes it is good to know which OOB data is actually
currently loaded for each controller. So expose that list via debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 5353f6ec8d68..65261e5d4b84 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -156,6 +156,35 @@ static const struct file_operations uuids_fops = {
 	.release	= single_release,
 };
 
+static int remote_oob_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct oob_data *data;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(data, &hdev->remote_oob_data, list) {
+		seq_printf(f, "%pMR (type %u) %u %*phN %*phN %*phN %*phN\n",
+			   &data->bdaddr, data->bdaddr_type, data->present,
+			   16, data->hash192, 16, data->rand192,
+			   16, data->hash256, 19, data->rand256);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int remote_oob_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, remote_oob_show, inode->i_private);
+}
+
+static const struct file_operations remote_oob_fops = {
+	.open		= remote_oob_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -264,6 +293,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
+	debugfs_create_file("remote_oob", 0400, hdev->debugfs, hdev,
+			    &remote_oob_fops);
 
 	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
 			    &conn_info_min_age_fops);
-- 
2.1.0

