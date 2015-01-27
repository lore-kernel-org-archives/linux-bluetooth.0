Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v11 2/2] Bluetooth: Add restarting to service discovery
Date: Mon, 26 Jan 2015 18:18:58 -0800
Message-Id: <1422325138-20113-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1422325138-20113-1-git-send-email-jpawlowski@google.com>
References: <1422325138-20113-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using LE_SCAN_FILTER_DUP_ENABLE, some controllers would send
advertising report from each LE device only once. That means that we
don't get any updates on RSSI value, and makes Service Discovery very
slow. This patch adds restarting scan when in Service Discovery, and
device with filtered uuid is found, but it's not in RSSI range to send
event yet. This way if device moves into range, we will quickly get RSSI
update.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 53 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6261679..538fe38 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1330,6 +1330,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
+#define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2012163..93d5e18 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7217,6 +7217,21 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 	return false;
 }
 
+static void restart_le_scan(struct hci_dev *hdev)
+{
+	/* If controller is not scanning we are done. */
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	if (time_after(jiffies + DISCOV_LE_RESTART_DELAY,
+		       hdev->discovery.scan_start +
+		       hdev->discovery.scan_duration))
+		return;
+
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+			   DISCOV_LE_RESTART_DELAY);
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -7239,14 +7254,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	/* When using service discovery with a RSSI threshold, then check
 	 * if such a RSSI threshold is specified. If a RSSI threshold has
-	 * been specified, then all results with a RSSI smaller than the
-	 * RSSI threshold will be dropped.
+	 * been specified, and HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set,
+	 * then all results with a RSSI smaller than the RSSI threshold will be
+	 * dropped. If the quirk is set, let it through for further processing,
+	 * as we might need to restart the scan.
 	 *
 	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
 	 * the results are also dropped.
 	 */
 	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
+	    (rssi == HCI_RSSI_INVALID ||
+	    (rssi < hdev->discovery.rssi &&
+	     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
 		return;
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
@@ -7281,12 +7300,20 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		 * kept and checking possible scan response data
 		 * will be skipped.
 		 */
-		if (hdev->discovery.uuid_count > 0)
+		if (hdev->discovery.uuid_count > 0) {
 			match = eir_has_uuids(eir, eir_len,
 					      hdev->discovery.uuid_count,
 					      hdev->discovery.uuids);
-		else
+			/* If duplicate filtering does not report RSSI changes,
+			 * then restart scanning to ensure updated result with
+			 * updated RSSI values.
+			 */
+			if (match && test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+					      &hdev->quirks))
+				restart_le_scan(hdev);
+		} else {
 			match = true;
+		}
 
 		if (!match && !scan_rsp_len)
 			return;
@@ -7319,6 +7346,14 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						     hdev->discovery.uuid_count,
 						     hdev->discovery.uuids))
 				return;
+
+			/* If duplicate filtering does not report RSSI changes,
+			 * then restart scanning to ensure updated result with
+			 * updated RSSI values.
+			 */
+			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+				     &hdev->quirks))
+				restart_le_scan(hdev);
 		}
 
 		/* Append scan response data to event */
@@ -7332,6 +7367,14 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
+	/* Validate the reported RSSI value against the RSSI threshold once more
+	 * incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a restart of LE
+	 * scanning.
+	 */
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+	    rssi < hdev->discovery.rssi)
+		return;
+
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-- 
2.2.0.rc0.207.ga3a616c

