Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 1/3] Bluetooth: Move Service Discovery logic before refactoring
Date: Tue,  3 Mar 2015 10:16:51 -0800
Message-Id: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves whole packet filering logic of service discovery
into single place. It's done in preparation to simplify this logic.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 183 +++++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 87 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e4635a..0a7f23e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7300,21 +7300,100 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
-	/* When using service discovery with a RSSI threshold, then check
-	 * if such a RSSI threshold is specified. If a RSSI threshold has
-	 * been specified, and HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set,
-	 * then all results with a RSSI smaller than the RSSI threshold will be
-	 * dropped. If the quirk is set, let it through for further processing,
-	 * as we might need to restart the scan.
-	 *
-	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
-	 * the results are also dropped.
-	 */
-	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    (rssi == HCI_RSSI_INVALID ||
-	    (rssi < hdev->discovery.rssi &&
-	     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
-		return;
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID ||
+	    hdev->discovery.uuid_count > 0) {
+		/* We are using service discovery */
+
+		/* If a RSSI threshold has been specified, and
+		 * HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set, then all
+		 * results with a RSSI smaller than the RSSI threshold will be
+		 * dropped. If the quirk is set, let it through for further
+		 * processing, as we might need to restart the scan.
+		 *
+		 * For BR/EDR devices (pre 1.2) providing no RSSI during
+		 * inquiry, the results are also dropped.
+		 */
+		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+		    (rssi == HCI_RSSI_INVALID ||
+		    (rssi < hdev->discovery.rssi &&
+		     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+			       &hdev->quirks))))
+			return;
+
+		if (eir_len > 0) {
+			/* When using service discovery and a list of UUID is
+			 * provided, results with no matching UUID should be
+			 * dropped. In case there is a match the result is
+			 * kept and checking possible scan response data
+			 * will be skipped.
+			 */
+			if (hdev->discovery.uuid_count > 0) {
+				match = eir_has_uuids(eir, eir_len,
+						      hdev->discovery.uuid_count,
+						      hdev->discovery.uuids);
+				/* If duplicate filtering does not report RSSI
+				 * changes, then restart scanning to ensure
+				 * updated result with updated RSSI values.
+				 */
+				if (match && test_bit(
+					      HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+					      &hdev->quirks))
+					restart_le_scan(hdev);
+			} else {
+				match = true;
+			}
+
+			if (!match && !scan_rsp_len)
+				return;
+		} else {
+			/* When using service discovery and a list of UUID is
+			 * provided, results with empty EIR or advertising data
+			 * should be dropped since they do not match any UUID.
+			 */
+			if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
+				return;
+
+			match = false;
+		}
+
+		if (scan_rsp_len > 0) {
+			/* When using service discovery and a list of UUID is
+			 * provided, results with no matching UUID should be
+			 * dropped if there is no previous match from the
+			 * advertising data.
+			 */
+			if (hdev->discovery.uuid_count > 0) {
+				if (!match &&
+				    !eir_has_uuids(scan_rsp, scan_rsp_len,
+						   hdev->discovery.uuid_count,
+						   hdev->discovery.uuids))
+					return;
+
+				/* If duplicate filtering does not report RSSI
+				 * changes, then restart scanning to ensure
+				 * updated result with updated RSSI values.
+				 */
+				if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+					     &hdev->quirks))
+					restart_le_scan(hdev);
+			}
+		} else {
+			/* When using service discovery and a list of UUID is
+			 * provided, results with empty scan response and no
+			 * previous matched advertising data should be dropped.
+			 */
+			if (hdev->discovery.uuid_count > 0 && !match)
+				return;
+		}
+
+		/* Validate the reported RSSI value against the RSSI threshold
+		 * once more incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a
+		 * restart of LE scanning.
+		 */
+		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+		    rssi < hdev->discovery.rssi)
+			return;
+	}
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
 	 * are for the potential CoD field.
@@ -7341,87 +7420,17 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->rssi = rssi;
 	ev->flags = cpu_to_le32(flags);
 
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
-			return;
-
+	if (eir_len > 0)
 		/* Copy EIR or advertising data into event */
 		memcpy(ev->eir, eir, eir_len);
-	} else {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with empty EIR or advertising data
-		 * should be dropped since they do not match any UUID.
-		 */
-		if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
-			return;
-
-		match = false;
-	}
 
 	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
 					  dev_class, 3);
 
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
-				return;
-
-			/* If duplicate filtering does not report RSSI changes,
-			 * then restart scanning to ensure updated result with
-			 * updated RSSI values.
-			 */
-			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-				     &hdev->quirks))
-				restart_le_scan(hdev);
-		}
-
+	if (scan_rsp_len > 0)
 		/* Append scan response data to event */
 		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
-	} else {
-		/* When using service discovery and a list of UUID is
-		 * provided, results with empty scan response and no
-		 * previous matched advertising data should be dropped.
-		 */
-		if (hdev->discovery.uuid_count > 0 && !match)
-			return;
-	}
-
-	/* Validate the reported RSSI value against the RSSI threshold once more
-	 * incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a restart of LE
-	 * scanning.
-	 */
-	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    rssi < hdev->discovery.rssi)
-		return;
 
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
-- 
2.2.0.rc0.207.ga3a616c

