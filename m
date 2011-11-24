Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 6/6] Bluetooth: Recalculate sched for HCI block flow ctrl
Date: Thu, 24 Nov 2011 14:52:05 +0200
Message-Id: <1322139125-22377-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Upstream Code Aurora code with trivial fixes.
Origin: git://codeaurora.org/kernel/msm.git

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2e4211e..1b62041 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2290,10 +2290,12 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
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
 
@@ -2303,15 +2305,28 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
+			if (hdev->flow_ctl_mode ==
+					HCI_BLOCK_BASED_FLOW_CTL_MODE)
+				/* Calculate count of blocks used by
+				 * this packet
+				 */
+				blocks = DIV_ROUND_UP(skb->len -
+					HCI_ACL_HDR_SIZE, hdev->block_len);
+
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

