Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794035820;
	b=SVcaqNr/u7JKx/1EaWTtoJ9WkS3FvMFGtfoaJfGQGYyFp4X1DiMZZfHCOC3+qne5jok1
	 JyQE7S7YRRKB1wtRBmrekmHrE5pfqR+Vt/Sxu/s1OwuntEVegLuIr0CwnDtWb8up6fn0w
	 SmJJixluD/p7ej5HHitwpzrH2TUvCQuJqZeO8/UTD+a/3oBza49ichMdvOmmWoRtc5Flw
	 UNRkG+zCTR9hxNi+TBO2BdB38899cHV5y9mnCBtKhZxGa6gD5QCDKVHj8kuBzzrY6xa0R
	 IzoiV0OWvOjAkxRv10yTxPVaveAtCm+VxdF9NhGWfGqxvgW72uxIPk+9dha2Q2MxMHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794035820;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jFU0FNhDD8Cj1PGykaxWFEZGVBEI4KdNTMsWVjzzBNc=;
	b=1cafwEbTz8gM2zg9jTpj6IjM6KgVQvYFsQmDixeY7MqaccFO1lZWp+yjBmc2xr3FeP9g
	 kC9m72Vczs4bDiCpeypU5C4NaS+2LfNf5bvzc+26lx23mJhxJHiPPENScFyS/D0oCN801
	 OnzxXb9elRA50n0I36f1ka3KVX0FZcyGJuVIUpBEgrmCj5TRAhusmVBSTgRCXl5YBcpwn
	 OVElKdWKkVsYEHc61f3pWP/vsMed3vUOLQm4KNIPgysjHcl4tOHLD4aCNCEVVjIdqIg/g
	 DOo7D/kdfP0d5JY0Hj7DNPh/YK6VKFJqfGm0/f91jQAOXySahNQ7Lkr2Bf2w+Gwrizw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=E3bw7kh9;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA5606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 07:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BA5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=E3bw7kh9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794035813; x=1794295013;
	bh=jFU0FNhDD8Cj1PGykaxWFEZGVBEI4KdNTMsWVjzzBNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E3bw7kh9PBlix7vpiDF3NX5ODWnlIiGrw4qvpACCCsNG/jYYX1cJfmPEvR4bsS7AU
	 jNNSrQmBZo26/eGLwL1YAdRuxwHnoCvmFu4tW187kB80D+k7GY3EtvhkCNR95pzqms
	 TI+vOjmJw7nsoislAB0onamX9tft5IHZ58A9+EloPZEoticLpztqLZ0Y51m7OVu0tu
	 NBqp3KVbPbX7wezyAmMn7am7aSfWMYJLmzRPzie8RvcYmasEPbVk/hovVDQj6mWPN8
	 ParsOSOhoG/q+Zfv7xksekKGosKvEspMkQ1Wsca5ZjLZrRuC7jQd1B6W+dzPfb6uRr
	 XT9LyHkXGXWqw==
Date: Sat, 07 Nov 2026 07:16:51 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v8 1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261107071634.2237059-1-cochcoder@proton.me>
In-Reply-To: <20261107023556.1475788-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me> <20261107023556.1475788-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 8e7ea3409d77b22c59747256fe581969028f8e13
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

Retain LE and ECRED credits without sending queued data or resuming
connected sockets while a security upgrade is pending. Guard the shared
send path and deferred acceptance, and preserve the requested level.

Finish pending upgrades from referenced connection work outside the
security callback's list walk. Keep failures terminal across later
confirmations and notify pending channels when local SMP pairing fails.
Use a dedicated unbound queue so management replies can report failure
while the device queue drains. Drain it before L2CAP exits and release
it if socket initialization fails. Ignore detached or powered-down links.

Serialize BT_SECURITY with SMP failure under the device lock, followed
by the connection, channel and socket locks. Record a failure generation
on each request so delayed failure work leaves newer requests alone.
Publish the failing generation in the consumed atomic and compare request
generations with signed subtraction. Skip zero when the counter wraps.
Keep EBUSY for channels with their own upgrade already pending.

