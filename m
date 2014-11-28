Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v13 2/3] Bluetooth: Extract generic start and stop discovery
Date: Fri, 28 Nov 2014 15:50:46 -0800
Message-Id: <1417218647-5362-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1417218647-5362-1-git-send-email-jpawlowski@google.com>
References: <1417218647-5362-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit extract generic_start_discovery and generic_stop_discovery
in preparation for start and stop service discovery. The reason behind
that is that both functions will share big part of code, and it would
be much easier to maintain just one generic method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbeef5f..6740de0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3735,8 +3735,8 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
 }
 
-static int start_discovery(struct sock *sk, struct hci_dev *hdev,
-			   void *data, u16 len)
+static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len, u16 opcode)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
@@ -3754,27 +3754,27 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3788,16 +3788,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3816,8 +3814,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
+			err = cmd_complete(sk, hdev->id, opcode, status,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
@@ -3825,8 +3822,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
+			err = cmd_complete(sk, hdev->id, opcode,
 					   MGMT_STATUS_NOT_SUPPORTED,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
@@ -3840,8 +3836,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			 */
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_START_DISCOVERY,
+				err = cmd_complete(sk, hdev->id, opcode,
 						   MGMT_STATUS_REJECTED,
 						   &cp->type,
 						   sizeof(cp->type));
@@ -3867,8 +3862,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		 */
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
+			err = cmd_complete(sk, hdev->id, opcode,
 					   MGMT_STATUS_FAILED,
 					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
@@ -3890,7 +3884,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	default:
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, opcode,
 				   MGMT_STATUS_INVALID_PARAMS,
 				   &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
@@ -3908,6 +3902,13 @@ failed:
 	return err;
 }
 
+static int start_discovery(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	return generic_start_discovery(sk, hdev, data, len,
+				       MGMT_OP_START_DISCOVERY);
+}
+
 static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
2.1.0

