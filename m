Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/14] Bluetooth: Remove start discovery handling from hci_event.c
Date: Tue, 30 Apr 2013 15:29:29 -0300
Message-Id: <1367346580-6647-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since all mgmt start discovery command complete events are now handled
in start_discovery_complete callback in mgmt.c, we can remove this
handling from hci_event.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b93cd2e..0e71e6c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -943,12 +943,6 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (status) {
-		hci_dev_lock(hdev);
-		mgmt_start_discovery_failed(hdev, status);
-		hci_dev_unlock(hdev);
-		return;
-	}
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -965,18 +959,10 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
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
@@ -1077,18 +1063,10 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
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
1.8.2.1

