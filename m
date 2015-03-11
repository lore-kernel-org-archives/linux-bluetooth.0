Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 2/5] Bluetooth: Add simultaneous dual mode scan
Date: Tue, 10 Mar 2015 22:53:34 -0700
Message-Id: <1426053217-9011-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426053217-9011-1-git-send-email-jpawlowski@google.com>
References: <1426053217-9011-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When doing scan through mgmt api, some controllers can do both le and
classic scan at same time. They can be distinguished by
HCI_QUIRK_SIMULTANEOUS_DISCOVERY set.

This patch enables them to use this feature when doing dual mode scan.
Instead of doing le, then classic scan, both scans are run at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_core.c  |  24 +++++--
 net/bluetooth/hci_event.c |  18 ++++-
 net/bluetooth/mgmt.c      | 172 ++++++++++++++++++++++++++++------------------
 3 files changed, 142 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a35d844..1103f5d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2893,12 +2893,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 
 		hci_dev_lock(hdev);
 
-		hci_inquiry_cache_flush(hdev);
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			/* If we were running le only scan, change discovery
+			 * state. If we were running both le and classic scans
+			 * simultaneously, and classic is already finished,
+			 * stop discovery, otherwise  classic scan will stop
+			 * discovery when finished.
+			 */
+			if (!test_bit(HCI_INQUIRY, &hdev->flags))
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
+		} else {
+			hci_inquiry_cache_flush(hdev);
 
-		err = hci_req_run(&req, inquiry_complete);
-		if (err) {
-			BT_ERR("Inquiry request failed: err %d", err);
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			err = hci_req_run(&req, inquiry_complete);
+			if (err) {
+				BT_ERR("Inquiry request failed: err %d", err);
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
+			}
 		}
 
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39653d4..ec69bdd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2127,7 +2127,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 
 	if (list_empty(&discov->resolve)) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running BR/EDR inquiry change discovery state.
+		 * If we were running both BR/EDR inquiry and LE scan
+		 * simultaneously, and LE is already finished, change state,
+		 * otherwise LE scan will stop discovery when finished.
+		 */
+		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
 
@@ -2136,7 +2143,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
 	} else {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running classic discovery change discovery state.
+		 * If we were running both le and classic scans simultaneously,
+		 * and le is already finished, change state, otherwise le
+		 * scan will stop discovery when finished.
+		 */
+		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
 unlock:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 600636c..070780e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1304,7 +1304,9 @@ static bool hci_stop_discovery(struct hci_request *req)
 	case DISCOVERY_FINDING:
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		} else {
+		}
+
+		if (test_bit(HCI_LE_SCAN, &hdev->flags)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
 			hci_req_add_le_scan_disable(req);
 		}
@@ -3820,93 +3822,125 @@ done:
 	return err;
 }
 
-static bool trigger_discovery(struct hci_request *req, u8 *status)
+static bool trigger_bredr_inquiry(struct hci_request *req, u8 *status)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_cp_inquiry inq_cp;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+
+	*status = mgmt_bredr_support(hdev);
+	if (*status)
+		return false;
+
+	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		*status = MGMT_STATUS_BUSY;
+		return false;
+	}
+
+	hci_inquiry_cache_flush(hdev);
+
+	memset(&inq_cp, 0, sizeof(inq_cp));
+	memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
+	inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
+	hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
+	return true;
+}
+
+static bool trigger_le_scan(struct hci_request *req, u8 *status,
+			    __le16 interval)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
 	u8 own_addr_type;
 	int err;
 
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_BREDR:
-		*status = mgmt_bredr_support(hdev);
-		if (*status)
-			return false;
+	*status = mgmt_le_support(hdev);
+	if (*status)
+		return false;
 
-		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			*status = MGMT_STATUS_BUSY;
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+		/* Don't let discovery abort an outgoing connection attempt
+		 * that's using directed advertising.
+		 */
+		if (hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+			*status = MGMT_STATUS_REJECTED;
 			return false;
 		}
 
