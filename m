Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add support for reading LE supported states
Date: Tue, 22 Jan 2013 14:02:01 +0200
Message-Id: <1358856121-1928-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE supported states indicate the states and state combinations that
the link layer supports. This is important information for knowing what
operations are possible when dealing with multiple connected devices.
This patch adds reading of the supported states to the HCI init
sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    6 ++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f1766a6..7f12c25f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1045,6 +1045,12 @@ struct hci_rp_le_ltk_neg_reply {
 	__le16	handle;
 } __packed;
 
+#define HCI_OP_LE_READ_SUPPORTED_STATES	0x201c
+struct hci_rp_le_read_supported_states {
+	__u8	status;
+	__u8	le_states[8];
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d6ed4ac..bcf8ffe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -154,6 +154,7 @@ struct hci_dev {
 	__u8		host_features[8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d2fee64..d4fcba6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -617,6 +617,9 @@ static void le_setup(struct hci_dev *hdev)
 
 	/* Read LE White List Size */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
+
+	/* Read LE Supported States */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
 }
 
 static void hci_setup(struct hci_dev *hdev)
@@ -1346,6 +1349,19 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
+static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	struct hci_rp_le_read_supported_states *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (!rp->status)
+		memcpy(hdev->le_states, rp->le_states, 8);
+
+	hci_req_complete(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, rp->status);
+}
+
 static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -2712,6 +2728,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_ltk_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_SUPPORTED_STATES:
+		hci_cc_le_read_supported_states(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
-- 
1.7.10.4