HCI confirmations describe the current ACL link. A failed encryption event
can disconnect it, so pending requests still fail regardless of their
local SMP generation. The powered-down check is advisory; HCI separately
guards transmit admission while draining and flushes connections on close.

Check every deferred ECRED sibling before responding. Reject the whole
batch on failure even if a child has already become BT_CONNECTED while
waiting for the response. Include a zero destination CID for each refused
channel. Close rejected children under a temporary reference, using child
socket lock nesting, so unaccepted sockets release their ownership.
Normal incoming ECRED channels enter BT_CONNECT2 only with deferred setup.
For a synthetic child without that flag or an identifier, delete locally;
there is no pending deferred response to send. Choose this fallback before
batch handling, avoiding a channel read after rejected children close.

Wake deferred sockets after successful security even with no initial
credits. Consume and return deferred batch errors. Preserve a pending
security rejection through teardown without masking unrelated socket
errors, and clear security and suspension state when removing a channel.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes since v7: defer rejection of an unencrypted deferred ECRED batch
from the security callback to the security workqueue.

Validation: mocked source-level tests pass; native v8 testing, hardware,
KCSAN, PTS and remote CI remain unverified. Leak detection did not run.

Previous version: https://lore.kernel.org/linux-bluetooth/20261107023556.14=
75788-1-cochcoder@proton.me/

 include/net/bluetooth/l2cap.h |   7 +
 net/bluetooth/l2cap_core.c    | 233 ++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    | 164 ++++++++++++++++--------
 net/bluetooth/smp.c           |   1 +
 4 files changed, 344 insertions(+), 61 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2a05bda8a..4aba89900 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -612,6 +612,7 @@ struct l2cap_chan {
 =09void=09=09=09*data;
 =09const struct l2cap_ops=09*ops;
 =09struct mutex=09=09lock;
+=09unsigned int=09=09security_generation;
 };
=20
 struct l2cap_conn {
@@ -636,6 +637,9 @@ struct l2cap_conn {
=20
 =09struct sk_buff_head=09pending_rx;
 =09struct work_struct=09pending_rx_work;
+=09struct work_struct=09security_work;
+=09atomic_t=09=09security_failed;
+=09atomic_t=09=09security_generation;
=20
 =09struct delayed_work=09id_addr_timer;
=20
@@ -758,6 +762,8 @@ enum {
 =09FLAG_ECRED_CONN_REQ_SENT,
 =09FLAG_ECRED_RECONF_REQ_SENT,
 =09FLAG_PENDING_SECURITY,
+=09FLAG_SECURITY_CFM,
+=09FLAG_SECURITY_FAILED,
 =09FLAG_HOLD_HCI_CONN,
 =09FLAG_DEL,
 };
@@ -983,6 +989,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msg=
hdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
+void l2cap_security_failed(struct l2cap_conn *conn);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *p=
chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dcb0586a..3a7b71321 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -59,6 +59,8 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2ca=
p_ctrl *control,
 static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
+static void l2cap_security_work(struct work_struct *work);
+static struct workqueue_struct *l2cap_security_wq;
 static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 =09__must_hold(&chan->lock) __must_hold(&chan->conn->lock);
=20
@@ -704,11 +706,14 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 =09lockdep_assert(!chan->conn || lockdep_is_held(&chan->conn->lock));
=20
 =09__clear_chan_timer(chan);
+=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
=20
 =09BT_DBG("chan %p, err %d, state %s", chan, err,
 =09       state_to_string(chan->state));
=20
 =09chan->ops->teardown(chan, err);
+=09clear_bit(FLAG_SECURITY_FAILED, &chan->flags);
=20
 =09if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
 =09=09/* Delete from channel list */
@@ -876,6 +881,13 @@ static void __l2cap_chan_close(struct l2cap_chan *chan=
, int reason)
=20
 =09case BT_CONNECTED:
 =09case BT_CONFIG:
+=09=09if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && chan->ident &&
+=09=09    test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
+=09=09    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags)) {
+=09=09=09l2cap_chan_ecred_connect_reject(chan);
+=09=09=09break;
+=09=09}
+
 =09=09if (chan->chan_type =3D=3D L2CAP_CHAN_CONN_ORIENTED) {
 =09=09=09__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 =09=09=09l2cap_send_disconn_req(chan, reason);
@@ -893,7 +905,11 @@ static void __l2cap_chan_close(struct l2cap_chan *chan=
, int reason)
 =09=09=09=09=09l2cap_chan_le_connect_reject(chan);
 =09=09=09=09=09break;
 =09=09=09=09case L2CAP_MODE_EXT_FLOWCTL:
-=09=09=09=09=09l2cap_chan_ecred_connect_reject(chan);
+=09=09=09=09=09if (chan->ident &&
+=09=09=09=09=09    test_bit(FLAG_DEFER_SETUP, &chan->flags))
+=09=09=09=09=09=09l2cap_chan_ecred_connect_reject(chan);
+=09=09=09=09=09else
+=09=09=09=09=09=09l2cap_chan_del(chan, reason);
 =09=09=09=09=09return;
 =09=09=09=09}
 =09=09=09}
