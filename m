Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v9 2/3] Bluetooth: Extract generic start and stop discovery
Date: Sat, 22 Nov 2014 23:49:52 -0800
Message-Id: <1416728993-4189-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
References: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit extract generic_start_discovery and generic_stop_discovery
in preparation for start and stop service discovery. The reason behind
that is that both functions will share big part of code, and it would
be much easier to maintain just one generic method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 89 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbeef5f..2687fc2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3675,7 +3675,8 @@ done:
 	return err;
 }
 
-static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
+static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status,
+				       u16 opcode)
 {
 	struct pending_cmd *cmd;
 	u8 type;
@@ -3683,7 +3684,7 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3696,7 +3697,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_start_discovery_complete(struct hci_dev *hdev, u8 status,
+					     u16 opcode)
 {
 	unsigned long timeout = 0;
 
@@ -3704,7 +3706,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
+		mgmt_start_discovery_failed(hdev, status, opcode);
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -3735,8 +3737,13 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
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
+				   void *data, u16 len, u16 opcode)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
@@ -3754,27 +3761,27 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_NOT_POWERED,
 				   &cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
 	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_BUSY, &cp->type,
 				   sizeof(cp->type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_BUSY, &cp->type,
 				   sizeof(cp->type));
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -3788,16 +3795,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_BREDR:
 		status = mgmt_bredr_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
+			err = cmd_complete(sk, hdev->id, opcode, status,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
+			err = cmd_complete(sk, hdev->id, opcode,
 					   MGMT_STATUS_BUSY, &cp->type,
 					   sizeof(cp->type));
 			mgmt_pending_remove(cmd);
@@ -3816,8 +3821,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
+			err = cmd_complete(sk, hdev->id, opcode, status,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3825,8 +3829,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
+			err = cmd_complete(sk, hdev->id, opcode,
 					   MGMT_STATUS_NOT_SUPPORTED,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
@@ -3840,8 +3843,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			 */
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_START_DISCOVERY,
+				err = cmd_complete(sk, hdev->id, opcode,
 						   MGMT_STATUS_REJECTED,
 						   &cp->type,
 						   sizeof(cp->type));
@@ -3867,8 +3869,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		 */
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
+			err = cmd_complete(sk, hdev->id, opcode,
 					   MGMT_STATUS_FAILED,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
@@ -3890,7 +3891,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	default:
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_INVALID_PARAMS,
 				   &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
@@ -3908,12 +3909,20 @@ failed:
 	return err;
 }
 
-static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
+static int start_discovery(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	return generic_start_discovery(sk, hdev, data, len,
+				       MGMT_OP_START_DISCOVERY);
+}
+
+static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status,
+				      u16 opcode)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3924,14 +3933,15 @@ static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_stop_discovery_complete(struct hci_dev *hdev, u8 status,
+					    u16 opcode)
 {
 	BT_DBG("status %d", status);
 
 	hci_dev_lock(hdev);
 
 	if (status) {
-		mgmt_stop_discovery_failed(hdev, status);
+		mgmt_stop_discovery_failed(hdev, status, opcode);
 		goto unlock;
 	}
 
@@ -3941,8 +3951,13 @@ unlock:
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
+				  void *data, u16 len, u16 opcode)
 {
 	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct pending_cmd *cmd;
@@ -3954,20 +3969,20 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
 				   sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
 	if (hdev->discovery.type != mgmt_cp->type) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
 				   sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -3978,6 +3993,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_stop_discovery(&req);
 
 	err = hci_req_run(&req, stop_discovery_complete);
+
 	if (!err) {
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 		goto unlock;
@@ -3987,7 +4003,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	/* If no HCI commands were sent we're done */
 	if (err == -ENODATA) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
+		err = cmd_complete(sk, hdev->id, opcode, 0,
 				   &mgmt_cp->type, sizeof(mgmt_cp->type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
@@ -3997,6 +4013,13 @@ unlock:
 	return err;
 }
 
+static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 len)
+{
+	return generic_stop_discovery(sk, hdev, data, len,
+				      MGMT_OP_STOP_DISCOVERY);
+}
+
 static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 len)
 {
-- 
2.1.0

