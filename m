Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/17] Bluetooth: Remove start discovery handling from hci_event.c
Date: Thu,  4 Apr 2013 20:21:05 -0300
Message-Id: <1365117675-2202-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since all mgmt start discovery command complete events are now handled
in start_discovery_complete callback in mgmt.c, we can remove this
handling from hci_event.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5daf37f..6f78a8c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -947,12 +947,6 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (status) {
-		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
-		hci_dev_unlock(hdev);
-		return;
-	}
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -969,18 +963,10 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	switch (cp->enable) {
 	case LE_SCAN_ENABLE:
-		if (status) {
-			hci_dev_lock(hdev);
-			mgmt_start_discovery_failed(hdev, status);
-			hci_dev_unlock(hdev);
+		if (status)
 			return;
-		}
 
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
-
-		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-		hci_dev_unlock(hdev);
 		break;
 
 	case LE_SCAN_DISABLE:
@@ -1081,18 +1067,10 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		hci_conn_check_pending(hdev);
-		hci_dev_lock(hdev);
-		if (test_bit(HCI_MGMT, &hdev->dev_flags))
-			mgmt_start_discovery_failed(hdev, status);
-		hci_dev_unlock(hdev);
 		return;
 	}
 
 	set_bit(HCI_INQUIRY, &hdev->flags);
-
-	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-	hci_dev_unlock(hdev);
 }
 
 static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
-- 
1.8.1.2

