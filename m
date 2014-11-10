Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 2/3] Bluetooth: Extract generic start and stop discovery
Date: Mon, 10 Nov 2014 08:33:30 -0800
Message-Id: <1415637211-11339-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1415637211-11339-1-git-send-email-jpawlowski@google.com>
References: <1415637211-11339-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit extract generic_start_discovery and generic_stop_discovery
in preparation for start and stop service discovery. The reason behind
that is that both functions will share big part of code, and it would
be much easier to maintain just one generic method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 147 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 61 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ce0272c..6e0da9b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3648,7 +3648,8 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
+static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status,
+				       uint16_t opcode)
 {
 	struct pending_cmd *cmd;
 	u8 type;
@@ -3656,7 +3657,7 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3669,7 +3670,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_start_discovery_complete(struct hci_dev *hdev, u8 status,
+					     uint16_t opcode)
 {
 	unsigned long timeout = 0;
 
@@ -3677,7 +3679,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
+		mgmt_start_discovery_failed(hdev, status, opcode);
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -3708,8 +3710,13 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
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
+				   void *data, u16 len, uint16_t opcode)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
@@ -3719,41 +3726,41 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct hci_request req;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	u8 status, own_addr_type;
+	u8 status, own_addr_type, type;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	type = cp->type;
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_NOT_POWERED,
-				   &cp->type, sizeof(cp->type));
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_NOT_POWERED, &type,
+				   sizeof(type));
 		goto failed;
 	}
 
 	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_BUSY, &type, sizeof(type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_BUSY, &type, sizeof(type));
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	hdev->discovery.type = cp->type;
+	hdev->discovery.type = type;
 
 	hci_req_init(&req, hdev);
 
@@ -3761,18 +3768,16 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_BREDR:
 		status = mgmt_bredr_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode, status, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_BUSY, &cp->type,
-					   sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode,
+					   MGMT_STATUS_BUSY, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3789,19 +3794,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode, status, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_NOT_SUPPORTED,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode,
+					   MGMT_STATUS_NOT_SUPPORTED, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3813,11 +3816,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			 */
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_START_DISCOVERY,
-						   MGMT_STATUS_REJECTED,
-						   &cp->type,
-						   sizeof(cp->type));
+				err = cmd_complete(sk, hdev->id, opcode,
+						   MGMT_STATUS_REJECTED, &type,
+						   sizeof(type));
 				mgmt_pending_remove(cmd);
 				goto failed;
 			}
@@ -3840,10 +3841,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		 */
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_FAILED,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode,
+					   MGMT_STATUS_FAILED, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3863,14 +3863,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	default:
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS,
-				   &cp->type, sizeof(cp->type));
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
 	err = hci_req_run(&req, start_discovery_complete);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
@@ -3881,12 +3882,20 @@ failed:
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
+				      uint16_t opcode)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -3897,14 +3906,15 @@ static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+static void generic_stop_discovery_complete(struct hci_dev *hdev, u8 status,
+					    uint16_t opcode)
 {
 	BT_DBG("status %d", status);
 
 	hci_dev_lock(hdev);
 
 	if (status) {
-		mgmt_stop_discovery_failed(hdev, status);
+		mgmt_stop_discovery_failed(hdev, status, opcode);
 		goto unlock;
 	}
 
@@ -3914,33 +3924,40 @@ unlock:
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
+				  void *data, u16 len, uint16_t opcode)
 {
-	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
+	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	int err;
+	u8 type;
 
 	BT_DBG("%s", hdev->name);
 
+	type = mgmt_cp->type;
+
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_REJECTED, &type, sizeof(type));
 		goto unlock;
 	}
 
-	if (hdev->discovery.type != mgmt_cp->type) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+	if (hdev->discovery.type != type) {
+		err = cmd_complete(sk, hdev->id, opcode,
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, opcode, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -3951,6 +3968,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_stop_discovery(&req);
 
 	err = hci_req_run(&req, stop_discovery_complete);
+
 	if (!err) {
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 		goto unlock;
@@ -3960,8 +3978,8 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	/* If no HCI commands were sent we're done */
 	if (err == -ENODATA) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
-				   &mgmt_cp->type, sizeof(mgmt_cp->type));
+		err = cmd_complete(sk, hdev->id, opcode, 0,
+				   &type, sizeof(type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
@@ -3970,6 +3988,13 @@ unlock:
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
2.1.0.rc2.206.gedb03e5

