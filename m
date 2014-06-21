Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use separate dbg_flags to special debugfs options
Date: Sat, 21 Jun 2014 04:53:17 +0200
Message-Id: <1403319197-5145-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All the special settings configured via debugfs are either developer
only options or temporary solutions. To not clutter the standard flags,
move them to their own dbg_flags entry.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      | 12 +++++++++---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 24 ++++++++++++------------
 net/bluetooth/mgmt.c             |  4 ++--
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe584d78008d..3e12e27afca1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -104,6 +104,15 @@ enum {
 	HCI_RESET,
 };
 
+/* BR/EDR and/or LE controller flags: the flags defined here should represent
+ * states configured via debugfs for debugging and testing purposes only.
+ */
+enum {
+	HCI_DUT_MODE,
+	HCI_FORCE_SC,
+	HCI_FORCE_STATIC_ADDR,
+};
+
 /*
  * BR/EDR and/or LE controller flags: the flags defined here should represent
  * states from the controller.
@@ -116,9 +125,6 @@ enum {
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
 	HCI_DEBUG_KEYS,
-	HCI_DUT_MODE,
-	HCI_FORCE_SC,
-	HCI_FORCE_STATIC_ADDR,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index de3bb22e83f9..bf41e992a618 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -318,6 +318,7 @@ struct hci_dev {
 
 	struct rfkill		*rfkill;
 
+	unsigned long		dbg_flags;
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c3d184fd24de..ddbb084250be 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -68,7 +68,7 @@ static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_DUT_MODE, &hdev->dev_flags) ? 'Y': 'N';
+	buf[0] = test_bit(HCI_DUT_MODE, &hdev->dbg_flags) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -94,7 +94,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_DUT_MODE, &hdev->dev_flags))
+	if (enable == test_bit(HCI_DUT_MODE, &hdev->dbg_flags))
 		return -EALREADY;
 
 	hci_req_lock(hdev);
@@ -115,7 +115,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (err < 0)
 		return err;
 
-	change_bit(HCI_DUT_MODE, &hdev->dev_flags);
+	change_bit(HCI_DUT_MODE, &hdev->dbg_flags);
 
 	return count;
 }
@@ -407,7 +407,7 @@ static ssize_t force_sc_support_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dev_flags) ? 'Y': 'N';
+	buf[0] = test_bit(HCI_FORCE_SC, &hdev->dbg_flags) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -432,10 +432,10 @@ static ssize_t force_sc_support_write(struct file *file,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_FORCE_SC, &hdev->dev_flags))
+	if (enable == test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
 		return -EALREADY;
 
-	change_bit(HCI_FORCE_SC, &hdev->dev_flags);
+	change_bit(HCI_FORCE_SC, &hdev->dbg_flags);
 
 	return count;
 }
@@ -719,7 +719,7 @@ static ssize_t force_static_address_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ? 'Y': 'N';
+	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -744,10 +744,10 @@ static ssize_t force_static_address_write(struct file *file,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags))
+	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags))
 		return -EALREADY;
 
-	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags);
+	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags);
 
 	return count;
 }
@@ -1752,7 +1752,7 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 
 	/* Enable Secure Connections if supported and configured */
 	if ((lmp_sc_capable(hdev) ||
-	     test_bit(HCI_FORCE_SC, &hdev->dev_flags)) &&
+	     test_bit(HCI_FORCE_SC, &hdev->dbg_flags)) &&
 	    test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
 		u8 support = 0x01;
 		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
@@ -3782,7 +3782,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * the HCI command if the current random address is already the
 	 * static one.
 	 */
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 		if (bacmp(&hdev->static_addr, &hdev->random_addr))
@@ -3811,7 +3811,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type)
 {
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
 		bacpy(bdaddr, &hdev->static_addr);
 		*bdaddr_type = ADDR_LE_DEV_RANDOM;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5bf032d9bce1..e1651c3fc676 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -387,7 +387,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		}
 
 		if (lmp_sc_capable(hdev) ||
-		    test_bit(HCI_FORCE_SC, &hdev->dev_flags))
+		    test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
 			settings |= MGMT_SETTING_SECURE_CONN;
 	}
 
@@ -4261,7 +4261,7 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 				  status);
 
 	if (!lmp_sc_capable(hdev) &&
-	    !test_bit(HCI_FORCE_SC, &hdev->dev_flags))
+	    !test_bit(HCI_FORCE_SC, &hdev->dbg_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-- 
1.9.3

