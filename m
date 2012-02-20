Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: mgmt: Add address type parameter to Stop Discovery command
Date: Tue, 21 Feb 2012 00:24:33 +0200
Message-Id: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds an address type parameter to the Stop Discovery command
which should match the value given to Start Discovery.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    3 +++
 net/bluetooth/mgmt.c         |   33 ++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7e3d38b..870a3de 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -283,6 +283,9 @@ struct mgmt_cp_start_discovery {
 } __packed;
 
 #define MGMT_OP_STOP_DISCOVERY		0x0024
+struct mgmt_cp_stop_discovery {
+	__u8 type;
+} __packed;
 
 #define MGMT_OP_CONFIRM_NAME		0x0025
 struct mgmt_cp_confirm_name {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f7c2969..3db8525 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2281,8 +2281,9 @@ failed:
 	return err;
 }
 
-static int stop_discovery(struct sock *sk, u16 index)
+static int stop_discovery(struct sock *sk, u16 index, void *data, u16 len)
 {
+	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	struct hci_cp_remote_name_req_cancel cp;
@@ -2291,6 +2292,10 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	BT_DBG("hci%u", index);
 
+	if (len != sizeof(*mgmt_cp))
+		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
+						MGMT_STATUS_INVALID_PARAMS);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
@@ -2299,8 +2304,16 @@ static int stop_discovery(struct sock *sk, u16 index)
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
-						MGMT_STATUS_REJECTED);
+		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY,
+					MGMT_STATUS_REJECTED,
+					&mgmt_cp->type, sizeof(mgmt_cp->type));
+		goto unlock;
+	}
+
+	if (hdev->discovery.type != mgmt_cp->type) {
+		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY,
+					MGMT_STATUS_INVALID_PARAMS,
+					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
@@ -2323,7 +2336,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 	if (!e) {
 		mgmt_pending_remove(cmd);
 		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY, 0,
-								NULL, 0);
+					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
@@ -2706,7 +2719,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = start_discovery(sk, index, cp, len);
 		break;
 	case MGMT_OP_STOP_DISCOVERY:
-		err = stop_discovery(sk, index);
+		err = stop_discovery(sk, index, cp, len);
 		break;
 	case MGMT_OP_CONFIRM_NAME:
 		err = confirm_name(sk, index, cp, len);
@@ -3369,7 +3382,9 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status));
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
+						&hdev->discovery.type,
+						sizeof(hdev->discovery.type));
 	mgmt_pending_remove(cmd);
 
 	return err;
@@ -3389,12 +3404,8 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	if (cmd != NULL) {
 		u8 type = hdev->discovery.type;
 
-		if (discovering)
-			cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0,
+		cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0,
 							&type, sizeof(type));
-		else
-			cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0,
-								NULL, 0);
 		mgmt_pending_remove(cmd);
 	}
 
-- 
1.7.9

