Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8D337B99
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100364; cv=none; b=NUiYPukCJbkbRbwksylO2fUSjopTvSmG76bgZb3zCbo+2ZRY69GcI2RBUyd8RTXQrSUGW8JAsMUyWgwVFRwNgJyFBMb2Nrxy74nXWwI4he1d6Cl/iQ5hZkGOgOvQFJVTLx508mBdGCe54HEZ13Ok8IN4tS6xAJCo4Lcjz0BJ6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100364; c=relaxed/simple;
	bh=6gBZ/hJmLLjnbYlzfhgRmDgIBrzs6c5ad/i7CBsGmyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4luUwZDYVX9Sh3toIWtch4m5KHVldGozsiy+noIyE/o2X4x6OjCxPRnAPYuS3iCyl0NpKiQxZlaBLuIg+nqIND3cUDdTcVe1XMZTJ63EFh6zPRFGD4iUUNGefe0mAvWGa4TcCr1ou25r56KFtBRrdMyEXdQesgYnPPY9n7BEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwfdChS9; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwfdChS9"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5675d609621so157571e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100361; x=1778705161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g392jgB+6lnAAk+nEefn10QGzGcNLgIsVxIMykrWjPA=;
        b=JwfdChS9St9D429uUrvo3onHYG2iOOWId1G7BR7D58nBeFMz4hYHo9tTHZECFljox4
         t1sORm/RUe2VmM0tDoKItDUwczU+L+/fgueR37pxWSy0DdFQZOCSu7T7g+U8X5sQFOKM
         lUph9T7SMFufrKEkee/JSxWGEn+LfRh9rNCHf+ZR+iIbZ1p4lIDbQq5RZDgostlCM3j3
         ykIdkXgIvd6U5nX854ryQSgz4RPKn0u+QbJVkMkYSZtb8BbuH7ZkXi9RlRTU9NYe7akf
         AT5l3xtpFrPHcqh7BKaahOdABN7UDnMbJR2A2JwJSXgdBj5rz4MwUEs3pbMmDnE7NcRo
         7L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100361; x=1778705161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g392jgB+6lnAAk+nEefn10QGzGcNLgIsVxIMykrWjPA=;
        b=hCxKebxh+ibdj+zWzEgIfPH1csPQJj4vAJ6z7NmPVard/0xg0GBbOPKG00VLNY6U5Z
         RA3SrIFQOveqmvmIk0re3stPlZ/g9DhR9L1WWDj71soB4tPZmQAbL+Nri8dokVQqq8kg
         jNhSZnP5VF/hV0Oc8mroWOLTwaIf+k64Kmuh0dsBaSBTvBQ4yIgmqZHwWrdxFGMdNwh9
         HwQ45qtXIs7QuMPDz+O8xL7MY5N+n/BqBzzbQj8WTRgD7XKWILXHtv+jjQQZhXCcGGZr
         iPACkk+dYEftbStjFiR0yHjBl00pfLt+sV2Dm9LAvU8/jlGl09XwgxZ7Jt80RraaxgQc
         ZlXQ==
X-Gm-Message-State: AOJu0Ywe60e04v3WrSPtrJ3nw0NXjlWqhPPCTu92ciZSeX3lAvF2ieHX
	fJhWSzj0JjKtUE9/KmQLUvviGLdrJWpuxl2/Zsk1ApT4Y4IIIF9flWhXd8GyisLd
X-Gm-Gg: AeBDievZ8GFYuCBHircRCGry5KT4WwDHlJna9/XBMyUz5ApDA/qQknOJH+XrjRtmihi
	U7Mjzo1ar96ZSmIOdXk+X0sZqyHafy/6jX2JzNQC9i02mjFcjWeNuqffgDAYqu6VYicJAus2qyL
	+6uJdPru85E0b2sZZ4Deq63DEONEGoeq0E1boGpw8Am3CPiJCThZhaQbRkwNwHFfqdHrfuTGIhg
	g3FAd5sRXqcx5lpGbNK5SFWKUh7NwTtYVx2gTLrKIoWO6tZT8R3m1IJU5cOUtW1B1wx/1gYVm/f
	VCXsAzB/p2P9Vm3tur13OBoT/H1LeK0e/IQGY8WGDZavqZERMakW3MRortUrrL7C65VYCORintA
	Hfy2RQdkUPK+xhm98jKJ9EO9zRxIH6LCq+x5L7cmj4IX/CWOva4WXt+gvMgHc/Fk9p92AD8DlIj
	//X4EaVPZkbmVjD4+hadl2QA1lqoBMgzsx1eoQUXTlXHYHEAs8zyTTLcldGA61DB89buSqQwiGD
	pyb2jUSeeiWav6BwyUJ847V9FaJ
