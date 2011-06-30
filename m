Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 2/5] Bluetooth: Write LE Host Supported command
Date: Thu, 30 Jun 2011 19:20:53 -0300
Message-Id: <1309472456-24674-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a handler to Write LE Host Supported command complete
events. Once this commands has completed successfully, we should
read the extended LMP features and update the extfeatures field in
hci_dev.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    6 ++++++
 net/bluetooth/hci_event.c   |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 741a2d6..ed1de1b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -654,6 +654,12 @@ struct hci_rp_read_local_oob_data {
 
 #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
 
+#define HCI_OP_WRITE_LE_HOST_SUPPORTED	0x0c6d
+struct hci_cp_write_le_host_supported {
+	__u8 le;
+	__u8 simul;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 93d528c..4ed59a8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -915,6 +915,21 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
+static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_cp_read_local_ext_features cp;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp.page = 0x01;
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp), &cp);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1921,6 +1936,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_le_ltk_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
+		hci_cc_write_le_host_supported(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
-- 
1.7.4.1

