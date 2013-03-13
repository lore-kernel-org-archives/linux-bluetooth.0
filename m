Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 15/26] Bluetooth: Fix fast connectable response sending
Date: Wed, 13 Mar 2013 11:12:06 -0700
Message-Id: <1363198337-3896-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt_set_fast_connectable response should be sent only when all
related HCI commands have completed. This patch fixes the issue by using
an async request and sending the response to user space throught the
complete callback of the request. The patch also fixes in the same go
the return parameters of the command which should be the current
settings.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   53 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a4f928d..bd61318 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2896,11 +2896,39 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev);
+	if (!cmd)
+		goto unlock;
+
+	if (status) {
+		cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+			   mgmt_status(status));
+	} else {
+		send_settings_rsp(cmd->sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev);
+		new_settings(hdev, cmd->sk);
+	}
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 				void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct hci_cp_write_page_scan_activity acp;
+	struct pending_cmd *cmd;
+	struct hci_request req;
 	u8 type;
 	int err;
 
@@ -2939,25 +2967,28 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	/* default 11.25 msec page scan window */
 	acp.window = __constant_cpu_to_le16(0x0012);
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp),
-			   &acp);
-	if (err < 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				 MGMT_STATUS_FAILED);
-		goto done;
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
+			       data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp), &acp);
+	hci_req_add(&req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+
+	err = hci_req_run(&req, fast_connectable_complete);
 	if (err < 0) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				 MGMT_STATUS_FAILED);
-		goto done;
+		mgmt_pending_remove(cmd);
 	}
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE, 0,
-			   NULL, 0);
-done:
+unlock:
 	hci_dev_unlock(hdev);
+
 	return err;
 }
 
-- 
1.7.10.4