@@ -2647,6 +2663,9 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *=
chan)
=20
 =09BT_DBG("chan %p", chan);
=20
+=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09return;
+
 =09while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
 =09=09l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
 =09=09chan->tx_credits--;
@@ -3979,8 +3998,13 @@ static void l2cap_ecred_list_defer(struct l2cap_chan=
 *chan, void *data)
 {
 =09int *result =3D data;
=20
-=09if (*result || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+=09if (*result < 0 || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+=09=09return;
+
+=09if (test_bit(FLAG_SECURITY_FAILED, &chan->flags)) {
+=09=09*result =3D -ECONNREFUSED;
 =09=09return;
+=09}
=20
 =09switch (chan->state) {
 =09case BT_CONNECT2:
@@ -3988,6 +4012,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
 =09=09(*result)++;
 =09=09return;
 =09case BT_CONNECTED:
+=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09=09(*result)++;
 =09=09return;
 =09default:
 =09=09/* If not connected or pending accept it has been refused */
@@ -4076,10 +4102,16 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
 =09=09rsp->pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_NO_MEM);
=20
 =09/* Include all channels pending with the same ident */
-=09if (!rsp->pdu.rsp.result)
+=09if (!rsp->pdu.rsp.result) {
 =09=09rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
-=09else
-=09=09l2cap_chan_del(chan, ECONNRESET);
+=09} else {
+=09=09if (rsp->count < ARRAY_SIZE(rsp->pdu.scid))
+=09=09=09rsp_flex->dcid[rsp->count++] =3D 0;
+=09=09l2cap_chan_del(chan, rsp->pdu.rsp.result =3D=3D
+=09=09=09      cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION) ?
+=09=09=09      ECONNREFUSED : ECONNRESET);
+=09=09chan->ops->close(chan);
+=09}
=20
 done:
 =09if (locked)
@@ -5380,6 +5412,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
 *conn,
=20
 =09l2cap_chan_lock(chan);
=20
+=09if (chan->state !=3D BT_CONNECTED ||
+=09    (chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
+=09     chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
+=09=09goto unlock;
+
 =09max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 =09if (credits > max_credits) {
 =09=09BT_ERR("LE credits overflow");
@@ -5393,6 +5430,9 @@ static inline int l2cap_le_credits(struct l2cap_conn =
*conn,
=20
 =09chan->tx_credits +=3D credits;
=20
+=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09goto unlock;
+
 =09/* Resume sending */
 =09l2cap_le_flowctl_send(chan);
=20
@@ -7510,6 +7550,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_c=
onn *hcon)
=20
 =09skb_queue_head_init(&conn->pending_rx);
 =09INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+=09INIT_WORK(&conn->security_work, l2cap_security_work);
+=09atomic_set(&conn->security_failed, 0);
 =09INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr);
=20
 =09conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
@@ -7962,6 +8004,127 @@ static inline void l2cap_check_encryption(struct l2=
cap_chan *chan, u8 encrypt)
 =09}
 }
=20
+static void l2cap_queue_security(struct l2cap_conn *conn)
+{
+=09l2cap_conn_get(conn);
+=09/* Management process replies can fail SMP while the device queue drain=
s;
+=09 * this work cannot depend on admission to that draining queue.
+=09 */
+=09if (!queue_work(l2cap_security_wq, &conn->security_work))
+=09=09l2cap_conn_put(conn);
+}
+
+void l2cap_security_failed(struct l2cap_conn *conn)
+{
+=09unsigned int generation;
+
+=09if (conn->hcon->type !=3D LE_LINK)
+=09=09return;
+
+=09/* SMP producers serialize on the fixed channel lock. */
+=09lockdep_assert_held(&conn->smp->lock);
+
+=09/* Zero means no failure queued, including after generation wrap. */
+=09generation =3D atomic_inc_return(&conn->security_generation);
+=09if (!generation)
+=09=09generation =3D atomic_inc_return(&conn->security_generation);
+=09atomic_set(&conn->security_failed, generation);
+=09l2cap_queue_security(conn);
+}
+
+static void l2cap_security_work(struct work_struct *work)
+{
+=09struct l2cap_conn *conn =3D container_of(work, struct l2cap_conn,
+=09=09=09=09=09    security_work);
+=09struct hci_conn *hcon =3D conn->hcon;
+=09struct l2cap_chan *chan, *next;
+=09unsigned int generation;
+
+=09hci_dev_lock(hcon->hdev);
+=09/* HCI_UP is advisory; device close flushes connections after clearing =
it.
+=09 * TX admission during drain is guarded separately by hci_sched_tx().
+=09 */
+=09if (hcon->l2cap_data !=3D conn || !test_bit(HCI_UP, &hcon->hdev->flags)=
)
+=09=09goto done;
+
+=09mutex_lock(&conn->lock);
+
+=09generation =3D atomic_xchg(&conn->security_failed, 0);
+=09if (generation) {
+=09=09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09=09l2cap_chan_lock(chan);
+=09=09=09if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags) &&
+=09=09=09    (s32)(generation - chan->security_generation) > 0) {
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09=09set_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09=09}
+=09=09=09l2cap_chan_unlock(chan);
+=09=09}
+=09}
+
+=09for (;;) {
+=09=09chan =3D NULL;
+=09=09list_for_each_entry(next, &conn->chan_l, list) {
+=09=09=09if (test_and_clear_bit(FLAG_SECURITY_CFM, &next->flags)) {
+=09=09=09=09chan =3D next;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09=09if (!chan)
+=09=09=09break;
+
+=09=09/* Batch rejection may delete siblings, so restart the walk. */
+=09=09l2cap_chan_hold(chan);
+=09=09l2cap_chan_lock(chan);
+=09=09lockdep_assert_held(&chan->conn->lock);
+=09=09if (!test_bit(FLAG_PENDING_SECURITY, &chan->flags) ||
+=09=09    (chan->state !=3D BT_CONNECTED && chan->state !=3D BT_CONFIG &&
+=09=09     chan->state !=3D BT_CONNECT2))
+=09=09=09goto next;
+
+=09=09if (test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
+=09=09    !test_bit(HCI_CONN_ENCRYPT, hcon->flags) ||
+=09=09    !smp_sufficient_security(hcon, chan->sec_level, SMP_ALLOW_STK) |=
|
+=09=09    !l2cap_check_enc_key_size(hcon, chan)) {
+=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09__l2cap_chan_close(chan, ECONNREFUSED);
+=09=09=09chan->ops->close(chan);
+=09=09=09goto next;
+=09=09}
+
+=09=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09chan->sec_level =3D hcon->sec_level;
+
+=09=09if (chan->state =3D=3D BT_CONNECT2) {
+=09=09=09chan->ops->resume(chan);
+=09=09=09goto next;
+=09=09}
+
+=09=09if (chan->state =3D=3D BT_CONNECTED &&
+=09=09    chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL &&
+=09=09    test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+=09=09=09__l2cap_ecred_conn_rsp_defer(chan);
+=09=09=09if (test_bit(FLAG_DEL, &chan->flags))
+=09=09=09=09goto next;
+=09=09}
+
+=09=09l2cap_le_flowctl_send(chan);
+=09=09if (chan->tx_credits)
+=09=09=09chan->ops->resume(chan);
+=09=09l2cap_check_encryption(chan, 1);
+next:
+=09=09l2cap_chan_unlock(chan);
+=09=09l2cap_chan_put(chan);
+=09}
+
+=09mutex_unlock(&conn->lock);
+done:
+=09hci_dev_unlock(hcon->hdev);
+=09l2cap_conn_put(conn);
+}
+
 static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encryp=
t)
 =09__must_hold(&hcon->hdev->lock)
 {
@@ -7976,6 +8139,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl, pending_le;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -7983,7 +8148,13 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 =09=09       state_to_string(chan->state));
=20
-=09=09if (!status && encrypt)
+=09=09le_flowctl =3D hcon->type =3D=3D LE_LINK &&
+=09=09=09     (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09      chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL);
+=09=09pending_le =3D le_flowctl &&
+=09=09=09     test_bit(FLAG_PENDING_SECURITY, &chan->flags);
+
+=09=09if (!status && encrypt && !pending_le)
 =09=09=09chan->sec_level =3D hcon->sec_level;
