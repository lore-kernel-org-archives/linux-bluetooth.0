Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v7 2/2] Bluetooth: Add restarting to service discovery
Date: Fri,  9 Jan 2015 05:46:16 -0800
Message-Id: <1420811176-31658-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
References: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
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
 net/bluetooth/mgmt.c             | 43 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index add94f6..86c1bd7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1327,6 +1327,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
+#define DISCOV_LE_RESTART_DELAY		200	/* msec */
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f295cd..6c6a50a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7165,6 +7165,16 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 	return false;
 }
 
+static void restart_le_scan(struct hci_dev *hdev)
+{
+	/* If controller is not scanning we are done. */
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+			   msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -7194,7 +7204,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	 * the results are also dropped.
 	 */
 	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
+	    (rssi == HCI_RSSI_INVALID || (rssi < hdev->discovery.rssi &&
+	    !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
 		return;
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
@@ -7228,12 +7239,20 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		 * kept and checking possible scan response data
 		 * will be skipped.
 		 */
-		if (hdev->discovery.uuid_count > 0)
+		if (hdev->discovery.uuid_count > 0) {
 			match = eir_has_uuids(eir, eir_len,
 					      hdev->discovery.uuid_count,
 					      hdev->discovery.uuids);
-		else
+			/* we have service match. If duplicate filtering doesn't
+			 * honour RSSI hanges, restart scan to make sure we'll
+			 * get RSSI updates
+			 */
+			if (match && test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+					      &hdev->quirks))
+				restart_le_scan(hdev);
+		} else {
 			match = true;
+		}
 
 		if (!match && !scan_rsp_len)
 			return;
@@ -7266,7 +7285,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						     hdev->discovery.uuid_count,
 						     hdev->discovery.uuids))
 				return;
-		}
+
+			/* we have service match. If duplicate filtering doesn't
+			 * honour RSSI hanges, restart scan to make sure we'll
+			 * get RSSI updates
+			 */
+			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+				     &hdev->quirks))
+				restart_le_scan(hdev);
+			}
 
 		/* Append scan response data to event */
 		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
@@ -7279,6 +7306,14 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
+	/* Check again wether RSSI value doesn't meet Service Discovery
+	 * threshold. This might evaluate to true only if
+	 * HCI_QUIRK_STRICT_DUPLICATE_FILTER is set.
+	 */
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+	    rssi < hdev->discovery.rssi)
+		return;
+
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-- 
2.2.0.rc0.207.ga3a616c

