Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 07/10] Bluetooth: Add chan->ops->defer()
Date: Sun, 27 May 2012 22:27:57 -0300
Message-Id: <1338168480-9646-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

When DEFER_SETUP is set defer() will trigger an authorization request
to the userspace.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   14 ++++++--------
 net/bluetooth/l2cap_sock.c    |   12 ++++++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0ea4cf1..6d0864e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -535,6 +535,7 @@ struct l2cap_ops {
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state);
 	void			(*ready) (struct l2cap_chan *chan);
+	void			(*defer) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d0c1ebe..35c2c52 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1058,12 +1058,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				lock_sock(sk);
 				if (test_bit(CONF_DEFER_SETUP,
 					     &chan->conf_state)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					if (parent)
-						parent->sk_data_ready(parent, 0);
-
+					if(chan->ops->defer)
+						chan->ops->defer(chan->data);
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
@@ -3381,7 +3379,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
-				parent->sk_data_ready(parent, 0);
+				if(chan->ops->defer)
+					chan->ops->defer(chan->data);
 			} else {
 				__l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
@@ -5409,11 +5408,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			if (!status) {
 				if (test_bit(CONF_DEFER_SETUP,
 					     &chan->conf_state)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-					if (parent)
-						parent->sk_data_ready(parent, 0);
+					if(chan->ops->defer)
+						chan->ops->defer(chan->data);
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a421a4e..e81e910 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1044,6 +1044,17 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 	release_sock(sk);
 }
 
+static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	struct sock *parent;
+
+	parent = bt_sk(sk)->parent;
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1052,6 +1063,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.ready		= l2cap_sock_ready_cb,
+	.defer		= l2cap_sock_defer_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
 
-- 
1.7.10.2

