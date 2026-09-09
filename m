Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C339A4BA
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981801; cv=none; b=KSXICprnz91bPXuGt9MwwJOlpL2QgxbucJaMgELwk6Grswnd3Edh6ILE1f0V+oh4VgW1k13I7wEShMx073MnN4fAnRoPI5FJ/TouXKpGPbfchakWYEBYiFnX7mr79DJ+Mw27XTS+0XlMsye9Bzv8Ph45tut8SFiXKHY4jLNGtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981801; c=relaxed/simple;
	bh=mpijE+HYGuzlnXQK5t3qoPkNkY9Wqv2W4BawCTyVOCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DKoBO8suUylS/YP1nSSyKlZ1U/aLgUFkrHv36H9R6TZC3xv6V/xRwFTXxiboBZZf3OJjq3KGGx8mg2r0KPsWilZH6wRsJPIQqydjld40OSOdmFBrcjbVWfzIeovfdDoyw20SzlVTNDs+Fd1ILb3UxjqhKovjzvD6WfGzhg608uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=old92Jy+; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="old92Jy+"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9809ce25a29so127800241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981798; x=1789586598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gd48TCvNFe8AW0keOUyWHzwV9+A8N4yvCLPXmdusT9A=;
        b=old92Jy+HPvfuxnJzmkzzTdyAbNbZGXF5e3cYMXRxX8Y0eg3pgUqrLTJgdsrjMATkU
         yAxufERGPEC7//3DSe8Ru3cO/aIkCcLEuCAT5m+bD1sc/UDqGslB2Emsex5bY3D9wNG7
         4BZi/oIYzGJD2paR/bnZEYZy0AGnAStdL1Tuuaf7rVTkeaC0cZ2swQXnm4NPy3o2zipB
         u0Kn5I+GDnBM4NL9Vu6DZL168VYmPIivyQCu08VjTC5jKDHW+YpxU+jeB3qjZ1QAotYN
         rCmSd0jykR1Qg/SNHO2QQwKPNMth78E7pNtYxEDCky6ijMsjAfPWZEBuNqRiHlUVhlmc
         ez3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981798; x=1789586598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gd48TCvNFe8AW0keOUyWHzwV9+A8N4yvCLPXmdusT9A=;
        b=S/ARKh9Xb1sLRqprPxuy47ipkXazJLcvocz1hvwaGT0jHSRXsZjgPYUjdArIT8BKox
         McxS32T2+nePT/5o9OCVC23Dac0ayQ5LPqdwOXAvcQ1KrrFMkdx30spZU3WKR8VweoBW
         dxd+IsaECKcvfRhmK2oaPx2QHeCEsZp5wOGillbZKZD8jbS/QDB1H3CpCvXv4TT0zDgC
         yIYxl6nUojPZSODpdyKcNjSoITSdSLGUM/iiuTKjU/HNWFq9wV8qPwsnkqcnFtAq4m3j
         uggC7LSAquoFMzxlclnHvTTSlvryXdY8jW6JIYGMtopf9vCtU11+aqxmVhhj7xqSy04Q
         4hqA==
X-Gm-Message-State: AFuF++mmfaEyypTcix4NvoXHHb9GATTLJ6Wm7Lo3+MFqX31PJ/Hqr9bs
	Fxbc38y8+PONHdN7DDq/w3euVv1T5TjHlulYhkFYvFiZYokIfqJTTg2Yd6YW7oJ1
X-Gm-Gg: AYBFou1QUuvKVNg8v0+h2YYR8216AOGqEoNLGLSH+HymCDzhvAEkAzHRFN8kCrAESSF
	mDmifuV+ovBW7fBGIUWbnbJ8q72TdUTSjRwCjUGXPqPcVqlPiDgJMapYnbmb+Ldi62nyN92mM6M
	4uZ9qNdkRqRekRgshs3OtrBeOGpEHvgFhlkY4m6rsbXSZLg54G61gYMTx1+bBsik8oWrKESOZdx
	X8TjbYmdbkbiBfbMN8KMHRsAwiZXWg2baWRKcTqSbwV1qpK/b8WQsGv0SMVnkZqpQWTOAIlrm9U
	Kt8fJ0b5T1MwW5BvWpHHKdarkdE6G8RJ2v9lxg+aU9PU/XqwmTMyKHwK/JRd6VQnD70UVNI4GmC
	HFqEUKP8pFIhQzMuOGlhG/t1fhAIUUbT/TAYs5b4bwSnfTPxGIVhnvZ/zMk5o/GkTyfLNzloeIh
	iSqhksJOKYr76NNjWcyKvW53F7t9myquaSfosdGmZISFeJmdzn5Kwr3qEY+kIQj5TUUELmY4E5j
	+7nxNQ4JQHtmVat+bfZGbmxSYRue3V2GC7IR4HCW85kEOoiG1NDRVi68hsI3ThmGA==
