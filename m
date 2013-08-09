Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/6] Bluetooth: Add support for setting LE connection parameters via debugfs
Date: Fri,  9 Aug 2013 20:12:34 -0300
Message-Id: <1376089954-13639-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This will allow for much more pratical measures of the impact of
different connection parameters in different scenarios.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 5993150..f3bf419 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -620,6 +620,47 @@ static int le_conn_parameters_show(struct seq_file *f, void *p)
 	return 0;
 }
 
+static ssize_t le_conn_parameters_write(struct file *filp,
+					const char __user *ubuf,
+					size_t cnt, loff_t *ppos)
+{
+	struct seq_file *seqf = filp->private_data;
+	struct hci_dev *hdev = seqf->private;
+	struct le_conn_params params;
+	char buffer[36];
+	int n;
+
+	/* No partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	/* Format: '0x0000 0x0000 0x0000 0x0000 0x0000' length 35 */
+	if (cnt != 35)
+		return -ENOSPC;
+
+	memset(buffer, 0, sizeof(buffer));
+
+	if (copy_from_user(buffer, ubuf, cnt))
+		return 0;
+
+	memset(&params, 0, sizeof(params));
+
+	n = sscanf(buffer, "%hx %hx %hx %hx %hx", &params.scan_interval,
+		   &params.scan_window, &params.conn_interval_min,
+		   &params.conn_interval_max, &params.supervision_timeout);
+
+	if (n < 5)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+
+	memcpy(&hdev->le_conn_params, &params, sizeof(params));
+
+	hci_dev_unlock(hdev);
+
+	return cnt;
+}
+
 static int le_conn_parameters_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, le_conn_parameters_show, inode->i_private);
@@ -627,6 +668,7 @@ static int le_conn_parameters_open(struct inode *inode, struct file *file)
 
 static const struct file_operations le_conn_parameters_fops = {
 	.open		= le_conn_parameters_open,
+	.write		= le_conn_parameters_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
-- 
1.8.3.4

