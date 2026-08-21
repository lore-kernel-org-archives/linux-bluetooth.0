Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D684248DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328519; cv=none; b=hJhFIyP3xc2zdzzzKbzJ2DvJITuQEjqk/9CqX12kLOdECOCc9wDI+seVSgSJNtxLppnk7H1rzMqOzc86OpJiLitOm2uDGUb4U/B8JmtSihlY64dnVrFWhWa2+d94VoDulQCOYU7yYpDg3YfVkvYRRTYCNRcHgOQFnM8TsG+Wr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328519; c=relaxed/simple;
	bh=gSExp73Zopg8TcSFO2CepVlOJAByF0WeIM+aF5dAdng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DloJyDfGTc2e01B63rHlallI8sr1fgP7dR5klM8RnZBM1nkstmzKn/TltRJOYiB0a4DcxjPK/A7liHjcefz8jYC9tj3z4xXQYlojofFTtp23mkg4jtIMBYLoWvk8iYNaX9bluKjVpAR2uJl9sdxSyhPmZFgngd1QeZgPWdVfQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=nUynbZdR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="nUynbZdR"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c214321dc32so235472866b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787328514; x=1787933314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yii/2D6B2izXWekChp05wRrSbczz6Eo9W3sbbU7mwyo=;
        b=nUynbZdRQ0zl+HHlaM6ERPHaegB+aWGzKFW3avBETV3Vfbx+HemEbrXcQcUi/fxIJn
         ZavmEAPnquwNKfXKteozizWU0MwqtC/qZQJtCuT+8pKd6hbnBngZOjDo8FV3Y6P/8a8l
         DcktAoD3hX3hDpqZsBsJMph3P01qdZvUReoQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328514; x=1787933314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yii/2D6B2izXWekChp05wRrSbczz6Eo9W3sbbU7mwyo=;
        b=htViUcAgwO0/daY76bDqnQ29Rgl/txZNHr2P2/2S52UZ5ZRz/r8IVI11GX/JR48ViG
         8KQmn3m/L3o3fjSVQ2t6aqKR9I9EvGR3TG5ppJzE3BgmFNFjRAkizvPCpfw0md4ToV9o
         VHYoF8UOPiMphSnUok2IXGRhNlnFnQT9TAFduxRdfcHa4EsyuEEyjp7030typw6iml6j
         QbSpwpp87zqF3c/pa6xulW8UMuNX5NF/HNRpjNwwXqRfiGx3Qvs0qa9Dsv+R6LHOXLly
         +WK8V/mE3/of6CXsgwH7GH1OyjhTZ3dmX+v3jwAbL8HrGLRcqtaVvziM/NVmS9/392AK
         Rstg==
X-Gm-Message-State: AFuF++lfWdb9LTJZ+5gFLRDfQugLyYE0B9KOePITmmRsOWx2/nWjEDVU
	R36gWpLwnaS5+vm6yr5QeCLSnQ4FsDtl9AV+GWPNwik1O/mrS0II5+x7myrlfXK61e18sbDC5iV
	SBKKkW6Q=
X-Gm-Gg: AR+sD13CBpITa3KM0H9SksVd+k4qEQe1t73EdBRLSHVI8BB+8fVd9Uv60seyq2jLuPo
	9CItn+2/zBts9eBSlWNA//UDIhCWOvU8lqoOMXqYNKXDRfOZ4j22gco9n5xtprxFb23XIkI+NtU
	/rE4t/OAaU4B7RUY0WBTgOI3PkUJbMisCeCzCxQl4XT4JyBfZbld3PkXTAvJtYMSQkQB9m0PmW1
	6T2OwTeYZBepWzM/TrsgGW+A1iPKpXnGVgHC/Y1ibPL0NvnNRjgPxwoKA8zSJjFOTfPBrCSS0Tt
	+czjA0Bx5p6cRsezgiyxFsitJsJ/4HMBvtwKXHANKeXzPFXGSy9zG52ZCEGrxe2mA/l+6/2Pcoe
	YoNKN3RkUi+BbzCwlYfo6kzLU3GPRRkPEv/2BPbJ5s6Rg145KszSCwixvJERinuO5ceBNLX0Jnb
	kiTj5mlXT2QAyclurWU++nUvrQwlAXBZaOxD2Vu5J+cNHxv6gQnolUoe9DO+ncH/4onQ78wH+M5
	8+y+uQIJ+95Bzk1A/wRAPcwQjOBQov9ITilAIKK7Vi2lQaS4rkTQZ3z3SOJCexQ++YYRWb4CLWL
	Y6DrRrhfecZDujq4xGc1XU8v13RauFDBZacpYTxlEsUu+PY2f/+HqDzQwj1SfrZfcrJLMhvgUMz
	yrA9kuxU1rHscM/hfJZIJdG/IUljBYvQfAInV
X-Received: by 2002:a17:907:97d5:b0:c19:45df:1856 with SMTP id a640c23a62f3a-c246a675873mr707144166b.17.1787328514056;
        Fri, 21 Aug 2026 09:08:34 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df29esm471299366b.47.2026.08.21.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:08:33 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair Message Stream
Date: Fri, 21 Aug 2026 18:07:59 +0200
Message-ID: <cover.1787327795.git.m.kurz@irregular.at>
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

