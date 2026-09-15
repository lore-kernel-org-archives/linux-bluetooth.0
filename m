Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787894CE671
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500296; cv=none; b=H3U9PmtUonCrj8uyz2mRFp6JTLVWV4QbTnlTMsG+CZxeu7uboW9w2qX6HFPpsHehZOn5W+8egQ+03mhYmXFrxGuDntIIJ6MkYMg0HAV8vuYwpNIEt/SGdurXb2DW504JBoCRvxuNB69beg3JbzSfdfZY286oQvyzdYQ8hHstLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500296; c=relaxed/simple;
	bh=9bHaq52+LNuWMhtyY2yvMcwuGO77VgXguJIzqI3vybI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0P5r4xuAyh1xehw7ED5tw6kXE/7SbWHl3rv0HGXdnt8mOkwlOE0XRwxKWLxq0EhOzoSkEKPlwqgbFUi0Yg+42kbbimdNZxaJt8CH2jWITm+sJ1aPNDw9Kb8j9QuSb0u7K7HZr5RRiDo2lrf4Ssqf/nVUkr9URPpRMy9hYtBCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsbQEKYK; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsbQEKYK"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-980b6159d30so38456241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789500291; x=1790105091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hq+Kkm/TimJDkxPPQ14NOEWXj4ICc2WmuYGKUmYgsP8=;
        b=CsbQEKYK8ig+fCQWYGr4iU84KmWqbVVb+m8eAE0Nu0773ZW6wwf5KHb8upgd3T+FyC
         hFXd5Mool0Fjl8NA/8xMdC17QfDwG+N5vXiv5HNRbQM6537ULSviDCHiXyr4DjbMVOZ8
         kPFSa7iYcukJpvU0tFng1AGtCdzNiINOnEbVJ9mSD6IkZ1Cp+R93HHsU4+u6HmxZRtgU
         kPu8qUkZsLMucQpUcjqzisJGxyrippojq2IMoCxgwt81UBdTFrbavhJ8agy7Z6UWMzAx
         Lzph4xy3BzUOuOiLUMWVyD++HcdzJ1EvFBW1ei8PR0exN8o9maIVj+ue6+Gjwo85CSiZ
         Q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500291; x=1790105091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hq+Kkm/TimJDkxPPQ14NOEWXj4ICc2WmuYGKUmYgsP8=;
        b=oTD56gLHEfrsPTSpwHnnPRi8NTujqPEBezzmyF4grMd4f7Fp/6B1AXm7pd7Eovf+14
         Q8Pem9/QCHQZfaGjsZDPQEPuMlssV8rTAMfTgbC2KKOobUZZkok9eZDbZGVE+zRrQH48
         NzcA2FnQerH9lf5gdrdhfUFxCt67V8UCipa6/v7eIoBKCqYPtBIIJ5FXWUU503DiIQqy
         EnqNID+ztoHumBCbgCrNaBp2UcccW/IDC5hu3ZpQCY3ZcKq5qFEVWkb6wjRgOjsWBbif
         LWrQpS27O3nNGgs5NIwNLhfqgkiiitWHeGtnknkr6YD/jYwAwiABdN0B54VIfiuDT+Ga
         SO2A==
X-Gm-Message-State: AFuF++lc6XAspqkOCTUqfZHX2VFr6xu00P1vzIbwX93Nv2LlmohlE+s0
	xI7ZOfTaUbSV9SYoLDGA1VhfQ0N+dTSabqJj+da66MYSpmc+kX37vMFX
X-Gm-Gg: AYBFou2TuyZo4I41JleMIBVyjWUoInS+aY8s/dZmckS0lr4vh99f86vKPAVDYfnjstE
	kVNXT90AIoG/A0+k9KKK7ePAH0DbMEK3PdtRN8V2EVWo3wu0UVVijWVB3isXJ2jCALArjb/Hee1
	qw0S4iZeuLOrYCoxGCqQHvRmjLFc6n80XkP6WjCiBc+k5/qAVnCuGMqq1pYHy5Erj+BCDxAt+B6
	37W2Px/C3FxQ0O1QZuN2WZYnxrR+rO12DKxoEcRF/e9htjjAUp+bhZ5Bei3uJ8bUhY+sspcezFb
	SEIdcmmkivfh2KSiPTJtpfbV2IpvbHE53saIo8o1cMPm47AdMxAN5uyLTPeyvIHSQfDMgJClHfW
	BHWrX8dWd0zqeBqI4VQrLzlRGEzGrS66AZJUGLzHifJClZUGnx5iQza1Ebz+Q4FGmOnjR3Z+Xhy
	8BCCZSsDcQmWdpKrGHJVYjI4f3bQ51T+xCvPfXg2LXykDs70InO0ldtV2YC+5T2d3iDKKWoZZzP
	MM/fCkceWvoTrEVXVR2S0oyspewHz2eklP4HO8cYnYHgcZDtjrvI809CMBDoc4nMQ==
