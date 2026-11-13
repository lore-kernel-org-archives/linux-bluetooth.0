Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578460;
	b=Vw5TFbYMRYkwN3LHePr5tKpe5SwvA9GMsAB5/CZQmaeQLhoiyUq/IzTkq5QlbENNH2qi
	 I5ouE0+CtCP7rK7AS4BdZQ81ZQ5OPd7HlxjXPupGRj0KTi9HvZqHBWvZOUQAn+qYFDkOk
	 7OERUX6qLorNshNiTtjD78+5RY/j4lVQSOX2C0NwTdSY1QADxXF5OKg4hQPxQTo7N+LEZ
	 56wnwsn1ankEYwXwqTPOVWAlqDXcKtN3hF/yRGoTpLJ9z35E1c9WWtwQtOfoRNfj9F9BA
	 VFh8ovftgPA8SLD4pq6ngmu4kMlElegqGggp/ubiIq96T26qNOc2UuCM5ShQ1Rp9u8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578460;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vHaCjcCnAPiQwr9pVt/YtHudqrJpZX6FLFbBhTiEIJA=;
	b=Mm6wlqThsyKDqeygGupcncgbYEsWr7O9bo1e9AsFjGR5oJcISRHm8xS7jQQMgn/JxJkR
	 hOpEOCU14LxnF58BA8dzxQ3Try6rXhsXoFmRA6fqW7fchPDIvxHWN8KwoNtIftvi+vtYG
	 CpTly1MDS3XfYVkdSn+Z/ERe2ckExLNJhI9bWgSbwl28wwRKJb5ugB44PlTwCRiFHV0b3
	 Y+OHVYlOpZvjYh5jikwsyHL1+oTESHh1CrQpeSvnB/ihDtjc9HM5OtEN7eokql8OnbFYl
	 3noy71M7SxkFn7wD0KOWLI/91N6X4u57lOIpeKw/xceLkeBFvswXHr2hkuCw4eEEqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HIZaeJ6j;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2740606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 14:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2740606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HIZaeJ6j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794578457; x=1794837657;
	bh=vHaCjcCnAPiQwr9pVt/YtHudqrJpZX6FLFbBhTiEIJA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HIZaeJ6jF3wF/98u9eeFRezL5ZFIdaMGbf7N0PL+nf5RT5VeN+DqfUjvjJM8qd5Bt
	 1MYh1RRNKmsM1HUeVBA4BcON27MrGXGTbE6fUnbuFrnpA/14qBYBt916hkFQ0rEKkZ
	 4C8j8sbbDgyGKDWhmpMjm0g8ta80eHsB8pDkag9mMKl0QqSIMxZsu9Pr63a2t5Xd4d
	 yIC+kPMhLZUo4J4G7b9OWTU/5ihjkr2esofJGpnGkoYAdKMLx/zRf4r12ty6+S/D2R
	 TgPIzEOur3qYa+8wW2tjMFJAfNkH5S7XHQLwbM8XPfUzp62HMaNXtR1LD3UPb1XgtC
	 JsxVTrQqM/ivg==
Date: Fri, 13 Nov 2026 14:00:52 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
Message-ID: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me>
In-Reply-To: <20261113030556.75484-1-cochcoder@proton.me>
References: <20261113030556.75484-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 5ca113300b781ac6e084d7317b4efadc3e8a1e39
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
Changes in v11:
- Purge retained deferred CoC data before incomplete-configuration teardown=
.
- Clear pending work flags on close and recheck channel state in the worker=
.
- Return EBUSY for overlapping SMP/encryption requests, including key
  distribution; restore pending_sec_level when rejecting an idle request.
- Complete ECRED child cleanup and propagate deferred security rejection.
- Preserve ordinary accept/close behavior and socket/SMP lock ordering.

Previous v10 (this series has no cover letter):
https://lore.kernel.org/linux-bluetooth/20261113030556.75484-1-cochcoder@pr=
oton.me/

 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09ff32394..4e8aec98e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5464,6 +5464,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
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

base-commit: da3cc02587c629420603df4395179ec82955c941

