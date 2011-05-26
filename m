Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v3 4/9] Bluetooth: Clear advertising cache before scanning
Date: Thu, 26 May 2011 16:23:52 -0300
Message-Id: <1306437837-18263-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE advertising cache should be cleared before performing a LE
scanning. This will force the cache to contain only fresh advertising
entries.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    6 ++++++
 net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ec0fb2d..ed1a0d1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -710,6 +710,12 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
+struct hci_cp_le_set_scan_enable {
+	__u8     enable;
+	__u8     filter_dup;
+} __packed;
+
 #define HCI_OP_LE_CREATE_CONN		0x200d
 struct hci_cp_le_create_conn {
 	__le16   scan_interval;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 458caac..556c38a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -839,6 +839,29 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 						rp->randomizer, rp->status);
 }
 
+static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_cp_le_set_scan_enable *cp;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (cp->enable == 0x01)
+		hci_adv_entries_clear(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1814,6 +1837,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_user_confirm_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_SCAN_ENABLE:
+		hci_cc_le_set_scan_enable(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
-- 
1.7.4.1

