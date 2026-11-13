Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539181;
	b=Ac9CJTYCPHHvnBjd6KoTnMpdqzJkkY6NPf8aEoN+ePym+5OhWY4vIAErswgwSLj7M8Eb
	 uALHzsI+PLZF1cspot6EvIQI+/XWwtRrNM243WYEtHnljs0TvJ5h6PSnrIz9E6HmXeNYE
	 sI0QQ8oKb5tP2zJ08TXzW5bOPLUrKV8EVbmNEc4tpWt7R2aYzFtOz47pP31UVVlsgw3Xp
	 oklFRpMzksehKqi3nwq1u8a6K0fQYa6d3VvDMpMi0A5yCOmXUp7lnNSxILie7CPPrC72F
	 /LBKZe5/MFFXyvoieHmuGjgzuuZoWIRo96HJjtKfHU6K5PS+XxGjvz1m6DeZ6UgKovg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539181;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kh+tcdmUqWLpYJ10VzVk3Z9Z4bd01wXdUTRuucB35YQ=;
	b=ivx0ArYil6mmyDdfSUNA9KK5GXBsFrzrRYCk3IrQBP2apUKzmNYCWnTOtNV3fI7TTNJt
	 Ozr51Cdye+oRhSDracpTcqpj9QWPPJV8WgBQY4J3i9+RB9glXYxM5BRgTFoRIa3OW8UoQ
	 11WnGKEx7dCV9o+ofMFCKwFBwD1xSWImPTBnVXCU34V3EYLLZwLpvesdFDIN4RSL/OzUV
	 +uCSm0NUxvimZQFRH5GYaMVogGkkbqyeYeYCOsDxPAJF/qI5fJipg8hOk7q6bLbLCqG++
	 TTLLuXS/Z5ZgCIuiEOwSXU1yvjjynKohB4jzyD5O9jo24UCmyUaIHxiB/ex/gDJZmMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=a4gwYA5u;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F7606A321;
	Fri, 13 Nov 2026 03:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=a4gwYA5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794539177; x=1794798377;
	bh=kh+tcdmUqWLpYJ10VzVk3Z9Z4bd01wXdUTRuucB35YQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a4gwYA5uiRqwtSDvXGs0ds3AuS8iLzUpwYXWEbCV9/PwqjpWDasUoNpF9vBII7A9K
	 ScZp+Oa+X4u/nFFF8uilyLjsWac+KIlV1nHVE8BS6mnKddeo4GTmBqtnk172cXjfeg
	 nN2O2CumQhyyn0dZFctDRqGR1InJmQE7/sjfd8IBXVOc5tMNvh7dwqMCeiuxulDZav
	 0ub7v98tW4uTQNNmwqzUq9X2ZvwmU3ZdGQQeEZASivTo+dnEh+f9bMETIGfrsC2Thf
	 Ap8YQkXiDlgVLI3JGCNFtJosgWrlk5WDbbZUUaJJz5JMV4oyXicIz8K16d9VGz5dte
	 z73PYYYe28b7w==
Date: Fri, 13 Nov 2026 03:06:13 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261113030556.75484-2-cochcoder@proton.me>
In-Reply-To: <20261113030556.75484-1-cochcoder@proton.me>
References: <20261113030556.75484-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 74ea17031864819f0bf591c2b26384db4481ff99
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
Latch SMP failure before admitting a fresh request, and fail pending
requests even if a later confirmation would otherwise satisfy them.
Use the existing pairing and HCI timeouts without a new request deadline.

Drain retained data when security completes or the requested requirement
is lowered to an achieved level. Return EACCES and restore the old request
when SMP starts no procedure and the requirements remain unmet. Preserve
each CoC's requested level across shared-link confirmations.