X-Received: by 2002:a05:6102:a06:b0:78a:4dff:7b3e with SMTP id ada2fe7eead31-790dabbf9dcmr253984137.15.1788981798165;
        Wed, 09 Sep 2026 12:23:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/12] Add functional tests for A2DP and BAP
Date: Wed,  9 Sep 2026 15:22:56 -0400
Message-ID: <20260909192308.1306567-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functional tests for A2DP and BAP, driven through
bluetoothctl, together with the endpoint registration scripts they use
and the documentation describing what each of them does.

The test documentation is reworked to describe every case as setup,
steps, expected outcome and notes, so a test can be reproduced and
reviewed without reading its source, and the reason behind the way it
is written is not lost. The setup of each case includes a topology
diagram showing how many hosts are used and the role each of them
takes. Tests of a profile need more context than the core ones, so they
are documented separately, in doc/functional-<profile>.rst.

The cases added are:

- A2DP: a transport is created on both sides once the stream is
  configured, and the central can acquire it.

- BAP unicast: the initiator configures the remote PAC Sink endpoint,
  a transport is created per audio location, and acquiring all of them
  establishes the CIS. All the transports of a CIG have to be acquired,
  as the CIS are only created once every CIS of the CIG is ready.

- BAP broadcast: a Broadcast Sink scans, syncs to a Broadcast Source
  on its own and acquires a transport, for a plain broadcast and for a
  Public Broadcast Profile one.

- BAP broadcast assistant: a Broadcast Assistant colocated with a
  Broadcast Source shares its own broadcast with a Scan Delegator,
  which syncs using PAST. The topology where the assistant relays a
  source it scanned, which does not use PAST, needs the assistant on a
  third host and can be added later.

Writing the tests exposed two issues, which are fixed here as well:

- Registering an A2DP endpoint prompted for Locations, Supported
  Context, Context, CIG and CIS, which are LE Audio specific and have
  no meaning for A2DP. Answering Locations with a single location also
  pushes an LC3_CHAN_COUNT LTV into the capabilities, corrupting the
  SBC capabilities.

- A Broadcast Sink established a PA sync to read the BASE, closed it,
  and established a new one to sync to the BIG, delaying the start of
  the stream. The sync is now reused, but only while there is nothing
  else to discover, and it is released once another Broadcast Source
  is probed or after a grace timeout.

The broadcast tests also depend on the following kernel fix, without
which the BIS connections are not notified to the listening socket and
the transport acquire never completes:

  Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Note that the broadcast tests are still occasionally slow: the first
LE BIG Create Sync may expire after 20 seconds and only the retry
succeeds, which is being looked at separately.

Luiz Augusto von Dentz (12):
  build: add doc/test-functional.rst to EXTRA_DIST
  doc: describe the functional test cases
  client: do not prompt for LE Audio settings on A2DP endpoints
  client: add A2DP endpoint registration scripts
  test: functional: add A2DP tests
  client: rename media endpoint scripts to include the codec
  client: add BAP endpoint registration scripts
  doc: bluetoothctl: document init script option and scripts
  test: functional: add BAP unicast tests
  test: functional: add BAP broadcast tests
  test: functional: add BAP broadcast assistant test
  bap: reuse the PA sync established to discover a Broadcast Source

 Makefile.am                       |   6 +
 client/player.c                   |  15 +-
 client/scripts/a2dp-sink-sbc.bt   |  19 ++
 client/scripts/a2dp-source-sbc.bt |  24 +++
 client/scripts/bap-sink-lc3.bt    |  32 +++
 client/scripts/bap-source-lc3.bt  |  34 +++
 doc/bluetoothctl.rst              | 105 +++++++++
 doc/functional-a2dp.rst           |  99 +++++++++
 doc/functional-avrcp.rst          |  64 ++++++
 doc/functional-bap.rst            | 290 +++++++++++++++++++++++++
 doc/functional-obex.rst           |  90 ++++++++
 doc/functional-testing.rst        | 340 ++++++++++++++++++++++++++++++
 profiles/audio/bap.c              | 115 +++++++++-
 test/functional/test_a2dp.py      | 144 +++++++++++++
 test/functional/test_bap.py       | 318 ++++++++++++++++++++++++++++
 15 files changed, 1685 insertions(+), 10 deletions(-)
 create mode 100644 client/scripts/a2dp-sink-sbc.bt
 create mode 100644 client/scripts/a2dp-source-sbc.bt
 create mode 100644 client/scripts/bap-sink-lc3.bt
 create mode 100644 client/scripts/bap-source-lc3.bt
 create mode 100644 doc/functional-a2dp.rst
 create mode 100644 doc/functional-avrcp.rst
 create mode 100644 doc/functional-bap.rst
 create mode 100644 doc/functional-obex.rst
 create mode 100644 doc/functional-testing.rst
 create mode 100644 test/functional/test_a2dp.py
 create mode 100644 test/functional/test_bap.py

-- 
2.55.0

