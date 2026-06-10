Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7A1A238F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114466; cv=none; b=XEFRXQrjV6sX06C24rsMlgFJ0DbTsRG5tLOV/MSipmGkci6b/VtFhz0YlyySchJqmiSngG+mHqm+s0cd/mMs23lRWV3nFgjaddAgugiIgeTRGVph/QCFEUeVNUaOipUzQp3hWZAd/gKruY/MdYYH67s3366nC8UyR8+j3PI2DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114466; c=relaxed/simple;
	bh=f2ejQVxewrDKsob82JgfUlTj3330mYg4KIAMFvIEs7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaj8g3gi/0RVgWi2OxjTlxGL/K0vzZhTyJ7mDiwdJ6eNNxYbgMImDuR0U2ZsxmoezQDz+GKCwYo4ejnXaR9PUmOsdjNxsu5i6rDmeaMtNep0nI6eacrh9TBY2IveWzpBC+ZPrwkaYvpzOthvazaqv5UL3AnwtBg41JXX17ejpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDMOhmRA; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDMOhmRA"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59cd803792aso4790575e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114465; x=1781719265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGp3yuhK4hPwbgdawSH7Sgib95jVuTbwLXx+HiTWnO4=;
        b=tDMOhmRA60wGFa2dGul9cAL3CSmHaq+Qj5KRV0JX7rf5pyvGR/IMZvBjArynYA4VP3
         1v5bfAlUSQrY14eykI7b4OqG7B2ei5K4/lTvprVQgPo0oHP84KAqnJw2wL775J/wAiJK
         ++GxpknYjDXRbKwdrMCR5KA4ctv+387U7MLOkUTER5VvVBkh1vJtraUuBaJyytvmxD9r
         qMCGTxFot/vqD/rIqf3gc45DNp3o2NnCQrtDeHOiWVUHQpv4r2qovvSoTdy0NmhQL+B3
         ukT6lm7hUPVIHBp4Pj3K2nDdXHkgMo136tP7u6HJFgNyfMvFgcAKq/H/SSW6dqC809Ip
         kWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114465; x=1781719265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGp3yuhK4hPwbgdawSH7Sgib95jVuTbwLXx+HiTWnO4=;
        b=elWj8b2026tQwQizGtJMvdeBZXs8KWztaQvKcetNCKbVx0VpMR029kUY5mZtOc6YU8
         XMgcQxs2SeYrAouPUHhHaEIzwGyl9n+6WvfooUdTxE+VSci5hrzl9lHlvg2ixLu5v4C5
         FDFv0+YVqE3I4z6V5Tr7rShOpzv1Dsmt+4Wi3IHDdhda0eIcdZpeRqJ0yjMwb92AAlO1
         3VheG8hRFjOwuKdncBZIXcbUwBYGXZiDQPSBI6Zos6C+vYhU5S5CxmLvCJXaTbQclF74
         rfTl266CPT8dGaTbZXUDMrzq+qka4e0ZckqnxlvXdGm0B1/xVdKJcyALmvsi7dhCdI1K
         Y5kg==
X-Gm-Message-State: AOJu0YwWupZ6kqP7VJxVAsDfo6dJXWb5nMbXK6Lx51NiWeULOW+xWUGb
	RTM0SnRW5LzKqjmM3hQMKkNTPAXVz0atN8xlBSk75tcFN9SZA75A4UaN
X-Gm-Gg: Acq92OGZpLLK0cX25MkAgEUeSO8/1Jh/6vR9YBkw8K9BUo7GpXDHNqdEJILkQFTXmlE
	VRWdosZI9ZRqQbx5r0pmctsvncDj0i0dCA92Q1rpTi6wvUWix7J/Bfx/KnuDw+i2uWNPQEKmyCe
	QadnvoFozyKarJAVAg1qlXk5+VGhG6TYM+5SgOnSUhXYGnDsFVoaVf/jc/19/N0r2VOfrUZnCH5
	P29dUMYxH6ig9Wld2ND7kw3xCv/QWkhJCgh5vasxxEsn/c+PRsI3uFT92ZVOQRLFky+l5nX5pd/
	rETwqu9U5JHto4yjx+Tf3eGrF4jGlb+QxJkPi27YsnWhODQVQ37l3HTPU3UPsZLUHIyiiuNQShm
	66VoQM00W8R6ElBuHL7JPaLbQJLK8rlJx6xrTCnqKJXVg7AqKyRssJuzHBtHK9T41xW7kKhmwJb
	eA6YMt/oE5fVRR5WT1w3lIN0RFdNTjGYdNPcAMj00e+U0vrbPC8r84qkqtM9epnP4heySs8wFbv
	821kylistC0V35PerzIe0/VejNI
X-Received: by 2002:a05:6122:786:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-5ba441ed976mr177164e0c.8.1781114463102;
        Wed, 10 Jun 2026 11:01:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e1d7sm19418359241.12.2026.06.10.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:01:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-06-10
Date: Wed, 10 Jun 2026 14:00:50 -0400
Message-ID: <20260610180050.419401-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 149324fc762c2a7acef9c26790566f81f475e51f:

  Bluetooth: MGMT: Fix backward compatibility with userspace (2026-06-03 11:24:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-10

for you to fetch changes up to f98220e190507d3eb3e02f9a2f20c418c30d04ae:

  Bluetooth: vhci: validate devcoredump state before side effects (2026-06-10 13:51:15 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: Fix UAF in hci_unregister_dev()
 - hci_event: fix simultaneous discovery stuck in FINDING
 - hci: validate codec capability element length
 - eir: Fix stack OOB write when prepending the Flags AD
 - L2CAP: Fix UAF in channel timeout by holding conn ref
 - btusb: fix use-after-free on registration failure
 - btusb: fix use-after-free on marvell probe failure
 - btusb: fix wakeup source leak on probe failure
 - btusb: fix wakeup irq devres lifetime
 - btmtk: fix URB leak in alloc_mtk_intr_urb error path
 - vhci: validate devcoredump state before side effects

----------------------------------------------------------------
Jiajia Liu (1):
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Johan Hovold (4):
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      Bluetooth: btusb: fix wakeup irq devres lifetime

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Samuel Moelius (2):
      Bluetooth: hci: validate codec capability element length
      Bluetooth: vhci: validate devcoredump state before side effects

Weiming Shi (1):
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

Zhao Dongdong (1):
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path

 drivers/bluetooth/btmtk.c     |  4 +++-
 drivers/bluetooth/btusb.c     | 55 ++++++++++++++++++++++++++++++++++---------
 drivers/bluetooth/hci_vhci.c  | 10 ++++++++
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/eir.c           |  8 ++++---
 net/bluetooth/hci_codec.c     |  2 +-
 net/bluetooth/hci_core.c      |  2 ++
 net/bluetooth/hci_event.c     |  7 ++++++
 net/bluetooth/l2cap_core.c    | 34 +++++++++++++++-----------
 9 files changed, 93 insertions(+), 30 deletions(-)
