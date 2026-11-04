Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817410;
	b=FzPUowQgIdSLgt9gmwLN0HBPFj11u2XcKUBzUmGizOvKIH8ciFa6fN5f6y2mD7JdZbCU
	 lpbaSvVUTHpT6T8CsFGLlp9Qi0R+2tnqH6y0K2c8fjoSpGHfwgKVyhmQuY+AtzbH5xKSX
	 eXAQxiwvNgh3ySMHYigkvH7gfac1OnmcC+kFkQvVnzJ1RVqNb3Rq7MHAQeuthtI21ICJ9
	 aL1S46HRsmLELG/HKlpj3yLN5Dc9N+Yl6yimYi2KC+S50SDR0poMAjWXg+ezKPVbgbdag
	 dMrJm79Kb0TK51avx3tCiNftkGfdD7sACACipj4qLUYnbX1zwcZkQ+XXinw2YY0svLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bjSoF+cxrjovlg8gSTTgzcf6IXH/kpKK9/cndLbhP+o=;
	b=kiTbvJLlWfOqoFiV1PVVEnLRr/fyy+rq6gnF9hIJ/Z7RQQA7RdnZ5Q69IFhNGbV0Dz0J
	 KAHTYJ3pCu0ZkfQ9Dj9/L5WwFTti6KvlEoUlgnjl1+G+xiMG14xFtpZ1eQgZ2iZazTP3d
	 /tdsZwCej3/C/a/Z+9gN0gdvENI0tNoXfVyuZ1zaPZUaQmBJZ3o/NXMCzT27B00gF8n5M
	 5c3j92xKuzB6yLkXsMTmI/adIGuVrUhf9hZGC4MBcav98MWM1GiwLspLhIIIELdnTuzgg
	 VMZmGUtDfDcz2ywepA+DUWR13dKOZr0LkHAoYLPkDp9WX3CKbUsINxyu8T96S0ruhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTVZ0DI2;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618F606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4618F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTVZ0DI2
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c3b75caad1so662922137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817409; x=1794422209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjSoF+cxrjovlg8gSTTgzcf6IXH/kpKK9/cndLbhP+o=;
        b=MTVZ0DI2T67RRKIsotr8E1FP1thRAzZA2YaEYVIAo5ksDtjKR9+f6QilMM64B4+qun
         pmQHilQONOQyqtwpnfUZ8am9t09tk8bLc2RBGyp4nwqvJFAXbupFUSv3s3/7Tpf1+kQR
         uIFokPKawxHc2t5/z6mRCvXrS1Jpf+U6FYybk8Pgir5+/USpuLxivfZeayIvpOYCi1qk
         qjD3EbcN2Cm0iw/TnO+3kqeQhmhUdjLslUkGYgOyNMqpu9hvtOMpMcyBGazGcCk7vTey
         mDJQccY0py1+QrcjiWNEjY4Bi5IUQ+zxZ4NdyORM3QpkI10Z6hNu3HHsfqqSX33CKMUt
         z0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817409; x=1794422209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bjSoF+cxrjovlg8gSTTgzcf6IXH/kpKK9/cndLbhP+o=;
        b=x8OG1nG9mCw+yxAVd1pONSFXdPqan88lX1QROESBT6dR8nlWRIQksLRk7+tzjFuGOJ
         QmwCqJPbGbv1o/eBINeKBGMxYpwm/kju3tMzpAPhpq2Xg+vY9dN2acGMdDsbbC5XuzQV
         fe8sTwy5HoXlcj3eqMdNR1mvXvRdbq1obOgbtJ+HfFAUamaygP3Ez6WxYHkOIVlBW5ti
         z0huBmC928SVMdOf+XkfcsvnHpoZ3AJV6LubeTJidTVVGlF3iMUs/KraGgiile7Aqh5m
         VHIRVWCbBOz6LRyU6RfsJTn3H1Itvo4awPqSvpEkh380huf0RuDKsR5HDCMPGT5IQWsj
         IkfQ==
X-Gm-Message-State: APuU4Z8Lz0kpu0n77gd0LHmEbDOuqbppj6SZjc1EXRK20NeYbqRxkI9z
	/Kspff+jbcGkp+2snvf1ANmDPi8wHb1122bb8XFGbycJd4wS2FGBgw/itwGXgQ==
X-Gm-Gg: AYBFou2y4rS08m1z2W4Le9/+IZ09ag3RSbeW5kcRFmYCydJ8wDHwAKURnX2m8AN6gIw
	ufnJjHPWJ2HgWW63R0BKyj0F8q720pTKCqh2KIOdQT1vfI5jyTQV6SBnxVoyCZIsZ2jPw9kURBr
	llqG1iYo8if4Ob9GbB9tzmu8z5g60aZsfRsAjO7tEJVdsEBqD14e61ZTdaXo+MCQxFGbXeDQolV
	Yvrd+Z9U/rCsiPpq6vp2gvTjwqU6Kn6+iwmrCjExz+wJUZdKPQ8p/lhwFozN1ImhDdDOILFQB0p
	5dX2Yq1C4z44ArzQhxp7MepZ/MB0HNwTWTT69lQ0GwjmyuCA7QykNq+nSp7gdROxWTi7P1akGPd
	ESbcY76URlP2zLu9qC86CG3N22q+QckZsLrgJivLYnMm5ItnDOIcF7sJPuqVtUAyqaqXw/3fS4t
	QeEgO5msHxzsDE73qcfsz3q+STAsFrrgQq2PGBMJfO+BLByhKBUXO2VMIa0575o8pifsrQmEiDj
	JOnW5tO+RtkrRShDJL+ZaKmx/8JTKqceUmJ/TyvmD4NOJAbjbDFSmsWIlC1g+WcmSuY0t0AFoNI
	qX7wCLJJCIswXqjGCdls6bJGSi/LHXO4x+oMyJn+CBJ1jt9GWzLULd+nJsSybGqlkFSj1BV+KtG
	a6QYW08eIwN1mIwk/JR1AOPLcW3rHkfMFBHpts+c+zqUxmXQ+VDGhQLe2v8x8BmT6sLC5s1HZDo
	4R06c=
