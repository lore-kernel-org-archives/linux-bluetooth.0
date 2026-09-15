Received: from mail-ua2-f29.google.com (mail-ua2-f29.google.com [74.125.226.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BEA346AC2
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506942; cv=none; b=j07LooZ+r6G3Nar4fGh/n1A7A7baaa3dsKbfM1dA2VSDxxnBlhmb8DnyFWTsuDDkE9YVrj4iXtLsYcrkOKy7fkXkPA04WyE4OWIxRVgav22qiLTwpYupgaS6n3IS1GwTbaC4EfO8osR1xW0kEaaY5e0qG21u1A39Hg/HFQP3Fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506942; c=relaxed/simple;
	bh=UDFMVqMUi0paBtH/+eS8HOI2tFDo6jUiPqHJlhRjQjw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u3Gd0pKcmTSuQeKG3VZ2JeRamJkBiBFExZ0ULuc64PMwzksZHOv0PjFiUcud2Z+EDtSrjD8c4ZkFxjBnAsoOsSjKJEBwulacYWKDsQL1ETkOToqPOuL2XHGmqcM9DGPFBCMFUZiSw14+IZvrFaQ5U9SgunDcMUvJw169cIMdquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdpHcuIW; arc=none smtp.client-ip=74.125.226.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdpHcuIW"
Received: by mail-ua2-f29.google.com with SMTP id a1e0cc1a2514c-97e80579b7dso57185241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506939; x=1790111739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oQ9CueVfQNINj+Z3spXf/YSFoL6leUt+0q2mpqKM6I=;
        b=WdpHcuIW4QmKabxpzNW6Vd0BvnBK3tftITe2FW5KZ7jqaxTXPg3yWTTEDxuvv1BFHr
         y+XaKSKVfs0SKcUjC7aOdBh6rWmiuIYas5AaCGIPniEHfXUz4zvqGYqampPTt/Wdq2ap
         I2i1rCzsC/7EWtRb3lhOzVaDg7DtZFYyKqaJph+0L07RYy3y3UnkC3pA/XQM3fh6NqGo
         Z0+1CeZGqpxDwEAsdg4eLdoDl04C3ynJX5aCuSog6aQL3fdbD9yT3jyq7DB3BX7HBU6j
         hECNzKgvKMbf548I9PHhF78VPU84k/djF25up2nJ3Qu1IsNRQwOVo3kEX9Mc4GMZ0CtK
         xVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506939; x=1790111739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/oQ9CueVfQNINj+Z3spXf/YSFoL6leUt+0q2mpqKM6I=;
        b=G5EwN5hRO2sepalcEnj57WqYSjjOWCYO4bprQ5y72Yu0Q1+uUTBg8b7OF+Drci/Ryg
         oeZkS36KGqpjMq0cVAVcZ5SHkSwf8HieuEooSYJjCJ6Ho1CvdsY56IAtmAXFfNG6Vv5m
         +10crjDwMYnn9p1kh3Tz2/1MF6A/0qmvQamPG9TgqI5e4iV3MNAX2Xzolu1hHV/82eMY
         f97eRNN66Jf+Gxo9e488uZEkz8SZb0ZnA1LsbG0V+d45lN+8v4l6L1mIJOnPGLelj0SS
         9fpmzKJn7ys/RXq9InM8vsNX2+yqxHauSeOXMAoQifB8xBuOWyyLyuBuJnrOQf8T15c6
         Eldg==
X-Gm-Message-State: AFuF++nbBtgdZCN/1C2Ab6MNojMBzBNQec6lu/0/kWqhWDx03HDzkVxl
	yfwNZigJWVVaRwSg6l/aSPv2uzHsGSVyF0mtZqk4CBaYn9ncYcjdgcyGf8BrOsCq
X-Gm-Gg: AYBFou2PN4Ue6MNfJC/OQn8ae6k3/fC9naE/lJBTBTcHZS8UIwKRiio3em95PYQEnJb
	BcekIA+rJ310SSz9zQSCOoxzepWR+LxUYZwupgu3paPISURZQPSFLwPJun5Yc1J2uRk/V/82MDq
	jXwAQ5RbA3an5l/beWzNHggFmIxmmqV15ryz4dPn3gyDQghLiPNaOGdpMR/1cuU0wgsw9u29R1q
	eGJky91gHSRopHKC9P1uxhL0u8JVVJs05eBixZWpc1MiP5dGQ/TEgxNcKQ96Ut+WHP9HevE2NgH
	MReVMSeJx1Y6PbJ5TTImfq0vVaMXKT6Q2NkJ7ojcMCvX3KCqxe7mm01oIyt2PTNAQS4zD1Tv8p7
	45Qvir9k5Zxef7k40XpodUhwE/rrY0vGnByzM31cOmT9/5UBrJBZjjGQ1MZXnA1kSpAG+3UJxfi
	2l5I7KdJt30agifekFhpFWK5Ae/kRaLp9SckO6OJyPU93DNTE0Fa3St6IS8sqExBfmbuLkc0Ayx
	H8FmVe2yT7219uJxAOR7DqwZVbSFmh04nhhDusiNouGNqKt7PmQ7zkHGo+9aOMcgA==
X-Received: by 2002:a05:6102:c4a:b0:79e:3401:3f72 with SMTP id ada2fe7eead31-7a02905618dmr127088137.8.1789506937483;
        Tue, 15 Sep 2026 14:15:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/11] Cover a BAP stream to a coordinated set
Date: Tue, 15 Sep 2026 17:15:17 -0400
Message-ID: <20260915211528.1223784-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These add the functional test cases for a BAP unicast stereo stream to
a coordinated set of two acceptors, one taking the left channel and one
the right, which is what a pair of earbuds does, together with the
fixes they turned out to need.

Covering a set takes three hosts talking to each other, which the
emulator does not get right: every device assigns its own connection
handles, but the events and the data delivered to the peer carried the
handle of the sender, so everything beyond the first link referred to a
handle the receiving side knows nothing about and was dropped. It is
invisible with two devices, as both sides then assign the same handles,
and it is what kept the second member of the set from exchanging
anything at all. A CIG was also limited to three CIS, one less than a
stereo stream to a set of two needs.

Encrypting the SIRK gave a value the initiator was unable to decrypt,
so the set was resolved under a SIRK that is not the one the members
were configured with: LE legacy pairing distributes one long term key
per role, and only the last one to arrive was kept, so the two sides
did not necessarily encrypt and decrypt with the same key.

The auto agent registers with no capability, which is KeyboardDisplay,
so a peer may well choose the entry of a passkey, a method the auto
agent has no answer for: the pairing then only completes once the
request times out, as a failure. A capability can now be given after
the name, e.g. auto:NoInputNoOutput, to pair Just Works instead.

The first two patches are a fix of their own, for a source pushed to a
BASS session before it is ready, and the rest of the test changes make
a failure easier to tell: a test now fails as soon as an operation
does, instead of waiting for its timeout, and reports what it is
waiting for while it waits.

The tests pass with "make check-functional", on their own as well as
alongside the others.

Luiz Augusto von Dentz (11):
  shared/bass: add a ready callback
  bass: wait for the session to be ready before pushing a source
  test: functional: report what a test is waiting for
  test: functional: answer the notification registered by the victim
  doc: describe the BAP coordinated set test cases
  emulator: use the handle of the receiving side
  emulator: allow the maximum number of CIS of a CIG
  device: keep the long term key of both roles
  client: allow a capability with the auto agent
  test: functional: fail as soon as an operation fails
  test: functional: add the BAP coordinated set tests

 client/agent.c                       |  14 +-
 client/main.c                        |  14 +-
 client/scripts/bap-sink-lc3-left.bt  |  30 ++++
 client/scripts/bap-sink-lc3-right.bt |  30 ++++
 doc/bluetoothctl.rst                 |   6 +-
 doc/functional-bap.rst               | 111 ++++++++++++
 emulator/btdev.c                     |  89 +++++++---
 profiles/audio/bass.c                | 124 +++++++++++--
 src/device.c                         |  45 +++--
 src/shared/bass.c                    | 107 +++++++++++
 src/shared/bass.h                    |   6 +
 test/functional/conftest.py          | 201 +++++++++++++++++++++
 test/functional/test_avrcp.py        |  13 ++
 test/functional/test_bap.py          | 256 ++++++++++++++++++++++++++-
 14 files changed, 987 insertions(+), 59 deletions(-)
 create mode 100644 client/scripts/bap-sink-lc3-left.bt
 create mode 100644 client/scripts/bap-sink-lc3-right.bt

-- 
2.55.0