Add an experimental Fast Pair Message Stream profile. The Message Stream
specification defines both a fixed endpoint UUID over RFCOMM and an L2CAP PSM
transport:

https://developers.google.com/nearby/fast-pair/specifications/extensions/messagestream

This series implements the RFCOMM variant. Pixel Buds Pro advertise the fixed
UUID in SDP, from which the profile obtains the RFCOMM channel. L2CAP Message
Stream support is left for future work.

The Device Information extension defines battery update message group 0x03,
code 0x03, with three component bytes using the Battery Notification
encoding:

https://developers.google.com/nearby/fast-pair/specifications/extensions/deviceinformation
https://developers.google.com/nearby/fast-pair/specifications/extensions/batterynotification

The generic unknown-level status bit is retained for earbuds. The
TWS-specific unsupported-case value 0xff is treated as unavailable:

https://developers.google.com/nearby/fast-pair/specifications/devicefeaturerequirement/devicefeaturerequirement_hearables

If the Message Stream closes while BR/EDR remains connected, invalidate the
values and reconnect with exponential backoff. Reset the backoff only after
a battery-producing stream remains connected for the maximum backoff
interval, and do not retry permanent local errors. Once BR/EDR disappears,
cancel pending work and remove the component objects. The final patch adds a
standalone diagnostic and provider tool for interoperability testing.

Existing UPower versions continue to consume the aggregate Battery1 object.
When experimental BlueZ is enabled, they may log a coldplug warning for a
child object and ignore it because they expect Device1 at the same path. The
aggregate remains available, so the currently displayed value is preserved.

UPower support for component objects, including python-dbusmock integration
tests, is available here:

https://gitlab.freedesktop.org/mkurz/upower/-/commits/fastpair-multi-battery

It is based on:

https://gitlab.freedesktop.org/upower/upower/-/merge_requests/337

With the Bluetooth address anonymised, the object hierarchy observed with
Pixel Buds Pro was:

  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_left
  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_right
  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_case

Each child implements org.bluez.Battery1. GetAll returned:

  battery_left:
    Percentage = 92
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "left"
    Charging = false

  battery_right:
    Percentage = 90
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "right"
    Charging = false

  battery_case:
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "case"
    Charging = false

Percentage was absent from the case object because its reported level was
unknown. This layout can be reproduced with python-dbusmock.

The complete path was tested through patched BlueZ, UPower, Solid,
PowerDevil, BlueZQt and BlueDevil. KDE Plasma's Power & Battery applet
displayed separate left, right and case batteries, including an unknown case
level, and the Bluetooth applet displayed all three components. Related KDE
changes are:

https://invent.kde.org/frameworks/solid/-/merge_requests/264
https://invent.kde.org/plasma/powerdevil/-/merge_requests/666

The series was tested with Pixel Buds Pro using an ASan/UBSan build. The live
tests covered fresh left/right/case reports, an unavailable case value,
explicit Message Stream disconnection, remote device disconnection,
reconnection, adapter power-down, and cancellation of a profile connection
in progress. Component properties were invalidated or removed as
appropriate, and the daemon reported no sanitizer failure.

The full 40-test make check suite passes under ASan/UBSan. The seven Fast
Pair parser tests provide 100% line coverage (55/55) and 95.83%
branch-direction coverage (46/48) for message-stream.c. They cover complete,
fragmented, coalesced/partial, zero-length and maximum-length frames, invalid
input, unknown-level status bits, the unavailable-case sentinel, and
reserved battery values.

Changes in v2:
- Clarify the RFCOMM transport and cite the protocol sources.
- Gate component objects and properties behind experimental mode.
- Document opaque component paths and the provider properties separately.
- Replace Message Stream magic numbers with shared named constants.
- Correct unknown-level and TWS unsupported-case decoding.
- Invalidate stale values and make disconnect handling reliable with
  dual-mode devices.
- Add reconnect backoff, permanent-error handling, and safe pending-connect
  cancellation.
- Improve the diagnostic provider's ObjectManager lifecycle and isolate it
  per adapter.
- Expand parser tests and record their coverage in doc/test-coverage.txt.

v1:
https://lore.kernel.org/r/20260819223144.82045-1-m.kurz@irregular.at

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
 doc/test-coverage.txt              |   3 +-
 profiles/fastpair/fastpair.c       | 650 +++++++++++++++++++++++++++++
 profiles/fastpair/message-stream.c | 135 ++++++
 profiles/fastpair/message-stream.h |  58 +++
 src/battery.c                      | 401 +++++++++++++++---
 src/battery.h                      |   4 +
 test/test-fastpair                 | 568 +++++++++++++++++++++++++
 unit/test-fastpair.c               | 322 ++++++++++++++
 14 files changed, 2146 insertions(+), 62 deletions(-)
 create mode 100644 profiles/fastpair/fastpair.c
 create mode 100644 profiles/fastpair/message-stream.c
 create mode 100644 profiles/fastpair/message-stream.h
 create mode 100755 test/test-fastpair
 create mode 100644 unit/test-fastpair.c


base-commit: c73fa2f9ae2d366cb8a4f101fa9a5ccd9f33a4ea
-- 
2.55.0
