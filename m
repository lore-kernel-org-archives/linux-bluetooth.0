Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931458;
	b=s7P1kOJ7Egw5E7x/hX1Db6veBj82o5zgZJgvDEZYINuPQ4Fwv1O0UrfVR4eflyxZiPfT
	 s6oUYmdgOz3mg6FE6BLzBqcnm0ffLyNPnva5HN3Dud0zMVib78Q0GAbGsiPji7wKU/V/y
	 FJ3MPD5joKWfTcet45V6r2/c2c5IRF6mAl/oF+cTFkAOIf6CJ8HFRQIlv7LIiVWa4mNvw
	 /nzkodso1vVaGWzBWHsEDHC6P4p+eYq3EBhKkXG3KGT8ygY5XDccpbInge7Elzf5kMHy2
	 ynzCSkny9TeEO5Nq7uDR1K6ESk9tTuktf9hePteIYIjkrAs+fr0uqR6My2VK25JeTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931458;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fnuxqyrG6REhIII7Ib8S+VJizUwMGc2b7hlQV0mN0WI=;
	b=066iNKUF9dhMkDAD6uiHAP0C7iDn0amsNpjFPCIZSNUPcjuOnj9PQgf6AK0ta9cQxq5a
	 n8UbqEzkZnw1apov54QN18OxkvUJNlPSALNKxxdrzzlHbyvRdHZmjOj6zcME7Rs0oNPe8
	 UyZFSFiIgfXGkj/dVmPhxi9683S81ioVgPuYoKSX97u6Mvlb8kSQlj7WPVKBllqCUHrxH
	 gz6QdCf56ApiYiSuOWMzewuW7KpJDR4w5m6+RDNM1X8EQlBp15Efqf54MQHz9RDc+ux4/
	 YK+hxZ3B8xv2e4X36MGaXCEiAB0iLAKjAjUpxCeb4yKQmcwUGjcmHWuLRAZD4myKIHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZLX14Gio;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B3606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 02:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E20B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZLX14Gio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793931453; x=1794190653;
	bh=fnuxqyrG6REhIII7Ib8S+VJizUwMGc2b7hlQV0mN0WI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZLX14GiojuHGctHf/UFt3QCMZMiFSoBLjGG/TOhuWyw3HC+9n09L4vb8qotZlRf/L
	 ZKjckeknu1WUKhPtfpQ2joeuLVG+FicURHIQHLVZOER4tfRMDdNdqoihdNE5Dnj5oj
	 N/EcCkY7FE7nDhlpisr4tfipleHJyZbPbUsXCmidVbwTkm2sI41Yd3pwnsihLYeX12
	 AAUuwKDf5Rzpm/cgSjnLCn1LvnfwQy9W87zyOIt6R20qZ11B60Ez6jgfNRfsvQ3zXC
	 ynsNGQtx0kK6E/a1S5l8o6mLeh+WdHW01bzC9fQQ82KGVYccIsRDA2mgv7ncXIvZsX
	 Eo0hDWtqZC8zg==
Date: Fri, 06 Nov 2026 02:17:30 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v4 1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261106021723.631339-1-cochcoder@proton.me>
In-Reply-To: <20261015181624.48318-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: a29f4e7611c1994cba9a395d763fc47ee7d1a9e6
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

Validate credit targets and retain credits without sending or resuming
while an LE or ECRED security upgrade is pending. Keep the requested
security level until encryption and key size satisfy it.

Schedule immediate channel timeout work if the upgrade fails. This runs
the normal close path outside the security callback list traversal and
keeps traffic suspended until teardown. Complete deferred security
without accepting the connection or sending queued data.

Drain connected channels after successful security completion. Resume
LE credit-based sockets only when credits remain, including background
encryption changes with no locally pending upgrade.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Assisted-by: LLM

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
v4: Fix failed/deferred security completion and credit-aware wakeups.
AI review: https://sashiko.dev/#/patchset/20261015181624.48318-1-cochcoder%=
40proton.me

 net/bluetooth/l2cap_core.c | 50 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c |  9 +++++--
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7dcb0586a..9463ac215 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5380,6 +5380,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -5393,6 +5398,9 @@ static inline int l2cap_le_credits(struct l2cap_conn =
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
@@ -7976,6 +7984,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool le_flowctl, pending_le;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -7983,7 +7993,13 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
@@ -7991,9 +8007,39 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
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
index 7a2551ef7..2cf91d0a0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -993,10 +993,15 @@ static int l2cap_sock_setsockopt(struct socket *sock,=
 int level, int optname,
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

base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881

