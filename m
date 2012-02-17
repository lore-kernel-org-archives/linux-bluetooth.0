Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 04/16] Bluetooth: Do not use sk lock in get_chan functions
Date: Fri, 17 Feb 2012 15:44:00 +0200
Message-Id: <1329486252-25252-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Take explicit lock. This change is needed to get rid of
socket locks in L2CAP core code. Socket locks will be changed
by chan locks in the following patches.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 18a9742..90e29ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -105,9 +105,8 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
-	if (c)
-		lock_sock(c->sk);
 	mutex_unlock(&conn->chan_lock);
+
 	return c;
 }
 
@@ -128,9 +127,8 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
-	if (c)
-		lock_sock(c->sk);
 	mutex_unlock(&conn->chan_lock);
+
 	return c;
 }
 
@@ -2743,6 +2741,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	err = 0;
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
@@ -2805,6 +2804,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		return -ENOENT;
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
@@ -2917,6 +2917,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		return 0;
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
@@ -3027,6 +3028,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	}
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
@@ -3065,6 +3067,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	}
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	l2cap_chan_del(chan, 0);
 	release_sock(sk);
@@ -4231,6 +4234,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	}
 
 	sk = chan->sk;
+	lock_sock(sk);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
@@ -4661,6 +4665,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
+			lock_sock(sk);
 
 			if (chan->imtu < len - L2CAP_HDR_SIZE) {
 				BT_ERR("Frame exceeding recv MTU (len %d, "
-- 
1.7.9

