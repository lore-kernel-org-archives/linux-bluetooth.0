Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: handle priority change within quote
Date: Wed,  2 Nov 2011 15:52:02 +0200
Message-Id: <1320241924-2300-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
References: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
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
index 631327d..19e4453 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2193,10 +2193,17 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
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
 
@@ -2278,10 +2285,17 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 
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

