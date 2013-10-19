Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Add support for setting DUT mode
Date: Sat, 19 Oct 2013 07:09:12 -0700
Message-Id: <1382191753-59287-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Device Under Test (DUT) mode is useful for doing certification
testing and so expose this as debugfs option.

This mode is actually special since you can only enter it. Restoring
normal operation means that a HCI Reset is required. The current mode
value gets tracked as a new device flag and when disabling it, the
correct command to reset the controller is sent.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  3 ++
 net/bluetooth/hci_core.c    | 73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ac9c4a7..1784c48 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -115,6 +115,7 @@ enum {
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
 	HCI_DEBUG_KEYS,
+	HCI_DUT_MODE,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
@@ -1043,6 +1044,8 @@ struct hci_rp_write_remote_amp_assoc {
 	__u8     phy_handle;
 } __packed;
 
+#define HCI_OP_ENABLE_DUT_MODE		0x1803
+
 #define HCI_OP_WRITE_SSP_DEBUG_MODE	0x1804
 
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2a9e925..4a5e567 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,6 +58,71 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI debugfs entries ---- */
 
+static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_DUT_MODE, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct sk_buff *skb;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+	int err;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_DUT_MODE, &hdev->dev_flags))
+		return -EALREADY;
+
+	hci_req_lock(hdev);
+	if (enable)
+		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	else
+		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	hci_req_unlock(hdev);
+
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	err = -bt_to_errno(skb->data[0]);
+	kfree_skb(skb);
+
+	if (err < 0)
+		return err;
+
+	change_bit(HCI_DUT_MODE, &hdev->dev_flags);
+
+	return count;
+}
+
+static const struct file_operations dut_mode_fops = {
+	.open		= simple_open,
+	.read		= dut_mode_read,
+	.write		= dut_mode_write,
+	.llseek		= default_llseek,
+};
+
 static int features_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1200,6 +1265,14 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	/* The Device Under Test (DUT) mode is special and available for
+	 * all controller types. So just create it early on.
+	 */
+	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
+				    &dut_mode_fops);
+	}
+
 	/* HCI_BREDR covers both single-mode LE, BR/EDR and dual-mode
 	 * BR/EDR/LE type controllers. AMP controllers only need the
 	 * first stage init.
-- 
1.8.3.1

