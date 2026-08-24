Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C563815F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594809; cv=none; b=hkmIeIbSYctehi1n24i384M8F1pjQMLD3HuKXZ4uBl8rYi4W1YzqQ/uw9jXKsOJLdJ5Wet4nh5wFyz14vlN7tPBDka+peXa2KJIYUmJubFaTU8J0szUMuVWOmvrj3r+n6noQUuj4cLcdkoncUy8BAHNMI2aIjTKT2+xYx914tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594809; c=relaxed/simple;
	bh=El6uhCbfAIyCFmVUCSbf6VYtuke7x6Eci5neK5eZnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfjYZmPp0M1ftdBP9qXtlB56yroyY5EjMXjeDBQro71njwl7cvbKo4lWZvdrLTvxjQjWi4WUZhfTWmk5C7yTM0heHGEtn1Yev4HTx1HPwpiU4Zwxf8qw+Iuak9Uz22hJe0bUn3ITZj+mPpjcpasgyh/oyxMFNwaez3jraJMuwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuzayVxv; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuzayVxv"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfa99f8ef8so166825e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787594807; x=1788199607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s04gzc+LgdPNYBRS3T5gtZw38JIFIXNwORrO2Yf3TQo=;
        b=NuzayVxvNvUBPmetiiJcgbGzAI0L8JR9i0NGRs7tWmQm9/MlktBEyJ5B1VStON1EIQ
         EcVY3OYQR2Gt5+ATLfqRRgj3lu5tLTyb5fqY5tW2E29Ub7vtGp/UN6arTOvWBcT12CyQ
         VroPfJikJLXjogb5ubCQ9G7ZFzxm5qSwKShG19UiuBnHY0xBsY26+3+jv6WJol4pdHHh
         sj1c4lheNJQuTufQW44AirohKFhJ+Sud8FINcZP+X/+Jj+e7ioswbaheTCzdHz+FxUSO
         QE0XIFg4WGqvn52RoAjHg+dkbpNm0emfjWse8eoWENkwEYjx+myUPzOjnQnKCvXY8a8L
         cWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787594807; x=1788199607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s04gzc+LgdPNYBRS3T5gtZw38JIFIXNwORrO2Yf3TQo=;
        b=Sugz29ktVIH8zR7gLKCF45yutSkzvq3NvZZFEUK+m6vSGFMntKZEYfQXNCh6gRFmMD
         HBGdu4nrBi/4ZWH02JQRrLJeZgvz/2OW2jwou/7gsE3qdfcX3ys3sxA0lg9YSOoShrHk
         uIMqpvhSlD3tYjLNd+7FLpXlfQozR+zKq93q4UuhuPQnCz1PWKoR/0XxuuPshl5k/PKw
         ziIdKV/2cb3P/x6PPBRY9XoEP2iOuWK7eKX/5BTm71MSMhzOGWHUugUSnZqJJ5qspo5k
         HyOobNG9r1g+MunloxtNj9E7LNuJaF+15c4E/PL6jJcuRNjs5rkyQkACszZzLpk65qdv
         MGGw==
X-Gm-Message-State: AFuF++kLW5o2Kt6EDBCjLsdCl3T9S8PyRQlApfo4z+w0embraqqFZYCE
	cYZwQEDc4VCGH5sYU+8P2CZ2xS2v6dQDwaSL229vY1iHM1JJ8wHTKFCH
X-Gm-Gg: AR+sD12OK3UyNfqy5oeumLJHQ1oPutTTnssYPlvKJpVoeXrdmOhWxjzus/59SCNQlol
	OhicdQQ2u1bpA6m42MHGrH+lRHcKxvNv81aKoK7UQ9S8aSxIWFriI3bzIApWyoLHydrXeBI3iQH
	MCQ+A0lmnd/j+dtkHBCoXaWD74kjJu6QuOaXWZ6l3391rS4ulhab0dXVqBrq87i+GqDH8PyKROq
	/69DX8Z3pxqEn36pOL4ngV8PpufbDeVHu0acj3XSRPwPKlFjjW6F+GCNiFqWJ22ol9AIkSsuakz
	a4hTAL0qvYmHwLXm0Umr3232Kd78KFJsBqVkwNKvkz3v3zhhUoDeepaLDenlomTNc3R3GDGRg52
	dHs9/lUAoOLJf5OAAj0c4gR4OpkPmpX552UMzXY+i2oJgHZj94QTblh2A4ldkpQ5Su7VyUthxi5
	MR2A4mWs85X5j4vraHaEsXvUvs7Lz7KbKmQK52153DtKvQCD3ZCEETovAOWmCB5HtoFUiMqSZis
	e/FRmI7xeexfHGmSpK6pW3+6StHi4FAoBfWLB0bgAPwj5nX0gutVv4=
