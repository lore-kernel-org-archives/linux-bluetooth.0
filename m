Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: Fix possible timeouts while sending RFCOMM commands
Date: Tue, 10 Jan 2012 15:26:28 +0200
Message-Id: <1326201988-17651-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1326201988-17651-1-git-send-email-luiz.dentz@gmail.com>
References: <1326201988-17651-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of MSG_DONTROUTE when sending RFCOMM commands to avoid possible
timeouts during connection attempts.

Note that this do not revert commit
5436538fb5f2a12e5328dcaa2e3a1742be25c2e0, it will continue ignoring
priorities (priority 0) for data sent by userspace via RFCOMM sockets
only commands are affected.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/core.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 09a3cbc..c4a7f8c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
 
 static LIST_HEAD(session_list);
 
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
+				unsigned flags);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_queue_disc(struct rfcomm_dlc *d);
@@ -747,7 +748,8 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
 }
 
 /* ---- RFCOMM frame sending ---- */
-static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
+static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
+				unsigned flags)
 {
 	struct kvec iv = { data, len };
 	struct msghdr msg;
@@ -755,6 +757,7 @@ static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
 	BT_DBG("session %p len %d", s, len);
 
 	memset(&msg, 0, sizeof(msg));
+	msg.msg_flags = flags;
 
 	return kernel_sendmsg(s->sock, &msg, &iv, 1, len);
 }
@@ -763,7 +766,7 @@ static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cmd *cmd)
 {
 	BT_DBG("%p cmd %u", s, cmd->ctrl);
 
-	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd));
+	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), MSG_DONTROUTE);
 }
 
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci)
@@ -866,7 +869,7 @@ static int rfcomm_send_nsc(struct rfcomm_session *s, int cr, u8 type)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d)
@@ -908,7 +911,7 @@ static int rfcomm_send_pn(struct rfcomm_session *s, int cr, struct rfcomm_dlc *d
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
@@ -946,7 +949,7 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
@@ -973,7 +976,7 @@ static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig)
@@ -1000,7 +1003,7 @@ static int rfcomm_send_msc(struct rfcomm_session *s, int cr, u8 dlci, u8 v24_sig
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
@@ -1022,7 +1025,7 @@ static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
@@ -1044,7 +1047,7 @@ static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static int rfcomm_send_test(struct rfcomm_session *s, int cr, u8 *pattern, int len)
@@ -1095,7 +1098,7 @@ static int rfcomm_send_credits(struct rfcomm_session *s, u8 addr, u8 credits)
 
 	*ptr = __fcs(buf); ptr++;
 
-	return rfcomm_send_frame(s, buf, ptr - buf);
+	return rfcomm_send_frame(s, buf, ptr - buf, MSG_DONTROUTE);
 }
 
 static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
@@ -1774,7 +1777,7 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 		return skb_queue_len(&d->tx_queue);
 
 	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
-		err = rfcomm_send_frame(d->session, skb->data, skb->len);
+		err = rfcomm_send_frame(d->session, skb->data, skb->len, 0);
 		if (err < 0) {
 			skb_queue_head(&d->tx_queue, skb);
 			break;
-- 
1.7.7.5

