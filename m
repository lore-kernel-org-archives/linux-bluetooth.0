Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650300;
	b=YuzHE2WVuGUFn8iS/Z6HL/yvzeVffnnuOrUv1iDwkuNu2RWJZiLnKOBvUi+jlQYeE3sm
	 g7UNgZoExjxVq6XmbJapLk9xikDU7T/dH/m6HL2jz9dloUOFIOIx7w/+xDMPHKk1QcgJF
	 Td2fEm0aaXfVY+YygIDC/dsXvFREHYyviWWsQ97nG6inaOcMBQoWRvzOYtRMQIbvIh4U0
	 Iq83TuMfnYAdR8DXGGxXzWHgZdBavRIQdPFrb4t6mw8aCZyFRkTkyESZ5Y+K5YA0RxhWN
	 AREs9DPbFkohfhboVUTRm9C9MhX49KochQzyAnl1EVE+HIFivpsa42R+LTlxQAQa9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650300;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3/L7AkM/aWqs46tvWQnmR2M3FlVl02fiC6MwuYCH2SA=;
	b=NI9g+4sZUKhPxUjZOQAvOxdQQM+dHx9tefnYKESIEJ1GciQ8xG3MTzFjaXbqOJOmJyNx
	 15PIw2i4zkqfp4ys9u30BqhvrT5EUYwosnT/fK2CRAMbz7QHYkIV/0J5tsEVCPPELNZxp
	 0zrOYjRisrhTyQIaIKHOUvHZDxk9GBLxQa6vUAi1VdufPaptkqufA/t18YgQIp2C4BDzQ
	 3RLutv9cjZaqqRkHrwnDSkzpqExuX92giZPR2ovHHOAvq+dNcZgDQXtkQsayKFFxsrGNT
	 28x+k6OLnjkOyer4K/V7x9s8IviGpZLgtX4j97dcg3oKfnCEBGAyuk+ieTInMfPDJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=tlGjveIJ;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136A606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2136A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=tlGjveIJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795650296; x=1795909496;
	bh=3/L7AkM/aWqs46tvWQnmR2M3FlVl02fiC6MwuYCH2SA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tlGjveIJCgbw8fXCNC9smPpj0oh72wDLuy71avlOIrwtynmgI8d7j+Vr/eNbFlcEL
	 7sCVotdH6ynU4xu6qvqcXdoQq1WCgHPzSAFqXakY0xdB6oS/R8ynAVlu56ybAZDdzR
	 b8xDY+MY4Z6+DtG0bPguFmRAWO8mEj9Vjp0eeXgjMcJa51srbDaFeemPfyZD0r4G6Z
	 IO4tA5vXYDLJa6EewRysLCLiG/chO5Lr/ozUpfUjcTCmHp2fhcYW8oOT231sJM9TaF
	 Nq/j1tzEWWm8yX39GJIvplv+6UbYu5o31RlGiuKjL5z7zZCK90b/XckMes13K0UddM
	 WV+veCErpAymA==
Date: Wed, 25 Nov 2026 23:44:51 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <fc7072a78de49b72d9034349512983d95be4ba1a.1795650070.git.github.filter194@slmail.me>
In-Reply-To: <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
References: <20261113030556.75484-1-cochcoder@proton.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794617024.git.github.filter194@slmail.me> <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: fad97f4efcc9996ca9b7a7c036c5bc12b6849053
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A credit indication can drain queued CoC data and clear socket suspension
while BT_SECURITY is waiting for stronger security. Keep the request
pending until the required encryption, level, key size and MIC are met.

Finish requests on the existing HCI workqueue, outside the confirmation
list walk. Hold selected channels before callbacks can remove siblings.
Latch SMP failure before admitting a fresh request, clear pending flags on
close, and recheck channel state before processing deferred confirmations.
Use the existing pairing and HCI timeouts without a new request deadline.

Reject overlapping requests with EBUSY while pairing, key distribution or
encryption is in progress. This includes repeated and lowered requests;
applications can retry after the current procedure completes. Return
EACCES when SMP starts no procedure and the requirements remain unmet,
restoring the channel requirements and both pending link requirements.
Preserve each CoC's requested level across shared-link confirmations.

Keep deferred reads pending during an upgrade. Send an ECRED response
before releasing accepted children's data, let rejection override pending
siblings, and close every deleted child. Return the batch's security error
to a deferred reader while preserving ordinary accept/close behavior.
Purge retained CoC data even if deferred acceptance left configuration
incomplete. Acquire the SMP channel lock without holding the socket lock,
and suspend pending ATT sockets until their confirmation resumes them.

Reject an incoming deferred ECRED batch when an accepted child closes
before the connection response, so its siblings cannot stay suspended.

Keep deferred ECRED identifiers and flags until the response is queued,
then release accepted children under their own channel locks. Clear
those fields on rejection too. Exclude outgoing authentication retries
from incoming batches even when their signaling identifiers collide.

If another shared-link encryption procedure starts after a confirmation
was queued, keep security pending until its confirmation arrives rather
than closing a channel whose requirements may still be satisfied.

