Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Export discovery parameters on debugfs
Date: Fri,  9 Aug 2013 20:12:30 -0300
Message-Id: <1376089954-13639-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch exports discovery parameters thought debugfs filesystem.
The default values are:

$ cat discovery_parameters
0x01 0x0012 0x0012 10240 5120 0x04 0x08

The file format is the following:
Scanning type
Scanning interval
Scanning window
Scanning duration (in milliseconds) in LE discovery
Scanning duration (in milliseconds) in interleaved discovery
Inquiry length used in interleaved discovery
Inquiry length used in BR/EDR discovery

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 7ad6ecf..90cb53b 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -531,6 +531,35 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static int discovery_parameters_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct discovery_param *p = &hdev->discovery_param;
+
+	hci_dev_lock(hdev);
+
+	seq_printf(f, "0x%.2x 0x%.4x 0x%.4x %u %u 0x%.2x 0x%.2x\n",
+		   p->scan_type, p->scan_interval, p->scan_window,
+		   p->le_scan_duration, p->interleaved_scan_duration,
+		   p->interleaved_inquiry_length, p->bredr_inquiry_length);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int discovery_parameters_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, discovery_parameters_show, inode->i_private);
+}
+
+static const struct file_operations discovery_parameters_fops = {
+	.open		= discovery_parameters_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 void hci_init_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -572,6 +601,9 @@ int hci_add_sysfs(struct hci_dev *hdev)
 
 	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
 			    &auto_accept_delay_fops);
+
+	debugfs_create_file("discovery_parameters", 0444, hdev->debugfs, hdev,
+			    &discovery_parameters_fops);
 	return 0;
 }
 
-- 
1.8.3.4

