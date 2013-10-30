Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 7/7] Bluetooth: Manually enable or disable 6LoWPAN between devices
Date: Wed, 30 Oct 2013 11:01:01 +0200
Message-Id: <1383123661-15087-8-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a temporary patch where user can manually enable or
disable BT 6LoWPAN functionality between devices.
Eventually the connection is established automatically if
the devices are advertising suitable capability and this patch
can be removed.

If you have two devices with these BT addresses
        device1  00:11:22:33:44:55
        device2  66:77:88:99:00:11

First add the desired devices manually into kernel

root@dev1# echo 66:77:88:99:00:11 > /sys/kernel/debug/bluetooth/hci0/6lowpan
root@dev2# echo 00:11:22:33:44:55 > /sys/kernel/debug/bluetooth/hci0/6lowpan

then connect the devices

root@dev1# hciconfig hci0 leadv
root@dev2# hcitool lecc 00:11:22:33:44:55

if the connection is established, then you can send IPv6 packets
between these two systems using the link local addresses

root@dev1# ping6 fe80::6477:88ff:fe99:0011
root@dev2# ping6 fe80::211:22ff:fe33:4455

By default 6LoWPAN connection is not established between devices,
so you need to add the MAC addresses manually into the
/sys/kernel/debug/bluetooth/hci0/6lowpan file.
If you want to prevent further connections you can remove
MAC address from the debugfs file like this
echo "00:11:22:33:44:55 d" > /sys/kernel/debug/bluetooth/hci0/6lowpan
Rebooting or unloading the bluetooth kernel module will also clear the
settings from the kernel.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c    | 158 +++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h    |   2 +
 net/bluetooth/hci_core.c   |   4 ++
 net/bluetooth/l2cap_core.c |  12 ++--
 4 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4ec3813..55f455a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/version.h>
+#include <linux/debugfs.h>
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
@@ -1553,6 +1554,163 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
 	.notifier_call = device_event,
 };
 
