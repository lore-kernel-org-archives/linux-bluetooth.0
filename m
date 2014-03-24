Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Refactor advertising report processing into its own function
Date: Mon, 24 Mar 2014 10:48:00 +0200
Message-Id: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation for merging ADV_IND/ADV_SCAN_IND and SCAN_RSP together
into a single mgmt Device Found event refactor individual advertising
report handling into a separate function. This will help keep the code
more readable as more logic gets added.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9ee081b9c064..43872af20aa4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3941,25 +3941,30 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	}
 }
 
+static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
+			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
+{
+	if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
+		check_pending_le_conn(hdev, bdaddr, bdaddr_type);
+
+	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
+			  data, len);
+}
+
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
-	s8 rssi;
 
 	hci_dev_lock(hdev);
 
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
-
-		if (ev->evt_type == LE_ADV_IND ||
-		    ev->evt_type == LE_ADV_DIRECT_IND)
-			check_pending_le_conn(hdev, &ev->bdaddr,
-					      ev->bdaddr_type);
+		s8 rssi;
 
 		rssi = ev->data[ev->length];
-		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
-				  NULL, rssi, 0, 1, ev->data, ev->length);
+		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
+				   ev->bdaddr_type, rssi, ev->data, ev->length);
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
-- 
1.8.5.3

