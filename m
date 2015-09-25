Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:btmrvl_main : Comparison to NULL re-written
Date: Fri, 25 Sep 2015 09:03:14 +0000
Message-ID: <20150925090310.GA5369@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

NOT NULL comparison modified to be readable, reported
by checkpatch.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/btmrvl_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_mai=
n.c
index bc110f6..050ad6b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -184,7 +184,7 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *=
priv, u16 opcode,
 	}
=20
 	skb =3D bt_skb_alloc(HCI_COMMAND_HDR_SIZE + len, GFP_ATOMIC);
-	if (skb =3D=3D NULL) {
+	if (!skb) {
 		BT_ERR("No free skb");
 		return -ENOMEM;
 	}
--=20
1.9.1
