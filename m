Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/3] Bluetooth: Move Service Discovery logic before refactoring
Date: Wed,  4 Mar 2015 16:24:24 -0800
Message-Id: <1425515066-28323-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves whole packet filering logic of service discovery
into new function is_filter_match. It's done because logic inside
mgmt_device_found is very complicated and needs some
simplification.

Also having whole logic in one place will allow to simplify it in
the future.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 141 +++++++++++++++++++++++++++++----------------------
 1 file changed, 79 insertions(+), 62 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e4635a..a41a5ef 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7280,32 +7280,16 @@ static void restart_le_scan(struct hci_dev *hdev)
 			   DISCOV_LE_RESTART_DELAY);
 }
 
-void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
-		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
+static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
+			    u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
 {
-	char buf[512];
-	struct mgmt_ev_device_found *ev = (void *) buf;
-	size_t ev_size;
 	bool match;
 
-	/* Don't send events for a non-kernel initiated discovery. With
-	 * LE one exception is if we have pend_le_reports > 0 in which
-	 * case we're doing passive scanning and want these events.
-	 */
-	if (!hci_discovery_active(hdev)) {
-		if (link_type == ACL_LINK)
-			return;
-		if (link_type == LE_LINK && list_empty(&hdev->pend_le_reports))
-			return;
-	}
-
-	/* When using service discovery with a RSSI threshold, then check
-	 * if such a RSSI threshold is specified. If a RSSI threshold has
-	 * been specified, and HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set,
-	 * then all results with a RSSI smaller than the RSSI threshold will be
-	 * dropped. If the quirk is set, let it through for further processing,
-	 * as we might need to restart the scan.
+	/* If a RSSI threshold has been specified, and
+	 * HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set, then all results with
+	 * a RSSI smaller than the RSSI threshold will be dropped. If the quirk
+	 * is set, let it through for further processing, as we might need to
+	 * restart the scan.
 	 *
 	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
 	 * the results are also dropped.
@@ -7314,32 +7298,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	    (rssi == HCI_RSSI_INVALID ||
 	    (rssi < hdev->discovery.rssi &&
 	     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
-		return;
-
-	/* Make sure that the buffer is big enough. The 5 extra bytes
-	 * are for the potential CoD field.
-	 */
-	if (sizeof(*ev) + eir_len + scan_rsp_len + 5 > sizeof(buf))
-		return;
-
-	memset(buf, 0, sizeof(buf));
-
-	/* In case of device discovery with BR/EDR devices (pre 1.2), the
-	 * RSSI value was reported as 0 when not available. This behavior
-	 * is kept when using device discovery. This is required for full
-	 * backwards compatibility with the API.
-	 *
-	 * However when using service discovery, the value 127 will be
-	 * returned when the RSSI is not available.
-	 */
-	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi &&
-	    link_type == ACL_LINK)
-		rssi = 0;
+		return  false;
 
-	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_bdaddr(link_type, addr_type);
-	ev->rssi = rssi;
-	ev->flags = cpu_to_le32(flags);
 
 	if (eir_len > 0) {
 		/* When using service discovery and a list of UUID is
@@ -7364,25 +7324,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		}
 
 		if (!match && !scan_rsp_len)
-			return;
-
-		/* Copy EIR or advertising data into event */
-		memcpy(ev->eir, eir, eir_len);
+			return  false;
 	} else {
 		/* When using service discovery and a list of UUID is
 		 * provided, results with empty EIR or advertising data
 		 * should be dropped since they do not match any UUID.
 		 */
 		if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
-			return;
+			return  false;
 
 		match = false;
 	}
 
-	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
-		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
-					  dev_class, 3);
-
 	if (scan_rsp_len > 0) {
 		/* When using service discovery and a list of UUID is
 		 * provided, results with no matching UUID should be
@@ -7393,7 +7346,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			if (!match && !eir_has_uuids(scan_rsp, scan_rsp_len,
 						     hdev->discovery.uuid_count,
 						     hdev->discovery.uuids))
-				return;
+				return  false;
 
 			/* If duplicate filtering does not report RSSI changes,
 			 * then restart scanning to ensure updated result with
@@ -7403,16 +7356,13 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 				     &hdev->quirks))
 				restart_le_scan(hdev);
 		}
-
-		/* Append scan response data to event */
-		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
 	} else {
 		/* When using service discovery and a list of UUID is
 		 * provided, results with empty scan response and no
 		 * previous matched advertising data should be dropped.
 		 */
 		if (hdev->discovery.uuid_count > 0 && !match)
-			return;
+			return  false;
 	}
 
 	/* Validate the reported RSSI value against the RSSI threshold once more
@@ -7421,8 +7371,75 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	 */
 	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
 	    rssi < hdev->discovery.rssi)
+		return  false;
+
+	return true;
+}
+
+void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
+{
+	char buf[512];
+	struct mgmt_ev_device_found *ev = (void *)buf;
+	size_t ev_size;
+
+	/* Don't send events for a non-kernel initiated discovery. With
+	 * LE one exception is if we have pend_le_reports > 0 in which
+	 * case we're doing passive scanning and want these events.
+	 */
+	if (!hci_discovery_active(hdev)) {
+		if (link_type == ACL_LINK)
+			return;
+		if (link_type == LE_LINK && list_empty(&hdev->pend_le_reports))
+			return;
+	}
+
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID ||
+	    hdev->discovery.uuid_count > 0) {
+		/* We are using service discovery */
+		if (!is_filter_match(hdev, rssi, eir, eir_len, scan_rsp,
+				     scan_rsp_len))
+			return;
+	}
+
+	/* Make sure that the buffer is big enough. The 5 extra bytes
+	 * are for the potential CoD field.
+	 */
+	if (sizeof(*ev) + eir_len + scan_rsp_len + 5 > sizeof(buf))
 		return;
 
+	memset(buf, 0, sizeof(buf));
+
+	/* In case of device discovery with BR/EDR devices (pre 1.2), the
+	 * RSSI value was reported as 0 when not available. This behavior
+	 * is kept when using device discovery. This is required for full
+	 * backwards compatibility with the API.
+	 *
+	 * However when using service discovery, the value 127 will be
+	 * returned when the RSSI is not available.
+	 */
+	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi &&
+	    link_type == ACL_LINK)
+		rssi = 0;
+
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_bdaddr(link_type, addr_type);
+	ev->rssi = rssi;
+	ev->flags = cpu_to_le32(flags);
+
+	if (eir_len > 0)
+		/* Copy EIR or advertising data into event */
+		memcpy(ev->eir, eir, eir_len);
+
+	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
+		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
+					  dev_class, 3);
+
+	if (scan_rsp_len > 0)
+		/* Append scan response data to event */
+		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
+
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-- 
2.2.0.rc0.207.ga3a616c

