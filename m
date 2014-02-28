Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove unnecessary stop_scan_complete function
Date: Fri, 28 Feb 2014 20:26:13 +0200
Message-Id: <1393611973-3183-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com>
References: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The stop_scan_complete function was used as an intermediate step before
doing the actual connection creation. Since we're using hci_request
there's no reason to have this extra function around, i.e. we can simply
put both HCI commands into the same request.

The single task that the intermediate function had, i.e. indicating
discovery as stopped is now taken care of by a new
HCI_LE_SCAN_INTERRUPTED flag which allows us to do the discovery state
update when the stop scan command completes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    | 51 +++++++--------------------------------------
 net/bluetooth/hci_event.c   |  7 +++++++
 3 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0409f0119d2b..be150cf8cd43 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -140,6 +140,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_6LOWPAN_ENABLED,
+	HCI_LE_SCAN_INTERRUPTED,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5330fcfde93d..7c713c4675ba 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -605,44 +605,6 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
-static void stop_scan_complete(struct hci_dev *hdev, u8 status)
-{
-	struct hci_request req;
-	struct hci_conn *conn;
-	int err;
-
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (!conn)
-		return;
-
-	if (status) {
-		BT_DBG("HCI request failed to stop scanning: status 0x%2.2x",
-		       status);
-
-		hci_dev_lock(hdev);
-		hci_le_conn_failed(conn, status);
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	/* Since we may have prematurely stopped discovery procedure, we should
-	 * update discovery state.
-	 */
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add_le_create_conn(&req, conn);
-
-	err = hci_req_run(&req, create_le_conn_complete);
-	if (err) {
-		hci_dev_lock(hdev);
-		hci_le_conn_failed(conn, HCI_ERROR_MEMORY_EXCEEDED);
-		hci_dev_unlock(hdev);
-		return;
-	}
-}
-
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u8 auth_type)
 {
@@ -721,16 +683,19 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	hci_req_init(&req, hdev);
 
 	/* If controller is scanning, we stop it since some controllers are
-	 * not able to scan and connect at the same time.
+	 * not able to scan and connect at the same time. Also set the
+	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
+	 * handler for scan disabling knows to set the correct discovery
+	 * state.
 	 */
 	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
 		hci_req_add_le_scan_disable(&req);
-		err = hci_req_run(&req, stop_scan_complete);
-	} else {
-		hci_req_add_le_create_conn(&req, conn);
-		err = hci_req_run(&req, create_le_conn_complete);
+		set_bit(HCI_LE_SCAN_INTERRUPTED, &hdev->dev_flags);
 	}
 
+	hci_req_add_le_create_conn(&req, conn);
+
+	err = hci_req_run(&req, create_le_conn_complete);
 	if (err) {
 		hci_conn_del(conn);
 		return ERR_PTR(err);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e3335b03c992..c3b0a08f5ab4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1024,6 +1024,13 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
+		 * interrupted scanning due to a connect request. Mark
+		 * therefore discovery as stopped.
+		 */
+		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
+				       &hdev->dev_flags))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		break;
 
 	default:
-- 
1.8.5.3

