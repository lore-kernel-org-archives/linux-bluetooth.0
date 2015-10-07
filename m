Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add debugfs entry for setting vendor diagnostic mode
Date: Wed,  7 Oct 2015 19:52:35 +0200
Message-Id: <1444240355-38859-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a new debugfs entry for enabling and disabling the vendor
diagnostic mode. It is only exposed for drivers that provide the
set_diag driver callback and actually have an option for vendor
specific diagnostic information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 63 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cf75c4391945..a26ff28ca878 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -240,6 +240,7 @@ enum {
 	HCI_LE_SCAN_INTERRUPTED,
 
 	HCI_DUT_MODE,
+	HCI_VENDOR_DIAG,
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d473b67a2c65..f28470e59682 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -398,6 +398,7 @@ struct hci_dev {
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
+	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8193845a9b60..e75bc545b48e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -134,6 +134,56 @@ static const struct file_operations dut_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+	int err;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	hci_req_lock(hdev);
+	err = hdev->set_diag(hdev, enable);
+	hci_req_unlock(hdev);
+
+	if (err < 0)
+		return err;
+
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
+	else
+		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
+
+	return count;
+}
+
+static const struct file_operations vendor_diag_fops = {
+	.open		= simple_open,
+	.read		= vendor_diag_read,
+	.write		= vendor_diag_write,
+	.llseek		= default_llseek,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
@@ -850,12 +900,19 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* The Device Under Test (DUT) mode is special and available for
-	 * all controller types. So just create it early on.
-	 */
 	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+		/* The Device Under Test (DUT) mode is special and available
+		 * for all controller types. So just create it early on.
+		 */
 		debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
 				    &dut_mode_fops);
+
+		/* When the driver supports the set_diag callback, then
+		 * expose an entry to modify the vendor diagnostic setting.
+		 */
+		if (hdev->set_diag)
+			debugfs_create_file("vendor_diag", 0644, hdev->debugfs,
+					    hdev, &vendor_diag_fops);
 	}
 
 	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
-- 
2.4.3

