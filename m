Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 8/8] Bluetooth: Add chan->ops->authorize
Date: Wed, 23 May 2012 22:12:44 -0300
Message-Id: <1337821964-4618-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337821964-4618-8-git-send-email-gustavo@padovan.org>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <1337821964-4618-5-git-send-email-gustavo@padovan.org>
 <1337821964-4618-6-git-send-email-gustavo@padovan.org>
 <1337821964-4618-7-git-send-email-gustavo@padovan.org>
 <1337821964-4618-8-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

When DEFER_SETUP is set authorize() will trigger an authorization request
to the userspace.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   14 ++++++--------
 net/bluetooth/l2cap_sock.c    |   12 ++++++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4f81d08..94e375a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -531,6 +531,7 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 	void			(*ready) (void *data);
+	void			(*authorize) (void *data);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1305b3b..22ba699 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1058,12 +1058,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				lock_sock(sk);
 				if (test_bit(CONF_DEFER_SETUP,
 					     &chan->conf_state)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					if (parent)
-						parent->sk_data_ready(parent, 0);
-
+					if(chan->ops->authorize)
+						chan->ops->authorize(chan->data);
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
@@ -3380,7 +3378,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
-				parent->sk_data_ready(parent, 0);
+				if(chan->ops->authorize)
+					chan->ops->authorize(chan->data);
 			} else {
 				__l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
@@ -5408,11 +5407,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			if (!status) {
 				if (test_bit(CONF_DEFER_SETUP,
 					     &chan->conf_state)) {
-					struct sock *parent = bt_sk(sk)->parent;
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-					if (parent)
-						parent->sk_data_ready(parent, 0);
+					if(chan->ops->authorize)
+						chan->ops->authorize(chan->data);
 				} else {
 					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index dac7b2c..d2a81f1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1047,6 +1047,17 @@ static void l2cap_sock_ready_cb(void *data)
 	release_sock(sk);
 }
 
+static void l2cap_sock_authorize_cb(void *data)
+{
+	struct sock *sk = data;
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
@@ -1056,6 +1067,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 	.ready		= l2cap_sock_ready_cb,
+	.authorize	= l2cap_sock_authorize_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.10.1

