Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add support for reading LE White List Size
Date: Tue, 22 Jan 2013 14:02:00 +0200
Message-Id: <1358856121-1928-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE White List Size is necessary to be known before attempting to
feed the controller with any addresses intended for the white list. This
patch adds the necessary HCI command sending to the HCI init sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    6 ++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 521eefa..f1766a6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1001,6 +1001,12 @@ struct hci_cp_le_create_conn {
 
 #define HCI_OP_LE_CREATE_CONN_CANCEL	0x200e
 
+#define HCI_OP_LE_READ_WHITE_LIST_SIZE	0x200f
+struct hci_rp_le_read_white_list_size {
+	__u8	status;
+	__u8	size;
+} __packed;
+
 #define HCI_OP_LE_CONN_UPDATE		0x2013
 struct hci_cp_le_conn_update {
 	__le16   handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3f607c9..d6ed4ac 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -153,6 +153,7 @@ struct hci_dev {
 	__u8		features[8];
 	__u8		host_features[8];
 	__u8		le_features[8];
+	__u8		le_white_list_size;
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 07c8c79..d2fee64 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -614,6 +614,9 @@ static void le_setup(struct hci_dev *hdev)
 
 	/* Read LE Advertising Channel TX Power */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
+
+	/* Read LE White List Size */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
 }
 
 static void hci_setup(struct hci_dev *hdev)
@@ -1306,6 +1309,19 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_le_read_white_list_size *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
+
+	if (!rp->status)
+		hdev->le_white_list_size = rp->size;
+
+	hci_req_complete(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, rp->status);
+}
+
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_le_ltk_reply *rp = (void *) skb->data;
@@ -2684,6 +2700,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_WHITE_LIST_SIZE:
+		hci_cc_le_read_white_list_size(hdev, skb);
+		break;
+
 	case HCI_OP_LE_LTK_REPLY:
 		hci_cc_le_ltk_reply(hdev, skb);
 		break;
-- 
1.7.10.4