-		hci_inquiry_cache_flush(hdev);
+		disable_advertising(req);
+	}
 
-		memset(&inq_cp, 0, sizeof(inq_cp));
-		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
-		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
-		hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
-		break;
+	/* If controller is scanning, it means the background scanning is
+	 * running. Thus, we should temporarily stop it in order to set the
+	 * discovery scanning parameters.
+	 */
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		hci_req_add_le_scan_disable(req);
 
-	case DISCOV_TYPE_LE:
-	case DISCOV_TYPE_INTERLEAVED:
-		*status = mgmt_le_support(hdev);
-		if (*status)
+	memset(&param_cp, 0, sizeof(param_cp));
+
+	/* All active scans will be done with either a resolvable private
+	 * address (when privacy feature has been enabled) or non-resolvable
+	 * private address.
+	 */
+	err = hci_update_random_address(req, true, &own_addr_type);
+	if (err < 0) {
+		*status = MGMT_STATUS_FAILED;
+		return false;
+	}
+
+	param_cp.type = LE_SCAN_ACTIVE;
+	param_cp.interval = interval;
+	param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
+	param_cp.own_address_type = own_addr_type;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+
+	return true;
+}
+
+static bool trigger_discovery(struct hci_request *req, u8 *status)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_BREDR:
+		if (!trigger_bredr_inquiry(req, status))
 			return false;
+		break;
 
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			*status = MGMT_STATUS_NOT_SUPPORTED;
+	case DISCOV_TYPE_LE:
+		if (!trigger_le_scan(req, status,
+				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
 			return false;
-		}
+		break;
 
-		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
-			/* Don't let discovery abort an outgoing
-			 * connection attempt that's using directed
-			 * advertising.
-			 */
-			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
-						       BT_CONNECT)) {
-				*status = MGMT_STATUS_REJECTED;
+	case DISCOV_TYPE_INTERLEAVED:
+		if (!test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			      &hdev->quirks)) {
+			if (!trigger_le_scan(req, status,
+					     cpu_to_le16(DISCOV_LE_SCAN_INT)))
 				return false;
-			}
-
-			disable_advertising(req);
+			return true;
 		}
 
-		/* If controller is scanning, it means the background scanning
-		 * is running. Thus, we should temporarily stop it in order to
-		 * set the discovery scanning parameters.
+		/* During simultaneous scan, we double scan interval. We must
+		 * leave some time to do BR/EDR scan.
 		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			hci_req_add_le_scan_disable(req);
-
-		memset(&param_cp, 0, sizeof(param_cp));
+		if (!trigger_le_scan(req, status,
+				     cpu_to_le16(DISCOV_LE_SCAN_INT * 2)))
+				return false;
 
-		/* All active scans will be done with either a resolvable
-		 * private address (when privacy feature has been enabled)
-		 * or non-resolvable private address.
-		 */
-		err = hci_update_random_address(req, true, &own_addr_type);
-		if (err < 0) {
-			*status = MGMT_STATUS_FAILED;
+		if (!trigger_bredr_inquiry(req, status))
 			return false;
-		}
-
-		param_cp.type = LE_SCAN_ACTIVE;
-		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
-		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-		param_cp.own_address_type = own_addr_type;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-			    &param_cp);
-
-		memset(&enable_cp, 0, sizeof(enable_cp));
-		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-			    &enable_cp);
 		break;
 
 	default:
@@ -3951,7 +3985,15 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
 		break;
 	case DISCOV_TYPE_INTERLEAVED:
-		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
+		/* if we're doing simultaneous discovery, LE scan should last
+		 * whole time. If we do interleaved scan, LE scan last only half
+		 * of that (BR/EDR inquiry takes rest of time).
+		 */
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+		else
+			timeout = msecs_to_jiffies(
+					     hdev->discov_interleaved_timeout);
 		break;
 	case DISCOV_TYPE_BREDR:
 		timeout = 0;
-- 
2.2.0.rc0.207.ga3a616c

