Return-Path: <mussitantesmortem@gmail.com>
Date: Fri, 8 Apr 2016 23:54:51 +0300
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH V2] bluetooth: hci_bcsp: fix code style
Message-ID: <20160408205451.GA12798@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

This commit fixed:
trailing "*/"
trailing spaces
mixed indent
space between ~ and (

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c | 57 ++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 064f2fe..d7d23ce 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -102,13 +102,12 @@ static const u16 crc_table[] = {
 /* Initialise the crc calculator */
 #define BCSP_CRC_INIT(x) x = 0xffff
 
-/*
-   Update crc with next data byte
-
-   Implementation note
-        The data byte is treated as two nibbles.  The crc is generated
-        in reverse, i.e., bits are fed into the register from the top.
-*/
+/* Update crc with next data byte
+ *
+ * Implementation note
+ *     The data byte is treated as two nibbles.  The crc is generated
+ *     in reverse, i.e., bits are fed into the register from the top.
+ */
 static void bcsp_crc_update(u16 *crc, u8 d)
 {
 	u16 reg = *crc;
@@ -223,9 +222,10 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 	}
 
 	/* Max len of packet: (original len +4(bcsp hdr) +2(crc))*2
-	   (because bytes 0xc0 and 0xdb are escaped, worst case is
-	   when the packet is all made of 0xc0 and 0xdb :) )
-	   + 2 (0xc0 delimiters at start and end). */
+	 * (because bytes 0xc0 and 0xdb are escaped, worst case is
+	 * when the packet is all made of 0xc0 and 0xdb :) )
+	 * + 2 (0xc0 delimiters at start and end).
+	 */
 
 	nskb = alloc_skb((len + 6) * 2 + 2, GFP_ATOMIC);
 	if (!nskb)
@@ -285,7 +285,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	struct bcsp_struct *bcsp = hu->priv;
 	unsigned long flags;
 	struct sk_buff *skb;
-	
+
 	/* First of all, check for unreliable messages in the queue,
 	   since they have priority */
 
@@ -305,8 +305,9 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	}
 
 	/* Now, try to send a reliable pkt. We can only send a
-	   reliable packet if the number of packets sent but not yet ack'ed
-	   is < than the winsize */
+	 * reliable packet if the number of packets sent but not yet ack'ed
+	 * is < than the winsize
+	 */
 
 	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
@@ -332,12 +333,14 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
 	/* We could not send a reliable packet, either because there are
-	   none or because there are too many unack'ed pkts. Did we receive
-	   any packets we have not acknowledged yet ? */
+	 * none or because there are too many unack'ed pkts. Did we receive
+	 * any packets we have not acknowledged yet ?
+	 */
 
 	if (bcsp->txack_req) {
 		/* if so, craft an empty ACK pkt and send it on BCSP unreliable
-		   channel 0 */
+		 * channel 0
+		 */
 		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, NULL, 0, BCSP_ACK_PKT);
 		return nskb;
 	}
@@ -399,8 +402,9 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 }
 
 /* Handle BCSP link-establishment packets. When we
-   detect a "sync" packet, symptom that the BT module has reset,
-   we do nothing :) (yet) */
+ * detect a "sync" packet, symptom that the BT module has reset,
+ * we do nothing :) (yet)
+ */
 static void bcsp_handle_le_pkt(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
@@ -462,7 +466,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 		case 0xdd:
 			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
 			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
-					bcsp->rx_state != BCSP_W4_CRC) 
+					bcsp->rx_state != BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, 0xdb);
 			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
@@ -534,7 +538,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 			} else {
 				BT_ERR("Packet for unknown channel (%u %s)",
 					bcsp->rx_skb->data[1] & 0x0f,
-					bcsp->rx_skb->data[0] & 0x80 ? 
+					bcsp->rx_skb->data[0] & 0x80 ?
 					"reliable" : "unreliable");
 				kfree_skb(bcsp->rx_skb);
 			}
@@ -562,7 +566,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	struct bcsp_struct *bcsp = hu->priv;
 	const unsigned char *ptr;
 
-	BT_DBG("hu %p count %d rx_state %d rx_count %ld", 
+	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 		hu, count, bcsp->rx_state, bcsp->rx_count);
 
 	ptr = data;
@@ -591,7 +595,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				continue;
 			}
 			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
-			    		&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
+						&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
 				BT_ERR("Out-of-order packet arrived, got %u expected %u",
 					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
 
@@ -601,7 +605,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				continue;
 			}
 			bcsp->rx_state = BCSP_W4_DATA;
-			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) + 
+			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) +
 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
 			continue;
 
@@ -615,7 +619,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 
 		case BCSP_W4_CRC:
 			if (bitrev16(bcsp->message_crc) != bscp_get_crc(bcsp)) {
-				BT_ERR ("Checksum failed: computed %04x received %04x",
+				BT_ERR("Checksum failed: computed %04x received %04x",
 					bitrev16(bcsp->message_crc),
 					bscp_get_crc(bcsp));
 
@@ -653,8 +657,9 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
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
2.8.0.rc3
