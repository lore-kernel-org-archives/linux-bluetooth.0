Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986812;
	b=svs36TbE31XjjeSNwzEQCmUq7E6s4IG3BwCsq+GxzxVo2qZs6eOlvfQVR3nHvDPgyLq7
	 kinYtkkyFYzVtPCgZ1sYiqnXModvtKlN/Ko/voSu734dAZAMl3EDfGe3lP7893gRpalg4
	 V4bskbCwYOS3s3RgLxuCVZUmdEk+5pyU1XdCoNVXTXLSgUDZ7JumpKI4afw/f5ZeL2ixE
	 VO8uiPbI9b4J/l+ew1oOkuP0f0a//x77Pa9E6gwwC9XRznT3JBLzNE21g9qf3mxo5dgDg
	 QxBdz4SPZl2y+9N3eKb7fj57Q1PRaZiheZ6x8Caw5Uk72YHke22DW+SVKVZ30WHkskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986812;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TWz4e2aqI/cWTblGfDAMMIQqvQe0hDyJk5TXBe76kmM=;
	b=23YY4w+5lHx9jC4AM9/x7H8Hs1sp6YOh2XwmUb/uwXFHQ2tk515UxjQIt1ePvn1w+3kC
	 BSmrKMYr0PLHAWtcuksm3wXFrxoBjUkeEDoqfZ3Hmdm+N90y7SKbpdJFEvc21bR76EU7a
	 oQRsCZj8fOdfzvXWPshdbm7j4Sgk6QZRLW6nxnExkLIQK2nywdOafklnOk1KZqSc/277C
	 +z3SxtX59T6emkFxG1lnC95rQWg0HOEQzkf+pRgPekC0lGacPadXUpz2TsNJfamowgOnT
	 92ylviC3Z+RyMvmQvxhVy55u9mhvqG9p0bF5+R7rC81GnB3fZwr3TNmLiCT/8Ou737g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=F8Tmnkny;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E9606A32E
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335E9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=F8Tmnkny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793986808; x=1794246008;
	bh=TWz4e2aqI/cWTblGfDAMMIQqvQe0hDyJk5TXBe76kmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F8TmnknyPAQp1i1izfvE6eXLYK2Pu6TlksyL3N0pp1h1g7doLhCA5Z3pZALcS41Ge
	 7CFoeOKXtJ01CWAA/zTWUaS1+xVDXwW5aPju4cLPVZaaOQKh68sS8awCYSk8GB4hda
	 sjeN1wfwbNSCCME1/yzcsm1wPgHdC4g2LqvkIEW2ZUYMz2F0N+RnTSWqqA6L7Dp9Bp
	 k1ePrlp46ISRQlikiCho3szubA58mfw/HjLm6uZGlKwomb8k5ErTwlpjh4yPcCcis1
	 lWXAfTAOcbrjXXltFPOImnN3R4ECjSrT40/uxE5pqHbysT+mvqF/z3xIgOBh/NaSVI
	 X1aCh+/3HQ6FA==
Date: Fri, 06 Nov 2026 17:40:05 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v6 1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261106173948.596166-1-cochcoder@proton.me>
In-Reply-To: <20261106045515.853897-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 71991211ea049ddaeb640f506a4765a537293a51
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
send path and deferred acceptance, and preserve the requested level
until completion or teardown.

Finish pending upgrades from connection work so failed channels and
ECRED batches can be removed outside the security callback's list walk.
Keep a failed upgrade terminal if another confirmation arrives before
the work runs. Report local SMP failure through the same work without
calling security callbacks while the SMP channel is locked.

Wake deferred sockets after successful security even with no initial
credits. Check every sibling's security before an ECRED batch response,
let refusal override pending acceptance, and retry the response after
security completes. Serialize BT_SECURITY with the batch response.

Wake failed senders, preserve disconnect errors through teardown, and
clear security and suspension state when removing the channel.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v6:
- Finish pending upgrades from referenced connection work.
- Keep failure terminal across later security confirmations.
- Report local SMP failure without taking channel-list locks from SMP.
- Wake deferred sockets even with zero initial credits.
- Wake failed senders and preserve errors through disconnect teardown.
- Clear pending-security and suspension state during teardown.
- Serialize BT_SECURITY with ECRED batch readiness and response handling.
- Let ECRED refusal override pending acceptance and retry after security.

