Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Return rfcomm session pointers to avoid freed session
Date: Sat, 11 Aug 2012 19:47:08 +0100
Message-Id: <1344710830-10301-3-git-send-email-djenkins@mvista.com>
In-Reply-To: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
References: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unfortunately, the design retains copies of the s rfcomm session
pointer in various code blocks and this invites the reuse of a
freed session pointer.

Therefore, return the rfcomm session pointer back up the call stack
to avoid reusing a freed rfcomm session pointer. When the rfcomm
session is deleted, NULL is passed up the call stack.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 net/bluetooth/rfcomm/core.c |   88 +++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index b0805c1..24d4d3c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -83,7 +83,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 							u8 sec_level,
 							int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
-static void rfcomm_session_del(struct rfcomm_session *s);
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
@@ -612,9 +612,13 @@ static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
 	return s;
 }
 
-static void rfcomm_session_del(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s)
 {
-	int state = s->state;
+	int state;
+
+	BUG_ON(s == NULL);
+
+	state = s->state;
 
 	BT_DBG("session %p state %ld", s, s->state);
 
@@ -626,6 +630,8 @@ static void rfcomm_session_del(struct rfcomm_session *s)
 
 	if (state != BT_LISTEN)
 		module_put(THIS_MODULE);
+
+	return NULL;
 }
 
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
@@ -644,11 +650,14 @@ static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
 	return NULL;
 }
 
-static void rfcomm_session_close(struct rfcomm_session *s, int err)
+static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
+							int err)
 {
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
 
+	BUG_ON(s == NULL);
+
 	BT_DBG("session %p state %ld err %d", s, s->state, err);
 
 	s->state = BT_CLOSED;
@@ -660,7 +669,7 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 		__rfcomm_dlc_close(d, err);
 	}
 
-	rfcomm_session_del(s);
+	return rfcomm_session_del(s);
 }
 
 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -712,8 +721,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	if (*err == 0 || *err == -EINPROGRESS)
 		return s;
 
-	rfcomm_session_del(s);
-	return NULL;
+	return rfcomm_session_del(s);
 
 failed:
 	sock_release(sock);
@@ -1102,7 +1110,7 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
 }
 
 /* ---- RFCOMM frame reception ---- */
-static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 {
 	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
 
@@ -1111,7 +1119,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 		struct rfcomm_dlc *d = rfcomm_dlc_get(s, dlci);
 		if (!d) {
 			rfcomm_send_dm(s, dlci);
-			return 0;
+			return s;
 		}
 
 		switch (d->state) {
@@ -1147,14 +1155,14 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			rfcomm_session_del(s);
+			s = rfcomm_session_del(s);
 			break;
 		}
 	}
-	return 0;
+	return s;
 }
 
-static int rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
 {
 	int err = 0;
 
@@ -1179,12 +1187,13 @@ static int rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
 			err = ECONNRESET;
 
 		s->state = BT_CLOSED;
-		rfcomm_session_close(s, err);
+		s = rfcomm_session_close(s, err);
 	}
-	return 0;
+	return s;
 }
 
-static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
+						u8 dlci)
 {
 	int err = 0;
 
@@ -1214,10 +1223,10 @@ static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
 			err = ECONNRESET;
 
 		s->state = BT_CLOSED;
-		rfcomm_session_close(s, err);
+		s = rfcomm_session_close(s, err);
 	}
 
-	return 0;
+	return s;
 }
 
 void rfcomm_dlc_accept(struct rfcomm_dlc *d)
@@ -1638,11 +1647,18 @@ drop:
 	return 0;
 }
 
-static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
+static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
+						struct sk_buff *skb)
 {
 	struct rfcomm_hdr *hdr = (void *) skb->data;
 	u8 type, dlci, fcs;
 
+	if (!s) {
+		/* no session, so free socket data */
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
@@ -1653,7 +1669,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 	if (__check_fcs(skb->data, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
-		return -EILSEQ;
+		return s;
 	}
 
 	if (__test_ea(hdr->len))
@@ -1669,22 +1685,23 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 
 	case RFCOMM_DISC:
 		if (__test_pf(hdr->ctrl))
-			rfcomm_recv_disc(s, dlci);
+			s = rfcomm_recv_disc(s, dlci);
 		break;
 
 	case RFCOMM_UA:
 		if (__test_pf(hdr->ctrl))
-			rfcomm_recv_ua(s, dlci);
+			s = rfcomm_recv_ua(s, dlci);
 		break;
 
 	case RFCOMM_DM:
-		rfcomm_recv_dm(s, dlci);
+		s = rfcomm_recv_dm(s, dlci);
 		break;
 
 	case RFCOMM_UIH:
-		if (dlci)
-			return rfcomm_recv_data(s, dlci, __test_pf(hdr->ctrl), skb);
-
+		if (dlci) {
+			rfcomm_recv_data(s, dlci, __test_pf(hdr->ctrl), skb);
+			return s;
+		}
 		rfcomm_recv_mcc(s, skb);
 		break;
 
@@ -1693,7 +1710,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 		break;
 	}
 	kfree_skb(skb);
-	return 0;
+	return s;
 }
 
 /* ---- Connection and data processing ---- */
@@ -1775,6 +1792,8 @@ static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
 
+	BUG_ON(s == NULL);
+
 	BT_DBG("session %p state %ld", s, s->state);
 
 	list_for_each_safe(p, n, &s->dlcs) {
@@ -1830,7 +1849,7 @@ static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
 	}
 }
 
-static inline void rfcomm_process_rx(struct rfcomm_session *s)
+static inline struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 {
 	struct socket *sock = s->sock;
 	struct sock *sk = sock->sk;
@@ -1842,13 +1861,15 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
 		if (!skb_linearize(skb))
-			rfcomm_recv_frame(s, skb);
+			s = rfcomm_recv_frame(s, skb);
 		else
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED)
-		rfcomm_session_close(s, sk->sk_err);
+	if (s && (sk->sk_state == BT_CLOSED))
+		s = rfcomm_session_close(s, sk->sk_err);
+
+	return s;
 }
 
 static inline void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1902,7 +1923,7 @@ static inline void rfcomm_check_connection(struct rfcomm_session *s)
 
 	case BT_CLOSED:
 		s->state = BT_CLOSED;
-		rfcomm_session_close(s, sk->sk_err);
+		s = rfcomm_session_close(s, sk->sk_err);
 		break;
 	}
 }
@@ -1934,11 +1955,12 @@ static inline void rfcomm_process_sessions(void)
 			break;
 
 		default:
-			rfcomm_process_rx(s);
+			s = rfcomm_process_rx(s);
 			break;
 		}
 
-		rfcomm_process_dlcs(s);
+		if (s)
+			rfcomm_process_dlcs(s);
 	}
 
 	rfcomm_unlock();
-- 
1.7.10.1

