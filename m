Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Simplify le_scan_disable_work()
Date: Wed, 11 Nov 2015 12:24:22 +0200
Message-Id: <1447237463-29233-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
References: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Merge le_scan_disable_work_complete into the main le_scan_disable_work
function and take advantage of the updated bredr_inquiry() to run the
Inquiry through hci_req_sync().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 148 +++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 91 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 98827e7631ca..04c3357b1e1c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -864,83 +864,31 @@ static void bg_scan_update(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static void inquiry_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	if (status) {
-		BT_ERR("Failed to start inquiry: status %d", status);
-
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		hci_dev_unlock(hdev);
-		return;
-	}
+	hci_req_add_le_scan_disable(req);
+	return 0;
 }
 
-static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 {
+	u8 length = opt;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
 	struct hci_cp_inquiry cp;
-	int err;
-
-	if (status) {
-		BT_ERR("Failed to disable LE scanning: status %d", status);
-		return;
-	}
-
-	hdev->discovery.scan_start = 0;
-
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_LE:
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		hci_dev_unlock(hdev);
-		break;
 
-	case DISCOV_TYPE_INTERLEAVED:
-		hci_dev_lock(hdev);
-
-		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
-			     &hdev->quirks)) {
-			/* If we were running LE only scan, change discovery
-			 * state. If we were running both LE and BR/EDR inquiry
-			 * simultaneously, and BR/EDR inquiry is already
-			 * finished, stop discovery, otherwise BR/EDR inquiry
-			 * will stop discovery when finished. If we will resolve
-			 * remote device name, do not change discovery state.
-			 */
-			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
-			    hdev->discovery.state != DISCOVERY_RESOLVING)
-				hci_discovery_set_state(hdev,
-							DISCOVERY_STOPPED);
-		} else {
-			struct hci_request req;
-
-			hci_inquiry_cache_flush(hdev);
-
-			hci_req_init(&req, hdev);
+	BT_DBG("%s", req->hdev->name);
 
-			memset(&cp, 0, sizeof(cp));
-			memcpy(&cp.lap, lap, sizeof(cp.lap));
-			cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
-			hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	hci_dev_lock(req->hdev);
+	hci_inquiry_cache_flush(req->hdev);
+	hci_dev_unlock(req->hdev);
 
-			err = hci_req_run(&req, inquiry_complete);
-			if (err) {
-				BT_ERR("Inquiry request failed: err %d", err);
-				hci_discovery_set_state(hdev,
-							DISCOVERY_STOPPED);
-			}
-		}
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, sizeof(cp.lap));
+	cp.length = length;
 
-		hci_dev_unlock(hdev);
-		break;
-	}
-}
+	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
 
-static int le_scan_disable(struct hci_request *req, unsigned long opt)
-{
-	hci_req_add_le_scan_disable(req);
 	return 0;
 }
 
@@ -949,17 +897,57 @@ static void le_scan_disable_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    le_scan_disable.work);
 	u8 status;
-	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		return;
+
 	cancel_delayed_work(&hdev->le_scan_restart);
 
-	err = hci_req_sync(hdev, le_scan_disable, 0, HCI_CMD_TIMEOUT, &status);
-	if (err)
+	hci_req_sync(hdev, le_scan_disable, 0, HCI_CMD_TIMEOUT, &status);
+	if (status) {
+		BT_ERR("Failed to disable LE scan: status 0x%02x", status);
+		return;
+	}
+
+	hdev->discovery.scan_start = 0;
+
+	/* If we were running LE only scan, change discovery state. If
+	 * we were running both LE and BR/EDR inquiry simultaneously,
+	 * and BR/EDR inquiry is already finished, stop discovery,
+	 * otherwise BR/EDR inquiry will stop discovery when finished.
+	 * If we will resolve remote device name, do not change
+	 * discovery state.
+	 */
+
+	if (hdev->discovery.type == DISCOV_TYPE_LE)
+		goto discov_stopped;
+
+	if (hdev->discovery.type != DISCOV_TYPE_INTERLEAVED)
+		return;
+
+	if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks)) {
+		if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
+		    hdev->discovery.state != DISCOVERY_RESOLVING)
+			goto discov_stopped;
+
 		return;
+	}
+
+	hci_req_sync(hdev, bredr_inquiry, DISCOV_INTERLEAVED_INQUIRY_LEN,
+		     HCI_CMD_TIMEOUT, &status);
+	if (status) {
+		BT_ERR("Inquiry failed: status 0x%02x", status);
+		goto discov_stopped;
+	}
+
+	return;
 
-	le_scan_disable_work_complete(hdev, status);
+discov_stopped:
+	hci_dev_lock(hdev);
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	hci_dev_unlock(hdev);
 }
 
 static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
@@ -1042,28 +1030,6 @@ static void le_scan_restart_work(struct work_struct *work)
 	le_scan_restart_work_complete(hdev, status);
 }
 
-static int bredr_inquiry(struct hci_request *req, unsigned long opt)
-{
-	u8 length = opt;
-	struct hci_cp_inquiry cp;
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-
-	BT_DBG("%s", req->hdev->name);
-
-	hci_dev_lock(req->hdev);
-	hci_inquiry_cache_flush(req->hdev);
-	hci_dev_unlock(req->hdev);
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, sizeof(cp.lap));
-	cp.length = length;
-
-	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
-	return 0;
-}
-
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
-- 
2.5.0

