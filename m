Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCHv2] Bluetooth:hci_bcsp:Fix coding style -- Clean up
Date: Mon, 22 Jun 2015 05:58:02 +0000
Message-ID: <20150622055716.GA3267@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Space prohibited between function name and open parenthesis '('
reported by Checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>

----
V2 Cleaned up the patch to remove trailing whitespace
---

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_bcsp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index dc8e3d4..9b8233b 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -464,7 +464,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_str=
uct *bcsp, unsigned char
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
@@ -610,7 +610,7 @@ static int bcsp_recv(struct hci_uart *hu, const void *d=
ata, int count)
=20
 		case BCSP_W4_CRC:
 			if (bitrev16(bcsp->message_crc) !=3D bscp_get_crc(bcsp)) {
-				BT_ERR ("Checksum failed: computed %04x received %04x",
+				BT_ERR("Checksum failed: computed %04x received %04x",
 					bitrev16(bcsp->message_crc),
 					bscp_get_crc(bcsp));
=20
--=20
1.7.0.4
