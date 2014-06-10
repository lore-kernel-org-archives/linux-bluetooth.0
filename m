Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Refactor discovery stopping into its own function
Date: Tue, 10 Jun 2014 14:05:58 +0300
Message-Id: <1402398359-1602-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
References: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll need to reuse the same logic for stopping discovery also when
cleaning up HCI state when powering off. This patch refactors the code
out to its own function that can later (in a subsequent patch) be used
also for the power off case.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 93 +++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0fce54412ffd..be6f03219121 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1047,6 +1047,43 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+static void hci_stop_discovery(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_remote_name_req_cancel cp;
+	struct inquiry_entry *e;
+
+	switch (hdev->discovery.state) {
+	case DISCOVERY_FINDING:
+		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+		} else {
+			cancel_delayed_work(&hdev->le_scan_disable);
+			hci_req_add_le_scan_disable(req);
+		}
+
+		break;
+
+	case DISCOVERY_RESOLVING:
+		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
+						     NAME_PENDING);
+		if (!e)
+			return;
+
+		bacpy(&cp.bdaddr, &e->data.bdaddr);
+		hci_req_add(req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
+			    &cp);
+
+		break;
+
+	default:
+		/* Passive scanning */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			hci_req_add_le_scan_disable(req);
+		break;
+	}
+}
+
 static int clean_up_hci_state(struct hci_dev *hdev)
 {
 	struct hci_request req;
@@ -3574,8 +3611,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct pending_cmd *cmd;
-	struct hci_cp_remote_name_req_cancel cp;
-	struct inquiry_entry *e;
 	struct hci_request req;
 	int err;
 
@@ -3605,52 +3640,22 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_init(&req, hdev);
 
-	switch (hdev->discovery.state) {
-	case DISCOVERY_FINDING:
-		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			hci_req_add(&req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		} else {
-			cancel_delayed_work(&hdev->le_scan_disable);
-
-			hci_req_add_le_scan_disable(&req);
-		}
-
-		break;
-
-	case DISCOVERY_RESOLVING:
-		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
-						     NAME_PENDING);
-		if (!e) {
-			mgmt_pending_remove(cmd);
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_STOP_DISCOVERY, 0,
-					   &mgmt_cp->type,
-					   sizeof(mgmt_cp->type));
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-			goto unlock;
-		}
-
-		bacpy(&cp.bdaddr, &e->data.bdaddr);
-		hci_req_add(&req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
-			    &cp);
+	hci_stop_discovery(&req);
 
-		break;
-
-	default:
-		BT_DBG("unknown discovery state %u", hdev->discovery.state);
-
-		mgmt_pending_remove(cmd);
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_FAILED, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+	err = hci_req_run(&req, stop_discovery_complete);
+	if (!err) {
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 		goto unlock;
 	}
 
-	err = hci_req_run(&req, stop_discovery_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
-	else
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+	mgmt_pending_remove(cmd);
+
+	/* If no HCI commands were sent we're done */
+	if (err == -ENODATA) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
+				   &mgmt_cp->type, sizeof(mgmt_cp->type));
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.9.3

