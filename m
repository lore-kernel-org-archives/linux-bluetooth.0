Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650291;
	b=NJA5PbF86Jud7+y6RXreFS+T9f+iXC0ImFtVnwSpNLyNFw/MjCWikHetVMJMXPVp0vE/
	 nQ1xH6cdTuE6no0HwzG3n7HYofPqL9+NbYBNPegC+uNzeqDe9drcXMyYGYBn0hoj4bm70
	 U+Sh43f0DjZJuliaOhBlzRB3olLJPXkDc81mkJeBjGtDD3rP4QplwGm9WBbsJTHmNheVP
	 3COJLbBDnMOL+9SEtSKraHjg7qK3MClF2gddgCD3IpT6S55CVkMo7p/8c8+i5cyztVigq
	 Mbax2ggXeBTs7zQJhw5Iao+TJ4lLoQX15+14TGRC3t+wZ1wMnP+1ztCcNvwstO1EP/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650291;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bm7h/Ud9QGyWYEADODdFvttRWzwPpZHM7W52VNkqaPc=;
	b=y1deqS60X6H3pbnGJLA10An68NRW8+BBGbMT7ShoRzflXLX/qARcCPW3Em8aazh2o+CP
	 gSBv9id0pcFG0wPqvjoV4xkiko3SQKpg/8vhA7CMS5qEKB9XDa5rMgWTPNpQNuQTYauFI
	 EVKvbJeS65BxQFRfhTb+p1MDEzjEDmTer0iMMmUJIISJ1TnkIyXXPtEZPwJ3g64m0tPsu
	 jtZbmw/s0w42S1M1hUQfFZ6VTVYXDSO86uktQ6n69AaTNUyhwb5WbfB0O0lJ5U5UiZV6Y
	 kukeIbVKsPqZIAf6q6QpNmjmTmB2FdlH4w7/YTjjqE3EDm3sSoTv86gK1dHv7PufVeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=eDRMCq+P;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF9606A31E;
	Wed, 25 Nov 2026 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BF9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=eDRMCq+P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795650286; x=1795909486;
	bh=bm7h/Ud9QGyWYEADODdFvttRWzwPpZHM7W52VNkqaPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eDRMCq+PF9gu6Za3bfDEGjkC3HoBseayCX24lliuhKPTpMUYJKq66rUDcrBP1v0Bx
	 54YKBcLO4sHosE1ow8T8ywszrCB0xqeNLLSREQ8g9O691Kx2fuPRCLINcgsLpuo9c2
	 KtE6fjkscSNsxWeiQrdRNUU8JikoMt3p4qNQpvr2unzvazBAGuQd9fYXu3aHJU6XYy
	 8x9tJ5XfhLgiAhioszbKS+WI+OVaH+0uVthXFuK3DAmjVyyjhrvYqylciYvlaa6dxc
	 cS5XGr5Ww/hSZc/h10/7K5NrVx3hImeBel70UT2pJ47nIDKZrzk73E6euHpEsAtUR8
	 wvvNptBSzCWNg==
Date: Wed, 25 Nov 2026 23:44:39 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
Message-ID: <6aff9cb5ebb1f1512734d5ecdac876a2cc0c86bc.1795650070.git.github.filter194@slmail.me>
In-Reply-To: <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
References: <20261113030556.75484-1-cochcoder@proton.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794617024.git.github.filter194@slmail.me> <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 350a8a431add4120316f4dafa670e7a1804c5aa1
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

AI assistance: Codex prepared this attribution revision and assisted
with validation and commit text. Earlier revisions disclosed LLM
assistance for the credit-state guard.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v14:
- Replace the obsolete Assisted-by trailer with AI disclosure in each
  commit message, following current kernel tool-generated content guidance.
- Rebase on current bluetooth-next; both patches' code is unchanged.

Previous v13 (no cover letter):
https://lore.kernel.org/linux-bluetooth/9d9d37680044266dbd1d6919b08564026af=
cd87d.1795528595.git.github.filter194@slmail.me/

V13 CI passed all 12 other jobs, including the kernel builds and
l2cap-tester. CheckPatch rejected the obsolete Assisted-by: LLM trailer.
Those are v13 results; v14 remote CI has not run.

 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc867402e232d4d4c4a93d4b7ba5d376367..8229bddca5df761dd1359b88752=
e3d5f6d6090cf 100644
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

base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00

