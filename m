Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940947;
	b=YqnRGzBjJJHPALGwBDJ7UOMSGe8A3hrxLY6ydORqnnGoQTumLZYypZqMWnE/a/H+XiXo
	 JHbLQArjhhc40B07D7f0gssFqoIAVorMovHZOUpqn7ehBgVV3ebNBFBHtOLZPrKkSmCJx
	 l9XgzZE/NirEgSdCfBLvBRbwjOqPPUUOq+eJt8iYnNEjekmvIe/8t84pdQbE1R1UA+QSn
	 etLarXnQROc0cuK+4MQwFlXZSHCXCa8niKY6Cwg3mZ4YOAf5J5B2T/RsmP3utoGUU7HfF
	 eNxk0k5PiFpDECOtTFPhHYenIEK3cpOnWC1bIpKQx7qY1itSrM+KG88h1FAX0W8hANA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940947;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Lk6N7fzjN+Pw1dvEq2zdf0hyl4yex5FCC8J0/mKI8gg=;
	b=ADGNZ58209r5qC5gFXspYNi/LjOW5LPjOjGeiHBGbyU1uLLCaAW4hOpvS84nooC44Vnn
	 VeWlub9cC/tyP3eeZkpl8cpbVCwwI33DCOqenGJ+0QB1QVQTekPEWhftyysjSPQ8qajjV
	 I+9RzAtND7TGRvJ3fmfQ51mQADKypDElp6dQfBpgixqqKRU/HlQu0fMPAK8I0xuh4Rb33
	 wc4KzvhCiJzDHwj0p6fW09LRTi0jqI0aAWs9L4TgLfYQZt6nmrBq8DqvnaqdaT21A6naU
	 17AV1JsOYM2ai1qMDYc5mtUe1pNNXNZfZHWjWcSN5jf/zSgVG+LMmEGPQnABI+Md+ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C36606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C36606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793940943; x=1794200143;
	bh=Lk6N7fzjN+Pw1dvEq2zdf0hyl4yex5FCC8J0/mKI8gg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jv/vQdc2aP9B4sJcmf3mNCGbm8T8WrUD4brEp4T/gizZ3ymIfEtmSNp9YaQplVrGy
	 nSizjnmABG8oHW0xQu+v0+E3aELn+T0Slgh22epj324eSSwn9sr7hkf8LwUbaAkrGQ
	 2sh09R0ET7bOUeIlgpZV7i/7tT2EFgTQ/Z5XM/7ujzxsUjji2+XZz9Pk/MoTM744ee
	 1w8/9YOniCT0uDi2N6BHhGy9bgjKdGok+3w1n9g9qL1qpg0cYNOEQCb3kZriW6FKR9
	 djIIdUW8JlxCr9O3CSqoCo/syFj0MlI2+JghXgnA0A0RbJuVUdo2Q/ScMEGSF6sOY7
	 kgdY5IKZ2InhQ==
Date: Fri, 06 Nov 2026 04:55:40 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v5 1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261106045515.853897-1-cochcoder@proton.me>
In-Reply-To: <20261106021723.631339-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 91295b5380bc4ecb375bb653c3f5602412133a31
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

Retain LE and ECRED credits without sending or resuming sockets while a
security upgrade is pending. Check the shared send path so a send that
crossed socket readiness or allocation lock gaps cannot drain queued
data at the old security level.

Reject deferred acceptance with EAGAIN while security is pending. Keep
the requested level unchanged and return EBUSY for another BT_SECURITY
request until completion or teardown, including the interval before
failed-upgrade timeout work closes the channel.

Validate encryption and key size before completing security, preserve
deferred setup, and resume connected sockets only when credits remain.
Schedule failed-upgrade teardown outside the channel-list traversal.

Assisted-by: LLM

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v5:
- Guard the shared send path across socket and allocation lock gaps.
- Keep deferred acceptance blocked while security is pending.
- Reject another BT_SECURITY request until completion or teardown.

AI review:
https://sashiko.dev/#/patchset/20261106021723.631339-1-cochcoder%40proton.m=
e

GCC/Clang sanitizer fixtures, negative controls and W=3D1 object builds pas=
s.
The local full kernel image builds with KASAN and lockdep enabled.
Native L2CAP and hardware behavior remain unverified. PR1075's BlueZ timeou=
t
use-after-free and checkpatch attribution compatibility need separate CI fi=
xes.

AI assistance: Codex prepared source revisions, descriptions and local test=
s
in response to the v4 automated review. Attribution is retained.

 net/bluetooth/l2cap_core.c | 53 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c | 22 ++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dcb0586a..ae6659fab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2647,6 +2647,9 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *=
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
@@ -5380,6 +5383,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -5393,6 +5401,9 @@ static inline int l2cap_le_credits(struct l2cap_conn =
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
@@ -7976,6 +7987,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl, pending_le;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -7983,7 +7996,13 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
@@ -7991,9 +8010,39 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
+=09=09=09=09/* Keep traffic suspended until timeout work closes
+=09=09=09=09 * the channel outside this list traversal.
+=09=09=09=09 */
+=09=09=09=09__set_chan_timer(chan, 0);
+=09=09=09=09l2cap_chan_unlock(chan);
+=09=09=09=09continue;
+=09=09=09}
+
+=09=09=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09=09chan->sec_level =3D hcon->sec_level;
+
+=09=09=09/* Security completion must not accept deferred setup. */
+=09=09=09if (chan->state =3D=3D BT_CONNECT2) {
+=09=09=09=09if (chan->tx_credits)
+=09=09=09=09=09chan->ops->resume(chan);
+=09=09=09=09l2cap_chan_unlock(chan);
+=09=09=09=09continue;
+=09=09=09}
+
+=09=09=09l2cap_le_flowctl_send(chan);
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
index 7a2551ef7..cc00ef688 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -972,6 +972,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, =
int level, int optname,
 =09=09=09break;
 =09=09}
=20
+=09=09/* Preserve an outstanding LE credit-based security request. */
+=09=09if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09    test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+=09=09=09err =3D -EBUSY;
+=09=09=09break;
+=09=09}
+
 =09=09chan->sec_level =3D sec.level;
=20
 =09=09conn =3D l2cap_chan_conn(chan);
@@ -993,10 +1001,15 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname,
 =09=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
 =09=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
 =09=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
-=09=09=09if (!l2cap_chan_check_security(chan, true))
+=09=09=09if (!l2cap_chan_check_security(chan, true)) {
+=09=09=09=09if (conn->hcon->type =3D=3D LE_LINK &&
+=09=09=09=09    (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL))
+=09=09=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
 =09=09=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
-=09=09=09else
+=09=09=09} else {
 =09=09=09=09sk->sk_state_change(sk);
+=09=09=09}
 =09=09} else {
 =09=09=09err =3D -EINVAL;
 =09=09}
@@ -1263,6 +1276,11 @@ static int l2cap_sock_defer(struct sock *sk)
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

base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881

