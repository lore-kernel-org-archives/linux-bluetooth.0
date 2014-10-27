Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 2/4] Extract generic_start_discovery and generic_stop_discovery in preparation for start_service_discovery and stop_service_discovery.
Date: Mon, 27 Oct 2014 13:41:42 -0700
Message-Id: <1414442504-14290-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1414442504-14290-1-git-send-email-jpawlowski@google.com>
References: <1414442504-14290-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 net/bluetooth/mgmt.c | 102 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9c4daf7..f2b80b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3648,7 +3648,8 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
+static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status,
+				       int discovery_op)
 {
 	struct pending_cmd *cmd;
 	u8 type;
@@ -3656,7 +3657,7 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(discovery_op, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3669,7 +3670,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_start_discovery_complete(struct hci_dev *hdev, u8 status,
+					     int discovery_op)
 {
 	unsigned long timeout = 0;
 
@@ -3677,7 +3679,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
+		mgmt_start_discovery_failed(hdev, status, discovery_op);
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -3708,10 +3710,18 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
 }
 
-static int start_discovery(struct sock *sk, struct hci_dev *hdev,
-			   void *data, u16 len)
+static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_start_discovery_complete(hdev, status, MGMT_OP_START_DISCOVERY);
+}
+
+static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
+				   int discovery_op,
+			void (*complete_cb)(struct hci_dev *hdev, u8 status),
+				   u8 type,
+				   struct mgmt_uuid_filter *serv_filters,
+				   __le16 serv_filter_cnt)
 {
-	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
@@ -3727,30 +3737,30 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_status(sk, hdev->id, discovery_op,
 				 MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_status(sk, hdev->id, discovery_op,
 				 MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_status(sk, hdev->id, discovery_op,
 				 MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, discovery_op, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	hdev->discovery.type = cp->type;
+	hdev->discovery.type = type;
 
 	hci_req_init(&req, hdev);
 
@@ -3758,14 +3768,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_BREDR:
 		status = mgmt_bredr_support(hdev);
 		if (status) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+			err = cmd_status(sk, hdev->id, discovery_op,
 					 status);
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+			err = cmd_status(sk, hdev->id, discovery_op,
 					 MGMT_STATUS_BUSY);
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3783,7 +3793,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+			err = cmd_status(sk, hdev->id, discovery_op,
 					 status);
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3791,7 +3801,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+			err = cmd_status(sk, hdev->id, discovery_op,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3805,7 +3815,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
 				err = cmd_status(sk, hdev->id,
-						 MGMT_OP_START_DISCOVERY,
+						 discovery_op,
 						 MGMT_STATUS_REJECTED);
 				mgmt_pending_remove(cmd);
 				goto failed;
@@ -3829,7 +3839,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		 */
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+			err = cmd_status(sk, hdev->id, discovery_op,
 					 MGMT_STATUS_FAILED);
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3850,13 +3860,13 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	default:
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_status(sk, hdev->id, discovery_op,
 				 MGMT_STATUS_INVALID_PARAMS);
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
-	err = hci_req_run(&req, start_discovery_complete);
+	err = hci_req_run(&req, complete_cb);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
@@ -3867,12 +3877,22 @@ failed:
 	return err;
 }
 
-static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
+static int start_discovery(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	struct mgmt_cp_start_discovery *cp = data;
+
+	return generic_start_discovery(sk, hdev, MGMT_OP_START_DISCOVERY,
+		start_discovery_complete, cp->type, NULL, 0);
+}
+
+static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status,
+				      int discovery_op)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(discovery_op, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3883,14 +3903,15 @@ static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_stop_discovery_complete(struct hci_dev *hdev, u8 status,
+					    int discovery_op)
 {
 	BT_DBG("status %d", status);
 
 	hci_dev_lock(hdev);
 
 	if (status) {
-		mgmt_stop_discovery_failed(hdev, status);
+		mgmt_stop_discovery_failed(hdev, status, discovery_op);
 		goto unlock;
 	}
 
@@ -3900,10 +3921,15 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
-			  u16 len)
+static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_stop_discovery_complete(hdev, status, MGMT_OP_STOP_DISCOVERY);
+}
+
+static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
+				  __u8 type,
+			void (*stop_discovery_cb)(struct hci_dev *, u8))
 {
-	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
 	int err;
@@ -3914,15 +3940,14 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (!hci_discovery_active(hdev)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+				   MGMT_STATUS_REJECTED, &type, sizeof(type));
 		goto unlock;
 	}
 
-	if (hdev->discovery.type != mgmt_cp->type) {
+	if (hdev->discovery.type != type) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		goto unlock;
 	}
 
@@ -3936,7 +3961,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_stop_discovery(&req);
 
-	err = hci_req_run(&req, stop_discovery_complete);
+	err = hci_req_run(&req, stop_discovery_cb);
 	if (!err) {
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 		goto unlock;
@@ -3947,7 +3972,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* If no HCI commands were sent we're done */
 	if (err == -ENODATA) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
-				   &mgmt_cp->type, sizeof(mgmt_cp->type));
+				   &type, sizeof(type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
@@ -3956,6 +3981,15 @@ unlock:
 	return err;
 }
 
+static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 len)
+{
+	struct mgmt_cp_stop_discovery *mgmt_cp = data;
+
+	return generic_stop_discovery(sk, hdev, mgmt_cp->type,
+					stop_discovery_complete);
+}
+
 static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 len)
 {
-- 
2.1.0.rc2.206.gedb03e5

