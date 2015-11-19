Return-Path: <mkarthi3@visteon.com>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] net: bluetooth: remove unneeded variable in l2cap_stream_rx
Date: Thu, 19 Nov 2015 12:05:35 +0000
Message-ID: <20151119120509.GA8228@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Remove unneeded variable used to store return value.
Error reported by coccicheck.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 net/bluetooth/l2cap_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee2..09a1900 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6524,8 +6524,6 @@ static int l2cap_rx(struct l2cap_chan *chan, struct l=
2cap_ctrl *control,
 static int l2cap_stream_rx(struct l2cap_chan *chan, struct l2cap_ctrl *con=
trol,
 			   struct sk_buff *skb)
 {
-	int err =3D 0;
-
 	BT_DBG("chan %p, control %p, skb %p, state %d", chan, control, skb,
 	       chan->rx_state);
=20
@@ -6556,7 +6554,7 @@ static int l2cap_stream_rx(struct l2cap_chan *chan, s=
truct l2cap_ctrl *control,
 	chan->last_acked_seq =3D control->txseq;
 	chan->expected_tx_seq =3D __next_seq(chan, control->txseq);
=20
-	return err;
+	return 0;
 }
=20
 static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
--=20
1.9.1
