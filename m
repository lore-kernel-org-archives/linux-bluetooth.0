Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Merge hdev->dbg_flags fields into hdev->dev_flags
Date: Fri, 13 Mar 2015 10:20:35 -0700
Message-Id: <1426267235-30299-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the extension of hdev->dev_flags utilizing a bitmap now, the space
is no longer restricted. Merge the hdev->dbg_flags into hdev->dev_flags
to save space on 64-bit architectures. On 32-bit architectures no size
reduction happens.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      | 14 +++++---------
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  8 ++++----
 net/bluetooth/hci_debugfs.c      |  6 +++---
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/mgmt.c             |  2 +-
 net/bluetooth/smp.c              | 10 +++++-----
 8 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7a0272a6f0ba..d942fedbaedd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -179,15 +179,6 @@ enum {
 	HCI_RESET,
 };
 
-/* BR/EDR and/or LE controller flags: the flags defined here should represent
- * states configured via debugfs for debugging and testing purposes only.
- */
-enum {
-	HCI_DUT_MODE,
-	HCI_FORCE_BREDR_SMP,
-	HCI_FORCE_STATIC_ADDR,
-};
-
 /*
  * BR/EDR and/or LE controller flags: the flags defined here should represent
  * states from the controller.
@@ -226,6 +217,11 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
+
+	HCI_DUT_MODE,
+	HCI_FORCE_BREDR_SMP,
+	HCI_FORCE_STATIC_ADDR,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 889a489d913f..6afbf5b014a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -353,7 +353,6 @@ struct hci_dev {
 
 	struct rfkill		*rfkill;
 
-	unsigned long		dbg_flags;
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 
 	struct delayed_work	le_scan_disable;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 23a43ca98785..750d3445f2d2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -80,7 +80,7 @@ static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_DUT_MODE, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -106,7 +106,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_DUT_MODE, &hdev->dbg_flags))
+	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
 		return -EALREADY;
 
 	hci_req_lock(hdev);
@@ -127,7 +127,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (err < 0)
 		return err;
 
-	change_bit(HCI_DUT_MODE, &hdev->dbg_flags);
+	hci_dev_change_flag(hdev, HCI_DUT_MODE);
 
 	return count;
 }
@@ -3019,7 +3019,7 @@ static void le_scan_restart_work(struct work_struct *work)
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type)
 {
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
 	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 3c025ee5572c..bc801e9db834 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -679,7 +679,7 @@ static ssize_t force_static_address_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -704,10 +704,10 @@ static ssize_t force_static_address_write(struct file *file,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags))
+	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR))
 		return -EALREADY;
 
-	change_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags);
+	hci_dev_change_flag(hdev, HCI_FORCE_STATIC_ADDR);
 
 	return count;
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e85f9ec9f73a..55e096d20a0f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -383,7 +383,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * and a static address has been configured, then use that
 	 * address instead of the public BR/EDR address.
 	 */
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
 	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index af30d8240c80..d69861c89bb5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6992,7 +6992,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	if (hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED) &&
 	    (bredr_sc_enabled(hcon->hdev) ||
-	     test_bit(HCI_FORCE_BREDR_SMP, &hcon->hdev->dbg_flags)))
+	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
 	mutex_init(&conn->ident_lock);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d97719d04be0..c58908652519 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -659,7 +659,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	 * with BR/EDR disabled, the existence of the static address will
 	 * be evaluated.
 	 */
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
 	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) ||
 	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
 		if (bacmp(&hdev->static_addr, BDADDR_ANY))
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 81975f274c2b..9155840068cf 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1679,7 +1679,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->type == ACL_LINK) {
 		/* We must have a BR/EDR SC link */
 		if (!test_bit(HCI_CONN_AES_CCM, &conn->hcon->flags) &&
-		    !test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
+		    !hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 			return SMP_CROSS_TRANSP_NOT_ALLOWED;
 
 		set_bit(SMP_FLAG_SC, &smp->flags);
@@ -2749,7 +2749,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	/* BR/EDR must use Secure Connections for SMP */
 	if (!test_bit(HCI_CONN_AES_CCM, &hcon->flags) &&
-	    !test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
+	    !hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return;
 
 	/* If our LE support is not enabled don't do anything */
@@ -3003,7 +3003,7 @@ static ssize_t force_bredr_smp_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y': 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -3025,7 +3025,7 @@ static ssize_t force_bredr_smp_write(struct file *file,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
-	if (enable == test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
+	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
 	if (enable) {
@@ -3044,7 +3044,7 @@ static ssize_t force_bredr_smp_write(struct file *file,
 		smp_del_chan(chan);
 	}
 
-	change_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags);
+	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
 
 	return count;
 }
-- 
2.1.0

