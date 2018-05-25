Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Emil Lenngren <emil.lenngren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Lenngren <emil.lenngren@gmail.com>
Subject: [PATCH] Bluetooth: Fix flow bugs in H5 so the protocol doesn't stall
Date: Fri, 25 May 2018 15:59:23 +0200
Message-Id: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. If more than tx_win packets are enqueued, so that the unack queue
gets full, then when packets are later acked, uart tx is not woken up,
meaning that the flow will be stalled unless uart tx is not later
woken up for some other reason (e.g. packet is received so an ack
needs to be sent).

2. If remote peer sends tx_win packets to us and our ack(s) are
incorrectly received by the remote device, it will first resend the
tx_win packets and wait for their ack before it can send the next
packets. However, we only send ack if a NEW packet (not a resent packet)
is arrived. Therefore, we will never send ack and the remote device
will keep resend the packets (and wait for the acks) forever, until
we send a new tx packet.
---
 drivers/bluetooth/hci_h5.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index abee221..6fca22c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -238,16 +238,19 @@ static int h5_close(struct hci_uart *hu)
 	return 0;
 }
 
-static void h5_pkt_cull(struct h5 *h5)
+static void h5_pkt_cull(struct hci_uart *hu)
 {
+	struct h5 *h5 = hu->priv;
 	struct sk_buff *skb, *tmp;
 	unsigned long flags;
 	int i, to_remove;
+	bool was_full;
 	u8 seq;
 
 	spin_lock_irqsave(&h5->unack.lock, flags);
 
 	to_remove = skb_queue_len(&h5->unack);
+	was_full = to_remove == h5->tx_win;
 	if (to_remove == 0)
 		goto unlock;
 
@@ -278,6 +281,8 @@ static void h5_pkt_cull(struct h5 *h5)
 
 unlock:
 	spin_unlock_irqrestore(&h5->unack.lock, flags);
+	if (was_full && to_remove > 0 && !skb_queue_empty(&h5->rel))
+		hci_uart_tx_wakeup(hu);
 }
 
 static void h5_handle_internal_rx(struct hci_uart *hu)
@@ -354,7 +359,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 
 	h5->rx_ack = H5_HDR_ACK(hdr);
 
-	h5_pkt_cull(h5);
+	h5_pkt_cull(hu);
 
 	switch (H5_HDR_PKT_TYPE(hdr)) {
 	case HCI_EVENT_PKT:
@@ -419,6 +424,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
 		BT_ERR("Out-of-order packet arrived (%u != %u)",
 		       H5_HDR_SEQ(hdr), h5->tx_ack);
+		set_bit(H5_TX_ACK_REQ, &h5->flags);
+		hci_uart_tx_wakeup(hu);
 		h5_reset_rx(h5);
 		return 0;
 	}
-- 
2.7.4

