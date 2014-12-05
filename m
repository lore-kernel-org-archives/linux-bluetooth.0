Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [RFC v4 2/2] Bluetooth: Add restarting to service discovery
Date: Fri,  5 Dec 2014 15:43:25 -0800
Message-Id: <1417823005-10262-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1417823005-10262-1-git-send-email-jpawlowski@google.com>
References: <1417823005-10262-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using LE_SCAN_FILTER_DUP_ENABLE, controllers would send
advertising report from each LE device only once. That means that we
don't get any updates on RSSI value, and makes Service Discovery very
slow. This patch adds restarting scan when in Service Discovery, and
device with filtered uuid is found, but it's not in RSSI range to send
event yet. This way if device moves into range, we will quickly get RSSI
update.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 34 ++++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 53e7975..96cf380 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1353,6 +1353,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
+#define DISCOV_LE_RESTART_DELAY		200	/* msec */
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a91e484..d40e253 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6983,6 +6983,12 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 	return false;
 }
 
+static void restart_le_scan(struct hci_dev *hdev)
+{
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+			   msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -7003,18 +7009,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
-	/* When using service discovery with a RSSI threshold, then check
-	 * if such a RSSI threshold is specified. If a RSSI threshold has
-	 * been specified, then all results with a RSSI smaller than the
-	 * RSSI threshold will be dropped.
-	 *
-	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
-	 * the results are also dropped.
-	 */
-	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
-		return;
-
 	/* Make sure that the buffer is big enough. The 5 extra bytes
 	 * are for the potential CoD field.
 	 */
@@ -7052,6 +7046,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					      hdev->discovery.uuids);
 			if (!match)
 				return;
+
+			restart_le_scan(hdev);
 		}
 
 		/* Copy EIR or advertising data into event */
@@ -7080,6 +7076,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						     hdev->discovery.uuid_count,
 						     hdev->discovery.uuids))
 				return;
+
+			restart_le_scan(hdev);
 		}
 
 		/* Append scan response data to event */
@@ -7093,6 +7091,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
+	/* When using service discovery with a RSSI threshold, then check
+	 * if such a RSSI threshold is specified. If a RSSI threshold has
+	 * been specified, then all results with a RSSI smaller than the
+	 * RSSI threshold will be dropped.
+	 *
+	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
+	 * the results are also dropped.
+	 */
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
+		return;
+
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-- 
2.2.0.rc0.207.ga3a616c

