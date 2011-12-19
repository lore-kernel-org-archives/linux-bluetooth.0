Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
Date: Mon, 19 Dec 2011 16:14:18 +0200
Message-Id: <1324304058-18944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code readable by removing magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_event.c   |   12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2e48d32..c019b27 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -800,6 +800,9 @@ struct hci_cp_le_set_scan_param {
 	__u8    filter_policy;
 } __packed;
 
+#define LE_SCANNING_DISABLED		0x00
+#define LE_SCANNING_ENABLED		0x01
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc5338f..4275816 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1030,7 +1030,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	if (cp->enable == 0x01) {
+	switch (cp->enable) {
+	case LE_SCANNING_ENABLED:
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
@@ -1038,12 +1039,19 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
-	} else if (cp->enable == 0x00) {
+		break;
+
+	case LE_SCANNING_DISABLED:
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
 		queue_delayed_work(hdev->workqueue, &hdev->adv_work,
 						 jiffies + ADV_CLEAR_TIMEOUT);
+		break;
+
+	default:
+		BT_ERR("Used reserved LE_Scan_Enable param %d", cp->enable);
+		break;
 	}
 }
 
-- 
1.7.4.1

