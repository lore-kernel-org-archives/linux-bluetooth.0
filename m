Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Replace le_auto_conn debugfs with device_list entry
Date: Sun, 29 Jun 2014 16:15:49 +0200
Message-Id: <1404051349-28707-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the auto-connection handling has gained offical management
command support, remove the le_auto_conn debugfs entry.

For debugging purposes replace it a simple device_list debugfs
entry that allows listing of the current internal auto-connection
list used for passive scanning.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 93 +++++-------------------------------------------
 1 file changed, 9 insertions(+), 84 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c566b57610c9..b2b7f6ed3c89 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -879,104 +879,29 @@ static int adv_channel_map_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
 			adv_channel_map_set, "%llu\n");
 
-static int le_auto_conn_show(struct seq_file *sf, void *ptr)
+static int device_list_show(struct seq_file *f, void *ptr)
 {
-	struct hci_dev *hdev = sf->private;
+	struct hci_dev *hdev = f->private;
 	struct hci_conn_params *p;
 
 	hci_dev_lock(hdev);
-
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
-		seq_printf(sf, "%pMR %u %u\n", &p->addr, p->addr_type,
+		seq_printf(f, "%pMR %u %u\n", &p->addr, p->addr_type,
 			   p->auto_connect);
 	}
-
 	hci_dev_unlock(hdev);
 
 	return 0;
 }
 
-static int le_auto_conn_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, le_auto_conn_show, inode->i_private);
-}
-
-static ssize_t le_auto_conn_write(struct file *file, const char __user *data,
-				  size_t count, loff_t *offset)
+static int device_list_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *sf = file->private_data;
-	struct hci_dev *hdev = sf->private;
-	u8 auto_connect = 0;
-	bdaddr_t addr;
-	u8 addr_type;
-	char *buf;
-	int err = 0;
-	int n;
-
-	/* Don't allow partial write */
-	if (*offset != 0)
-		return -EINVAL;
-
-	if (count < 3)
-		return -EINVAL;
-
-	buf = memdup_user(data, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	if (memcmp(buf, "add", 3) == 0) {
-		n = sscanf(&buf[4], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu %hhu",
-			   &addr.b[5], &addr.b[4], &addr.b[3], &addr.b[2],
-			   &addr.b[1], &addr.b[0], &addr_type,
-			   &auto_connect);
-
-		if (n < 7) {
-			err = -EINVAL;
-			goto done;
-		}
-
-		hci_dev_lock(hdev);
-		err = hci_conn_params_add(hdev, &addr, addr_type, auto_connect,
-					  hdev->le_conn_min_interval,
-					  hdev->le_conn_max_interval);
-		hci_dev_unlock(hdev);
-
-		if (err)
-			goto done;
-	} else if (memcmp(buf, "del", 3) == 0) {
-		n = sscanf(&buf[4], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
-			   &addr.b[5], &addr.b[4], &addr.b[3], &addr.b[2],
-			   &addr.b[1], &addr.b[0], &addr_type);
-
-		if (n < 7) {
-			err = -EINVAL;
-			goto done;
-		}
-
-		hci_dev_lock(hdev);
-		hci_conn_params_del(hdev, &addr, addr_type);
-		hci_dev_unlock(hdev);
-	} else if (memcmp(buf, "clr", 3) == 0) {
-		hci_dev_lock(hdev);
-		hci_conn_params_clear(hdev);
-		hci_dev_unlock(hdev);
-	} else {
-		err = -EINVAL;
-	}
-
-done:
-	kfree(buf);
-
-	if (err)
-		return err;
-	else
-		return count;
+	return single_open(file, device_list_show, inode->i_private);
 }
 
-static const struct file_operations le_auto_conn_fops = {
-	.open		= le_auto_conn_open,
+static const struct file_operations device_list_fops = {
+	.open		= device_list_open,
 	.read		= seq_read,
-	.write		= le_auto_conn_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1785,8 +1710,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_max_interval_fops);
 		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
 				    hdev, &adv_channel_map_fops);
-		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
-				    &le_auto_conn_fops);
+		debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
+				    &device_list_fops);
 		debugfs_create_u16("discov_interleaved_timeout", 0644,
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
-- 
1.9.3

