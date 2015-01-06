Return-Path: <cyrus@holtmann.org>
From: Tristan Lelong <tristan@lelong.xyz>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tristan@lelong.xyz>
Subject: [PATCH v2 1/2] hci_bcsp: Add LE protocol on kernel side
Date: Mon,  5 Jan 2015 23:17:45 -0800
Message-Id: <1420528666-4846-2-git-send-email-tristan@lelong.xyz>
In-Reply-To: <1420528666-4846-1-git-send-email-tristan@lelong.xyz>
References: <1420528666-4846-1-git-send-email-tristan@lelong.xyz>
List-ID: <linux-bluetooth.vger.kernel.org>

Add the link establishment protocol handling in the kernel:
- le_state enum to handle state machine
- bcsp_timed_event to send LE messages
- bcsp_handle_le_pkt to answer endpoint LE messages
- various tests to muzzle BCSP link before GARULOUS

Signed-off-by: Tristan Lelong <tristan@lelong.xyz>
---
 drivers/bluetooth/hci_bcsp.c | 210 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 172 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 21cc45b..2685ab9 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -47,13 +47,24 @@
 
 #include "hci_uart.h"
 
-#define VERSION "0.3"
+#define VERSION "0.4"
+
+#define LE_POLLING	(HZ/10)
+#define TX_POLLING	(HZ/4)
 
 static bool txcrc = 1;
 static bool hciextn = 1;
 
+static const u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
+static const u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
+static const u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
+static const u8 sync_rsp_pkt[4] = { 0xac, 0xaf, 0xef, 0xee };
+
 #define BCSP_TXWINSIZE	4
 
+#define BCSP_PKT_LEN(data)	((data[1] >> 4) + (data[2]))
+#define BCSP_LE_PKT_LEN	0x04
+
 #define BCSP_ACK_PKT	0x05
 #define BCSP_LE_PKT	0x06
 
@@ -69,6 +80,12 @@ struct bcsp_struct {
 	struct	timer_list tbcsp;
 
 	enum {
+		BCSP_SHY = 0,
+		BCSP_CURIOUS,
+		BCSP_GARULOUS
+	} le_state;
+
+	enum {
 		BCSP_W4_PKT_DELIMITER,
 		BCSP_W4_PKT_START,
 		BCSP_W4_BCSP_HDR,
@@ -184,6 +201,9 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 	u16 BCSP_CRC_INIT(bcsp_txmsg_crc);
 	int rel, i;
 
+	if (bcsp->le_state != BCSP_GARULOUS && pkt_type != BCSP_LE_PKT)
+		return NULL;
+
 	switch (pkt_type) {
 	case HCI_ACLDATA_PKT:
 		chan = 6;	/* BCSP ACL channel */
@@ -299,10 +319,16 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 			return nskb;
 		} else {
 			skb_queue_head(&bcsp->unrel, skb);
+			if (bcsp->le_state == BCSP_GARULOUS)
+				return NULL;
 			BT_ERR("Could not dequeue pkt because alloc_skb failed");
 		}
 	}
 
+	/* If BCSP is not connected yet, there is no need to go further */
+	if (bcsp->le_state != BCSP_GARULOUS)
+		return NULL;
+
 	/* Now, try to send a reliable pkt. We can only send a
 	   reliable packet if the number of packets sent but not yet ack'ed
 	   is < than the winsize */
@@ -316,11 +342,18 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 								bt_cb(skb)->pkt_type);
 			if (nskb) {
 				__skb_queue_tail(&bcsp->unack, skb);
-				mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
+
+				if (bcsp->le_state == BCSP_GARULOUS)
+					/* only re-arm retransmit timer
+					 * if the BCSP link is connected */
+					mod_timer(&bcsp->tbcsp,
+						  jiffies + HZ / 4);
 				spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 				return nskb;
 			} else {
 				skb_queue_head(&bcsp->rel, skb);
+				if (bcsp->le_state != BCSP_GARULOUS)
+					return NULL;
 				BT_ERR("Could not dequeue pkt because alloc_skb failed");
 			}
 		}
@@ -350,8 +383,9 @@ static int bcsp_flush(struct hci_uart *hu)
 }
 
 /* Remove ack'ed packets */
