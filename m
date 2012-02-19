Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: mgmt: Fix Start Discovery return parameters
Date: Sun, 19 Feb 2012 13:54:27 +0200
Message-Id: <1329652469-28973-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The same address type that was passed to the Start Discovery command
should also be returned in the response message.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 79255f5..258adf4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3325,6 +3325,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
+	u8 type;
 	int err;
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -3333,7 +3334,10 @@ int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status));
+	type = hdev->discovery.type;
+
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
+							&type, sizeof(type));
 	mgmt_pending_remove(cmd);
 
 	return err;
@@ -3366,7 +3370,14 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
 
 	if (cmd != NULL) {
-		cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0, NULL, 0);
+		u8 type = hdev->discovery.type;
+
+		if (discovering)
+			cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0,
+							&type, sizeof(type));
+		else
+			cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0,
+								NULL, 0);
 		mgmt_pending_remove(cmd);
 	}
 
-- 
1.7.9

