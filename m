Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/17] Bluetooth: Add le_auto_conn file on debugfs
Date: Wed, 26 Feb 2014 20:21:54 -0300
Message-Id: <1393456916-22701-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to debugfs the le_auto_conn file. This file will be
used to test LE auto connection infrastructure.

This file accept writes in the following format:
  "add <address> <address_type> [auto_connect]"
  "del <address> <address_type>"
  "clr"

The <address type> values are:
  * 0 for public address
  * 1 for random address

The [auto_connect] values are (for more details see struct hci_
conn_params):
  * 0 for disabled (default)
  * 1 for always
  * 2 for link loss

So for instance, if you want the kernel autonomously establishes
connections with device AA:BB:CC:DD:EE:FF (public address) every
time the device enters in connectable mode (starts advertising),
you should run the command:
$ echo "add AA:BB:CC:DD:EE:FF 0 1" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

To delete the connection parameters for that device, run the command:
$ echo "del AA:BB:CC:DD:EE:FF 0" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

To clear the connection parameters list, run the command:
$ echo "clr" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

Finally. to get the list of connection parameters configured in kernel,
read the le_auto_conn file:
$ cat /sys/kernel/debug/bluetooth/hci0/le_auto_conn

This file is created only if LE is enabled.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6d83ca0..0b96f20 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -896,6 +896,115 @@ static const struct file_operations lowpan_debugfs_fops = {
 	.llseek		= default_llseek,
 };
 
+static int le_auto_conn_show(struct seq_file *sf, void *ptr)
+{
+	struct hci_dev *hdev = sf->private;
+	struct hci_conn_params *p;
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(p, &hdev->le_conn_params, list) {
+		seq_printf(sf, "%pMR %u %u\n", &p->addr, p->addr_type,
+			   p->auto_connect);
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int le_auto_conn_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, le_auto_conn_show, inode->i_private);
+}
+
+static ssize_t le_auto_conn_write(struct file *file, const char __user *data,
+				  size_t count, loff_t *offset)
+{
+	struct seq_file *sf = file->private_data;
+	struct hci_dev *hdev = sf->private;
+	u8 auto_connect = 0;
+	bdaddr_t addr;
+	u8 addr_type;
+	char *buf;
+	int err = 0;
+	int n;
+
+	/* Don't allow partial write */
+	if (*offset != 0)
+		return -EINVAL;
+
+	if (count < 3)
+		return -EINVAL;
+
+	buf = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, data, count)) {
+		err = -EFAULT;
+		goto done;
+	}
+
+	if (memcmp(buf, "add", 3) == 0) {
+		n = sscanf(&buf[4], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu %hhu",
+			   &addr.b[5], &addr.b[4], &addr.b[3], &addr.b[2],
+			   &addr.b[1], &addr.b[0], &addr_type,
+			   &auto_connect);
+
+		if (n < 7) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		hci_dev_lock(hdev);
+		err = hci_conn_params_add(hdev, &addr, addr_type, auto_connect,
+					  hdev->le_conn_min_interval,
+					  hdev->le_conn_max_interval);
+		hci_dev_unlock(hdev);
+
+		if (err)
+			goto done;
+	} else if (memcmp(buf, "del", 3) == 0) {
+		n = sscanf(&buf[4], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
+			   &addr.b[5], &addr.b[4], &addr.b[3], &addr.b[2],
+			   &addr.b[1], &addr.b[0], &addr_type);
+
+		if (n < 7) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		hci_dev_lock(hdev);
+		hci_conn_params_del(hdev, &addr, addr_type);
+		hci_dev_unlock(hdev);
+	} else if (memcmp(buf, "clr", 3) == 0) {
+		hci_dev_lock(hdev);
+		hci_conn_params_clear(hdev);
+		hci_pend_le_conns_clear(hdev);
+		hci_update_background_scan(hdev);
+		hci_dev_unlock(hdev);
+	} else {
+		err = -EINVAL;
+	}
+
+done:
+	kfree(buf);
+
+	if (err)
+		return err;
+	else
+		return count;
+}
+
+static const struct file_operations le_auto_conn_fops = {
+	.open		= le_auto_conn_open,
+	.read		= seq_read,
+	.write		= le_auto_conn_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1694,6 +1803,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &adv_channel_map_fops);
 		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
 				    &lowpan_debugfs_fops);
+		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
+				    &le_auto_conn_fops);
 	}
 
 	return 0;
-- 
1.8.5.4

