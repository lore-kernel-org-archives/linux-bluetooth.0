Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 3/6] Bluetooth: Add simultaneous dual mode scan
Date: Tue, 17 Mar 2015 09:04:14 -0700
Message-Id: <1426608257-20332-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
References: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
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
 net/bluetooth/hci_event.c | 22 ++++++++++++++++++++--
 net/bluetooth/mgmt.c      | 34 +++++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 750d344..773f216 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2902,12 +2902,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 
 		hci_dev_lock(hdev);
 
-		hci_inquiry_cache_flush(hdev);
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			/* If we were running LE only scan, change discovery
+			 * state. If we were running both LE and BR/EDR inquiry
+			 * simultaneously, and BR/EDR inquiry is already
+			 * finished, stop discovery, otherwise BR/EDR inquiry
+			 * will stop discovery when finished.
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
index d800f0c..62f92a5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2126,7 +2126,16 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 
 	if (list_empty(&discov->resolve)) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* When BR/EDR inquiry is active and no LE scanning is in
+		 * progress, then change discovery state to indicate completion.
+		 *
+		 * When running LE scanning and BR/EDR inquiry simultaneously
+		 * and the LE scan already finished, then change the discovery
+		 * state to indicate completion.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
 
@@ -2135,7 +2144,16 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
 	} else {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		/* When BR/EDR inquiry is active and no LE scanning is in
+		 * progress, then change discovery state to indicate completion.
+		 *
+		 * When running LE scanning and BR/EDR inquiry simultaneously
+		 * and the LE scan already finished, then change the discovery
+		 * state to indicate completion.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
 unlock:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5a4b9d5..7bcdf61 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1408,9 +1408,10 @@ static bool hci_stop_discovery(struct hci_request *req)
 
 	switch (hdev->discovery.state) {
 	case DISCOVERY_FINDING:
-		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		if (test_bit(HCI_INQUIRY, &hdev->flags))
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		} else {
+
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
 			hci_req_add_le_scan_disable(req);
 		}
@@ -4019,6 +4020,22 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			/* During simultaneous discovery, we double LE scan
+			 * interval. We must leave some time for the controller
+			 * to do BR/EDR inquiry.
+			 */
+			if (!trigger_le_scan(req, DISCOV_LE_SCAN_INT * 2,
+					     status))
+				return false;
+
+			if (!trigger_bredr_inquiry(req, status))
+				return false;
+
+			return true;
+		}
+
 		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 			*status = MGMT_STATUS_NOT_SUPPORTED;
 			return false;
@@ -4072,7 +4089,18 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
 		break;
 	case DISCOV_TYPE_INTERLEAVED:
-		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
+		 /* When running simultaneous discovery, the LE scanning time
+		 * should occupy the whole discovery time sine BR/EDR inquiry
+		 * and LE scanning are scheduled by the controller.
+		 *
+		 * For interleaving discovery in comparison, BR/EDR inquiry
+		 * and LE scanning are done sequentially with separate
+		 * timeouts.
+		 */
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
+			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+		else
+			timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
 		break;
 	case DISCOV_TYPE_BREDR:
 		timeout = 0;
-- 
2.2.0.rc0.207.ga3a616c

