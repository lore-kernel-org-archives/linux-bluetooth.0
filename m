Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975711;
	b=pbgZb1m2MgsLqs/Wdtk+/LC2peQX0A1Yy6wJ4pgwpPQZdA1TwbZyZUvOfUmXdlifYCpY
	 xdEJz4nFXDqtr+d0Cd6KM/5tMHpZRhnmeGNLowJzJjfVBt7j1egMFh7oDHSBK6mGAUruW
	 vYRPuT49v5LoZ56EfbOF+QU7rIiHYO/dYe4wk+yJM8t2ULG3OdQy+1WjtjiBZcQh7OlrQ
	 /YtMFvonhetSvXgjIGHM+8j8L2KanEKRm2LZOPaSmNJkiV+EivRpWO54gPTYWUfIZ5DNY
	 j7CcG1hvcRnrEfddlPE+IpbZZ3yoPzkTMOiafFP4mzff01dQmcSH0YsMZHuSB3wNH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EgWW/8tTggMrSKDZfyyG8vdUOL5ZUz6+50xvEDNKnOE=;
	b=klsgkpmWuQ1tlduYfc88N53EJTRF0U62AZvdsYtXfWZW+OVYY2V/RUgzyNuRmdVO+ayi
	 Kpl4euxLclPcoEUnSspiJl7ypa1dYRvHo079NlBrcMSkGdZW8tIO8K/FvQlNGPcHAosii
	 vQyC6iO8XtIv0UabbvgCATCoLiNIlTdmX7x4UwEfYOv+CKuSNSS1Ev46Sq7cqZk3yQers
	 3JNVwXSgX/ddd1BxRnxatZ6IKtcvVx6qq5CCaMvhNrs5cRdfwsKA14WenJabLwUfYB9lB
	 myMFCyWwpXX+cS3zvqawQ/gw6e/CPvJjsudMOIE6pOr0aGUj3v9Q++eFRVy+98g0nUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gA4NZHpr;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457CC606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 04:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 457CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gA4NZHpr
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso457319b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794975710; x=1795580510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EgWW/8tTggMrSKDZfyyG8vdUOL5ZUz6+50xvEDNKnOE=;
        b=gA4NZHprEeYkTP/6D69vqa8UNiJAMv9duN4yD+EivK0VhX/LapyjkM7e6RB0PE3bEr
         4JfdsFLXmwrk/UDnbnmvwwxO8MeewAcx2bSLGpTriTKCqm8Uv4J1UB1uiNuEHkFYnJNE
         VLAPRyGxJsEijKzKY/RaB0y+zWeoqjXC2x7h3MZ+REqV01erU9eeoXANWFfpbqtdaCj2
         4O7KUAT5L2sA/0LjoSyk30KVo6ohkobBxic4+eOMw4BsAwJxLYQCzOOh4XsQPGw5GOQk
         4MaeHqMwL6Q1C5806JZzmyyQ/v1J0TTnzJAGekuqPhoRA78Mt87/VinpPZxIgFz2v1A9
         91pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975710; x=1795580510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgWW/8tTggMrSKDZfyyG8vdUOL5ZUz6+50xvEDNKnOE=;
        b=nUo7owPM0h3ki/lY8OIPSNQjauw7rp6f81v+uCIFV8W2Way066+RU8d24PxFCM8j8G
         mt/7sHlD45KNk1SexWcQ8ioeOMHEJC8ptKokdv/UOCe4NgknoawfKNC4mQB9OMwq+SMS
         99fAVesgnfwLcgGkWGSDlQPgujGnCH+wCTaHtiRoA/0cNzmGg5qvWwEJhLeH88v2u8Z1
         QrtLZKDI2ZKc4mYghxzdOA8pfv/pE72MY3NbwFT1zNs9zNLe2JAKbeIUnogaXWRsGSMv
         crwuqYkOzvtTq93Z5foYIf6KKwXjoCgkGBkpQCL6z4z5XR9DI3zZpwKrlxcTLgoyn5zR
         LDVg==
X-Gm-Message-State: APuU4Z9htdCyAdP+CIetaeFh2vdfqUbC5IuumBNxBqVxdA077gQ1gI0Z
	mJsUbfMFWPtfBv8Xq68oWQ3aptt1bfqTl8SxsqYRb4aAwF3vGYm4U5p4zYuqdD52LQU=
