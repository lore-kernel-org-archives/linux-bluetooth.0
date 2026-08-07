Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E2419305
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132952; cv=none; b=hGwU6RDvLTjQCMvLR/eeKFNq28r0o3ptS9q1oyXQ6LC5lpy4qWlSN4vhMTeTia4MWR38D6rAIF5gAM7cynY5twHGUMgKUMzfIr8h8T16O/KVbiuZqeLOtS10nLC+8b3PxEQgOlbMkZY4kVZdv3bH8HFUDkEERzoHl4wBzQFr38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132952; c=relaxed/simple;
	bh=nNREcFrskMgLQhOyWxgv6KLOsfLKkwUek9MZX7NCYQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRP3lvadCUUDtMATnvFmBEXUMuvnCGfBfaYKrd7aDFHVa4VE/7PSty2QfYrwWaZ2EXDvHEmfjj9iEW+1GUfhilR+OGidvC5ZSWt0GST3nunV8BPwdTIcEjd/FcfwZu4u2hcIqSoPvCKNSyP2rX1/Y+Lr+Vwihcy7rZXn/4TZun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvU/u9yJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvU/u9yJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so1391816e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786132943; x=1786737743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CylUasdOj+GKKoIGSbquj6DD4APH7gHoIjd6xxfChW4=;
        b=hvU/u9yJ3ZTHAX6v/zzYAoRTTC9hpvP76j0dWRailuHQfOiRPoo5MCVUD/hSnY1T0E
         eD5FhfwS/1L2wM/VyGRz7ealuebGYHaWjLCtmQyns+IdMuoiSI3bcTamZrVsVkgjHVAQ
         JuUwMnFY2xolDmevc9Vwfs9oz5UQL6rBjs75dqgMEryjkqVhgeXDvCBhO23FkoCWSdL8
         4Hrt0RqkE+HVfcQ09MtntV79Ob7Ka6urzgEJmD/egbCWF+tU3iiaE1huPatPTzJSIitL
         nALsQ2GUm8ECvuCxnKh3ofk6eiyS9l7nQyVjXESI1hcS9nO2a++a288BltSB0U/hOb/L
         NHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132943; x=1786737743;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CylUasdOj+GKKoIGSbquj6DD4APH7gHoIjd6xxfChW4=;
        b=oja+p0wBRRz1OqO0uchvYIBbzFeghCGaVDdvp7jpTCnNNExJe53drIqnFUOBTIXCZD
         qiqHvQA1oc04xSPgDQCNwYQYTe3uHRBeLfqXIPnTKr/HlL+4mCbzLLyD45536dIZZr+9
         27Z4QAg1jWCkP5/QXlkpDr9ZYkqkO53GqVdKHJmCujA3b/5ci8SB4Ycv6jQtRcTeSwud
         lCFQLO/GtEBWCCs363P+jZlIdJOSgq2sdfjA5jt9EcuD8W0Mw+oNGh/nT7uzGbwKNwxl
         GzN7PXBvzBx4NdEnAiT48+PswOj0/CgiLIprDg2Aqv2MRw2mOT+LAliW4PbgHbsYDUOF
         qi6A==
X-Gm-Message-State: AOJu0YzeQGCsEQyMfO8iNJjDv6IHwf6vsAvtJa90vNzAN+XjyU/mbiI+
	JhCWh0eBt8MSRGeuCf8SwK/vANTAz7eh7e9dghQsvIXRoPuzSS5WdL2m
X-Gm-Gg: AR+sD126401DLo+VdeWn3y/qx9sCKRvaci1rqvT4RWDAAvBNPUHzGspASFbWEJ5t3Ft
	FxDcD15DYkwrW40nVYHT0bGrIGxHtRypHSs+GGw6DSW3k71ry/cpqI0prj8bPl/dnf6UHXzZrAW
	YWlNtVfKLuROLtjzGktNT+Nb/J52lUHL3QNF/L6+W1YapZbhiv1UFgARdoFqAN/sDhMRS2Lec/5
	n86NDMPK8i4AKsVgdLjjQRmdhH94Q90kQSv0ElUt3zPZPnuY/0gmn5FZyVPFAc5PJA/5JlzskM8
	XG2Y4ix/7+FiFQe2lpEVNHHnca0tMw/iFfSVJftSFaY9o7sWoTd6PRdvX+oO/X1JbkTU4PpmYr2
	LIGbFqSx/D4AAnPo2O5pV1NzfVhHxVd8yK6RDF5F+V5kkKwsmSKO/EAZ30PFchhEPz09YogRAwC
	X7zM5GQJRGvIyUONrxPTL2JlICHTwOGLHKKm1lK0Lj6aKeAbXqdNxe7vishCWG5i3MoWEHT6b/O
	NxFyOTKSNUuBMDPOL0wCuKXQSXuZ+Ya/kDdA1nDUKAkIQZwwAekoRU40lUCMTWY2XA=
