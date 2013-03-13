Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 10/26] Bluetooth: Fix waiting for EIR update when setting local name
Date: Wed, 13 Mar 2013 11:12:01 -0700
Message-Id: <1363198337-3896-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We shouldn't respond to the mgmt_set_local_name command until all
related HCI commands have completed. This patch fixes the issue by
running the local name HCI command and the EIR update in the same
asynchronous request, and returning the mgmt command complete through
the complete callback of the request.

The downside of this is that we must set hdev->dev_name before the local
name HCI command has completed since otherwise the generated EIR
command doesn't contain the new name. This means that we can no-longer
reliably detect when the name has really changed and when not. Luckily
this only affects scenarios where the mgmt interface is *not* used (e.g.
hciconfig) so redundant mgmt_ev_local_name_changed events in these cases
are an acceptable drawback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   96 ++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e3cb01..1d50841 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2358,15 +2358,44 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static void update_name(struct hci_request *req, const char *name)
+static void update_name(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_local_name cp;
 
-	memcpy(cp.name, name, sizeof(cp.name));
+	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
 
 	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
+static void set_name_complete(struct hci_dev *hdev, u8 status)
+{
+	struct mgmt_cp_set_local_name *cp;
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
+	if (!cmd)
+		goto unlock;
+
+	cp = cmd->param;
+
+	if (status)
+		cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+			   mgmt_status(status));
+	else
+		cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+			     cp, sizeof(*cp));
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
@@ -2401,9 +2430,12 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
+
 	hci_req_init(&req, hdev);
-	update_name(&req, cp->name);
-	err = hci_req_run(&req, NULL);
+	update_name(&req);
+	update_eir(&req);
+	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -3208,7 +3240,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		set_bredr_scan(&req);
 		update_class(&req);
-		update_name(&req, hdev->dev_name);
+		update_name(&req);
 		update_eir(&req);
 	}
 
@@ -3776,59 +3808,29 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
-	struct pending_cmd *cmd;
 	struct mgmt_cp_set_local_name ev;
-	bool changed = false;
-	int err = 0;
+	struct pending_cmd *cmd;
 
-	if (memcmp(name, hdev->dev_name, sizeof(hdev->dev_name)) != 0) {
-		memcpy(hdev->dev_name, name, sizeof(hdev->dev_name));
-		changed = true;
-	}
+	if (status)
+		return 0;
 
 	memset(&ev, 0, sizeof(ev));
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
 	memcpy(ev.short_name, hdev->short_name, HCI_MAX_SHORT_NAME_LENGTH);
 
 	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
-	if (!cmd)
-		goto send_event;
-
-	/* Always assume that either the short or the complete name has
-	 * changed if there was a pending mgmt command */
-	changed = true;
-
-	if (status) {
-		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-				 mgmt_status(status));
-		goto failed;
-	}
-
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0, &ev,
-			   sizeof(ev));
-	if (err < 0)
-		goto failed;
-
-send_event:
-	if (changed)
-		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev,
-				 sizeof(ev), cmd ? cmd->sk : NULL);
+	if (!cmd) {
+		memcpy(hdev->dev_name, name, sizeof(hdev->dev_name));
 
-	/* EIR is taken care of separately when powering on the
-	 * adapter so only update them here if this is a name change
-	 * unrelated to power on.
-	 */
-	if (!test_bit(HCI_INIT, &hdev->flags)) {
-		struct hci_request req;
-		hci_req_init(&req, hdev);
-		update_eir(&req);
-		hci_req_run(&req, NULL);
+		/* If this is a HCI command related to powering on the
+		 * HCI dev don't send any mgmt signals.
+		 */
+		if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
+			return 0;
 	}
 
-failed:
-	if (cmd)
-		mgmt_pending_remove(cmd);
-	return err;
+	return mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
+			  cmd ? cmd->sk : NULL);
 }
 
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-- 
1.7.10.4

