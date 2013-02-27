Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 11/16] Bluetooth: Update mgmt powered HCI commands to use transactions
Date: Wed, 27 Feb 2013 09:57:19 +0200
Message-Id: <1361951844-13719-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates sending of HCI commands related to mgmt_set_powered
(e.g. class, name and EIR data) to be sent using transactions. This is
necessary since it's the only (well, at least the cleanest) way to keep
the power on procedure synchronized and let user space know it has
completed only when all HCI commands are completed (this actual fix is
coming in a subsequent patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  147 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 48 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 025f6f0..e76581d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -591,8 +591,9 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 }
 
-static int update_eir(struct hci_dev *hdev)
+static int update_eir(struct hci_transaction *transaction)
 {
+	struct hci_dev *hdev = transaction->hdev;
 	struct hci_cp_write_eir cp;
 
 	if (!hdev_is_powered(hdev))
@@ -616,7 +617,8 @@ static int update_eir(struct hci_dev *hdev)
 
 	memcpy(hdev->eir, cp.data, sizeof(cp.data));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+	return hci_transaction_cmd(transaction, HCI_OP_WRITE_EIR,
+				   sizeof(cp), &cp);
 }
 
 static u8 get_service_classes(struct hci_dev *hdev)
@@ -630,8 +632,9 @@ static u8 get_service_classes(struct hci_dev *hdev)
 	return val;
 }
 
-static int update_class(struct hci_dev *hdev)
+static int update_class(struct hci_transaction *transaction)
 {
+	struct hci_dev *hdev = transaction->hdev;
 	u8 cod[3];
 	int err;
 
@@ -650,7 +653,8 @@ static int update_class(struct hci_dev *hdev)
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return 0;
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+	err = hci_transaction_cmd(transaction, HCI_OP_WRITE_CLASS_OF_DEV,
+				  sizeof(cod), cod);
 	if (err == 0)
 		set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
 
@@ -661,16 +665,21 @@ static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    service_cache.work);
+	struct hci_transaction transaction;
 
 	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
+	hci_transaction_init(&transaction, hdev, NULL);
+
 	hci_dev_lock(hdev);
 
-	update_eir(hdev);
-	update_class(hdev);
+	update_eir(&transaction);
+	update_class(&transaction);
 
 	hci_dev_unlock(hdev);
+
+	hci_transaction_run(&transaction);
 }
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
@@ -1354,6 +1363,7 @@ static u8 get_uuid_size(const u8 *uuid)
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
+	struct hci_transaction transaction;
 	struct pending_cmd *cmd;
 	struct bt_uuid *uuid;
 	int err;
@@ -1380,13 +1390,12 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-	err = update_class(hdev);
-	if (err < 0)
-		goto failed;
+	hci_transaction_init(&transaction, hdev, NULL);
 
