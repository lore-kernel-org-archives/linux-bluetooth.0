Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix scope of sc_only_mode debugfs entry
Date: Wed, 31 Dec 2014 14:43:19 -0800
Message-Id: <1420065799-28781-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The sc_only_mode debugfs entry is used to read the current state of the
Secure Connections Only mode. Before Bluetooth 4.2 this mode was only
for BR/EDR controllers and with that tight to the support Secure Simple
Pairing. Since Secure Connections is now available for BR/EDR and LE
this debugfs entry is no longer correctly place.

Move it to the common section and enable it when either BR/EDR Secure
Connections feature is supported or when the controller has LE support.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index d72ebc2b11fa..ead89a5ad9ce 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -212,6 +212,24 @@ static int conn_info_max_age_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
 			conn_info_max_age_set, "%llu\n");
 
+static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_SC_ONLY, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static const struct file_operations sc_only_mode_fops = {
+	.open		= simple_open,
+	.read		= sc_only_mode_read,
+	.llseek		= default_llseek,
+};
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
@@ -230,6 +248,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 			    &conn_info_min_age_fops);
 	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
 			    &conn_info_max_age_fops);
+
+	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
+		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
+				    hdev, &sc_only_mode_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
@@ -357,24 +379,6 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
-static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_SC_ONLY, &hdev->dev_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static const struct file_operations sc_only_mode_fops = {
-	.open		= simple_open,
-	.read		= sc_only_mode_read,
-	.llseek		= default_llseek,
-};
-
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -470,12 +474,9 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
 			    &voice_setting_fops);
 
-	if (lmp_ssp_capable(hdev)) {
+	if (lmp_ssp_capable(hdev))
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
-		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
-				    hdev, &sc_only_mode_fops);
-	}
 
 	if (lmp_sniff_capable(hdev)) {
 		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
-- 
2.1.0

