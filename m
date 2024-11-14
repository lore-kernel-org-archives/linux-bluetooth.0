Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF66F073
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620015; cv=none; b=jta+6lHP+mEnA2FwZAuHJz4GURMb6UGLjzIaDI69iEP5MCNGJfkeKNHPNMxZoPlrdsK1Iz9QEOhcnPuis9Zvd6cZX9S4u6Zg4BzQaHKvTkNCB1ay095jWDZ87gTpmLh9wSKDWZPm6eHTeKT95peKuZ6AsIxAxWlVBMYGyIWPoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620015; c=relaxed/simple;
	bh=SatbvP193iS7Fu+xHHx1UqmRJ8b/vQGCd17EeoYanlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I3VdemsdnY8rKYsUlQsw7Bovk3T28x47Dn+xGDssYmXQ0PP04RXEln1Cj0pBpN+/5P7vNAi9J6DQy/WEqyKt8ypzBBQoIouO873f52COdDhsr/a2ex8pmH3uladhL5bL05o645CEJXSH7wVu4cUQKhkyxPrsvMieSsViH4Ut1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYdepx5d; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYdepx5d"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-855f2cf1ad4so459767241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731620012; x=1732224812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bcLkEcgUXdJIzj+rj0yvAgKq6BhMsYDcM08hMXGCKQ=;
        b=HYdepx5duCdmft6vdMk6+krIX2yG+cOHUxqxZ5PKZHpOqzCFA8skyCX33uvugB65aU
         w+5XAsPSPJlsoQx7YiEOCrFF5d7ftdcgGYOKGzgnROxkdixY6G+8nZhE4BYwxmfVRa6i
         GXmNaOWeiqnMJcuR5V5q24OuGwXQ7Cmb7UXvPxOFwgcP+JGTLzNxHxe17bfsX1OydV/a
         qHyIP4cyWjeOJwrG1+Jb52uO5EyBKkV1SOwMisIDwjjsBYqHdCBiMHtykhtbMApQTKkc
         jz3AM+Htp6kojc/hwTDCzP9nmnLbpzklZXNqixDUxbviOPEQDaPdybS4eHUIz/+j1rtl
         2ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620012; x=1732224812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bcLkEcgUXdJIzj+rj0yvAgKq6BhMsYDcM08hMXGCKQ=;
        b=a01bTQ9MQ22WMF46CjZ34KaNmPItTpxaQBJiSr48/lFRBwKVP9d0YcSvetMPdcr0av
         vwI1wuB0RTyVAVOFu84ixkJN5vmEnN39obG4uRoNxCHU1DH+RCn0wuNwYbpJ1fuHh2kK
         FfloF4BeCZV1p1iPfDuLWJWF5L5Eumjl6fj3c8l+Fzs3L5yut+HhqpxO2vtkkMl9jHWA
         rSSOaYJ3I1Aa+W5ddGxXjzscc22z01i0tbzkXGxFZLCezgm9EUPVNcwPVXNNR4Z8jHff
         3VdkwsAiW95GBmdi9R0MzBfReDd8BYhXmkXsCOGaTbiuHW2J6HAjxejonVkDr8SGKc1j
         hubw==
X-Gm-Message-State: AOJu0Yx5oLZQbmnRXfeEox1zXRMcHJN2jX6TzSPowVdyWiQoDO+pmqE/
	PkUlUTId4qTvVplBjfKvVyE+ssehde66ulgbzhpmMsWvhhC9LJGrl26IIg==
X-Google-Smtp-Source: AGHT+IE2R2t2E8Fvw3BjooD43zBuUt5VzyuMKDuavPmSJifWWER525oZmmOTn/+98FVYq1H2NlohkQ==
X-Received: by 2002:a05:6102:3f03:b0:4a3:db6a:dbbf with SMTP id ada2fe7eead31-4ad62bffe1amr831331137.14.1731620012214;
        Thu, 14 Nov 2024 13:33:32 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856dfd84de4sm22735241.24.2024.11.14.13.33.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:33:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2024-11-14
