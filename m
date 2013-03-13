Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 22/26] Bluetooth: Update page scan parameters after successful write commands
Date: Wed, 13 Mar 2013 11:12:13 -0700
Message-Id: <1363198337-3896-23-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The page scan parameters (interval, window and type) stored in struct
hci_dev should not only be updated after successful reads but also after
successful writes. This patch adds the necessary handlers for the write
command complete events and updates the stored values through them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4a57913..7cbe35f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -614,6 +614,25 @@ static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_write_page_scan_activity(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	u8 status = *((u8 *) skb->data);
+	struct hci_cp_write_page_scan_activity *sent;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY);
+	if (!sent)
+		return;
+
+	hdev->page_scan_interval = __le16_to_cpu(sent->interval);
+	hdev->page_scan_window = __le16_to_cpu(sent->window);
+}
+
 static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -625,6 +644,22 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 		hdev->page_scan_type = __le16_to_cpu(rp->type);
 }
 
+static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	u8 status = *((u8 *) skb->data);
+	u8 *type;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	type = hci_sent_cmd_data(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE);
+	if (type)
+		hdev->page_scan_type = *type;
+}
+
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -2232,10 +2267,18 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_page_scan_activity(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_PAGE_SCAN_ACTIVITY:
+		hci_cc_write_page_scan_activity(hdev, skb);
+		break;
+
 	case HCI_OP_READ_PAGE_SCAN_TYPE:
 		hci_cc_read_page_scan_type(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_PAGE_SCAN_TYPE:
+		hci_cc_write_page_scan_type(hdev, skb);
+		break;
+
 	case HCI_OP_READ_DATA_BLOCK_SIZE:
 		hci_cc_read_data_block_size(hdev, skb);
 		break;
-- 
1.7.10.4

