Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/13] Bluetooth: Remove stop discovery handling from hci_event.c
Date: Tue, 30 Apr 2013 02:44:59 -0300
Message-Id: <1367300704-703-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
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
index faaf1f3..27f66dc 100644
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
 
@@ -966,12 +958,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
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
1.8.2.1

