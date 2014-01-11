Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add debugfs entry to show Secure Connections Only mode
Date: Sat, 11 Jan 2014 14:20:28 -0800
Message-Id: <1389478828-44922-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes of Secure Connection Only support a simple
debugfs entry is used to indicate if this mode is active or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 499ec1b1095d..369d30750417 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -461,6 +461,24 @@ static const struct file_operations force_sc_support_fops = {
 	.llseek		= default_llseek,
 };
 
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
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1491,6 +1509,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &ssp_debug_mode_fops);
 		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
 				    hdev, &force_sc_support_fops);
+		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
+				    hdev, &sc_only_mode_fops);
 	}
 
 	if (lmp_sniff_capable(hdev)) {
-- 
1.8.4.2