X-Received: by 2002:a05:6122:3125:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c3d9086b6bmr2991992e0c.3.1786132943262;
        Fri, 07 Aug 2026 13:02:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b20d380sm1073495e0c.15.2026.08.07.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:02:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-08-07
Date: Fri,  7 Aug 2026 16:02:14 -0400
Message-ID: <20260807200215.982570-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4fa4977a0d900f936bcae5cd2c510be5554e8dd6:

  Merge tag 'wireless-next-2026-08-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-08-06 12:39:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-08-07

for you to fetch changes up to 43a556b2fd43f2df6dded59c2e26560a27874c24:

  Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept (2026-08-07 15:40:28 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - HCI: Add support for Shorter Connection Interval (SCI) feature
 - af_bluetooth: Add minimal context analysis annotations

drivers:

 - btusb: Add ASUS USB-BT540 for Realtek 8761CU
 - btusb: Add ASUS USB-BT600 for Realtek 8761CU
 - btusb: Add USB ID 13d3:3625 for MediaTek MT7922
 - btusb: Add support for 1357:c123 Realtek 8852BE device
 - btusb: Add new VID/PID 0x0489/0xe156 for MT7902
 - btintel: Add Bluetooth SAR revision 2 support
 - btintel_pcie: Add vendor_reset PCI sysfs for PLDR
 - btnxpuart: Add M.2 Bluetooth device support using pwrseq

----------------------------------------------------------------
Ali Ahmet Memis (5):
      Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
      Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
      Bluetooth: ISO: zero the sockaddr before returning it in getname
      Bluetooth: MSFT: validate evt_prefix_len against the response length
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

Chen Changcheng (2):
      Bluetooth: btintel_pcie: Remove unreachable break after goto
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration

Chengfeng Ye (2):
      Bluetooth: hci_event: fix LE list UAF on reset
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Christoph Zwerschke (2):
      Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
      Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

Dmitry Antipov (1):
      Bluetooth: simplify force_no_mitm_write() with kstrtobool_from_user()

Guangshuo Li (1):
      Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative

Gustavo Evgucci (1):
      Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922

HyeongJun An (1):
      Bluetooth: virtio_bt: avoid OOB read of build info string

Iva Kasprzaková (1):
      Bluetooth: fix BT dependency for submodules

Kiran K (3):
      Bluetooth: btintel_pcie: split coredump worker into per-trigger works
      Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
      Bluetooth: btintel: Add Bluetooth SAR revision 2 support

Laxman Acharya (1):
      Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

Laxman Acharya Padhya (2):
      Bluetooth: hci_aml: validate firmware segment lengths
      Bluetooth: hci_event: validate LE Set CIG Parameters response

Li Qiang (4):
      Bluetooth: bfusb: validate received block boundaries
      Bluetooth: btmrvl: validate event packet lengths
      Bluetooth: hci_bcsp: validate received packet lengths
      Bluetooth: hci_ldisc: reject invalid tty write lengths

Linmao Li (4):
      Bluetooth: hci_conn: fix the SCO setup context lifetime
      Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
      Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
      Bluetooth: MGMT: free the HCI command when it is cancelled

Luiz Augusto von Dentz (3):
      Bluetooth: Add support for Shorter Connection Interval (SCI) feature
      Bluetooth: Add MGMT Shorter Connection Interval setting
      Bluetooth: Add MGMT Load Connection Subrate command

Marek Szyprowski (1):
      Bluetooth: btmrvl: fix event packet length validation

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Pauli Virtanen (7):
      Bluetooth: af_bluetooth: Add minimal context analysis annotations
      Bluetooth: hci_core: Add minimal context analysis annotations
      Bluetooth: L2CAP: Add minimal context analysis annotations
      Bluetooth: RFCOMM: Add minimal context analysis annotations
      Bluetooth: enable context analysis
      Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
      Bluetooth: add annotations for l2cap_data locking context

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pawel Zalewski (The Capable Hub) (2):
      Bluetooth: use a named initializer for acpi_device_id
      Bluetooth: hci_intel: drop unused assignment of acpi_device_id::driver_data

Pengpeng Hou (1):
      Bluetooth: hci_nokia: validate firmware packet bounds

Sean Wang (1):
      Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902

Sherry Sun (1):
      Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq

Siwei Zhang (1):
      Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Zhao Dongdong (1):
      Bluetooth: btnxpuart: Fix use-after-free in probe error path

Zijun Hu (31):
      Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
      Bluetooth: btusb: QCA: move qca_dump out of struct btusb_data
      Bluetooth: hci_sync: Introduce __hci_reset_sync() for device drivers
      Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()
      Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()
      Bluetooth: hci_sync: Simplify hci_reset_sync()
      Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()
      Bluetooth: btusb: Reduce a redundant assignment in btusb_probe()
      Bluetooth: btusb: Use & instead of == to test bitflag BTUSB_IGNORE
      Bluetooth: coredump: Do not export hci_devcd_rx() and hci_devcd_timeout()
      Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
      Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *
      Bluetooth: btusb: Add a simple static btusb_prepare_reset()
      Bluetooth: hci: Introduce hci_acl_handle() and hci_acl_dlen() helpers
      Bluetooth: hci_core: Simplify hci_recv_frame() by hci_acl_handle()
      Bluetooth: btusb: Simplify btusb_recv_bulk() by hci_acl_dlen()
      Bluetooth: btintel: Simplify btintel_classify_pkt_type() by hci_acl_handle()
      Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()
      Bluetooth: btintel: Fix diagnostics event detection
      Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()
      Bluetooth: coredump: Expose header size and end marker to drivers
      Bluetooth: hci_core: Introduce __hci_reset_dev() with a hardware error code
      Bluetooth: btnxpuart: Simplify nxp_set_ind_reset() by __hci_reset_dev()
      Bluetooth: hci_event: Introduce handle_ev_vendor() for HCI_EV_VENDOR
      Bluetooth: hci_event: Use 255 as max event payload length in hci_ev_table[]

oshada imalka (1):
      Bluetooth: hcli_ldisc: Remove reduntant braces

 .../ABI/testing/sysfs-bus-pci-drivers-btintel_pcie |  15 +
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/Makefile                         |   2 +
 drivers/bluetooth/bfusb.c                          |  37 ++-
 drivers/bluetooth/btintel.c                        | 200 +++++++++++-
 drivers/bluetooth/btintel.h                        |  18 ++
 drivers/bluetooth/btintel_pcie.c                   | 299 ++++++++++++------
 drivers/bluetooth/btintel_pcie.h                   |  12 +-
 drivers/bluetooth/btmrvl_main.c                    |  20 ++
 drivers/bluetooth/btmrvl_sdio.c                    |   2 +-
 drivers/bluetooth/btmtksdio.c                      |   3 +
 drivers/bluetooth/btnxpuart.c                      |  52 ++--
 drivers/bluetooth/btqca.c                          |  25 +-
 drivers/bluetooth/btrsi.c                          |   3 +-
 drivers/bluetooth/btusb.c                          | 137 +++++----
 drivers/bluetooth/hci_aml.c                        |  18 +-
 drivers/bluetooth/hci_bcm.c                        | 336 ++++++++++-----------
 drivers/bluetooth/hci_bcsp.c                       |   5 +-
 drivers/bluetooth/hci_h5.c                         |   6 +-
 drivers/bluetooth/hci_intel.c                      |   4 +-
 drivers/bluetooth/hci_ldisc.c                      |  10 +-
 drivers/bluetooth/hci_nokia.c                      |  20 ++
 drivers/bluetooth/hci_qca.c                        |  16 +-
 drivers/bluetooth/virtio_bt.c                      |   8 +-
 include/net/bluetooth/coredump.h                   |  14 +
 include/net/bluetooth/hci.h                        |  64 ++++
 include/net/bluetooth/hci_core.h                   |  33 +-
 include/net/bluetooth/hci_sync.h                   |   5 +-
 include/net/bluetooth/mgmt.h                       |  29 ++
 net/bluetooth/6lowpan.c                            |   2 +
 net/bluetooth/Kconfig                              |   2 +-
 net/bluetooth/Makefile                             |   2 +
 net/bluetooth/af_bluetooth.c                       |   7 +-
 net/bluetooth/bnep/Kconfig                         |   2 +-
 net/bluetooth/bnep/Makefile                        |   2 +
 net/bluetooth/coredump.c                           |  54 +++-
 net/bluetooth/hci_conn.c                           |  20 +-
 net/bluetooth/hci_core.c                           |  12 +-
 net/bluetooth/hci_debugfs.c                        |  12 +-
 net/bluetooth/hci_event.c                          | 122 +++++++-
 net/bluetooth/hci_sync.c                           | 265 +++++++++++++---
 net/bluetooth/hidp/Kconfig                         |   2 +-
 net/bluetooth/hidp/Makefile                        |   2 +
 net/bluetooth/iso.c                                |  32 +-
 net/bluetooth/l2cap_core.c                         |  32 +-
 net/bluetooth/l2cap_sock.c                         |   1 +
 net/bluetooth/mgmt.c                               | 169 ++++++++++-
 net/bluetooth/msft.c                               |   5 +
 net/bluetooth/rfcomm/Kconfig                       |   2 +-
 net/bluetooth/rfcomm/Makefile                      |   2 +
 net/bluetooth/rfcomm/core.c                        |  24 +-
 net/bluetooth/rfcomm/sock.c                        |   1 +
 net/bluetooth/smp.c                                |   7 +-
 net/bluetooth/smp.h                                |   6 +-
 54 files changed, 1671 insertions(+), 510 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