AI review of v5:
https://sashiko.dev/#/patchset/20261106045515.853897-1-cochcoder%40proton.m=
e

GCC/Clang ASan/UBSan fixtures cover the seven reported paths and successful
upgrades, with v5 baseline and isolated mutation controls. GCC/Clang and
ECRED-disabled W=3D1 objects and a KASAN/lockdep kernel image pass locally.
Native L2CAP/concurrency and hardware behavior remain unverified.

The userspace timeout sanitizer failure and the checker's handling of
required AI attribution remain separate CI infrastructure issues. A remote
CI pass is not claimed.

AI assistance: Codex prepared this revision, descriptions and local tests.
Attribution is retained.

 include/net/bluetooth/l2cap.h |   5 ++
 net/bluetooth/l2cap_core.c    | 161 +++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c    | 134 +++++++++++++++++-----------
 net/bluetooth/smp.c           |   1 +
 4 files changed, 244 insertions(+), 57 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2a05bda8a..f09c2696f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -636,6 +636,8 @@ struct l2cap_conn {
=20
 =09struct sk_buff_head=09pending_rx;
 =09struct work_struct=09pending_rx_work;
+=09struct work_struct=09security_work;
+=09atomic_t=09=09security_failed;
=20
 =09struct delayed_work=09id_addr_timer;
=20
@@ -758,6 +760,8 @@ enum {
 =09FLAG_ECRED_CONN_REQ_SENT,
 =09FLAG_ECRED_RECONF_REQ_SENT,
 =09FLAG_PENDING_SECURITY,
+=09FLAG_SECURITY_CFM,
+=09FLAG_SECURITY_FAILED,
 =09FLAG_HOLD_HCI_CONN,
 =09FLAG_DEL,
 };
@@ -983,6 +987,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msg=
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
index 7dcb0586a..24360d8e1 100644
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
@@ -704,6 +705,9 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 =09lockdep_assert(!chan->conn || lockdep_is_held(&chan->conn->lock));
=20
 =09__clear_chan_timer(chan);
+=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09clear_bit(FLAG_SECURITY_CFM, &chan->flags);
+=09clear_bit(FLAG_SECURITY_FAILED, &chan->flags);
=20
 =09BT_DBG("chan %p, err %d, state %s", chan, err,
 =09       state_to_string(chan->state));
@@ -2647,6 +2651,9 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *=
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
@@ -3979,8 +3986,13 @@ static void l2cap_ecred_list_defer(struct l2cap_chan=
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
@@ -3988,6 +4000,8 @@ static void l2cap_ecred_list_defer(struct l2cap_chan =
*chan, void *data)
 =09=09(*result)++;
 =09=09return;
 =09case BT_CONNECTED:
+=09=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
+=09=09=09(*result)++;
 =09=09return;
 =09default:
 =09=09/* If not connected or pending accept it has been refused */
@@ -4079,7 +4093,9 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *=
chan, void *data)
 =09if (!rsp->pdu.rsp.result)
 =09=09rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
 =09else
-=09=09l2cap_chan_del(chan, ECONNRESET);
+=09=09l2cap_chan_del(chan, rsp->pdu.rsp.result =3D=3D
+=09=09=09      cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION) ?
+=09=09=09      ECONNREFUSED : ECONNRESET);
=20
 done:
 =09if (locked)
@@ -5380,6 +5396,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -5393,6 +5414,9 @@ static inline int l2cap_le_credits(struct l2cap_conn =
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
@@ -7510,6 +7534,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_c=
onn *hcon)
=20
 =09skb_queue_head_init(&conn->pending_rx);
 =09INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+=09INIT_WORK(&conn->security_work, l2cap_security_work);
+=09atomic_set(&conn->security_failed, 0);
 =09INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr);
=20
 =09conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
@@ -7962,6 +7988,109 @@ static inline void l2cap_check_encryption(struct l2=
cap_chan *chan, u8 encrypt)
 =09}
 }
