Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v3 2/3] Bluetooth: Add mgmt_start_discovery_cancelled()
Date: Tue, 15 Jan 2013 18:31:31 +0530
Message-id: <1358254892-11303-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1358254892-11303-1-git-send-email-jaganath.k@samsung.com>
References: <1358254892-11303-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function can be used to inform userspace that start discovery
is cancelled

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 014a2ea..d8f68c7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1112,6 +1112,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
+int mgmt_start_discovery_cancelled(struct hci_dev *hdev);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_interleaved_discovery(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bcc7080..0db9d66 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3665,6 +3665,25 @@ int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
+int mgmt_start_discovery_cancelled(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+	u8 type;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	type = hdev->discovery.type;
+
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, MGMT_STATUS_CANCELLED,
+			   &type, sizeof(type));
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.7.9.5

