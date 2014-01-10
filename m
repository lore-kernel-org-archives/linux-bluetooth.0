Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 12/15] Bluetooth: Add debugfs quirk for forcing Secure Connections support
Date: Fri, 10 Jan 2014 02:07:27 -0800
Message-Id: <1389348450-23303-12-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth 4.1 specification with Secure Connections support has
just been released and controllers with this feature are still in
an early stage.

A handful of controllers have already support for it, but they do
not always identify this feature correctly. This debugfs entry
allows to tell the kernel that the controller can be treated as
it would fully support Secure Connections.

Using debugfs to force Secure Connections support of course does
not make this feature magically appear in all controllers. This
is a debug functionality for early adopters. Once the majority
of controllers matures this quirk will be removed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0253276e88e4..2bc19881e250 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -117,6 +117,7 @@ enum {
 	HCI_SERVICE_CACHE,
 	HCI_DEBUG_KEYS,
 	HCI_DUT_MODE,
+	HCI_FORCE_SC,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3b619a448b5..946631ffe802 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -415,6 +415,52 @@ static int ssp_debug_mode_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(ssp_debug_mode_fops, ssp_debug_mode_get,
 			ssp_debug_mode_set, "%llu\n");
 
+static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_sc_support_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+
+	if (test_bit(HCI_UP, &hdev->flags))
+		return -EBUSY;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_SC, &hdev->dev_flags))
+		return -EALREADY;
+
+	change_bit(HCI_FORCE_SC, &hdev->dev_flags);
+
+	return count;
+}
+
+static const struct file_operations force_sc_support_fops = {
+	.open		= simple_open,
+	.read		= force_sc_support_read,
+	.write		= force_sc_support_write,
+	.llseek		= default_llseek,
+};
+
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1365,7 +1411,8 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
 
 	/* Enable Secure Connections if supported and configured */
-	if (lmp_sc_capable(hdev) &&
+	if ((lmp_sc_capable(hdev) ||
+	     test_bit(HCI_FORCE_SC, &hdev->dev_flags)) &&
 	    test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
 		u8 support = 0x01;
 		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
@@ -1442,6 +1489,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &auto_accept_delay_fops);
 		debugfs_create_file("ssp_debug_mode", 0644, hdev->debugfs,
 				    hdev, &ssp_debug_mode_fops);
+		debugfs_create_file("force_sc_support", 0644, hdev->debugfs,
+				    hdev, &force_sc_support_fops);
 	}
 
 	if (lmp_sniff_capable(hdev)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7d4ae679ab7..bbe30c983492 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -378,7 +378,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_HS;
 		}
 
-		if (lmp_sc_capable(hdev))
+		if (lmp_sc_capable(hdev) ||
+		    test_bit(HCI_FORCE_SC, &hdev->dev_flags))
 			settings |= MGMT_SETTING_SECURE_CONN;
 	}
 
@@ -4026,7 +4027,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  status);
 
-	if (!lmp_sc_capable(hdev))
+	if (!lmp_sc_capable(hdev) &&
+	    !test_bit(HCI_FORCE_SC, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-- 
1.8.4.2