+static LIST_HEAD(user_enabled);
+DEFINE_RWLOCK(user_enabled_list_lock);
+
+struct lowpan_enabled {
+	__u8 dev_name[HCI_MAX_NAME_LENGTH];
+	bdaddr_t addr;
+	struct list_head list;
+};
+
+bool bt_6lowpan_is_enabled(struct hci_dev *hdev, bdaddr_t *dst)
+{
+	struct lowpan_enabled *entry, *tmp;
+	bool found = false;
+
+	write_lock(&user_enabled_list_lock);
+	list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
+		if (!strncmp(entry->dev_name, hdev->dev_name,
+				HCI_MAX_NAME_LENGTH) &&
+				!bacmp(dst, &entry->addr)) {
+			found = true;
+			break;
+		}
+	}
+	write_unlock(&user_enabled_list_lock);
+
+	/* Check also the device list just in case we removed the
+	 * device from debugfs before disconnecting.
+	 */
+	if (!found) {
+		struct lowpan_dev *entry, *tmp;
+		struct lowpan_info *info;
+
+		write_lock(&net_dev_list_lock);
+		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
+								list) {
+			info = lowpan_info(entry->dev);
+			if (info->conn->hcon->hdev == hdev &&
+						!bacmp(&info->addr, dst)) {
+				found = true;
+				break;
+			}
+		}
+		write_unlock(&net_dev_list_lock);
+	}
+
+	return found;
+}
+
+static int debugfs_show(struct seq_file *f, void *p)
+{
+	struct lowpan_enabled *entry, *tmp;
+
+	write_lock(&user_enabled_list_lock);
+	list_for_each_entry_safe(entry, tmp, &user_enabled, list)
+		seq_printf(f, "%pMR\n", &entry->addr);
+
+	write_unlock(&user_enabled_list_lock);
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
+#define MAC_STR_LEN 17
+	char mac_buf[MAC_STR_LEN + 1];
+	ssize_t ret;
+	bool delete_mode = false;
+	struct lowpan_enabled *entry = NULL, *tmp;
+	bdaddr_t bdaddr;
+
+        if(count > (MAC_STR_LEN + 1))
+		delete_mode = true;
+	else if (count < MAC_STR_LEN)
+		return count;
+
+	BT_DBG("count %zd mode %d", count, delete_mode);
+
+	memset(mac_buf, 0, MAC_STR_LEN + 1);
+        ret = simple_write_to_buffer(mac_buf, MAC_STR_LEN, position,
+							user_buffer, count);
+	if (ret <= 0)
+		return ret;
+
+	if (sscanf(mac_buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			&bdaddr.b[5], &bdaddr.b[4],
+			&bdaddr.b[3], &bdaddr.b[2],
+			&bdaddr.b[1], &bdaddr.b[0]) != 6)
+		return -EINVAL;
+
+	BT_DBG("user %pMR", &bdaddr);
+
+	write_lock(&user_enabled_list_lock);
+	list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
+		if (!bacmp(&entry->addr, &bdaddr)) {
+			struct hci_dev *hdev = fp->f_inode->i_private;
+
+			if (!strncmp(entry->dev_name, hdev->dev_name,
+					HCI_MAX_NAME_LENGTH) && delete_mode) {
+				break;
+			} else {
+				ret = -EEXIST;
+				break;
+			}
+		}
+	}
+	write_unlock(&user_enabled_list_lock);
+
+	if (ret < 0)
+		return ret;
+
+	if (delete_mode) {
+		write_lock(&user_enabled_list_lock);
+		list_del(&entry->list);
+		kfree(entry);
+		write_unlock(&user_enabled_list_lock);
+	} else {
+		struct hci_dev *hdev = fp->f_inode->i_private;
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		strncpy(entry->dev_name, hdev->dev_name, HCI_MAX_NAME_LENGTH);
+		entry->addr = bdaddr;
+
+		write_lock(&user_enabled_list_lock);
+		INIT_LIST_HEAD(&entry->list);
+		list_add(&entry->list, &user_enabled);
+		write_unlock(&user_enabled_list_lock);
+	}
+
+	return ret;
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
+static struct dentry *bt_6lowpan_debugfs;
+
+void bt_6lowpan_add_debugfs(struct hci_dev *hdev)
+{
+	if (hdev->debugfs)
+		bt_6lowpan_debugfs = debugfs_create_file("6lowpan", 0644,
+			hdev->debugfs, hdev, &ble_6lowpan_debugfs_fops);
+}
+
 int bt_6lowpan_init(void)
 {
 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
index 680eac8..549fc51 100644
--- a/net/bluetooth/6lowpan.h
+++ b/net/bluetooth/6lowpan.h
@@ -22,5 +22,7 @@ int bt_6lowpan_add_conn(struct l2cap_conn *conn);
 int bt_6lowpan_del_conn(struct l2cap_conn *conn);
 int bt_6lowpan_init(void);
 void bt_6lowpan_cleanup(void);
+bool bt_6lowpan_is_enabled(struct hci_dev *hdev, bdaddr_t *dst);
+void bt_6lowpan_add_debugfs(struct hci_dev *hdev);
 
 #endif /* __6LOWPAN_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6ccc4eb..444b4bc 100644
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
@@ -1406,6 +1408,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &conn_max_interval_fops);
 	}
 
+	bt_6lowpan_add_debugfs(hdev);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c47215f..d02241e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6512,11 +6512,6 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return exact ? lm1 : lm2;
 }
 
-static bool is_bt_6lowpan(void)
-{
-	return false;
-}
-
 void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
@@ -6528,7 +6523,9 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		if (conn) {
 			l2cap_conn_ready(conn);
 
-			if (hcon->type == LE_LINK && is_bt_6lowpan())
+			if (hcon->type == LE_LINK &&
+					bt_6lowpan_is_enabled(hcon->hdev,
+								&hcon->dst))
 				bt_6lowpan_add_conn(conn);
 		}
 	} else {
@@ -6551,7 +6548,8 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	if (hcon->type == LE_LINK && is_bt_6lowpan())
+	if (hcon->type == LE_LINK && bt_6lowpan_is_enabled(hcon->hdev,
+							&hcon->dst))
 		bt_6lowpan_del_conn(hcon->l2cap_data);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
-- 
1.7.11.7

