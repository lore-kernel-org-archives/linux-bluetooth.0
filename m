Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC v2 1/6] Bluetooth: Implement advertising report meta event
Date: Fri, 11 Mar 2011 10:32:52 -0300
Message-Id: <1299850377-3734-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements new LE meta event in order to handle advertising
reports.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h |   18 ++++++++++++++++++
 net/bluetooth/hci_event.c   |   21 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d851f8b..de27caa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1011,6 +1011,24 @@ struct hci_ev_le_conn_complete {
 	__u8     clk_accurancy;
 } __packed;
 
+#define ADV_IND		0x00
+#define ADV_DIRECT_IND	0x01
+#define ADV_SCAN_IND	0x02
+#define ADV_NONCONN_IND	0x03
+#define ADV_SCAN_RSP	0x04
+
+#define ADDR_LE_DEV_PUBLIC	0x00
+#define ADDR_LE_DEV_RANDOM	0x01
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
index 5a2ab2c..55502ac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2556,6 +2556,23 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_ev_le_advertising_info *ev;
+	u8 num_reports;
+
+	num_reports = skb->data[0];
+	ev = (void *) &skb->data[1];
+
+	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+
+	while (--num_reports) {
+		ev = (void *) (ev->data + ev->length + 1);
+		BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+	}
+}
+
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2571,6 +2588,10 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_ltk_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_ADVERTISING_REPORT:
+		hci_le_adv_report_evt(hdev, skb);
+		break;
+
 	default:
 		break;
 	}
-- 
1.7.1

