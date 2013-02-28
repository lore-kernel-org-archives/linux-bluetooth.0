Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH v2 3/6] Bluetooth: Return RFCOMM session ptrs to avoid freed session
Date: Thu, 28 Feb 2013 14:21:55 +0000
Message-Id: <1362061318-30580-4-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Unfortunately, the design retains local copies of the s RFCOMM
session pointer in various code blocks and this invites the erroneous
access to a freed RFCOMM session structure.

Therefore, return the RFCOMM session pointer back up the call stack
to avoid accessing a freed RFCOMM session structure. When the RFCOMM
session is deleted, NULL is passed up the call stack.

If active DLCs exist when the rfcomm session is terminating,
avoid a memory leak of rfcomm_dlc structures by ensuring that
rfcomm_session_close() is used instead of rfcomm_session_del().

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/rfcomm.h |    3 +-
 net/bluetooth/rfcomm/core.c    |  106 +++++++++++++++++++++-------------------
 2 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index e2e3eca..a4e38ea 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -278,7 +278,8 @@ void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
 
 static inline void rfcomm_session_hold(struct rfcomm_session *s)
 {
-	atomic_inc(&s->refcnt);
+	if (s)
+		atomic_inc(&s->refcnt);
 }
 
 /* ---- RFCOMM sockets ---- */
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ae7124e..60ccb37 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -69,7 +69,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 							u8 sec_level,
 							int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
-static void rfcomm_session_del(struct rfcomm_session *s);
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
@@ -108,10 +108,12 @@ static void rfcomm_schedule(void)
 	wake_up_process(rfcomm_thread);
 }
 
-static void rfcomm_session_put(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_session_put(struct rfcomm_session *s)
 {
-	if (atomic_dec_and_test(&s->refcnt))
-		rfcomm_session_del(s);
+	if (s && atomic_dec_and_test(&s->refcnt))
+		s = rfcomm_session_del(s);
+
+	return s;
 }
 
 /* ---- RFCOMM FCS computation ---- */
@@ -631,7 +633,7 @@ static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
 	return s;
 }
 
-static void rfcomm_session_del(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s)
 {
 	int state = s->state;
 
@@ -648,6 +650,8 @@ static void rfcomm_session_del(struct rfcomm_session *s)
 
 	if (state != BT_LISTEN)
 		module_put(THIS_MODULE);
+
+	return NULL;
 }
 
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
@@ -666,7 +670,8 @@ static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
 	return NULL;
 }
 
-static void rfcomm_session_close(struct rfcomm_session *s, int err)
+static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
+						   int err)
 {
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
@@ -685,7 +690,7 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 	}
 
 	rfcomm_session_clear_timer(s);
-	rfcomm_session_put(s);
+	return rfcomm_session_put(s);
 }
 
 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -737,8 +742,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	if (*err == 0 || *err == -EINPROGRESS)
 		return s;
 
-	rfcomm_session_del(s);
-	return NULL;
+	return rfcomm_session_del(s);
 
 failed:
 	sock_release(sock);
@@ -1127,7 +1131,7 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
 }
 
 /* ---- RFCOMM frame reception ---- */
-static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 {
 	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
 
@@ -1136,7 +1140,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 		struct rfcomm_dlc *d = rfcomm_dlc_get(s, dlci);
 		if (!d) {
 			rfcomm_send_dm(s, dlci);
-			return 0;
+			return s;
 		}
 
 		switch (d->state) {
@@ -1172,25 +1176,14 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			/* rfcomm_session_put is called later so don't do
-			 * anything here otherwise we will mess up the session
-			 * reference counter:
-			 *
-			 * (a) when we are the initiator dlc_unlink will drive
-			 * the reference counter to 0 (there is no initial put
-			 * after session_add)
-			 *
-			 * (b) when we are not the initiator rfcomm_rx_process
-			 * will explicitly call put to balance the initial hold
-			 * done after session add.
-			 */
+			s = rfcomm_session_close(s, ECONNRESET);
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
 
@@ -1215,12 +1208,13 @@ static int rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
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
+					       u8 dlci)
 {
 	int err = 0;
 
@@ -1250,10 +1244,9 @@ static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
 			err = ECONNRESET;
 
 		s->state = BT_CLOSED;
-		rfcomm_session_close(s, err);
+		s = rfcomm_session_close(s, err);
 	}
-
-	return 0;
+	return s;
 }
 
 void rfcomm_dlc_accept(struct rfcomm_dlc *d)
@@ -1674,11 +1667,18 @@ drop:
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
 
@@ -1689,7 +1689,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 	if (__check_fcs(skb->data, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
-		return -EILSEQ;
+		return s;
 	}
 
 	if (__test_ea(hdr->len))
@@ -1705,22 +1705,23 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 
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
 
@@ -1729,7 +1730,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
 		break;
 	}
 	kfree_skb(skb);
-	return 0;
+	return s;
 }
 
 /* ---- Connection and data processing ---- */
@@ -1866,7 +1867,7 @@ static void rfcomm_process_dlcs(struct rfcomm_session *s)
 	}
 }
 
-static void rfcomm_process_rx(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 {
 	struct socket *sock = s->sock;
 	struct sock *sk = sock->sk;
@@ -1878,17 +1879,20 @@ static void rfcomm_process_rx(struct rfcomm_session *s)
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
 		if (!skb_linearize(skb))
-			rfcomm_recv_frame(s, skb);
+			s = rfcomm_recv_frame(s, skb);
 		else
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
+	if (s && (sk->sk_state == BT_CLOSED)) {
 		if (!s->initiator)
-			rfcomm_session_put(s);
+			s = rfcomm_session_put(s);
 
-		rfcomm_session_close(s, sk->sk_err);
+		if (s)
+			s = rfcomm_session_close(s, sk->sk_err);
 	}
+
+	return s;
 }
 
 static void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1925,7 +1929,7 @@ static void rfcomm_accept_connection(struct rfcomm_session *s)
 		sock_release(nsock);
 }
 
-static void rfcomm_check_connection(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_check_connection(struct rfcomm_session *s)
 {
 	struct sock *sk = s->sock->sk;
 
@@ -1944,9 +1948,10 @@ static void rfcomm_check_connection(struct rfcomm_session *s)
 
 	case BT_CLOSED:
 		s->state = BT_CLOSED;
-		rfcomm_session_close(s, sk->sk_err);
+		s = rfcomm_session_close(s, sk->sk_err);
 		break;
 	}
+	return s;
 }
 
 static void rfcomm_process_sessions(void)
@@ -1975,15 +1980,16 @@ static void rfcomm_process_sessions(void)
 
 		switch (s->state) {
 		case BT_BOUND:
-			rfcomm_check_connection(s);
+			s = rfcomm_check_connection(s);
 			break;
 
 		default:
-			rfcomm_process_rx(s);
+			s = rfcomm_process_rx(s);
 			break;
 		}
 
-		rfcomm_process_dlcs(s);
+		if (s)
+			rfcomm_process_dlcs(s);
 
 		rfcomm_session_put(s);
 	}
-- 
1.7.10.1
