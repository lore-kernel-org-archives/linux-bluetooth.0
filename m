Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/3] Bluetooth: Process num completed data blocks event
Date: Mon,  5 Dec 2011 14:55:04 +0200
Message-Id: <1323089704-1005-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for Number Of Completed Data Blocks Event. Highly
modified version of Code Aurora code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    7 +++++
 net/bluetooth/hci_event.c   |   61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9490c2c..0a6193e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1149,6 +1149,13 @@ struct hci_ev_le_meta {
 	__u8     subevent;
 } __packed;
 
+#define HCI_EV_NUM_COMP_BLOCKS		0x48
+struct hci_ev_num_comp_blocks {
+	__le16   num_blocks;
+	__u8     num_hndl;
+	/* variable length part */
+} __packed;
+
 /* Low energy meta events */
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fd7e6b5..26e4d38 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2325,6 +2325,63 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	tasklet_enable(&hdev->tx_task);
 }
 
+static inline void hci_num_comp_blocks_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
+	__le16 *ptr;
+	int i;
+
+	skb_pull(skb, sizeof(*ev));
+
+	BT_DBG("%s num_blocks %d num_hndl %d", hdev->name, ev->num_blocks,
+								ev->num_hndl);
+
+	if (skb->len < ev->num_hndl * 6) {
+		BT_DBG("%s bad parameters", hdev->name);
+		return;
+	}
+
+	if (hdev->dev_type != HCI_BREDR)
+		return;
+
+	tasklet_disable(&hdev->tx_task);
+
+	for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_hndl; i++) {
+		struct hci_conn *conn;
+		__u16  handle, block_count;
+
+		handle = get_unaligned_le16(ptr++);
+
+		/* Skip packet count*/
+		ptr++;
+
+		block_count = get_unaligned_le16(ptr++);
+
+		conn = hci_conn_hash_lookup_handle(hdev, handle);
+		if (!conn)
+			continue;
+
+		conn->sent -= block_count;
+
+		switch (conn->type) {
+		case ACL_LINK:
+			hdev->block_cnt += block_count;
+			if (hdev->block_cnt > hdev->num_blocks)
+				hdev->block_cnt = hdev->num_blocks;
+			break;
+
+		default:
+			BT_ERR("Not implemented for type %d", conn->type);
+			break;
+		}
+	}
+
+	tasklet_schedule(&hdev->tx_task);
+
+	tasklet_enable(&hdev->tx_task);
+}
+
 static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_mode_change *ev = (void *) skb->data;
@@ -3264,6 +3321,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_NUM_COMP_BLOCKS:
+		hci_num_comp_blocks_evt(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s event 0x%x", hdev->name, event);
 		break;
-- 
1.7.4.1

