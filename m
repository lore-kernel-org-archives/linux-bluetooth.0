Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5055246781
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086581; cv=none; b=Hyo4fYAO86wgf02mTc5ek3nWTUWvK/fxVr+4iE8iwH4fE4LdZTl/pGub3v8ARDVCZ9cPD5Fmzsn/FgbcUsDyKxYsi1lPWy/VmyaTYLvE2sV/TB3IkWhZj0XunvDwMjb3HQD7HUla8pyewQo2ufpIHTHsFWwrtZ4qZrJXH7XUPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086581; c=relaxed/simple;
	bh=qRT5bCyfsZocUIjQFHoiRZiMPLaCEanZRSedjTq1fHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BklHKA8Bq+gRPfR+Ljmb7uutwrpxUjb0ZKCaqHSrJnXsPYFJ2XM/cc/DFEcg+rpN8gnnIZpm77PxOwDStXjBsLj+NELPgjR3sSaMflyON5GjGp06HOHKvFJUUTX7/w1VektAAdUKJGJdHQXW0kufIBHnadBrlVR5Ri6/cC+pG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6jG/1aJ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6jG/1aJ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56eec951db1so1404512e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776086577; x=1776691377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCGHzY1FMguIBQXBT4VFc+kDu77bLE052c7KyR1b0is=;
        b=c6jG/1aJkkDnEVEe/GnCaXWz6ON2T76/N83snaXuRmh4pjYSZ3QpQB7WTkxSkZU7Zt
         qVoSjZmr+HzeF1qfAWByQ8cmxI6MKdoxg577k2ST7z4wYP9Z+IAQPF3TiAfJvI8Rw2id
         dg4jqGsDgksyC9jmahxTV7Oj10fRPwWyF/g8/QsvAR3n06R2AovNzY3fn2tn3DmF395o
         5BNMuBtUFgVJe+oOpMkx3utMKgBqfzrtLlgxN4cUlJfAPFNseh0ivPQZUpkH2C/tyuuA
         6CXkP9ILsOiKDknHSqga7CQcfSiZOzR90VbMl2WDx6CgT8VkIG0QV4Rr+dSy+gpRjC7Z
         Ux9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086577; x=1776691377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCGHzY1FMguIBQXBT4VFc+kDu77bLE052c7KyR1b0is=;
        b=XqtOWd746izZ605YqYeYkyWDdfMK/QS51V+UodCIBZ6fozgHTTCwf3UBh2ZEHNYfvC
         +e5SKOfWWrSkkDHpYD22oBC7NQ4bYLXOIV9c4FVk0lIIEwEUG3oea+Rd/szzfJ+KJ7fO
         xnycJAMLyp+pLC1KfTrMJAUcXHf2/VlpEd6aoyMoxRS4ZId8QPR5T3oXQZOWypGa1V4r
         ttPlIxti49Aja0r27xOzus5jm6AKhjKH9TEUf4vPOx3vIY2GyP+N1LFcs4DMqwV4ahr7
         OhzMYhIMapD163FYCVQ4F+v/oUhU4VwxMmoSR/XA9dN1pbsdNt3jnXwCtSkUJe3G55OY
         +LZw==
X-Gm-Message-State: AOJu0YxNyqxgjRZgKTgXeRX4xNcu/yTJprnPbFvrdMl6a+vDl5Uzupsz
	674/z+QGelC6cfouYdnADalHOnkOdNbJrTPB7nZt/QrTCTvRM1x5CX8B
X-Gm-Gg: AeBDiesDhla35Z7kuypNgWN9mt4N7WNQiNI0V58D7+4ZlilLIOZgkey6ypI1etEh7JM
	9P3Z9szgvP1VeEGUMPLt48yZ2EiwOepWcJ/+tSObleXcjMPg+M8ifwjZB0qItVjPpdCw31tvDMG
	EHlbXe0/aw8deifQl8CYokZ70qRe3HpZ3ADsbFc2AePO7gPyqZs6MUzl+iXRTlADDB0qGC+sKUH
	qbvOE97ew6hLT+UcSsJkAuO7reTtqmFZzRr3O449woskRKwEb3/xNaQ9NphY+LRL41geyAXnh30
	9dxMfKraxmiYzpCGOGomjYLBxR3RoVATsmYx5DDUnTZnU1bJe9MQLUkb5XQHckx5bf5KDa3dzL5
	vCWB0vYbNOQCqcYgJK9NFv4nQoExqmqWgOX6j3I8+u2ZIFEEu3jZVR0jjHKcBZGxlih+Y2MY+YB
	Nf+Ctk5msLZx71TLgUpboDMVteYZa9KdS32jjslMmtQmqkpzYGrugaZYbduartKdECLkqr7F96+
	vZ5CSCW7+A9EtXPww==
X-Received: by 2002:a05:6122:2a02:b0:56f:1ea2:8609 with SMTP id 71dfb90a1353d-56f3bba0573mr6274623e0c.3.1776086577504;
        Mon, 13 Apr 2026 06:22:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f3b96f510sm6864034e0c.9.2026.04.13.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:22:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-04-13
Date: Mon, 13 Apr 2026 09:22:47 -0400
Message-ID: <20260413132247.320961-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:

  tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13

for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:

  Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:
 - hci_core: Rate limit the logging of invalid ISO handle
 - hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
 - hci_event: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
 - hci_event: fix potential UAF in SSP passkey handlers
 - HCI: Avoid a couple -Wflex-array-member-not-at-end warnings
 - L2CAP: CoC: Disconnect if received packet size exceeds MPS
 - L2CAP: Add missing chan lock in l2cap_ecred_reconf_rsp
 - L2CAP: Fix printing wrong information if SDU length exceeds MTU
 - SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