X-Received: by 2002:a05:6122:3a0f:b0:56a:fcbf:8aa4 with SMTP id 71dfb90a1353d-575595d06c3mr3478778e0c.2.1778100360812;
        Wed, 06 May 2026 13:46:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc1e08sm10962969e0c.13.2026.05.06.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:46:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-06
Date: Wed,  6 May 2026 16:45:53 -0400
Message-ID: <20260506204553.58686-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b89e0100a5f6885f9748bbacc3f4e3bcff654e4c:

  Merge tag 'wireless-2026-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-05-06 07:29:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-06

for you to fetch changes up to c5d415596cb6fbdf6334b06cc87a1a5a268d8725:

  Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem (2026-05-06 16:27:53 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: fix potential UAF in create_big_sync
 - hci_event: fix memset typo
 - hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
 - L2CAP: fix MPS check in l2cap_ecred_reconf_req
 - L2CAP: defer conn param update to avoid conn->lock/hdev->lock inversion
 - L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
 - L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
 - L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
 - RFCOMM: pull credit byte with skb_pull_data()
 - SCO: fix sleeping under spinlock in sco_conn_ready
 - SCO: hold sk properly in sco_conn_ready
 - ISO: Fix data-race on dst in iso_sock_connect()
 - ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
 - bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
 - hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
 - virtio_bt: clamp rx length before skb_put
 - virtio_bt: validate rx pkt_type header length
 - HIDP: serialise l2cap_unregister_user via hidp_session_sem
 - btintel_pcie: treat boot stage bit 12 as warning
 - btmtk: validate WMT event SKB length before struct access

----------------------------------------------------------------
Aurelien DESBRIERES (1):
      Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized

David Carlier (1):
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

Dudu Lu (2):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
      Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req

Jann Horn (1):
      Bluetooth: hci_event: fix memset typo

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

Michael Bommarito (3):
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem

Mikhail Gavrilov (1):
      Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

Pauli Virtanen (2):
      Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
      Bluetooth: SCO: hold sk properly in sco_conn_ready

Pengpeng Hou (1):
      Bluetooth: RFCOMM: pull credit byte with skb_pull_data()

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: treat boot stage bit 12 as warning

SeungJu Cheon (2):
      Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
      Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()

Tristan Madani (1):
      Bluetooth: btmtk: validate WMT event SKB length before struct access

 drivers/bluetooth/btintel_pcie.c |  13 +++-
 drivers/bluetooth/btintel_pcie.h |   2 +-
 drivers/bluetooth/btmtk.c        |  15 ++++-
 drivers/bluetooth/hci_ath.c      |   3 +
 drivers/bluetooth/hci_bcsp.c     |   3 +
 drivers/bluetooth/hci_h4.c       |   3 +
 drivers/bluetooth/hci_h5.c       |   3 +
 drivers/bluetooth/virtio_bt.c    |  39 +++++++++---
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/bnep/core.c        |  13 +++-
 net/bluetooth/hci_conn.c         | 124 ++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        |  29 ++++++++-
 net/bluetooth/hidp/core.c        |  27 ++++++++-
 net/bluetooth/iso.c              |  56 ++++++++++--------
 net/bluetooth/l2cap_core.c       |  14 +----
 net/bluetooth/l2cap_sock.c       |   9 +++
 net/bluetooth/rfcomm/core.c      |   7 ++-
 net/bluetooth/sco.c              |  60 ++++++++++++-------
 18 files changed, 320 insertions(+), 102 deletions(-)
