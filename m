Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC903769F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310209; cv=none; b=oqii8/9ASKFaWDaTkX1Cn+dCytpMmI5DL0TAXAnlPBvxhVuVZ6Bk6J2spH/b1UGfg3VFUolF/IcSg5rBo9A41VJ1YVZfw0UZoS4RiAUM+Hnse6eOwW45OVcM5HEIMVi+87iKy6o/Hqi4HbLd+zuriqH/+FaQW9g0mhycSiWOGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310209; c=relaxed/simple;
	bh=xY4morXltX4RqPtRrcw5r7QGtep1CcSEbYEzsn8H7jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/ztVp6Em7zre/G60JAQqKi9YMAmhwScrGBJe7fMt2/e2pJ78vlSowUOGmmvgROomeQHBhE9HZpbrtr4Iy+e43EwNX/BPoYbAESCgxu1vHyGei0Q3fIvCA5XJHyHItqF1XRPdvoDck2F+DpBXu5VTsHVmRv5L8VbeS24Z883afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJqZcM3e; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJqZcM3e"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5751136c561so4852283e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779310207; x=1779915007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhvkCKsqDmZR9B7mEF0SJvWzY0KRdobltrP9UrFhvDk=;
        b=qJqZcM3ef+WY3ruDAi3+0mKWXBuOYXjLYy2eduqOmX/6L4fkF0X0F9ehyUMmc1oAgR
         x8tUPQ8UPXWj7WeyYPXBzQDqb0r7TGKLOPD6t/zVkR2FihbZAh5IYyhWIRZyBw6PCHd7
         Whrk1gD03wZeQ8aLEOcsHZdLy9FCD4Qwh0YceLKYwdPqqUZvN70apvc+4AeIddCK9tKo
         lqOlmyj8OqC4uXzveJrev/Mw7mZbYwk6YYwLgxwjqh4eYmS7trxiLzrPMzlPdpKoZYN6
         Wbi5IR2lwGJCY1wqPpHJtoArO74RiMYEwcv/x/qyoj23V8WtZ9/7ckGT4GteS/JGUeXO
         2lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310207; x=1779915007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhvkCKsqDmZR9B7mEF0SJvWzY0KRdobltrP9UrFhvDk=;
        b=dOJ+nMq6ExBF1ajYIn3x6ORw3nUxaz0ysr7Drl9EpIXqIDszFqCVlhvlBCOx7tj3sd
         RPV+WQjR44Y972NE2v/nHEmXE9ftJ5EHxb4Ku7vY7UOtNZ9FGXeMt0JOV63Taru70w2o
         sfJlXviPurHv7wYetHTafsfFMcrHn+LpSgEFKAg5K7bVVDEy9TTPklfE0fbgQK1SV/hC
         10MOo8t+12VmaCVAVsetEvNSA1OBZinFd2G5qx3ORdcJ9rGbxdBqxXubFX/B5xJvWC7G
         RMw3EX8zj+p80jZ78xam+8eO4fa4giTmpNFjqifR5kfDHEB/bVL/6Ygb6subI/ZMbppe
         MbGw==
X-Gm-Message-State: AOJu0YzpFL+7+oHHl25Ok4CMUgs0DfKgL0tx2z87vy/OQs4Lcqkn3QOp
	v8nnJMno0Qe4hlFCO9dsZR78GSk+v98fM1f/ziZEee/DUIZyOu8DP8ss5zI5SM4OBS0=
X-Gm-Gg: Acq92OHwBqs6fgTlMNq7ZxGo17+oS1MOMBeDCmD4mpJA1l/dcQL0vi8m2IZ1y82zZy3
	cNGVbjvZwAsMoXBM3PGsqmsCbV5fhP2P3RF+8jfwkfq1VQlCm9i2mVbv6twxWxdFbzISS5WGz54
	1zrRnc/N+gCDyfS0HCp7k8JwDziiSkEcZpqh71Js5dJlVvMRronMGeA9UulBPr6It8aYfL/Cr+7
	vomlvHxfCmjQ7ykHOPMLuP/t5gvkv6uLXKHE4Ea0hVbSYw7SVPnxO9XoJB/k+hbZBwlrsMB2Fl6
	jmJ+OSfgEhAHIEu/3jgDoQb4TQlmKGyobKrUx1FcHoyWXVPttiPT6hw9OUxWv7ZKwK7E8oObbGq
	zjq7fIiE5ONVPo4maXE/gp4NU4Hxj9KxSVqR5UaR0vd8nkB1jUanzs+CwrOU4QyczN+HN2xgXZJ
	9IuKrlM9D6aZrYHoiTN2KQ6N3CLK9y0kHOyanCqLk6rpUW9h/TzX4sIOD1CHfayA1M+EB32j8lD
	uuyOYr6LmerOHtYl+z7D5fSonh2
X-Received: by 2002:a05:6122:6587:b0:575:9f5:ac57 with SMTP id 71dfb90a1353d-58411e72bcbmr31363e0c.4.1779310206904;
        Wed, 20 May 2026 13:50:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f58feacsm13392295e0c.1.2026.05.20.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-20
Date: Wed, 20 May 2026 16:49:58 -0400
Message-ID: <20260520204959.2902497-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 375ba7484132662a4a8c7547d088fb6275c00282:

  Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-20

for you to fetch changes up to ab1513597c6cf17cd1ad2a21e3b045421b48e022:

  Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
 - L2CAP: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
 - ISO: drop ISO_END frames received without prior ISO_START
 - MGMT: validate Add Extended Advertising Data length
 - bnep: Fix UAF read of dev->name
 - btmtk: fix urb->setup_packet leak in error paths
 - btintel_pcie: Fix incorrect MAC access programming
 - hci_uart: fix UAFs and race conditions in close and init paths

----------------------------------------------------------------
David Carlier (1):
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START

Jann Horn (1):
      Bluetooth: bnep: Fix UAF read of dev->name

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Kiran K (1):
      Bluetooth: btintel_pcie: Fix incorrect MAC access programming

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE

Michael Bommarito (1):
      Bluetooth: MGMT: validate Add Extended Advertising Data length

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

 drivers/bluetooth/btintel_pcie.c | 20 +++++-----------
 drivers/bluetooth/btintel_pcie.h |  3 ---
 drivers/bluetooth/btmtk.c        |  2 ++
 drivers/bluetooth/hci_ldisc.c    | 48 ++++++++++++++++++++++++++++++-------
 net/bluetooth/af_bluetooth.c     | 10 ++++++++
 net/bluetooth/bnep/core.c        |  2 +-
 net/bluetooth/hci_sync.c         |  6 ++---
 net/bluetooth/iso.c              | 14 ++++++++++-
 net/bluetooth/l2cap_sock.c       | 51 ++++++++++++++++++++++++++++++++++------
 net/bluetooth/mgmt.c             |  6 +++++
 net/bluetooth/rfcomm/sock.c      |  9 ++++++-
 net/bluetooth/sco.c              |  9 ++++++-
 12 files changed, 141 insertions(+), 39 deletions(-)
