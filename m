Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Only report LE scan responses with data content
Date: Fri, 21 Mar 2014 22:57:42 -0700
Message-Id: <1395467862-29120-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE scan response advertising report does not contain any
advertising data, then do not report it as device found event.

All LE scan response advertising reports will be only send with a
previous directed or undirected advertising report. Such a report
is enough to discovery new devices. So an empty LE scan response
advertising is of no value since it would just repeat an already
known address and RSSI value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9ee081b9c064..7e3b1b2559d5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3945,7 +3945,6 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
-	s8 rssi;
 
 	hci_dev_lock(hdev);
 
@@ -3957,9 +3956,12 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			check_pending_le_conn(hdev, &ev->bdaddr,
 					      ev->bdaddr_type);
 
-		rssi = ev->data[ev->length];
-		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
-				  NULL, rssi, 0, 1, ev->data, ev->length);
+		if (ev->evt_type != LE_ADV_SCAN_RSP || ev->length > 0) {
+			s8 rssi = ev->data[ev->length];
+			mgmt_device_found(hdev, &ev->bdaddr, LE_LINK,
+					  ev->bdaddr_type, NULL, rssi,
+					  0, 1, ev->data, ev->length);
+		}
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
-- 
1.8.5.3