=20
+static void l2cap_queue_security(struct l2cap_conn *conn)
+{
+=09l2cap_conn_get(conn);
+=09if (!queue_work(conn->hcon->hdev->workqueue, &conn->security_work))
+=09=09l2cap_conn_put(conn);
+}
+
+void l2cap_security_failed(struct l2cap_conn *conn)
+{
+=09if (conn->hcon->type !=3D LE_LINK)
+=09=09return;
+
+=09atomic_set(&conn->security_failed, 1);
+=09l2cap_queue_security(conn);
+}
+
+static void l2cap_security_work(struct work_struct *work)
+{
+=09struct l2cap_conn *conn =3D container_of(work, struct l2cap_conn,
+=09=09=09=09=09    security_work);
+=09struct hci_conn *hcon =3D conn->hcon;
+=09struct l2cap_chan *chan, *next;
+
+=09hci_dev_lock(hcon->hdev);
+=09if (hcon->l2cap_data !=3D conn)
+=09=09goto done;
+
+=09mutex_lock(&conn->lock);
+
+=09if (atomic_xchg(&conn->security_failed, 0)) {
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
@@ -7976,6 +8105,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl, pending_le;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -7983,7 +8114,13 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
@@ -7991,9 +8128,25 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09=09continue;
 =09=09}
=20
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
 =09=09=09l2cap_check_encryption(chan, encrypt);
 =09=09=09l2cap_chan_unlock(chan);
 =09=09=09continue;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7..3f4ab80b3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -927,12 +927,70 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8=
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
+=09    (test_bit(FLAG_PENDING_SECURITY, &chan->flags) ||
+=09     (conn && atomic_read(&conn->security_failed))))
+=09=09return -EBUSY;
+
+=09chan->sec_level =3D sec.level;
+=09if (!conn)
+=09=09return 0;
+
+=09lockdep_assert_held(&conn->lock);
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
@@ -948,60 +1006,20 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname,
 =09if (level !=3D SOL_BLUETOOTH)
 =09=09return -ENOPROTOOPT;
=20
+=09if (optname =3D=3D BT_SECURITY) {
+=09=09bool have_conn =3D l2cap_chan_lock_conn(chan);
+
+=09=09lock_sock(sk);
+=09=09err =3D l2cap_sock_set_security(sk, chan, optval, optlen);
+=09=09release_sock(sk);
+=09=09l2cap_chan_unlock_conn(chan, have_conn);
+=09=09return err;
+=09}
+
 =09l2cap_chan_lock(chan);
 =09lock_sock(sk);
=20
 =09switch (optname) {
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
-
-=09=09conn =3D l2cap_chan_conn(chan);
-=09=09if (!conn)
-=09=09=09break;
-
-=09=09/* change security for LE channels */
-=09=09if (chan->scid =3D=3D L2CAP_CID_ATT) {
-=09=09=09if (smp_conn_security(conn->hcon, sec.level)) {
-=09=09=09=09err =3D -EINVAL;
-=09=09=09=09break;
-=09=09=09}
-
-=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
-=09=09=09sk->sk_state =3D BT_CONFIG;
-=09=09=09chan->state =3D BT_CONFIG;
-
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
-
 =09case BT_DEFER_SETUP:
 =09=09if (sk->sk_state !=3D BT_BOUND && sk->sk_state !=3D BT_LISTEN) {
 =09=09=09err =3D -EINVAL;
@@ -1263,6 +1281,11 @@ static int l2cap_sock_defer(struct sock *sk)
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
@@ -1736,6 +1759,7 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan =
*chan, int err)
 =09lock_sock_nested(sk, atomic_read(&chan->nesting));
=20
 =09parent =3D bt_sk(sk)->parent;
+=09clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
=20
 =09switch (chan->state) {
 =09case BT_OPEN:
@@ -1752,7 +1776,8 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan =
*chan, int err)
 =09=09sk->sk_state =3D BT_CLOSED;
 =09=09chan->state =3D BT_CLOSED;
=20
-=09=09sk->sk_err =3D err;
+=09=09if (err)
+=09=09=09sk->sk_err =3D err;
=20
 =09=09if (parent) {
 =09=09=09/*
@@ -1788,8 +1813,11 @@ static void l2cap_sock_state_change_cb(struct l2cap_=
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

base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881