AI assistance: Codex prepared and tested the security-upgrade and
deferred-ECRED changes in prior revisions, including the supplied v13
follow-up fixes, and assisted with this commit message and revision
notes. Work followed the reported credit/security failures and supplied
review findings; validation used compiler builds and source-extracted
sanitizer models with mutation controls.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v14:
- Replace the obsolete Assisted-by trailer with AI disclosure in each
  commit message, following current kernel tool-generated content guidance.
- Rebase on current bluetooth-next; both patches' code is unchanged.

Previous v13 (no cover letter):
https://lore.kernel.org/linux-bluetooth/9d9d37680044266dbd1d6919b08564026af=
cd87d.1795528595.git.github.filter194@slmail.me/

V13 CI passed all 12 other jobs, including the kernel builds and
l2cap-tester. CheckPatch rejected the obsolete Assisted-by: LLM trailer.
Those are v13 results; v14 remote CI has not run.

 include/net/bluetooth/l2cap.h |   9 +-
 net/bluetooth/l2cap_core.c    | 378 +++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 181 ++++++++++------
 net/bluetooth/smp.c           |   1 +
 4 files changed, 470 insertions(+), 99 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 72d9d56c6f2a2e513acd41f9d1e0d08d99d9cdf8..8519099c0a701422c2a0270c98c=
c35e4f67c3a6f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -609,6 +609,7 @@ struct l2cap_chan {
 =09__u32=09=09remote_flush_to;
=20
 =09struct delayed_work=09chan_timer;
+=09struct list_head=09security_list;
 =09struct delayed_work=09retrans_timer;
 =09struct delayed_work=09monitor_timer;
 =09struct delayed_work=09ack_timer;
@@ -649,6 +650,8 @@ struct l2cap_conn {
=20
 =09struct sk_buff_head=09pending_rx;
 =09struct work_struct=09pending_rx_work;
+=09struct work_struct=09security_work;
+=09atomic_t=09=09security_failure;
 =09bool=09=09=09pending_rx_blocked __guarded_by(&lock);
=20
 =09struct delayed_work=09id_addr_timer;
@@ -772,6 +775,8 @@ enum {
 =09FLAG_ECRED_CONN_REQ_SENT,
 =09FLAG_ECRED_RECONF_REQ_SENT,
 =09FLAG_PENDING_SECURITY,
+=09FLAG_SECURITY_CFM,
+=09FLAG_SECURITY_FAILED,
 =09FLAG_HOLD_HCI_CONN,
 =09FLAG_DEL,
 };
@@ -979,7 +984,7 @@ void l2cap_cleanup_sockets(void);
 bool l2cap_is_socket(struct socket *sock);
=20
 void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan);
-void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+int __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 =09__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
=20
@@ -998,6 +1003,8 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy=
);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 void l2cap_chan_req_mic_len(struct l2cap_chan *chan, struct hci_conn *hcon=
);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
+int l2cap_chan_set_security(struct l2cap_chan *chan, u8 level, u8 mic_len)=
;
+void l2cap_security_failure(struct l2cap_conn *conn);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *p=
chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8229bddca5df761dd1359b88752e3d5f6d6090cf..29fbe6de913cde1adb667cd316b=
20bf5223d2bb5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,8 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2ca=
p_ctrl *control,
 static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
+static void l2cap_security_work(struct work_struct *work);
+static bool l2cap_chan_ecred_rsp_pending(struct l2cap_chan *chan);
 static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 =09__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
=20
@@ -479,6 +481,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 =09write_unlock(&chan_list_lock);
=20
 =09INIT_DELAYED_WORK(&chan->chan_timer, l2cap_chan_timeout);
+=09INIT_LIST_HEAD(&chan->security_list);
 =09INIT_DELAYED_WORK(&chan->retrans_timer, l2cap_retrans_timeout);
 =09INIT_DELAYED_WORK(&chan->monitor_timer, l2cap_monitor_timeout);
 =09INIT_DELAYED_WORK(&chan->ack_timer, l2cap_ack_timeout);
@@ -709,7 +712,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 =09BT_DBG("chan %p, err %d, state %s", chan, err,
 =09       state_to_string(chan->state));
=20
+=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
 =09chan->ops->teardown(chan, err);
+=09clear_bit(FLAG_SECURITY_FAILED, &chan->flags);
=20
 =09if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
 =09=09/* Delete from channel list */
@@ -726,6 +732,12 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 =09=09=09hci_conn_drop(chan->conn->hcon);
 =09}
=20
+=09if (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09    chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
+=09=09skb_queue_purge(&chan->tx_q);
+=09=09return;
+=09}
+
 =09if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 =09=09return;
=20
@@ -733,11 +745,6 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 =09case L2CAP_MODE_BASIC:
 =09=09break;
=20
-=09case L2CAP_MODE_LE_FLOWCTL:
-=09case L2CAP_MODE_EXT_FLOWCTL:
-=09=09skb_queue_purge(&chan->tx_q);
-=09=09break;
-
 =09case L2CAP_MODE_ERTM:
 =09=09__clear_retrans_timer(chan);
 =09=09__clear_monitor_timer(chan);
