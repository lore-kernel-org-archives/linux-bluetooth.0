Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 3/3] Bluetooth: Add support for setting LE connection parameters via debugfs
Date: Mon,  5 Nov 2012 14:25:43 +0100
Message-Id: <1352121943-18001-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for much more pratical measures of the impact of
different connection parameters in different scenarios.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a9554ec..8474d02 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -550,6 +550,48 @@ static int le_conn_parameters_show(struct seq_file *f, void *p)
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
+	n = copy_from_user(buffer, ubuf, cnt);
+	if (n < 0)
+		return n;
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
@@ -557,6 +599,7 @@ static int le_conn_parameters_open(struct inode *inode, struct file *file)
 
 static const struct file_operations le_conn_parameters_fops = {
 	.open		= le_conn_parameters_open,
+	.write		= le_conn_parameters_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
-- 
1.7.12.4

