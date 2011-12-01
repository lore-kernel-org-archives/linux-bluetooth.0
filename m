Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/8] Bluetooth: Recalculate sched for HCI block flow ctrl
Date: Thu,  1 Dec 2011 14:42:13 +0200
Message-Id: <1322743335-8671-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Upstream Code Aurora code with trivial fixes.
Origin: git://codeaurora.org/kernel/msm.git
---
 net/bluetooth/hci_core.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4a0391e..6769eb5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2269,6 +2269,26 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 	}
 }
 
+static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int blocks;
+
+	switch (hdev->flow_ctl_mode) {
+	case HCI_FLOW_CTL_MODE_BLOCK_BASED:
+		/* Calculate count of blocks used by this packet */
+		blocks = DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE,
+							hdev->block_len);
+		break;
+
+	case HCI_FLOW_CTL_MODE_PACKET_BASED:
+	default:
+		blocks = 1;
+		break;
+	}
+
+	return blocks;
+}
+
 static inline void hci_sched_acl(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
@@ -2290,10 +2310,12 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 	cnt = hdev->acl_cnt;
 
-	while (hdev->acl_cnt &&
+	while (hdev->acl_cnt > 0 &&
 			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
-		while (quote-- && (skb = skb_peek(&chan->data_q))) {
+		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
+			int blocks = 1;
+
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 					skb->len, skb->priority);
 
@@ -2303,15 +2325,21 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
+			blocks = __get_blocks(hdev, skb);
+			if (blocks > hdev->acl_cnt)
+				return;
+
 			hci_conn_enter_active_mode(chan->conn,
 						bt_cb(skb)->force_active);
 
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
 
-			hdev->acl_cnt--;
-			chan->sent++;
-			chan->conn->sent++;
+			hdev->acl_cnt -= blocks;
+			quote -= blocks;
+
+			chan->sent += blocks;
+			chan->conn->sent += blocks;
 		}
 	}
 
-- 
1.7.4.1

