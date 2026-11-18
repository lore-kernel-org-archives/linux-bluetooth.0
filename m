Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031929;
	b=oM+IlhPo2DK6u1guK1g25CQx1+lPTNyWSp1xx1LrtzXXd9hCJtPohFBZnO8AD8AXZZ87
	 wfvLqv14jYcwNPa+RMBuHVhb50elF+emA2c0mHeTfxwj3jz9YR3c/k6PgwlLJz8bLfn4V
	 WhRfFHEGcP9y5514ekshKbihhXMY+I5+XzoRdXp4XAZsuykPY8R9wbbhgdNW2/6+JuMZ6
	 Diaxtb9lCOSp1YDkGhmXAab5zf4XL+yB9ROXEYoQRdY5YgcERG5J7B6K3kaXnYez42xnv
	 fXkneLuWfMMQm0ffQCQrmwGeTOyAhX2D2fUMy6eFikI8kJcqbzm/dIfVgDKaus2vcpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GqZ1d5nDfALsXlz+rP3o48YSjnCnfwpTy1zQyKTRuZ8=;
	b=pUbYMp+kOmgFv165YEZEcscLI7MlOrNEDU+yVrMfE8biNfxtH5OtiNhuUAFFPW6jJUma
	 TWj5R3ozN5Xtciob2qlyG92VoXKp2xOBNu9K2befv4HitT0Q0OP9+JDm8M8AsSOx5xEUx
	 JPTAblCIIldXtRMOTwhDdqraE9RNGD5Ko/dLJp+ppQHNtqy8aAnC3TgCOLZhpuLotcucS
	 DCNzMAM9v5nZTOWpc29F/5KUwjp0tobCM0q9J4rhazBq0TFHsmbYxTAj0VzFbGOcWej+v
	 GV97xMD32bFpxSiRCUBkEJPDwzhFetmZSneNgJcbwMHdfL44rjC9lMhYXYbFWtoAxWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABL5xGZ0;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C52606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C52606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABL5xGZ0
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc81984fceso572850137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031928; x=1795636728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqZ1d5nDfALsXlz+rP3o48YSjnCnfwpTy1zQyKTRuZ8=;
        b=ABL5xGZ0h/3ppr6bsSiq1rshdOeDWOa+nDERVLy7AuXD359Fq9yjBuQhtrW7Zx/6O1
         ylGbSMYxHp8SMq70oWzZv2awCQ9Pie2/KwjOQHTUJgbh+Vv660EgA0yO9YUScPdhThJL
         DDL/6KabYrSwF+7eMR/gTium5Ai9U1V58g88RhXk3CHgoSiAuiBrRvBQzVEoALP7cgaU
         XLQ/7pjQNyM/a99dtb3cM1gd1b61L6WeDfeglVBSX9t2V3Sb763Yy5kh/pDi2IShqUKF
         r8Mqe27lj2g8GphMyis59bBvCiUxQe4cTcc2EvrmuUoV/PvMJS3ugTFMyLHDq41/rTTp
         Jnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031928; x=1795636728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GqZ1d5nDfALsXlz+rP3o48YSjnCnfwpTy1zQyKTRuZ8=;
        b=rHCPH5L3g7HbrPLpJI0jhUNBvnczedvElko5lkfCidUgmLq2SbG9glcMjFRP3Qvyk8
         D7VrkIojLubmtmdnObDvzB1COIzmRUeS4ltLcK4ydHaDm+APHqveNlXJotJa/tmQmGh9
         762LFFR2N5yqzLbiPXQazVp+MdIMjLQ6LBbk0Pt5pjGkWLrP84U8rfT+bj1SrULeNErK
         l7kRkaf2XjHWo+B9E+pDH25hnwaxjMG+B+nj7Fy3I60EhtjRywlF8CsWqEd3yAmpUbg1
         UdPtRvYzOVdRpEGu2WVuxffRSkCU/G5r5kD8aZF1+kyEv7faAkL3DlDa70zwqW8eTWdo
         mxAw==
X-Gm-Message-State: APuU4Z8/zEl4D3H0jchHXR+C6vgFZJzuyRdDn3eI/loiv+VZhm/n7j0G
	B7q5AUBGESuj3td9nxkTxkbBSfmuCL86INnMyALD9WkHtuu/kZ81l264vHaRAs5A
