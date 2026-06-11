Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38070332EBC
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202851; cv=none; b=pHN8v6Am7pfqFPTdqAebtXthzlP9ydn19Y5Sc3+de1K84t0/dMMIk8m3W18XvkFVP76Y52aB6+i7NFpM+b7thDNLQX5UFVjy7rfoIMZ7gmzc90iUuLYE6C002lQYrQTDOxejYo5MXuiQmcfXqWBzQV7UpqLz7Taf0WuUkxDfozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202851; c=relaxed/simple;
	bh=WXgqjzk3UWe/jXrL2M+IBs9sdYVmhhnsD38oJ8U0xr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQbvpwlSqxSkNMurp4BpvIqriW+VePXxOB497L7K2AsMK+n60t1nmikgqScpGpdL6jK9BfI3dXyjMNR4ih21dGEUcOdv5Y6yoNXHGuGxjJG0m2E5kU6/TOPVnOOA6qAO7HGnuI94XL3K9yMaF0433YGUBHw/Wkl4syP9RT6mi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC1vLeCD; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC1vLeCD"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59c627b53a0so34903e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781202848; x=1781807648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJl8vFJs1ksF6PwBy+VbjnmpLd0PR4Ukn/whmZHSD+s=;
        b=aC1vLeCDanj3YWSyQmDhxseSryKeHX+rA7vOfHgPfwAVqC/lRckKyq5VRbiPFw3zA3
         7Z/pkUXBqhaTO27avmdq6q2jA2NcBjHPbKCIdKq89p7dYAHm6yuzm3Nlu+jgVTCV06x9
         UUw1kOwUlzhAOEqODfZrcrdHzfRN5HQ69E1xyDSTJIYVBxLiDsidS9FsfOSyLOyqC0/s
         zqVeoQzHQJ8F5HL/NN8bzb31m1iH3ZVhcCWD5o5A4NEqKzyIQU7227sVM5smcLMh5VxP
         HJrzRV7OckAxyR8Y/m9aXKPrlaWO36xie75b/MVCYWk+hXFk0kJOvVmzotVk/YnCg1Ct
         0Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202848; x=1781807648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJl8vFJs1ksF6PwBy+VbjnmpLd0PR4Ukn/whmZHSD+s=;
        b=he/iq7De+a4oCxLbODORpSbKzVnBhMbSmVEvuTsz3SEpsfiLkaGPMyYsbRa6U3OFBc
         EvLgWEhUsoIxGVQM+gEJa19HaqmqhztnYFk7kQ1QssnAZuw74hKRs5vBGEyat7tMhT7p
         qn4GEsuLfK5i+r0K/8effCyRSAqJzHy45zNPdQpTfVe0X5JluPsc83nynGqDrHNVFqVi
         mTHk3Kji4wYkJ+Q2+cKzdcsd2FvrFD4VvcY25AgZreKfFs0gLeNmNYMy9eSebpMLduf5
         BPWZng4+HVuNmRWkP5QKxZFXTowFmaKMpnwATc7yUUBRkIvpIrB2bDh/qUesT7uzIMS2
         rFGw==
X-Gm-Message-State: AOJu0YxruKxQ7tcN3wsOpBT7Gt0mpiJl2Afi/diwIXJn52Yb0Wud5xAW
	FK8CWspPH8xWxnUHz2ietpZd7OR7m6/wHwbj40ofGsdr1Oe1Ib0tS0IbCHD146UB
X-Gm-Gg: Acq92OHTthOdb9HgWANJTLpa30BO2FIbhJvqFbQl0pgcQVLzMWpRSsprJn90/FINMXV
	Wjg5nKKgKodsoHlqLANEQBpjCBKyoWE1482atXsPVNMk/K6kgLGM39j7vTL3L4wyF1g0M5HLgb+
	FlDfYoNcEPvcXIeNmk0SQ/1o76cyJTO7BY+jl3diFmeTTnVI5FJpbe8ryj6NHW/ZLrOKtlphuRa
	vp2DrYvD80046PfzzAnx+MwpK2BreFQwVwiuVdNUbdFokaVZvZZml6ORIFirDtBcbImzWhCNy6H
	lThIYe83XT6ezwnC+N/yBYh+q5QkCg6NnFrls+dk9ZEBpmJMpOzIBcQ0g8xq6jdJBjCY653qpaq
	uaiiajX57W5+rW2oFVig1y+l09xaKr9ayLorRnm2x3ylAbwBSKU5fW20gQVTPYqfSluFCS+L+BL
	4RJmHXmDUNJ6lcQNCTTIvEDudTUGTfiTCecootaQF1rbNdabGRQmIWbm6As7zMsDrAH/ztBt2TB
	hNivqwJJGC0/+iB7w==
