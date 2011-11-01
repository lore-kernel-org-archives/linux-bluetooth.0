Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: handle priority change within quote
Date: Tue,  1 Nov 2011 10:59:00 +0200
Message-Id: <1320137942-25780-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
References: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The quote is calculated based on the first buffer in the queue so if the
priority changes to something lower than the priority of the first skb
the quote needs to be recalculated.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6dbc36a1..4ecf652 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2211,10 +2211,17 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 	while (hdev->acl_cnt &&
 			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
+		u32 priority = (skb_peek(&chan->data_q))->priority;
+		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 					skb->len, skb->priority);
 
+			/* Stop if priority has changed */
+			if (skb->priority < priority)
+				break;
+
+			skb = skb_dequeue(&chan->data_q);
+
 			hci_conn_enter_active_mode(chan->conn,
 						bt_cb(skb)->force_active);
 
@@ -2296,10 +2303,17 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
+		u32 priority = (skb_peek(&chan->data_q))->priority;
+		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 					skb->len, skb->priority);
 
+			/* Stop if priority has changed */
+			if (skb->priority < priority)
+				break;
+
+			skb = skb_dequeue(&chan->data_q);
+
 			hci_send_frame(skb);
 			hdev->le_last_tx = jiffies;
 
-- 
1.7.6.4