@@ -870,6 +877,9 @@ static void __l2cap_chan_close(struct l2cap_chan *chan,=
 int reason)
=20
 =09BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
=20
+=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
+
 =09switch (chan->state) {
 =09case BT_LISTEN:
 =09=09chan->ops->teardown(chan, 0);
@@ -877,6 +887,11 @@ static void __l2cap_chan_close(struct l2cap_chan *chan=
, int reason)
=20
 =09case BT_CONNECTED:
 =09case BT_CONFIG:
+=09=09if (l2cap_chan_ecred_rsp_pending(chan)) {
+=09=09=09l2cap_chan_ecred_connect_reject(chan);
+=09=09=09return;
+=09=09}
+
 =09=09if (chan->chan_type =3D=3D L2CAP_CHAN_CONN_ORIENTED) {
 =09=09=09__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 =09=09=09l2cap_send_disconn_req(chan, reason);
@@ -2707,12 +2722,37 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *=
chan,
 =09return 0;
 }
=20
-static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
+/* True for an incoming deferred ECRED channel whose L2CAP_ECRED_CONN_RSP =
has
+ * not been queued yet. FLAG_DEFER_SETUP and ident stay set until the resp=
onse
+ * is queued, so data cannot overtake it.
+ *
+ * Local and remote idents share one number space, and a bound socket with
+ * BT_DEFER_SETUP can later connect out. l2cap_ecred_conn_rsp() clears
+ * FLAG_ECRED_CONN_REQ_SENT and keeps ident while such a channel retries a=
fter
+ * an authentication error, always in BT_CONNECT, a state an incoming chan=
nel
+ * never has. Exclude it so it cannot match an incoming batch.
+ */
+static bool l2cap_chan_ecred_rsp_pending(struct l2cap_chan *chan)
+{
+=09return chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && chan->ident &&
+=09       chan->state !=3D BT_CONNECT &&
+=09       test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
+=09       !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
+}
+
+static bool l2cap_le_flowctl_send(struct l2cap_chan *chan)
 {
 =09int sent =3D 0;
=20
 =09BT_DBG("chan %p", chan);
=20
+=09if (chan->state !=3D BT_CONNECTED ||
+=09    test_bit(FLAG_DEL, &chan->flags) ||
+=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags) ||
+=09    test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
+=09    l2cap_chan_ecred_rsp_pending(chan))
+=09=09return false;
+
 =09while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
 =09=09l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
 =09=09chan->tx_credits--;
@@ -2721,6 +2761,205 @@ static void l2cap_le_flowctl_send(struct l2cap_chan=
 *chan)
=20
 =09BT_DBG("Sent %d credits %u queued %u", sent, chan->tx_credits,
 =09       skb_queue_len(&chan->tx_q));
+
+=09return true;
+}
+
+static void l2cap_le_flowctl_resume(struct l2cap_chan *chan)
+=09__must_hold(&chan->lock)
+{
+=09if (l2cap_le_flowctl_send(chan) && chan->tx_credits)
+=09=09chan->ops->resume(chan);
+=09else
+=09=09chan->ops->suspend(chan);
+}
+
+static bool l2cap_chan_security_sufficient(struct l2cap_chan *chan)
+{
+=09struct hci_conn *hcon =3D chan->conn->hcon;
+
+=09lockdep_assert_held(&hcon->hdev->lock);
+=09lockdep_assert_held(&chan->lock);
+
+=09return smp_sufficient_security(hcon, chan->sec_level, SMP_ALLOW_STK) &&
+=09       (chan->sec_level =3D=3D BT_SECURITY_LOW ||
+=09=09test_bit(HCI_CONN_ENCRYPT, hcon->flags)) &&
+=09       l2cap_check_enc_key_size(hcon, chan) &&
+=09       l2cap_check_mic_len(hcon, chan);
+}
+
+static bool l2cap_chan_security_ready(struct l2cap_chan *chan)
+{
+=09return !test_bit(HCI_CONN_ENCRYPT_PEND, chan->conn->hcon->flags) &&
+=09       l2cap_chan_security_sufficient(chan);
+}
+
+static void l2cap_chan_security_complete(struct l2cap_chan *chan)
+=09__must_hold(&chan->lock) __must_hold(&chan->conn->lock)
+{
+=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
+
+=09if (chan->state =3D=3D BT_CONNECT2) {
+=09=09chan->ops->resume(chan);
+=09=09return;
+=09}
+
+=09if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)
+=09=09__l2cap_ecred_conn_rsp_defer(chan);
+=09if (!test_bit(FLAG_DEL, &chan->flags))
+=09=09l2cap_le_flowctl_resume(chan);
+}
+
+static void l2cap_queue_security_work(struct l2cap_conn *conn)
+{
+=09struct hci_dev *hdev =3D conn->hcon->hdev;
+
+=09/* Pair with the RCU grace period before hci_dev_close_sync() drains
+=09 * this queue. No security work may be added after that drain.
+=09 */
+=09rcu_read_lock();
+=09if (test_bit(HCI_UP, &hdev->flags)) {
+=09=09l2cap_conn_get(conn);
+=09=09if (!queue_work(hdev->workqueue, &conn->security_work))
+=09=09=09l2cap_conn_put(conn);
+=09}
+=09rcu_read_unlock();
+}
+
+void l2cap_security_failure(struct l2cap_conn *conn)
+{
+=09/* SMP receive holds conn->lock; management and encryption hold hdev. *=
/
+=09lockdep_assert(lockdep_is_held(&conn->lock) ||
+=09=09       lockdep_is_held(&conn->hcon->hdev->lock));
+=09if (conn->hcon->type !=3D LE_LINK)
+=09=09return;
+
+=09atomic_set(&conn->security_failure, 1);
+=09l2cap_queue_security_work(conn);
+}
+
+static void l2cap_security_work(struct work_struct *work)
+{
+=09struct l2cap_conn *conn =3D container_of(work, struct l2cap_conn,
+=09=09=09=09=09       security_work);
+=09struct l2cap_chan *chan, *next;
+=09LIST_HEAD(pending);
+
+=09hci_dev_lock(conn->hcon->hdev);
+=09mutex_lock(&conn->lock);
+=09if (!test_bit(HCI_UP, &conn->hcon->hdev->flags) ||
+=09    conn->hcon->l2cap_data !=3D conn)
+=09=09goto done;
+
+=09if (atomic_xchg(&conn->security_failure, 0)) {
+=09=09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09=09l2cap_chan_lock(chan);
+=09=09=09if ((chan->state =3D=3D BT_CONNECTED ||
+=09=09=09     chan->state =3D=3D BT_CONNECT2) &&
+=09=09=09    (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09=09set_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09=09}
+=09=09=09l2cap_chan_unlock(chan);
+=09=09}
+=09}
+
+=09/* Hold all selected channels before a callback can remove siblings. */
+=09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09l2cap_chan_lock(chan);
+=09=09if (test_and_clear_bit(FLAG_SECURITY_CFM, &chan->flags) &&
+=09=09    (chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CONNEC=
T2)) {
+=09=09=09l2cap_chan_hold(chan);
+=09=09=09list_add_tail(&chan->security_list, &pending);
+=09=09}
+=09=09l2cap_chan_unlock(chan);
+=09}
+
+=09list_for_each_entry_safe(chan, next, &pending, security_list) {
+=09=09list_del_init(&chan->security_list);
+=09=09l2cap_chan_lock(chan);
+=09=09lockdep_assert_held(&chan->conn->lock);
+=09=09if ((chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CONNEC=
T2) &&
+=09=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09bool failed =3D test_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09bool encrypting =3D test_bit(HCI_CONN_ENCRYPT_PEND,
+=09=09=09=09=09=09   chan->conn->hcon->flags);
+
+=09=09=09if (!failed && encrypting) {
+=09=09=09=09/* Another procedure started on the shared link
+=09=09=09=09 * after the confirmation was queued. Stay
+=09=09=09=09 * pending: its confirmation sets
+=09=09=09=09 * FLAG_SECURITY_CFM and queues this work again.
+=09=09=09=09 */
+=09=09=09} else if (!failed &&
+=09=09=09=09   l2cap_chan_security_sufficient(chan)) {
+=09=09=09=09l2cap_chan_security_complete(chan);
+=09=09=09} else {
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09=09if (l2cap_chan_ecred_rsp_pending(chan))
+=09=09=09=09=09l2cap_chan_ecred_connect_reject(chan);
+=09=09=09=09else
+=09=09=09=09=09__l2cap_chan_close(chan, ECONNREFUSED);
+=09=09=09=09chan->ops->close(chan);
+=09=09=09}
+=09=09}
+=09=09l2cap_chan_unlock(chan);
+=09=09l2cap_chan_put(chan);
+=09}
+done:
+=09mutex_unlock(&conn->lock);
+=09hci_dev_unlock(conn->hcon->hdev);
+=09l2cap_conn_put(conn);
+}
+
+int l2cap_chan_set_security(struct l2cap_chan *chan, u8 level, u8 mic_len)
+{
+=09struct hci_conn *hcon =3D chan->conn->hcon;
+=09u8 old_level =3D chan->sec_level, old_mic =3D chan->mic_len;
+=09u8 old_req_mic =3D hcon->req_mic_len;
+=09u8 old_pending =3D hcon->pending_sec_level;
+=09int err =3D 0;
+
+=09lockdep_assert_held(&hcon->hdev->lock);
+=09lockdep_assert_held(&chan->conn->lock);
+=09lockdep_assert_held(&chan->lock);
+
+=09if (test_bit(FLAG_SECURITY_FAILED, &chan->flags))
+=09=09return -ECONNREFUSED;
+=09/* Do not admit a new request before an old SMP failure is dispatched. =
*/
+=09if (atomic_read(&chan->conn->security_failure))
+=09=09return -EBUSY;
+=09/* Do not change the requirements of a procedure already in progress. *=
/
+=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags) ||
+=09    test_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags) ||
+=09    smp_pairing_in_progress(hcon))
+=09=09return -EBUSY;
+
+=09chan->sec_level =3D level;
+=09chan->mic_len =3D mic_len;
+=09if (!l2cap_chan_check_security(chan, true) ||
+=09    test_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags)) {
+=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09chan->ops->suspend(chan);
+=09=09return 0;
+=09} else if (!l2cap_chan_security_ready(chan)) {
+=09=09/* SMP did not start a procedure that could meet this request. */
+=09=09err =3D -EACCES;
+=09=09goto restore;
+=09}
+
+=09l2cap_chan_security_complete(chan);
+=09return 0;
+restore:
+=09chan->sec_level =3D old_level;
+=09chan->mic_len =3D old_mic;
+=09hcon->req_mic_len =3D old_req_mic;
+=09hcon->pending_sec_level =3D old_pending;
+=09return err;
 }
