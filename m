Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: Convert Disconnect mgmt command to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:02 +0200
Message-Id: <1417779369-6428-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the Disconnect mgmt command to take advantage of the
new cmd_complete callback that's part of the pending_cmd struct. There
are many commands whose response parameters map 1:1 to the command
parameters and Disconnect is one of them. This patch adds a
generic_cmd_complete() function for such commands that can be reused in
subsequent patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 56c7838c0a41..81b2886f64b8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1486,6 +1486,12 @@ static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
 	cmd_status_rsp(cmd, data);
 }
 
+static void generic_cmd_complete(struct pending_cmd *cmd, u8 status)
+{
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
+		     cmd->param_len);
+}
+
 static u8 mgmt_bredr_support(struct hci_dev *hdev)
 {
 	if (!lmp_bredr_capable(hdev))
@@ -2872,6 +2878,8 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	cmd->cmd_complete = generic_cmd_complete;
+
 	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
@@ -6396,15 +6404,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 {
-	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct sock **sk = data;
-	struct mgmt_rp_disconnect rp;
 
-	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
-	rp.addr.type = cp->addr.type;
-
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT, 0, &rp,
-		     sizeof(rp));
+	cmd->cmd_complete(cmd, 0);
 
 	*sk = cmd->sk;
 	sock_hold(*sk);
@@ -6486,7 +6488,6 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	u8 bdaddr_type = link_to_bdaddr(link_type, addr_type);
 	struct mgmt_cp_disconnect *cp;
-	struct mgmt_rp_disconnect rp;
 	struct pending_cmd *cmd;
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
@@ -6504,12 +6505,7 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (cp->addr.type != bdaddr_type)
 		return;
 
-	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = bdaddr_type;
-
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
-		     mgmt_status(status), &rp, sizeof(rp));
-
+	cmd->cmd_complete(cmd, mgmt_status(status));
 	mgmt_pending_remove(cmd);
 }
 
-- 
2.1.0

