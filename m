Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 5/5] Bluetooth: Manually enable or disable 6LoWPAN between devices
Date: Wed, 11 Dec 2013 09:38:50 +0200
Message-Id: <1386747530-15830-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1386747530-15830-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1386747530-15830-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a temporary patch where user can manually enable or
disable BT 6LoWPAN functionality between devices.
Eventually the connection is established automatically if
the devices are advertising suitable capability and this patch
can be removed.

Before connecting the devices do this

echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan

This enables 6LoWPAN support and creates the bt0 interface
automatically when devices are finally connected.

Rebooting or unloading the bluetooth kernel module will also clear the
settings from the kernel.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/hci_core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b8b5f8..e5b43cc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -636,6 +636,57 @@ static int conn_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
 			conn_max_interval_set, "%llu\n");
 
+static ssize_t lowpan_read(struct file *file, char __user *user_buf,
+			   size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t lowpan_write(struct file *fp, const char __user *user_buffer,
+			    size_t count, loff_t *position)
+{
+	struct hci_dev *hdev = fp->private_data;
+	bool new_value, old_value;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	ssize_t ret;
+
+	BT_DBG("dev %s count %zd", hdev->dev_name, count);
+
+	if (copy_from_user(buf, user_buffer, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+
+	if (strtobool(buf, &new_value) < 0)
+		return -EINVAL;
+
+	ret = -ENOENT;
+
+	if (ret == 0 && old_value == new_value)
+		return count;
+
+	if (new_value == true)
+		set_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags);
+	else
+		clear_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags);
+
+	return count;
+}
+
+static const struct file_operations lowpan_debugfs_fops = {
+	.open		= simple_open,
+	.read		= lowpan_read,
+	.write		= lowpan_write,
+	.llseek		= default_llseek,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1406,6 +1457,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_min_interval_fops);
 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
 				    hdev, &conn_max_interval_fops);
+		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
+				    &lowpan_debugfs_fops);
 	}
 
 	return 0;
-- 
1.8.3.1

