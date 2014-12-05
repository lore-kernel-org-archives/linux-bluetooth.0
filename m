Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Convert discovery commands to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:06 +0200
Message-Id: <1417779369-6428-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the Start/Stop Discovery mgmt commands to use the
cmd_complete callback of struct pending_cmd. Since both of these
commands return the same parameters as they take as input we can use the
existing generic_cmd_complete() helper for this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1accbb9d1a36..ddaeebbccfba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3835,10 +3835,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 		cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
 
 	if (cmd) {
-		u8 type = hdev->discovery.type;
-
-		cmd_complete(cmd->sk, hdev->id, cmd->opcode,
-			     mgmt_status(status), &type, sizeof(type));
+		cmd->cmd_complete(cmd, mgmt_status(status));
 		mgmt_pending_remove(cmd);
 	}
 
@@ -3901,12 +3898,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
+	cmd->cmd_complete = generic_cmd_complete;
+
 	/* Clear the discovery filter first to free any previously
 	 * allocated memory for the UUID list.
 	 */
@@ -3936,6 +3935,11 @@ failed:
 	return err;
 }
 
+static void service_discovery_cmd_complete(struct pending_cmd *cmd, u8 status)
+{
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param, 1);
+}
+
 static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len)
 {
@@ -3991,12 +3995,14 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
-			       hdev, NULL, 0);
+			       hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
+	cmd->cmd_complete = service_discovery_cmd_complete;
+
 	/* Clear the discovery filter first to free any previously
 	 * allocated memory for the UUID list.
 	 */
@@ -4052,10 +4058,7 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
 	if (cmd) {
-		u8 type = hdev->discovery.type;
-
-		cmd_complete(cmd->sk, hdev->id, cmd->opcode,
-			     mgmt_status(status), &type, sizeof(type));
+		cmd->cmd_complete(cmd, mgmt_status(status));
 		mgmt_pending_remove(cmd);
 	}
 
@@ -4091,12 +4094,14 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
+	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
+	cmd->cmd_complete = generic_cmd_complete;
+
 	hci_req_init(&req, hdev);
 
 	hci_stop_discovery(&req);
-- 
2.1.0

