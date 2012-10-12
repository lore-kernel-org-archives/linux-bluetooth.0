Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 2/2] Bluetooth: Add chan->ops->defer()
Date: Fri, 12 Oct 2012 19:35:24 +0800
Message-Id: <1350041724-29948-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1350041724-29948-1-git-send-email-gustavo@padovan.org>
References: <1350041724-29948-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

When DEFER_SETUP is set defer() will trigger an authorization
request to the userspace.

l2cap_chan_no_defer() is meant to be used when one does not want to
support DEFER_SETUP (A2MP for example).

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    | 10 +++-------
 net/bluetooth/l2cap_sock.c    | 10 ++++++++++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index caab98c..6e23afd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -541,6 +541,7 @@ struct l2cap_ops {
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state);
 	void			(*ready) (struct l2cap_chan *chan);
+	void			(*defer) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
@@ -748,6 +749,10 @@ static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
+{
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 3ff4dc9..7bf9a10 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -699,6 +699,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.new_connection = l2cap_chan_no_new_connection,
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
+	.defer = l2cap_chan_no_defer,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9d84050..314d955 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1120,11 +1120,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				lock_sock(sk);
 				if (test_bit(BT_SK_DEFER_SETUP,
 					     &bt_sk(sk)->flags)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					if (parent)
-						parent->sk_data_ready(parent, 0);
+					chan->ops->defer(chan);
 
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
@@ -3460,7 +3458,7 @@ static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
-				parent->sk_data_ready(parent, 0);
+				chan->ops->defer(chan);
 			} else {
 				__l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
@@ -5523,11 +5521,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			if (!status) {
 				if (test_bit(BT_SK_DEFER_SETUP,
 					     &bt_sk(sk)->flags)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-					if (parent)
-						parent->sk_data_ready(parent, 0);
+					chan->ops->defer(chan);
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d5093b8..5fae2bd 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1081,6 +1081,15 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 	release_sock(sk);
 }
 
+static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	struct sock *parent = bt_sk(sk)->parent;
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1089,6 +1098,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.ready		= l2cap_sock_ready_cb,
+	.defer		= l2cap_sock_defer_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
 
-- 
1.7.11.4

