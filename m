Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 1/7] Bluetooth: Tidy-up coding style in hci_bcsp.c
Date: Fri, 23 Sep 2016 18:56:26 +0100
Message-ID: <1474653392-28770-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

drivers/bluetooth/hci_bcsp.c contains some style issues as
highlighted by

./scripts/checkpatch.pl --strict -f drivers/bluetooth/hci_bcsp.c

a) comments - maintainer prefers network style comments
b) positioning of lines in multi-line statements
c) spaces after casts
d) missing blank lines after declarations

Therefore, tidy-up the above to make it easier to apply
future code changes that have conforming style.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_bcsp.c | 55 +++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index d7d23ce..2628b36 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -90,7 +90,8 @@ struct bcsp_struct {
 /* ---- BCSP CRC calculation ---- */
 
 /* Table for calculating CRC for polynomial 0x1021, LSB processed first,
-initial value 0xffff, bits shifted in reverse order. */
+ * initial value 0xffff, bits shifted in reverse order.
+ */
 
 static const u16 crc_table[] = {
 	0x0000, 0x1081, 0x2102, 0x3183,
@@ -174,7 +175,7 @@ static int bcsp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 }
 
 static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
-		int len, int pkt_type)
+					int len, int pkt_type)
 {
 	struct sk_buff *nskb;
 	u8 hdr[4], chan;
@@ -213,6 +214,7 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 		/* Vendor specific commands */
 		if (hci_opcode_ogf(__le16_to_cpu(opcode)) == 0x3f) {
 			u8 desc = *(data + HCI_COMMAND_HDR_SIZE);
+
 			if ((desc & 0xf0) == 0xc0) {
 				data += HCI_COMMAND_HDR_SIZE + 1;
 				len  -= HCI_COMMAND_HDR_SIZE + 1;
@@ -271,8 +273,8 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 	/* Put CRC */
 	if (bcsp->use_crc) {
 		bcsp_txmsg_crc = bitrev16(bcsp_txmsg_crc);
-		bcsp_slip_one_byte(nskb, (u8) ((bcsp_txmsg_crc >> 8) & 0x00ff));
-		bcsp_slip_one_byte(nskb, (u8) (bcsp_txmsg_crc & 0x00ff));
+		bcsp_slip_one_byte(nskb, (u8)((bcsp_txmsg_crc >> 8) & 0x00ff));
+		bcsp_slip_one_byte(nskb, (u8)(bcsp_txmsg_crc & 0x00ff));
 	}
 
 	bcsp_slip_msgdelim(nskb);
@@ -287,7 +289,8 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	struct sk_buff *skb;
 
 	/* First of all, check for unreliable messages in the queue,
-	   since they have priority */
+	 * since they have priority
+	 */
 
 	skb = skb_dequeue(&bcsp->unrel);
 	if (skb != NULL) {
@@ -414,7 +417,7 @@ static void bcsp_handle_le_pkt(struct hci_uart *hu)
 
 	/* spot "conf" pkts and reply with a "conf rsp" pkt */
 	if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
-			!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
+	    !memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
 		struct sk_buff *nskb = alloc_skb(4, GFP_ATOMIC);
 
 		BT_DBG("Found a LE conf pkt");
@@ -428,7 +431,7 @@ static void bcsp_handle_le_pkt(struct hci_uart *hu)
 	}
 	/* Spot "sync" pkts. If we find one...disaster! */
 	else if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
-			!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
+		 !memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
 		BT_ERR("Found a LE sync pkt, card has reset");
 	}
 }
@@ -446,7 +449,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 		default:
 			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
 			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
-					bcsp->rx_state != BCSP_W4_CRC)
+			    bcsp->rx_state != BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, byte);
 			bcsp->rx_count--;
 		}
@@ -457,7 +460,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 		case 0xdc:
 			memcpy(skb_put(bcsp->rx_skb, 1), &c0, 1);
 			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
