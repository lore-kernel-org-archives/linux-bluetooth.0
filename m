Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v4 05/13] Bluetooth: Handle extended ADV PDU types
Date: Wed, 11 Jul 2018 15:01:27 +0530
Message-Id: <1531301495-14479-6-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch defines the extended ADV types and handle it in ADV report.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h |  8 ++++++++
 net/bluetooth/hci_event.c   | 49 +++++++++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3584632..fcd1d57 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1977,6 +1977,14 @@ struct hci_ev_le_conn_complete {
 #define LE_LEGACY_SCAN_RSP_ADV		0x001b
 #define LE_LEGACY_SCAN_RSP_ADV_SCAN	0x001a
 
+/* Extended Advertising event types */
+#define LE_EXT_ADV_NON_CONN_IND		0x0000
+#define LE_EXT_ADV_CONN_IND		0x0001
+#define LE_EXT_ADV_SCAN_IND		0x0002
+#define LE_EXT_ADV_DIRECT_IND		0x0004
+#define LE_EXT_ADV_SCAN_RSP		0x0008
+#define LE_EXT_ADV_LEGACY_PDU		0x0010
+
 #define ADDR_LE_DEV_PUBLIC	0x00
 #define ADDR_LE_DEV_RANDOM	0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6942315..027abe6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5137,20 +5137,39 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static u8 convert_legacy_evt_type(u16 evt_type)
-{
-	switch (evt_type) {
-	case LE_LEGACY_ADV_IND:
-		return LE_ADV_IND;
-	case LE_LEGACY_ADV_DIRECT_IND:
-		return LE_ADV_DIRECT_IND;
-	case LE_LEGACY_ADV_SCAN_IND:
-		return LE_ADV_SCAN_IND;
-	case LE_LEGACY_NONCONN_IND:
-		return LE_ADV_NONCONN_IND;
-	case LE_LEGACY_SCAN_RSP_ADV:
-	case LE_LEGACY_SCAN_RSP_ADV_SCAN:
-		return LE_ADV_SCAN_RSP;
+static u8 convert_ext_evt_type(u16 evt_type)
+{
+	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
+		switch (evt_type) {
+		case LE_LEGACY_ADV_IND:
+			return LE_ADV_IND;
+		case LE_LEGACY_ADV_DIRECT_IND:
+			return LE_ADV_DIRECT_IND;
+		case LE_LEGACY_ADV_SCAN_IND:
+			return LE_ADV_SCAN_IND;
+		case LE_LEGACY_NONCONN_IND:
+			return LE_ADV_NONCONN_IND;
+		case LE_LEGACY_SCAN_RSP_ADV:
+		case LE_LEGACY_SCAN_RSP_ADV_SCAN:
+			return LE_ADV_SCAN_RSP;
+		}
+	} else {
+		if (evt_type & LE_EXT_ADV_CONN_IND) {
+			if (evt_type & LE_EXT_ADV_DIRECT_IND)
+				return LE_ADV_DIRECT_IND;
+
+			return LE_ADV_IND;
+		}
+
+		if (evt_type & LE_EXT_ADV_SCAN_RSP)
+			return LE_ADV_SCAN_RSP;
+
+		if (evt_type & LE_EXT_ADV_SCAN_IND)
+			return LE_ADV_SCAN_IND;
+
+		if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
+		    evt_type & LE_EXT_ADV_DIRECT_IND)
+			return LE_ADV_NONCONN_IND;
 	}
 
 	BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
@@ -5172,7 +5191,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		u16 evt_type;
 
 		evt_type = __le16_to_cpu(ev->evt_type);
-		legacy_evt_type = convert_legacy_evt_type(evt_type);
+		legacy_evt_type = convert_ext_evt_type(evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
 					   ev->bdaddr_type, NULL, 0, ev->rssi,
-- 
2.7.4