X-Gm-Gg: AYBFou2hBid4ibKpEGc5zaF2BxN6Hr/gvG10EsP1Fw8DnA2PVoBXycIoQxfKp0aGGiB
	0V9Da5lbNl7fyb+jyA6bZT1/1SYBM9FhsYeSn7NkdwOIj/Cw+v6GM/BMl3PirNie3yY+Ov0q2D3
	xEp1PRCjQsI3nRoPLDgwR7uzP1ypo7MeutVSpJMyzEMUJ3JYJPeZAKsoiaxLy1HqWYbNOs4X0G2
	GXt8o/1rweejD13FNfzlGyNM6f4QekuBDuRlIozsIa+IqWp2p2VYiRtRFaIY+8dFM5awO1dTiGV
	sjNZlNEsQvyFTo/q2i3f2nJyPwq1zp7vyqcWQQtRMS+KlfNn5W5pDAoT/FUgR7z1DHarAHSW2ic
	DaO+GtOi7qxQ6oG+QwOmnaBiHIinm3XIjP0lceTXgCkCM5yuIvGTiexo7dC44FjHdw9AJ8SwQAL
	C29R1NBvKx2RxVzkb3yTYZ7Efa7pBJZe8RSN2wZaFhnwFX7dbPJqwLmGt6X1X6Mcfygb9Zw79IV
	n+5na5uFnD9ZUduMmybPOMj7dCZqJhSjZQNVx6PmrN9UH2joi1X1SWni2Lbh7z7GWQ5WqekN55l
	O7aH/8d+rqsIX7dgARtx4E9Jg1qcVwH9+dTKCyvzjwEIOQ==
X-Received: by 2002:a05:6a00:22d2:b0:880:b709:cefb with SMTP id d2e1a72fcca58-8c5d4cbd63dmr1158086b3a.45.1794975710241;
        Tue, 17 Nov 2026 20:21:50 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aaa8dsm455003b3a.10.2026.11.17.20.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:21:49 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v4 0/4] Bluetooth: SMP: Serialize root channel updates
Date: Wed, 18 Nov 2026 12:21:34 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

SMP root changes must serialize with their users. Publish BT_LISTEN only
after the root is initialized, under the global channel list lock,
so another controller with the same address cannot select a
partially initialized root (patch 1).

The force_bredr_smp writer takes hdev->lock and changes only its flag
while the controller is down (patch 2). Power-on holds the request lock
for its auto-off update (patch 3). Registration then runs on the ordered
HCI workqueue under hdev->lock (patch 4), excluding both HCI event users
and SMP receive callbacks from root replacement. Patch 4 depends on
patch 3. Patch 2's exclusion from power-on also needs patch 4.

The old mgmt_powered() called smp_register() synchronously under the
device mutex before submitting the HCI update. It did not run in the
receive worker. SMP receive callbacks began using root-owned OOB data in
March 2015, before the synchronous HCI update conversion that November.
The shared root transform use was added in September 2018. Patch 4
corrects that history and tags the earlier root-data access as well.

The WARN_ON() for replacing an already registered root remains. The
separate HCI_CONFIG auto-off shortcut issue mentioned in the review
also predates this series and is outside these root lifetime changes.

Validation: GCC modular and Clang built-in Bluetooth builds, including
Clang context analysis; every prefix and the combined tree with the six
new Bluetooth series build successfully. No new kernel runtime test was
run; the quoted reports are from the earlier instrumented test kernels.

Cen Zhang (4):
  Bluetooth: SMP: Publish root channels after initialization
  Bluetooth: SMP: Serialize forced BR/EDR channel changes
  Bluetooth: hci_core: Hold the request lock for the power-on update
  Bluetooth: SMP: Serialize root channel replacement

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/hci_core.c      |  3 +++
 net/bluetooth/hci_debugfs.c   |  2 ++
 net/bluetooth/l2cap_core.c    |  8 ++++++
 net/bluetooth/smp.c           | 46 ++++++++++++++++++++++++++++++++---
 net/bluetooth/smp.h           |  3 ++-
 6 files changed, 59 insertions(+), 4 deletions(-)

---
Changes in v4:
- Address the cross-controller root publication and powered-off debugfs
  concerns raised by Sashiko:
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0%40gmail.com
- Publish fixed roots only after initialization under chan_list_lock, and
  change only the force flag while HCI_UP is clear.
- Correct the registration history and early root-data Fixes reference;
  state the dependency between debugfs and power-on serialization.

Changes in v3:
- Address the hci_power_on() path that reaches smp_register() without the
  request lock, raised by Sashiko: https://sashiko.dev/#/patchset/99158
- Add patch 2, which takes the request lock in hci_power_on() again, and
  correct the locking description of patch 3; the code of patches 1 and 3 is
  unchanged.

Changes in v2:
- Address the CheckPatch and GitLint long-line failures reported by the
  Bluetooth CI: https://patchwork.kernel.org/series/1197223/
- Trim the crash reports in both commit messages to the headline, call trace
  and allocation/free stacks; no code changes.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com
Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com
Link to v3: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com
