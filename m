Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 13/14] Bluetooth: Remove empty event handler
Date: Tue, 30 Apr 2013 15:29:39 -0300
Message-Id: <1367346580-6647-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the hci_cc_le_set_scan_param event handler. This
handler became empty because failures of this event are now handled
by start_discovery_complete function in mgmt.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 76ff1af..db58e72 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -929,14 +929,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-}
-
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
@@ -2251,10 +2243,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_user_passkey_neg_reply(hdev, skb);
 		break;
 
-	case HCI_OP_LE_SET_SCAN_PARAM:
-		hci_cc_le_set_scan_param(hdev, skb);
-		break;
-
 	case HCI_OP_LE_SET_ADV_ENABLE:
 		hci_cc_le_set_adv_enable(hdev, skb);
 		break;
-- 
1.8.2.1

