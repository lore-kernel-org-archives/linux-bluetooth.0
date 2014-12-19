Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move hci_update_page_scan to hci_request.c
Date: Fri, 19 Dec 2014 23:18:22 +0200
Message-Id: <1419023902-16725-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This is a left-over from the patch that created hci_request.c. The
hci_update_page_scan functions should have been moved from hci_core.c
there.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 56 ---------------------------------------------
 net/bluetooth/hci_request.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ee2096c7ec2c..9790a0108e69 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5253,59 +5253,3 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
-
-static bool disconnected_whitelist_entries(struct hci_dev *hdev)
-{
-	struct bdaddr_list *b;
-
-	list_for_each_entry(b, &hdev->whitelist, list) {
-		struct hci_conn *conn;
-
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
-		if (!conn)
-			return true;
-
-		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
-			return true;
-	}
-
-	return false;
-}
-
-void __hci_update_page_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 scan;
-
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return;
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (mgmt_powering_down(hdev))
-		return;
-
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
-	    disconnected_whitelist_entries(hdev))
-		scan = SCAN_PAGE;
-	else
-		scan = SCAN_DISABLED;
-
-	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
-		return;
-
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-		scan |= SCAN_INQUIRY;
-
-	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
-void hci_update_page_scan(struct hci_dev *hdev)
-{
-	struct hci_request req;
-
-	hci_req_init(&req, hdev);
-	__hci_update_page_scan(&req);
-	hci_req_run(&req, NULL);
-}
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e49f682f1550..5e64ea70a106 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -396,6 +396,62 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	return 0;
 }
 
+static bool disconnected_whitelist_entries(struct hci_dev *hdev)
+{
+	struct bdaddr_list *b;
+
+	list_for_each_entry(b, &hdev->whitelist, list) {
+		struct hci_conn *conn;
+
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
+		if (!conn)
+			return true;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			return true;
+	}
+
+	return false;
+}
+
+void __hci_update_page_scan(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 scan;
+
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (mgmt_powering_down(hdev))
+		return;
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
+	    disconnected_whitelist_entries(hdev))
+		scan = SCAN_PAGE;
+	else
+		scan = SCAN_DISABLED;
+
+	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
+		return;
+
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
+void hci_update_page_scan(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+	__hci_update_page_scan(&req);
+	hci_req_run(&req, NULL);
+}
+
 /* This function controls the background scanning based on hdev->pend_le_conns
  * list. If there are pending LE connection we start the background scanning,
  * otherwise we stop it.
-- 
2.1.0