-static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
+static void bcsp_pkt_cull(struct hci_uart *hu)
 {
+	struct bcsp_struct *bcsp = hu->priv;
 	struct sk_buff *skb, *tmp;
 	unsigned long flags;
 	int i, pkts_to_be_removed;
@@ -386,43 +420,111 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 		kfree_skb(skb);
 	}
 
-	if (skb_queue_empty(&bcsp->unack))
+	if (skb_queue_empty(&bcsp->unack) && bcsp->le_state == BCSP_GARULOUS)
 		del_timer(&bcsp->tbcsp);
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
+	/* Some reliable packets might be queued in ack queue,
+	 * but not sent since the tx window was full.
+	 * try to process them now. */
+	if (bcsp->unack.qlen < BCSP_TXWINSIZE)
+		if (skb_queue_len(&bcsp->rel))
+			hci_uart_tx_wakeup(hu);
+
 	if (i != pkts_to_be_removed)
 		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
 }
 
-/* Handle BCSP link-establishment packets. When we
-   detect a "sync" packet, symptom that the BT module has reset,
-   we do nothing :) (yet) */
+static void bcsp_internal_reset(struct hci_uart *hu)
+{
+	struct bcsp_struct *bcsp = hu->priv;
+
+	/* reset the bcsp stack counters */
+	bcsp->rxseq_txack = 0;
+	bcsp->rxack = 0;
+	bcsp->message_crc = 0;
+	bcsp->txack_req = 0;
+	bcsp->msgq_txseq = 0;
+
+	/* reset state machine */
+	bcsp->le_state = BCSP_SHY;
+	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
+	bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
+
+	/* empty all the queues */
+	skb_queue_purge(&bcsp->unack);
+	skb_queue_purge(&bcsp->rel);
+	skb_queue_purge(&bcsp->unrel);
+
+	/* tell upper layer about the reset */
+	hci_reset_dev(hu->hdev);
+
+	bcsp->tbcsp.expires  = jiffies + LE_POLLING;
+	add_timer(&bcsp->tbcsp);
+}
+
+/* Handle BCSP link-establishment packets.
+ */
 static void bcsp_handle_le_pkt(struct hci_uart *hu)
 {
+	struct sk_buff *nskb;
 	struct bcsp_struct *bcsp = hu->priv;
-	u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
-	u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
-	u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
-
-	/* spot "conf" pkts and reply with a "conf rsp" pkt */
-	if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
-			!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
-		struct sk_buff *nskb = alloc_skb(4, GFP_ATOMIC);
-
-		BT_DBG("Found a LE conf pkt");
-		if (!nskb)
-			return;
-		memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
-		bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
-
-		skb_queue_head(&bcsp->unrel, nskb);
-		hci_uart_tx_wakeup(hu);
-	}
-	/* Spot "sync" pkts. If we find one...disaster! */
-	else if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
-			!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
-		BT_ERR("Found a LE sync pkt, card has reset");
+
+	if (BCSP_PKT_LEN(bcsp->rx_skb->data) == BCSP_LE_PKT_LEN) {
+		if (!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
+			/* spot "conf" pkts and reply with a "conf rsp" pkt */
+			if (bcsp->le_state == BCSP_SHY)
+				return;
+
+			BT_DBG("Found a LE conf pkt");
+			nskb = alloc_skb(4, GFP_ATOMIC);
+			if (!nskb)
+				return;
+			memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
+			bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
+
+			skb_queue_head(&bcsp->unrel, nskb);
+			hci_uart_tx_wakeup(hu);
+		} else if (!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
+			/* Spot "sync" pkts and reply with a "sync rsp" pkt */
+			if (bcsp->le_state == BCSP_GARULOUS)
+				/* we force the connection state to reset */
+				bcsp_internal_reset(hu);
+
+			BT_INFO("BCSP: hci%d LE sync pkt, performing reset",
+				hu->hdev->id);
+
+			nskb = alloc_skb(4, GFP_ATOMIC);
+			if (!nskb)
+				return;
+			memcpy(skb_put(nskb, 4), sync_rsp_pkt, 4);
+			bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
+
+			skb_queue_head(&bcsp->unrel, nskb);
+			hci_uart_tx_wakeup(hu);
+		} else if (!memcmp(&bcsp->rx_skb->data[4], conf_rsp_pkt, 4)) {
+			/* Spot "conf rsp" pkts and update state machine */
+			if (bcsp->le_state != BCSP_CURIOUS) {
+				BT_DBG("BCSP: hci%d ingoring conf_resp packet",
+				       hu->hdev->id);
+				return;
+			}
+
+			BT_INFO("BCSP: hci%d connected", hu->hdev->id);
+			bcsp->le_state = BCSP_GARULOUS;
+		} else if (!memcmp(&bcsp->rx_skb->data[4], sync_rsp_pkt, 4)) {
+			/* Spot "sync rsp" pkts and update state machine */
+			if (bcsp->le_state != BCSP_SHY) {
+				BT_DBG("BCSP: hci%d ignoring sync_resp packet",
+				       hu->hdev->id);
+				return;
+			}
+
+			BT_DBG("Found a LE sync rsp pkt");
+			bcsp->le_state = BCSP_CURIOUS;
+		}
+
 	}
 }
 
