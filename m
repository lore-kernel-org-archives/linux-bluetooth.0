Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 1/5] Bluetooth: Implement advertising report meta event
Date: Mon, 14 Feb 2011 18:59:56 -0300
Message-Id: <4d59a5ff.859ddc0a.46cb.5143@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements new LE meta event in order to handle advertising
reports.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h |   18 ++++++++++++++++++
 net/bluetooth/hci_event.c   |   22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 46438f4..5180555 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -980,6 +980,24 @@ struct hci_ev_le_conn_complete {
 	__u8     clk_accurancy;
 } __packed;
 
+#define ADV_IND		0x00
+#define ADV_DIRECT_IND	0x01
+#define ADV_SCAN_IND	0x02
+#define ADV_NONCONN_IND	0x03
+#define SCAN_RSP	0x04
+
+#define ADDR_DEV_PUBLIC	0x00
+#define ADDR_DEV_RANDOM	0x01
+
+#define HCI_EV_LE_ADVERTISING_REPORT	0x02
+struct hci_ev_le_advertising_info {
+	__u8	 evt_type;
+	__u8	 bdaddr_type;
+	bdaddr_t bdaddr;
+	__u8	 length;
+	__u8	 data[0];
+} __packed;
+
 #define HCI_EV_LE_LTK_REQ		0x05
 struct hci_ev_le_ltk_req {
 	__le16	handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 99c75f4..987f5de 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2498,6 +2498,25 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_ev_le_advertising_info *ev;
+	u8 num_reports, i;
+
+	num_reports = (u8) skb->data[0];
+
+	ev = (struct hci_ev_le_advertising_info *) (skb->data + 1);
+
+	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+
+	for (i = 1; i < num_reports; i++) {
+		ev = (struct hci_ev_le_advertising_info *)
+					(ev->data + ev->length + 1);
+		BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+	}
+}
+
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2513,6 +2532,9 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_ltk_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_ADVERTISING_REPORT:
+		hci_le_adv_report_evt(hdev, skb);
+
 	default:
 		break;
 	}
-- 
1.7.1

