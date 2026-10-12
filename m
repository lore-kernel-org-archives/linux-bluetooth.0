Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69740F742
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839292; cv=none; b=si/2dQiBzwMAjoEbq8VTicpbnCZlvXBu2FKXLHgadhZGT78oA0P2VvDug/tAYHl3sUiT+RGa/W9JBGK8jzGDQxnRDzqQxdwz8/0h5J4ktmuddtMJpcYxhKU7RnT5NoRefUCw6n4EmjmBTpn4t9VvbK1/WNyL9fPlRsrqpr6nNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839292; c=relaxed/simple;
	bh=jsl71V5FtC06/50t0daXqqjNV/VyEyXzqcTiVIacV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJLiOjB2eC1IOrlqbgejTUDRwl40HGcYTYrgWFsZfnA3y4fnUh/+iR68CA+WboLx4Bmv/aFt7DwsIEN/7IKFBb1s6Fl4OCjQ62rqpkd6jTd0yrI6oAIJdVf1yk1UsiEb9pHuLrmWAEjUd3ppvkAgdbCWmoMgN41IMoD6dFkcFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9j1vyDX; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9j1vyDX"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5da7a39e584so809700e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791839288; x=1792444088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uap5kT9XS9XvCOY+jEh6of0VhCK5p2hjX0LTl9bySnk=;
        b=G9j1vyDXOEc4fLsnZ7c8uHPDNTk0igRuOWOel8qlsl4E8qvej4t9DpSKroMjgspDGc
         JDnjNWMh3KXZ+TUGw+VlYLUcBV+AqR+JsL/vDK83YQP5VDpVsBmlhsiuwUmkC9+UFiBi
         qV1NK94k/IYYn2BmdtISu4Glt/5ftws2ZsaDFnrKM4JO2PS61y3Va69+Puh87VpUyI40
         XNhm7UoJwWaeXINH3v1yinoi0M53iWNtvuzIO/4j8TqQEKIfwFvEF5BYopUE2D0gT2EN
         5Fdqs//LahvRinYwGTR6mQmtnUyIG1TC/jZ3dcwiDSTRy9dKw3TAmANyQQtzrx6Wm29B
         OE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839288; x=1792444088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uap5kT9XS9XvCOY+jEh6of0VhCK5p2hjX0LTl9bySnk=;
        b=y61Yk4YOGOhOJMaMyqcBP5jMmKepj+sZkeNLehLIi3I9LL3wdSbbGfSLAwmkJZYfPX
         0Zj+cbg+ADYKVSKBRRS+GcRXk0tOS0/BgTGvlZi8/9PEc7kOd6gNCBQ6CynpdeQq5VoQ
         bw18Z9ErLv1SCnOF8zbBQRb394nOvQ8+pN7ZnwURogYBfs3tXYu7h/Al0eTZCSjSehiM
         rvbjtoNUwWfMUfuGhCGSce+Za/2A4B9X9VJreyv6nZLasGGbkQ+oESlazMVDmX4njnmQ
         axbB1NdcKDbSd2e8zf3JITb4sbCwotT9wrDyM0sEE6205ot55ntTl+OJosTCc3F3ZdfQ
         Ucfw==
X-Gm-Message-State: AFq9FYKeMcEuBbXoNVGrivqgxB3gusmW4+mkdUyUx8Cx1a4qUvROmfWb
	kpPPBnskuXcI5BwMbs99o3vE0xrNZ5f0gKVt8LKZO3dya3dUL9yT2f4J
X-Gm-Gg: AYBFou2iZGU6QIGUkshkC7rR/XYK35BKWrVEFAjK6/lOa5hKfleQpYXaAeY8n1qWSCb
	JNm8uKESfE3r7KdiH9UG0TJ0dVqszEuNS/9KSN65LNSWLXc0Y7pyK+HiXnYydAH/5xJ1maGEhSj
	3eZqv0Hs6fWM0qGSuWvNH1peOYuQa6tnXpTqI4VE+rWR2bRqW9S3cGPMMab7FwfoJyM3TFh3SxK
	bF0HAZYYJfRIFyRoS5iA2IXDNB7Cw+9RZ3zrphPppSnzBDhETcrBkaWtmuBZVCItfdJz1Zxbgc4
	A4Qgzd9YSOrF6I1bSWA3+JC9FMLKsqGHjbhwvx327gOCuruXGZb7AHkGSX2pntDHpXYzo7TSu0u
	ovydJ9BTJ2r+yKAyZ7+SUY0o28UTsO6Ul2wpth1uJjLsjnqEKMO1rYairN33bfapjZuJNEP9zcw
	hHKzhRSdrVUABAoQZ5/04d4KzxesMQ6yTi37y1ryXCvdH2L3UVpSWS3tjpTWPoQXGAPV5WD7hOr
	vf+EjZQdQW4pYThWrxvnzCXcHAVnFeoh1pKnS5/gq49JHYdjalLMZvQbjjFC+ns