Date: Thu, 14 Nov 2024 16:33:28 -0500
Message-ID: <20241114213328.1991275-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3d12862b216d39670500f6bd44b8be312b2ee4fb:

  eth: fbnic: Add support to dump registers (2024-11-14 15:28:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-11-14

for you to fetch changes up to 827af4787e74e8df9e8e0677a69fbb15e0856d2f:

  Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC (2024-11-14 15:41:31 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
 - btmtk: Fix ISO interface handling
 - Add quirk for ATS2851
 - btusb: Add RTL8852BE device 0489:e123
 - ISO: Do not emit LE PA/BIG Create Sync if previous is pending
 - btusb: Add USB HW IDs for MT7920/MT7925
 - btintel_pcie: Add handshake between driver and firmware
 - btintel_pcie: Add recovery mechanism
 - hci_conn: Use disable_delayed_work_sync
 - SCO: Use kref to track lifetime of sco_conn
 - ISO: Use kref to track lifetime of iso_conn
 - btnxpuart: Add GPIO support to power save feature
 - btusb: Add 0x0489:0xe0f3 and 0x13d3:0x3623 for Qualcomm WCN785x

----------------------------------------------------------------
Aaron Ma (1):
      Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andy Shevchenko (1):
      Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()

Chen-Yu Tsai (1):
      Bluetooth: btmtksdio: Lookup device node only as fallback

Chris Lu (5):
      Bluetooth: btusb: mediatek: move Bluetooth power off command position
      Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
      Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
      Bluetooth: btusb: mediatek: change the conditions for ISO interface
      Bluetooth: btmtk: adjust the position to init iso data anchor

Colin Ian King (1):
      Bluetooth: btintel_pcie: remove redundant assignment to variable ret

Danil Pylaev (3):
      Bluetooth: Add new quirks for ATS2851
      Bluetooth: Support new quirks for ATS2851
      Bluetooth: Set quirks for ATS2851

Dmitry Antipov (1):
      Bluetooth: fix use-after-free in device_for_each_child()

Everest K.C. (1):
      Bluetooth: btintel_pcie: Remove deadcode

Hao Qin (1):
      Bluetooth: btusb: Add new VID/PID 0489/e111 for MT7925

Hilda Wu (2):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables
      Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s

Iulia Tanasescu (6):
      Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
      Bluetooth: ISO: Fix matching parent socket for BIS slave
      Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
      Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave
      Bluetooth: hci_conn: Remove alloc from critical section
      Bluetooth: ISO: Send BIG Create Sync via hci_sync

Javier Carrasco (1):
      Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
      Bluetooth: btusb: Add 3 HWIDs for MT7925

Jonathan McCrohan (1):
      Bluetooth: btusb: Add new VID/PID 0489/e124 for MT7925

Kiran K (5):
      Bluetooth: btintel_pcie: Add handshake between driver and firmware
      Bluetooth: btintel_pcie: Add recovery mechanism
      Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP
      Bluetooth: btintel: Do no pass vendor events to stack
      Bluetooth: btintel: Direct exception event to bluetooth stack

Luiz Augusto von Dentz (8):
      Bluetooth: hci_conn: Use disable_delayed_work_sync
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
      Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
      Bluetooth: HCI: Add IPC(11) bus type
      Bluetooth: SCO: Use kref to track lifetime of sco_conn
      Bluetooth: ISO: Use kref to track lifetime of iso_conn
      Bluetooth: hci_core: Fix calling mgmt_device_connected
      Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC

Markus Elfring (1):
      Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions

Neeraj Sanjay Kale (4):
      Bluetooth: btnxpuart: Drop _v0 suffix from FW names
      Bluetooth: btnxpuart: Rename IW615 to IW610
      dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
      Bluetooth: btnxpuart: Add GPIO support to power save feature

Philipp Stanner (1):
      Bluetooth: btintel_pcie: Replace deprecated PCI functions

Yan Zhen (1):
      bluetooth: Fix typos in the comments

Zijun Hu (2):
      Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
      Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |   8 +
 drivers/bluetooth/btbcm.c                          |   4 +-
 drivers/bluetooth/btintel.c                        | 113 +++++-
 drivers/bluetooth/btintel.h                        |  10 +
 drivers/bluetooth/btintel_pcie.c                   | 387 ++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h                   |  18 +-
 drivers/bluetooth/btmtk.c                          |   3 +-
 drivers/bluetooth/btmtksdio.c                      |  21 +-
 drivers/bluetooth/btmtkuart.c                      |   2 +-
 drivers/bluetooth/btnxpuart.c                      |  81 ++++-
 drivers/bluetooth/btrtl.c                          |   2 +-
 drivers/bluetooth/btusb.c                          |  76 +++-
 drivers/bluetooth/hci_bcm.c                        |  25 +-
 drivers/bluetooth/hci_ldisc.c                      |   2 +-
 drivers/bluetooth/hci_ll.c                         |   2 +-
 drivers/bluetooth/hci_nokia.c                      |   2 +-
 drivers/bluetooth/hci_qca.c                        |  32 +-
 include/net/bluetooth/hci.h                        |  19 +-
 include/net/bluetooth/hci_core.h                   |  85 ++++-
 include/net/bluetooth/mgmt.h                       |  10 +
 net/bluetooth/hci_conn.c                           | 230 ++++++++----
 net/bluetooth/hci_core.c                           |  28 +-
 net/bluetooth/hci_event.c                          |  47 ++-
 net/bluetooth/hci_sync.c                           |   9 +-
 net/bluetooth/hci_sysfs.c                          |  15 +-
 net/bluetooth/iso.c                                | 121 +++++--
 net/bluetooth/mgmt.c                               |  60 ++++
 net/bluetooth/rfcomm/sock.c                        |  10 +-
 net/bluetooth/sco.c                                |  99 ++++--
 29 files changed, 1219 insertions(+), 302 deletions(-)