X-Received: by 2002:a05:6122:c92:b0:5a6:7838:d679 with SMTP id 71dfb90a1353d-5bb02415951mr2627736e0c.13.1781202847381;
        Thu, 11 Jun 2026 11:34:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb690118cfsm121804e0c.5.2026.06.11.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:34:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-06-11
Date: Thu, 11 Jun 2026 14:33:58 -0400
Message-ID: <20260611183358.176776-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 518d8d0199538a4d6d5e51064044ece71e0c42e7:

  net: sched: avoid printing uninitialized link speed (2026-06-11 15:44:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-06-11

for you to fetch changes up to f70f7f2512c6b9113dc78f6a25361166afd1412e:

  Bluetooth: btintel_pcie: Separate coredump work from RX work (2026-06-11 14:24:42 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:
 - hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]
 - SMP: Use AES-CMAC library API
 - sockets: convert to getsockopt_iter
 - Add SPDX id lines to some source files

drivers:
 - btintel_pcie: Support Product level reset
 - btintel_pcie: Add support for smart trigger dump
 - btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
 - btintel_pcie: Separate coredump work from RX work
 - btmtk: add event filter to filter specific event
 - btrtl: fix RTL8761B/BU broken LE extended scan
 - btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
 - btusb: Add Realtek RTL8922AE VID/PID 0bda/d923
 - btusb: MT7922: Add VID/PID 0e8d/223c
 - btusb: MT7925: Add VID/PID 0e8d/8c38
 - btusb: Add support for TP-Link TL-UB250
 - btusb: Add Mercusys MA530 for Realtek RTL8761BUV
 - btusb: Add TP-Link UB600 for Realtek 8761BUV
 - btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
 - btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
 - btusb: MT7925: Add VID/PID 13d3/3609

----------------------------------------------------------------
Alexej Sidorenko (1):
      Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan

Breno Leitao (6):
      Bluetooth: hci_sock: write the full optval for getsockopt
      Bluetooth: hci_sock: convert to getsockopt_iter
      Bluetooth: ISO: convert to getsockopt_iter
      Bluetooth: RFCOMM: convert to getsockopt_iter
      Bluetooth: L2CAP: convert to getsockopt_iter
      Bluetooth: SCO: convert to getsockopt_iter

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Support Product level reset

Chen Zhang (2):
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923

Chris Lu (3):
      Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
      Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
      Bluetooth: btmtk: add event filter to filter specific event

Cris (1):
      Bluetooth: btusb: Add support for TP-Link TL-UB250

Eric Biggers (2):
      Bluetooth: Remove unneeded crypto kconfig selections
      Bluetooth: SMP: Use AES-CMAC library API

Ethan Nelson-Moore (1):
      bluetooth: remove all PCMCIA drivers

Hrvoje Nuic (1):
      Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

Jiajia Liu (2):
      Bluetooth: btmtk: remove extra copy in cmd array init
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Johan Hovold (5):
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      Bluetooth: btusb: fix wakeup irq devres lifetime
      Bluetooth: btusb: clean up probe error handling

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Kiran K (2):
      Bluetooth: btintel_pcie: Add support for smart trigger dump
      Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Nils Helmig (1):
      Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV

Pauli Virtanen (1):
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Ravindra (2):
      Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
      Bluetooth: btintel_pcie: Separate coredump work from RX work

Rong Zhang (1):
      Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant

Samuel Moelius (3):
      Bluetooth: hci: validate codec capability element length
      Bluetooth: L2CAP: validate connectionless PSM length
      Bluetooth: vhci: validate devcoredump state before side effects

Sergey Senozhatsky (1):
      Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()

Sergey Shtylyov (1):
      Bluetooth: hci_h5: reset hci_uart::priv in the close() method

Tim Bird (1):
      Bluetooth: Add SPDX id lines to some source files

Weiming Shi (1):
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

Xiuzhuo Shang (1):
      Bluetooth: qca: Add BT FW build version to kernel log

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB

Zhao Dongdong (1):
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path

Zijun Hu (2):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

luke-yj.chen (1):
      Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609

 arch/arm/configs/pxa_defconfig              |   3 -
 arch/arm/configs/spitz_defconfig            |   3 -
 arch/loongarch/configs/loongson32_defconfig |   3 -
 arch/loongarch/configs/loongson64_defconfig |   3 -
 arch/mips/configs/mtx1_defconfig            |   3 -
 arch/powerpc/configs/ppc6xx_defconfig       |   3 -
 drivers/bluetooth/Kconfig                   |  42 +-
 drivers/bluetooth/Makefile                  |   3 -
 drivers/bluetooth/bluecard_cs.c             | 908 ----------------------------
 drivers/bluetooth/bt3c_cs.c                 | 749 -----------------------
 drivers/bluetooth/btintel.c                 |  10 +-
 drivers/bluetooth/btintel.h                 |   9 +
 drivers/bluetooth/btintel_pcie.c            | 502 +++++++++++++--
 drivers/bluetooth/btintel_pcie.h            |  26 +-
 drivers/bluetooth/btmtk.c                   |  39 +-
 drivers/bluetooth/btmtk.h                   |   7 +
 drivers/bluetooth/btmtksdio.c               |   2 +-
 drivers/bluetooth/btqca.c                   |   2 +
 drivers/bluetooth/btrsi.c                   |  12 +-
 drivers/bluetooth/btrtl.c                   |  13 +
 drivers/bluetooth/btusb.c                   |  94 ++-
 drivers/bluetooth/dtl1_cs.c                 | 614 -------------------
 drivers/bluetooth/hci_h5.c                  |   1 +
 drivers/bluetooth/hci_qca.c                 |  11 +-
 drivers/bluetooth/hci_vhci.c                |  10 +
 include/net/bluetooth/bluetooth.h           |   5 +-
 include/net/bluetooth/hci.h                 |  11 +-
 include/net/bluetooth/hci_core.h            |   5 +-
 include/net/bluetooth/hci_mon.h             |   5 +-
 include/net/bluetooth/hci_sock.h            |   5 +-
 include/net/bluetooth/l2cap.h               |   6 +-
 include/net/bluetooth/mgmt.h                |   5 +-
 include/net/bluetooth/rfcomm.h              |   5 +-
 include/net/bluetooth/sco.h                 |   5 +-
 net/bluetooth/6lowpan.c                     |  25 +-
 net/bluetooth/Kconfig                       |   6 +-
 net/bluetooth/af_bluetooth.c                |   5 +-
 net/bluetooth/bnep/core.c                   |   5 +-
 net/bluetooth/bnep/netdev.c                 |   5 +-
 net/bluetooth/bnep/sock.c                   |   5 +-
 net/bluetooth/ecdh_helper.c                 |   5 +-
 net/bluetooth/ecdh_helper.h                 |   5 +-
 net/bluetooth/eir.c                         |   8 +-
 net/bluetooth/hci_codec.c                   |   2 +-
 net/bluetooth/hci_conn.c                    |   5 +-
 net/bluetooth/hci_core.c                    |   7 +-
 net/bluetooth/hci_debugfs.c                 |   5 +-
 net/bluetooth/hci_debugfs.h                 |   5 +-
 net/bluetooth/hci_event.c                   |  12 +-
 net/bluetooth/hci_sock.c                    |  31 +-
 net/bluetooth/hci_sync.c                    |  24 +-
 net/bluetooth/hidp/core.c                   |   5 +-
 net/bluetooth/hidp/hidp.h                   |   5 +-
 net/bluetooth/hidp/sock.c                   |   5 +-
 net/bluetooth/iso.c                         |  27 +-
 net/bluetooth/l2cap_core.c                  |  44 +-
 net/bluetooth/l2cap_sock.c                  |  66 +-
 net/bluetooth/lib.c                         |   5 +-
 net/bluetooth/mgmt.c                        |   5 +-
 net/bluetooth/mgmt_util.c                   |   5 +-
 net/bluetooth/mgmt_util.h                   |   5 +-
 net/bluetooth/rfcomm/core.c                 |   5 +-
 net/bluetooth/rfcomm/sock.c                 |  35 +-
 net/bluetooth/rfcomm/tty.c                  |   5 +-
 net/bluetooth/sco.c                         |  64 +-
 net/bluetooth/selftest.c                    |   5 +-
 net/bluetooth/selftest.h                    |   5 +-
 net/bluetooth/smp.c                         | 185 ++----
 net/bluetooth/smp.h                         |   5 +-
 69 files changed, 955 insertions(+), 2810 deletions(-)
 delete mode 100644 drivers/bluetooth/bluecard_cs.c
 delete mode 100644 drivers/bluetooth/bt3c_cs.c
 delete mode 100644 drivers/bluetooth/dtl1_cs.c
