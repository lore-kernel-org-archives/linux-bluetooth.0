Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 1/4] Bluetooth: hci_cc_le_set_scan_enable() critical region
Date: Tue,  9 Aug 2011 19:52:37 -0300
Message-Id: <1312930360-30860-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
References: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reduces the critial region (protected by hdev->lock) in
hci_cc_le_set_scan_enable(). This way, only really needed code is
protected.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 55872ff..9910f81 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -894,23 +894,24 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	hci_dev_lock(hdev);
-
 	if (cp->enable == 0x01) {
 		if (status) {
 			mgmt_start_discovery_failed(hdev->id,
 							bt_to_errno(status));
-			goto unlock;
+			return;
 		}
 
 		set_bit(HCI_LE_SCAN, &hdev->flags);
 
 		del_timer(&hdev->adv_timer);
+
+		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
+		hci_dev_unlock(hdev);
 
 		if (mgmt_has_pending_stop_discov(hdev->id)) {
 			mgmt_cancel_discovery(hdev->id);
-			goto unlock;
+			return;
 		}
 
 		if (!mgmt_is_interleaved_discovery(hdev->id))
@@ -924,7 +925,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				mgmt_start_discovery_failed(hdev->id,
 							bt_to_errno(status));
 
-			goto unlock;
+			return;
 		}
 
 		clear_bit(HCI_LE_SCAN, &hdev->flags);
@@ -933,14 +934,14 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		mgmt_discovering(hdev->id, 0);
 
-		if (mgmt_has_pending_stop_discov(hdev->id))
+		if (mgmt_has_pending_stop_discov(hdev->id)) {
 			mgmt_stop_discovery_complete(hdev->id);
-		else
+		} else {
+			hci_dev_lock(hdev);
 			mgmt_start_discovery_complete(hdev->id);
+			hci_dev_unlock(hdev);
+		}
 	}
-
-unlock:
-	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.5.2

