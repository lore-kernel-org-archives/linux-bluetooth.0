Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in RFCOMM
Date: Tue, 20 Dec 2011 17:15:57 -0200
Message-Id: <1324408558-24653-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

RFCOMM needs a proper priority mechanism inside itself and not try to use
l2cap priority to fix its own problem.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/core.c |   47 ++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index be6288c..a795d96 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -65,8 +65,7 @@ static DEFINE_MUTEX(rfcomm_mutex);
 
 static LIST_HEAD(session_list);
 
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
-							u32 priority);
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_queue_disc(struct rfcomm_dlc *d);
@@ -748,32 +747,23 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
 }
 
 /* ---- RFCOMM frame sending ---- */
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
-							u32 priority)
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
 {
-	struct socket *sock = s->sock;
-	struct sock *sk = sock->sk;
 	struct kvec iv = { data, len };
 	struct msghdr msg;
 
-	BT_DBG("session %p len %d priority %u", s, len, priority);
-
-	if (sk->sk_priority != priority) {
-		lock_sock(sk);
-		sk->sk_priority = priority;
-		release_sock(sk);
-	}
+	BT_DBG("session %p len %d", s, len);
 
 	memset(&msg, 0, sizeof(msg));
 
-	return kernel_sendmsg(sock, &msg, &iv, 1, len);
+	return kernel_sendmsg(s->sock, &msg, &iv, 1, len);
 }
 
 static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cmd *cmd)
 {
 	BT_DBG("%p cmd %u", s, cmd->ctrl);
 
-	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd));
 }
 
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci)
@@ -878,7 +868,7 @@ static int rfcomm_send_nsc(struct rfcomm_session *s, int cr, u8 type)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d)
@@ -920,7 +910,7 @@ static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
@@ -958,7 +948,7 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
@@ -985,7 +975,7 @@ static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig)
@@ -1012,7 +1002,7 @@ static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
@@ -1034,7 +1024,7 @@ static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
@@ -1056,7 +1046,7 @@ static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static int rfcomm_send_test(struct rfcomm_session *s, int cr, u8 *pattern, int len)
@@ -1107,7 +1097,7 @@ static int rfcomm_send_credits(struct rfcomm_session *s, u8 addr, u8 credits)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
+	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
 static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
@@ -1786,8 +1776,15 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 		return skb_queue_len(&d->tx_queue);
 
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
-		err = rfcomm_send_frame(d->session, skb->data, skb->len,
-							skb->priority);
+		struct socket *sock = d->session->sock;
+		struct sock *sk = sock->sk;
+
+		if (sk->sk_priority != skb->priority) {
+			lock_sock(sk);
+			sk->sk_priority = skb->priority;
+			release_sock(sk);
+		}
+		err = rfcomm_send_frame(d->session, skb->data, skb->len);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
 			break;
-- 
1.7.6.4

