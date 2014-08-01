Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [RFC] Bluetooth: HCI H5 fast retransmit
Date: Fri,  1 Aug 2014 18:37:56 +0200
Message-Id: <1406911076-8714-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HCI H5 protocol is based on timeout to retransmit dropped packets.
According to the specification, this timeout should be calculated
based on the baudrate and the maximum packet size.

In the current implementation, this timeout is set to 250ms.
Moreover this timer is re-triggered for 250ms at each packet transmission
without taking care of the previous non acked packet timeout.
So, in the worst case, the delay before retransmission of a packet is
tx_win*250ms. Common H5 tx_win is 4.

These delays are not acceptable in case of "real time".
Despite buffering, It may lead to audio cuts with A2DP profile.

Rather than decreasing timeout with a magic value, I propose to implement
a fast retransmit mechanism:
If a sender receives a specified number of invalid acks (basically, duplicate
ACKs), the sender can be reasonably confident that its oldest non-acknowledged
H5 packet was dropped.

This mechanism is out of the H5 specification.
However, without breaking compatibility, it gives good results in practical
tests.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h5.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fede8ca..8092daa 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -45,6 +45,8 @@
  */
 #define H5_MAX_LEN (4 + 0xfff + 2)

+#define H5_MAX_INV_ACK 2
+
 /* Convenience macros for reading Three-wire header values */
 #define H5_HDR_SEQ(hdr)		((hdr)[0] & 0x07)
 #define H5_HDR_ACK(hdr)		(((hdr)[0] >> 3) & 0x07)
@@ -74,6 +76,7 @@ struct h5 {
 	struct sk_buff		*rx_skb;	/* Receive buffer */
 	size_t			rx_pending;	/* Expecting more bytes */
 	u8			rx_ack;		/* Last ack number received */
+	u8			rx_inv_ack;	/* Invalid acks counter */

 	int			(*rx_func) (struct hci_uart *hu, u8 c);

@@ -240,8 +243,16 @@ static void h5_pkt_cull(struct h5 *h5)
 		seq = (seq - 1) % 8;
 	}

-	if (seq != h5->rx_ack)
+	if (seq != h5->rx_ack) {
 		BT_ERR("Controller acked invalid packet");
+		if (++h5->rx_inv_ack >= H5_MAX_INV_ACK) {
+			BT_ERR("H5 fast retransmit");
+			h5->rx_inv_ack = 0;
+			mod_timer(&h5->timer, 0);
+		}
+	} else {
+		h5->rx_inv_ack = 0;
+	}

 	i = 0;
 	skb_queue_walk_safe(&h5->unack, skb, tmp) {
--
1.8.3.2

