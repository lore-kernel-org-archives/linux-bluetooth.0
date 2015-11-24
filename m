Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Move __hci_update_background_scan up in hci_request.c
Date: Tue, 24 Nov 2015 14:02:02 +0200
Message-Id: <1448366527-29714-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
References: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This way we avoid the need to do a forward declaration in later
patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 146 ++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 78c026b4ffa1..7c85435b8982 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -346,6 +346,79 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
 
+/* This function controls the background scanning based on hdev->pend_le_conns
+ * list. If there are pending LE connection we start the background scanning,
+ * otherwise we stop it.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void __hci_update_background_scan(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return;
+
+	/* No point in doing scanning if LE support hasn't been enabled */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return;
+
+	/* If discovery is active don't interfere with it */
+	if (hdev->discovery.state != DISCOVERY_STOPPED)
+		return;
+
+	/* Reset RSSI and UUID filters when starting background scanning
+	 * since these filters are meant for service discovery only.
+	 *
+	 * The Start Discovery and Start Service Discovery operations
+	 * ensure to set proper values for RSSI threshold and UUID
+	 * filter list. So it is safe to just reset them here.
+	 */
+	hci_discovery_filter_clear(hdev);
+
+	if (list_empty(&hdev->pend_le_conns) &&
+	    list_empty(&hdev->pend_le_reports)) {
+		/* If there is no pending LE connections or devices
+		 * to be scanned for, we should stop the background
+		 * scanning.
+		 */
+
+		/* If controller is not scanning we are done. */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+			return;
+
+		hci_req_add_le_scan_disable(req);
+
+		BT_DBG("%s stopping background scanning", hdev->name);
+	} else {
+		/* If there is at least one pending LE connection, we should
+		 * keep the background scan running.
+		 */
+
+		/* If controller is connecting, we should not start scanning
+		 * since some controllers are not able to scan and connect at
+		 * the same time.
+		 */
+		if (hci_lookup_le_connect(hdev))
+			return;
+
+		/* If controller is currently scanning, we stop it to ensure we
+		 * don't miss any advertising (due to duplicates filter).
+		 */
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+			hci_req_add_le_scan_disable(req);
+
+		hci_req_add_le_passive_scan(req);
+
+		BT_DBG("%s starting background scanning", hdev->name);
+	}
+}
+
 void hci_req_add_le_scan_disable(struct hci_request *req)
 {
 	struct hci_cp_le_set_scan_enable cp;
@@ -682,79 +755,6 @@ static void scan_update_work(struct work_struct *work)
 	hci_req_sync(hdev, update_scan, 0, HCI_CMD_TIMEOUT, NULL);
 }
 
-/* This function controls the background scanning based on hdev->pend_le_conns
- * list. If there are pending LE connection we start the background scanning,
- * otherwise we stop it.
- *
- * This function requires the caller holds hdev->lock.
- */
-static void __hci_update_background_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	if (!test_bit(HCI_UP, &hdev->flags) ||
-	    test_bit(HCI_INIT, &hdev->flags) ||
-	    hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
-	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
-	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return;
-
-	/* No point in doing scanning if LE support hasn't been enabled */
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	/* If discovery is active don't interfere with it */
-	if (hdev->discovery.state != DISCOVERY_STOPPED)
-		return;
-
-	/* Reset RSSI and UUID filters when starting background scanning
-	 * since these filters are meant for service discovery only.
-	 *
-	 * The Start Discovery and Start Service Discovery operations
-	 * ensure to set proper values for RSSI threshold and UUID
-	 * filter list. So it is safe to just reset them here.
-	 */
-	hci_discovery_filter_clear(hdev);
-
-	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports)) {
-		/* If there is no pending LE connections or devices
-		 * to be scanned for, we should stop the background
-		 * scanning.
-		 */
-
-		/* If controller is not scanning we are done. */
-		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			return;
-
-		hci_req_add_le_scan_disable(req);
-
-		BT_DBG("%s stopping background scanning", hdev->name);
-	} else {
-		/* If there is at least one pending LE connection, we should
-		 * keep the background scan running.
-		 */
-
-		/* If controller is connecting, we should not start scanning
-		 * since some controllers are not able to scan and connect at
-		 * the same time.
-		 */
-		if (hci_lookup_le_connect(hdev))
-			return;
-
-		/* If controller is currently scanning, we stop it to ensure we
-		 * don't miss any advertising (due to duplicates filter).
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req);
-
-		hci_req_add_le_passive_scan(req);
-
-		BT_DBG("%s starting background scanning", hdev->name);
-	}
-}
-
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
-- 
2.5.0

