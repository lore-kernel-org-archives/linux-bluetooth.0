Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450650;
	b=zJsxc4hGMZNKV1tky5sf9zG/c9CerCcBIgCDHe6EuSy4MrZXK0QBR9YSxGACWSQkMqbo
	 YIddJr4882McJ/xSN4G9qJfvfV8j9CK24NctJjKs5Rd6MM4IzhqKtHuQGUisrgcP9sRC2
	 bwiZ5QVxQj1C/KxNaZUknOxY220//eXGdLqrtYOl0NHLuIYGJ2W+LJjhq047QXr2xhqef
	 lZeLfdxrBlJtnZ7RMNw9vqGneV9U89LRFGnFjBTuoIFY9HT8KmO68zzYbbojtdstiSTIV
	 rcnd5y8MGMhXSRhF4JjWN+4vnbIz9ekKmboP/wYH4auhMKcqqUqESJIVthKYuG0ykaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450650;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fanzbmkFLp8wnwI+20OXUgBVZ//GS4MBHYYlTHJ6NJQ=;
	b=qpbkp7+UG9fMeIu9eGrbOxrzT+zTHxHwiaOTh9Ucy5jYOJcS9dd3txe+1CfZ2qx7bCcC
	 0w0sE0S+2gKe/ADssFUqhJK3VpkLzjOE6AgfX4bO4mfkRIw3iLPkde/ip82Jh/naBTmpj
	 cZFy6sU+tbd/M41WQ2p1J0spfV63dYlOmsaefJCkCpDdPkgbHAekA+SC2RucJpCpPkj7D
	 SpgXdjrT69OE1BOkx5ThUYj4CIK3mjvS1nWYlM1R0BJk1EdU8nB0/uQ8g4iCAqw0wFVWb
	 bBPhvGr5sc0yEzTWl6zfiAH+VdlheDKxs6iuluaKnSMuDAdd7FckrHmuui8mDFwJOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rr0GTDid;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D9606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159D9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rr0GTDid
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794450647; x=1794709847;
	bh=fanzbmkFLp8wnwI+20OXUgBVZ//GS4MBHYYlTHJ6NJQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rr0GTDid3zu0Kum9rfnhzfkj+pyI8660BupBA/lgOK+XuOm2GuIlM8wOXbojMOp8t
	 mvqlc+Cm+BK+NY7i8CcHecVD/Fe1KQGdyCvkHMd7Hw5piHd0/PiF2KeteQ5w8K9gDA
	 PwCaJ4Jm70DsFMfaRaueiuL3xu2Y0roL3e5yiJ2sPOboWuSQ+y2LRv6lcGYYl6ozys
	 EzvKaMHroYJR3DNd2T/2zqVYofleacsv83DWB30DaceOVZfa8f6peZ+KVBAxckwl6l
	 5ETg60ENPQZ0tn2YkzcLmxIIvhewh8g3WDiVPUlm0OomENmfvSrxroaF+rUspmPsSv
	 S9suys/xFlFPw==
Date: Thu, 12 Nov 2026 02:30:42 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v9 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261112023025.187702-2-cochcoder@proton.me>
In-Reply-To: <20261112023025.187702-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me> <20261107023556.1475788-1-cochcoder@proton.me> <20261107071634.2237059-1-cochcoder@proton.me> <20261112023025.187702-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 8d12eb6ccec130cb7ccf6f8b99b5fe413cf0c9a9
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
v9: source edits unchanged from v8; depends on patch 1.
Previous v8: https://lore.kernel.org/linux-bluetooth/20261107071634.2237059=
-1-cochcoder@proton.me/

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8a2a99084..20b64626d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5501,6 +5501,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -6138,11 +6142,20 @@ static inline void l2cap_le_sig_channel(struct l2ca=
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

