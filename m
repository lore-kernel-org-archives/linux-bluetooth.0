Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B161FCE
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841740; cv=none; b=g6uMLBhdyvoUJUqrYIDYe30wXss7dvFWKOefDTYm92uNF7Uf0fEy2PXGWjXPeVU+5CdzLzF0EsopBC9Qo3RiBhKg372ZanKouq05CFfDYGALyiMooi5XYLyAAebDp9HfJ0XnRy2exdsU7a7X85iSorxgXmeSA7HaPV5jMtdrgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841740; c=relaxed/simple;
	bh=5F7zzF9L2td63ho0ruf1R6hDs5jbQ534olMLYExhsWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWGNFa3sxYPwbrqKZMQVZorVpiDM+3HFFwPhkZP8UUjYga1z3/O8+V1cMFcb7vRO94PiapkBovA9xTFyMwMe8mQzjt11N8jjrrel2HgFQtmLRkNq61pd1AIFdRO0fUYxYP8FOiMxSPWcpOGy1ne4Crr9EAI4j+l9eYuL5vGh+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWYcXG3K; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWYcXG3K"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d958880ecso810819e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775841738; x=1776446538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GvaVKIkuWT5Ieu3JsTKwswFQ108qsrnkd5bGikjbhM=;
        b=eWYcXG3KxieO5cHuM/rTo3WL2ApFW2lUArcD+NgCO1HbsDoVBHqhK6w3WAS1LarvE2
         ppryBEjbKReMRWeJ2sSxZeRBCsBQcQVIFpyEQIROZk3BsQVRhVik/WcZO3W4bAJ2KBhy
         ZjsCVNoQfT999SdXT8wLsBY6xtsoy6/shH5gFhNAlByOHT+Kqlu+OlwyocaXNMkwZoET
         y/j4cHBiPnfnOJUeQ/k8knqgupZS0LlVpBgCUM3Jj1nqw/oqyhtwd11uODiV8hPyL+Q9
         S7ls6FQr11G8k+2aPUjwFkw8mUigkOXTU/agsOzH5r4wfRcCKwWIjvPE1ZIuon2b3j29
         EQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841738; x=1776446538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GvaVKIkuWT5Ieu3JsTKwswFQ108qsrnkd5bGikjbhM=;
        b=RERvUhtHBxhan2mHMrA1BDDB1HyVoyl0ftxg/WAlQi3qLUe4stsgSYcIgA4uyZIm65
         Wq9Y5VdNB9fUFJmevbnAdkqbKw+rHxxuaiIJSkvE2HJ+eUCZ9vA2YGdGNRxoPCcWcqOA
         55VMbMV81fgj4TfyceP/aSqEzXlMUvvlu+QhJuzpo0c6ZcTka45RfHTt5CCytFfUCyzw
         +jl2pnD+U0mApFUILZC7WpTcpa2mkLRCedRyWoXDuCvTg75iIj6L6BP/FbDYSgWWbtht
         2BoehrtuGwji7/+8Adi32jQ9asunXGRFuetCNQkglrOnLZKTuSsAALuuOj3tHZDvl5H5
         Emsg==
X-Gm-Message-State: AOJu0YwFx/8MV2sYF+A2pzYpZsq/DVL4Qu0r0d6eIF6CQ7dePMey/a52
	1Pk3HF/zcmGCsoD0POnHdHHrQ8DVSeYI2awEn/Z1Z+gjZuAS+0VFgclYbkoKLiVS
X-Gm-Gg: AeBDiev2qRR64PK4CMZ5Z8xg3dltmAdVeExZBNU5Czw51DEzUbp5qQFMchrx+xNeUQ/
	5kAQQDVgLRP+JLQBabKo3LDMXqSvAUV2yn3i2gVtGIEHNvkGSqwwexy/XaX7KlQH92q/a95tHXb
	4S67VY4mm02iUciod50Dv7+8Hf7fFeVwSTnOhJnfmwzLO6EcRYXwdKR21UEwkiq6CPTHKtnNMJ0
	UN4LIQvjbig91GN9B6ZmkeIFakZhK2IcaPNnlzRwYjve5d2LffGtsGAhyqyHYiZIvVmBIYe+fSC
	zTadpz+ACvz6ZANnM5oae6XD5I6eAgtTvrOsWs1RDJE1knJtV14bQLdhIu7hJnj4LQ5GyL4f31W
	YpUQyilpN2eDEqke/j1MROoGt8+4B1tRPBPjEtEmmsL26e5H+gW4aUtdHMe0uK7O7lcA6RQSKbf
	vRQieNR9fzcrkoEU3BXbfpBZEbrgSdny8jtlSLjnCmbBEi1eR4r60xuLexu9b/ea/Y0yTj/4zDG
	23jwWUSTZelqi5ouQ==
X-Received: by 2002:a05:6122:4598:b0:56e:f5be:1068 with SMTP id 71dfb90a1353d-56f3bb9f67dmr2423236e0c.1.1775841737804;
        Fri, 10 Apr 2026 10:22:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-954e0c7acb1sm2075505241.10.2026.04.10.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:22:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-04-10
Date: Fri, 10 Apr 2026 13:22:06 -0400
Message-ID: <20260410172206.150975-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-10

for you to fetch changes up to 02751aa9eb61cba881dad5a1e2663389b76ea8f2:

  Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-10 10:38:37 -0400)

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