=20
 static void l2cap_tx_timestamp(struct sk_buff *skb,
@@ -2793,9 +3032,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct m=
sghdr *msg, size_t len,
=20
 =09=09skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
=20
-=09=09l2cap_le_flowctl_send(chan);
-
-=09=09if (!chan->tx_credits)
+=09=09if (!l2cap_le_flowctl_send(chan) || !chan->tx_credits)
 =09=09=09chan->ops->suspend(chan);
=20
 =09=09err =3D len;
@@ -4048,7 +4285,13 @@ static void l2cap_ecred_list_defer(struct l2cap_chan=
 *chan, void *data)
 {
 =09int *result =3D data;
=20
-=09if (*result || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+=09if (!l2cap_chan_ecred_rsp_pending(chan))
+=09=09return;
+=09if (test_bit(FLAG_SECURITY_FAILED, &chan->flags)) {
+=09=09*result =3D -ECONNREFUSED;
+=09=09return;
+=09}
+=09if (*result < 0)
 =09=09return;
=20
 =09switch (chan->state) {
@@ -4057,6 +4300,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
 =09=09(*result)++;
 =09=09return;
 =09case BT_CONNECTED:
+=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09=09(*result)++;
 =09=09return;
 =09default:
 =09=09/* If not connected or pending accept it has been refused */
@@ -4067,6 +4312,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
=20
 struct l2cap_ecred_rsp_data {
 =09struct l2cap_chan *locked_chan;
+=09struct l2cap_chan *accepted[L2CAP_ECRED_MAX_CID];
+=09bool security_failed;
 =09struct {
 =09=09struct l2cap_ecred_conn_rsp_hdr rsp;
 =09=09__le16 scid[L2CAP_ECRED_MAX_CID];
@@ -4111,14 +4358,12 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
 =09=09container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 =09bool locked;
=20
-=09if (chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
-=09=09return;
-
-=09/* Check if channel for outgoing connection or if it wasn't deferred
-=09 * since in those cases it must be skipped.
+=09/* Skip channels for outgoing connections and channels that were not
+=09 * deferred. FLAG_DEFER_SETUP and ident are cleared only after the
+=09 * response is queued (see __l2cap_ecred_conn_rsp_defer()), so that a
+=09 * concurrent l2cap_chan_send() cannot transmit ahead of it.
 =09 */
-=09if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
-=09    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+=09if (!l2cap_chan_ecred_rsp_pending(chan))
 =09=09return;
=20
 =09lockdep_assert_held(&rsp->locked_chan->lock);
@@ -4137,18 +4382,24 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
 =09lockdep_assert_held(&chan->lock);
 =09lockdep_assert_held(&chan->conn->lock);
=20
-=09/* Reset ident so only one response is sent */
-=09chan->ident =3D 0;
-
 =09/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest */
 =09if (WARN_ON_ONCE(rsp->count >=3D ARRAY_SIZE(rsp->pdu.scid)))
 =09=09rsp->pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_NO_MEM);
=20
 =09/* Include all channels pending with the same ident */
-=09if (!rsp->pdu.rsp.result)
+=09if (!rsp->pdu.rsp.result) {
+=09=09rsp->accepted[rsp->count] =3D chan;
+=09=09l2cap_chan_hold(chan);
 =09=09rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
-=09else
-=09=09l2cap_chan_del(chan, ECONNRESET);
+=09} else {
+=09=09clear_bit(FLAG_DEFER_SETUP, &chan->flags);
+=09=09chan->ident =3D 0;
+=09=09if (rsp->security_failed)
+=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09l2cap_chan_del(chan, rsp->security_failed ?
+=09=09=09      ECONNREFUSED : ECONNRESET);
+=09=09chan->ops->close(chan);
+=09}
=20
 done:
 =09if (locked)
@@ -4157,23 +4408,31 @@ done:
 =09l2cap_chan_put(chan);
 }
=20
-void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+int __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 {
 =09struct l2cap_conn *conn =3D chan->conn;
 =09struct l2cap_ecred_rsp_data data;
+=09struct l2cap_chan *sibling;
 =09u16 id =3D chan->ident;
 =09int result =3D 0;
+=09int i;
=20
 =09if (!id)
-=09=09return;
+=09=09return 0;
 =09if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
-=09=09return;
+=09=09return 0;
=20
 =09BT_DBG("chan %p id %d", chan, id);
=20
 =09memset(&data, 0, sizeof(data));
=20
 =09data.locked_chan =3D chan;
+=09list_for_each_entry(sibling, &conn->chan_l, list) {
+=09=09if (sibling->ident =3D=3D id &&
+=09=09    l2cap_chan_ecred_rsp_pending(sibling) &&
+=09=09    test_bit(FLAG_SECURITY_FAILED, &sibling->flags))
+=09=09=09data.security_failed =3D true;
+=09}
=20
 =09data.pdu.rsp.mtu     =3D cpu_to_le16(chan->imtu);
 =09data.pdu.rsp.mps     =3D cpu_to_le16(chan->mps);
@@ -4184,7 +4443,7 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *=
chan)
 =09__l2cap_chan_list_id(conn, id, l2cap_ecred_list_defer, &result);
=20
 =09if (result > 0)
-=09=09return;
+=09=09return 0;
=20
 =09if (result < 0)
 =09=09data.pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION);
@@ -4195,6 +4454,32 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan =
*chan)
 =09l2cap_send_cmd(conn, id, L2CAP_ECRED_CONN_RSP,
 =09=09       sizeof(data.pdu.rsp) + (data.count * sizeof(__le16)),
 =09=09       &data.pdu);
+
+=09/* Data must follow the connection response on the wire. */
+=09for (i =3D 0; i < data.count; i++) {
+=09=09struct l2cap_chan *accepted =3D data.accepted[i];
+=09=09bool locked =3D l2cap_chan_try_sibling_lock(accepted, chan);
+
+=09=09/* The response is queued: open the data gate and make later
+=09=09 * calls for this batch return early. Both are done under the
+=09=09 * channel lock, so no sender sees one without the other.
+=09=09 */
+=09=09if (locked) {
+=09=09=09clear_bit(FLAG_DEFER_SETUP, &accepted->flags);
+=09=09=09accepted->ident =3D 0;
+=09=09=09if (!test_bit(FLAG_DEL, &accepted->flags))
+=09=09=09=09l2cap_le_flowctl_resume(accepted);
+=09=09=09l2cap_chan_unlock(accepted);
+=09=09} else if (accepted =3D=3D chan) {
+=09=09=09clear_bit(FLAG_DEFER_SETUP, &chan->flags);
+=09=09=09chan->ident =3D 0;
+=09=09=09if (!test_bit(FLAG_DEL, &chan->flags))
+=09=09=09=09l2cap_le_flowctl_resume(chan);
+=09=09}
+=09=09l2cap_chan_put(accepted);
+=09}
+
+=09return data.security_failed ? -ECONNREFUSED : 0;
 }
=20
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
@@ -5488,10 +5773,7 @@ static inline int l2cap_le_credits(struct l2cap_conn=
 *conn,
 =09chan->tx_credits +=3D credits;
=20
 =09/* Resume sending */
-=09l2cap_le_flowctl_send(chan);
-
-=09if (chan->tx_credits)
-=09=09chan->ops->resume(chan);
+=09l2cap_le_flowctl_resume(chan);
=20
 unlock:
 =09l2cap_chan_unlock(chan);
@@ -7648,6 +7930,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_c=
onn *hcon)
=20
 =09skb_queue_head_init(&conn->pending_rx);
 =09INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+=09INIT_WORK(&conn->security_work, l2cap_security_work);
+=09atomic_set(&conn->security_failure, 0);
 =09INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr);
=20
 =09conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
@@ -8114,6 +8398,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -8121,7 +8407,10 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 =09=09       state_to_string(chan->state));
=20
-=09=09if (!status && encrypt)
+=09=09le_flowctl =3D hcon->type =3D=3D LE_LINK &&
+=09=09=09     (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09      chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL);
+=09=09if (!status && encrypt && !le_flowctl)
 =09=09=09chan->sec_level =3D hcon->sec_level;
