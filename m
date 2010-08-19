Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH v2] Bluetooth: Implement LE Set Advertise Enable cmd
Date: Thu, 19 Aug 2010 11:42:38 -0400
Message-Id: <1282232558-14472-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements LE Set Advertise Enable command for dual mode and
Low Energy hci controllers. It also adds new HCI flags in order to
indicate the Advertising state for userland applications and kernel
itself.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h |    6 ++++++
 net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bcbdd6d..cae1816 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -76,6 +76,7 @@ enum {
 	HCI_INQUIRY,
 
 	HCI_RAW,
+	HCI_LE_ADV,
 };
 
 /* HCI ioctl defines */
@@ -593,6 +594,11 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __packed;
 
+/* --- HCI LE Commands --- */
+#define HCI_OP_LE_SET_ADVERTISE_ENABLE	0x200a
+	#define ADVERTISE_ENABLED	0x01
+	#define ADVERTISE_DISABLED	0x00
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bfef5ba..c86c655 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -822,6 +822,29 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_advertise(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	void *sent;
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADVERTISE_ENABLE);
+	if (!sent)
+		return;
+
+	if (!status) {
+		__u8 param = *((__u8 *) sent);
+
+		clear_bit(HCI_LE_ADV, &hdev->flags);
+
+		if (param & ADVERTISE_ENABLED)
+			set_bit(HCI_LE_ADV, &hdev->flags);
+	}
+
+	hci_req_complete(hdev, status);
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1310,6 +1333,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADVERTISE_ENABLE:
+		hci_cc_le_set_advertise(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
-- 
1.7.0.4

