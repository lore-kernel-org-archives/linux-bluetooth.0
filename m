Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/2] Bluetooth: Recalculate sched HCI blk/pkt flow ctrl
Date: Fri,  3 Feb 2012 16:27:54 +0200
Message-Id: <1328279275-10303-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Split HCI scheduling for block and packet flow control.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   85 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 76dc153..9a56a40 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2384,18 +2384,19 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 }
 
-static inline void hci_sched_acl(struct hci_dev *hdev)
+static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Calculate count of blocks used by this packet */
+	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
+}
+
+static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
 	int quote;
 	unsigned int cnt;
 
-	BT_DBG("%s", hdev->name);
-
-	if (!hci_conn_num(hdev, ACL_LINK))
-		return;
-
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
@@ -2435,6 +2436,78 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
+static inline void hci_sched_acl_blk(struct hci_dev *hdev)
+{
+	struct hci_chan *chan;
+	struct sk_buff *skb;
+	int quote;
+	unsigned int cnt;
+
+	if (!test_bit(HCI_RAW, &hdev->flags)) {
+		/* ACL tx timeout must be longer than maximum
+		 * link supervision timeout (40.9 seconds) */
+		if (!hdev->block_cnt && time_after(jiffies, hdev->acl_last_tx +
+					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
+			hci_link_tx_to(hdev, ACL_LINK);
+	}
+
+	cnt = hdev->block_cnt;
+
+	while (hdev->block_cnt > 0 &&
+			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
+		u32 priority = (skb_peek(&chan->data_q))->priority;
+		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
+			int blocks;
+
+			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
+						skb->len, skb->priority);
+
+			/* Stop if priority has changed */
+			if (skb->priority < priority)
+				break;
+
+			skb = skb_dequeue(&chan->data_q);
+
+			blocks = __get_blocks(hdev, skb);
+			if (blocks > hdev->block_cnt)
+				return;
+
+			hci_conn_enter_active_mode(chan->conn,
+						bt_cb(skb)->force_active);
+
+			hci_send_frame(skb);
+			hdev->acl_last_tx = jiffies;
+
+			hdev->block_cnt -= blocks;
+			quote -= blocks;
+
+			chan->sent += blocks;
+			chan->conn->sent += blocks;
+		}
+	}
+
+	if (cnt != hdev->block_cnt)
+		hci_prio_recalculate(hdev, ACL_LINK);
+}
+
+static inline void hci_sched_acl(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (!hci_conn_num(hdev, ACL_LINK))
+		return;
+
+	switch (hdev->flow_ctl_mode) {
+	case HCI_FLOW_CTL_MODE_PACKET_BASED:
+		hci_sched_acl_pkt(hdev);
+		break;
+
+	case HCI_FLOW_CTL_MODE_BLOCK_BASED:
+		hci_sched_acl_blk(hdev);
+		break;
+	}
+}
+
 /* Schedule SCO */
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
-- 
1.7.8.3

