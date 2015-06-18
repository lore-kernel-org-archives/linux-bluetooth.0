Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: bt3c_cs: Fix coding style -- clean up
Date: Thu, 18 Jun 2015 13:51:11 +0000
Message-ID: <20150618135102.GA12844@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix for braces {} are not necessary for single statement blocks
reported by checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/bt3c_cs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 6de97b3..3c18233 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -202,9 +202,8 @@ static void bt3c_write_wakeup(struct bt3c_info *info)
 		/* Send frame */
 		len =3D bt3c_write(iobase, 256, skb->data, skb->len);
=20
-		if (len !=3D skb->len) {
+		if (len !=3D skb->len)
 			BT_ERR("Very strange");
-		}
=20
 		kfree_skb(skb);
=20
--=20
1.7.0.4
