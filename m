Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 35/49] Bluetooth: Add debugfs switch for forcing SMP over BR/EDR
Date: Wed,  3 Dec 2014 17:02:29 +0200
Message-Id: <1417618963-18010-36-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make it possible to use LE SC functionality over BR/EDR with pre-4.1
controllers (that do not support BR/EDR SC links) it's useful to be able
to force LE SC operations even over a traditional SSP protected link.
This patch adds a debugfs switch to force a special debug flag which is
used to skip the checks for BR/EDR SC support.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e56f9099f8e3..569c077778b6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -163,6 +163,7 @@ enum {
 enum {
 	HCI_DUT_MODE,
 	HCI_FORCE_SC,
+	HCI_FORCE_LESC,
 	HCI_FORCE_STATIC_ADDR,
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2fa9f2b2bee3..581e13e9dc32 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -406,6 +406,49 @@ static const struct file_operations force_sc_support_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_lesc_support_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_LESC, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_lesc_support_write(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_LESC, &hdev->dbg_flags);
+
+	return count;
+}
+
+static const struct file_operations force_lesc_support_fops = {
+	.open		= simple_open,
+	.read		= force_lesc_support_read,
+	.write		= force_lesc_support_write,
+	.llseek		= default_llseek,
+};
+
 static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 				 size_t count, loff_t *ppos)
 {
@@ -1817,6 +1860,10 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &force_sc_support_fops);
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
+		if (lmp_le_capable(hdev))
+			debugfs_create_file("force_lesc_support", 0644,
+					    hdev->debugfs, hdev,
+					    &force_lesc_support_fops);
 	}
 
 	if (lmp_sniff_capable(hdev)) {
-- 
2.1.0

