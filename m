Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: mgmt_stop_discovery_failed()
Date: Tue,  8 Nov 2011 19:40:02 -0300
Message-Id: <1320792002-31151-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org>
References: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patches creates mgmt_stop_discovery_failed() which removes
pending MGMT_OP_STOP_DISCOVERY commands and sends proper command
status events.

This patch also fixes the MGMT_OP_STOP_DISCOVERY command leak in
case cancel inquiry fails.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    4 +++-
 net/bluetooth/mgmt.c             |   15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4e00ae0..dba10c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -932,6 +932,7 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
 							s8 rssi, u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_start_discovery_failed(u16 index, u8 status);
+int mgmt_stop_discovery_failed(u16 index, u8 status);
 int mgmt_discovering(u16 index, u8 discovering);
 int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e29a3b1..78ba9c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -55,8 +55,10 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
+	if (status) {
+		mgmt_stop_discovery_failed(hdev->id, status);
 		return;
+	}
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dc938dc..d840600 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2394,6 +2394,21 @@ int mgmt_start_discovery_failed(u16 index, u8 status)
 	return err;
 }
 
+int mgmt_stop_discovery_failed(u16 index, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
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
 	struct pending_cmd *cmd;
-- 
1.7.7.1

