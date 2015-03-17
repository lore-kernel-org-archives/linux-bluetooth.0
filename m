Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 4/7] Bluetooth: Add simultaneous dual mode scan
Date: Mon, 16 Mar 2015 18:37:31 -0700
Message-Id: <1426556254-1480-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When doing scan through mgmt api, some controllers can do both le and
classic scan at same time. They can be distinguished by
HCI_QUIRK_SIMULTANEOUS_DISCOVERY set.

This patch enables them to use this feature when doing dual mode scan.
Instead of doing le, then classic scan, both scans are run at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_core.c  | 24 +++++++++++++++++++-----
 net/bluetooth/hci_event.c | 18 ++++++++++++++++--
 net/bluetooth/mgmt.c      | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 750d344..3d51bf7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2902,12 +2902,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 
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
index d800f0c..4a3cc58 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2126,7 +2126,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 
 	if (list_empty(&discov->resolve)) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running BR/EDR inquiry change discovery state.
+		 * If we were running both BR/EDR inquiry and LE scan
+		 * simultaneously, and LE is already finished, change state,
+		 * otherwise LE scan will stop discovery when finished.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
 
@@ -2135,7 +2142,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
 	} else {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* if we were running classic discovery change discovery state.
+		 * If we were running both le and classic scans simultaneously,
+		 * and le is already finished, change state, otherwise le
+		 * scan will stop discovery when finished.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
 unlock:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9d3c7a1..ef4db8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1402,7 +1402,9 @@ static bool hci_stop_discovery(struct hci_request *req)
 	case DISCOVERY_FINDING:
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		} else {
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
 			hci_req_add_le_scan_disable(req);
 		}
@@ -4015,13 +4017,27 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
-			*status = MGMT_STATUS_NOT_SUPPORTED;
-			return false;
+		if (!test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			      &hdev->quirks)) {
+			if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
+				*status = MGMT_STATUS_NOT_SUPPORTED;
+				return false;
+			}
+
+			if (!trigger_le_scan(req, status,
+					     cpu_to_le16(DISCOV_LE_SCAN_INT)))
+				return false;
+			return true;
 		}
 
+		/* During simultaneous scan, we double scan interval. We must
+		 * leave some time to do BR/EDR scan.
+		 */
 		if (!trigger_le_scan(req, status,
-				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
+				     cpu_to_le16(DISCOV_LE_SCAN_INT * 2)))
+			return false;
+
+		if (!trigger_bredr_inquiry(req, status))
 			return false;
 		break;
 
@@ -4067,7 +4083,15 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
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

