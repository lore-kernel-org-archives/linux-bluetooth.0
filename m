Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/14] Bluetooth: Make mgmt_stop_discovery_failed static
Date: Tue, 30 Apr 2013 15:29:35 -0300
Message-Id: <1367346580-6647-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_stop_discovery_failed is now only used in mgmt.c so we can
make it a local function. This patch also moves the mgmt_stop_
discovery_failed definition up in mgmt.c to avoid forward
declaration.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/mgmt.c             | 32 ++++++++++++++++----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9b226c5..9f5bea6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1179,7 +1179,6 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 ssp, u8 *eir, u16 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
-int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index afe29fe..83db6e8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2808,6 +2808,22 @@ failed:
 	return err;
 }
 
+static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
+			   &hdev->discovery.type, sizeof(hdev->discovery.type));
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("status %d", status);
@@ -4194,22 +4210,6 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  sizeof(*ev) + eir_len, NULL);
 }
 
-int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
-{
-	struct pending_cmd *cmd;
-	int err;
-
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
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
 	struct mgmt_ev_discovering ev;
-- 
1.8.2.1

