Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528946;
	b=BHYvR1m/rRkr8BosIzB/+unCUb/5xddecHIbgegwKRo84mmYNifjWTE99rt802hiLjut
	 V9Ho2lqonCO6fKLzzU1wyuMPn1/GMCjoPtk2mmuJ68ket9jZezS8dsJ2yf2hi8/eaK+kU
	 Wd2XZ0cqEiuj9mXJT3q/BJ5tvMhLpYiTgB8vAPiqCtP+2alblxfHlK6RUAst2FZVSW0nJ
	 A02qm9+nB7tIsSuSVh4RZOftUzYlTeqZU7AWOUpytsElZ4FX9S5BT3zHy3txcSkZHyTIa
	 NAXkL5amnXXzR/rR4DZ3UgPrkZF0Z7lIOH7MvhNekqmvxlxI9uiViS5bIudBqCfC/3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528946;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=c4GNMa9tpgoOG4yUmZygw04GbSRyFzVs9uNLQgTcCD0=;
	b=LXZ19HkEnA5L89rt7mfcLlv23ZtM0ippWsGf9UDAHG16zXa7UEa/nrMRYyOakeGLEy0/
	 GFXWBn2mVGsAPkdX5BRS3tTeX1m8F8NZ0ZhyZ5HdsBtDYZZ7r43LqGeQOw/n6X/nvxsoW
	 Ot0FBCLABSv1qVtvLrG+8s3TkgTtfT8T1ggPe4DWrevN4d8QTE3d9x7KZf7HIbc/zutxI
	 59kEo74TiBiKDxzAXSb1+TpTlL9lQbQGZq6Lq/mRsPGJG4O0j18it3Xi4jZYobZY2Xaij
	 YcCjf4ObBGQMwLsn9p0yZitAh2CWb8bCTxCYlWuT7ai0nP5QP3oA0e4djrkFfu+2KJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=yjQDOz5W;
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246E606A6A2
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F246E606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=yjQDOz5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795528943; x=1795788143;
	bh=c4GNMa9tpgoOG4yUmZygw04GbSRyFzVs9uNLQgTcCD0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=yjQDOz5WBFexND6PF6D0K+pSOkxMcQ/mTZvN4HnCRazRtFS9ViR/qhEAAtmStA+pj
	 I9mextt9wGRG+hb80acxL7JIjraDMneNDv8wXkITfBlPqLlCL7b4zept3et3JMinkQ
	 VDHIsIJJmxwah+09ENaV6YfhlFbaXUGtGNLQZTHvLCpPglFVc2j36rHsgiqcwkwpUW
	 /C0+rHt+YGKZrOTm3x4medAglFld8HpWuVkJzq3FtCOQ1TiFsUhnlsFtWPEo4URWup
	 niMoueHA+9gQL0m6IHvpK1m9irB/gzPY5ZOI2plRnyA4kJpY4J4y//KZp9KOpeweuS
	 SQhJrgUAUcskw==
Date: Tue, 24 Nov 2026 14:02:19 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
Message-ID: <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
In-Reply-To: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794617024.git.github.filter194@slmail.me>
References: <20261113030556.75484-1-cochcoder@proton.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794617024.git.github.filter194@slmail.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: ad419a724179f2bb488ae4a1a724b67456016d11
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

Do not let credit indications change fixed channels or complete pending
connection setup. Validate the channel state and mode before accounting
credits, checking overflow or invoking its resume callback.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v13:
- Rebase on current bluetooth-next; patch 1's code is unchanged.
- Keep deferred ECRED data gated until the response is queued.
- Exclude outgoing authentication retries from incoming ECRED batches.
- Wait for a new shared-link encryption procedure before completing securit=
y.
- Preserve rejection cleanup and explicit per-channel locking.

Previous v12 (no cover letter):
https://lore.kernel.org/linux-bluetooth/4278a9caf4dc8e949092452c141a5be465e=
c77e1.1794617024.git.github.filter194@slmail.me/

AI assistance: Codex prepared and tested the supplied follow-up fixes and
updated this revision's source, commit explanation and revision notes.
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86..8229bddca 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5469,6 +5469,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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

base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f

