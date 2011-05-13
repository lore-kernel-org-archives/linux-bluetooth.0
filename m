Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 6/7] Bluetooth: Remove export of l2cap_chan_clear_timer()
Date: Fri, 13 May 2011 16:20:49 -0300
Message-Id: <1305314450-25493-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-6-git-send-email-padovan@profusion.mobi>
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-3-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-5-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The call to l2cap_chan_clear_timer() is not really needed in l2cap_sock.c.
This patch also adds a call to l2cap_chan_clear_timer() to the only place
in __l2cap_sock_close() that wasn't calling it. It's safe call it there
because l2cap_chan_clear_timer() check first for timer_peding().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |    3 ++-
 net/bluetooth/l2cap_sock.c    |    1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index efb1fc4..1c89c7f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -463,7 +463,6 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 
-void l2cap_chan_clear_timer(struct l2cap_chan *chan);
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index afd648e..1390d0b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -216,7 +216,7 @@ static void l2cap_chan_set_timer(struct l2cap_chan *chan, long timeout)
 	       sock_hold(chan->sk);
 }
 
-void l2cap_chan_clear_timer(struct l2cap_chan *chan)
+static void l2cap_chan_clear_timer(struct l2cap_chan *chan)
 {
        BT_DBG("chan %p state %d", chan, chan->sk->sk_state);
 
@@ -423,6 +423,7 @@ void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONFIG:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
+			l2cap_chan_clear_timer(chan);
 			l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, chan, reason);
 		} else
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 14b686b..aca1d56 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -707,7 +707,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
-		l2cap_chan_clear_timer(chan);
 		__l2cap_chan_close(chan, 0);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
-- 
1.7.5.rc3

