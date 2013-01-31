Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded locking
Date: Thu, 31 Jan 2013 20:12:10 -0300
Message-Id: <1359673930-18226-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unneeded locking in hci_le_adv_report_evt. There
is no need to lock hdev before calling mgmt_device_found.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4fcba6..06e7657 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3988,8 +3988,6 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	void *ptr = &skb->data[1];
 	s8 rssi;
 
-	hci_dev_lock(hdev);
-
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
@@ -3999,8 +3997,6 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
-
-	hci_dev_unlock(hdev);
 }
 
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.1.1