Keep deferred reads pending during an upgrade. Send an ECRED response
before releasing accepted children's data and reject the batch on security
failure. Preserve ordinary deferred rejection behavior.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
 include/net/bluetooth/l2cap.h |   7 +
 net/bluetooth/l2cap_core.c    | 295 ++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    | 169 +++++++++++--------
 net/bluetooth/smp.c           |   1 +
 4 files changed, 394 insertions(+), 78 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cf5c2df68..7b95bd407 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -604,6 +604,7 @@ struct l2cap_chan {
 =09__u32=09=09remote_flush_to;
=20
 =09struct delayed_work=09chan_timer;
+=09struct list_head=09security_list;
 =09struct delayed_work=09retrans_timer;
 =09struct delayed_work=09monitor_timer;
 =09struct delayed_work=09ack_timer;
@@ -644,6 +645,8 @@ struct l2cap_conn {
=20
 =09struct sk_buff_head=09pending_rx;
 =09struct work_struct=09pending_rx_work;
+=09struct work_struct=09security_work;
+=09atomic_t=09=09security_failure;
 =09bool=09=09=09pending_rx_blocked __guarded_by(&lock);
=20
 =09struct delayed_work=09id_addr_timer;
@@ -767,6 +770,8 @@ enum {
 =09FLAG_ECRED_CONN_REQ_SENT,
 =09FLAG_ECRED_RECONF_REQ_SENT,
 =09FLAG_PENDING_SECURITY,
+=09FLAG_SECURITY_CFM,
+=09FLAG_SECURITY_FAILED,
 =09FLAG_HOLD_HCI_CONN,
 =09FLAG_DEL,
 };
@@ -993,6 +998,8 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)=
;
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
index 4e8aec98e..3736eda47 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,7 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2ca=
p_ctrl *control,
 static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
+static void l2cap_security_work(struct work_struct *work);
 static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 =09__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
=20
@@ -479,6 +480,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 =09write_unlock(&chan_list_lock);
=20
 =09INIT_DELAYED_WORK(&chan->chan_timer, l2cap_chan_timeout);
+=09INIT_LIST_HEAD(&chan->security_list);
 =09INIT_DELAYED_WORK(&chan->retrans_timer, l2cap_retrans_timeout);
 =09INIT_DELAYED_WORK(&chan->monitor_timer, l2cap_monitor_timeout);
 =09INIT_DELAYED_WORK(&chan->ack_timer, l2cap_ack_timeout);
@@ -709,7 +711,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
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
@@ -2705,12 +2710,21 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *=
chan,
 =09return 0;
 }
=20
-static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
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
+=09    (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && chan->ident &&
+=09     test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
+=09     !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags)))
+=09=09return false;
+
 =09while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
 =09=09l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
 =09=09chan->tx_credits--;
