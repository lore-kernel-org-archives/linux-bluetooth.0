Return-Path: <cyrus@holtmann.org>
From: djenkins@mvista.com
To: linux-bluetooth@vger.kernel.org
Cc: Dean Jenkins <djenkins@mvista.com>
Subject: [RFC 1/2] Bluetooth: remove rfcomm session refcnt
Date: Tue, 29 May 2012 11:07:35 +0100
Message-Id: <1338286055-16639-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dean Jenkins <djenkins@mvista.com>

The rfcomm session refcnt is unworkable as it is hard
to predict the program flow during abnormal protocol conditions
so is easy for the refcnt to be out-of-sync. In addition, high
processor loading can cause the run-time thread order to change
resulting in malfunctioning of the session refcnt eg. premature
session deletion or double session deletion resulting in
kernel crashes.

Therefore, rely on the rfcomm session state machine to absolutely
delete the rfcomm session at the right time. The rfcomm session
state machine is controlled by the DLC data channel connection
states. The rfcomm session is created when a DLC data channel is
required. The rfcomm session is deleted when all DLC data channels
are closed or in abnormal conditions when the socket is BT_CLOSED.

There are 4 connection / disconnection rfcomm session scenarios:
host initiated: host disconnected
host initiated: remote disconnected
remote initiated: host disconnected
remote initiated: remote disconnected

The connection procedures are independent of the disconnection
procedures. Strangely, the session refcnt was applying special
treatment so erroneously combining connection and disconnection
events.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 include/net/bluetooth/rfcomm.h |    6 -----
 net/bluetooth/rfcomm/core.c    |   56 +++++-----------------------------------
 2 files changed, 6 insertions(+), 56 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index e2e3eca..7afd419 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -158,7 +158,6 @@ struct rfcomm_session {
 	struct timer_list timer;
 	unsigned long    state;
 	unsigned long    flags;
-	atomic_t         refcnt;
 	int              initiator;
 
 	/* Default DLC parameters */
@@ -276,11 +275,6 @@ static inline void rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
 void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
 								bdaddr_t *dst);
 
-static inline void rfcomm_session_hold(struct rfcomm_session *s)
-{
-	atomic_inc(&s->refcnt);
-}
-
 /* ---- RFCOMM sockets ---- */
 struct sockaddr_rc {
 	sa_family_t	rc_family;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..b0805c1 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -122,12 +122,6 @@ static inline void rfcomm_schedule(void)
 	wake_up_process(rfcomm_thread);
 }
 
-static inline void rfcomm_session_put(struct rfcomm_session *s)
-{
-	if (atomic_dec_and_test(&s->refcnt))
-		rfcomm_session_del(s);
-}
-
 /* ---- RFCOMM FCS computation ---- */
 
 /* reversed, 8-bit, poly=0x07 */
@@ -263,16 +257,15 @@ static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
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
@@ -350,8 +343,6 @@ static void rfcomm_dlc_link(struct rfcomm_session *s, struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p session %p", d, s);
 
-	rfcomm_session_hold(s);
-
 	rfcomm_session_clear_timer(s);
 	rfcomm_dlc_hold(d);
 	list_add(&d->list, &s->dlcs);
@@ -370,8 +361,6 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 
 	if (list_empty(&s->dlcs))
 		rfcomm_session_set_timer(s, RFCOMM_IDLE_TIMEOUT);
-
-	rfcomm_session_put(s);
 }
 
 static struct rfcomm_dlc *rfcomm_dlc_get(struct rfcomm_session *s, u8 dlci)
@@ -631,9 +620,6 @@ static void rfcomm_session_del(struct rfcomm_session *s)
 
 	list_del(&s->list);
 
-	if (state == BT_CONNECTED)
-		rfcomm_send_disc(s, 0);
-
 	rfcomm_session_clear_timer(s);
 	sock_release(s->sock);
 	kfree(s);
@@ -665,8 +651,6 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 
 	BT_DBG("session %p state %ld err %d", s, s->state, err);
 
-	rfcomm_session_hold(s);
-
 	s->state = BT_CLOSED;
 
 	/* Close all dlcs */
@@ -676,8 +660,7 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 		__rfcomm_dlc_close(d, err);
 	}
 
-	rfcomm_session_clear_timer(s);
-	rfcomm_session_put(s);
+	rfcomm_session_del(s);
 }
 
 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -1164,18 +1147,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
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
+			rfcomm_session_del(s);
 			break;
 		}
 	}
@@ -1875,12 +1847,8 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
-		if (!s->initiator)
-			rfcomm_session_put(s);
-
+	if (sk->sk_state == BT_CLOSED)
 		rfcomm_session_close(s, sk->sk_err);
-	}
 }
 
 static inline void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1905,8 +1873,6 @@ static inline void rfcomm_accept_connection(struct rfcomm_session *s)
 
 	s = rfcomm_session_add(nsock, BT_OPEN);
 	if (s) {
-		rfcomm_session_hold(s);
-
 		/* We should adjust MTU on incoming sessions.
 		 * L2CAP MTU minus UIH header and FCS. */
 		s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
@@ -1954,7 +1920,6 @@ static inline void rfcomm_process_sessions(void)
 		if (test_and_clear_bit(RFCOMM_TIMED_OUT, &s->flags)) {
 			s->state = BT_DISCONN;
 			rfcomm_send_disc(s, 0);
-			rfcomm_session_put(s);
 			continue;
 		}
 
@@ -1963,8 +1928,6 @@ static inline void rfcomm_process_sessions(void)
 			continue;
 		}
 
-		rfcomm_session_hold(s);
-
 		switch (s->state) {
 		case BT_BOUND:
 			rfcomm_check_connection(s);
@@ -1976,8 +1939,6 @@ static inline void rfcomm_process_sessions(void)
 		}
 
 		rfcomm_process_dlcs(s);
-
-		rfcomm_session_put(s);
 	}
 
 	rfcomm_unlock();
@@ -2027,7 +1988,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	if (!s)
 		goto failed;
 
-	rfcomm_session_hold(s);
 	return 0;
 failed:
 	sock_release(sock);
@@ -2085,8 +2045,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 	if (!s)
 		return;
 
-	rfcomm_session_hold(s);
-
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
 
@@ -2118,8 +2076,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
 
-	rfcomm_session_put(s);
-
 	rfcomm_schedule();
 }
 
-- 
1.7.10.1

