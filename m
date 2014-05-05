Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: 6LoWPAN: Allow user to set the device role via sysfs
Date: Mon,  5 May 2014 12:31:24 +0300
Message-Id: <1399282285-32743-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is temporary patch that will eventually disappear when
the 6LoWPAN device services can be discovered automatically.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 53 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 4 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4261a67..3060254 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -140,6 +140,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_6LOWPAN_ENABLED,
+	HCI_6LOWPAN_ROLE_NODE,
 	HCI_LE_SCAN_INTERRUPTED,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d73f418..3cf9c45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -510,6 +510,7 @@ enum {
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_6LOWPAN,
+	HCI_CONN_6LOWPAN_ROLE_NODE,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d31f144..b0558cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -914,6 +914,57 @@ static const struct file_operations lowpan_debugfs_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t lowpan_role_read(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[8];
+	int i;
+
+	if (test_bit(HCI_6LOWPAN_ROLE_NODE, &hdev->dev_flags)) {
+		strncpy(buf, "node", 4);
+		i = 4;
+	} else {
+		strncpy(buf, "router", 6);
+		i = 6;
+	}
+	buf[i] = '\n';
+	buf[i + 1] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, i + 1);
+}
+
+static ssize_t lowpan_role_write(struct file *fp,
+				 const char __user *user_buffer,
+				 size_t count, loff_t *position)
+{
+	struct hci_dev *hdev = fp->private_data;
+	bool node = false;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+
+	if (copy_from_user(buf, user_buffer, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+
+	if (buf[0] == 'n' || buf[0] == 'N')
+		node = true;
+
+	if (node == test_bit(HCI_6LOWPAN_ROLE_NODE, &hdev->dev_flags))
+		return -EALREADY;
+
+	change_bit(HCI_6LOWPAN_ROLE_NODE, &hdev->dev_flags);
+
+	return count;
+}
+
+static const struct file_operations lowpan_role_debugfs_fops = {
+	.open		= simple_open,
+	.read		= lowpan_role_read,
+	.write		= lowpan_role_write,
+	.llseek		= default_llseek,
+};
+
 static int le_auto_conn_show(struct seq_file *sf, void *ptr)
 {
 	struct hci_dev *hdev = sf->private;
@@ -1826,6 +1877,8 @@ static int __hci_init(struct hci_dev *hdev)
 		debugfs_create_u16("discov_interleaved_timeout", 0644,
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
+		debugfs_create_file("6lowpan_role", 0644, hdev->debugfs, hdev,
+				    &lowpan_role_debugfs_fops);
 	}
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ca19fd4..8f54bf5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3984,6 +3984,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags))
 		set_bit(HCI_CONN_6LOWPAN, &conn->flags);
 
+	if (test_bit(HCI_6LOWPAN_ROLE_NODE, &hdev->dev_flags))
+		set_bit(HCI_CONN_6LOWPAN_ROLE_NODE, &conn->flags);
+
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
-- 
1.8.3.1

