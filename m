Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for Not Connectable flag for Device Found events
Date: Tue,  1 Jul 2014 13:53:10 +0200
Message-Id: <1404215590-36797-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Device Found events of the management interface should indicate if
it is possible to connect to a remote device or if it is broadcaster
only advertising. To allow this differentation the Not Connectable flag
is introduced that will be set when it is known that a device can not
be connected.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 42 +++++++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab3d4dda071c..eb0add396595 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -71,6 +71,7 @@ struct discovery_state {
 	bdaddr_t		last_adv_addr;
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
+	u32			last_adv_flags;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
 };
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9fbcd1eade3d..f7c2f40f1eac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1089,13 +1089,15 @@ static void clear_pending_adv_report(struct hci_dev *hdev)
 }
 
 static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
+				     u8 bdaddr_type, s8 rssi, u32 flags,
+				     u8 *data, u8 len)
 {
 	struct discovery_state *d = &hdev->discovery;
 
 	bacpy(&d->last_adv_addr, bdaddr);
 	d->last_adv_addr_type = bdaddr_type;
 	d->last_adv_rssi = rssi;
+	d->last_adv_flags = flags;
 	memcpy(d->last_adv_data, data, len);
 	d->last_adv_data_len = len;
 }
@@ -1132,7 +1134,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 					  d->last_adv_addr_type, NULL,
-					  d->last_adv_rssi, 0,
+					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 		}
@@ -4209,6 +4211,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 	bool match;
+	u32 flags;
 
 	/* Passive scanning shouldn't trigger any device found events */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
@@ -4217,6 +4220,27 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
+	/* When receiving non-connectable or scannable undirected
+	 * advertising reports, this means that the remote device is
+	 * not connectable and then clearly indicate this in the
+	 * device found event.
+	 *
+	 * When receiving a scan response, then there is no way to
+	 * know if the remote device is connectable or not. However
+	 * since scan responses are merged with a previously seen
+	 * advertising report, the flags field from that report
+	 * will be used.
+	 *
+	 * In the really unlikely case that a controller get confused
+	 * and just sends a scan response event, then it is marked as
+	 * not connectable as well.
+	 */
+	if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND ||
+	    type == LE_ADV_SCAN_RSP)
+		flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
+	else
+		flags = 0;
+
 	/* If there's nothing pending either store the data from this
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
@@ -4227,12 +4251,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
-						 rssi, data, len);
+						 rssi, flags, data, len);
 			return;
 		}
 
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, 0, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0);
 		return;
 	}
 
@@ -4249,7 +4273,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (!match)
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 					  d->last_adv_addr_type, NULL,
-					  d->last_adv_rssi, 0,
+					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 
@@ -4258,7 +4282,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
-						 rssi, data, len);
+						 rssi, flags, data, len);
 			return;
 		}
 
@@ -4267,7 +4291,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		clear_pending_adv_report(hdev);
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, 0, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0);
 		return;
 	}
 
@@ -4276,8 +4300,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * sending a merged device found event.
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-			  d->last_adv_addr_type, NULL, rssi, 0, data, len,
-			  d->last_adv_data, d->last_adv_data_len);
+			  d->last_adv_addr_type, NULL, rssi, d->last_adv_flags,
+			  data, len, d->last_adv_data, d->last_adv_data_len);
 	clear_pending_adv_report(hdev);
 }
 
-- 
1.9.3

