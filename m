Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931495;
	b=DdjwwPfOxVY9NKKwnGUQwq6MxtiGrcRF7yeSNviPYoQqewConOXkFjp3Akb4t7l01AZA
	 +yxNpSpu5x3lOkZU3MsQ1sHbw9BUOF/iUYqwPNY6kBLjVwgOixD/eujiwDNlPS+EtT6hb
	 A7hBhYlB7Mnl2Z/PxE+vSj5rQZXCSpkqsIeQrfYc5EouPIOavICV2QtRqpbiKEInOMPBv
	 ySVRP3XRqZh9cJDZTmOPRnCTbWTmYgVW+GG0n6SzpsDjGEhnL0GePU16sgrdQioCrjX0n
	 GtBlfx+VaBFGMQ0zxx6Omn+K+4XOehPUMRXgk+5LBya6QrauwV6Dw/I+kCPe3+yNddA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931495;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vJAwnH6DqhVCv2oRViwC2Bi0m/mhC0czlGN3s2VpsuY=;
	b=Eb3GDbSp1jtzZD+tQrytWTON1iewD/1ImtkjQDU0wTFeSnq5JgXfwwrWwafrjEzgqh1J
	 BSWvQ1xh/YO/kKgHNFluUAC8TOL7qnWMDP2C3dYmk1v2q3Vw6RKtyLhh1a32Y+lNOiR8F
	 7rvUpV5IcSBaLzkqXev4VToVeN7U0v+Zzsd/nPFOv37V52pD+ifKyc4lHchljVy4ytyMG
	 6aGynMC6J4jxd9usZ/hsszPynRFB2/D51GjT0rSFqIsuVxV+dBRL9ntgbtJN3ZfNV88au
	 jVZDElnOb6IgnN6wG30scd+NTURDuRTv+sDx4lGo0Xudol7cFTwziI954HeTJBFzCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="X3pNd/SK";
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA4606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 02:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=X3pNd/SK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793931491; x=1794190691;
	bh=vJAwnH6DqhVCv2oRViwC2Bi0m/mhC0czlGN3s2VpsuY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X3pNd/SKlZDw0N6dndGskcsPrsU/zRrOZ3CTHXX9BQCJf1TtAj7Y7Qds0vDMhZfqp
	 A8EEnW9fgRAEh2Qv0dl37eCkBqkLAoo80AJDItoEATM9y43VnGI+5zVc6NjBqLvl+S
	 Lgw/fpStjQWh/X5fI0pQKqNIv6ctOGLuUH2WXGb3cO5u4pM1XCVOg+dhrVZ97qcSG8
	 9D9X20lejcpMx/ZxP/1SMsQb86ZFQidgFrnt0G/U1D0/wYGL+7hsgXxETcdzKLAS7y
	 cghTu27YDHqpCvhKlNVBhcAOsrgg+YDPF23E1i982JY8x8wgSuc4sOHZr/Z3P6LwsC
	 SXTTDKDwkA+Rw==
Date: Fri, 06 Nov 2026 02:18:07 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v4 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261106021723.631339-2-cochcoder@proton.me>
In-Reply-To: <20261106021723.631339-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 874f26d40e2051fa6d311ad2d565f4765e7b6134
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

Keep the narrow identifier-zero exception for nonzero credit grants to
connected LE CoC channels. Apply the same mode, state and pending
security checks as ordinary credit indications.

This interoperability exception depends on the security fix and still
requires maintainer policy approval.

Assisted-by: LLM

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
No code change; depends on patch 1. Maintainer policy approval remains requ=
ired.
AI review: https://sashiko.dev/#/patchset/20261015181624.48318-1-cochcoder%=
40proton.me

 net/bluetooth/l2cap_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9463ac215..4bef75235 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5385,6 +5385,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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

