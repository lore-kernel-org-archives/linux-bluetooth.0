Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCHv2] bluetooth: hci_bcsp: Clean up code Fix
Date: Tue, 9 Jun 2015 11:51:53 +0000
Message-ID: <20150609115144.GA19399@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix for spaces prohibited around that '->' reported by checkpatch and space=
 prohibited
between function name and open parenthesis '('

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>

---
V3: Reverted back Indentation,Now patch only has above fix, cleanedup
---
---
 drivers/bluetooth/hci_bcsp.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index dc8e3d4..764939d 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
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
+			if ((bcsp->rx_skb->data[0] & 0x40) !=3D 0 &&
 					bcsp->rx_state !=3D BCSP_W4_CRC)=20
-				bcsp_crc_update(&bcsp-> message_crc, 0xdb);
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
@@ -527,7 +527,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
=20
 				hci_recv_frame(hu->hdev, bcsp->rx_skb);
 			} else {
-				BT_ERR ("Packet for unknown channel (%u %s)",
+				BT_ERR("Packet for unknown channel (%u %s)",
 					bcsp->rx_skb->data[1] & 0x0f,
 					bcsp->rx_skb->data[0] & 0x80 ?=20
 					"reliable" : "unreliable");
@@ -587,7 +587,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
 			}
 			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
 			    		&& (bcsp->rx_skb->data[0] & 0x07) !=3D bcsp->rxseq_txack) {
-				BT_ERR ("Out-of-order packet arrived, got %u expected %u",
+				BT_ERR("Out-of-order packet arrived, got %u expected %u",
 					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
=20
 				kfree_skb(bcsp->rx_skb);
--=20
1.7.0.4
