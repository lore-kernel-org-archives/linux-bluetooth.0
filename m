Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 2/3] Bluetooth: Refactor service discovery filter logic
Date: Tue,  3 Mar 2015 10:16:52 -0800
Message-Id: <1425406613-21420-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
References: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch refactor code responsible for filtering when service
discovery method is used.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 95 ++++++++++++++--------------------------------------
 1 file changed, 26 insertions(+), 69 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0a7f23e..896ace7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7287,7 +7287,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
-	bool match;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -7320,79 +7319,37 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			       &hdev->quirks))))
 			return;
 
-		if (eir_len > 0) {
-			/* When using service discovery and a list of UUID is
-			 * provided, results with no matching UUID should be
-			 * dropped. In case there is a match the result is
-			 * kept and checking possible scan response data
-			 * will be skipped.
-			 */
-			if (hdev->discovery.uuid_count > 0) {
-				match = eir_has_uuids(eir, eir_len,
-						      hdev->discovery.uuid_count,
-						      hdev->discovery.uuids);
-				/* If duplicate filtering does not report RSSI
-				 * changes, then restart scanning to ensure
-				 * updated result with updated RSSI values.
-				 */
-				if (match && test_bit(
-					      HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-					      &hdev->quirks))
-					restart_le_scan(hdev);
-			} else {
-				match = true;
-			}
-
-			if (!match && !scan_rsp_len)
-				return;
-		} else {
-			/* When using service discovery and a list of UUID is
-			 * provided, results with empty EIR or advertising data
-			 * should be dropped since they do not match any UUID.
-			 */
-			if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
-				return;
+		/* If a list of UUID is provided, results with no matching UUID
+		 * should be dropped. If list of UUID is not provided, treat
+		 * all devices as matches.
+		 * Empty UUID filter might be a result of merging filters
+		 * somewhere in highter layer, and should behave same as when
+		 * we have UUID match.
+		 */
+		if (hdev->discovery.uuid_count != 0 &&
+		    (eir_len == 0 || !eir_has_uuids(eir, eir_len,
+				  hdev->discovery.uuid_count,
+				  hdev->discovery.uuids)) &&
+		    (scan_rsp_len == 0 || !eir_has_uuids(scan_rsp, scan_rsp_len,
+				  hdev->discovery.uuid_count,
+				  hdev->discovery.uuids)))
+			return;
 
-			match = false;
-		}
+		/* If duplicate filtering does not report RSSI changes,
+		 * then restart scanning to ensure updated result with
+		 * updated RSSI values.
+		 */
+		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+			     &hdev->quirks)) {
+			restart_le_scan(hdev);
 
-		if (scan_rsp_len > 0) {
-			/* When using service discovery and a list of UUID is
-			 * provided, results with no matching UUID should be
-			 * dropped if there is no previous match from the
-			 * advertising data.
-			 */
-			if (hdev->discovery.uuid_count > 0) {
-				if (!match &&
-				    !eir_has_uuids(scan_rsp, scan_rsp_len,
-						   hdev->discovery.uuid_count,
-						   hdev->discovery.uuids))
-					return;
-
-				/* If duplicate filtering does not report RSSI
-				 * changes, then restart scanning to ensure
-				 * updated result with updated RSSI values.
-				 */
-				if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-					     &hdev->quirks))
-					restart_le_scan(hdev);
-			}
-		} else {
-			/* When using service discovery and a list of UUID is
-			 * provided, results with empty scan response and no
-			 * previous matched advertising data should be dropped.
+			/* Validate the reported RSSI value against the
+			 * RSSI threshold once more.
 			 */
-			if (hdev->discovery.uuid_count > 0 && !match)
+			if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+			    rssi < hdev->discovery.rssi)
 				return;
 		}
-
-		/* Validate the reported RSSI value against the RSSI threshold
-		 * once more incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a
-		 * restart of LE scanning.
-		 */
-		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-		    rssi < hdev->discovery.rssi)
-			return;
 	}
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
-- 
2.2.0.rc0.207.ga3a616c

