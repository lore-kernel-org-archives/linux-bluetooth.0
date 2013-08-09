Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Set discovery parameters
Date: Fri,  9 Aug 2013 20:12:31 -0300
Message-Id: <1376089954-13639-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for setting discovery parameters through
debugfs filesystem.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 90cb53b..17ebc4a 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -553,9 +553,52 @@ static int discovery_parameters_open(struct inode *inode, struct file *file)
 	return single_open(file, discovery_parameters_show, inode->i_private);
 }
 
+static ssize_t discovery_parameters_write(struct file *file,
+					  const char __user *data,
+					  size_t count, loff_t *offset)
+{
+	struct seq_file *sfile = file->private_data;
+	struct hci_dev *hdev = sfile->private;
+	struct discovery_param param;
+	char *buf;
+	int n;
+	ssize_t res = 0;
+
+	/* We don't allow partial writes */
+	if (*offset != 0)
+		return 0;
+
+	buf = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	if (copy_from_user(buf, data, count))
+		goto out;
+
+	memset(&param, 0, sizeof(param));
+
+	n = sscanf(buf, "%hhx %hx %hx %u %u %hhx %hhx",
+		   &param.scan_type, &param.scan_interval, &param.scan_window,
+		   &param.le_scan_duration, &param.interleaved_scan_duration,
+		   &param.interleaved_inquiry_length,
+		   &param.bredr_inquiry_length);
+	if (n != 7)
+		goto out;
+
+	hci_dev_lock(hdev);
+	memcpy(&hdev->discovery_param, &param, sizeof(param));
+	hci_dev_unlock(hdev);
+
+	res = count;
+out:
+	kfree(buf);
+	return res;
+}
+
 static const struct file_operations discovery_parameters_fops = {
 	.open		= discovery_parameters_open,
 	.read		= seq_read,
+	.write		= discovery_parameters_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -602,7 +645,7 @@ int hci_add_sysfs(struct hci_dev *hdev)
 	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
 			    &auto_accept_delay_fops);
 
-	debugfs_create_file("discovery_parameters", 0444, hdev->debugfs, hdev,
+	debugfs_create_file("discovery_parameters", 0644, hdev->debugfs, hdev,
 			    &discovery_parameters_fops);
 	return 0;
 }
-- 
1.8.3.4

