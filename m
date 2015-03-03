Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 3/3] Bluetooth: fix service discovery behaviour for empty uuids filter
Date: Tue,  3 Mar 2015 10:16:53 -0800
Message-Id: <1425406613-21420-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
References: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes service discovery behaviour, when provided uuid filter
is empty and HCI_QUIRK_STRICT_DUPLICATE_FILTER is set. Before this
patch, empty uuid filter was unable to trigger scan restart, and that
caused inconsistent behaviour in applications.

Example: two DBus clients call BlueZ, one to find all devices with
service abcd, second to find all devices with rssi smaller than -90.
Sum of those filters, that is passed to mgmt_service_scan is empty
filter, with no rssi or uuids set.
That caused kernel not to restart scan when quirk was set.
That was inconsistent with what happen when there's only one of those
two filters set (scan is restarted and reports devices).

To fix that, new variable hdev->discovery.result_filtering was
introduced. It can indicate that filtered scan is running, no matter
what uuid or rssi filter is set.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/mgmt.c             | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index acec914..15c761c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -76,6 +76,7 @@ struct discovery_state {
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
 	bool			report_invalid_rssi;
+	bool			result_filtering;
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
@@ -525,6 +526,7 @@ static inline void discovery_init(struct hci_dev *hdev)
 
 static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 {
+	hdev->discovery.result_filtering = false;
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 	hdev->discovery.uuid_count = 0;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 896ace7..0590bfe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3933,8 +3933,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		 */
 		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
 			     &hdev->quirks) &&
-		    (hdev->discovery.uuid_count > 0 ||
-		     hdev->discovery.rssi != HCI_RSSI_INVALID)) {
+		    hdev->discovery.result_filtering) {
 			hdev->discovery.scan_start = jiffies;
 			hdev->discovery.scan_duration = timeout;
 		}
@@ -4087,6 +4086,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	 */
 	hci_discovery_filter_clear(hdev);
 
+	hdev->discovery.result_filtering = true;
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
 	hdev->discovery.uuid_count = uuid_count;
@@ -7299,8 +7299,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
-	if (hdev->discovery.rssi != HCI_RSSI_INVALID ||
-	    hdev->discovery.uuid_count > 0) {
+	if (hdev->discovery.result_filtering) {
 		/* We are using service discovery */
 
 		/* If a RSSI threshold has been specified, and
-- 
2.2.0.rc0.207.ga3a616c

