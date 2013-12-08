Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 5/5] Bluetooth: Manually enable or disable 6LoWPAN between devices
Date: Sun,  8 Dec 2013 13:10:56 +0200
Message-Id: <1386501056-2555-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1386501056-2555-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1386501056-2555-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a temporary patch where user can manually enable or
disable BT 6LoWPAN functionality between devices.
Eventually the connection is established automatically if
the devices are advertising suitable capability and this patch
can be removed.

Before connecting the devices do this

echo 1 > /sys/kernel/debug/bluetooth/hci0/6lowpan

This enables 6LoWPAN support and creates the bt0 interface
automatically when devices are finally connected.

Rebooting or unloading the bluetooth kernel module will also clear the
settings from the kernel.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/hci_core.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 03e8355..0a2ec42 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -636,6 +636,97 @@ static int conn_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
 			conn_max_interval_set, "%llu\n");
 
+static LIST_HEAD(lowpan_user_enabled);
+static DEFINE_RWLOCK(lowpan_enabled_lock);
+
+struct lowpan_enabled {
+	__u8 dev_name[HCI_MAX_NAME_LENGTH];
+	bool enabled;
+	struct list_head list;
+};
+
+static int lowpan_debugfs_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+
+	if (test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags))
+		seq_printf(f, "1\n");
+	else
+		seq_printf(f, "0\n");
+
+	return 0;
+}
+
+static int lowpan_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lowpan_debugfs_show, inode->i_private);
+}
+
+static ssize_t lowpan_writer(struct file *fp, const char __user *user_buffer,
+			     size_t count, loff_t *position)
+{
+	struct hci_dev *hdev = fp->f_inode->i_private;
+	struct lowpan_enabled *entry = NULL, *tmp;
+	bool new_value, old_value;
+	char buf[3] = { 0 };
+	ssize_t ret;
+
+	BT_DBG("dev %s count %zd", hdev->dev_name, count);
+
+        ret = simple_write_to_buffer(buf, 2, position, user_buffer, count);
+	if (ret <= 0)
+		return ret;
+
+	if (strtobool(buf, &new_value) < 0)
+		return -EINVAL;
+
+	ret = -ENOENT;
+
+	write_lock(&lowpan_enabled_lock);
+	list_for_each_entry_safe(entry, tmp, &lowpan_user_enabled, list) {
+		if (!strncmp(entry->dev_name, hdev->dev_name,
+						HCI_MAX_NAME_LENGTH)) {
+			old_value = entry->enabled;
+			entry->enabled = new_value;
+			ret = 0;
+			break;
+		}
+	}
+	write_unlock(&lowpan_enabled_lock);
+
+	if (ret == 0 && old_value == new_value)
+		return count;
+
+	if (ret < 0) {
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		strncpy(entry->dev_name, hdev->dev_name, HCI_MAX_NAME_LENGTH);
+		entry->enabled = new_value;
+
+		write_lock(&lowpan_enabled_lock);
+		INIT_LIST_HEAD(&entry->list);
+		list_add(&entry->list, &lowpan_user_enabled);
+		write_unlock(&lowpan_enabled_lock);
+	}
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
+	.open		= lowpan_debugfs_open,
+	.read		= seq_read,
+	.write		= lowpan_writer,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1406,6 +1497,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_min_interval_fops);
 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
 				    hdev, &conn_max_interval_fops);
+		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
+				    &lowpan_debugfs_fops);
 	}
 
 	return 0;
-- 
1.8.3.1

