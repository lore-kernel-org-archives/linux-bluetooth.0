Return-Path: <cmcvista@gmail.com>
From: Chriz Chow <cmcvista@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@codecoup.pl>
Cc: Chriz Chow <chriz.chow@aminocom.com>
Subject: [PATCH v2] Bluetooth: Prevent buffer overflow for large advertisement data
Date: Fri, 20 Apr 2018 15:46:24 +0800
Message-Id: <1524210384-19845-1-git-send-email-chriz.chow@aminocom.com>
In-Reply-To: <1646173.KpzMEjoeCb@ix>
References: <1646173.KpzMEjoeCb@ix>
List-ID: <linux-bluetooth.vger.kernel.org>

There are some controllers sending out advertising data with illegal
length value which is longer than HCI_MAX_AD_LENGTH, causing the
buffer last_adv_data overflows. To avoid these controllers from
overflowing the buffer, we do not process the advertisement data
if its length is incorrect.

Signed-off-by: Chriz Chow <chriz.chow@aminocom.com>
---
 net/bluetooth/hci_event.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 139707c..dc4cfd5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4942,10 +4942,14 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		struct hci_ev_le_advertising_info *ev = ptr;
 		s8 rssi;
 
-		rssi = ev->data[ev->length];
-		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, NULL, 0, rssi,
-				   ev->data, ev->length);
+		if (ev->length <= HCI_MAX_AD_LENGTH) {
+			rssi = ev->data[ev->length];
+			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
+					   ev->bdaddr_type, NULL, 0, rssi,
+					   ev->data, ev->length);
+		} else {
+			BT_ERR("Dropped invalid adv data");
+		}
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
-- 
2.7.4
