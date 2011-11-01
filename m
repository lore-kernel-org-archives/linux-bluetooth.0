Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix command complete/status for discovery commands
Date: Tue,  1 Nov 2011 17:06:44 +0200
Message-Id: <1320160004-2012-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary code to send proper command status or
command complete events to the start/stop discovery management commands.
Before this patch these events were completely missing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    2 ++
 net/bluetooth/mgmt.c             |   27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 119b795..c6a3715 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -884,6 +884,7 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
+int mgmt_inquiry_failed(u16 index, u8 status);
 int mgmt_discovering(u16 index, u8 discovering);
 int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41967fe..d8fa657 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -979,6 +979,8 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	if (status) {
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_inquiry_failed(hdev->id, status);
 		return;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b086c69..1625646 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2349,8 +2349,35 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
 	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_inquiry_failed(u16 index, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, index, cmd->opcode, status);
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 int mgmt_discovering(u16 index, u8 discovering)
 {
+	struct pending_cmd *cmd;
+
+	if (discovering)
+		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	else
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+
+	if (cmd != NULL) {
+		cmd_complete(cmd->sk, index, cmd->opcode, NULL, 0);
+		mgmt_pending_remove(cmd);
+	}
+
 	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
 						sizeof(discovering), NULL);
 }
-- 
1.7.7