=20
 =09=09if (!__l2cap_no_conn_pending(chan)) {
@@ -7991,9 +8162,48 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09=09continue;
 =09=09}
=20
+=09=09/* HCI reports the current link state. Encryption failure can
+=09=09 * disconnect that link, regardless of the SMP request generation.
+=09=09 */
+=09=09if (pending_le && (chan->state =3D=3D BT_CONNECTED ||
+=09=09=09=09   chan->state =3D=3D BT_CONFIG ||
+=09=09=09=09   chan->state =3D=3D BT_CONNECT2)) {
+=09=09=09if (status || !encrypt ||
+=09=09=09    !smp_sufficient_security(hcon, chan->sec_level,
+=09=09=09=09=09=09    SMP_ALLOW_STK) ||
+=09=09=09    !l2cap_check_enc_key_size(hcon, chan)) {
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09}
+=09=09=09set_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09=09l2cap_queue_security(conn);
+=09=09=09l2cap_chan_unlock(chan);
+=09=09=09continue;
+=09=09}
+
 =09=09if (!status && (chan->state =3D=3D BT_CONNECTED ||
 =09=09=09=09chan->state =3D=3D BT_CONFIG)) {
-=09=09=09chan->ops->resume(chan);
+=09=09=09if (!le_flowctl || chan->tx_credits)
+=09=09=09=09chan->ops->resume(chan);
+=09=09=09/* A deferred multi-channel ECRED connection may have
+=09=09=09 * released one accepted channel into BT_CONNECTED while
+=09=09=09 * its batch still shares an ident with pending siblings.
+=09=09=09 * Its security-failure close rejects that whole batch and
+=09=09=09 * unlinks those channels from conn->chan_l; do not run it
+=09=09=09 * directly while this traversal holds chan and the list.
+=09=09=09 */
+=09=09=09if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && chan->ident &&
+=09=09=09    test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
+=09=09=09    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) &&
+=09=09=09    (chan->sec_level =3D=3D BT_SECURITY_HIGH ||
+=09=09=09     chan->sec_level =3D=3D BT_SECURITY_FIPS) &&
+=09=09=09    !encrypt) {
+=09=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09=09=09set_bit(FLAG_SECURITY_FAILED, &chan->flags);
+=09=09=09=09set_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09=09=09=09l2cap_queue_security(conn);
+=09=09=09=09l2cap_chan_unlock(chan);
+=09=09=09=09continue;
+=09=09=09}
 =09=09=09l2cap_check_encryption(chan, encrypt);
 =09=09=09l2cap_chan_unlock(chan);
 =09=09=09continue;
