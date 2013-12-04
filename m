Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 22/31] Bluetooth: Introduce L2CAP channel callback for suspending
Date: Wed,  4 Dec 2013 16:11:18 +0200
Message-Id: <1386166287-13693-23-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Setting the BT_SK_SUSPEND socket flag from the L2CAP core is causing a
dependency on the socket. So instead of doing that, use a channel
callback into the socket handling to suspend.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8c59ed17ee90..c6c86d0e39c5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -593,6 +593,7 @@ struct l2cap_ops {
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
 	void			(*resume) (struct l2cap_chan *chan);
+	void			(*suspend) (struct l2cap_chan *chan);
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9007def8c619..c2424782c245 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1321,6 +1321,14 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return sk->sk_sndtimeo;
 }
 
+static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+	sk->sk_state_change(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1331,6 +1339,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.ready		= l2cap_sock_ready_cb,
 	.defer		= l2cap_sock_defer_cb,
 	.resume		= l2cap_sock_resume_cb,
+	.suspend	= l2cap_sock_suspend_cb,
 	.set_shutdown	= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo	= l2cap_sock_get_sndtimeo_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
-- 
1.8.4.2

