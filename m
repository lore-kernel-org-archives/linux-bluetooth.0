Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AC595740
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088265; cv=none; b=LZLJzUa77CrZ10bA+MYwzmBMARuLnAkEMIe4rCPobUyCSs04k7ojRuIs7x32nMZeDV7D+/xKLXX/zcJHBvQyyguesRPkUUqEwgy4/0t4o5IqK/bpPd3dsTGz0wnJDGUOfDsuBqWIJrbsbjHCyb9VUnK9TmC/g7NjWze5E90Csdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088265; c=relaxed/simple;
	bh=fXUw9dwYfc0/piYKtd9zfLqtnmRaA1x/lw9N1gpMg04=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPLTOMdYOsO8GqtlbKJyKc6iHb/V3LABQtq4FuOnoQkVmkp2Cw2NhJxFziajtO5LX+q43AlARN8dcMgaLjPcMvwfAG/A9Z4ZqoJO3EOih5EZmQD/IEe93l0uIEViXjT7zh+DpYFMzt+JGr39W77LESLFWvvL6bbIEvS6AqJ1J/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YPr+Xm+k; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YPr+Xm+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792088249; x=1792347449;
	bh=VbxIQ53RyPD7D7Pdl+D8EUpM1ND26OgskfzKVFAylwg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YPr+Xm+kZC1zTglFLNDch9MfIKuw1BpkziTaK9nRyVV9hsTVAkNjmdj1RJSs7JHBo
	 GCD/2p5Whfv+TwG1DKLLlDPAR3X44mDWhTOe+zRVa93wEiUcO8I70j4e8LU2BS5c7J
	 UJpCQyST8Yp9Fq//G0TYL9GT71oCJkhtHivdU9yWv0kDyRX0Jmr3uEjktNOIPBHRGN
	 8C3NaK0hjN3G02wIizPPfcPHn3dRRd0jjX0GtxPc3q89m+NK9GmD6XfT0c9bc6qRaM
	 tV5tNhtiWxxmVC/2uIvCUYFysOuG1ZEh9c4rxtCnfTyjszMq9ksPxc/xV41Uyx8wzd
	 1rUi2wvVBEKOw==
Date: Thu, 15 Oct 2026 18:17:23 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@intel.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261015181624.48318-2-cochcoder@proton.me>
In-Reply-To: <20261015181624.48318-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 8c616f923c110b9c41770ec30c36f0d01a4c1450
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tolerate exact-size, nonzero credit grants with identifier zero only
for connected LE credit-based channels. Keep the target and pending
security checks shared with ordinary identifiers. Do not send a
response with identifier zero or relax other signaling commands.

This is an interoperability exception to Core Vol 3 Part A section 4,
not a conformance fix.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes since v2:
- Include the unchanged security prerequisite as patch 1/2 in this series,
  rather than relying on CI to apply a separately submitted dependency.
- Refresh onto bluetooth-next ff8b09806b7b without a source delta.
- Wrap test notes to keep all prose within GitLint's 80-column limit.

The saved v2 report failed application at l2cap_core.c:5396. That patch
depends on the security fix, which was not yet upstream. A dependency
link and prerequisite-patch-id did not make that CI run apply it first.
Apply this entire series in order; patch 2 alone is not a valid input.

The Core specification still forbids identifier zero. This remains an
interoperability RFC requiring maintainer policy agreement, not a
conformance fix. Patch 1 is independently useful without this exception.

Earlier 397464709a20 runs passed all nine focused security controls with
security-only and combined guests. Public credit controls passed 13/14
security-only (expected positive zero-ID failure), 14/14 combined, with
no skips or captured kernel alerts. Source-extracted fixtures and GCC
W=3D1 changed objects passed. These are prior runs, not fresh v3 VMs.

The earlier full-suite attempt was incomplete due to an SCI timeout also
seen on the unpatched base. No fresh full-suite or remote CI pass is
claimed for v3. The combined Arch trial is reported working on hardware,
not isolated attribution or exhaustive device/security/teardown coverage.
Private security reproducer/logs and the archived BlueZ test companion
are excluded. This series contains only the two kernel patches.

 net/bluetooth/l2cap_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7a7f30531..d805b1c62 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5396,6 +5396,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
 *conn,
 =09     chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
 =09=09goto unlock;
=20
+=09/* Tolerate identifier-zero credits only for a live LE CoC. */
+=09if (!cmd->ident && (!credits || chan->mode !=3D L2CAP_MODE_LE_FLOWCTL))
+=09=09goto unlock;
+
 =09max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 =09if (credits > max_credits) {
 =09=09BT_ERR("LE credits overflow");
@@ -5994,11 +5998,21 @@ static inline void l2cap_le_sig_channel(struct l2ca=
p_conn *conn,
=20
 =09BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len, cmd->ident);
=20
-=09if (len !=3D skb->len || !cmd->ident) {
+=09if (len !=3D skb->len) {
 =09=09BT_DBG("corrupted command");
 =09=09goto drop;
 =09}
=20
+=09if (!cmd->ident) {
+=09=09if (cmd->code !=3D L2CAP_LE_CREDITS ||
+=09=09    len !=3D sizeof(struct l2cap_le_credits))
+=09=09=09goto drop;
+
+=09=09/* Credits have no response or identifier-matched transaction. */
+=09=09l2cap_le_credits(conn, cmd, len, skb->data);
+=09=09goto drop;
+=09}
+
 =09err =3D l2cap_le_sig_cmd(conn, cmd, len, skb->data);
 =09if (err) {
 =09=09struct l2cap_cmd_rej_unk rej;

