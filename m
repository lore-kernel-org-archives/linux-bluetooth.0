Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28349485512
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436153; cv=none; b=sU5s9roM5CdFCM/7gY45wf/+RCBF6zv+CBL5QPlEFe26q8ywOm7mslEyUNJTnXIWyUZfWdvO9kTnwxeQULnGCGD7n+mi3KDDuLE8fjzsmmTN5pEWcQbFW8PxPsigW+ZYj22n5c9lCBKoRq58eD1DBBAyXmXYjCqk5BP9arbMYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436153; c=relaxed/simple;
	bh=x4iNf/H+eqvgV16IyVjU2WfxeneojhQ2OF5mfbf/4IA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=etDyVIfMLmOAb75a6wA10EJsR96jCEgpxj9pGkdm5K2MbHWVU44gDEUzT/2cFwRyQ1tEARxB78xkps+VQPLsW5gSGGJRz6AaN1P9FxAA16z7Kqo+Z+zkE4zNz3AiLB7dXN1WvceJZ4QMkulB/2DvHNmsqyiPDbqrL1j+0SqBB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bzeZt+kr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bzeZt+kr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788436134;
	bh=x4iNf/H+eqvgV16IyVjU2WfxeneojhQ2OF5mfbf/4IA=;
	h=From:To:Subject:Date:From;
	b=bzeZt+krDQeZ5+BDF463n1DFVW0CEPxQ+q08u89BPUuLKVzwJY8a/4OjHDFqCx4P2
	 lQOotSr5rlbA+yGXpDcEbDxCHuP/um5W6Hfn1MHDxn5jG2Bdnx6JbXstDrKPzlOtCb
	 nQTRvh1CZvLpEJiPEVBsh0/VQTVZyM2i7wRNWNG0BkB0EGLj19qN5ecIjubcRsRLOf
	 wM5Q0NXMZ0xD8ppGBqR8l7y1Y8T/f73Ca2mna9qZCbzvKZ7Sps91LWAkym4qfAiy8M
	 SC1t+m9KolYDSgQx9ygxpSPByzI67Ygm+l7NIqpy5khVZaiP3kEzrCDcmyp4/VP0Lk
	 ZU8yvSCro/c4Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D4A117E0DC3
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 13:48:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
Date: Thu,  3 Sep 2026 13:48:47 +0200
Message-ID: <20260903114849.777525-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We received reports of Bluetooth instability with Nintendo Switch Pro v1
(NSP1), including unexpected disconnects during use. HCI traces indicate
the controller repeatedly requests Sniff mode while BlueZ keeps forcing
Active mode, creating frequent Sniff/Exit Sniff transitions and increasing
the chance of LMP Sniff Response failures.

This series adds generic btio support to control force-active behavior for
L2CAP sockets, then uses it in the input profile for NSP1 by disabling
force-active on the HID interrupt channel. With that, BlueZ stops
repeatedly issuing Exit Sniff requests for this device, improving
connection stability.

v1->v2: Add missing Co-developed-by tag

Frédéric Danis (2):
  btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets
  profiles/input: disable force-active for Nintendo Switch Pro v1

 btio/btio.c             | 35 +++++++++++++++++++++++++++++++----
 btio/btio.h             |  1 +
 profiles/input/device.c | 16 ++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.43.0

