Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
Date: Wed, 30 Nov 2011 16:17:10 +0200
Message-Id: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code readable by removing magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_event.c   |   12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b0a801b..a913001 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -821,6 +821,9 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define LE_SCANNING_DISABLED		0x00
+#define LE_SCANNING_ENABLED		0x01
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fa66d88..65ca922 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1011,14 +1011,22 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	if (cp->enable == 0x01) {
+	switch (cp->enable) {
+	case LE_SCANNING_ENABLED:
 		del_timer(&hdev->adv_timer);
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
-	} else if (cp->enable == 0x00) {
+		break;
+
+	case LE_SCANNING_DISABLED:
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

