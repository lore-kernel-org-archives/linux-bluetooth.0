Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] bluetooth: hci_bcsp: Clean up code Fix
Date: Thu, 4 Jun 2015 07:09:01 +0000
Message-ID: <20150604070848.GA8533@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix for spaces prohibited around that '->' reported by checkpatch
and space prohibited between function name and open parenthesis '('

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_bcsp.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index dc8e3d4..94e0046 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -285,7 +285,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu=
)
 	struct bcsp_struct *bcsp =3D hu->priv;
 	unsigned long flags;
 	struct sk_buff *skb;
-=09
+
 	/* First of all, check for unreliable messages in the queue,
 	   since they have priority */
=20
@@ -436,7 +436,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_str=
uct *bcsp, unsigned char
 			break;
 		default:
 			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) !=3D 0 &&=20
+			if ((bcsp->rx_skb->data[0] & 0x40) !=3D 0 &&
 					bcsp->rx_state !=3D BCSP_W4_CRC)
 				bcsp_crc_update(&bcsp->message_crc, byte);
 			bcsp->rx_count--;
@@ -447,24 +447,24 @@ static inline void bcsp_unslip_one_byte(struct bcsp_s=
truct *bcsp, unsigned char
 		switch (byte) {
 		case 0xdc:
 			memcpy(skb_put(bcsp->rx_skb, 1), &c0, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) !=3D 0 &&=20
+			if ((bcsp->rx_skb->data[0] & 0x40) !=3D 0 &&
 					bcsp->rx_state !=3D BCSP_W4_CRC)
-				bcsp_crc_update(&bcsp-> message_crc, 0xc0);
+				bcsp_crc_update(&bcsp->message_crc, 0xc0);
 			bcsp->rx_esc_state =3D BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
 			break;
=20
 		case 0xdd:
 			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
-			if ((bcsp->rx_skb-> data[0] & 0x40) !=3D 0 &&=20
-					bcsp->rx_state !=3D BCSP_W4_CRC)=20
-				bcsp_crc_update(&bcsp-> message_crc, 0xdb);
+			if ((bcsp->rx_skb->data[0] & 0x40) !=3D 0 &&
+					bcsp->rx_state !=3D BCSP_W4_CRC)
+				bcsp_crc_update(&bcsp->message_crc, 0xdb);
 			bcsp->rx_esc_state =3D BCSP_ESCSTATE_NOESC;
 			bcsp->rx_count--;
 			break;
=20
 		default:
-			BT_ERR ("Invalid byte %02x after esc byte", byte);
+			BT_ERR("Invalid byte %02x after esc byte", byte);
 			kfree_skb(bcsp->rx_skb);
 			bcsp->rx_skb =3D NULL;
 			bcsp->rx_state =3D BCSP_W4_PKT_DELIMITER;
@@ -527,9 +527,9 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
=20
 				hci_recv_frame(hu->hdev, bcsp->rx_skb);
 			} else {
-				BT_ERR ("Packet for unknown channel (%u %s)",
+				BT_ERR("Packet for unknown channel (%u %s)",
 					bcsp->rx_skb->data[1] & 0x0f,
-					bcsp->rx_skb->data[0] & 0x80 ?=20
+					bcsp->rx_skb->data[0] & 0x80 ?
 					"reliable" : "unreliable");
 				kfree_skb(bcsp->rx_skb);
 			}
@@ -557,7 +557,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
 	struct bcsp_struct *bcsp =3D hu->priv;
 	const unsigned char *ptr;
=20
-	BT_DBG("hu %p count %d rx_state %d rx_count %ld",=20
+	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 		hu, count, bcsp->rx_state, bcsp->rx_count);
=20
 	ptr =3D data;
@@ -586,7 +586,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
 				continue;
 			}
 			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
-			    		&& (bcsp->rx_skb->data[0] & 0x07) !=3D bcsp->rxseq_txack) {
+					&& (bcsp->rx_skb->data[0] & 0x07) !=3D bcsp->rxseq_txack) {
 				BT_ERR ("Out-of-order packet arrived, got %u expected %u",
 					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
=20
@@ -596,7 +596,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
 				continue;
 			}
 			bcsp->rx_state =3D BCSP_W4_DATA;
-			bcsp->rx_count =3D (bcsp->rx_skb->data[1] >> 4) +=20
+			bcsp->rx_count =3D (bcsp->rx_skb->data[1] >> 4) +
 					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
 			continue;
=20
@@ -648,7 +648,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
 				BCSP_CRC_INIT(bcsp->message_crc);
=20
 				/* Do not increment ptr or decrement count
-				 * Allocate packet. Max len of a BCSP pkt=3D=20
+				 * Allocate packet. Max len of a BCSP pkt=3D
 				 * 0xFFF (payload) +4 (header) +2 (crc) */
=20
 				bcsp->rx_skb =3D bt_skb_alloc(0x1005, GFP_ATOMIC);
--=20
1.7.0.4
