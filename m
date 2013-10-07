Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: Make mgmt_set_powered_failed() return void
Date: Sun,  6 Oct 2013 23:55:46 -0700
Message-Id: <1381128953-32080-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_set_powered_failed() function is never used
and so make the function just return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1e6f584..62e2fc1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1094,7 +1094,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
-int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
+void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 811c411..5da7464 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3934,25 +3934,23 @@ new_settings:
 	return err;
 }
 
-int mgmt_set_powered_failed(struct hci_dev *hdev, int err)
+void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 {
 	struct pending_cmd *cmd;
 	u8 status;
 
 	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
 	if (!cmd)
-		return -ENOENT;
+		return;
 
 	if (err == -ERFKILL)
 		status = MGMT_STATUS_RFKILLED;
 	else
 		status = MGMT_STATUS_FAILED;
 
-	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED, status);
+	cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED, status);
 
 	mgmt_pending_remove(cmd);
-
-	return err;
 }
 
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
-- 
1.8.3.1

