Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/17] Bluetooth: Add initial packet sending support to Three-wire UART
Date: Wed, 27 Jun 2012 14:25:55 +0300
Message-Id: <1340796367-10321-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds initial packed encoding and sending support to the
Three-wire UART HCI transport driver.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |  105 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 3b33f90..6b02ccc 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -30,6 +30,9 @@
 
 #include "hci_uart.h"
 
+#define HCI_3WIRE_ACK_PKT	0
+#define HCI_3WIRE_LINK_PKT	15
+
 #define H5_TXWINSIZE 4
 
 /*
@@ -58,7 +61,8 @@ struct h5 {
 
 	bool			txack_req;
 
-	u8			msgq_txseq;
+	u8			next_ack;
+	u8			next_seq;
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -75,7 +79,7 @@ static void h5_timed_event(unsigned long arg)
 	spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
 	while ((skb = __skb_dequeue_tail(&h5->unack)) != NULL) {
-		h5->msgq_txseq = (h5->msgq_txseq - 1) & 0x07;
+		h5->next_seq = (h5->next_seq - 1) & 0x07;
 		skb_queue_head(&h5->rel, skb);
 	}
 
@@ -353,10 +357,96 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
-static struct sk_buff *h5_prepare_pkt(struct h5 *h5, struct sk_buff *skb)
+static void h5_slip_delim(struct sk_buff *skb)
+{
+	const char delim = SLIP_DELIMITER;
+
+	memcpy(skb_put(skb, 1), &delim, 1);
+}
+
+static void h5_slip_one_byte(struct sk_buff *skb, u8 c)
+{
+	const char esc_delim[2] = { SLIP_ESC, SLIP_ESC_DELIM };
+	const char esc_esc[2] = { SLIP_ESC, SLIP_ESC_ESC };
+
+	switch (c) {
+	case SLIP_DELIMITER:
+		memcpy(skb_put(skb, 2), &esc_delim, 2);
+		break;
+	case SLIP_ESC:
+		memcpy(skb_put(skb, 2), &esc_esc, 2);
+		break;
+	default:
+		memcpy(skb_put(skb, 1), &c, 1);
+	}
+}
+
+static struct sk_buff *h5_build_pkt(struct h5 *h5, bool rel, u8 pkt_type,
+				    const u8 *data, size_t len)
 {
+	struct sk_buff *nskb;
+	u8 hdr[4];
+	int i;
+
+	/*
+	 * Max len of packet: (original len + 4 (H5 hdr) + 2 (crc)) * 2
+	 * (because bytes 0xc0 and 0xdb are escaped, worst case is when
+	 * the packet is all made of 0xc0 and 0xdb) + 2 (0xc0
+	 * delimiters at start and end).
+	 */
+	nskb = alloc_skb((len + 6) * 2 + 2, GFP_ATOMIC);
+	if (!nskb)
+		return NULL;
+
+	bt_cb(nskb)->pkt_type = pkt_type;
+
+	h5_slip_delim(nskb);
+
+	hdr[0] = h5->next_ack << 3;
 	h5->txack_req = false;
-	return NULL;
+
+	if (rel) {
+		hdr[0] |= 1 << 7;
+		hdr[0] |= h5->next_seq;
+		h5->next_seq = (h5->next_seq + 1) % 8;
+	}
+
+	hdr[1] = pkt_type | ((len & 0x0f) << 4);
+	hdr[2] = len >> 4;
+	hdr[3] = ~((hdr[0] + hdr[1] + hdr[2]) & 0xff);
+
+	for (i = 0; i < 4; i++)
+		h5_slip_one_byte(nskb, hdr[i]);
+
+	for (i = 0; i < len; i++)
+		h5_slip_one_byte(nskb, data[i]);
+
+	h5_slip_delim(nskb);
+
+	return nskb;
+}
+
+static struct sk_buff *h5_prepare_pkt(struct h5 *h5, u8 pkt_type,
+				      const u8 *data, size_t len)
+{
+	bool rel;
+
+	switch (pkt_type) {
+	case HCI_ACLDATA_PKT:
+	case HCI_COMMAND_PKT:
+		rel = true;
+		break;
+	case HCI_SCODATA_PKT:
+	case HCI_3WIRE_LINK_PKT:
+	case HCI_3WIRE_ACK_PKT:
+		rel = false;
+		break;
+	default:
+		BT_ERR("Unknown packet type %u", pkt_type);
+		return NULL;
+	}
+
+	return h5_build_pkt(h5, rel, pkt_type, data, len);
 }
 
 static struct sk_buff *h5_prepare_ack(struct h5 *h5)
@@ -372,7 +462,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 	struct sk_buff *skb, *nskb;
 
 	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
-		nskb = h5_prepare_pkt(h5, skb);
+		nskb = h5_prepare_pkt(h5, bt_cb(skb)->pkt_type,
+				      skb->data, skb->len);
 		if (nskb) {
 			kfree_skb(skb);
 			return nskb;
@@ -388,8 +479,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 	       goto unlock;
 
 	if ((skb = skb_dequeue(&h5->rel)) != NULL) {
-		nskb = h5_prepare_pkt(h5, skb);
-
+		nskb = h5_prepare_pkt(h5, bt_cb(skb)->pkt_type,
+				      skb->data, skb->len);
 		if (nskb) {
 			__skb_queue_tail(&h5->unack, skb);
 			mod_timer(&h5->timer, jiffies + HZ / 4);
-- 
1.7.10.4