X-Received: by 2002:a05:6102:5114:b0:7a7:195a:1b29 with SMTP id ada2fe7eead31-7cb375057ebmr2406907137.35.1791839288359;
        Mon, 12 Oct 2026 14:08:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354016d6sm7389871137.8.2026.10.12.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:08:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-10-12
Date: Mon, 12 Oct 2026 17:07:58 -0400
Message-ID: <20261012210758.275556-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e32d80293a0e1a160d5e5101daa8c82148c07510:

  Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-10-12

for you to fetch changes up to 23ad91f6a21a830b67f5eee790caa0053bd6537d:

  Bluetooth: MSFT: Serialize handle map cleanup with event processing (2026-10-12 16:27:16 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Keep RCU protection through LTK filtering
 - hci_sync: Serialize devcoredump reset during device open
 - hci_sync: Protect IRK identity reads with RCU
 - hci_sync: fix mesh adv timeout units
 - hci_debugfs: Pin module for debugfs file operations
 - L2CAP: Hold the listener while notifying child teardown
 - ISO: Hold the listener during disconnect notification
 - MGMT: Reject quality report requests during unregister
 - MGMT: Fix advertising instances with Global Advertising
 - MGMT: Fix pending state of instances added without HCI traffic
 - MGMT: Fix leaking instance on Add Extended Advertising Parameters
 - MGMT: Allow connection rate request as peripheral
 - selftest: Pin module for selftest debugfs file operations
 - 6lowpan: Pin module for 6lowpan_control debugfs file
 - 6LoWPAN: Use RCU-safe device list removal
 - 6lowpan: Drain RCU readers on registration failure
 - msft: Lock failed probe cleanup against feature readers
 - MSFT: Serialize handle map cleanup with event processing
 - Add missing newline to bt_dev_{err,warn}_ratelimited()
 - Fix tracking of instances sharing handle 0x00

Drivers:

 - btintel: Zero version data before parsing TLVs
 - btmtk: fix skb double free on ISO padding failure
 - hci_vhci: Pin module for debugfs file operations

----------------------------------------------------------------
Bui Viet Dung (4):
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Cen Zhang (10):
      Bluetooth: 6LoWPAN: Use RCU-safe device list removal
      Bluetooth: hci_core: Keep RCU protection through LTK filtering
      Bluetooth: hci_sync: Serialize devcoredump reset during device open
      Bluetooth: ISO: Hold the listener during disconnect notification
      Bluetooth: MGMT: Reject quality report requests during unregister
      Bluetooth: msft: Lock failed probe cleanup against feature readers
      Bluetooth: 6lowpan: Drain RCU readers on registration failure
      Bluetooth: hci_sync: Protect IRK identity reads with RCU
      Bluetooth: L2CAP: Hold the listener while notifying child teardown
      Bluetooth: MSFT: Serialize handle map cleanup with event processing

Eric Dumazet (1):
      Bluetooth: btmtk: fix skb double free on ISO padding failure

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Kiran K (1):
      Bluetooth: btintel: Zero version data before parsing TLVs

Luiz Augusto von Dentz (5):
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
      Bluetooth: MGMT: Allow connection rate request as peripheral

Pauli Virtanen (1):
      Bluetooth: hci_sync: fix mesh adv timeout units

 drivers/bluetooth/btintel.c       |   1 +
 drivers/bluetooth/btmtk.c         |   8 +--
 drivers/bluetooth/hci_vhci.c      |   4 ++
 drivers/bluetooth/virtio_bt.c     |   4 +-
 include/net/bluetooth/bluetooth.h |   4 +-
 include/net/bluetooth/hci_sync.h  |   1 +
 net/bluetooth/6lowpan.c           |   4 +-
 net/bluetooth/hci_core.c          |   4 +-
 net/bluetooth/hci_debugfs.c       |   9 +++
 net/bluetooth/hci_event.c         |  58 ++++++++++++++----
 net/bluetooth/hci_sync.c          |  53 +++++++++++++++--
 net/bluetooth/iso.c               |   3 +
 net/bluetooth/l2cap_sock.c        |   6 ++
 net/bluetooth/mgmt.c              | 122 ++++++++++++++++++++++++++++++++------
 net/bluetooth/msft.c              |   6 ++
 net/bluetooth/selftest.c          |   1 +
 net/bluetooth/smp.c               |   1 +
 17 files changed, 241 insertions(+), 48 deletions(-)
