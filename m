Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Update mgmt powered HCI commands to use async requests
Date: Wed,  6 Mar 2013 09:16:28 +0200
Message-Id: <1362554191-21753-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
References: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates sending of HCI commands related to mgmt_set_powered
(e.g. class, name and EIR data) to be sent using asynchronous requests.
This is necessary since it's the only (well, at least the cleanest) way
to keep the power on procedure synchronized and let user space know it
has completed only when all HCI commands are completed (this actual fix
is coming in a subsequent patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  136 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d58b44..dd62700 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -591,8 +591,9 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 }
 
-static int update_eir(struct hci_dev *hdev)
+static int update_eir(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_eir cp;
 
 	if (!hdev_is_powered(hdev))
@@ -616,7 +617,7 @@ static int update_eir(struct hci_dev *hdev)
 
 	memcpy(hdev->eir, cp.data, sizeof(cp.data));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+	return hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
 static u8 get_service_classes(struct hci_dev *hdev)
@@ -630,8 +631,9 @@ static u8 get_service_classes(struct hci_dev *hdev)
 	return val;
 }
 
-static int update_class(struct hci_dev *hdev)
+static int update_class(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	u8 cod[3];
 	int err;
 
@@ -650,7 +652,7 @@ static int update_class(struct hci_dev *hdev)
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return 0;
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+	err = hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 	if (err == 0)
 		set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
 
@@ -661,16 +663,21 @@ static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    service_cache.work);
+	struct hci_request req;
 
 	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
+	hci_req_init(&req, hdev);
+
 	hci_dev_lock(hdev);
 
-	update_eir(hdev);
-	update_class(hdev);
+	update_eir(&req);
+	update_class(&req);
 
 	hci_dev_unlock(hdev);
+
+	hci_req_run(&req, NULL);
 }
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
@@ -1355,6 +1362,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	struct bt_uuid *uuid;
 	int err;
 
@@ -1380,13 +1388,12 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-	err = update_class(hdev);
-	if (err < 0)
-		goto failed;
+	hci_req_init(&req, hdev);
 
-	err = update_eir(hdev);
-	if (err < 0)
-		goto failed;
+	update_class(&req);
+	update_eir(&req);
+
+	hci_req_run(&req, NULL);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
@@ -1395,8 +1402,12 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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
@@ -1424,6 +1435,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct pending_cmd *cmd;
 	struct bt_uuid *match, *tmp;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	struct hci_request req;
 	int err, found;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1466,13 +1478,12 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 update_class:
-	err = update_class(hdev);
-	if (err < 0)
-		goto unlock;
+	hci_req_init(&req, hdev);
 
-	err = update_eir(hdev);
-	if (err < 0)
-		goto unlock;
+	update_class(&req);
+	update_eir(&req);
+
+	hci_req_run(&req, NULL);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
@@ -1481,8 +1492,12 @@ update_class:
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
@@ -1494,6 +1509,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_dev_class *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
@@ -1521,16 +1537,18 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	hci_req_init(&req, hdev);
+
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
-		update_eir(hdev);
+		update_eir(&req);
 	}
 
-	err = update_class(hdev);
-	if (err < 0)
-		goto unlock;
+	update_class(&req);
+
+	hci_req_run(&req, NULL);
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
@@ -1539,8 +1557,12 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
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
@@ -2268,13 +2290,13 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static int update_name(struct hci_dev *hdev, const char *name)
+static void update_name(struct hci_request *req, const char *name)
 {
 	struct hci_cp_write_local_name cp;
 
 	memcpy(cp.name, name, sizeof(cp.name));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -2282,6 +2304,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_local_name *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 
 	BT_DBG("");
@@ -2310,7 +2333,9 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	err = update_name(hdev, cp->name);
+	hci_req_init(&req, hdev);
+	update_name(&req, cp->name);
+	err = hci_req_run(&req, NULL);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2698,6 +2723,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_device_id *cp = data;
+	struct hci_request req;
 	int err;
 	__u16 source;
 
@@ -2718,7 +2744,9 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0, NULL, 0);
 
-	update_eir(hdev);
+	hci_req_init(&req, hdev);
+	update_eir(&req);
+	hci_req_run(&req, NULL);
 
 	hci_dev_unlock(hdev);
 
@@ -3043,8 +3071,9 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
-static int set_bredr_scan(struct hci_dev *hdev)
+static int set_bredr_scan(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	u8 scan = 0;
 
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
@@ -3055,18 +3084,21 @@ static int set_bredr_scan(struct hci_dev *hdev)
 	if (!scan)
 		return 0;
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	return hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
 static int powered_update_hci(struct hci_dev *hdev)
 {
+	struct hci_request req;
 	u8 link_sec;
 
+	hci_req_init(&req, hdev);
+
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 	    !lmp_host_ssp_capable(hdev)) {
 		u8 ssp = 1;
 
-		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
+		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
 	}
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
@@ -3080,23 +3112,23 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 */
 		if (cp.le != lmp_host_le_capable(hdev) ||
 		    cp.simul != lmp_host_le_br_capable(hdev))
-			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
-				     sizeof(cp), &cp);
+			hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+				    sizeof(cp), &cp);
 	}
 
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
 	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
-		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
-			     sizeof(link_sec), &link_sec);
+		hci_req_add(&req, HCI_OP_WRITE_AUTH_ENABLE,
+			    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		set_bredr_scan(hdev);
-		update_class(hdev);
-		update_name(hdev, hdev->dev_name);
-		update_eir(hdev);
+		set_bredr_scan(&req);
+		update_class(&req);
+		update_name(&req, hdev->dev_name);
+		update_eir(&req);
 	}
 
-	return 0;
+	return hci_req_run(&req, NULL);
 }
 
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
@@ -3561,8 +3593,9 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static int clear_eir(struct hci_dev *hdev)
+static int clear_eir(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_eir cp;
 
 	if (!lmp_ext_inq_capable(hdev))
@@ -3572,12 +3605,13 @@ static int clear_eir(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+	return hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	struct hci_request req;
 	bool changed = false;
 	int err = 0;
 
@@ -3610,10 +3644,14 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (match.sk)
 		sock_put(match.sk);
 
+	hci_req_init(&req, hdev);
+
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-		update_eir(hdev);
+		update_eir(&req);
 	else
-		clear_eir(hdev);
+		clear_eir(&req);
+
+	hci_req_run(&req, NULL);
 
 	return err;
 }
@@ -3701,8 +3739,12 @@ send_event:
 	 * adapter so only update them here if this is a name change
 	 * unrelated to power on.
 	 */
-	if (!test_bit(HCI_INIT, &hdev->flags))
-		update_eir(hdev);
+	if (!test_bit(HCI_INIT, &hdev->flags)) {
+		struct hci_request req;
+		hci_req_init(&req, hdev);
+		update_eir(&req);
+		hci_req_run(&req, NULL);
+	}
 
 failed:
 	if (cmd)
-- 
1.7.10.4

