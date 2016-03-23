Return-Path: <mussitantesmortem@gmail.com>
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH] bluetooth: hci_bcsp: fix code style
Date: Wed, 23 Mar 2016 11:00:17 +0300
Message-Id: <1458720017-21115-1-git-send-email-mussitantesmortem@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This commit fixed:
trailing "*/"
trailing spaces
mixed indent
space between ~ and (

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c | 55 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 064f2fe..3cfbe1d 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -103,12 +103,12 @@ static const u16 crc_table[] = {
 #define BCSP_CRC_INIT(x) x = 0xffff
 
 /*
-   Update crc with next data byte
-
-   Implementation note
-        The data byte is treated as two nibbles.  The crc is generated
-        in reverse, i.e., bits are fed into the register from the top.
-*/
+ * Update crc with next data byte
+ *
+ * Implementation note
+ *	The data byte is treated as two nibbles.  The crc is generated
+ *	in reverse, i.e., bits are fed into the register from the top.
+ */
 static void bcsp_crc_update(u16 *crc, u8 d)
 {
 	u16 reg = *crc;
@@ -285,7 +285,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	struct bcsp_struct *bcsp = hu->priv;
 	unsigned long flags;
 	struct sk_buff *skb;
-	
+
 	/* First of all, check for unreliable messages in the queue,
 	   since they have priority */
 
@@ -331,13 +331,17 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
-	/* We could not send a reliable packet, either because there are
-	   none or because there are too many unack'ed pkts. Did we receive
-	   any packets we have not acknowledged yet ? */
+	/*
+	 * We could not send a reliable packet, either because there are
+	 * none or because there are too many unack'ed pkts. Did we receive
+	 * any packets we have not acknowledged yet ?
+	 */
 
 	if (bcsp->txack_req) {
-		/* if so, craft an empty ACK pkt and send it on BCSP unreliable
-		   channel 0 */
+		/*
+		 * if so, craft an empty ACK pkt and send it on BCSP unreliable
+		 * channel 0
+		 */
 		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, NULL, 0, BCSP_ACK_PKT);
 		return nskb;
 	}
@@ -398,9 +402,11 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
 }
 
-/* Handle BCSP link-establishment packets. When we
-   detect a "sync" packet, symptom that the BT module has reset,
-   we do nothing :) (yet) */
+/*
+ * Handle BCSP link-establishment packets. When we
+ * detect a "sync" packet, symptom that the BT module has reset,
+ * we do nothing :) (yet)
+ */
 static void bcsp_handle_le_pkt(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
@@ -462,7 +468,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 		case 0xdd:
 			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
 			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
-					bcsp->rx_state != BCSP_W4_CRC) 
+					bcsp->rx_state != BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, 0xdb);
 			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
@@ -534,7 +540,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 			} else {
 				BT_ERR("Packet for unknown channel (%u %s)",
 					bcsp->rx_skb->data[1] & 0x0f,
-					bcsp->rx_skb->data[0] & 0x80 ? 
+					bcsp->rx_skb->data[0] & 0x80 ?
 					"reliable" : "unreliable");
 				kfree_skb(bcsp->rx_skb);
 			}
@@ -562,7 +568,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	struct bcsp_struct *bcsp = hu->priv;
 	const unsigned char *ptr;
 
-	BT_DBG("hu %p count %d rx_state %d rx_count %ld", 
+	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 		hu, count, bcsp->rx_state, bcsp->rx_count);
 
 	ptr = data;
@@ -582,7 +588,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 
 		switch (bcsp->rx_state) {
 		case BCSP_W4_BCSP_HDR:
-			if ((0xff & (u8) ~ (bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
+			if ((0xff & (u8) ~(bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
 					bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
 				BT_ERR("Error in BCSP hdr checksum");
 				kfree_skb(bcsp->rx_skb);
@@ -591,7 +597,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				continue;
 			}
 			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
-			    		&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
+						&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
 				BT_ERR("Out-of-order packet arrived, got %u expected %u",
 					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
 
@@ -601,7 +607,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				continue;
 			}
 			bcsp->rx_state = BCSP_W4_DATA;
-			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) + 
+			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) +
 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
 			continue;
 
@@ -615,7 +621,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 
 		case BCSP_W4_CRC:
 			if (bitrev16(bcsp->message_crc) != bscp_get_crc(bcsp)) {
-				BT_ERR ("Checksum failed: computed %04x received %04x",
+				BT_ERR("Checksum failed: computed %04x received %04x",
 					bitrev16(bcsp->message_crc),
 					bscp_get_crc(bcsp));
 
@@ -653,8 +659,9 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				BCSP_CRC_INIT(bcsp->message_crc);
 
 				/* Do not increment ptr or decrement count
-				 * Allocate packet. Max len of a BCSP pkt= 
-				 * 0xFFF (payload) +4 (header) +2 (crc) */
+				 * Allocate packet. Max len of a BCSP pkt=
+				 * 0xFFF (payload) +4 (header) +2 (crc)
+				 */
 
 				bcsp->rx_skb = bt_skb_alloc(0x1005, GFP_ATOMIC);
 				if (!bcsp->rx_skb) {
-- 
2.7.1.1.g3617aa0
