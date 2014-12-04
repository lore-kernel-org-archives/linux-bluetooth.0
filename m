Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 2/7] Bluetooth: Use {start,stop}_discovery_complete handler for cmd_complete
Date: Thu,  4 Dec 2014 11:36:35 +0100
Message-Id: <1417689400-128063-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sending the required cmd_complete for the management commands should be
done in one place and not in multiple places. Especially for Start and
Stop Discovery commands this is split into to sending it in case of
failure from the complete handler, but in case of success from the
event state update function triggering mgmt_discovering. This is way
too convoluted and since hci_request serializes the HCI command
processing, send the cmd_complete response from the complete handler
for all cases.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 97 +++++++++++++++++-----------------------------------
 1 file changed, 31 insertions(+), 66 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f3296371a310..311984fcac55 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3686,64 +3686,53 @@ done:
 	return err;
 }
 
-static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
+static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-	u8 type;
-	int err;
-
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	type = hdev->discovery.type;
+	unsigned long timeout;
 
-	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
-			   &type, sizeof(type));
-	mgmt_pending_remove(cmd);
+	BT_DBG("status %d", status);
 
-	return err;
-}
+	hci_dev_lock(hdev);
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
-{
-	unsigned long timeout = 0;
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	if (cmd) {
+		u8 type = hdev->discovery.type;
 
-	BT_DBG("status %d", status);
+		cmd_complete(cmd->sk, hdev->id, cmd->opcode,
+			     mgmt_status(status), &type, sizeof(type));
+		mgmt_pending_remove(cmd);
+	}
 
 	if (status) {
-		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
-		hci_dev_unlock(hdev);
-		return;
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		goto unlock;
 	}
 
-	hci_dev_lock(hdev);
 	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-	hci_dev_unlock(hdev);
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
 		break;
-
 	case DISCOV_TYPE_INTERLEAVED:
 		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
 		break;
-
 	case DISCOV_TYPE_BREDR:
+		timeout = 0;
 		break;
-
 	default:
 		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
+		timeout = 0;
+		break;
 	}
 
-	if (!timeout)
-		return;
+	if (timeout)
+		queue_delayed_work(hdev->workqueue,
+				   &hdev->le_scan_disable, timeout);
 
-	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static int start_discovery(struct sock *sk, struct hci_dev *hdev,
@@ -3915,36 +3904,26 @@ failed:
 	return err;
 }
 
-static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
+static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
-			   &hdev->discovery.type, sizeof(hdev->discovery.type));
-	mgmt_pending_remove(cmd);
-
-	return err;
-}
-
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
-{
 	BT_DBG("status %d", status);
 
 	hci_dev_lock(hdev);
 
-	if (status) {
-		mgmt_stop_discovery_failed(hdev, status);
-		goto unlock;
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	if (cmd) {
+		u8 type = hdev->discovery.type;
+
+		cmd_complete(cmd->sk, hdev->id, cmd->opcode,
+			     mgmt_status(status), &type, sizeof(type));
+		mgmt_pending_remove(cmd);
 	}
 
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	if (!status)
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6909,23 +6888,9 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
 	struct mgmt_ev_discovering ev;
-	struct pending_cmd *cmd;
 
 	BT_DBG("%s discovering %u", hdev->name, discovering);
 
-	if (discovering)
-		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	else
-		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
-
-	if (cmd != NULL) {
-		u8 type = hdev->discovery.type;
-
-		cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0, &type,
-			     sizeof(type));
-		mgmt_pending_remove(cmd);
-	}
-
 	memset(&ev, 0, sizeof(ev));
 	ev.type = hdev->discovery.type;
 	ev.discovering = discovering;
-- 
1.9.3

