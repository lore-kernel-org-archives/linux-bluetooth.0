Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819753DA7D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178733; cv=none; b=oZvBfezpHlWfqn1qdP/LETtqT9DylNOxYq7ozLfTlnn5/irQzDPTqFcKekRp1Nk9It88FGienP41wIUJGdReGrO+aR106/tew08QWoH9dpjCLC5Rm3c6s6qUtrXzN3f22hLu5bJygqUnsViDsNOhwdoay7nOBjXMgSHrZu69Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178733; c=relaxed/simple;
	bh=Sm6KYP1RMv+SNudO1YR/PsVBRoah1UmCzFKXNamzIP8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Izom9lnlP26AN6Upg2McZpt/CsowvVqnXazSGzLc0FTUBfbFFjbebk+7NO9pW1mHKIadyDmD45sXoY5BbfoxVX4DorPigjiC3vKYE2YYJWRKBWRPet69dCKtBfM45s+Xo8TnS91kMTFJBkTHJ4gZen9i8h2i7WeSeI71L/8Xk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=AWzwSbhW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="AWzwSbhW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-480001972b8so557066f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787178726; x=1787783526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Mbn2+XTIJhfftu50hMFefzdBcSWUxs31ctI/K25zt4=;
        b=AWzwSbhW0XQ0hObvc+XBPeDSDkK0iRI7QMJs4S1AyRWfjAN7am2dLmQZpgMhOnVsED
         GvyVnCZGvhb304cBdlcHMfCGbs5fCkxhp4Y8waud18kXUZ1VaYlkbg/owrehUQSDYrWB
         E7lyOUSNxShA8YmWiyyVPy2mvKfnawhKsuF4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178726; x=1787783526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Mbn2+XTIJhfftu50hMFefzdBcSWUxs31ctI/K25zt4=;
        b=HQNkkkMc5d05cv1VUMMnJcxSuCxu6HzcPsMWQlMev8DHhencqwe1/yaT/k8ETZ0agI
         rE64sG/mdIrXy66AXH2qfsvqCC5yBzfWkddlkg1kHPEb1ddAx1ZWOPGHg9AcXeT72Ze2
         Z6Rg7skdKe+8MWE2VvL2ak9/6Ms/D0kbkMzSvDpjaGKNHmIFLl/aEYZPWNasKXEBVPwl
         8XhthXc4HzUaGeAqx4R7Oh0PoVgrc9Fq2ZyPUjVROy1H3VHas4DLBmkBludfno0Owc7P
         cRc3PfbbbSMUHGggN5FgTGYeR0ZHaeZcrz3lwJ4YFdsoEOn+2kOrn+wLoQBqw/lWLLsH
         46Qg==
X-Gm-Message-State: AFuF++lH521wGM4gfPx+wGTCD2XmunjVgVEbcUzckKbG3zY2hkiFVtb1
	CcqvvpR64WfDx5bKUNBKD35PNjLjS3lQnh+7J65INF7O+75hFyWB/iFnizEru+mOWIkSp4adonP
	eIckLx1Y=
X-Gm-Gg: AR+sD11lTIis/p7/CDmHHxuZUVCzndnVOjmbdyzHCoheB6TBC7StTMloKL8+MkkoDG8
	qjgcMPL9gAaoJv98lC4rAHcRby7ujB9zZdKPY6oAxeH7FMVX0tXGw1XrGOWNxni3nTt9PmCTr7K
	p7NMP6jupp/mvjXv/nh6xwTxJfLMlmKzGThV/XroMDI8AI205Z3Y2QZUiB90imsXofvuN7TXHk3
	MJCcb8uCaJ6WRmHJn6wgKFK6Q3f/r98rGkAChHjCE22Rr7OXPE6quLaoqv1Swg8dRIfNPiqAtaQ
	3Iznm2zEblbcm+EDPlk2VtE/zEVaWK9q83LxFSFBsTVaoObxjxUNrs0BxtUaiARtpYJFjV0C9pZ
	USzfr8qvmo51P5pa7qLLTBPZ+GunIpwk7Q46+fV7Mt85dclORG6L07qRswSQvfErXOeZZuWNYjl
	LMZW3u3k/Cd1l3ZI/KUVIZBbfockEIZnKdgFC6AMWXW0G42p2FvdBfVnSugHkWKAxjWw4mNfHag
	SsyeSRuz+xFh9S+MTvRYoJ5e/SqiUtalidAOjuy/6ON/aHE2qSEja8l1vgibFIIurg+K5Aazjdw
	jhVvLf3ZNisjEn10hbVJQXE1Stbf0qGSCuC2MKfoYL5AgQH00/SkOIvxIipw8TYdakqKo2eRfHw
	Aut7d8aKEt4EvucOJ9Nm2G52/ZbCF49GIEE6dWoI19xuLbdWy
