Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 5/6] Bluetooth: Implement the Remove Advertising command
Date: Thu, 19 Mar 2015 17:04:36 -0700
Message-Id: <1426809877-22469-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1426809877-22469-1-git-send-email-armansito@chromium.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Remove Advertising" mgmt command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f4ed4fb..eae280d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6511,6 +6511,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_SET_LE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_BUSY);
@@ -6539,7 +6540,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	 */
 	hdev->cur_adv_index = cp->instance;
 
-	hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
+	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
 	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
 	 * we have no HCI communication to make. Simply return.
@@ -6577,14 +6578,105 @@ unlock:
 	return err;
 }
 
+static void remove_advertising_complete(struct hci_dev *hdev, u8 status,
+					u16 opcode)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct mgmt_rp_remove_advertising rp;
+
+	BT_DBG("status %d", status);
+
+	hci_dev_lock(hdev);
+
+	/* A failure status here only means that we failed to disable
+	 * advertising. Otherwise, the advertising instance has been removed,
+	 * so report success.
+	 */
+	cmd = pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev);
+	if (!cmd)
+		goto unlock;
+
+	rp.instance = 1;
+
+	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, MGMT_STATUS_SUCCESS,
+			  &rp, sizeof(rp));
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 data_len)
 {
+	struct mgmt_cp_remove_advertising *cp = data;
+	struct mgmt_rp_remove_advertising rp;
+	int err;
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+
 	BT_DBG("%s", hdev->name);
 
-	/* TODO: Implement this command. */
-	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
-			       MGMT_STATUS_NOT_SUPPORTED);
+	/* The current implementation only allows modifying instance no 1. A
+	 * value of 0 indicates that all instances should be cleared.
+	 */
+	if (cp->instance > 1)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_SET_LE, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
+	hdev->cur_adv_index = 0;
+
+	/* TODO" Send Advertising Removed event */
+
+	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+
+	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
+	 * we have no HCI communication to make. Simply return.
+	 */
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+		rp.instance = 1;
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_REMOVE_ADVERTISING,
+					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_ADVERTISING, hdev, data,
+			       data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_req_init(&req, hdev);
+	disable_advertising(&req);
+
+	err = hci_req_run(&req, remove_advertising_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
 }
 
 static const struct hci_mgmt_handler mgmt_handlers[] = {
-- 
2.2.0.rc0.207.ga3a616c

