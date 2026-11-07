Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794035833;
	b=vR5uPnhhAOXxzEgDK6wq0vCYt8xcB4F32giqheQ5+/TkIT4V0sOsV7ZYJ54cS7/4AQB3
	 dpHrS2qn16Z38E4CNzKHhpZLWU+2jwb+oE+UfvRwVa0MS6oGKQO3EmAy5MZISiUzFuLGm
	 MlzeC4az2vrqaQJVCbbW6k6QEye3XHW3KEBYjwrhe6drlzQWo0s8J6llLB45hhHi6brj3
	 FkCn4xrgSKhNb7C3g3qnTGjnbnfck9M/cG6SklkZWHmwFdpthymKXL8HEtUQ8ELR9XX5u
	 qQpbSQrfJWI8+meV+jBDRolTQ/S4OB1BllnDODbVpq3O0fY/m3JV5MIDJxICftR+bvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794035833;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GXZ6gNEfXUgUW/W1D09ZMaTWGI5bQNp42jwcUsjKAsk=;
	b=E1Up+9pJHJU6DDhjnLEsnbMNzeQK31qk1uHlBRlOPk9jgTdsposQIUTfKOJPRGQYmEQ4
	 pwugIOm6oFIRh/0I6MJsQCdnvakfJombp/piONBG1qStmDM/nAGPbOBkAevovNORUm3EX
	 5hebS+UCQoPj2dJbYtRvbQxlp8Wr0jOn4B4rRmCyEdjele6ukSBwnicPke5h+sKxk6mid
	 1MxyRCSxfr7+aiaj4Wzob7PhXK/2hfYb1CbPWURecnIexNJNG7rDn+fOT9mYGj2NQ1hfX
	 XxYUQIzVw7IPog4ElCPy7N28xFlF7Kv8+3YsJkWbqxC+D7W3yHuFATkzZ+/2mtBohCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HSKj7iwg;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E892606A32D
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E892606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HSKj7iwg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794035830; x=1794295030;
	bh=GXZ6gNEfXUgUW/W1D09ZMaTWGI5bQNp42jwcUsjKAsk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HSKj7iwgnyXQeLDlyF4d6x4rb5AQMUf8QIOQ9cXSKXsScAqvf1JmfeRqf6Ub31C2U
	 nZkivheFCDHqQ17Ju3eNV9gyFDMHw10irakB+uK11DFYFxqEMwHiaLeIOTXzzyg1vo
	 bIiZIIgQh+L+4ubnHRDFMv8t/DSdz631R3yE4lG2OXTwFFsNjeEEXOjy09Z7e2FCzl
	 oJcyRwhisSiBcE/jXdGDmEKujyc1keMqAS8IARjwbRhlnnYvNAPTIyTcIIP9e1zXwf
	 MxohH+6EB3eq5Z+7WHM/LAUaMw3oTuFoUt98Enve2+rq6St9tXrJDo9kzXKpUi6QaQ
	 NfeasG1/24qtQ==
Date: Sat, 07 Nov 2026 07:17:05 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v8 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261107071634.2237059-2-cochcoder@proton.me>
In-Reply-To: <20261107071634.2237059-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me> <20261107023556.1475788-1-cochcoder@proton.me> <20261107071634.2237059-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: fa7677dac6e9dda0d92ac8355645e3f5211735cd
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
Changes since v7: no source changes; depends on patch 1.

Validation: mocked source-level tests pass; native v8 testing, hardware,
KCSAN, PTS and remote CI remain unverified. Leak detection did not run.

Previous version: https://lore.kernel.org/linux-bluetooth/20261107023556.14=
75788-1-cochcoder@proton.me/

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3a7b71321..8fbdaac06 100644
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
--=20
2.56.0


