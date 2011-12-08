Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 6/6] Bluetooth: Process num completed data blocks event
Date: Thu,  8 Dec 2011 14:53:06 +0200
Message-Id: <1323348786-18134-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for Number Of Completed Data Blocks Event. Highly
modified version of Code Aurora code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |   13 +++++++++
 net/bluetooth/hci_event.c   |   58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b9c0087..6846f3e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1154,6 +1154,19 @@ struct hci_ev_le_meta {
 	__u8     subevent;
 } __packed;
 
+#define HCI_EV_NUM_COMP_BLOCKS		0x48
+struct hci_comp_blocks_info {
+	__le16   handle;
+	__le16   pkts;
+	__le16   blocks;
+} __packed;
+
+struct hci_ev_num_comp_blocks {
+	__le16   num_blocks;
+	__u8     num_hndl;
+	struct hci_comp_blocks_info handles[0];
+} __packed;
+
 /* Low energy meta events */
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c96d580..403ddd5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2333,6 +2333,60 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	tasklet_enable(&hdev->tx_task);
 }
 
+static inline void hci_num_comp_blocks_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
+	int i;
+
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
+		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
+		return;
+	}
+
+	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
+			ev->num_hndl * sizeof(struct hci_comp_blocks_info)) {
+		BT_DBG("%s bad parameters", hdev->name);
+		return;
+	}
+
+	BT_DBG("%s num_blocks %d num_hndl %d", hdev->name, ev->num_blocks,
+								ev->num_hndl);
+
+	tasklet_disable(&hdev->tx_task);
+
+	for (i = 0; i < ev->num_hndl; i++) {
+		struct hci_comp_blocks_info *info = &ev->handles[i];
+		struct hci_conn *conn;
+		__u16  handle, block_count;
+
+		handle = __le16_to_cpu(info->handle);
+		block_count = __le16_to_cpu(info->blocks);
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
+			BT_ERR("Unknown type %d conn %p", conn->type, conn);
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
@@ -3272,6 +3326,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

