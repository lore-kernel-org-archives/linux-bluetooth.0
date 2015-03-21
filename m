Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 5/7] Bluetooth: Implement the Remove Advertising command
Date: Sat, 21 Mar 2015 00:03:35 -0700
Message-Id: <1426921417-3419-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1426921417-3419-1-git-send-email-armansito@chromium.org>
References: <1426921417-3419-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Remove Advertising" mgmt command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ea18675..3991380 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -101,6 +101,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_ADV_FEATURES,
 	MGMT_OP_ADD_ADVERTISING,
+	MGMT_OP_REMOVE_ADVERTISING,
 };
 
 static const u16 mgmt_events[] = {
@@ -6518,6 +6519,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_SET_LE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_BUSY);
@@ -6580,6 +6582,106 @@ unlock:
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
+static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 data_len)
+{
+	struct mgmt_cp_remove_advertising *cp = data;
+	struct mgmt_rp_remove_advertising rp;
+	int err;
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+
+	BT_DBG("%s", hdev->name);
+
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
+
+	advertising_removed(sk, hdev, 1);
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
+}
+
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,            MGMT_READ_VERSION_SIZE,
@@ -6666,6 +6768,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
 	{ add_advertising,	   MGMT_ADD_ADVERTISING_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.2.0.rc0.207.ga3a616c

