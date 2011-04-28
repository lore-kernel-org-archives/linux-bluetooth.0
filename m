Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/3] Bluetooth: Handle psm == 0 case inside l2cap_add_psm()
Date: Thu, 28 Apr 2011 02:26:59 -0300
Message-Id: <1303968420-12719-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1303968420-12719-1-git-send-email-padovan@profusion.mobi>
References: <1303968420-12719-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the user doesn't specify a psm we have the choose one for the
channel. Now we do this inside l2cap_add_psm().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/l2cap_core.c    |   32 ++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c    |   22 ----------------------
 3 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f5f3c2c..fb3f90e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -458,7 +458,6 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
 void l2cap_streaming_send(struct l2cap_chan *chan);
 int l2cap_ertm_send(struct l2cap_chan *chan);
 
-struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src);
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 98ddd86..9e3f64f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -135,7 +135,7 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 	return c;
 }
 
-struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
+static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
 {
 	struct sock *sk;
 	struct hlist_node *node;
@@ -153,19 +153,35 @@ found:
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 {
+	int err;
+
 	write_lock_bh(&l2cap_sk_list.lock);
 
-	if (__l2cap_get_sock_by_addr(psm, src)) {
-		write_unlock_bh(&l2cap_sk_list.lock);
-		return -EADDRINUSE;
+	if (psm && __l2cap_get_sock_by_addr(psm, src)) {
+		err = -EADDRINUSE;
+		goto done;
 	}
 
-	chan->psm = psm;
-	chan->sport = psm;
+	if (psm) {
+		chan->psm = psm;
+		chan->sport = psm;
+		err = 0;
+	} else {
+		u16 p;
 
-	write_unlock_bh(&l2cap_sk_list.lock);
+		err = -EINVAL;
+		for (p = 0x1001; p < 0x1100; p += 2)
+			if (!__l2cap_get_sock_by_addr(cpu_to_le16(p), src)) {
+				chan->psm   = cpu_to_le16(p);
+				chan->sport = cpu_to_le16(p);
+				err = 0;
+				break;
+			}
+	}
 
-	return 0;
+done:
+	write_unlock_bh(&l2cap_sk_list.lock);
+	return err;
 }
 
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 2156dce..aca99cd 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -256,28 +256,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	if (!chan->psm && !chan->scid) {
-		bdaddr_t *src = &bt_sk(sk)->src;
-		u16 psm;
-
-		err = -EINVAL;
-
-		write_lock_bh(&l2cap_sk_list.lock);
-
-		for (psm = 0x1001; psm < 0x1100; psm += 2)
-			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
-				chan->psm   = cpu_to_le16(psm);
-				chan->sport = cpu_to_le16(psm);
-				err = 0;
-				break;
-			}
-
-		write_unlock_bh(&l2cap_sk_list.lock);
-
-		if (err < 0)
-			goto done;
-	}
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = BT_LISTEN;
-- 
1.7.5.rc1