@@ -8321,9 +8531,15 @@ int __init l2cap_init(void)
 {
 =09int err;
=20
+=09l2cap_security_wq =3D alloc_workqueue("l2cap_sec", WQ_UNBOUND, 0);
+=09if (!l2cap_security_wq)
+=09=09return -ENOMEM;
+
 =09err =3D l2cap_init_sockets();
-=09if (err < 0)
+=09if (err < 0) {
+=09=09destroy_workqueue(l2cap_security_wq);
 =09=09return err;
+=09}
=20
 =09hci_register_cb(&l2cap_cb);
=20
@@ -8340,6 +8556,7 @@ void l2cap_exit(void)
 {
 =09debugfs_remove(l2cap_debugfs);
 =09hci_unregister_cb(&l2cap_cb);
+=09destroy_workqueue(l2cap_security_wq);
 =09l2cap_cleanup_sockets();
 }
=20
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7..89da73dd3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -927,12 +927,71 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8=
 mode)
 =09return 0;
 }
=20
+static int l2cap_sock_set_security(struct sock *sk, struct l2cap_chan *cha=
n,
+=09=09=09=09   sockptr_t optval, unsigned int optlen)
+=09__must_hold(&chan->lock)
+{
+=09struct l2cap_conn *conn;
+=09struct bt_security sec =3D { .level =3D BT_SECURITY_LOW };
+=09int err;
+
+=09if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED &&
+=09    chan->chan_type !=3D L2CAP_CHAN_FIXED &&
+=09    chan->chan_type !=3D L2CAP_CHAN_RAW)
+=09=09return -EINVAL;
+
+=09err =3D copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
+=09if (err)
+=09=09return err;
+
+=09if (sec.level < BT_SECURITY_LOW || sec.level > BT_SECURITY_FIPS)
+=09=09return -EINVAL;
+
+=09conn =3D l2cap_chan_conn(chan);
+=09if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09return -EBUSY;
+
+=09chan->sec_level =3D sec.level;
+=09if (!conn)
+=09=09return 0;
+
+=09lockdep_assert_held(&conn->lock);
+=09lockdep_assert_held(&conn->hcon->hdev->lock);
+=09chan->security_generation =3D atomic_read(&conn->security_generation);
+
+=09if (chan->scid =3D=3D L2CAP_CID_ATT) {
+=09=09if (smp_conn_security(conn->hcon, sec.level))
+=09=09=09return -EINVAL;
+
+=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09sk->sk_state =3D BT_CONFIG;
+=09=09chan->state =3D BT_CONFIG;
+=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
+=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
+=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
+=09=09if (!l2cap_chan_check_security(chan, true)) {
+=09=09=09if (conn->hcon->type =3D=3D LE_LINK &&
+=09=09=09    (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL))
+=09=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+=09=09} else {
+=09=09=09sk->sk_state_change(sk);
+=09=09}
+=09} else {
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
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
@@ -948,60 +1007,41 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname,
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
-
-=09=09sec.level =3D BT_SECURITY_LOW;
-
-=09=09err =3D copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
-=09=09if (err)
-=09=09=09break;
-
-=09=09if (sec.level < BT_SECURITY_LOW ||
-=09=09    sec.level > BT_SECURITY_FIPS) {
-=09=09=09err =3D -EINVAL;
-=09=09=09break;
-=09=09}
-
-=09=09chan->sec_level =3D sec.level;
+=09if (optname =3D=3D BT_SECURITY) {
+=09=09bool have_conn;
=20
+=09=09l2cap_chan_lock(chan);
 =09=09conn =3D l2cap_chan_conn(chan);
-=09=09if (!conn)
-=09=09=09break;
+=09=09if (!conn) {
+=09=09=09lock_sock(sk);
+=09=09=09err =3D l2cap_sock_set_security(sk, chan, optval, optlen);
+=09=09=09release_sock(sk);
+=09=09=09l2cap_chan_unlock(chan);
+=09=09=09return err;
+=09=09}
+=09=09l2cap_conn_get(conn);
+=09=09l2cap_chan_unlock(chan);
=20
-=09=09/* change security for LE channels */
-=09=09if (chan->scid =3D=3D L2CAP_CID_ATT) {
-=09=09=09if (smp_conn_security(conn->hcon, sec.level)) {
-=09=09=09=09err =3D -EINVAL;
-=09=09=09=09break;
-=09=09=09}
+=09=09/* Match SMP failure's hdev -> conn -> chan lock order. */
+=09=09hci_dev_lock(conn->hcon->hdev);
+=09=09have_conn =3D l2cap_chan_lock_conn(chan);
=20
-=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
-=09=09=09sk->sk_state =3D BT_CONFIG;
-=09=09=09chan->state =3D BT_CONFIG;
+=09=09lock_sock(sk);
+=09=09if (l2cap_chan_conn(chan) !=3D conn)
+=09=09=09err =3D -ENOTCONN;
+=09=09else
+=09=09=09err =3D l2cap_sock_set_security(sk, chan, optval, optlen);
+=09=09release_sock(sk);
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
=20
+=09switch (optname) {
 =09case BT_DEFER_SETUP:
 =09=09if (sk->sk_state !=3D BT_BOUND && sk->sk_state !=3D BT_LISTEN) {
 =09=09=09err =3D -EINVAL;
@@ -1263,11 +1303,23 @@ static int l2cap_sock_defer(struct sock *sk)
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
 =09=09=09release_sock(sk);
 =09=09=09__l2cap_ecred_conn_rsp_defer(chan);
+=09=09=09lock_sock(sk);
+=09=09=09if (sk->sk_state =3D=3D BT_CLOSED) {
+=09=09=09=09err =3D sock_error(sk);
+=09=09=09=09if (!err)
+=09=09=09=09=09err =3D -ECONNRESET;
+=09=09=09}
+=09=09=09release_sock(sk);
 =09=09} else if (bdaddr_type_is_le(chan->src_type)) {
 =09=09=09sk->sk_state =3D BT_CONNECTED;
 =09=09=09chan->state =3D BT_CONNECTED;
@@ -1371,7 +1423,7 @@ static void l2cap_sock_kill(struct sock *sk)
 =09/* Take lock to synchronize against access without owning sk->sk_socket=
,
 =09 * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need lock.
 =09 */
-=09lock_sock(sk);
+=09lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
 =09l2cap_sock_put_chan(sk);
 =09release_sock(sk);
=20
@@ -1736,6 +1788,7 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan =
*chan, int err)
 =09lock_sock_nested(sk, atomic_read(&chan->nesting));
=20
 =09parent =3D bt_sk(sk)->parent;
+=09clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
=20
 =09switch (chan->state) {
 =09case BT_OPEN:
@@ -1752,7 +1805,9 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan =
*chan, int err)
 =09=09sk->sk_state =3D BT_CLOSED;
 =09=09chan->state =3D BT_CLOSED;
=20
-=09=09sk->sk_err =3D err;
+=09=09if (!test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
+=09=09    READ_ONCE(sk->sk_err) !=3D ECONNREFUSED)
+=09=09=09WRITE_ONCE(sk->sk_err, err);
=20
 =09=09if (parent) {
 =09=09=09/*
@@ -1788,8 +1843,11 @@ static void l2cap_sock_state_change_cb(struct l2cap_=
chan *chan, int state,
=20
 =09sk->sk_state =3D state;
=20
-=09if (err)
-=09=09sk->sk_err =3D err;
+=09if (err) {
+=09=09WRITE_ONCE(sk->sk_err, err);
+=09=09clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
+=09=09sk->sk_state_change(sk);
+=09}
=20
 =09release_sock(sk);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7015e37e..b4b761788 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -785,6 +785,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 rea=
son)
 =09=09=09     &reason);
=20
 =09mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
+=09l2cap_security_failed(conn);
=20
 =09if (chan->data)
 =09=09smp_chan_destroy(conn);
--=20
2.56.0


