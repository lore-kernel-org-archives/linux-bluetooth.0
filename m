Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH v3 3/9] Bluetooth: Add Advertising Report Meta Event handler
Date: Thu, 26 May 2011 16:23:51 -0300
Message-Id: <1306437837-18263-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function to handle LE Advertising Report Meta
Events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/hci_event.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f13ddbf..458caac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2680,6 +2680,28 @@ unlock:
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
+	ev = (void *) &skb->data[1];
+
+	hci_dev_lock(hdev);
+
+	hci_add_adv_entry(hdev, ev);
+
+	while (--num_reports) {
+		ev = (void *) (ev->data + ev->length + RSSI_SIZE);
+		hci_add_adv_entry(hdev, ev);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2691,6 +2713,10 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
1.7.4.1

