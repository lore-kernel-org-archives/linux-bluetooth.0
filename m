Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose current identity information in debugfs
Date: Sun, 23 Feb 2014 12:44:25 -0800
Message-Id: <1393188265-55337-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using LE Privacy it is useful to know the local identity address,
identity address type and identity resolving key. For debugging purposes
add these information to debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1651de959d9c..80462a126ebd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -579,6 +579,42 @@ static int sniff_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
 			sniff_max_interval_set, "%llu\n");
 
+static int identity_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	bdaddr_t *addr;
+	u8 addr_type;
+
+	hci_dev_lock(hdev);
+
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		addr = &hdev->static_addr;
+		addr_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		addr = &hdev->bdaddr;
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	}
+
+	seq_printf(f, "%pMR (type %u) %*phN\n", addr, addr_type, 16, hdev->irk);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int identity_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, identity_show, inode->i_private);
+}
+
+static const struct file_operations identity_fops = {
+	.open		= identity_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int random_address_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1624,12 +1660,14 @@ static int __hci_init(struct hci_dev *hdev)
 	}
 
 	if (lmp_le_capable(hdev)) {
+		debugfs_create_file("identity", 0400, hdev->debugfs,
+				    hdev, &identity_fops);
+		debugfs_create_file("rpa_timeout", 0644, hdev->debugfs,
+				    hdev, &rpa_timeout_fops);
 		debugfs_create_file("random_address", 0444, hdev->debugfs,
 				    hdev, &random_address_fops);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				    hdev, &static_address_fops);
-		debugfs_create_file("rpa_timeout", 0644, hdev->debugfs,
-				    hdev, &rpa_timeout_fops);
 
 		/* For controllers with a public address, provide a debug
 		 * option to force the usage of the configured static
-- 
1.8.5.3