-					bcsp->rx_state != BCSP_W4_CRC)
+			    bcsp->rx_state != BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, 0xc0);
 			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
@@ -466,7 +469,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 		case 0xdd:
 			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
 			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
-					bcsp->rx_state != BCSP_W4_CRC)
+			    bcsp->rx_state != BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, 0xdb);
 			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
@@ -502,18 +505,18 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 
 	bcsp_pkt_cull(bcsp);
 	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
-			bcsp->rx_skb->data[0] & 0x80) {
+	    bcsp->rx_skb->data[0] & 0x80) {
 		hci_skb_pkt_type(bcsp->rx_skb) = HCI_ACLDATA_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
-			bcsp->rx_skb->data[0] & 0x80) {
+		   bcsp->rx_skb->data[0] & 0x80) {
 		hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
 		hci_skb_pkt_type(bcsp->rx_skb) = HCI_SCODATA_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
-			!(bcsp->rx_skb->data[0] & 0x80)) {
+		   !(bcsp->rx_skb->data[0] & 0x80)) {
 		bcsp_handle_le_pkt(hu);
 		pass_up = 0;
 	} else
@@ -537,9 +540,9 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 				hci_recv_frame(hu->hdev, bcsp->rx_skb);
 			} else {
 				BT_ERR("Packet for unknown channel (%u %s)",
-					bcsp->rx_skb->data[1] & 0x0f,
-					bcsp->rx_skb->data[0] & 0x80 ?
-					"reliable" : "unreliable");
+				       bcsp->rx_skb->data[1] & 0x0f,
+				       bcsp->rx_skb->data[0] & 0x80 ?
+				       "reliable" : "unreliable");
 				kfree_skb(bcsp->rx_skb);
 			}
 		} else
@@ -567,7 +570,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	const unsigned char *ptr;
 
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
-		hu, count, bcsp->rx_state, bcsp->rx_count);
+	       hu, count, bcsp->rx_state, bcsp->rx_count);
 
 	ptr = data;
 	while (count) {
@@ -586,18 +589,18 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 
 		switch (bcsp->rx_state) {
 		case BCSP_W4_BCSP_HDR:
-			if ((0xff & (u8) ~ (bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
-					bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
+			if ((0xff & (u8)~(bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
+			    bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
 				BT_ERR("Error in BCSP hdr checksum");
 				kfree_skb(bcsp->rx_skb);
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 				bcsp->rx_count = 0;
 				continue;
 			}
-			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
-						&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
+			if (bcsp->rx_skb->data[0] & 0x80 &&	/* reliable pkt */
+			    (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
 				BT_ERR("Out-of-order packet arrived, got %u expected %u",
-					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
+				       bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
 
 				kfree_skb(bcsp->rx_skb);
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
@@ -620,8 +623,8 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 		case BCSP_W4_CRC:
 			if (bitrev16(bcsp->message_crc) != bscp_get_crc(bcsp)) {
 				BT_ERR("Checksum failed: computed %04x received %04x",
-					bitrev16(bcsp->message_crc),
-					bscp_get_crc(bcsp));
+				       bitrev16(bcsp->message_crc),
+				       bscp_get_crc(bcsp));
 
 				kfree_skb(bcsp->rx_skb);
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
@@ -679,7 +682,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	/* Arrange to retransmit all messages in the relq. */
 static void bcsp_timed_event(unsigned long arg)
 {
-	struct hci_uart *hu = (struct hci_uart *) arg;
+	struct hci_uart *hu = (struct hci_uart *)arg;
 	struct bcsp_struct *bcsp = hu->priv;
 	struct sk_buff *skb;
 	unsigned long flags;
@@ -715,7 +718,7 @@ static int bcsp_open(struct hci_uart *hu)
 
 	init_timer(&bcsp->tbcsp);
 	bcsp->tbcsp.function = bcsp_timed_event;
-	bcsp->tbcsp.data     = (u_long) hu;
+	bcsp->tbcsp.data     = (u_long)hu;
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 
-- 
2.7.4