drivers:
 - btusb: MT7922: Add VID/PID 0489/e174
 - btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
 - btusb: Add MT7927 IDs ASUS ROG Crosshair X870E Hero, Lenovo Legion Pro 7
          16ARX9, Gigabyte Z790 AORUS MASTER X, MSI X870E Ace Max, TP-Link
          Archer TBE550E, ASUS X870E / ProArt X870E-Creator.
 - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e8d/1ede
 - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e8d/1ede
 - btusb: MediaTek MT7922: Add VID 0489 & PID e11d
 - btintel: Add support for Scorpious Peak2 support
 - btintel: Add support for Scorpious Peak2F support
 - btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
 - btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
 - btmtk: Add reset mechanism if downloading firmware failed
 - btmtk: Add MT6639 (MT7927) Bluetooth support
 - btmtk: fix ISO interface setup for single alt setting
 - btmtk: add MT7902 SDIO support
 - Bluetooth: btmtk: add MT7902 MCU support
 - btbcm: Add entry for BCM4343A2 UART Bluetooth
 - qca: enable pwrseq support for wcn39xx devices
 - hci_qca: Fix BT not getting powered-off on rmmod
 - hci_qca: disable power control for WCN7850 when bt_en is not defined
 - hci_qca: Fix missing wakeup during SSR memdump handling
 - hci_ldisc: Clear HCI_UART_PROTO_INIT on error
 - mmc: sdio: add MediaTek MT7902 SDIO device ID
 - hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

----------------------------------------------------------------
Arnd Bergmann (1):
      Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array

Chris Lu (4):
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e174
      Bluetooth: btmtk: improve mt79xx firmware setup retry flow
      Bluetooth: btmtk: add status check in mt79xx firmware setup
      Bluetooth: btmtk: Add reset mechanism if downloading firmware failed

Christian Eggers (1):
      Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS

Dmitry Baryshkov (1):
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

Dongyang Jin (1):
      Bluetooth: btbcm: remove done label in btbcm_patchram

Dudu Lu (1):
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp

Dylan Eray (1):
      Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921

Gustavo A. R. Silva (1):
      Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings

Hans de Goede (2):
      Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
      Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod

Javier Tia (8):
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
      Bluetooth: btmtk: fix ISO interface setup for single alt setting
      Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
      Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
      Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
      Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
      Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
      Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Johan Hovold (2):
      Bluetooth: btusb: refactor endpoint lookup
      Bluetooth: btmtk: refactor endpoint lookup

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Kamiyama Chiaki (1):
      Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d

Kiran K (10):
      Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
      Bluetooth: btintel: Replace CNVi id with hardware variant
      Bluetooth: btintel: Add support for Scorpious Peak2 support
      Bluetooth: btintel: Add DSBR support for ScP2 onwards
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2
      Bluetooth: btintel: Add support for Scorpious Peak2F support
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2F
      Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
      Bluetooth: btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
      Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes

Luiz Augusto von Dentz (2):
      Bluetooth: btintel_pci: Fix btintel_pcie_read_hwexp code style
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Lukas Kraft (1):
      bluetooth: btusb: Fix whitespace in btusb.c

Marek Vasut (1):
      Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth

Pauli Virtanen (3):
      Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
      Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER

Sean Wang (8):
      mmc: sdio: add MediaTek MT7902 SDIO device ID
      Bluetooth: btmtk: add MT7902 MCU support
      Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3594 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
      Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
      Bluetooth: btmtk: add MT7902 SDIO support

Shuai Zhang (2):
      Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
      Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Stefan Metzmacher (1):
      Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

Stefano Radaelli (1):
      Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

Thorsten Blum (3):
      Bluetooth: btintel_pcie: Replace snprintf("%s") with strscpy
      Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
      Bluetooth: btintel_pcie: use strscpy to copy plain strings

Vivek Sahu (1):
      Bluetooth: qca: Refactor code on the basis of chipset names

 drivers/bluetooth/btbcm.c        |  11 ++--
 drivers/bluetooth/btintel.c      | 109 ++++++++++++++++++++++++++++------
 drivers/bluetooth/btintel.h      |  20 +++++--
 drivers/bluetooth/btintel_pcie.c | 122 ++++++++++++++++++++++++---------------
 drivers/bluetooth/btintel_pcie.h |   3 -
 drivers/bluetooth/btmtk.c        | 115 ++++++++++++++++++++++++++----------
 drivers/bluetooth/btmtk.h        |   9 ++-
 drivers/bluetooth/btmtksdio.c    |  44 +++++++++-----
 drivers/bluetooth/btqca.c        |  37 ++++++------
 drivers/bluetooth/btusb.c        |  84 +++++++++++++--------------
 drivers/bluetooth/hci_ldisc.c    |   3 +
 drivers/bluetooth/hci_ll.c       |  10 ++++
 drivers/bluetooth/hci_qca.c      |  84 ++++++++++++++++-----------
 include/linux/mmc/sdio_ids.h     |   1 +
 include/net/bluetooth/hci.h      |  16 +++--
 net/bluetooth/hci_conn.c         |   4 +-
 net/bluetooth/hci_core.c         |   4 +-
 net/bluetooth/hci_event.c        |  21 ++++---
 net/bluetooth/hci_sync.c         |   2 +-
 net/bluetooth/l2cap_core.c       |  15 ++++-
 net/bluetooth/sco.c              |   3 +-
 21 files changed, 476 insertions(+), 241 deletions(-)
