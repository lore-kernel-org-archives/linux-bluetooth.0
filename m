Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019001;
	b=1tB7hgjGi1OJFX7PZAlR9PMOIHU5AQGkar0PF2RN2nKj2DLMMiqHbFqfodkUERoQ6WO3
	 UzxgnJSmJDAWwWNmO/KOT0EoQhC9mI8LJ7V5Hn9tmxydCFBBiNWupGwskuZY3deCFodxj
	 ZRDlx2ifBmvIfU5iAkLLeQOaOSRf7BzOHhNmD0JBkjMuh5OTa0GAFC/AvxU++BstTQvk4
	 z+WBZ8HiJiEJVmz13781WjX/ry+1qOGT6b1HEf2lp+Dk8kHQovYiFo1RWlJ8xaIdHYhff
	 EvMBLqu+GVK/jfk2QXuQuTdhFzR5Q0CtsgPLeHcnGML/Pdbq3gTbwX36439qFGIz6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019001;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=D1Jx9y9jVGR/TWdy2LDI49Y0udDyhcHmoW4k9AEF0ig=;
	b=fk+0uT8TV6Uv4I1rbMzNuewsHMehbTQNmljp7oQHaETNYPP0YC5FMVPI5oYycitTibJR
	 KgzqPM596ZBlx6UENLgZVwCwuBDDBFXW961ocsNnQqXihvdbtsin0mMgaEeqiI3vLibi3
	 ftGRXVVTUPHZydN19bwFCqKAYLQiXI4xuC6MZHPtT6Pp6K5dmjJicsxTj0iFwRDX3D7A1
	 4B85SKxQYQEPdBx5u5wQA6HmUf3TVc1L/2lau3smiQdeAB6u4shnx4Yl95++V3vxPY9d2
	 AoEqbzFQ4hrFKctDN/ONF1zLHHUZcloNDkmFXQfelnJr5Y/E0SoPHJIeOtxfxl3K7uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=yegfdCwu;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813C606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 02:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C813C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=yegfdCwu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794018998; x=1794278198;
	bh=D1Jx9y9jVGR/TWdy2LDI49Y0udDyhcHmoW4k9AEF0ig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=yegfdCwuGad5g+9shLxJVKuj9BLXX+xKF9beUWUUtgdwbZyydtedVaaMj3IzuyJsK
	 e3BKAeT2veWl7nRvoeM0Mp/ksJh+BO5fqKCR+TYNO+FwUwZBffzMe2c8BU7rGLHYWB
	 lOCmgbsVldsoutLFroHTfHVWe6Q/A3oTnMRYf9iEZe2KBulLaBaUVhxs7OBLYasarA
	 FgozZbcCpwCQN5fpWV9EjdQ6HHOByIYgti231/HPvhSRcB1qiVv1SmeDEF3c7u4x+g
	 DzlS7LAfhejxdihWSlBxgZUDXwwvshXtiEkspYaRVNJhZP8+/yvlye2XFsB1gf7PbZ
	 vGHBD9ZsGf0Kw==
Date: Sat, 07 Nov 2026 02:36:35 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v7 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261107023556.1475788-2-cochcoder@proton.me>
In-Reply-To: <20261107023556.1475788-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me> <20261107023556.1475788-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 2124152fff084203ac7a59ad5e70b045bdd432b4
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

Cochlear Nucleus N8 captures contain LE credit indications with
identifier zero. The specification forbids zero identifiers, so the
current parser discards these grants and leaves the channel without
usable transmit credits.

Accept nonzero grants only for connected legacy LE CoC channels. Keep
ECRED and all other commands excluded because the observed
interoperability issue concerns legacy LE CoC. Apply normal credit
overflow and pending-security handling, including the shared transmit
guard from the preceding patch.

Let the credit handler validate the exact payload size after the
signaling parser validates framing.

Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes since v6:
- Rebase on the revised security handling; zero-ID source edits are unchang=
ed.

Previous version:
https://lore.kernel.org/linux-bluetooth/20261106173948.596166-1-cochcoder@p=
roton.me/

Corrected native controls verify the loaded module's srcversion and SHA-256=
;
the genuine unpatched base fails the single zero-identifier credit test.
The concatenated-command rejection probe is not a patch-2 negative control.
The legacy LE CoC exception still needs maintainer policy review. Hardware,
PTS and new remote CI remain unverified.

AI assistance: Codex prepared the revision and local tests. Attribution rem=
ains;
personal Linux DCO certification is separate.

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 503942987..c25d339f9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5417,6 +5417,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -6026,11 +6030,20 @@ static inline void l2cap_le_sig_channel(struct l2ca=
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
+=09=09if (cmd->code !=3D L2CAP_LE_CREDITS)
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

