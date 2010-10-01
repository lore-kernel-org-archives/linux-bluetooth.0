Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: clean up rfcomm code
Date: Fri,  1 Oct 2010 12:05:11 +0300
Message-Id: <1285923911-12902-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Remove dead code and unused rfcomm thread events

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/rfcomm.h |    5 -----
 net/bluetooth/rfcomm/core.c    |   29 ++++++++++++++---------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index a140847..71047bc 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -213,11 +213,6 @@ struct rfcomm_dlc {
 #define RFCOMM_DEFER_SETUP  8
 
 /* Scheduling flags and events */
-#define RFCOMM_SCHED_STATE  0
-#define RFCOMM_SCHED_RX     1
-#define RFCOMM_SCHED_TX     2
-#define RFCOMM_SCHED_TIMEO  3
-#define RFCOMM_SCHED_AUTH   4
 #define RFCOMM_SCHED_WAKEUP 31
 
 /* MSC exchange flags */
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d326ad7..7af619c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -113,11 +113,10 @@ static void rfcomm_session_del(struct rfcomm_session *s);
 #define __get_rpn_stop_bits(line) (((line) >> 2) & 0x1)
 #define __get_rpn_parity(line)    (((line) >> 3) & 0x7)
 
-static inline void rfcomm_schedule(uint event)
+static inline void rfcomm_schedule(void)
 {
 	if (!rfcomm_thread)
 		return;
-	//set_bit(event, &rfcomm_event);
 	set_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
 	wake_up_process(rfcomm_thread);
 }
@@ -203,13 +202,13 @@ static inline int __check_fcs(u8 *data, int type, u8 fcs)
 static void rfcomm_l2state_change(struct sock *sk)
 {
 	BT_DBG("%p state %d", sk, sk->sk_state);
-	rfcomm_schedule(RFCOMM_SCHED_STATE);
+	rfcomm_schedule();
 }
 
 static void rfcomm_l2data_ready(struct sock *sk, int bytes)
 {
 	BT_DBG("%p bytes %d", sk, bytes);
-	rfcomm_schedule(RFCOMM_SCHED_RX);
+	rfcomm_schedule();
 }
 
 static int rfcomm_l2sock_create(struct socket **sock)
@@ -255,7 +254,7 @@ static void rfcomm_session_timeout(unsigned long arg)
 	BT_DBG("session %p state %ld", s, s->state);
 
 	set_bit(RFCOMM_TIMED_OUT, &s->flags);
-	rfcomm_schedule(RFCOMM_SCHED_TIMEO);
+	rfcomm_schedule();
 }
 
 static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
@@ -283,7 +282,7 @@ static void rfcomm_dlc_timeout(unsigned long arg)
 
 	set_bit(RFCOMM_TIMED_OUT, &d->flags);
 	rfcomm_dlc_put(d);
-	rfcomm_schedule(RFCOMM_SCHED_TIMEO);
+	rfcomm_schedule();
 }
 
 static void rfcomm_dlc_set_timer(struct rfcomm_dlc *d, long timeout)
@@ -465,7 +464,7 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	case BT_CONFIG:
 		if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-			rfcomm_schedule(RFCOMM_SCHED_AUTH);
+			rfcomm_schedule();
 			break;
 		}
 		/* Fall through */
@@ -485,7 +484,7 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	case BT_CONNECT2:
 		if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-			rfcomm_schedule(RFCOMM_SCHED_AUTH);
+			rfcomm_schedule();
 			break;
 		}
 		/* Fall through */
@@ -533,7 +532,7 @@ int rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb)
 	skb_queue_tail(&d->tx_queue, skb);
 
 	if (!test_bit(RFCOMM_TX_THROTTLED, &d->flags))
-		rfcomm_schedule(RFCOMM_SCHED_TX);
+		rfcomm_schedule();
 	return len;
 }
 
@@ -545,7 +544,7 @@ void __rfcomm_dlc_throttle(struct rfcomm_dlc *d)
 		d->v24_sig |= RFCOMM_V24_FC;
 		set_bit(RFCOMM_MSC_PENDING, &d->flags);
 	}
-	rfcomm_schedule(RFCOMM_SCHED_TX);
+	rfcomm_schedule();
 }
 
 void __rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
@@ -556,7 +555,7 @@ void __rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
 		d->v24_sig &= ~RFCOMM_V24_FC;
 		set_bit(RFCOMM_MSC_PENDING, &d->flags);
 	}
-	rfcomm_schedule(RFCOMM_SCHED_TX);
+	rfcomm_schedule();
 }
 
 /*
@@ -577,7 +576,7 @@ int rfcomm_dlc_set_modem_status(struct rfcomm_dlc *d, u8 v24_sig)
 	d->v24_sig = v24_sig;
 
 	if (!test_and_set_bit(RFCOMM_MSC_PENDING, &d->flags))
-		rfcomm_schedule(RFCOMM_SCHED_TX);
+		rfcomm_schedule();
 
 	return 0;
 }
@@ -816,7 +815,7 @@ static int rfcomm_queue_disc(struct rfcomm_dlc *d)
 	cmd->fcs  = __fcs2((u8 *) cmd);
 
 	skb_queue_tail(&d->tx_queue, skb);
-	rfcomm_schedule(RFCOMM_SCHED_TX);
+	rfcomm_schedule();
 	return 0;
 }
 
@@ -1884,7 +1883,7 @@ static inline void rfcomm_accept_connection(struct rfcomm_session *s)
 		 * L2CAP MTU minus UIH header and FCS. */
 		s->mtu = min(l2cap_pi(nsock->sk)->omtu, l2cap_pi(nsock->sk)->imtu) - 5;
 
-		rfcomm_schedule(RFCOMM_SCHED_RX);
+		rfcomm_schedule();
 	} else
 		sock_release(nsock);
 }
@@ -2093,7 +2092,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 	rfcomm_session_put(s);
 
-	rfcomm_schedule(RFCOMM_SCHED_AUTH);
+	rfcomm_schedule();
 }
 
 static struct hci_cb rfcomm_cb = {
-- 
1.7.0.4