-	err = update_eir(hdev);
-	if (err < 0)
-		goto failed;
+	update_class(&transaction);
+	update_eir(&transaction);
+
+	hci_transaction_run(&transaction);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
@@ -1395,8 +1404,12 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_UUID, hdev, data, len);
-	if (!cmd)
+	if (!cmd) {
 		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1421,6 +1434,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
+	struct hci_transaction transaction;
 	struct pending_cmd *cmd;
 	struct bt_uuid *match, *tmp;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
@@ -1466,13 +1480,12 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 update_class:
-	err = update_class(hdev);
-	if (err < 0)
-		goto unlock;
+	hci_transaction_init(&transaction, hdev, NULL);
 
-	err = update_eir(hdev);
-	if (err < 0)
-		goto unlock;
+	update_class(&transaction);
+	update_eir(&transaction);
+
+	hci_transaction_run(&transaction);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
@@ -1481,8 +1494,12 @@ update_class:
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
-	if (!cmd)
+	if (!cmd) {
 		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = 0;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1493,6 +1510,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_dev_class *cp = data;
+	struct hci_transaction transaction;
 	struct pending_cmd *cmd;
 	int err;
 
@@ -1521,16 +1539,18 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	hci_transaction_init(&transaction, hdev, NULL);
+
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
-		update_eir(hdev);
+		update_eir(&transaction);
 	}
 
-	err = update_class(hdev);
-	if (err < 0)
-		goto unlock;
+	update_class(&transaction);
+
+	hci_transaction_run(&transaction);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
@@ -1539,8 +1559,12 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
-	if (!cmd)
+	if (!cmd) {
 		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = 0;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -2268,19 +2292,21 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static int update_name(struct hci_dev *hdev, const char *name)
+static void update_name(struct hci_transaction *transaction, const char *name)
 {
 	struct hci_cp_write_local_name cp;
 
 	memcpy(cp.name, name, sizeof(cp.name));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
+	hci_transaction_cmd(transaction, HCI_OP_WRITE_LOCAL_NAME,
+			    sizeof(cp), &cp);
 }
 
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
 	struct mgmt_cp_set_local_name *cp = data;
+	struct hci_transaction transaction;
 	struct pending_cmd *cmd;
 	int err;
 
@@ -2310,7 +2336,9 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	err = update_name(hdev, cp->name);
+	hci_transaction_init(&transaction, hdev, NULL);
+	update_name(&transaction, cp->name);
+	err = hci_transaction_run(&transaction);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2698,6 +2726,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_device_id *cp = data;
+	struct hci_transaction transaction;
 	int err;
 	__u16 source;
 
@@ -2718,7 +2747,9 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0, NULL, 0);
 
-	update_eir(hdev);
+	hci_transaction_init(&transaction, hdev, NULL);
+	update_eir(&transaction);
+	hci_transaction_run(&transaction);
 
 	hci_dev_unlock(hdev);
 
@@ -3043,8 +3074,9 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
-static int set_bredr_scan(struct hci_dev *hdev)
+static int set_bredr_scan(struct hci_transaction *transaction)
 {
+	struct hci_dev *hdev = transaction->hdev;
 	u8 scan = 0;
 
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
@@ -3055,18 +3087,23 @@ static int set_bredr_scan(struct hci_dev *hdev)
 	if (!scan)
 		return 0;
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	return hci_transaction_cmd(transaction, HCI_OP_WRITE_SCAN_ENABLE,
+				   1, &scan);
 }
 
 static int powered_update_hci(struct hci_dev *hdev)
 {
+	struct hci_transaction transaction;
 	u8 link_sec;
 
+	hci_transaction_init(&transaction, hdev, NULL);
+
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
-	    !lmp_host_ssp_capable(hdev)) {
+			!lmp_host_ssp_capable(hdev)) {
 		u8 ssp = 1;
 
-		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
+		hci_transaction_cmd(&transaction, HCI_OP_WRITE_SSP_MODE,
+				    1, &ssp);
 	}
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
@@ -3079,22 +3116,25 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 * host state (host features set)
 		 */
 		if (cp.le != lmp_host_le_capable(hdev) ||
-		    cp.simul != lmp_host_le_br_capable(hdev))
-			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
-				     sizeof(cp), &cp);
+				cp.simul != lmp_host_le_br_capable(hdev))
+			hci_transaction_cmd(&transaction,
+					    HCI_OP_WRITE_LE_HOST_SUPPORTED,
+					    sizeof(cp), &cp);
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
 	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
-		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
-			     sizeof(link_sec), &link_sec);
+		hci_transaction_cmd(&transaction, HCI_OP_WRITE_AUTH_ENABLE,
+				    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		set_bredr_scan(hdev);
-		update_class(hdev);
-		update_name(hdev, hdev->dev_name);
-		update_eir(hdev);
+		set_bredr_scan(&transaction);
+		update_class(&transaction);
+		update_name(&transaction, hdev->dev_name);
+		update_eir(&transaction);
 	}
+
+	return hci_transaction_run(&transaction);
 }
 
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
@@ -3559,8 +3599,9 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static int clear_eir(struct hci_dev *hdev)
+static int clear_eir(struct hci_transaction *transaction)
 {
+	struct hci_dev *hdev = transaction->hdev;
 	struct hci_cp_write_eir cp;
 
 	if (!lmp_ext_inq_capable(hdev))
@@ -3570,12 +3611,14 @@ static int clear_eir(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+	return hci_transaction_cmd(transaction, HCI_OP_WRITE_EIR,
+				   sizeof(cp), &cp);
 }
 
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	struct hci_transaction transaction;
 	bool changed = false;
 	int err = 0;
 
@@ -3608,10 +3651,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (match.sk)
 		sock_put(match.sk);
 
+	hci_transaction_init(&transaction, hdev, NULL);
+
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-		update_eir(hdev);
+		update_eir(&transaction);
 	else
-		clear_eir(hdev);
+		clear_eir(&transaction);
+
+	hci_transaction_run(&transaction);
 
 	return err;
 }
@@ -3699,8 +3746,12 @@ send_event:
 	 * adapter so only update them here if this is a name change
 	 * unrelated to power on.
 	 */
-	if (!test_bit(HCI_INIT, &hdev->flags))
-		update_eir(hdev);
+	if (!test_bit(HCI_INIT, &hdev->flags)) {
+		struct hci_transaction transaction;
+		hci_transaction_init(&transaction, hdev, NULL);
+		update_eir(&transaction);
+		hci_transaction_run(&transaction);
+	}
 
 failed:
 	if (cmd)
-- 
1.7.10.4

