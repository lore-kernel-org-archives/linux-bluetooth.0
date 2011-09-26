Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_le_adv_report_evt code refactoring
Date: Mon, 26 Sep 2011 20:48:35 -0300
Message-Id: <1317080915-3901-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to treat the first advertising entry differently
from the potential other ones. Besides, the current implementation
can easily leads to typos.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8404cd9..570b57a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2836,19 +2836,17 @@ unlock:
 static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 						struct sk_buff *skb)
 {
-	struct hci_ev_le_advertising_info *ev;
-	u8 num_reports;
-
-	num_reports = skb->data[0];
-	ev = (void *) &skb->data[1];
+	u8 num_reports = skb->data[0];
+	void *ptr = &skb->data[1];
 
 	hci_dev_lock(hdev);
 
-	hci_add_adv_entry(hdev, ev);
+	while (num_reports--) {
+		struct hci_ev_le_advertising_info *ev = ptr;
 
-	while (--num_reports) {
-		ev = (void *) (ev->data + ev->length + 1);
 		hci_add_adv_entry(hdev, ev);
+
+		ptr += sizeof(*ev) + ev->length + 1;
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.5.2

