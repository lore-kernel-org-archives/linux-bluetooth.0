Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117671D5CFE
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269737; cv=none; b=JcVhELyzlT7FOOc9oxAk7WbJmzD9HWKtSMvCKeeO/l8F1reG67c37c+g51hljZLFfpeYlKONM1aG9wockLxrtQ1Ea5j5pYsmJkkdo4sfagabxysrBMYQp21pJ1znfKSE4yLgFhmfmUMipiGm6kcE9szaoN5byz3oVRZXahBSOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269737; c=relaxed/simple;
	bh=GBpRrOVmi7JNzkhTZgZnofItQpSe0DOh1g0dT8AmpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLAjZPuC9UCl/cCFp5g06mcH3YrrnhxADxKWGydpl+dmbRiWN/CjcckkX/EwyHRR75NKIvzLgZB2nrLyvlRe51NIzt1wBaL2H041e5XcGcc+iktqRb+FUtOmqHmlO3W3gAVag312Bhy5q7Ls5euMFGWFW8juEWbkavycueiWfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6/10E02; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6/10E02"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so92579e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785269735; x=1785874535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AgFewBM+P7dksOw/4iikngQqad0tjKaW9YEAK0T1Clc=;
        b=R6/10E02KgqQ3VSX5teGLpRz9wREKSR38llBNHmjWssRO1e0gyddLhLEC86Sd4M+I7
         S9yu99XHcrIESf9zO6EV7AbLdN/TzRIoIGuGqduEhTVZGUOJHqEIQriJK/FvQGeX8kck
         8cv2Ria0yzDGYre+DJeD7T20nVGuDHDiIc5SSUwIonC2BUn7yvahrerM8sY3w+jyNKM9
         O0agjdTIcjt+VNQiHi0qoF7c7kbTAN5wSrxAp6Z5NCQ7bwKgy5sbaOg0j9sBFpOA+vJ1
         gKRSmpRY54vB08Q2YhJGukkTPQj4JJDqQXp5DM7EjlbZ3a6k3duAzfHi5npBfiSbQDMj
         2pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269735; x=1785874535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AgFewBM+P7dksOw/4iikngQqad0tjKaW9YEAK0T1Clc=;
        b=YBTD9vTqiCHsaeiN4Eedn2T0O3YWz3KItMUO40CyNwNuT0sVtCfVcv4o//Fis8jSrT
         lG3bWmrOgloJ6Iimp0aNPAFelwRawjIkZ/lAoF+ri62miLOSZMcq4xn0revpEG/gdp1H
         63yXllUQ3OL2GKOvDkZqc/p6lnRrgLOqeJD4QrkCHWpqDxoSjRyWDkLOZ0yTtFfCFvq0
         pi2Ep4t5q6l7mT07g9iffE8Kie0Q/wSmNjAjvZOAvmrV0rV4HneNDINBp9+DkiYEMTmQ
         t6XjGjfZQajRyL1GIHaZkyQXP2pcCRGEgSrQIYLGuk65Hj7AG/2stKV269kKo/uXBnNo
         N0iw==
X-Gm-Message-State: AOJu0Ywt55PTgBoeeXuOux27LsoVIQ7XEN1SE29CblR6JiGsH59KiTwd
	CpNEno/Nlh3B75cie61nelU7iV+tJN79Qo0TjFBwsIO2FPYu7Kn31N53
X-Gm-Gg: AR+sD11DZI3wBKFlBWBUAWDUE3SC9ovHfzi8Gz+jSF2uO4kRCgMDQ609nlbTn/oZoD3
	99cbYs0AAkAs7+Vu2EbcyHYImdKHZeaabnl33dILKIvYwaQ+zj7sTW7p3Tv3Uf1XxrOWsBH6UTb
	KqHd+/qX2LCpXnBHDunpr0MOLsSMRZibakDyYuDyHlBhgw3a5/eG5ozs4XekrJzIVLi9x7G6xck
	vrIpRj9b5GIN/dEq2cP3bLppZY+O4POJ6j5DrP6kQ936IvYfN7GHfMI+QxaZOfHtUB/K/SMts3d
	WDHVGV5GuGwsPFXvGKzvQOrflq2tIiGAgt0x/NbByQEkf9n8oIjR37RD5hKq7Tpox+xUQ0PUcTx
	xwVZCl2ap1QyfrHq3myaAcchJxP5MNmtQfezKZh/825KxUuo5ZTskC/BFb2+2N+YrBpyNVrJKvB
	hQHrBMaAEaDDVJXMBB+hdXMfrBztyf35BERsR8/UNenqJU3HtMCzQTjD7GaVsBar8HkjLoJVPQ
