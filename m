Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Code refactoring
Date: Wed,  9 Nov 2011 17:14:27 -0300
Message-Id: <1320869667-1373-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the helper function cmd_failed() to handle mgmt
commands failures. This function sends the proper command status
event and removes the command from the pending list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   53 +++++++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 60306bc..f242be2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -290,6 +290,22 @@ static void mgmt_pending_remove(struct pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
+static int cmd_failed(struct hci_dev *hdev, u16 cmd_opcode, u8 status)
+{
+	struct pending_cmd *cmd = mgmt_pending_find(cmd_opcode, hdev);
+	int err;
+
+	if (!cmd)
+		return -ENOENT;
+
+	BT_DBG("%s opcode %u status %u", hdev->name, cmd_opcode, status);
+
+	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
@@ -2135,18 +2151,7 @@ int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 int mgmt_disconnect_failed(struct hci_dev *hdev)
 {
-	struct pending_cmd *cmd;
-	int err;
-
-	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT, EIO);
-
-	mgmt_pending_remove(cmd);
-
-	return err;
+	return cmd_failed(hdev, MGMT_OP_DISCONNECT, EIO);
 }
 
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
@@ -2376,32 +2381,12 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name)
 
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
-	struct pending_cmd *cmd;
-	int err;
-
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
-	mgmt_pending_remove(cmd);
-
-	return err;
+	return cmd_failed(hdev, MGMT_OP_START_DISCOVERY, status);
 }
 
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 {
-	struct pending_cmd *cmd;
-	int err;
-
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
-	mgmt_pending_remove(cmd);
-
-	return err;
+	return cmd_failed(hdev, MGMT_OP_STOP_DISCOVERY, status);
 }
 
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
-- 
1.7.7.1

