Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395784;
	b=t0rXmc1j8QccYbeD/xQHoYQLp/UT0N2zvLk8R6yeq9M4T2PYK6z87QA8x94hnQo61zPw
	 we7g8OaSf2dGQG8EQnX+wINR825k55wLDODmiCCOhmCV/kRhcb5dcAasM4G02P421i3dV
	 b+zv2Tuxj1TWiOFi1CAMUb106pmeoUZfgkgdFDCIyw2SJAScEkp7A8UAt6Om7xibWx6Wb
	 pjP3N5rvbQSSsThDfX7eDa0XvhSWcbxLolmoBxoPTN03fHdlJZJ4hR+1S/kxD5sAGW6df
	 5XSfhkRCI+FZOIwcWMihcFB0fgiLASicsVbEDTXAy9BLVS+wzH7VsJg3F4Gg/8LT5WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=b+6b6aepV2UAMLhfLgMkchciRwdhFYy9TOYJkHoeXt0=;
	b=xQgOcXXZJt/yjvhEknZQJaYsoiRjEpsUr4VyP0sS/AiO5vz2uN0vekOMqmXiqzYq6WVa
	 UZ8Ff2kaJ58JRST9l7aJnH66XZyqhvKsh6qED4mTxI2Ox3ILyxub8dCz9KUD8kB/2p6eH
	 jGjcUYSP0PvCSJavnSTpAYEFWKSvXjZGwxWSWwtEnsE0u2lEMKLGAUt/vbDUP4uzxrYaa
	 nmpibmuFNYQIgFS8VnS7bWGhv+Ed73sdedn0Y9MvklJdvbBPjEhgT2hQDWWhBboQ9hwno
	 F4IwwKkfQ2vvSQ7S4iFRYKCeoAlNRdgku1enPJ4ddHfKTtv9CwdoJ4U/oJ+pZXSy5Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvgNG9Kn;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777A606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C777A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvgNG9Kn
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso481224e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395783; x=1794000583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+6b6aepV2UAMLhfLgMkchciRwdhFYy9TOYJkHoeXt0=;
        b=EvgNG9Knjfr52dBniR1qoyDXxoMfND1ZPRYWuAunfFolhCUD9mrb8QBJ40DQ29jl7C
         rWRKKkQXqfxh/cHp7WVnUrae1xBLU7oA2WDFSx8YtufM3xJ02my35DYwGOQfps+Zo1yQ
         CJvmyHs4L+53hm4D6ZbqfuVZoGox1hTemwt1Wvb1CVv6bqm3PC735CwXPe6cIXzWu8bS
         iBaSR7nHtxOhQVhKuNlCIXzOFFL2tZV/tao9Ntcur9LfhAe8gL0JY+eitI43aYXPNHWt
         B5p59jgCWl+uRcuXJxbxsvrVmZRrn/uE2vrrRsU+zo0uccUoXeFsIy4tD9GGUQQ3Clxh
         tAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395783; x=1794000583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b+6b6aepV2UAMLhfLgMkchciRwdhFYy9TOYJkHoeXt0=;
        b=C0dCCmgFM91EsDcySq7pPoLbdciNh7Mqyw1UopCYId/dKGEYPKo90Gvv47iAP8G1VX
         3aW7QJ7XiPn1BMwm0Y1GXlQmzebHYP3kKtEnczqnrZM/pA2ICE0JW7yxO1C6vEYdG3wt
         6bPcoyTir3H2yIYY9fhbB77KsWCVH3h8S4X2fRR24N8Kc0VoZfnqTWj906XyJNrFCH0o
         S7FIblCnm1mOAQlawgyg7HoDEbJGPvVP4dtwkr7N2lPec99rJ//MJ8S7uTJDq8AVP7wu
         XN9lXyl8gl/0eZ0XGgD6XQa6rnJaPugBksVpbnIcaK0v+zzDF7IY2hRwvEO/FkrWGEGa
         SkDQ==
X-Gm-Message-State: AFq9FYK0Z0U//AvSWelXJxomGGQHDCg2I8ag1IcrQ8IAmxGE3iQy9L2b
	QiJjSNBPp7kqh9ygL9bNLG0hfZ1Kp7dHHUNbT6s5nZ0PUqiMp6lNsoYHQg6aMg==
