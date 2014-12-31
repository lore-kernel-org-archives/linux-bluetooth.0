Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Remove broken force_lesc_support debugfs option
Date: Wed, 31 Dec 2014 14:43:17 -0800
Message-Id: <1420065799-28781-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The force_lesc_support debugfs option never really worked. It has a race
condition between creating the debugfs entry and registering the L2CAP
fixed channel for BR/EDR SMP support.

Also this has been replaced with a working force_bredr_smp debugfs
switch that developers can use now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 -
 net/bluetooth/hci_debugfs.c | 49 ---------------------------------------------
 2 files changed, 50 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fddb93f168b8..884ba004237e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -173,7 +173,6 @@ enum {
 enum {
 	HCI_DUT_MODE,
 	HCI_FORCE_SC,
-	HCI_FORCE_LESC,
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 };
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index ee33ce88d3d8..dc8f994a957b 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -421,50 +421,6 @@ static const struct file_operations force_sc_support_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t force_lesc_support_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_FORCE_LESC, &hdev->dbg_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_lesc_support_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
-	bool enable;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
-
-	if (enable == test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
-		return -EALREADY;
-
-	change_bit(HCI_FORCE_LESC, &hdev->dbg_flags);
-
-	return count;
-}
-
-static const struct file_operations force_lesc_support_fops = {
-	.open		= simple_open,
-	.read		= force_lesc_support_read,
-	.write		= force_lesc_support_write,
-	.llseek		= default_llseek,
-};
-
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -568,11 +524,6 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 
 		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
 				    hdev, &force_sc_support_fops);
-
-		if (lmp_le_capable(hdev))
-			debugfs_create_file("force_lesc_support", 0644,
-					    hdev->debugfs, hdev,
-					    &force_lesc_support_fops);
 	}
 
 	if (lmp_sniff_capable(hdev)) {
-- 
2.1.0