X-Received: by 2002:a05:6102:358d:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7d072d5e4a4mr8527476137.36.1793817408873;
        Wed, 04 Nov 2026 10:36:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/9] Add support for HDT and EKS
Date: Wed,  4 Nov 2026 13:36:35 -0500
Message-ID: <20261104183647.839090-1-luiz.dentz@gmail.com>
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

This adds support for the LE High Data Throughput (HDT) PHY and the
Encryption Key Schedule (EKS) introduced in Bluetooth Core 7.0:
definitions, btmon HCI and LL decoding, btdev/bthost emulation, GATT
MIC length permissions, main.conf options, tests in l2cap-tester,
iso-tester and mgmt-tester, and l2test options.

Changes in v2:
 - Remove the values from drafts of the specification and use the ones
   from Core 7.0:
   - ATT MIC Length Too Short is 0x14; L2CAP results are 0x000C (LE
     Credit Based) and 0x0010 (Enhanced Credit Based); the HCI error
     0xFE is removed and btmon decodes the 7.0 errors 0x49-0x4B.
   - The draft LL PDUs are replaced by the versioned LL_PHY_REQ,
     LL_PHY_RSP, LL_PHY_UPDATE_IND, LL_CIS_REQ and LL_CIS_IND [v2],
     decoded by length.
   - 0x20AA is LE Set Data Length v2; LE feature page 0 bit 59 is
     removed; Set CIG Parameters Test v2 decodes
     Anchor_Update_Buffer_Time.
 - btdev: a 64-bit MIC is only used when both sides prefer it; the
   re-encryption tests now pair with Secure Connections and check the
   128-bit MIC is kept.
 - lib: struct bt_iso_qos_ext replaces bt_iso_qos_v2, BT_PHY_* without
   BIT().
 - btmon: Create BIG Complete v2 bounds the BIS handles and shows the
   MIC length, CIG Parameters Test v2 and Create BIG Test v2 are
   variable length, Data Length Change v2 checks its own size,
   PHY_Options S=8 is bit 1, Coded rates label S=2, LL window size
   fields are masked.
 - btdev: Create BIG v2 rejects an invalid Num_BIS without completing,
   opportunistic encryption reports key size 0 and EKS mode 2, the
   peer PHY Update Complete swaps TX/RX, fixes default PHY selection,
   BIS rates come from the PHY value, unknown handles return the v2
   opcode, and CIS Established uses the version the host unmasked.
 - shared/gatt: Read By Group Type checks every service before
   encoding it.
 - main.conf: DefaultRates is sent little endian.
 - Testers wait for the re-encryption result; iso-tester converts the
   extended QoS for the emulated remote.
 - l2test: the requested PHY is separate from the queried one and the
   MIC requirement keeps the requested security level.

Luiz Augusto von Dentz (9):
  lib: Add HDT definitions
  monitor: Add HCI decoding for HDT
  monitor: Add LL decoding for HDT
  emulator: Add HDT support to btdev
  emulator: Add HDT support to bthost
  shared/gatt: Add MIC length permission checks
  main.conf: Add HDT configuration
  l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
  l2test: Add HDT options

 client/scripts/gatt-mic-128.bt       |    5 +
 client/scripts/gatt-mic-64-128.bt    |    7 +
 client/scripts/gatt-mic-64.bt        |    5 +
 doc/l2cap-protocol.rst               |   42 +-
 doc/mgmt-protocol.rst                |    3 +
 doc/org.bluez.GattCharacteristic.rst |    4 +
 doc/org.bluez.GattDescriptor.rst     |    4 +
 emulator/btdev.c                     |  884 ++++++++++++--
 emulator/btdev.h                     |    1 +
 emulator/bthost.c                    |   99 ++
 emulator/bthost.h                    |   14 +
 emulator/hciemu.c                    |    3 +
 emulator/hciemu.h                    |    1 +
 emulator/main.c                      |    5 +-
 lib/bluetooth/bluetooth.h            |   65 +
 monitor/att.c                        |    3 +
 monitor/bt.h                         |  378 ++++++
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  215 +++-
 monitor/packet.c                     | 1321 +++++++++++++++++----
 src/adapter.c                        |   28 +
 src/btd.h                            |    7 +
 src/gatt-database.c                  |   26 +
 src/main.c                           |   33 +
 src/main.conf                        |   27 +
 src/shared/att-types.h               |   17 +-
 src/shared/att.c                     |   39 +
 src/shared/att.h                     |    3 +
 src/shared/gatt-db.c                 |    9 +
 src/shared/gatt-db.h                 |    3 +
 src/shared/gatt-server.c             |   33 +-
 tools/iso-tester.c                   | 1638 +++++++++++++++++++++++---
 tools/l2cap-tester.c                 |  761 ++++++++++++
 tools/l2test.c                       |  153 ++-
 tools/mgmt-tester.c                  |  170 +++
 unit/test-gatt.c                     |  101 ++
 36 files changed, 5603 insertions(+), 510 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

