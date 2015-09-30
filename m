Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_h5: clean up hci_h5 code
Date: Wed, 30 Sep 2015 13:02:05 +0000
Message-ID: <20150930130159.GA5696@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

This patch fixes checkpatch warnings:
- Comparison to NULL could be re-written
- no space required after a cast

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_h5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b35b238..abee221 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -128,7 +128,7 @@ static void h5_timed_event(unsigned long arg)
 {
 	const unsigned char sync_req[] =3D { 0x01, 0x7e };
 	unsigned char conf_req[] =3D { 0x03, 0xfc, 0x01 };
-	struct hci_uart *hu =3D (struct hci_uart *) arg;
+	struct hci_uart *hu =3D (struct hci_uart *)arg;
 	struct h5 *h5 =3D hu->priv;
 	struct sk_buff *skb;
 	unsigned long flags;
@@ -210,7 +210,7 @@ static int h5_open(struct hci_uart *hu)
=20
 	init_timer(&h5->timer);
 	h5->timer.function =3D h5_timed_event;
-	h5->timer.data =3D (unsigned long) hu;
+	h5->timer.data =3D (unsigned long)hu;
=20
 	h5->tx_win =3D H5_TX_WIN_MAX;
=20
@@ -453,7 +453,7 @@ static int h5_rx_pkt_start(struct hci_uart *hu, unsigne=
d char c)
 		return -ENOMEM;
 	}
=20
-	h5->rx_skb->dev =3D (void *) hu->hdev;
+	h5->rx_skb->dev =3D (void *)hu->hdev;
=20
 	return 0;
 }
@@ -696,7 +696,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 	}
=20
 	skb =3D skb_dequeue(&h5->unrel);
-	if (skb !=3D NULL) {
+	if (skb) {
 		nskb =3D h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
 				      skb->data, skb->len);
 		if (nskb) {
@@ -714,7 +714,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 		goto unlock;
=20
 	skb =3D skb_dequeue(&h5->rel);
-	if (skb !=3D NULL) {
+	if (skb) {
 		nskb =3D h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
 				      skb->data, skb->len);
 		if (nskb) {
--=20
1.9.1