X-Received: by 2002:a05:6000:2303:b0:47f:f339:556c with SMTP id ffacd0b85a97d-482b1e84742mr12873201f8f.2.1787178726071;
        Wed, 19 Aug 2026 15:32:06 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14cf0a3sm8125296f8f.32.2026.08.19.15.32.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:32:05 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] Add component batteries and Fast Pair Message Stream
Date: Thu, 20 Aug 2026 00:31:40 +0200
Message-ID: <20260819223144.82045-1-m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

True wireless earbuds can report separate charge states for the left bud,
right bud, and charging case. Battery1 currently has one fixed object per
Device1, so BlueZ cannot expose those values without collapsing them into
one percentage.

Extend the battery core and provider API to support child Battery1 objects
with a stable identifier, optional percentage, and optional charging state.
The existing Battery1 object at the Device1 path remains the aggregate
compatibility interface. Component objects and their new properties remain
experimental.

Add an experimental Fast Pair Message Stream profile which connects to the
advertised RFCOMM service and publishes its left, right, and case battery
updates through the new component objects. The generic unknown-level status
bit is retained for earbuds. Treat the TWS-specific case value 0xff as
unavailable.

If the Message Stream closes while BR/EDR remains connected, invalidate the
values and reconnect with exponential backoff. Reset the backoff only after
a battery-producing stream remains connected for the maximum backoff
interval, and do not retry permanent local errors. Once BR/EDR disappears,
cancel pending work and remove the component objects. The final patch adds
a standalone diagnostic and provider tool for interoperability testing.

This was tested with Pixel Buds Pro using an ASan/UBSan build. The live
tests covered fresh left/right/case reports, an unavailable case value,
explicit Message Stream disconnection, remote device disconnection,
reconnection, adapter power-down, and cancellation of a profile connection
in progress. Component properties were invalidated or removed as
appropriate, and the daemon reported no sanitizer failure.

The full 40-test make check suite passes under ASan/UBSan. The Fast Pair
parser tests cover payload fragmentation, a complete frame followed by a
partial frame, invalid input, a zero-length frame, the maximum 65535-byte
payload, unknown-level status bits, the unavailable-case sentinel, and
reserved battery values. The Python tool compiles and its matching decoder
was checked directly.

Matthias Kurz (4):
  battery: Add component battery objects
  doc: Document component battery objects
  fastpair: Add Message Stream battery profile
  test: Add Fast Pair Message Stream tool

 .gitignore                         |   1 +
 Makefile.am                        |   8 +
 Makefile.plugins                   |   5 +
 Makefile.tools                     |   2 +-
 doc/org.bluez.Battery.rst          |  35 +-
 doc/org.bluez.BatteryProvider.rst  |  16 +
 profiles/fastpair/fastpair.c       | 650 +++++++++++++++++++++++++++++
 profiles/fastpair/message-stream.c | 129 ++++++
 profiles/fastpair/message-stream.h |  42 ++
 src/battery.c                      | 401 +++++++++++++++---
 src/battery.h                      |   4 +
 test/test-fastpair                 | 561 +++++++++++++++++++++++++
 unit/test-fastpair.c               | 286 +++++++++++++
 13 files changed, 2079 insertions(+), 61 deletions(-)
 create mode 100644 profiles/fastpair/fastpair.c
 create mode 100644 profiles/fastpair/message-stream.c
 create mode 100644 profiles/fastpair/message-stream.h
 create mode 100755 test/test-fastpair
 create mode 100644 unit/test-fastpair.c

-- 
2.55.0