=20
 =09=09if (!__l2cap_no_conn_pending(chan)) {
@@ -8129,6 +8418,31 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09=09continue;
 =09=09}
=20
+=09=09if (le_flowctl && (chan->state =3D=3D BT_CONNECTED ||
+=09=09=09=09   chan->state =3D=3D BT_CONNECT2)) {
+=09=09=09bool pending =3D test_bit(FLAG_PENDING_SECURITY, &chan->flags);
+
+=09=09=09/* An authentication event may precede encryption completion. */
+=09=09=09if (pending && !status &&
+=09=09=09    test_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags)) {
+=09=09=09=09l2cap_chan_unlock(chan);
+=09=09=09=09continue;
+=09=09=09}
+=09=09=09if ((status && pending) ||
+=09=09=09    !l2cap_chan_security_sufficient(chan)) {
+=09=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09}
+=09=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09=09set_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09=09=09l2cap_queue_security_work(conn);
+=09=09=09} else if (!status && chan->state =3D=3D BT_CONNECTED) {
+=09=09=09=09l2cap_le_flowctl_resume(chan);
+=09=09=09}
+=09=09=09l2cap_chan_unlock(chan);
+=09=09=09continue;
+=09=09}
+
 =09=09if (!status && (chan->state =3D=3D BT_CONNECTED ||
 =09=09=09=09chan->state =3D=3D BT_CONFIG)) {
 =09=09=09chan->ops->resume(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d5663a4642a9c0fd1b4f262701f2addb4d3d8d03..4db1e9f5d15937000177903f76a=
b54af1795ceab 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -929,12 +929,65 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8=
 mode)
 =09return 0;
 }
