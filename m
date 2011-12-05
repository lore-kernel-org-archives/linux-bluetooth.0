Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
Date: Mon,  5 Dec 2011 11:26:15 +0200
Message-Id: <1323077175-26299-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code readable by removing magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_event.c   |   14 ++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 67ad984..5f8af41 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -791,6 +791,9 @@ struct hci_cp_le_set_scan_param {
 	__u8    filter_policy;
 } __packed;
 
+#define LE_SCANNING_DISABLED		0x00
+#define LE_SCANNING_ENABLED		0x01
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35cb56e..447071a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1014,18 +1014,24 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	if (cp->enable == 0x01) {
+	switch (cp->enable) {
+	case LE_SCANNING_ENABLED:
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
-
 		del_timer(&hdev->adv_timer);
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
-	} else if (cp->enable == 0x00) {
-		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		break;
 
+	case LE_SCANNING_DISABLED:
+		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+		break;
+
+	default:
+		BT_ERR("Used reserved LE_Scan_Enable param %d", cp->enable);
+		break;
 	}
 }
 
-- 
1.7.4.1

