Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433384;
	b=rd/CmoHdqmHPdenLE26q7BazqsvBR/4A/j9YCwmdnr+sZzTdhAQM7yHow/X2svwYxNHj
	 IJ50AvqItQzSKRn6AeVhWGX826R+6CIkO1p9kkpaGwIkZmEkmSi52aX56+tSgD184IGw5
	 9FRoKg2Dj0lHilXbP4jPgkYCqtZSlZM+k9LQVH4oXqIYuo2Wy8TvJj3mjfnLyfzZet2ED
	 R1Md4Z8MQkxyXrzVK0DxrHzEEfBUdjoj3adBBMatdrPK6nIjbwDmHcfEDcRfuBofpfy3H
	 Y2KJZer4c9KshcGi2V2QTaZA7U+mxcYlauJmKdt6DpSqn3TUUDQmmgcLSketspUcRiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433384;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xJuj9P4uXgEj6iPCcP2YaJV3OZU4C2gZtFCB8hefNn8=;
	b=mtmV7vwlkYA2uCqwaPF9BqDUH5ueZZoGHM0/OkJnhXVqBpVZkhw+WOODDt2XOztqv6iN
	 /v7w2gZN90/nJr46wCZ7Yt1KItJDPLKhiPZ3159gEOoKlpnLYUXo++VUcEepEz4RJo4fw
	 xUNFKEjS7qWoHN67Q2oVr4VtSgR9KGPiPvpbUOX9Sg/t+bnL6l/JcZ8vD3OuDwQ/r2huz
	 P+Sw7tOPQlZD/bQ+qJOdVYQamRD5L0x2CLZReBseTvmGk8jV2PAEC8I+Rv9bTdRO1a5hC
	 JtF6rVwLg3H9E4Mdk4qaFeKKhCJb9PxT5auIMUK7cO0SK4qTOV3fYkJSqzGqk4Ya25w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ge3rqyt2urftlk5ktw7h26xeyi.protonmail2 header.b="SNlJU/Jv";
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15804606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15804606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ge3rqyt2urftlk5ktw7h26xeyi.protonmail2 header.b=SNlJU/Jv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ge3rqyt2urftlk5ktw7h26xeyi.protonmail2; t=1794433380;
	x=1794692580; bh=xJuj9P4uXgEj6iPCcP2YaJV3OZU4C2gZtFCB8hefNn8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SNlJU/Jv42BU2Fa42JiaVq+CYIPixJeYGDllL5/J5fDoglsMdzUDGMCgq/tx2W5Py
	 dNXvOL9jQ5cYIOa/hSRAP3djIRVmUqblEATdz/fcX/n6FGJPGQ84i5v2ozO6/F+AA5
	 GIoJodKzDqFjE7H6Xp1Mk1eY+aiw8cUj6i6Nm+sn/OOW2PtcT8tD5gsk0SnIlpzb7x
	 3WOhYeZPtb2D9xRcDRFet5ETWbFGjhhZ84+XqOGASbcVLoVEzcFmY8CPGbDHzJfPHI
	 cEsaNi1NOK7olO8KtphPqqQEAqyHoAFoesIOEVaJnS7BvvV2HjyFbyBIxHylsjuLBS
	 TSXKbf+f7PIwQ==
Date: Wed, 11 Nov 2026 21:42:55 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [PATCH v2 0/3] shared/gatt-client: Track internal discovery reads
Message-ID: <cover.1794432472.git.cochcoder@proton.me>
In-Reply-To: <20261107065854.2147141-1-cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: e8fac1f7ac94f5cc3386804778551072da9872d7
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

Track Server Features and discovery Database Hash reads in pending_requests
so client cancellation releases them before the client is freed.

Patch 1 adds shared request support. Patches 2 and 3 fix each read with
separate native ATT tests. Both depend only on patch 1; either fix and its
tests can be reverted independently.

Changes in v2:
- Reuse pending_requests instead of adding per-read client fields.
- Separate shared support from each fix and its tests.
- Test queued, pending and continued reads. Cache Server Features in the
  Database Hash tests so they exercise that fix independently.
- Rebase onto current master, preserving its GATT parser updates.

GCC and Clang ASan/UBSan and GCC LTO: 236 passed, zero failed, one not run.
All six regressions reproduce the use-after-free on the unchanged base.
Removing either fix reproduces only that read's three regressions; the
other three still pass. Both reverts apply cleanly. Checkpatch passes.
Native make check passes all 35 programs with Valgrind disabled; the host's
Valgrind crashes in the dynamic loader before executing tests.

Previous version:
https://lore.kernel.org/linux-bluetooth/20261107065854.2147141-1-cochcoder@=
proton.me/

Kyle Pepper (3):
  shared/gatt-client: Support pending GATT helper requests
  shared/gatt-client: Track pending Server Features reads
  shared/gatt-client: Track pending discovery Database Hash reads

 src/shared/gatt-client.c  | 58 +++++++++++++++++++++++++-------
 src/shared/gatt-helpers.c | 26 ++++++++++++---
 src/shared/gatt-helpers.h |  7 ++++
 unit/test-gatt.c          | 70 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 144 insertions(+), 17 deletions(-)


base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
--=20
2.56.0


