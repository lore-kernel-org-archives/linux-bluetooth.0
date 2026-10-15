Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319E3BBFD0
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042107; cv=none; b=uM0WX5qRe2i/ONf82gEr+HvDyELz8gCxbcoq8+xqlX809osIqpj2vi2fAifV23qZsMSux0DJ4tzNabzUMnHt9HrhImNDwqF0sbuRq1GJBWnhywtsWQDjkA18zGp5pX3ZU048kr5+3muR96e5OApjecC8GRErwtqXJJbz8MCQWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042107; c=relaxed/simple;
	bh=U2gj/vaV65VNsUL7fPUVQ/1hnFH4ZW5FqtRa+wjwJM0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXey+ujjVYfo9DPMUW25Daz7hx0LtmczO3vw3hiUlXb2exX1tng7NhMY8+5OWOVMBzKzeYUfB2Jk5TviV7YKIvKUolnDVKVzD5viJbyPcgVgGa0NK5E/OLNy0MhgaljDXa93L+eeK0pFeE3cRkOLU9vFa2b73g3sH8kWe6Io1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QPvLQWl+; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QPvLQWl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792042102; x=1792301302;
	bh=cK+uFW9olimdOfTgCS7tswFXLY5ZJbA4nN3Y6M4+Al8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QPvLQWl+JYE3NDjbfKXEBhqhLFae9WISTCmsq3HnhVBUuw26bapNuDMP1i8vuLU7s
	 Jc7Hhclpm2/4WU862FqZefGlJXgYfYGPBqoA2q+1tBLTK7jZwpplvpU6xXbBuVjTGx
	 nzZZEURQzd5Gg8/FjTgZeFU9IQb7L0BucfXqmKIJb++SeZWN/Xzlg2U9n0y6QIPn93
	 vkV6el9jbhjARJnHcENwvQosBQFIJ/y1SiOwMIq01eUnH/z1BGfzqP/eK/STw+CnbY
	 3gf8gvb+Uhxdq7QLGTJqLtpfA+ujBYTC3GzKti3cMGSrdEdjq9KhAsQ2Y/DzeY47yn
	 LY+JG9slNrpGA==
Date: Thu, 15 Oct 2026 05:28:18 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261015052751.137705-1-cochcoder@proton.me>
In-Reply-To: <20261013031943.489829-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 0a035fcb2513a39e20eb97b1810c65016d85ce26
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
Changes since v1:
- Depend on the separately submitted target/state and pending-security fix.
- Require a connected ordinary LE CoC, an exact-size indication and a nonze=
ro
  grant. Keep fixed/unready targets and ECRED identifier-zero grants exclud=
ed.
- Preserve shared target/security checks for normal and zero identifiers.
- Do not generate any response with identifier zero or relax other commands=
.

REQUIRED security dependency, submitted separately and not resent here:
https://lore.kernel.org/linux-bluetooth/20261015052018.129971-1-cochcoder@p=
roton.me/
Signed dependency commit: 61a7ca610078ddf616873e7d4914cb6ac9eae7a3.
Apply it first. This mail includes its prerequisite patch-id against upstre=
am
397464709a20. The resulting source tree matches the validated refreshed pai=
r.

The Core specification still forbids identifier zero. This remains an
interoperability RFC requiring maintainer policy agreement, not a conforman=
ce
fix. The separate security patch is independently useful without this excep=
tion.

Fresh current-base controls: all nine focused security cases pass with eith=
er
security-only or combined kernels. Public credit controls pass 13/14 with
security-only (expected positive zero-ID failure), and 14/14 with this revi=
sion
added. No skips or captured KASAN/lockdep alerts occurred in these focused =
runs.
GCC W=3D1 changed objects and source-extracted security/target/zero-ID fixt=
ures pass.

The refreshed full suite is NOT claimed passing: SCI Fast Mode encounters a=
n
invalid response length for HCI opcode 0x20a3 and times out without a compl=
ete
summary. The same SCI failure reproduces on unpatched current upstream and =
both
revised guests. Initial spaced VM selectors selected broader tests; correct=
ed
space-free credit runs are the focused results above. Earlier 134/134 combi=
ned
results belong to the older reference base, not this fresh full-suite attem=
pt.

The combined Arch integration is reported working on hardware, not isolated
attribution or exhaustive device/security/teardown coverage. No remote CI p=
ass
or severity claim is made. Private security reproducer/logs are not include=
d.
Confirm archive rendering of the dependency link before sending.

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

base-commit: 397464709a204da9b8dc3b01d6ea42539d951cd2
prerequisite-patch-id: 658bb8f3b3e38bbbb21f2619434affc641582b7f

