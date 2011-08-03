Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] Bluetooth: make use sk_priority to priritize RFCOMM packets
Date: Wed,  3 Aug 2011 16:11:34 +0300
Message-Id: <1312377094-11285-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/core.c |   51 +++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 5759bb7..3ec98bd 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -66,7 +66,8 @@ static unsigned long rfcomm_event;
 
 static LIST_HEAD(session_list);
 
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
+							u32 priority);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_queue_disc(struct rfcomm_dlc *d);
@@ -751,19 +752,34 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
 }
 
 /* ---- RFCOMM frame sending ---- */
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
+							u32 priority)
 {
 	struct socket *sock = s->sock;
+	struct sock *sk = sock->sk;
 	struct kvec iv = { data, len };
 	struct msghdr msg;
 
-	BT_DBG("session %p len %d", s, len);
+	BT_DBG("session %p len %d priority %u", s, len, priority);
+
+	if (sk->sk_priority != priority) {
+		lock_sock(sk);
+		sk->sk_priority = priority;
+		release_sock(sk);
+	}
 
 	memset(&msg, 0, sizeof(msg));
 
 	return kernel_sendmsg(sock, &msg, &iv, 1, len);
 }
 
+static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cmd *cmd)
+{
+	BT_DBG("%p cmd %u", s, cmd->ctrl);
+
+	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_PRIO_MAX);
+}
+
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci)
 {
 	struct rfcomm_cmd cmd;
@@ -775,7 +791,7 @@ static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci)
 	cmd.len  = __len8(0);
 	cmd.fcs  = __fcs2((u8 *) &cmd);
 
-	return rfcomm_send_frame(s, (void *) &cmd, sizeof(cmd));
+	return rfcomm_send_cmd(s, &cmd);
 }
 
 static int rfcomm_send_ua(struct rfcomm_session *s, u8 dlci)
@@ -789,7 +805,7 @@ static int rfcomm_send_ua(struct rfcomm_session *s, u8 dlci)
 	cmd.len  = __len8(0);
 	cmd.fcs  = __fcs2((u8 *) &cmd);
 
-	return rfcomm_send_frame(s, (void *) &cmd, sizeof(cmd));
+	return rfcomm_send_cmd(s, &cmd);
 }
 
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci)
@@ -803,7 +819,7 @@ static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci)
 	cmd.len  = __len8(0);
 	cmd.fcs  = __fcs2((u8 *) &cmd);
 
-	return rfcomm_send_frame(s, (void *) &cmd, sizeof(cmd));
+	return rfcomm_send_cmd(s, &cmd);
 }
 
 static int rfcomm_queue_disc(struct rfcomm_dlc *d)
@@ -817,6 +833,8 @@ static int rfcomm_queue_disc(struct rfcomm_dlc *d)
 	if (!skb)
 		return -ENOMEM;
 
+	skb->priority = HCI_PRIO_MAX;
+
 	cmd = (void *) __skb_put(skb, sizeof(*cmd));
 	cmd->addr = d->addr;
 	cmd->ctrl = __ctrl(RFCOMM_DISC, 1);
@@ -839,7 +857,7 @@ static int rfcomm_send_dm(struct rfcomm_session *s, u8 dlci)
 	cmd.len  = __len8(0);
 	cmd.fcs  = __fcs2((u8 *) &cmd);
 
-	return rfcomm_send_frame(s, (void *) &cmd, sizeof(cmd));
+	return rfcomm_send_cmd(s, &cmd);
 }
 
 static int rfcomm_send_nsc(struct rfcomm_session *s, int cr, u8 type)
@@ -864,7 +882,7 @@ static int rfcomm_send_nsc(struct rfcomm_session *s, int cr, u8 type)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d)
@@ -906,7 +924,7 @@ static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
@@ -944,7 +962,7 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
@@ -971,7 +989,7 @@ static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig)
@@ -998,7 +1016,7 @@ static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
@@ -1020,7 +1038,7 @@ static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
@@ -1042,7 +1060,7 @@ static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static int rfcomm_send_test(struct rfcomm_session *s, int cr, u8 *pattern, int len)
@@ -1093,7 +1111,7 @@ static int rfcomm_send_credits(struct rfcomm_session *s, u8 addr, u8 credits)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, HCI_PRIO_MAX);
 }
 
 static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
@@ -1771,7 +1789,8 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 		return skb_queue_len(&d->tx_queue);
 
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
-		err = rfcomm_send_frame(d->session, skb->data, skb->len);
+		err = rfcomm_send_frame(d->session, skb->data, skb->len,
+							skb->priority);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
 			break;
-- 
1.7.6

