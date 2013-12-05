Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 32/32] Bluetooth: Simplify l2cap_chan initialization for LE CoC
Date: Thu,  5 Dec 2013 15:11:30 +0200
Message-Id: <1386249090-10236-33-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The values in l2cap_chan that are used for actually transmitting data
only need to be initialized right after we've received an L2CAP Connect
Request or just before we send one. The only thing that we need to
initialize though bind() and connect() is the chan->mode value. This way
all other initializations can be done in the l2cap_le_flowctl_init
function (which now becomes private to l2cap_core.c) and the
l2cap_le_flowctl_start function can be completely removed.

Also, since the l2cap_sock_init function initializes the imtu and omtu
to adequate values these do not need to be part of l2cap_le_flowctl_init.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 -
 net/bluetooth/l2cap_core.c    | 33 +++++++++++----------------------
 net/bluetooth/l2cap_sock.c    |  4 ++--
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ef6ca5fa8f5e..458245cd26fc 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -873,7 +873,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
-void l2cap_le_flowctl_init(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 326d323ddfe3..08c7259c4ad7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -500,9 +500,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 
 void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 {
-	chan->imtu = L2CAP_DEFAULT_MTU;
-	chan->omtu = L2CAP_LE_MIN_MTU;
-	chan->mode = L2CAP_MODE_LE_FLOWCTL;
+	chan->sdu = NULL;
+	chan->sdu_last_frag = NULL;
+	chan->sdu_len = 0;
 	chan->tx_credits = 0;
 	chan->rx_credits = le_max_credits;
 
@@ -510,6 +510,8 @@ void l2cap_le_flowctl_init(struct l2cap_chan *chan)
 		chan->mps = chan->imtu;
 	else
 		chan->mps = L2CAP_LE_DEFAULT_MPS;
+
+	skb_queue_head_init(&chan->tx_q);
 }
 
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -1208,31 +1210,14 @@ static void l2cap_move_done(struct l2cap_chan *chan)
 	}
 }
 
-static void l2cap_le_flowctl_start(struct l2cap_chan *chan)
-{
-	chan->sdu = NULL;
-	chan->sdu_last_frag = NULL;
-	chan->sdu_len = 0;
-
-	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
-		chan->mps = chan->imtu;
-	else
-		chan->mps = le_default_mps;
-
-	skb_queue_head_init(&chan->tx_q);
-
-	if (!chan->tx_credits)
-		chan->ops->suspend(chan);
-}
-
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	if (chan->mode == L2CAP_MODE_LE_FLOWCTL)
-		l2cap_le_flowctl_start(chan);
+	if (chan->mode == L2CAP_MODE_LE_FLOWCTL && !chan->tx_credits)
+		chan->ops->suspend(chan);
 
 	chan->state = BT_CONNECTED;
 
@@ -1909,7 +1894,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
+		break;
 	case L2CAP_MODE_LE_FLOWCTL:
+		l2cap_le_flowctl_init(chan);
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -5661,6 +5648,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	l2cap_le_flowctl_init(chan);
+
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_type(conn->hcon, conn->hcon->src_type);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f4471fd6e99e..cebeca136551 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -153,7 +153,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	chan->src_type = la.l2_bdaddr_type;
 
 	if (chan->psm && bdaddr_type_is_le(chan->src_type))
-		l2cap_le_flowctl_init(chan);
+		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	chan->state = BT_BOUND;
 	sk->sk_state = BT_BOUND;
@@ -226,7 +226,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	}
 
 	if (chan->psm && bdaddr_type_is_le(chan->src_type))
-		l2cap_le_flowctl_init(chan);
+		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
-- 
1.8.4.2

