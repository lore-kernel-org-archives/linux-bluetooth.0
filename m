Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 02/16] Bluetooth: Add failed/complete functions to discovery commands
Date: Mon, 25 Jul 2011 16:49:51 -0300
Message-Id: <1311623405-31108-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These functions remove pending commands and send command complete/
status events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    4 ++
 net/bluetooth/mgmt.c             |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c41e275..0ccd724 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -857,6 +857,10 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_discovering(u16 index, u8 discovering);
+int mgmt_start_discovery_complete(u16 index);
+int mgmt_start_discovery_failed(u16 index, u8 status);
+int mgmt_stop_discovery_complete(u16 index);
+int mgmt_stop_discovery_failed(u16 index, u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 53e109e..6102648 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2286,3 +2286,83 @@ int mgmt_discovering(u16 index, u8 discovering)
 	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
 						sizeof(discovering), NULL);
 }
+
+int mgmt_start_discovery_complete(u16 index)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_complete(cmd->sk, index, MGMT_OP_START_DISCOVERY, NULL, 0);
+
+	mgmt_pending_remove(cmd);
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (cmd) {
+		cmd_status(cmd->sk, index, MGMT_OP_STOP_DISCOVERY, EPERM);
+		mgmt_pending_remove(cmd);
+	}
+
+	return err;
+}
+
+int mgmt_start_discovery_failed(u16 index, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, index, MGMT_OP_START_DISCOVERY, status);
+
+	mgmt_pending_remove(cmd);
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (cmd) {
+		cmd_status(cmd->sk, index, MGMT_OP_STOP_DISCOVERY, EPERM);
+		mgmt_pending_remove(cmd);
+	}
+
+	return err;
+}
+
+int mgmt_stop_discovery_complete(u16 index)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_complete(cmd->sk, index, MGMT_OP_STOP_DISCOVERY, NULL, 0);
+
+	mgmt_pending_remove(cmd);
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	if (cmd)
+		mgmt_pending_remove(cmd);
+
+	return err;
+}
+
+int mgmt_stop_discovery_failed(u16 index, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, index, MGMT_OP_STOP_DISCOVERY, status);
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
-- 
1.7.4.1

