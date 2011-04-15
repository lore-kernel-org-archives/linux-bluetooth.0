Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Rename l2cap_do_connect() to l2cap_chan_connect()
Date: Fri, 15 Apr 2011 15:17:29 -0300
Message-Id: <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_chan_connect() is a much better name and reflects what this
functions is doing (or will do once socket dependence is removed from the
core).

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |    2 +-
 net/bluetooth/l2cap_sock.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b3bb3d4..f709350 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -466,6 +466,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err);
 struct l2cap_chan *l2cap_chan_alloc(struct sock *sk);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-int l2cap_do_connect(struct l2cap_chan *chan);
+int l2cap_chan_connect(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a3aa26b..05848ee 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -847,7 +847,7 @@ static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 	return node ? sk : sk1;
 }
 
-int l2cap_do_connect(struct l2cap_chan *chan)
+int l2cap_chan_connect(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
 	bdaddr_t *src = &bt_sk(sk)->src;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a29782a..50437c6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -229,7 +229,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	l2cap_pi(sk)->psm = la.l2_psm;
 	l2cap_pi(sk)->dcid = la.l2_cid;
 
-	err = l2cap_do_connect(l2cap_pi(sk)->chan);
+	err = l2cap_chan_connect(l2cap_pi(sk)->chan);
 	if (err)
 		goto done;
 
-- 
1.7.5.rc1