X-Received: by 2002:ac5:c9b3:0:b0:5c5:d799:5b87 with SMTP id 71dfb90a1353d-5c641a10e48mr228912e0c.6.1787594806770;
        Mon, 24 Aug 2026 11:06:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623eb64f8sm4337455e0c.12.2026.08.24.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:06:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-08-24
Date: Mon, 24 Aug 2026 14:06:39 -0400
Message-ID: <20260824180639.3570348-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 7cbfb180945ce529608e4d4e24a6d483699fab1e:

  net/sched: sch_cake: fix autorate reconfiguration throttling (2026-08-22 13:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-24

for you to fetch changes up to ebe6674292fda9a58e6f3adffd6d277560857169:

  Bluetooth: RFCOMM: serialize session teardown (2026-08-24 13:14:43 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: use skb_get() instead of skb_clone() for req_skb
 - hci_conn: re-enable advertising only for peripheral role
 - hci_event: clear HCI_LE_ADV only on a created connection
 - hci_sync: Clear HCI_CMD_PENDING when dropping the last request
 - hci_sync: add conditional locking annotations
 - hci_sync: do not leak an hci_conn when a second LE connect is rejected
 - eir: Fix OOB read in eir_get_service_data()
 - mgmt: fix 'hdev->discovery.uuids' NULL dereference
 - L2CAP: access chan->conn safely in get/setsockopt
 - L2CAP: reject accept queue add unless BT_LISTEN
 - L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
 - RFCOMM: serialize security confirmation handling
 - RFCOMM: serialize session teardown
 - RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop
 - ISO: fix use-after-free of listener socket in iso_conn_ready

Drivers:

 - btnxpuart: Validate the FW dump header length
 - btnxpuart: Check remote M.2 connector availability before pwrseq
 - btmtksdio: Take exclusive ownership of the SKB before TX
 - btmtksdio: Fix out-of-bounds DMA read in the TX path
 - hci_uart: Fix false success return in hci_uart_setup()
 - hci_bcm: fix usage_count leak when autosuspend_delay is negative
 - hci_h5: fix usage_count leak when autosuspend_delay is negative
 - hci_intel: fix usage_count leak when autosuspend_delay is negative
 - btmtk: Do not report success when subsys reset fails
 - btmtk: Do not discard the subsystem reset timeout
 - btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
 - hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

----------------------------------------------------------------
Ali Ahmet Memis (1):
      Bluetooth: btnxpuart: Validate the FW dump header length

Chengfeng Ye (2):
      Bluetooth: RFCOMM: serialize security confirmation handling
      Bluetooth: RFCOMM: serialize session teardown

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Guangshuo Li (3):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative

Hang Nan (1):
      Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

HyeongJun An (1):
      Bluetooth: eir: Fix OOB read in eir_get_service_data()

Hyunwoo Kim (1):
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ibrahim Abdelkader (1):
      Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request

Ismail Tarim (2):
      Bluetooth: btmtk: Do not report success when subsys reset fails
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Junjie Cao (1):
      Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728

Lorenzo Stoakes (ARM) (1):
      Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

Pauli Virtanen (4):
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
      Bluetooth: hci_sync: add conditional locking annotations

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Sherry Sun (1):
      Bluetooth: btnxpuart: Check remote M.2 connector availability before pwrseq

Valentin Kindschi (2):
      Bluetooth: hci_conn: re-enable advertising only for peripheral role
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Xin Chen (1):
      Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb

 drivers/bluetooth/btmtk.c        |  11 +++--
 drivers/bluetooth/btmtksdio.c    |  33 +++++++++----
 drivers/bluetooth/btnxpuart.c    |  39 +++++++++++++--
 drivers/bluetooth/btrtl.c        |  13 -----
 drivers/bluetooth/btusb.c        |   8 ++++
 drivers/bluetooth/hci_bcm.c      |   1 +
 drivers/bluetooth/hci_bcm4377.c  |   1 +
 drivers/bluetooth/hci_h5.c       |   4 +-
 drivers/bluetooth/hci_intel.c    |   1 +
 drivers/bluetooth/hci_ldisc.c    |   2 +-
 drivers/bluetooth/hci_serdev.c   |   2 +-
 include/net/bluetooth/hci_core.h |   2 +-
 include/net/bluetooth/l2cap.h    |   5 ++
 net/bluetooth/eir.c              |   3 +-
 net/bluetooth/hci_conn.c         |   3 +-
 net/bluetooth/hci_core.c         |   2 +-
 net/bluetooth/hci_event.c        |   7 +--
 net/bluetooth/hci_sync.c         |  16 ++++++-
 net/bluetooth/iso.c              |   8 ++++
 net/bluetooth/l2cap_sock.c       | 100 +++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c             |  18 +++++--
 net/bluetooth/rfcomm/core.c      |  14 +++++-
 22 files changed, 220 insertions(+), 73 deletions(-)
