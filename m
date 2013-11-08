Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 8/8] Bluetooth: Manually enable or disable 6LoWPAN between devices
Date: Fri,  8 Nov 2013 17:23:15 +0200
Message-Id: <1383924195-7936-9-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
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
 net/bluetooth/6lowpan.c  | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h  |   1 +
 net/bluetooth/hci_core.c |   4 ++
 3 files changed, 110 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index e70302a..a8891f5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -26,6 +26,8 @@
  */
 
 #include <linux/version.h>
+#include <linux/debugfs.h>
+#include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
@@ -1607,6 +1609,109 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
 	.notifier_call = device_event,
 };
 
+static LIST_HEAD(user_enabled);
+DEFINE_RWLOCK(enabled_lock);
+
+struct lowpan_enabled {
+	__u8 dev_name[HCI_MAX_NAME_LENGTH];
+	bool enabled;
+	struct list_head list;
+};
+
+static int debugfs_show(struct seq_file *f, void *p)
+{
+	struct lowpan_enabled *entry, *tmp;
+	bool found = false;
+
+	write_lock(&enabled_lock);
+	list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
+		seq_printf(f, "%d\n", entry->enabled);
+		found = true;
+	}
+	write_unlock(&enabled_lock);
+
+	if (!found)
+		seq_printf(f, "0\n");
+
+	return 0;
+}
+
+static int debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, debugfs_show, inode->i_private);
+}
+
+static ssize_t writer(struct file *fp, const char __user *user_buffer,
+		size_t count, loff_t *position)
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
+	write_lock(&enabled_lock);
+	list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
+		if (!strncmp(entry->dev_name, hdev->dev_name,
+						HCI_MAX_NAME_LENGTH)) {
+			old_value = entry->enabled;
+			entry->enabled = new_value;
+			ret = 0;
+			break;
+		}
+	}
+	write_unlock(&enabled_lock);
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
+		write_lock(&enabled_lock);
+		INIT_LIST_HEAD(&entry->list);
+		list_add(&entry->list, &user_enabled);
+		write_unlock(&enabled_lock);
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
+static const struct file_operations ble_6lowpan_debugfs_fops = {
+	.open		= debugfs_open,
+	.read		= seq_read,
+	.write		= writer,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+void bt_6lowpan_add_debugfs(struct hci_dev *hdev)
+{
+	debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
+			&ble_6lowpan_debugfs_fops);
+}
+
 int bt_6lowpan_init(void)
 {
 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
index 680eac8..5f60cf2 100644
--- a/net/bluetooth/6lowpan.h
+++ b/net/bluetooth/6lowpan.h
@@ -22,5 +22,6 @@ int bt_6lowpan_add_conn(struct l2cap_conn *conn);
 int bt_6lowpan_del_conn(struct l2cap_conn *conn);
 int bt_6lowpan_init(void);
 void bt_6lowpan_cleanup(void);
+void bt_6lowpan_add_debugfs(struct hci_dev *hdev);
 
 #endif /* __6LOWPAN_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 03e8355..a229ce0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -34,6 +34,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "6lowpan.h"
+
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
@@ -1408,6 +1410,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_max_interval_fops);
 	}
 
+	bt_6lowpan_add_debugfs(hdev);
+
 	return 0;
 }
 
-- 
1.8.3.1

