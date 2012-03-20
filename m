Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [RFC 1/4] Bluetooth: Add Periodic Inquiry command complete handler
Date: Mon, 19 Mar 2012 23:32:49 -0300
Message-Id: <1332210772-13806-2-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a handler function to Periodic Inquiry command
complete event.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 include/net/bluetooth/hci.h |    2 ++
 net/bluetooth/hci_event.c   |   11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dbbb593..d74645e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -324,6 +324,8 @@ struct hci_cp_inquiry {
 
 #define HCI_OP_INQUIRY_CANCEL		0x0402
 
+#define HCI_OP_PERIODIC_INQ		0x0403
+
 #define HCI_OP_EXIT_PERIODIC_INQ	0x0404
 
 #define HCI_OP_CREATE_CONN		0x0405
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 04d39f4..af0c5a2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -70,6 +70,13 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_check_pending(hdev);
 }
 
+static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+}
+
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2154,6 +2161,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_inquiry_cancel(hdev, skb);
 		break;
 
+	case HCI_OP_PERIODIC_INQ:
+		hci_cc_periodic_inq(hdev, skb);
+		break;
+
 	case HCI_OP_EXIT_PERIODIC_INQ:
 		hci_cc_exit_periodic_inq(hdev, skb);
 		break;
-- 
1.7.9.4

