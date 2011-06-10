Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 15/16] Bluetooth: Support LE-Only discovery procedure
Date: Fri, 10 Jun 2011 16:36:12 -0300
Message-Id: <1307734573-1630-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for LE-Only discovery procedure through
management interface.

A new flag (HCI_LE_SCAN) was created to inform if the controller is
performing LE scan. The HCI_LE_SCAN flag is set/cleared when the
controller starts/stops scanning.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    2 +
 net/bluetooth/hci_event.c   |   47 ++++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c        |    5 ++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c92a4cc..7e82b2c 100644
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
index fa6e6f7..709c3e1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -840,6 +840,17 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 						rp->randomizer, rp->status);
 }
 
+/* hdev must be locked */
+static inline void disable_le_scan(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0;
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -848,9 +859,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
@@ -858,12 +866,45 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->enable == 0x01) {
+		if (status) {
+			mgmt_start_discovery_failed(hdev->id);
+			goto unlock;
+		}
+
+		set_bit(HCI_LE_SCAN, &hdev->flags);
+
 		del_timer(&hdev->adv_timer);
 		hci_adv_entries_clear(hdev);
+
+		if (mgmt_has_pending_stop_discov(hdev->id)) {
+			disable_le_scan(hdev);
+			goto unlock;
+		}
+
+		mgmt_discovering(hdev->id, 1);
 	} else if (cp->enable == 0x00) {
+		if (status) {
+			if (mgmt_has_pending_stop_discov(hdev->id))
+				mgmt_stop_discovery_failed(hdev->id);
+			else
+				mgmt_start_discovery_failed(hdev->id);
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
index 9e60416..c780367 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,6 +40,7 @@ enum bt_device_type {
 };
 
 #define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
+#define LE_ONLY_SCAN_TIMEOUT 10240 /* TGAP(gen_disc_scan_min) */
 
 struct pending_cmd {
 	struct list_head list;
@@ -1713,6 +1714,8 @@ static int start_discovery(struct sock *sk, u16 index)
 		err = do_inquiry(hdev, BREDR_ONLY_INQ_LENGTH);
 		break;
 	case LE_ONLY:
+		err = do_le_scan(hdev, LE_ONLY_SCAN_TIMEOUT);
+		break;
 	case BREDR_LE:
 		err = -ENOSYS;
 		break;
@@ -1777,6 +1780,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		err = cancel_inquiry(hdev);
+	else if (test_bit(HCI_LE_SCAN, &hdev->flags))
+		err = cancel_le_scan(hdev);
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.4.1

