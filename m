Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH v2 4/6] Bluetooth: Remove RFCOMM session refcnt
Date: Thu, 28 Feb 2013 14:21:56 +0000
Message-Id: <1362061318-30580-5-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Previous commits have improved the handling of the RFCOMM session
timer and the RFCOMM session pointers such that freed RFCOMM
session structures should no longer be erroneously accessed. The
RFCOMM session refcnt now has no purpose and will be deleted by
this commit.

Note that the RFCOMM session is now deleted as soon as the
RFCOMM control channel link is no longer required. This makes the
lifetime of the RFCOMM session deterministic and absolute.
Previously with the refcnt, there was uncertainty about when
the session structure would be deleted because the relative
refcnt prevented the session structure from being deleted at will.

It was noted that the refcnt could malfunction under very heavy
real-time processor loading in embedded SMP environments. This
could cause premature RFCOMM session deletion or double session
deletion that could result in kernel crashes. Removal of the
refcnt prevents this issue.

There are 4 connection / disconnection RFCOMM session scenarios:
host initiated control link ---> host disconnected control link
host initiated ctrl link ---> remote device disconnected ctrl link
remote device initiated ctrl link ---> host disconnected ctrl link
remote device initiated ctrl link ---> remote device disc'ed ctrl link

The control channel connection procedures are independent of the
disconnection procedures. Strangely, the RFCOMM session refcnt was
applying special treatment so erroneously combining connection and
disconnection events. This commit fixes this issue by removing
some session code that used the "initiator" member of the session
structure that was intended for use with the data channels.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/rfcomm.h |    7 -------
 net/bluetooth/rfcomm/core.c    |   43 +++++-----------------------------------
 2 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index a4e38ea..7afd419 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -158,7 +158,6 @@ struct rfcomm_session {
 	struct timer_list timer;
 	unsigned long    state;
 	unsigned long    flags;
-	atomic_t         refcnt;
 	int              initiator;
 
 	/* Default DLC parameters */
@@ -276,12 +275,6 @@ static inline void rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
 void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
 								bdaddr_t *dst);
 
-static inline void rfcomm_session_hold(struct rfcomm_session *s)
-{
-	if (s)
-		atomic_inc(&s->refcnt);
-}
-
 /* ---- RFCOMM sockets ---- */
 struct sockaddr_rc {
 	sa_family_t	rc_family;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 60ccb37..af97fa2 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -108,14 +108,6 @@ static void rfcomm_schedule(void)
 	wake_up_process(rfcomm_thread);
 }
 
-static struct rfcomm_session *rfcomm_session_put(struct rfcomm_session *s)
-{
-	if (s && atomic_dec_and_test(&s->refcnt))
-		s = rfcomm_session_del(s);
-
-	return s;
-}
-
 /* ---- RFCOMM FCS computation ---- */
 
 /* reversed, 8-bit, poly=0x07 */
@@ -251,16 +243,14 @@ static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
 {
 	BT_DBG("session %p state %ld timeout %ld", s, s->state, timeout);
 
-	if (!mod_timer(&s->timer, jiffies + timeout))
-		rfcomm_session_hold(s);
+	mod_timer(&s->timer, jiffies + timeout);
 }
 
 static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
 	BT_DBG("session %p state %ld", s, s->state);
 
-	if (del_timer_sync(&s->timer))
-		rfcomm_session_put(s);
+	del_timer_sync(&s->timer);
 }
 
 /* ---- RFCOMM DLCs ---- */
@@ -338,8 +328,6 @@ static void rfcomm_dlc_link(struct rfcomm_session *s, struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p session %p", d, s);
 
-	rfcomm_session_hold(s);
-
 	rfcomm_session_clear_timer(s);
 	rfcomm_dlc_hold(d);
 	list_add(&d->list, &s->dlcs);
@@ -358,8 +346,6 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 
 	if (list_empty(&s->dlcs))
 		rfcomm_session_set_timer(s, RFCOMM_IDLE_TIMEOUT);
-
-	rfcomm_session_put(s);
 }
 
 static struct rfcomm_dlc *rfcomm_dlc_get(struct rfcomm_session *s, u8 dlci)
@@ -678,8 +664,6 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 
 	BT_DBG("session %p state %ld err %d", s, s->state, err);
 
-	rfcomm_session_hold(s);
-
 	s->state = BT_CLOSED;
 
 	/* Close all dlcs */
@@ -690,7 +674,7 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 	}
 
 	rfcomm_session_clear_timer(s);
-	return rfcomm_session_put(s);
+	return rfcomm_session_del(s);
 }
 
 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -1884,13 +1868,8 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 			kfree_skb(skb);
 	}
 
-	if (s && (sk->sk_state == BT_CLOSED)) {
-		if (!s->initiator)
-			s = rfcomm_session_put(s);
-
-		if (s)
-			s = rfcomm_session_close(s, sk->sk_err);
-	}
+	if (s && (sk->sk_state == BT_CLOSED))
+		s = rfcomm_session_close(s, sk->sk_err);
 
 	return s;
 }
@@ -1917,8 +1896,6 @@ static void rfcomm_accept_connection(struct rfcomm_session *s)
 
 	s = rfcomm_session_add(nsock, BT_OPEN);
 	if (s) {
-		rfcomm_session_hold(s);
-
 		/* We should adjust MTU on incoming sessions.
 		 * L2CAP MTU minus UIH header and FCS. */
 		s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
@@ -1967,7 +1944,6 @@ static void rfcomm_process_sessions(void)
 		if (test_and_clear_bit(RFCOMM_TIMED_OUT, &s->flags)) {
 			s->state = BT_DISCONN;
 			rfcomm_send_disc(s, 0);
-			rfcomm_session_put(s);
 			continue;
 		}
 
@@ -1976,8 +1952,6 @@ static void rfcomm_process_sessions(void)
 			continue;
 		}
 
-		rfcomm_session_hold(s);
-
 		switch (s->state) {
 		case BT_BOUND:
 			s = rfcomm_check_connection(s);
@@ -1990,8 +1964,6 @@ static void rfcomm_process_sessions(void)
 
 		if (s)
 			rfcomm_process_dlcs(s);
-
-		rfcomm_session_put(s);
 	}
 
 	rfcomm_unlock();
@@ -2041,7 +2013,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	if (!s)
 		goto failed;
 
-	rfcomm_session_hold(s);
 	return 0;
 failed:
 	sock_release(sock);
@@ -2099,8 +2070,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 	if (!s)
 		return;
 
-	rfcomm_session_hold(s);
-
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
 
@@ -2132,8 +2101,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
 
-	rfcomm_session_put(s);
-
 	rfcomm_schedule();
 }
 
-- 
1.7.10.1
