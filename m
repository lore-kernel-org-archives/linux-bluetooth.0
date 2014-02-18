Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v9 10/10] Bluetooth: Add le_auto_conn file on debugfs
Date: Tue, 18 Feb 2014 14:55:01 -0300
Message-Id: <1392746101-5981-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
References: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to debugfs the le_auto_conn file. This file will be
used to test LE auto connection infrastructure.

To add a new auto connection address we write on le_auto_conn file
following the format <address> <address type> <auto_connect>.

The <address type> values are:
  * 0 for public address
  * 1 for random address

The <auto_connect> values are (for more details see struct hci_
conn_params):
  * 0 for disabled
  * 1 for always
  * 2 for link loss

So for instance, if you want the kernel autonomously establishes
connections with device AA:BB:CC:DD:EE:FF (public address) every
time the device enters in connectable mode (starts advertising),
you should run the command:
$ echo "AA:BB:CC:DD:EE:FF 0 1" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

To get the list of connection parameters configured in kernel, read
the le_auto_conn file:
$ cat /sys/kernel/debug/bluetooth/hci0/le_auto_conn

Finally, to clear the connection parameters list, write an empty
string:
$ echo "" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

This file is created only if LE is enabled.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0adc642..04560fa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -728,6 +728,89 @@ static const struct file_operations lowpan_debugfs_fops = {
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
+	u8 auto_connect;
+	bdaddr_t addr;
+	u8 addr_type;
+	char *buf;
+	int n;
+
+	/* Don't allow partial write */
+	if (*offset != 0)
+		return -EINVAL;
+
+	/* If empty string, clear the connection parameters and pending LE
+	 * connection list.
+	 */
+	if (count == 1) {
+		hci_dev_lock(hdev);
+		hci_conn_params_clear(hdev);
+		hci_pend_le_conns_clear(hdev);
+		hci_dev_unlock(hdev);
+		return count;
+	}
+
+	buf = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, data, count)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu %hhu", &addr.b[5],
+		   &addr.b[4], &addr.b[3], &addr.b[2], &addr.b[1], &addr.b[0],
+		   &addr_type, &auto_connect);
+	if (n != 8) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	hci_dev_lock(hdev);
+	hci_conn_params_add(hdev, &addr, addr_type, auto_connect,
+			    hdev->le_conn_min_interval,
+			    hdev->le_conn_max_interval);
+	hci_dev_unlock(hdev);
+
+	kfree(buf);
+	return count;
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
@@ -1520,6 +1603,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_max_interval_fops);
 		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
 				    &lowpan_debugfs_fops);
+		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
+				    &le_auto_conn_fops);
 	}
 
 	return 0;
-- 
1.8.5.4

