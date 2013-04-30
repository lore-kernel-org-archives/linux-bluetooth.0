Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/14] Bluetooth: Update stop_discovery to use HCI request
Date: Tue, 30 Apr 2013 15:29:33 -0300
Message-Id: <1367346580-6647-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies the stop_discovery function so it uses the HCI
request framework.

The HCI request is built according to the current discovery state
(inquiry, LE scanning or name resolving) and a complete callback is
register to handle the command complete event for the stop discovery
command. This way, we move all stop_discovery mgmt handling code
spread in hci_event.c to a single place in mgmt.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 15d40ab..afe29fe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2808,6 +2808,23 @@ failed:
 	return err;
 }
 
+static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status %d", status);
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		mgmt_stop_discovery_failed(hdev, status);
+		goto unlock;
+	}
+
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
@@ -2815,6 +2832,8 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct pending_cmd *cmd;
 	struct hci_cp_remote_name_req_cancel cp;
 	struct inquiry_entry *e;
+	struct hci_request req;
+	struct hci_cp_le_set_scan_enable enable_cp;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2841,12 +2860,20 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	hci_req_init(&req, hdev);
+
 	switch (hdev->discovery.state) {
 	case DISCOVERY_FINDING:
-		if (test_bit(HCI_INQUIRY, &hdev->flags))
-			err = hci_cancel_inquiry(hdev);
-		else
-			err = hci_cancel_le_scan(hdev);
+		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+			hci_req_add(&req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+		} else {
+			cancel_delayed_work(&hdev->le_scan_disable);
+
+			memset(&enable_cp, 0, sizeof(enable_cp));
+			enable_cp.enable = LE_SCAN_DISABLE;
+			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
+				    sizeof(enable_cp), &enable_cp);
+		}
 
 		break;
 
@@ -2864,16 +2891,22 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 
 		bacpy(&cp.bdaddr, &e->data.bdaddr);
-		err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ_CANCEL,
-				   sizeof(cp), &cp);
+		hci_req_add(&req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
+			    &cp);
 
 		break;
 
 	default:
 		BT_DBG("unknown discovery state %u", hdev->discovery.state);
-		err = -EFAULT;
+
+		mgmt_pending_remove(cmd);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+				   MGMT_STATUS_FAILED, &mgmt_cp->type,
+				   sizeof(mgmt_cp->type));
+		goto unlock;
 	}
 
+	err = hci_req_run(&req, stop_discovery_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
-- 
1.8.2.1

