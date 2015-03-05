Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 2/3] Bluetooth: Refactor service discovery filter logic
Date: Wed,  4 Mar 2015 16:24:25 -0800
Message-Id: <1425515066-28323-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1425515066-28323-1-git-send-email-jpawlowski@google.com>
References: <1425515066-28323-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch refactor code responsible for filtering when service
discovery method is used. Previously this code was mixed with
mgmt_device found logic. Now when it's in one place whole logic can
be greatly simplified. That includes removing no longer necessary
length field and merging checks for eir and scan_rsp.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 89 +++++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 70 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a41a5ef..bc09c5a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7283,8 +7283,6 @@ static void restart_le_scan(struct hci_dev *hdev)
 static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 			    u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
 {
-	bool match;
-
 	/* If a RSSI threshold has been specified, and
 	 * HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set, then all results with
 	 * a RSSI smaller than the RSSI threshold will be dropped. If the quirk
@@ -7300,78 +7298,29 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 	     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
 		return  false;
 
-
-	if (eir_len > 0) {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with no matching UUID should be
-		 * dropped. In case there is a match the result is
-		 * kept and checking possible scan response data
-		 * will be skipped.
-		 */
-		if (hdev->discovery.uuid_count > 0) {
-			match = eir_has_uuids(eir, eir_len,
-					      hdev->discovery.uuid_count,
-					      hdev->discovery.uuids);
-			/* If duplicate filtering does not report RSSI changes,
-			 * then restart scanning to ensure updated result with
-			 * updated RSSI values.
-			 */
-			if (match && test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-					      &hdev->quirks))
-				restart_le_scan(hdev);
-		} else {
-			match = true;
-		}
-
-		if (!match && !scan_rsp_len)
-			return  false;
-	} else {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with empty EIR or advertising data
-		 * should be dropped since they do not match any UUID.
-		 */
-		if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
-			return  false;
-
-		match = false;
-	}
-
-	if (scan_rsp_len > 0) {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with no matching UUID should be
-		 * dropped if there is no previous match from the
-		 * advertising data.
-		 */
-		if (hdev->discovery.uuid_count > 0) {
-			if (!match && !eir_has_uuids(scan_rsp, scan_rsp_len,
-						     hdev->discovery.uuid_count,
-						     hdev->discovery.uuids))
-				return  false;
-
-			/* If duplicate filtering does not report RSSI changes,
-			 * then restart scanning to ensure updated result with
-			 * updated RSSI values.
-			 */
-			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-				     &hdev->quirks))
-				restart_le_scan(hdev);
-		}
-	} else {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with empty scan response and no
-		 * previous matched advertising data should be dropped.
+	if (hdev->discovery.uuid_count != 0) {
+		/* If a list of UUIDs is provided in filter, results with no
+		 * matching UUID should be dropped.
 		 */
-		if (hdev->discovery.uuid_count > 0 && !match)
-			return  false;
+		if (!eir_has_uuids(eir, eir_len, hdev->discovery.uuid_count,
+				   hdev->discovery.uuids) &&
+		    !eir_has_uuids(scan_rsp, scan_rsp_len,
+				   hdev->discovery.uuid_count,
+				   hdev->discovery.uuids))
+			return false;
 	}
 
-	/* Validate the reported RSSI value against the RSSI threshold once more
-	 * incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a restart of LE
-	 * scanning.
+	/* If duplicate filtering does not report RSSI changes, then restart
+	 * scanning to ensure updated result with updated RSSI values.
 	 */
-	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    rssi < hdev->discovery.rssi)
-		return  false;
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)) {
+		restart_le_scan(hdev);
+
+		/* Validate RSSI value against the RSSI threshold once more. */
+		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+		    rssi < hdev->discovery.rssi)
+			return false;
+	}
 
 	return true;
 }
-- 
2.2.0.rc0.207.ga3a616c

