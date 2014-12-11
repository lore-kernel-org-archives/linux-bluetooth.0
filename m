Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix incorrect pending cmd removal in pairing_complete()
Date: Thu, 11 Dec 2014 21:45:45 +0200
Message-Id: <1418327146-15899-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
References: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The pairing_complete() function is used as a pending mgmt command
cmd_complete callback. The expectation of such functions is that they
are not responsible themselves for calling mgmt_pending_remove(). This
patch fixes the incorrect mgmt_pending_remove() call in
pairing_complete() and adds it to the appropriate changes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 34da65ccc888..827107d5a424 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3115,7 +3115,6 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	conn->disconn_cfm_cb = NULL;
 
 	hci_conn_drop(conn);
-	mgmt_pending_remove(cmd);
 
 	/* The device is paired so there is no need to remove
 	 * its connection parameters anymore.
@@ -3131,8 +3130,10 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 	struct pending_cmd *cmd;
 
 	cmd = find_pairing(conn);
-	if (cmd)
+	if (cmd) {
 		cmd->cmd_complete(cmd, status);
+		mgmt_pending_remove(cmd);
+	}
 }
 
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3142,10 +3143,13 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 	BT_DBG("status %u", status);
 
 	cmd = find_pairing(conn);
-	if (!cmd)
+	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
-	else
-		cmd->cmd_complete(cmd, mgmt_status(status));
+		return;
+	}
+
+	cmd->cmd_complete(cmd, mgmt_status(status));
+	mgmt_pending_remove(cmd);
 }
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3158,10 +3162,13 @@ static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 		return;
 
 	cmd = find_pairing(conn);
-	if (!cmd)
+	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
-	else
-		cmd->cmd_complete(cmd, mgmt_status(status));
+		return;
+	}
+
+	cmd->cmd_complete(cmd, mgmt_status(status));
+	mgmt_pending_remove(cmd);
 }
 
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3275,8 +3282,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	cmd->user_data = hci_conn_get(conn);
 
 	if ((conn->state == BT_CONNECTED || conn->state == BT_CONFIG) &&
-	    hci_conn_security(conn, sec_level, auth_type, true))
-		pairing_complete(cmd, 0);
+	    hci_conn_security(conn, sec_level, auth_type, true)) {
+		cmd->cmd_complete(cmd, 0);
+		mgmt_pending_remove(cmd);
+	}
 
 	err = 0;
 
@@ -3318,7 +3327,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	pairing_complete(cmd, MGMT_STATUS_CANCELLED);
+	cmd->cmd_complete(cmd, MGMT_STATUS_CANCELLED);
+	mgmt_pending_remove(cmd);
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 			   addr, sizeof(*addr));
@@ -6687,8 +6697,10 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 	mgmt_event(MGMT_EV_AUTH_FAILED, conn->hdev, &ev, sizeof(ev),
 		    cmd ? cmd->sk : NULL);
 
-	if (cmd)
-		pairing_complete(cmd, status);
+	if (cmd) {
+		cmd->cmd_complete(cmd, status);
+		mgmt_pending_remove(cmd);
+	}
 }
 
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
-- 
2.1.0