@@ -2719,6 +2733,192 @@ static void l2cap_le_flowctl_send(struct l2cap_chan=
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
+=09=09=09if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
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
+=09=09if (test_and_clear_bit(FLAG_SECURITY_CFM, &chan->flags)) {
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
+=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09if (!test_bit(FLAG_SECURITY_FAILED, &chan->flags) &&
+=09=09=09    l2cap_chan_security_ready(chan)) {
+=09=09=09=09l2cap_chan_security_complete(chan);
+=09=09=09} else {
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09=09if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL &&
+=09=09=09=09    chan->ident &&
+=09=09=09=09    test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
+=09=09=09=09    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
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
+
+=09chan->sec_level =3D level;
+=09chan->mic_len =3D mic_len;
+=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09if (!l2cap_chan_security_ready(chan)) {
+=09=09=09err =3D -EBUSY;
+=09=09=09goto restore;
+=09=09}
+=09} else if (!l2cap_chan_check_security(chan, true) ||
+=09=09   test_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags)) {
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
+=09return err;
 }
=20
 static void l2cap_tx_timestamp(struct sk_buff *skb,
@@ -2791,9 +2991,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct m=
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
@@ -4043,7 +4241,14 @@ static void l2cap_ecred_list_defer(struct l2cap_chan=
 *chan, void *data)
 {
 =09int *result =3D data;
=20
-=09if (*result || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+=09if (chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL ||
+=09    test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+=09=09return;
+=09if (test_bit(FLAG_SECURITY_FAILED, &chan->flags)) {
+=09=09*result =3D -ECONNREFUSED;
+=09=09return;
+=09}
+=09if (*result)
 =09=09return;
=20
 =09switch (chan->state) {
@@ -4052,6 +4257,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
 =09=09(*result)++;
 =09=09return;
 =09case BT_CONNECTED:
+=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09=09(*result)++;
 =09=09return;
 =09default:
 =09=09/* If not connected or pending accept it has been refused */
@@ -4062,6 +4269,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
=20
 struct l2cap_ecred_rsp_data {
 =09struct l2cap_chan *locked_chan;
+=09struct l2cap_chan *accepted[L2CAP_ECRED_MAX_CID];
+=09bool security_failed;
 =09struct {
 =09=09struct l2cap_ecred_conn_rsp_hdr rsp;
 =09=09__le16 scid[L2CAP_ECRED_MAX_CID];
@@ -4140,10 +4349,16 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
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
+=09=09l2cap_chan_del(chan, rsp->security_failed ?
+=09=09=09      ECONNREFUSED : ECONNRESET);
+=09=09if (rsp->security_failed && chan !=3D rsp->locked_chan)
+=09=09=09chan->ops->close(chan);
+=09}
=20
 done:
 =09if (locked)
@@ -4156,8 +4371,10 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan =
*chan)
 {
 =09struct l2cap_conn *conn =3D chan->conn;
 =09struct l2cap_ecred_rsp_data data;
+=09struct l2cap_chan *sibling;
 =09u16 id =3D chan->ident;
 =09int result =3D 0;
+=09int i;
=20
 =09if (!id)
 =09=09return;
@@ -4169,6 +4386,13 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan =
*chan)
 =09memset(&data, 0, sizeof(data));
=20
 =09data.locked_chan =3D chan;
+=09list_for_each_entry(sibling, &conn->chan_l, list) {
+=09=09if (sibling->ident =3D=3D id &&
+=09=09    sibling->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL &&
+=09=09    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &sibling->flags) &&
+=09=09    test_bit(FLAG_SECURITY_FAILED, &sibling->flags))
+=09=09=09data.security_failed =3D true;
+=09}
=20
 =09data.pdu.rsp.mtu     =3D cpu_to_le16(chan->imtu);
 =09data.pdu.rsp.mps     =3D cpu_to_le16(chan->mps);
@@ -4190,6 +4414,22 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan =
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
+=09=09if (locked) {
+=09=09=09if (!test_bit(FLAG_DEL, &accepted->flags))
+=09=09=09=09l2cap_le_flowctl_resume(accepted);
+=09=09=09l2cap_chan_unlock(accepted);
+=09=09} else if (accepted =3D=3D chan &&
+=09=09=09   !test_bit(FLAG_DEL, &chan->flags)) {
+=09=09=09l2cap_le_flowctl_resume(chan);
+=09=09}
+=09=09l2cap_chan_put(accepted);
+=09}
 }
=20
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
@@ -5483,10 +5723,7 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -7623,6 +7860,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_c=
onn *hcon)
=20
 =09skb_queue_head_init(&conn->pending_rx);
 =09INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+=09INIT_WORK(&conn->security_work, l2cap_security_work);
+=09atomic_set(&conn->security_failure, 0);
 =09INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr);
=20
 =09conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
@@ -8089,6 +8328,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -8096,7 +8337,10 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
@@ -8104,6 +8348,31 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
index d8a7b5f4b..ad38fba6a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -929,12 +929,59 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8=
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
+=09=09l2cap_chan_req_mic_len(chan, conn->hcon);
+=09=09if (smp_conn_security(conn->hcon, sec->level)) {
+=09=09=09err =3D -EINVAL;
+=09=09=09goto done;
+=09=09}
+=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09sk->sk_state =3D BT_CONFIG;
+=09=09chan->state =3D BT_CONFIG;
+=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
+=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
+=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
+=09=09if (!l2cap_chan_check_security(chan, true))
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
@@ -950,78 +997,59 @@ static int l2cap_sock_setsockopt(struct socket *sock,=
 int level, int optname,
 =09if (level !=3D SOL_BLUETOOTH)
 =09=09return -ENOPROTOOPT;
=20
-=09l2cap_chan_lock(chan);
-=09lock_sock(sk);
-
-=09switch (optname) {
-=09case BT_SECURITY:
-=09=09if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED &&
-=09=09    chan->chan_type !=3D L2CAP_CHAN_FIXED &&
-=09=09    chan->chan_type !=3D L2CAP_CHAN_RAW) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
+=09if (optname =3D=3D BT_SECURITY) {
+=09=09struct bt_security sec =3D { .level =3D BT_SECURITY_LOW };
+=09=09bool have_conn;
=20
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
@@ -1284,6 +1312,11 @@ static int l2cap_sock_defer(struct sock *sk)
 =09=09if (!have_conn) {
 =09=09=09release_sock(sk);
 =09=09=09err =3D -ENOTCONN;
+=09=09} else if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09    chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09=09   test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09release_sock(sk);
+=09=09=09err =3D -EAGAIN;
 =09=09} else if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
 =09=09=09sk->sk_state =3D BT_CONNECTED;
 =09=09=09chan->state =3D BT_CONNECTED;
@@ -1774,7 +1807,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan=
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
@@ -1810,8 +1846,11 @@ static void l2cap_sock_state_change_cb(struct l2cap_=
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
index f8f86b8f7..84d85613c 100644
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

