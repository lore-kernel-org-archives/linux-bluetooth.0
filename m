Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce L2CAP channel callback for resuming
Date: Mon, 14 Oct 2013 02:53:54 -0700
Message-Id: <1381744434-35580-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clearing the BT_SK_SUSPEND socket flag from the L2CAP core is causing
a dependency on the socket. So intead of doing that, use a channel
callback into the socket handling to resume.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 6 +-----
 net/bluetooth/l2cap_sock.c    | 9 +++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1a38ede..07757a2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -554,6 +554,7 @@ struct l2cap_ops {
 						 int state);
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
+	void			(*resume) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e5819cb..0c3446d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6669,11 +6669,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
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
index f5d9573..fcf012a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1112,6 +1112,14 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 		parent->sk_data_ready(parent, 0);
 }
 
+static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+	sk->sk_state_change(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1121,6 +1129,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.state_change	= l2cap_sock_state_change_cb,
 	.ready		= l2cap_sock_ready_cb,
 	.defer		= l2cap_sock_defer_cb,
+	.resume		= l2cap_sock_resume_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
 
-- 
1.8.3.1