X-Gm-Gg: AYBFou3Z0wxsajsZWkeqH+9zVcBXt3w1NRz3kXiiVUACOgzVwfgBRfBLWfgF59BnYEi
	oyA1XCo+BbalY0wbdiy8DVFZ+7xk1o85yaWBaC0t8s+V0Wzzl3n4pVBCvbhMXV4GoUY62qgtehA
	qUJ+cg85AXHXvoOrp9Ex8W8vVAqC64oZ9xwSneVm0HqJnxe+To510rwLfoUr0dF8p2jYZ/2AE9S
	eMzB/Yee9R6QtqPWnRCDSv2qrgLqIcZ7ZP5RDDk27X52+Ps4GRPn0DYxo0Ag86fHtlLZYquAJiu
	6ESFsEwag3pc02hAAophkPxEedyjnpUkn01hTvlddkNfL8roQiqbK6LnKEcZMcG8PqV4N/0XmIy
	gpXZ+vERRbFibjuJ8pndazED2IiVV6LWCYgl38g4NeK6+omz+bifkG4ZkEGP2XMHQKucLyQhFvO
	uv2L/MtJc+kxPcLoHoM5vlKFvDMMao6rnmUGVoa4n3ANhkBzd+/7VVyzKc7aKLJgGWVGjt1GJTP
	0BqkdaLhcag3KfIz4kSaOk3OpQNmGuWCD7f9zGtYIwtJSgTYkdA3KNc8j9d7NZUFzyVLB4upoD1
	2L/f8RLAMogwy+Q0JiQ+UFD+1tDhiEawgSkzm8NGcEtRM/084JIoJFTwjIwgSSqyesSS4rsXIir
	5VrjwYJNumB7SunCfFz/YlL0oZVQwTPGCNThMLXuC52b1K6Pcpir7Dc+Hw6SG7DgVQs0qBHCUpx
	TsalY=
X-Received: by 2002:a05:6122:3a07:b0:5ea:dbae:3cbc with SMTP id 71dfb90a1353d-5ec6897c702mr2169025e0c.19.1793395782619;
        Fri, 30 Oct 2026 14:29:42 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/10] Run test-functional under User Mode Linux
Date: Fri, 30 Oct 2026 17:29:29 -0400
Message-ID: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

This allows running test-functional with User Mode Linux (UML) VM hosts,
e.g. on machines without KVM support, together with pytest-bluezenv:

https://github.com/bluez/pytest-bluezenv/pull/8

test-runner runs UML guests on time travel by default, as the kernel
testers benefit from it, with -R to run on real time, which is what
test-functional uses: with traffic between several guests, lock-step
makes the tests slower, see the measurements in the documentation.

The slower timing of UML exposed races, which are fixed by:

 - adapter: setting Pairable right after an agent registered failed
   with Busy while bondable was being set by bluetoothd itself. This
   is fixed in bluetoothd, replying once the pending change completes
   when it sets the requested value, rather than retrying in the tests.
 - test_bap: transports were acquired or selected before bluetoothctl
   had them configured on its endpoint.
 - shared/mcp: commands sent before the Media Control Point Opcodes
   Supported was read were dropped while the D-Bus call succeeded.
 - a2dp, adapter: when the remote reconnects before the disconnection
   of the previous link is processed, the new AVDTP connection was taken
   for a transport channel of the stale session and refused, or its
   service authorization was cancelled by the stale disconnection. A
   new test reproduces it by stopping bluetoothd across the reconnection.

With these, make check-functional with 4 workers takes about 100-140 s
under UML (68 s with KVM on the same machine). Remaining intermittent
failures under UML:

 - test_bass_past_*_transport_acquire, addressed by the pending "bass:
   wait for PAST listener readiness".
 - test_hog[sci], reading the HID SCI Information characteristic returns
   00, not investigated yet.

Luiz Augusto von Dentz (10):
  tools/test-runner: Default to time travel with User Mode Linux
  tools/test-runner: Unbind virtio devices before powering off UML
  emulator: Answer the time of a guest with a skew
  adapter: Don't return Busy when a pending change sets the same value
  test: functional: wait for BAP transports to be configured
  shared/mcp: Don't drop commands before supported opcodes are read
  doc/test-functional: Document User Mode Linux VM hosts
  a2dp: Fix refusing the AVDTP connection of a new link
  adapter: Don't cancel requests of a new link on stale disconnection
  test: Cover A2DP reconnection with a pending disconnection

 doc/functional-a2dp.rst      |  32 +++++++++
 doc/test-functional.rst      |  74 +++++++++++++++++++--
 doc/test-runner.rst          |  23 ++++---
 emulator/timetravel.c        |   8 ++-
 profiles/audio/a2dp.c        |   7 ++
 profiles/audio/avdtp.c       |  24 +++++++
 profiles/audio/avdtp.h       |   1 +
 profiles/audio/mcp.c         |  10 +--
 src/adapter.c                | 123 +++++++++++++++++++++++++++++++++--
 src/shared/mcp.c             |   8 ++-
 test/functional/test_a2dp.py |  36 ++++++++++
 test/functional/test_bap.py  |  22 ++++---
 tools/test-runner.c          |  72 +++++++++++++++++---
 13 files changed, 396 insertions(+), 44 deletions(-)

-- 
2.56.0

