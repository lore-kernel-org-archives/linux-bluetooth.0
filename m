Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Refactor stop_discovery
Date: Tue, 20 Mar 2012 15:15:36 -0300
Message-Id: <1332267336-15967-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial code refactoring in stop_discovery
function by using a switch statement instead of an if-return-else
approach.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d93f2bf..44a500c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2401,31 +2401,39 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (hdev->discovery.state == DISCOVERY_FINDING) {
+	switch (hdev->discovery.state) {
+	case DISCOVERY_FINDING:
 		if (test_bit(HCI_INQUIRY, &hdev->flags))
 			err = hci_cancel_inquiry(hdev);
 		else
 			err = hci_cancel_le_scan(hdev);
 
-		if (err < 0)
+		break;
+
+	case DISCOVERY_RESOLVING:
+		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
+							NAME_PENDING);
+		if (!e) {
 			mgmt_pending_remove(cmd);
-		else
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
-		goto unlock;
-	}
+			err = cmd_complete(sk, hdev->id,
+						MGMT_OP_STOP_DISCOVERY, 0,
+						&mgmt_cp->type,
+						sizeof(mgmt_cp->type));
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			goto unlock;
+		}
 
-	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_PENDING);
-	if (!e) {
-		mgmt_pending_remove(cmd);
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
-				   &mgmt_cp->type, sizeof(mgmt_cp->type));
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		goto unlock;
+		bacpy(&cp.bdaddr, &e->data.bdaddr);
+		err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ_CANCEL,
+					sizeof(cp), &cp);
+
+		break;
+
+	default:
+		BT_DBG("unknown discovery state %u", hdev->discovery.state);
+		err = -EFAULT;
 	}
 
-	bacpy(&cp.bdaddr, &e->data.bdaddr);
-	err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
-			   &cp);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
-- 
1.7.9.4

