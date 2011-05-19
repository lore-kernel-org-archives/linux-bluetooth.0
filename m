Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 17:47:12 -0400 (EDT)
Message-Id: <20110519.174712.485186818693543128.davem@davemloft.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Kill set but unused variable 'pi' in
 l2cap_data_channel()
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a86f9ba..84ebe8d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3667,7 +3667,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 {
 	struct l2cap_chan *chan;
 	struct sock *sk = NULL;
-	struct l2cap_pinfo *pi;
 	u16 control;
 	u8 tx_seq;
 	int len;
@@ -3679,7 +3678,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	}
 
 	sk = chan->sk;
-	pi = l2cap_pi(sk);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
