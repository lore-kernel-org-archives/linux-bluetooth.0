Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix setting STOPPING state for discovery
Date: Tue,  8 Jul 2014 16:05:06 +0300
Message-Id: <1404824706-1057-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com>
References: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If any of the HCI commands from the hci_stop_discovery function were
successfully sent we need to set the discovery state to STOPPING. The
Stop Discovery code was already handling this, but the code in
clean_up_hci_state was not. This patch updates the hci_stop_discovery to
return a bool to indicate whether it queued any commands and the
clean_up_hci_state() function respectively to look at the return value
and call hci_discovery_set_state() if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 944e6463fd61..a4232bc237f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1251,7 +1251,7 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static void hci_stop_discovery(struct hci_request *req)
+static bool hci_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_remote_name_req_cancel cp;
@@ -1266,32 +1266,39 @@ static void hci_stop_discovery(struct hci_request *req)
 			hci_req_add_le_scan_disable(req);
 		}
 
-		break;
+		return true;
 
 	case DISCOVERY_RESOLVING:
 		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
 						     NAME_PENDING);
 		if (!e)
-			return;
+			break;
 
 		bacpy(&cp.bdaddr, &e->data.bdaddr);
 		hci_req_add(req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
 			    &cp);
 
-		break;
+		return true;
 
 	default:
 		/* Passive scanning */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
 			hci_req_add_le_scan_disable(req);
+			return true;
+		}
+
 		break;
 	}
+
+	return false;
 }
 
 static int clean_up_hci_state(struct hci_dev *hdev)
 {
 	struct hci_request req;
 	struct hci_conn *conn;
+	bool discov_stopped;
+	int err;
 
 	hci_req_init(&req, hdev);
 
@@ -1304,7 +1311,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
 		disable_advertising(&req);
 
-	hci_stop_discovery(&req);
+	discov_stopped = hci_stop_discovery(&req);
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
 		struct hci_cp_disconnect dc;
@@ -1338,7 +1345,11 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		}
 	}
 
-	return hci_req_run(&req, clean_up_hci_complete);
+	err = hci_req_run(&req, clean_up_hci_complete);
+	if (!err && discov_stopped)
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+
+	return err;
 }
 
 static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
-- 
1.9.3

