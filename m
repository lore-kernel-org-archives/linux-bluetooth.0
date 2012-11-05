Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 2/3] Bluetooth: Add LE connection parameters to debugfs
Date: Mon,  5 Nov 2012 14:25:42 +0100
Message-Id: <1352121943-18001-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only reading the parameters is supported for now.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 55cceee..a9554ec 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -532,6 +532,36 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+
+static int le_conn_parameters_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct le_conn_params *params = &hdev->le_conn_params;
+
+	hci_dev_lock(hdev);
+
+	seq_printf(f, "0x%.4x 0x%.4x 0x%.4x 0x%.4x 0x%.4x\n",
+		   params->scan_interval, params->scan_window,
+		   params->conn_interval_min, params->conn_interval_max,
+		   params->supervision_timeout);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int le_conn_parameters_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, le_conn_parameters_show, inode->i_private);
+}
+
+static const struct file_operations le_conn_parameters_fops = {
+	.open		= le_conn_parameters_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 void hci_init_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -573,6 +603,10 @@ int hci_add_sysfs(struct hci_dev *hdev)
 
 	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
 			    &auto_accept_delay_fops);
+
+	debugfs_create_file("le_conn_parameters", 0644, hdev->debugfs, hdev,
+			    &le_conn_parameters_fops);
+
 	return 0;
 }
 
-- 
1.7.12.4

