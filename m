Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 2/7] Bluetooth: BCSP fails to ACK re-transmitted frames from the peer
Date: Fri, 23 Sep 2016 18:56:27 +0100
Message-ID: <1474653392-28770-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Send an ACK frame with the current txack value in response to
every received reliable frame unless a TX reliable frame is being
sent. This modification allows re-transmitted frames from the remote
peer to be acknowledged rather than ignored. It means that the remote
peer knows which frame number to start re-transmitting from.

Without this modification, the recovery time to a missing frame
from the remote peer was unnecessarily being extended because the
headers of the out of order reliable frames were being discarded rather
than being processed. The frame headers of received frames will
indicate whether the local peer's transmissions have been
acknowledged by the remote peer. Therefore, the local peer may
unnecessarily re-transmit despite the remote peer already indicating
that the frame had been acknowledged in out of order reliable frame.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
---
 drivers/bluetooth/hci_bcsp.c | 85 ++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 2628b36..a2c921f 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -488,13 +488,28 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
 static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
-	int pass_up;
+	int pass_up = 0;
 
 	if (bcsp->rx_skb->data[0] & 0x80) {	/* reliable pkt */
 		BT_DBG("Received seqno %u from card", bcsp->rxseq_txack);
-		bcsp->rxseq_txack++;
-		bcsp->rxseq_txack %= 0x8;
-		bcsp->txack_req    = 1;
+
+		/* check the rx sequence number is as expected */
+		if ((bcsp->rx_skb->data[0] & 0x07) == bcsp->rxseq_txack) {
+			bcsp->rxseq_txack++;
+			bcsp->rxseq_txack %= 0x8;
+		} else {
+			/* handle re-transmitted packet or
+			 * when packet was missed
+			 */
+			BT_ERR("Out-of-order packet arrived, got %u expected %u",
+			       bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
+
+			/* do not process out-of-order packet payload */
+			pass_up = 2;
+		}
+
+		/* send current txack value to all received reliable packets */
+		bcsp->txack_req = 1;
 
 		/* If needed, transmit an ack pkt */
 		hci_uart_tx_wakeup(hu);
@@ -503,26 +518,33 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 	bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
 	BT_DBG("Request for pkt %u from card", bcsp->rxack);
 
+	/* handle received ACK indications,
+	 * including those from out-of-order packets
+	 */
 	bcsp_pkt_cull(bcsp);
-	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
-	    bcsp->rx_skb->data[0] & 0x80) {
-		hci_skb_pkt_type(bcsp->rx_skb) = HCI_ACLDATA_PKT;
-		pass_up = 1;
-	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
-		   bcsp->rx_skb->data[0] & 0x80) {
-		hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
-		pass_up = 1;
-	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
-		hci_skb_pkt_type(bcsp->rx_skb) = HCI_SCODATA_PKT;
-		pass_up = 1;
-	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
-		   !(bcsp->rx_skb->data[0] & 0x80)) {
-		bcsp_handle_le_pkt(hu);
-		pass_up = 0;
-	} else
-		pass_up = 0;
-
-	if (!pass_up) {
+
+	if (pass_up != 2) {
+		if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
+		    (bcsp->rx_skb->data[0] & 0x80)) {
+			hci_skb_pkt_type(bcsp->rx_skb) = HCI_ACLDATA_PKT;
+			pass_up = 1;
+		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
+			   (bcsp->rx_skb->data[0] & 0x80)) {
+			hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
+			pass_up = 1;
+		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
+			hci_skb_pkt_type(bcsp->rx_skb) = HCI_SCODATA_PKT;
+			pass_up = 1;
+		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
+			   !(bcsp->rx_skb->data[0] & 0x80)) {
+			bcsp_handle_le_pkt(hu);
+			pass_up = 0;
+		} else {
+			pass_up = 0;
+		}
+	}
+
+	if (pass_up == 0) {
 		struct hci_event_hdr hdr;
 		u8 desc = (bcsp->rx_skb->data[1] & 0x0f);
 
@@ -547,11 +569,16 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 			}
 		} else
 			kfree_skb(bcsp->rx_skb);
-	} else {
+	} else if (pass_up == 1) {
 		/* Pull out BCSP hdr */
 		skb_pull(bcsp->rx_skb, 4);
 
 		hci_recv_frame(hu->hdev, bcsp->rx_skb);
+	} else {
+		/* ignore packet payload of already ACKed re-transmitted
+		 * packets or when a packet was missed in the BCSP window
+		 */
+		kfree_skb(bcsp->rx_skb);
 	}
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
@@ -597,16 +624,6 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 				bcsp->rx_count = 0;
 				continue;
 			}
-			if (bcsp->rx_skb->data[0] & 0x80 &&	/* reliable pkt */
-			    (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
-				BT_ERR("Out-of-order packet arrived, got %u expected %u",
-				       bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
-
-				kfree_skb(bcsp->rx_skb);
-				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
-				bcsp->rx_count = 0;
-				continue;
-			}
 			bcsp->rx_state = BCSP_W4_DATA;
 			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) +
 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
-- 
2.7.4
