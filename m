Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/17] Bluetooth: Remove empty event handler
Date: Thu,  4 Apr 2013 20:21:13 -0300
Message-Id: <1365117675-2202-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the hci_cc_le_set_scan_param event handler. This
handler became empty because failures of this event are now handled
by start_discovery_complete function in mgmt.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb28ea9..93c26cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -933,14 +933,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2293,10 +2285,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
1.8.1.2

