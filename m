Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515615;
	b=WyPAzfPYT0NXOKQl5xh3chqh5Td2efDhpglAq3mdYz71YAB2TDsozlMZIYrc04s9ZESv
	 wkveMQiWPWzbr6sA10O+Gv6eUoHf66tE3B0g3t3YMhLaR2lE47T6HhfeMz+ZoCRhkryYa
	 wuWF3uu1zA3Ffq3ck5ooWSeInhANaVPLRFhtwKgO7BG8oeP4qz1v/B53cKd9zSQSt31lj
	 HkrF2nXa1o/hT7hQQ5FxphbVDZS3PLJJcEekeqzNdssyrxNjD9ZUc8GkANjOEwAhHtQNV
	 OgC1Cdz0Od9DuUKwBYdpG3OaMzlXbeWH0ehUNknNyACDKhAOSBZuxpI/aiDZuPrOx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XCf0dmgMikCjKenWP+R/PDy2Fv/Q85+QkQnzzII+3Ko=;
	b=ix2LCTRlCDvOzKvM9nMjQYF1gdsKBrVmEJ363NG51TceJhqpz5QsEvFsCDjxTSZhBNmv
	 kcR4s9ncYSCojacv9AQGUYC3uewWzCgXqQd14ROFZYYL66Macy0muSd/quDecHdOjB0x4
	 RHnlSWS7uCjcjtEIELF1LpjDNhRzEqHhGp2Sc1AlDcRVVe+kdEZ+20grl9db9RULF8CtM
	 im+pvgZ9hvbcCFoFVzzDkfp/ftNuwbcLGT7DzGtdv1YHy9AHmgc5mNzKvjWi5JmP/nQkZ
	 LakzJl493EQ8f9Z7UW3DjmblIeaauEOxNc7sXQjP5lRQxjPWQJX+1jnoxlF4pW+B9vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifNosrqq;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF452606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF452606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifNosrqq
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1131737137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515614; x=1795120414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XCf0dmgMikCjKenWP+R/PDy2Fv/Q85+QkQnzzII+3Ko=;
        b=ifNosrqqJ8t0kBTiJ7ZrkC9DYhtScApR+JAB4SMGLuAMOSiFUPUSC0D5vhDHciynvS
         A5jeJGkWoqPGZ9o6q/PIbcQDspE8Pgohg8VDHr/DLuIrneTehnvqW9eazGCTRpJIA3VX
         8O4PUpkdhKyarFlHA5w16PIjIXwsYBURVM3qi+K/dPBfO8mb7XBqobpdVz7FEqK2M5l5
         X7B0IUH5Jt3bdJPYNbCx3s9PagS7pV5bgsuTmg7lZ3tcafaGGpNR2nTrfW18zxhAMBmP
         9H6B0TLdPr/LSjETCtq2t33P69XE2jiLvLXhmvpMFv5dpyOiV1btDP/51shJRqzeonoL
         CRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515614; x=1795120414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XCf0dmgMikCjKenWP+R/PDy2Fv/Q85+QkQnzzII+3Ko=;
        b=FIR9ccWxwD23fyWFidQfSLoC3sX3sj6/RydewzY3o0qY9mEc35JSNLjYz9JhGkzJB8
         XrQ9IKjdZSQjhn1Q98s4myzS2m3qvV9A+0EuLGpWw+M9ESrDAr3oCDQIbIuqsvGM7yxl
         D0IPYkoNde17Z7vfLLXfjMNSySo5KnRRzE8v3MdGStnpasO+J/eSgxwMgYSerhCXXRcW
         jw6oACX12Td35wgtS7BBrDwrt5B0LuYwqcmeUR3WPftDupPl29r7H16njcaIoZ0QBSia
         4PPVxb88kI7AYVvPajQMZyP6GMq9oA0XEH45/14PlOtXwgngPZfXnXhx+NkVyOGhC11w
         fqXw==