=20
+static int l2cap_sock_set_security(struct sock *sk, struct l2cap_chan *cha=
n,
+=09=09=09=09   const struct bt_security *sec)
+{
+=09struct l2cap_conn *conn =3D l2cap_chan_conn(chan);
+=09int err =3D 0;
+
+=09lock_sock(sk);
+=09if (conn && conn->hcon->type =3D=3D LE_LINK &&
+=09    (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)) {
+=09=09if (sk->sk_state !=3D BT_CONNECTED &&
+=09=09    !(sk->sk_state =3D=3D BT_CONNECT2 &&
+=09=09      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) {
+=09=09=09release_sock(sk);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09release_sock(sk);
+=09=09return l2cap_chan_set_security(chan, sec->level, sec->mic_len);
+=09}
+
+=09chan->sec_level =3D sec->level;
+=09chan->mic_len =3D sec->mic_len;
+=09if (!conn)
+=09=09goto done;
+=09if (chan->scid =3D=3D L2CAP_CID_ATT) {
+=09=09release_sock(sk);
+=09=09l2cap_chan_req_mic_len(chan, conn->hcon);
+=09=09if (smp_conn_security(conn->hcon, sec->level))
+=09=09=09return -EINVAL;
+=09=09lock_sock(sk);
+=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+=09=09sk->sk_state =3D BT_CONFIG;
+=09=09chan->state =3D BT_CONFIG;
+=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
+=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
+=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
+=09=09bool ready;
+
+=09=09release_sock(sk);
+=09=09ready =3D l2cap_chan_check_security(chan, true);
+=09=09lock_sock(sk);
+=09=09if (!ready)
+=09=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+=09=09else
+=09=09=09sk->sk_state_change(sk);
+=09} else {
+=09=09err =3D -EINVAL;
+=09}
+done:
+=09release_sock(sk);
+=09return err;
+}
+
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optna=
me,
 =09=09=09=09 sockptr_t optval, unsigned int optlen)
 {
 =09struct sock *sk =3D sock->sk;
 =09struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
-=09struct bt_security sec;
 =09struct bt_power pwr;
 =09struct l2cap_conn *conn;
 =09int err =3D 0;
@@ -950,78 +1003,59 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname,
 =09if (level !=3D SOL_BLUETOOTH)
 =09=09return -ENOPROTOOPT;
=20
-=09l2cap_chan_lock(chan);
-=09lock_sock(sk);
+=09if (optname =3D=3D BT_SECURITY) {
+=09=09struct bt_security sec =3D { .level =3D BT_SECURITY_LOW };
+=09=09bool have_conn;
=20
-=09switch (optname) {
-=09case BT_SECURITY:
-=09=09if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED &&
-=09=09    chan->chan_type !=3D L2CAP_CHAN_FIXED &&
-=09=09    chan->chan_type !=3D L2CAP_CHAN_RAW) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
-
-=09=09/* mic_len was added at the end of struct bt_security, so
-=09=09 * accept the shorter struct as well, leaving mic_len unset.
-=09=09 */
-=09=09if (optlen < offsetofend(struct bt_security, key_size)) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
+=09=09/* Keep accepting the struct size used before mic_len was added. */
+=09=09if (optlen < offsetofend(struct bt_security, key_size))
+=09=09=09return -EINVAL;
=20
-=09=09err =3D copy_struct_from_sockptr(&sec, sizeof(sec), optval,
-=09=09=09=09=09       optlen);
+=09=09err =3D copy_struct_from_sockptr(&sec, sizeof(sec), optval, optlen);
 =09=09if (err)
-=09=09=09break;
-
-=09=09if (sec.level < BT_SECURITY_LOW ||
-=09=09    sec.level > BT_SECURITY_FIPS) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
+=09=09=09return err;
=20
-=09=09/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4,
-=09=09 * Part E, Section 7.7.8: MIC_Length 0x00 is 32 bits,
-=09=09 * 0x01 is 64 bits and 0x02 is 128 bits; all other
-=09=09 * values are reserved for future use.
-=09=09 */
-=09=09if (sec.mic_len > 0x02) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
+=09=09if (sec.level < BT_SECURITY_LOW || sec.level > BT_SECURITY_FIPS)
+=09=09=09return -EINVAL;
=20
-=09=09chan->sec_level =3D sec.level;
-=09=09chan->mic_len =3D sec.mic_len;
+=09=09/* MIC length encodings 0, 1 and 2 mean 32, 64 and 128 bits. */
+=09=09if (sec.mic_len > 0x02)
+=09=09=09return -EINVAL;
=20
+=09=09l2cap_chan_lock(chan);
+=09=09if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED &&
+=09=09    chan->chan_type !=3D L2CAP_CHAN_FIXED &&
+=09=09    chan->chan_type !=3D L2CAP_CHAN_RAW) {
+=09=09=09l2cap_chan_unlock(chan);
+=09=09=09return -EINVAL;
+=09=09}
 =09=09conn =3D l2cap_chan_conn(chan);
-=09=09if (!conn)
-=09=09=09break;
+=09=09if (!conn) {
+=09=09=09err =3D l2cap_sock_set_security(sk, chan, &sec);
+=09=09=09l2cap_chan_unlock(chan);
+=09=09=09return err;
+=09=09}
+=09=09l2cap_conn_get(conn);
+=09=09l2cap_chan_unlock(chan);
=20
-=09=09/* change security for LE channels */
-=09=09if (chan->scid =3D=3D L2CAP_CID_ATT) {
-=09=09=09l2cap_chan_req_mic_len(chan, conn->hcon);
-=09=09=09if (smp_conn_security(conn->hcon, sec.level)) {
-=09=09=09=09err =3D -EINVAL;
-=09=09=09=09break;
-=09=09=09}
+=09=09/* SMP receive holds conn->lock; management holds hdev->lock. */
+=09=09hci_dev_lock(conn->hcon->hdev);
+=09=09have_conn =3D l2cap_chan_lock_conn(chan);
=20
-=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
-=09=09=09sk->sk_state =3D BT_CONFIG;
-=09=09=09chan->state =3D BT_CONFIG;
+=09=09if (l2cap_chan_conn(chan) !=3D conn)
+=09=09=09err =3D -ENOTCONN;
+=09=09else
+=09=09=09err =3D l2cap_sock_set_security(sk, chan, &sec);
+=09=09l2cap_chan_unlock_conn(chan, have_conn);
+=09=09hci_dev_unlock(conn->hcon->hdev);
+=09=09l2cap_conn_put(conn);
+=09=09return err;
+=09}
=20
-=09=09/* or for ACL link */
-=09=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
-=09=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
-=09=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
-=09=09=09if (!l2cap_chan_check_security(chan, true))
-=09=09=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
-=09=09=09else
-=09=09=09=09sk->sk_state_change(sk);
-=09=09} else {
-=09=09=09err =3D -EINVAL;
-=09=09}
-=09=09break;
+=09l2cap_chan_lock(chan);
+=09lock_sock(sk);
+
+=09switch (optname) {
=20
 =09case BT_DEFER_SETUP:
 =09=09if (sk->sk_state !=3D BT_BOUND && sk->sk_state !=3D BT_LISTEN) {
@@ -1284,11 +1318,20 @@ static int l2cap_sock_defer(struct sock *sk)
 =09=09if (!have_conn) {
 =09=09=09release_sock(sk);
 =09=09=09err =3D -ENOTCONN;
+=09=09} else if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09    chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09=09   test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09release_sock(sk);
+=09=09=09err =3D -EAGAIN;
 =09=09} else if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
+=09=09=09int result;
+
 =09=09=09sk->sk_state =3D BT_CONNECTED;
 =09=09=09chan->state =3D BT_CONNECTED;
 =09=09=09release_sock(sk);
-=09=09=09__l2cap_ecred_conn_rsp_defer(chan);
+=09=09=09result =3D __l2cap_ecred_conn_rsp_defer(chan);
+=09=09=09if (result)
+=09=09=09=09err =3D result;
 =09=09} else if (bdaddr_type_is_le(chan->src_type)) {
 =09=09=09sk->sk_state =3D BT_CONNECTED;
 =09=09=09chan->state =3D BT_CONNECTED;
@@ -1778,7 +1821,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan=
 *chan, int err)
 =09=09sk->sk_state =3D BT_CLOSED;
 =09=09chan->state =3D BT_CLOSED;
=20
-=09=09sk->sk_err =3D err;
+=09=09if (!test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
+=09=09    READ_ONCE(sk->sk_err) !=3D ECONNREFUSED)
+=09=09=09sk->sk_err =3D err;
+=09=09clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
=20
 =09=09if (parent) {
 =09=09=09/*
@@ -1814,8 +1860,11 @@ static void l2cap_sock_state_change_cb(struct l2cap_=
chan *chan, int state,
=20
 =09sk->sk_state =3D state;
=20
-=09if (err)
+=09if (err) {
 =09=09sk->sk_err =3D err;
+=09=09clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+=09=09sk->sk_state_change(sk);
+=09}
=20
 =09release_sock(sk);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 62a6b1e8f7cb11eed874dbacf211fe861513f2fa..bc54e0e65e19624c775edb94a0e=
8fca2c8fc5305 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -785,6 +785,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 rea=
son)
 =09=09=09     &reason);
=20
 =09mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
+=09l2cap_security_failure(conn);
=20
 =09if (chan->data)
 =09=09smp_chan_destroy(conn);

