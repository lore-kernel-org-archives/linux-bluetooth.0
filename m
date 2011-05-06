Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 04/12] Bluetooth: Add advertising report meta event handler
Date: Fri,  6 May 2011 14:05:13 -0300
Message-Id: <1304701521-26459-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch adds a function to handle LE Advertising Report Meta
Events.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d5aa97e..3fb36bc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2677,6 +2677,24 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	const u8 RSSI_SIZE = 1;
+	struct hci_ev_le_advertising_info *ev;
+	u8 num_reports;
+
+	num_reports = skb->data[0];
+
+	ev = (void *) &skb->data[1];
+	hci_add_adv_entry(hdev, ev);
+
+	while (--num_reports) {
+		ev = (void *) (ev->data + ev->length + RSSI_SIZE);
+		hci_add_adv_entry(hdev, ev);
+	}
+}
+
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2688,6 +2706,10 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_conn_complete_evt(hdev, skb);
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