X-Gm-Message-State: APuU4Z8xC5xzrfQi9CrZC6W/gUccnIMexvk2dzZwIeB8hW6yM0EFQ7Ft
	QrKkIjC2Lc1JJiPiB4T/p/NEXFb9UO8bD3NXpsQXYapIbGVbiQaQRMoUKdu8yg==
X-Gm-Gg: AYBFou0q18sMCjr9PA6j2NzQSBqVOckKq9b7o/BUxLJsg+txanpMLksrOJJK0Y0zTm8
	bblrTCl0PErkPYDIEvUiah/Lz+xkCHjC1jYAIpwMvQqmicXFNDh7H76st79sHfAaJtMnV3sUnWx
	U4jhcFiPrtLJXfhxHiAxlnnaLzegAGVohtRgPsuWCRY8EgYvyrYDhBLldN5umiV+oRpKw7c6nZS
	xGEUelTni4xKq/Mbv3EuQiHZyHmRPIMAlSveZ1CvGcAkWO9yNLpiJ748v8o7c9a+EGJ2kGLGvUQ
	309KmbmiajCvJJafCcUuY/NpwSbExyAhgE7d2bejHcwKt+8/cFww9m2XhZRdeaIpRIRkELsM4vQ
	ZXFXsWxtjUw7WxfM1DTUiaRGUPrHZZo8eBUeINwMwKX2SeykTtRJxs68A7ha9Khl7njZ79LI5hl
	a5NQIvKOt02DmEL1CdktsPnDGrCbOmQMq8remr1PV4/UlVgeOKmqW/8yVQTn49oyA3hn1J8IO0r
	Nz1PMYYGVdxKrh4TZeSDhHcxBEyFsKLQEKXjUI3DdoHOxPJUupjLUS2mAy9N6VAF1U1mJb2erRe
	cJBeGREdvR6IRlhbj/cMlg4EbJZbBxKcZWmZRr5JS2zcpTM9c4De1w/vobv3JMT2pzbzAbEQCFk
	Xl2p8Z5AM1M/XQ0mAuOGnauPsY1ADPFdFhTxuZWQbKMwZQMpM3RmyNMv7vz1P3G7xxvyWUPxJIS
	U7U00=
X-Received: by 2002:a05:6102:1612:b0:7d2:cdcb:6b4a with SMTP id ada2fe7eead31-7d63178e12cmr1214977137.22.1794515613868;
        Thu, 12 Nov 2026 12:33:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/6] bap: Release cached ASEs on ClearConfiguration
Date: Thu, 12 Nov 2026 15:33:26 -0500
Message-ID: <cover.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

An acceptor may keep an ASE in Codec Configured, caching its codec
configuration, once the initiator removes the transport. The initiator
then has no way to get rid of it, as it no longer has a transport to
release.

Release such cached ASEs on ClearConfiguration of an endpoint, and add
endpoint.clear to bluetoothctl to exercise it, with a functional test.

This series is independent of the other two.

v4: Complete the release of a cached ASE once it leaves Releasing, to Idle
    or back to Codec Configured as some servers do, and don't release it
    again while a release is pending.
v3: Reply to ClearConfiguration once the cached ASEs are idle, and
    report a failed release as an error.
v2: Wait for the release of the cached ASEs before replying, validate the
    transport path of endpoint.clear and update the remote PAC of an ASE
    when it is reused (new patch 2/6).

Luiz Augusto von Dentz (6):
  shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
  shared/bap: Update the remote PAC when reusing an ASE
  bap: Release cached ASEs on ClearConfiguration of an endpoint
  client/player: Add endpoint.clear command
  doc/functional-bap: Document clearing a cached configuration
  test: functional: Cover clearing a cached configuration

 client/player.c               |  57 +++++++++++
 doc/bluetoothctl-endpoint.rst |  20 ++++
 doc/functional-bap.rst        |  24 +++++
 profiles/audio/bap.c          | 178 ++++++++++++++++++++++++++++++++--
 src/shared/bap.c              |  32 ++++++
 src/shared/bap.h              |   8 ++
 test/functional/test_bap.py   |  23 +++++
 7 files changed, 333 insertions(+), 9 deletions(-)

-- 
2.56.0

