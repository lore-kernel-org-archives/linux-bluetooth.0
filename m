Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/17] Bluetooth: Remove stop discovery handling from hci_event.c
Date: Thu,  4 Apr 2013 20:21:09 -0300
Message-Id: <1365117675-2202-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since all mgmt stop discovery command complete events are now handled
in stop_discovery_complete callback in mgmt.c, we can remove this
handling from hci_event.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc42acb..6f5fb41 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -40,21 +40,13 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (status) {
-		hci_dev_lock(hdev);
-		mgmt_stop_discovery_failed(hdev, status);
-		hci_dev_unlock(hdev);
+	if (status)
 		return;
-	}
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 	smp_mb__after_clear_bit(); /* wake_up_bit advises about this barrier */
 	wake_up_bit(&hdev->flags, HCI_INQUIRY);
 
-	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-	hci_dev_unlock(hdev);
-
 	hci_conn_check_pending(hdev);
 }
 
@@ -970,12 +962,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCAN_DISABLE:
-		if (status) {
-			hci_dev_lock(hdev);
-			mgmt_stop_discovery_failed(hdev, status);
-			hci_dev_unlock(hdev);
+		if (status)
 			return;
-		}
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 		break;
-- 
1.8.1.2

