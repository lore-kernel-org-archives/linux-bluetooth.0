Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:btmrvl_sdio: Comparison to NULL re-written
Date: Fri, 25 Sep 2015 09:04:18 +0000
Message-ID: <20150925090413.GA5396@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

NOT NULL comparison modified to be readable, reported
by checkpatch.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdi=
o.c
index b9978a7..4487183 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -619,7 +619,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_priva=
te *priv)
=20
 	/* Allocate buffer */
 	skb =3D bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
-	if (skb =3D=3D NULL) {
+	if (!skb) {
 		BT_ERR("No free skb");
 		ret =3D -ENOMEM;
 		goto exit;
--=20
1.9.1
