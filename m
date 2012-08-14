Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Failed attempt to fix rfcomm session refcnt
Date: Tue, 14 Aug 2012 09:40:10 +0100
Message-Id: <1344933610-24682-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This pseudo commit is based on my analysis of the implementation failure
of the rfcomm session refcnt.

This commit fixes the fundamental mistake of not setting the rfcomm
session refcnt to 1 before adding the session structure to the session
list.

Remove the broken workarounds that erroneously use the DLC data channel
initiator flag. Only the session termination events need be tracked.

Remove unnecessary calls to refcomm_session_hold() and
refcomm_session_put() where protection mechanisms already exist or
protection is not requried.

Use refcomm_session_put() in rfcomm_session_close() and
rfcomm_recv_ua() to indicate that the session can be deleted. These are
the events that identify that the session can be deleted.

Use refcomm_session_hold() and refcomm_session_put() in
rfcomm_process_sessions() to protect premature deletion of the rfcomm
session. The session may become deleted when the refcomm_session_put()
is called, this is the only place where the session will be deleted
unless a malfunction of the refcnt occurs.

However, the rfcomm session refcnt concept is fatally flawed because
the refcnt cannot prevent rfcomm_session_close() being called twice or
when rfcomm_recv_ua() calls refcomm_session_put() followed by
rfcomm_session_close() in rfcomm_process_rx().

The flaw is because multiple events can cause the session to finish
and these events are not mutually exclusive so the refcnt is
decremented too many times. These events come from the rfcomm control
channel and the socket layer, and both are independently capable of
demanding the session be terminated.

Instead of a refcnt, suggest using a flag to indicate that the session
is pending deletion or add a flag to inidicate that the session has
been deleted. This provides logical locking so the session can only be
deleted once. A flag would also make the code more readable.

I hope that this pseudo commit makes the explanation clearer to explain
why the rfcomm session refcnt concept does not work.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 net/bluetooth/rfcomm/core.c |   67 ++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..882842b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -263,16 +263,15 @@ static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
 {
 	BT_DBG("session %p state %ld timeout %ld", s, s->state, timeout);
 
-	if (!mod_timer(&s->timer, jiffies + timeout))
-		rfcomm_session_hold(s);
+	mod_timer(&s->timer, jiffies + timeout);
 }
 
 static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
 	BT_DBG("session %p state %ld", s, s->state);
 
-	if (timer_pending(&s->timer) && del_timer(&s->timer))
-		rfcomm_session_put(s);
+	if (timer_pending(&s->timer))
+		del_timer(&s->timer);
 }
 
 /* ---- RFCOMM DLCs ---- */
@@ -350,8 +349,6 @@ static void rfcomm_dlc_link(struct rfcomm_session *s, struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p session %p", d, s);
 
-	rfcomm_session_hold(s);
-
 	rfcomm_session_clear_timer(s);
 	rfcomm_dlc_hold(d);
 	list_add(&d->list, &s->dlcs);
@@ -370,8 +367,6 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 
 	if (list_empty(&s->dlcs))
 		rfcomm_session_set_timer(s, RFCOMM_IDLE_TIMEOUT);
-
-	rfcomm_session_put(s);
 }
 
 static struct rfcomm_dlc *rfcomm_dlc_get(struct rfcomm_session *s, u8 dlci)
@@ -618,6 +613,8 @@ static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
 			return NULL;
 		}
 
+	/* rfcomm session refcnt must be 1 before adding to the session list */
+	rfcomm_session_hold(s);
 	list_add(&s->list, &session_list);
 
 	return s;
@@ -631,9 +628,6 @@ static void rfcomm_session_del(struct rfcomm_session *s)
 
 	list_del(&s->list);
 
-	if (state == BT_CONNECTED)
-		rfcomm_send_disc(s, 0);
-
 	rfcomm_session_clear_timer(s);
 	sock_release(s->sock);
 	kfree(s);
@@ -665,8 +659,6 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 
 	BT_DBG("session %p state %ld err %d", s, s->state, err);
 
-	rfcomm_session_hold(s);
-
 	s->state = BT_CLOSED;
 
 	/* Close all dlcs */
@@ -677,6 +669,8 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 	}
 
 	rfcomm_session_clear_timer(s);
+
+	/* indicate rfcomm session can be deleted */
 	rfcomm_session_put(s);
 }
 
@@ -1164,18 +1158,8 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
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
+			/* indicate rfcomm session can be deleted */
+			rfcomm_session_put(s);
 			break;
 		}
 	}
@@ -1875,12 +1859,22 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
-		if (!s->initiator)
-			rfcomm_session_put(s);
-
+/*
+ * The rfcomm session refcnt fails to protect the possibility of deleting the
+ * session twice because the refcnt cannot determine whether the session has
+ * already been deleted. If the refcnt is 1 here (normally refcnt is 2 here)
+ * because the rfcomm channel has disconnected via DISC-UA then failure occurs
+ * later in rfcomm_process_sessions() if the session becomes deleted when the
+ * socket state transistions to BT_CLOSED. This is because the refcnt is
+ * decremented too many times due to 2 events that demand the session to be
+ * deleted.
+ *
+ * A better solution is to use a flag instead of a refcnt. A flag allows
+ * 1 or more events to trigger the deletion of the session. The refcnt cannot
+ * manage multiple independent events.
+ */
+	if (sk->sk_state == BT_CLOSED)
 		rfcomm_session_close(s, sk->sk_err);
-	}
 }
 
 static inline void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1905,8 +1899,6 @@ static inline void rfcomm_accept_connection(struct rfcomm_session *s)
 
 	s = rfcomm_session_add(nsock, BT_OPEN);
 	if (s) {
-		rfcomm_session_hold(s);
-
 		/* We should adjust MTU on incoming sessions.
 		 * L2CAP MTU minus UIH header and FCS. */
 		s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
@@ -1951,6 +1943,8 @@ static inline void rfcomm_process_sessions(void)
 		struct rfcomm_session *s;
 		s = list_entry(p, struct rfcomm_session, list);
 
+		rfcomm_session_hold(s);
+
 		if (test_and_clear_bit(RFCOMM_TIMED_OUT, &s->flags)) {
 			s->state = BT_DISCONN;
 			rfcomm_send_disc(s, 0);
@@ -1960,11 +1954,10 @@ static inline void rfcomm_process_sessions(void)
 
 		if (s->state == BT_LISTEN) {
 			rfcomm_accept_connection(s);
+			rfcomm_session_put(s);
 			continue;
 		}
 
-		rfcomm_session_hold(s);
-
 		switch (s->state) {
 		case BT_BOUND:
 			rfcomm_check_connection(s);
@@ -1977,6 +1970,7 @@ static inline void rfcomm_process_sessions(void)
 
 		rfcomm_process_dlcs(s);
 
+		/* rfcomm_session_del() is called here when refcnt goes to 0 */
 		rfcomm_session_put(s);
 	}
 
@@ -2027,7 +2021,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	if (!s)
 		goto failed;
 
-	rfcomm_session_hold(s);
 	return 0;
 failed:
 	sock_release(sock);
@@ -2085,8 +2078,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 	if (!s)
 		return;
 
-	rfcomm_session_hold(s);
-
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
 
@@ -2118,8 +2109,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
 
-	rfcomm_session_put(s);
-
 	rfcomm_schedule();
 }
 
-- 
1.7.10.1

