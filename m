Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940972;
	b=V+iLYyb6PBt8EV2UOGFTi7PTusRSfLi1ZMRQ1gFvQmOVH3Eb8J/y/NHWbBTcf/ZoiWss
	 aQuc52TvjyneB+yNl0ebANwHnuUejwcPIqVrRFoXSNfIenTDGLi1IjllczrIzx/3snQus
	 dsZB0X49xkg8sZwD8HBebe6rG2QlPfJeoqowvcFJlrfd3emssZA0x1ZrpA2wLdi9xfGbu
	 3CkzhQSiWVcNTLOCLsSVH+XU4Uc8Y1GpkIOSaOyaauvUzen1Pe37TpTQ0y1yGJ3jk6r2n
	 veTcgOr41HgIR/Yar5d/N92D3UjtRQrvuM2Omb9Axung+sGDUgspH/2leR54bycMgpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940972;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lqqB5syzjzLAkhdvBwHvqSYGDeFYQmOJTV77GTgjLkA=;
	b=N6o8kw/A4l5tqnfLKRoHqGbCWh16WQhdVzR926Fgn19VPrIiPQ1lEthDQqW27EYoFs3O
	 VTEuIFNXhZGnpHblqSN2uyGpENxFfpV1JE1Dgk8bOqS6jXk87J2b8vmgT+iXOutcr4G2z
	 zCHN78HYyIEt/P/l4xdjfefHCtEAEVpeeC2HL83mZyvsZfDMFpo80WjzqdhsKpYQHqdnv
	 0RVmtNjLSzDerD4mLWxJFpApec3CzEr+wbd+lPhhQAScEAHzoc1s/+3cC86YVvIs0sM5+
	 GCZUBEwUtjhkh+B2KXH8dr7RVDutBqFkaSf4CSzcWFhDWzN6jD7ID6p5N9zeZI92ZMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=opiv4elrcvclzigtz5y5hxt56q.protonmail2 header.b=NNNmJBVH;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95055606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95055606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=opiv4elrcvclzigtz5y5hxt56q.protonmail2 header.b=NNNmJBVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=opiv4elrcvclzigtz5y5hxt56q.protonmail2; t=1793940968;
	x=1794200168; bh=lqqB5syzjzLAkhdvBwHvqSYGDeFYQmOJTV77GTgjLkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NNNmJBVHKnMi74ZQ2jXTCF9mZgVNR/YRexL02aMxojGYCuWglmfrla+OAhDPaxrPB
	 FpM4XMscOCxbwYbyd7OLCVPgKemnXk24MAELNmjRVvmSWBRqFigG+UYa7bYt72x4hs
	 Qupw40cBco8XhEKg6CjONoWs5qMjay6bwB1b9KQBUUt6CWXueeqwdFQePdtIQle6wC
	 wC45G1Gc7o9P/Z5FIcM1FgoXOnj1TQ4cmMEW7D8xcKgKBljSqnPMGlgSrHJvr5G0he
	 cUJl7LYBEyEyDER3R4gijR/w9rDsfZbRhVMyNO1MsPdHwUBtl3ZnuqZAF4wlw0tRdE
	 qMPyy+nKC3vSw==
Date: Fri, 06 Nov 2026 04:56:04 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v5 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261106045515.853897-2-cochcoder@proton.me>
In-Reply-To: <20261106045515.853897-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 3be4ac843c75ee3278691da332ea809e5afbe382
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
Changes in v5:
- Explain the observed Nucleus N8 behavior and legacy LE CoC restriction.
- Use the credit handler's existing exact payload-size validation.
- Depend on v5's shared security transmit guard.

AI review:
https://sashiko.dev/#/patchset/20261106021723.631339-1-cochcoder%40proton.m=
e

Credit/parser fixtures pass. ECRED remains excluded from the zero-ID except=
ion.
Native L2CAP and hardware behavior remain unverified. The interoperability
exception remains subject to maintainer policy approval.

AI assistance: Codex prepared source revisions, descriptions and local test=
s
in response to the v4 automated review. Attribution is retained.

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae6659fab..d3b875c47 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5388,6 +5388,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -5997,11 +6001,20 @@ static inline void l2cap_le_sig_channel(struct l2ca=
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

