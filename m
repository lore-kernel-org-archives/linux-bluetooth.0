Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9013CB2EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041646; cv=none; b=ku6TyVPbdG/o0beUCgelujw2M9/PaTRY7ZJNnhgSz9YimPF3qj7WNyo5T9KNOOrN+gHkAE7s1JFoFaVJ54pXDRhJeA1eyRM7Ig0bQfrOQTC8oV657CLZXa6fvDaqR2xyRqzyaBJhRChJ+lX5Mumh9o57koZYZ+Q+pqQfg4SHySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041646; c=relaxed/simple;
	bh=o78/8ZgMwQ+c3Jml1c//wS7cCcxmyFPAi/4GoyOBxio=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R3uw/15ul0OMM1hsKI7YhSWXvsHN62XYD6hC3k4A1xgVy5Ew8QDY/QGI4JIKgVJrJNbWHeScJyxtfxsavNPus3KYMFT31RKuMHmWlLUBz10L0UoUgG/ZrDoFkZVEx+3+1NxbA2DR1glTVFfhpXPM5OUPWDGKefZeU2Xea9rTj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=At8cY24u; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="At8cY24u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792041638; x=1792300838;
	bh=PcmXnfmK8y2euY70mI2xAIXpNV9stQYYQjVINHKgyuI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=At8cY24ue5JIo+LLyvoGQGnI2dI5VTpjcYRvUNMGW4AA8xO+j3anqetii/Ni/Ot0o
	 C2g+9ZQrjOOctkKL+kE6PWaFlJZ7uAiX2Y5QsC52KbKzV36DuqReDu55MWihqJtrSq
	 8T3TOD5QmNQ+HVxvVj0bkW+khyge02hN3anbiynsJj++Uz+9UQZXJL2JQzFlz0XP7b
	 RCjPL5oUwO6iBX1d3W2rs3zYsex8/PHE5ToPHQWqcUUAtcFeNYXGyPkKur0NNNPYsH
	 SpYG1ty3ek69Mq305CC5qyR1Cq4vkdNOyVQHjv+3UnQuzLem0OJK6mrDYNr483puaU
	 9bkHzKX+HFYuw==
Date: Thu, 15 Oct 2026 05:20:33 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <20261015052018.129971-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: d3fd2344d0b46055654193950ccb3c168efe5603
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Credit indications can invoke resume on fixed or unready channels.
Connected LE credit-based sockets can also resume during a security
upgrade because credits and security share the socket suspend flag.

Validate the target mode and state for every identifier. Track pending
LE/ECRED security upgrades and retain credits without sending queued
data or resuming the socket until encryption meets the requested level.
Drain queued data after security completes and keep credit-starved
sockets suspended.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
New standalone security/target-state fix, not a resend of the zero-identifi=
er
interoperability RFC. The zero-ID revision will be submitted separately and
depends on this fix; this patch does not accept identifier zero.

Refreshed without functional changes from the reviewed candidate onto curre=
nt
bluetooth-next 397464709a20. The referenced Fixes commit's full ID and subj=
ect
were verified from its Git object:
fad5fc89594de31388572a26f33caa7c30a23782

On this refreshed base, both security-only and security+compatibility guest
kernels build with KASAN/lockdep and pass all nine focused security control=
s.
The 14 public credit controls pass 13/14 with this patch alone: the sole fa=
ilure
is the intentionally unsupported positive zero-ID case. With the separate
compatibility patch they pass 14/14. No skips or captured KASAN/lockdep ale=
rts
occurred in these focused runs. GCC W=3D1 changed objects and source-extrac=
ted
target/security and zero-ID fixtures pass.

The refreshed full-suite attempt is NOT a pass: SCI Fast Mode times out aft=
er
an invalid HCI Read Connection Interval response length for opcode 0x20a3, =
and
the runner reaches its outer timeout without a complete summary. The same S=
CI
failure reproduces on the unpatched current-base guest. It is not diagnosed=
 as
a credit regression or claimed fixed here. An initial filter containing spa=
ces
was split by the VM runner; corrected space-free filtered runs are reported=
 above.

Earlier reference-base results were security-only 133/134 (the expected zer=
o-ID
failure) and combined 134/134; those are historical, not fresh full-suite r=
esults.
The combined Arch integration was built and is reported working on hardware=
,
but that is not isolated attribution, over-the-air exploit evidence, comple=
te
security/lifetime coverage or a remote-CI pass. No severity/CVE claim is ma=
de.
The private reproducer and detailed private regression logs are not include=
d.

 net/bluetooth/l2cap_core.c | 33 +++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c |  9 +++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4dd56e007..7a7f30531 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5391,6 +5391,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -5404,6 +5409,9 @@ static inline int l2cap_le_credits(struct l2cap_conn =
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
@@ -7967,6 +7975,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon,=
 u8 status, u8 encrypt)
 =09mutex_lock(&conn->lock);
=20
 =09list_for_each_entry(chan, &conn->chan_l, list) {
+=09=09bool pending_le;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09lockdep_assert_held(&chan->conn->lock);
@@ -7974,7 +7984,12 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
 =09=09BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 =09=09       state_to_string(chan->state));
=20
-=09=09if (!status && encrypt)
+=09=09pending_le =3D hcon->type =3D=3D LE_LINK &&
+=09=09=09     (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
+=09=09=09      chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
+=09=09=09     test_bit(FLAG_PENDING_SECURITY, &chan->flags);
+
+=09=09if (!status && encrypt && !pending_le)
 =09=09=09chan->sec_level =3D hcon->sec_level;
=20
 =09=09if (!__l2cap_no_conn_pending(chan)) {
@@ -7984,7 +7999,21 @@ static void l2cap_security_cfm(struct hci_conn *hcon=
, u8 status, u8 encrypt)
=20
 =09=09if (!status && (chan->state =3D=3D BT_CONNECTED ||
 =09=09=09=09chan->state =3D=3D BT_CONFIG)) {
-=09=09=09chan->ops->resume(chan);
+=09=09=09if (pending_le) {
+=09=09=09=09if (!encrypt ||
+=09=09=09=09    !smp_sufficient_security(hcon, chan->sec_level,
+=09=09=09=09=09=09=09    SMP_ALLOW_STK)) {
+=09=09=09=09=09l2cap_chan_unlock(chan);
+=09=09=09=09=09continue;
+=09=09=09=09}
+
+=09=09=09=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
+=09=09=09=09chan->sec_level =3D hcon->sec_level;
+=09=09=09=09l2cap_le_flowctl_send(chan);
+=09=09=09}
+
+=09=09=09if (!pending_le || chan->tx_credits)
+=09=09=09=09chan->ops->resume(chan);
 =09=09=09l2cap_check_encryption(chan, encrypt);
 =09=09=09l2cap_chan_unlock(chan);
 =09=09=09continue;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c396987c5..2d7f2935c 100644
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

base-commit: 397464709a204da9b8dc3b01d6ea42539d951cd2

