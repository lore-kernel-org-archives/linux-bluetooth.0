Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 14/26] Bluetooth: Use an async request for mgmt_set_connectable
Date: Wed, 13 Mar 2013 11:12:05 -0700
Message-Id: <1363198337-3896-15-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch changes the mgmt_set_connectable handler to use an async
request for sending the required HCI command. This is necessary
preparation for handling the fast connectable change that needs to be
associated with disabling the connectable setting.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 15305fa..a4f928d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -996,11 +996,32 @@ failed:
 	return err;
 }
 
+static void set_connectable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (!cmd)
+		goto unlock;
+
+	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	u8 scan;
 	int err;
 
@@ -1067,7 +1088,11 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 			cancel_delayed_work(&hdev->discov_off);
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+
+	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -3328,7 +3353,7 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
-	struct cmd_lookup match = { NULL, hdev };
+	struct pending_cmd *cmd;
 	bool changed = false;
 	int err = 0;
 
@@ -3340,14 +3365,10 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 			changed = true;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, settings_rsp,
-			     &match);
+	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
 
 	if (changed)
-		err = new_settings(hdev, match.sk);
-
-	if (match.sk)
-		sock_put(match.sk);
+		err = new_settings(hdev, cmd ? cmd->sk : NULL);
 
 	return err;
 }
-- 
1.7.10.4