X-Received: by 2002:a05:6102:510b:b0:789:100e:3d1b with SMTP id ada2fe7eead31-79b51c82460mr3594256137.0.1789500290673;
        Tue, 15 Sep 2026 12:24:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9831526cf4fsm409743241.11.2026.09.15.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:24:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-15
Date: Tue, 15 Sep 2026 15:24:41 -0400
Message-ID: <20260915192441.1130583-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 83a945a529d6e002dd7339c532288a931f463dba:

  tcp: do not let tcp_rmem be set below 4096 (2026-09-15 15:21:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-15

for you to fetch changes up to 801fb950cae7048eb7d83b18857d1ca37b8cd5a4:

  Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup (2026-09-15 14:55:41 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci: put the peer's on-air address on air when we cannot resolve
 - hci: keep dst_type with dst when reusing an LE connection
 - hci_core: Fix queuing tx_work after workqueue is drained
 - hci_sync: Serialize local codec list cleanup
 - hci_codec: validate vendor codec count length
 - eir: validate service data length before reading UUID
 - RFCOMM: avoid socket lock inversion in listener cleanup
 - ISO: Fix parent socket leak in iso_conn_ready()
 - ISO: set BT_LISTEN before requesting a BIG sync
 - coredump: Quiesce dump work on unregister

Drivers:

 - btintel_pcie: validate TX skb length in send_sync
 - btmtk: fix wrong status for short WMT FUNC_CTRL events
 - btmtksdio, btmtkuart: validate WMT event length before struct access
 - hci_qca: Do not write to the serial port after it is closed
 - btusb: fix NXP IW610 composite device handling
 - btintel_pcie: fix off-by-one bounds check in RX submit
 - btmtksdio: Fix PM runtime reference leak in shutdown

----------------------------------------------------------------
Aamir Ahmed (1):
      Bluetooth: eir: validate service data length before reading UUID

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: validate TX skb length in send_sync

Chengfeng Ye (1):
      Bluetooth: hci_sync: Serialize local codec list cleanup

Chris Lu (2):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
      Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access

Ibrahim Abdelkader (1):
      Bluetooth: hci_qca: Do not write to the serial port after it is closed

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Laxman Acharya Padhya (1):
      Bluetooth: hci_codec: validate vendor codec count length

Luiz Augusto von Dentz (2):
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
      Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Radek Podgorny (2):
      Bluetooth: put the peer's on-air address on air when we cannot resolve
      Bluetooth: keep dst_type with dst when reusing an LE connection

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Tzung-Bi Shih (1):
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown

Weiming Shi (1):
      Bluetooth: coredump: Quiesce dump work on unregister

 drivers/bluetooth/btintel_pcie.c |  8 ++++-
 drivers/bluetooth/btmtk.c        |  7 ++++-
 drivers/bluetooth/btmtksdio.c    | 24 ++++++++++++---
 drivers/bluetooth/btmtkuart.c    | 20 ++++++++++++-
 drivers/bluetooth/btusb.c        | 17 +++++++++++
 drivers/bluetooth/hci_qca.c      | 14 ++++++---
 include/net/bluetooth/coredump.h |  2 ++
 net/bluetooth/coredump.c         | 65 +++++++++++++++++++++++++++-------------
 net/bluetooth/eir.c              | 10 ++++++-
 net/bluetooth/hci_codec.c        | 36 +++++++++++-----------
 net/bluetooth/hci_conn.c         | 21 +++++++++++++
 net/bluetooth/hci_core.c         | 18 +++++++++--
 net/bluetooth/hci_sync.c         |  2 ++
 net/bluetooth/iso.c              | 53 +++++++++++++++++++++++++-------
 net/bluetooth/rfcomm/sock.c      | 13 ++++++--
 15 files changed, 242 insertions(+), 68 deletions(-)
