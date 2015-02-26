Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 2/3] Bluetooth: Add simultaenous dual mode scan
Date: Wed, 25 Feb 2015 18:14:18 -0800
Message-Id: <1424916859-14473-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1424916859-14473-1-git-send-email-jpawlowski@google.com>
References: <1424916859-14473-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When doing scan through mgmt api, some controllers can do both le and
classic scan at same time. They can be distinguished by
HCI_QUIRK_SIMULTAENOUS_DISCOVERY set.

This patch enables them to use this feature when doing dual mode scan.
Instead of doing le, then classic scan, both scans are run at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_core.c  | 26 +++++++++++++++++------
 net/bluetooth/hci_event.c | 18 ++++++++++++++--
 net/bluetooth/mgmt.c      | 54 +++++++++++++++++++++++++++++++----------------
 3 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbd26bc..c4f2316 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2866,12 +2866,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 
 		hci_dev_lock(hdev);
 
-		hci_inquiry_cache_flush(hdev);
-
-		err = hci_req_run(&req, inquiry_complete);
-		if (err) {
-			BT_ERR("Inquiry request failed: err %d", err);
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		if (!test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY,
+			      &hdev->quirks)) {
+			hci_inquiry_cache_flush(hdev);
+
+			err = hci_req_run(&req, inquiry_complete);
+			if (err) {
+				BT_ERR("Inquiry request failed: err %d", err);
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
+			}
+		} else {
+			/* If we were running le only scan, change discovery
+			 * state. If we were running both le and classic scans
+			 * simultaenously, and classic is already finished,
+			 * stop discovery, otherwise  classic scan will stop
+			 * discovery when finished.
+			 */
+			if (!test_bit(HCI_INQUIRY, &hdev->flags))
+				hci_discovery_set_state(hdev,
+							DISCOVERY_STOPPED);
 		}
 
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e9b17b5..d69de31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2127,7 +2127,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 
 	if (list_empty(&discov->resolve)) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running classic discovery change discovery state.
+		 * If we were running both le and classic scans simultaenously,
+		 * and le is already finished, change state, otherwise le
+		 * scan will stop discovery when finished.
+		 */
+		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
+		    !test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
 
@@ -2136,7 +2143,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
 	} else {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running classic discovery change discovery state.
+		 * If we were running both le and classic scans simultaenously,
+		 * and le is already finished, change state, otherwise le
+		 * scan will stop discovery when finished.
+		 */
+		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
+		    !test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
 unlock:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d5d46e7..b0df917 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3783,34 +3783,43 @@ done:
 	return err;
 }
 
-static bool trigger_discovery(struct hci_request *req, u8 *status)
+static bool trigger_classic_discovery(struct hci_request *req, u8 *status)
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
+static bool trigger_discovery(struct hci_request *req, u8 *status)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
 	u8 own_addr_type;
 	int err;
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		*status = mgmt_bredr_support(hdev);
-		if (*status)
-			return false;
-
-		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			*status = MGMT_STATUS_BUSY;
+		if (!trigger_classic_discovery(req, status))
 			return false;
-		}
-
-		hci_inquiry_cache_flush(hdev);
-
-		memset(&inq_cp, 0, sizeof(inq_cp));
-		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
-		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
-		hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
 		break;
 
 	case DISCOV_TYPE_LE:
@@ -3870,6 +3879,11 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 			    &enable_cp);
+
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
+			if (!trigger_classic_discovery(req, status))
+				return false;
 		break;
 
 	default:
@@ -3914,7 +3928,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
 		break;
 	case DISCOV_TYPE_INTERLEAVED:
-		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
+		if (test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
+			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+		else
+			timeout = msecs_to_jiffies(
+					     hdev->discov_interleaved_timeout);
 		break;
 	case DISCOV_TYPE_BREDR:
 		timeout = 0;
-- 
2.2.0.rc0.207.ga3a616c

