Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 14/16] Bluetooth: Create l2cap->ops->resume()
Date: Thu, 10 Jan 2013 05:47:51 -0200
Message-Id: <1357804073-31582-15-git-send-email-gustavo@padovan.org>
In-Reply-To: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
References: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

resume() will isolate the code the code to get a socket back from the
suspended state when a security elevation happens.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    |  6 +-----
 net/bluetooth/l2cap_sock.c    | 13 +++++++++++++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 574b3ae..cab7773 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -555,6 +555,7 @@ struct l2cap_ops {
 	void			(*defer) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
+	void			(*resume) (struct l2cap_chan *chan);
 };
 
 struct l2cap_conn {
@@ -789,6 +790,10 @@ static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_resume(struct l2cap_chan *chan)
+{
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index ad6e42f..4a542b3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -708,6 +708,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
+	.resume = l2cap_chan_no_resume,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f151775..72dd394 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6315,11 +6315,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (!status && (chan->state == BT_CONNECTED ||
 				chan->state == BT_CONFIG)) {
-			struct sock *sk = chan->sk;
-
-			clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
-			sk->sk_state_change(sk);
-
+			chan->ops->resume(chan);
 			l2cap_check_encryption(chan, encrypt);
 			l2cap_chan_unlock(chan);
 			continue;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 58b4a5d..e7b3291 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1147,6 +1147,18 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 	release_sock(sk);
 }
 
+static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	lock_sock(sk);
+
+	clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+	sk->sk_state_change(sk);
+
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1157,6 +1169,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.ready		= l2cap_sock_ready_cb,
 	.defer		= l2cap_sock_defer_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
+	.resume		= l2cap_sock_resume_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.8.0.2