@@ -493,7 +595,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 	bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
 	BT_DBG("Request for pkt %u from card", bcsp->rxack);
 
-	bcsp_pkt_cull(bcsp);
+	bcsp_pkt_cull(hu);
 	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
 			bcsp->rx_skb->data[0] & 0x80) {
 		bt_cb(bcsp->rx_skb)->pkt_type = HCI_ACLDATA_PKT;
@@ -537,11 +639,13 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 			}
 		} else
 			kfree_skb(bcsp->rx_skb);
-	} else {
+	} else if (bcsp->le_state == BCSP_GARULOUS) {
 		/* Pull out BCSP hdr */
 		skb_pull(bcsp->rx_skb, 4);
 
 		hci_recv_frame(hu->hdev, bcsp->rx_skb);
+	} else {
+		kfree_skb(bcsp->rx_skb);
 	}
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
@@ -676,16 +780,42 @@ static void bcsp_timed_event(unsigned long arg)
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
+	switch (bcsp->le_state) {
+	case BCSP_GARULOUS:
+		BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
 
-	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
+		spin_lock_irqsave_nested(&bcsp->unack.lock, flags,
+					 SINGLE_DEPTH_NESTING);
 
-	while ((skb = __skb_dequeue_tail(&bcsp->unack)) != NULL) {
-		bcsp->msgq_txseq = (bcsp->msgq_txseq - 1) & 0x07;
-		skb_queue_head(&bcsp->rel, skb);
-	}
+		while ((skb = __skb_dequeue_tail(&bcsp->unack)) != NULL) {
+			bcsp->msgq_txseq = (bcsp->msgq_txseq - 1) & 0x07;
+			skb_queue_head(&bcsp->rel, skb);
+		}
 
-	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
+		spin_unlock_irqrestore(&bcsp->unack.lock, flags);
+		break;
+	case BCSP_CURIOUS:
+		skb = alloc_skb(4, GFP_ATOMIC);
+		memcpy(skb_put(skb, 4), conf_pkt, 4);
+		bt_cb(skb)->pkt_type = BCSP_LE_PKT;
+		skb_queue_head(&bcsp->unrel, skb);
+
+		bcsp->tbcsp.expires += LE_POLLING;
+		add_timer(&bcsp->tbcsp);
+		break;
+	default:
+		BT_INFO("Internal state unknown. Assuming not connected.");
+		bcsp->le_state = BCSP_SHY;
+	case BCSP_SHY:
+		skb = alloc_skb(4, GFP_ATOMIC);
+		memcpy(skb_put(skb, 4), sync_pkt, 4);
+		bt_cb(skb)->pkt_type = BCSP_LE_PKT;
+		skb_queue_head(&bcsp->unrel, skb);
+
+		bcsp->tbcsp.expires += LE_POLLING;
+		add_timer(&bcsp->tbcsp);
+		break;
+	}
 
 	hci_uart_tx_wakeup(hu);
 }
@@ -708,12 +838,16 @@ static int bcsp_open(struct hci_uart *hu)
 	init_timer(&bcsp->tbcsp);
 	bcsp->tbcsp.function = bcsp_timed_event;
 	bcsp->tbcsp.data     = (u_long) hu;
+	bcsp->tbcsp.expires  = jiffies + LE_POLLING;
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
+	bcsp->le_state = BCSP_SHY;
 
 	if (txcrc)
 		bcsp->use_crc = 1;
 
+	add_timer(&bcsp->tbcsp);
+
 	return 0;
 }
 
-- 
2.1.3