X-Gm-Gg: AYBFou2FrwsXkE7ycbo2Nep7v8AvTye4FMc/3M4BoiyT8/4oB22lQCXY8y8ztZOi+hI
	WxH/kDNQaTnwDptGPn3E/VxZlFbTWm7rNXYaRkf+ZlCDS4UNf74qjsoenB0Bc5WTILm7iOnSm0l
	58zFPTg7FXMw5TK2mPsELir4aY97aEJLsrBAjpdqxg57qVZBqGhAMJIHIc56uQj99kwt7c+b6ST
	QDgWpaNXb1HT27zwxWRRPAAhC8LHjCi5tU7mGXLiqDZtQ1dVOKOxbXzgiRVA7r8TT+htNfPkfO3
	TgC0YMgMP2718oYXVi3klF5yFJRocGCfoaXeTmy4VJ6tefoOgBp/xgIvHBanS09uK5K4yHybiXj
	7SCkni4p/IkA2zyHNRGTpYlFOlPy2yF47MpIbYGwvlvKupYPsgmA/1EWqgy9wiB8Fb42ZggbBt4
	RQYVmNukKN39BKhNu8OOV2u7FqVRl2eMl5A/4nbeBgv7eLg/jFTdPP98bBZYeo4KoqcSJeN2tTY
	rrepWa15ThCryZokvUy+7oA4bHn507e7yOH9NHIR2uDecDMMen6bEOrdIZ/zJQrn1LbjMSAJJv/
	XqRpxYRjKjPwHQZOYcszCSdEqFYGkL052LxoG7Sjsa/euabwfpBroTSjJ+guElPJXPhMLmCzu2x
	kkzbyn1spGklXpF15np9EHLVfIRvPxhoQbMKAyzyzTs7FMFHVj6NpBr1zDvP35z16X1CkySiqGg
	zLnY0=
X-Received: by 2002:a05:6102:6f07:b0:7c8:1fd5:82b5 with SMTP id ada2fe7eead31-7d6ba404626mr1085081137.14.1795031928013;
        Wed, 18 Nov 2026 11:58:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 00/16] Channel Sounding and RAP fixes
Date: Wed, 18 Nov 2026 14:58:28 -0500
Message-ID: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

This series fixes the Ranging Profile Requester and Reflector setup
and RAS server issues found while running the RAP and RAS PTS tests
(Channel Sounding with a Reflector, peer-created configurations,
Ranging Data subscriptions, per-connection Ranging Counters), plus a
GATT database CCC state leak and a use-after-free in bluetoothctl.

v2:
- gatt-database: clear the cached state of both bearers of a dual-mode
  device when it is removed.
- shared/rap: keep the Ranging Data Ready and Overwritten counters per
  connection instead of resetting the adapter-wide state on detach.
- profiles/ranging: exclude armed Reflector sessions from the Active
  property.
- profiles/ranging: ignore Remote Supported Capabilities of unmapped
  handles, so one link cannot overwrite another's antenna limits.
- profiles/ranging: enter CS_STATE_INIT before the asynchronous
  capability reads, so a peer-created configuration is not rewound.
- unit/test-rap: add tests for the Requester Ranging Data subscriptions,
  the Real-time timeout and the per-connection counters.

Cheng Jiang (15):
  gatt-database: Drop stale device state for removed bonds
  shared/rap: Reset the readable Ranging Counters per connection
  shared/rap: Subscribe on-demand data with the requested transport
  shared/rap: Subscribe to Ranging Data when a measurement starts
  client/cs: Fix use-after-free in stop_measurement_reply
  shared/hci: Look up the connection handle on the right link
  profiles/ranging: Let the Reflector run the CS setup phase
  profiles/ranging: Let StartMeasurement() pick the Initiator for Both
  profiles/ranging: Take the CS role from Config Complete
  profiles/ranging: Act on a CS configuration created by the peer
  profiles/ranging: Keep a peer-driven setup from being rewound
  profiles/ranging: Defer CS Security Enable until the link is encrypted
  profiles/ranging: Choose the CS antenna configuration from both ends
  profiles/ranging: Do not start a procedure after StopMeasurement()
  shared/rap: Start the Real-time timeout when the procedure starts

Luiz Augusto von Dentz (1):
  unit/test-rap: Add tests for Ranging Data subscription and counters

 client/cs.c                        |  40 ++-
 doc/org.bluez.ChannelSounding1.rst |  21 +-
 lib/bluetooth/hci.h                |   1 +
 profiles/ranging/rap.c             |  28 +-
 profiles/ranging/rap_hci.c         | 431 +++++++++++++++++++-----
 src/device.c                       |   3 +
 src/gatt-database.c                |  30 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   |  98 ++++--
 src/shared/rap.h                   |   6 +-
 tools/hcitool.c                    |   3 -
 unit/test-rap.c                    | 507 ++++++++++++++++++++++++++---
 14 files changed, 985 insertions(+), 199 deletions(-)

-- 
2.56.0

