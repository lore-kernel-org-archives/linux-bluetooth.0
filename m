Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Scott James Remnant <keybuk@chromium.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/3] bluetooth: rfcomm: Reply with DM after dlc disconnect
Date: Thu, 13 Mar 2014 12:43:04 -0400
Message-Id: <1394728986-5096-2-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
References: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
 <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Stale commands and data may be received after DISC has already
been sent for a dlc; specifically the MSC, RLS, RPN and DISC commands
must reply with DM for a dlc already closing.  [The PN command receive
already handles this case and other TS 0710 commands are not dlc-specific.]

Fixes when a stale reply to a stale command causes a DM response
on a newly reopened dlc. For example,

 Station A                   Station B

 MSC  --->|                |
          |                |<--- DISC
          | MSC ---->      |
          |     <---- DISC |---> MSC
 DISC <---|                |<--- MSC
 UA   --->|     <----  MSC |

The dlc is now closed on Station A.

          | UA  ---->      |
 MSC  <---|                |---> UA

The dlc is now closed on Station B.

 DM   --->|                | Open new dlc @ same dlci
          | DM  ---->      |
          |                |---> DM
          |                | Prematurely closes new dlc.

Reported-by: Scott James Remnant <keybuk@chromium.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 112749c..6aa90c0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1253,7 +1253,7 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 
 	if (dlci) {
 		struct rfcomm_dlc *d = rfcomm_dlc_get(s, dlci);
-		if (d) {
+		if (d && d->state != BT_DISCONN) {
 			rfcomm_send_ua(s, dlci);
 
 			if (d->state == BT_CONNECT || d->state == BT_CONFIG)
@@ -1445,6 +1445,7 @@ static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 
 static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_buff *skb)
 {
+	struct rfcomm_dlc *d;
 	struct rfcomm_rpn *rpn = (void *) skb->data;
 	u8 dlci = __get_dlci(rpn->dlci);
 
@@ -1461,6 +1462,12 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 		dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
 		rpn->xon_char, rpn->xoff_char, rpn->param_mask);
 
+	d = rfcomm_dlc_get(s, dlci);
+	if (!d || d->state == BT_DISCONN) {
+		rfcomm_send_dm(s, dlci);
+		return 0;
+	}
+
 	if (!cr)
 		return 0;
 
@@ -1551,11 +1558,18 @@ rpn_out:
 
 static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
+	struct rfcomm_dlc *d;
 	struct rfcomm_rls *rls = (void *) skb->data;
 	u8 dlci = __get_dlci(rls->dlci);
 
 	BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
 
+	d = rfcomm_dlc_get(s, dlci);
+	if (!d || d->state == BT_DISCONN) {
+		rfcomm_send_dm(s, dlci);
+		return 0;
+	}
+
 	if (!cr)
 		return 0;
 
@@ -1577,8 +1591,10 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 	BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
 
 	d = rfcomm_dlc_get(s, dlci);
-	if (!d)
+	if (!d || d->state == BT_DISCONN) {
+		rfcomm_send_dm(s, dlci);
 		return 0;
+	}
 
 	if (cr) {
 		if (msc->v24_sig & RFCOMM_V24_FC && !d->cfc)
@@ -1671,7 +1687,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 	BT_DBG("session %p state %ld dlci %d pf %d", s, s->state, dlci, pf);
 
 	d = rfcomm_dlc_get(s, dlci);
-	if (!d) {
+	if (!d || d->state == BT_DISCONN) {
 		rfcomm_send_dm(s, dlci);
 		goto drop;
 	}
-- 
1.8.1.2