X-Received: by 2002:a05:6122:4d81:b0:5a4:7e8b:3171 with SMTP id 71dfb90a1353d-5c33fa833a2mr2164406e0c.11.1785269734867;
        Tue, 28 Jul 2026 13:15:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c34f280583sm393616e0c.17.2026.07.28.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:15:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-28
Date: Tue, 28 Jul 2026 16:15:27 -0400
Message-ID: <20260728201527.2456032-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e095f249e2209674f6366f6db0383a2b96e19239:

  net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller (2026-07-28 15:53:49 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-28

for you to fetch changes up to abd93c85c8667add738ee82aeab95dd9fc8265a2:

  Bluetooth: SCO: give the socket its own sco_conn reference (2026-07-28 16:13:48 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix advertising data UAFs
 - hci_conn: hold conn reference fixes
 - L2CAP: fix UAF in l2cap_le_connect_rsp
 - RFCOMM: validate skb length in rfcomm_recv_frame
 - ISO: Locking fixes
 - SCO: give the socket its own sco_conn reference
 - MGMT: fix UAF in pair command cancellation
 - MGMT: fix pending command UAF in EIR updates
 - HIDP: reject frames without a transaction header
 - HIDP: validate numbered report payloads
 - btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
 - btmtk: Fix short read errors in btmtk_usb_reg_read()
 - btusb: Fix short read errors in btusb_qca_send_vendor_req()
 - btintel: Validate length before parsing diagnostics TLV

----------------------------------------------------------------
Aldo Ariel Panzardo (1):
      Bluetooth: SCO: give the socket its own sco_conn reference

Chengfeng Ye (1):
      Bluetooth: hci_sync: Fix advertising data UAFs

Greg Kroah-Hartman (3):
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()

Jiale Yao (2):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
      Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Pauli Virtanen (19):
      Bluetooth: ISO: clear iso_data always when detaching conn from hcon
      Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
      Bluetooth: ISO: lock sk in iso_sock_getname
      Bluetooth: ISO: lock sk in iso_connect_ind
      Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
      Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
      Bluetooth: ISO: hold sk properly in iso_conn_ready
      Bluetooth: ISO: fix leaking sk after socket release
      Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
      Bluetooth: ISO: ensure no dangling hcon references in iso_conn
      Bluetooth: ISO: fix refcounting of iso_conn
      Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
      Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
      Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
      Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
      Bluetooth: hci_sync: hold conn in hci_past_sync() callback
      Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
      Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Zihan Xi (2):
      Bluetooth: mgmt: fix UAF in pair command cancellation
      Bluetooth: mgmt: fix pending command UAF in EIR updates

Zijun Hu (1):
      Bluetooth: btintel: Validate length before parsing diagnostics TLV

 drivers/bluetooth/btintel.c      |   3 +
 drivers/bluetooth/btmtk.c        |  86 ++++++------
 drivers/bluetooth/btusb.c        |  30 ++---
 include/net/bluetooth/hci_core.h |   4 +-
 net/bluetooth/hci_conn.c         |  14 +-
 net/bluetooth/hci_sync.c         | 216 +++++++++++++++++++++----------
 net/bluetooth/hidp/core.c        |  30 +++--
 net/bluetooth/iso.c              | 273 +++++++++++++++++++++++++++------------
 net/bluetooth/l2cap_core.c       |   5 +
 net/bluetooth/mgmt.c             |  84 +++++++++---
 net/bluetooth/rfcomm/core.c      |   5 +
 net/bluetooth/sco.c              |  22 ++--
 12 files changed, 513 insertions(+), 259 deletions(-)
