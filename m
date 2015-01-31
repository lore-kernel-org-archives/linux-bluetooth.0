Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose debug keys usage setting via debugfs
Date: Sat, 31 Jan 2015 15:12:06 -0800
Message-Id: <1422745926-30299-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To allow easier debugging when debug keys are generated, provide debugfs
entry for checking the setting of debug keys usage.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 51a424cfa94a..2272384755d5 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -212,6 +212,24 @@ static int conn_info_max_age_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
 			conn_info_max_age_set, "%llu\n");
 
+static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static const struct file_operations use_debug_keys_fops = {
+	.open		= simple_open,
+	.read		= use_debug_keys_read,
+	.llseek		= default_llseek,
+};
+
 static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 				 size_t count, loff_t *ppos)
 {
@@ -249,6 +267,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
 			    &conn_info_max_age_fops);
 
+	if (lmp_ssp_capable(hdev) || lmp_le_capable(hdev))
+		debugfs_create_file("use_debug_keys", 0444, hdev->debugfs,
+				    hdev, &use_debug_keys_fops);
+
 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
-- 
2.1.0

