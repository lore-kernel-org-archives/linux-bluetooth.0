Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986829;
	b=P7ln2Zv6ne9U5Ip19qF/cZl0TKBUV4f5R6/tAMyMQbPWIKwPzKWqvXVYXB29vrCgCdTd
	 C1u4pHL8fQGJ9Cw8qD5zPJZz1LrrvBbLfZ20JTJM8jokKETH4NEmQGYOrHQ/Q/u0CTsv4
	 nqLiDIi4/qC14a6g/3UWbCk4EL1Us8NIOmf6qjApDhuYepk4memGlxIWg8DhMDb9IQ48R
	 KoM6Tz7t76NoDuMMMhK/zXcP9xOIwuGQ9VGnS01OXVzNDCD5D0FErApxSIObjWD/BvHL0
	 zRXX49qYflrrTXhI+igwCminwzlJR7aEG/ao0/aFIzPoUQQCju6u35d/1wcbhYJ79hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986829;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=L002ci0A7poWvXHoVJU7eBXko6+SeXIYRMuTGdW0NKg=;
	b=TQER4HJb05HXzrQZGfIEhWjLptLr7YbGhePuEbiN4gKjFVnDZl8piccqtPUJddp3D/fg
	 Aj73UvRwmRsTy9ouDfNDq7q6nHiaA6V6Bjxytf4HTSmCjNv99ST1D5GlDldIyMWz/HNtv
	 B2h+yrRBZbHuEQldsVYqlf6VUOocAWAemBeZk3ibu8p8Ax2hKEnZz5/f9cIvlYbMgqfHC
	 PVmJ6+aUacSEdpeDUxm3MWLQztWv51mgEzNuoI1Upby6CQoZUQEEgDdDxAyBQ0uwGJ0XV
	 HuU5D2DKnp7fUnpAMvW07U06GfowFEJ9Ack5I6gUqoOpTlk6aGdyYgwAxS6M+jh0R+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rJZcHh1L;
	arc=none smtp.remote-ip=79.135.106.120
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771F606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 17:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0771F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rJZcHh1L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793986825; x=1794246025;
	bh=L002ci0A7poWvXHoVJU7eBXko6+SeXIYRMuTGdW0NKg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rJZcHh1LFl3wSS1/OWy+sJF8hHwC6TUXegEG3oAMBkNcfAmwRT8UNmErLZKFBjXMp
	 pjEOI5qsbMfiE+71aMBfncz0TaeSUcrVQP+eIb7vTBO+ftgRAJ3auMlJKHmLdwxWXO
	 /r3MtNpA+rmW8uvn6Icrqt2yru7lCHevMy2w0zoWWOn8E70Q/pX6eiIKAAjoyrvluV
	 qaTVL0OEhc9ka9n1ezK0qKDdc8Rl1v61oIVApugva/G4lW4/EIGbVqczxKL96SoUGR
	 Pbceor2vePuUtqqWA8RlyNe0XHJDBFNys/Vq93/88fuXt+9ALnoX80jxbhAOKLv3ZN
	 KvlSshOjXhAcQ==
Date: Fri, 06 Nov 2026 17:40:23 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v6 2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <20261106173948.596166-2-cochcoder@proton.me>
In-Reply-To: <20261106173948.596166-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me> <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: c572eec48ace0d839a0ae1d7064cfd5893992633
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
Changes in v6:
- Rebase on the revised security patch; zero-ID source edits are unchanged.

AI review of v5:
https://sashiko.dev/#/patchset/20261106045515.853897-1-cochcoder%40proton.m=
e

Sashiko reported no findings for v5 patch 2. The legacy LE CoC exception
still needs maintainer policy review. Native L2CAP and hardware behavior
remain unverified.

AI assistance: Codex prepared the revision and local tests. Attribution is
retained.

 net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 24360d8e1..8d322d609 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5401,6 +5401,10 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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
@@ -6010,11 +6014,20 @@ static inline void l2cap_le_sig_channel(struct l2ca=
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

