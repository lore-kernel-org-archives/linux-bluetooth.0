Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/14] Bluetooth: Make mgmt_start_discovery_failed static
Date: Tue, 30 Apr 2013 15:29:30 -0300
Message-Id: <1367346580-6647-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_start_discovery_failed is now only used in mgmt.c so we can
make it a local function. This patch also moves the mgmt_start_
discovery_failed definition up in mgmt.c to avoid forward
declaration.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/mgmt.c             | 42 ++++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1ff7f67..aa7eed7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1169,7 +1169,6 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 ssp, u8 *eir, u16 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
-int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_interleaved_discovery(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c701eac..0572cb1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2650,6 +2650,27 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 	return err;
 }
 
+static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+	u8 type;
+	int err;
+
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	type = hdev->discovery.type;
+
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
+			   &type, sizeof(type));
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("status %d", status);
@@ -4169,27 +4190,6 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  sizeof(*ev) + eir_len, NULL);
 }
 
-int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
-{
-	struct pending_cmd *cmd;
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
-
-	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
-			   &type, sizeof(type));
-	mgmt_pending_remove(cmd);
-
-	return err;
-}
-
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.8.2.1

