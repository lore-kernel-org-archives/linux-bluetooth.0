Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Remove no longer needed force_sc_support debugfs option
Date: Wed, 31 Dec 2014 14:43:18 -0800
Message-Id: <1420065799-28781-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The force_sc_support debugfs option was introduced to easily work with
pre-production Bluetooth 4.1 silicon. This option is no longer needed
since controllers supporting BR/EDR Secure Connections feature are now
available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 -
 include/net/bluetooth/hci_core.h |  3 +--
 net/bluetooth/hci_debugfs.c      | 49 ----------------------------------------
 net/bluetooth/mgmt.c             | 11 ++++-----
 4 files changed, 5 insertions(+), 59 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 884ba004237e..aee16bf5d34f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -172,7 +172,6 @@ enum {
  */
 enum {
 	HCI_DUT_MODE,
-	HCI_FORCE_SC,
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 };
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3e7e5110f298..89f4e3c8a097 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1017,8 +1017,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
 				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-#define bredr_sc_enabled(dev) ((lmp_sc_capable(dev) || \
-				test_bit(HCI_FORCE_SC, &(dev)->dbg_flags)) && \
+#define bredr_sc_enabled(dev) (lmp_sc_capable(dev) && \
 			       test_bit(HCI_SC_ENABLED, &(dev)->dev_flags))
 
 /* ----- HCI protocols ----- */
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index dc8f994a957b..d72ebc2b11fa 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -375,52 +375,6 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dbg_flags) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_sc_support_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf)-1));
-	bool enable;
-
-	if (test_bit(HCI_UP, &hdev->flags))
-		return -EBUSY;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
-		return -EINVAL;
-
-	if (enable == test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
-		return -EALREADY;
-
-	change_bit(HCI_FORCE_SC, &hdev->dbg_flags);
-
-	return count;
-}
-
-static const struct file_operations force_sc_support_fops = {
-	.open		= simple_open,
-	.read		= force_sc_support_read,
-	.write		= force_sc_support_write,
-	.llseek		= default_llseek,
-};
-
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -521,9 +475,6 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 				    hdev, &auto_accept_delay_fops);
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
-
-		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
-				    hdev, &force_sc_support_fops);
 	}
 
 	if (lmp_sniff_capable(hdev)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3d2f7ad1e655..6b3f5537e441 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -570,8 +570,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_HS;
 		}
 
-		if (lmp_sc_capable(hdev) ||
-		    test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
+		if (lmp_sc_capable(hdev))
 			settings |= MGMT_SETTING_SECURE_CONN;
 	}
 
@@ -4727,8 +4726,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
-	    !lmp_sc_capable(hdev) && !test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
+	if (!lmp_sc_capable(hdev) &&
+	    !test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -4738,9 +4737,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev) ||
-	    (!lmp_sc_capable(hdev) &&
-	     !test_bit(HCI_FORCE_SC, &hdev->dbg_flags)) ||
+	if (!hdev_is_powered(hdev) || !lmp_sc_capable(hdev) ||
 	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		bool changed;
 
-- 
2.1.0

