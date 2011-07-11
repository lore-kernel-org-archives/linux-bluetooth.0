Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 15/16] Bluetooth: Support LE-Only discovery procedure
Date: Mon, 11 Jul 2011 18:11:58 -0300
Message-Id: <1310418719-12296-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for LE-Only discovery procedure through
management interface.

A new flag (HCI_LE_SCAN) was created to inform if the controller is
performing LE scan. The HCI_LE_SCAN flag is set/cleared when the
controller starts/stops scanning.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    2 ++
 net/bluetooth/hci_event.c   |   39 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/mgmt.c        |    5 +++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fb40388..c4fdeeb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -86,6 +86,8 @@ enum {
 	HCI_DEBUG_KEYS,
 
 	HCI_RESET,
+
+	HCI_LE_SCAN,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4f0929..08774c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -890,9 +890,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
@@ -900,12 +897,48 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->enable == 0x01) {
+		if (status) {
+			mgmt_start_discovery_failed(hdev->id,
+							bt_to_errno(status));
+			goto unlock;
+		}
+
+		set_bit(HCI_LE_SCAN, &hdev->flags);
+
 		del_timer(&hdev->adv_timer);
 		hci_adv_entries_clear(hdev);
+
+		if (mgmt_has_pending_stop_discov(hdev->id)) {
+			mgmt_cancel_discovery(hdev->id);
+			goto unlock;
+		}
+
+		mgmt_discovering(hdev->id, 1);
 	} else if (cp->enable == 0x00) {
+		if (status) {
+			if (mgmt_has_pending_stop_discov(hdev->id))
+				mgmt_stop_discovery_failed(hdev->id,
+							bt_to_errno(status));
+			else
+				mgmt_start_discovery_failed(hdev->id,
+							bt_to_errno(status));
+
+			goto unlock;
+		}
+
+		clear_bit(HCI_LE_SCAN, &hdev->flags);
+
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+
+		mgmt_discovering(hdev->id, 0);
+
+		if (mgmt_has_pending_stop_discov(hdev->id))
+			mgmt_stop_discovery_complete(hdev->id);
+		else
+			mgmt_start_discovery_complete(hdev->id);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 01c63db8..dcfc66f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,6 +40,7 @@ enum bt_device_type {
 };
 
 #define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
+#define LE_ONLY_SCAN_TIMEOUT 10240 /* TGAP(gen_disc_scan_min) */
 
 struct pending_cmd {
 	struct list_head list;
@@ -1727,6 +1728,8 @@ static int start_discovery(struct sock *sk, u16 index)
 		err = do_inquiry(hdev, BREDR_ONLY_INQ_LENGTH);
 		break;
 	case LE_ONLY:
+		err = do_le_scan(hdev, LE_ONLY_SCAN_TIMEOUT);
+		break;
 	case BREDR_LE:
 		err = -ENOSYS;
 		break;
@@ -1765,6 +1768,8 @@ int mgmt_cancel_discovery(u16 index)
 
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		res = cancel_inquiry(hdev);
+	else if (test_bit(HCI_LE_SCAN, &hdev->flags))
+		res = cancel_le_scan(hdev);
 
 	hci_dev_put(hdev);
 
-- 
1.7.4.1

