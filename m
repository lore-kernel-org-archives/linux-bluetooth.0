Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4D3F0AAC
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003420; cv=none; b=cLGGDNDqBRh7AUOkb8Dzh722+uic8cZQIqyQdaHtnf6K74lLAwuXQfsXM5oN8MCs/oYBFjumRh4uqnSOVtFje0kZMPTXscxeliDVLvWotbF6U8nAMvru+KJmvkvayOCVCVHT9pQkyP5ya0RseQjGhMAM/rGNkGGOqGS6ZLyFIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003420; c=relaxed/simple;
	bh=Y7xnwK8z1ivyl9b7h7uP42Rdjv2t9q/Cl3/MEiyCvd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qzvThI16Ire/nq9Od4dxwAdaJ7kEKQPYOqk0RCusE81pRMu2eI8fUQY/iUprrWmahN98eI1WEXGA6daRaETR9oO0f6RhtUpvqbME92Zmc1axHJ+rqcSyLQ975FskPtwT26U4LJlquHrpZV4ipSFtNeLUbtg0Vhp4KK9FbMyrq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnu6vcCj; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnu6vcCj"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9906034086cso348009241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792003417; x=1792608217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUKrwI694YVDxKZ1g5qsyZmsgUDdISSnPxqJADqeWNM=;
        b=Cnu6vcCj3efJfyJ+1vYhB5KjEh9gSRjpn/6eFs9qXdhwm8ZKhLugIRTspIUZVIdk1d
         rqvU9hSNhixyJIE/QvoowkeY7Zv9aIV5vbSoqFPMObnNeG/lew8plT+fxi3qUCPcV8wv
         uLCyi6rphEvLiQYi6aS4Ink2fDjAD+uPBBB+EwXKLGKjsbjN0FT8i5RUH7gOjy3QpDRK
         boE7WrbjW6HyEY0xROKrrs3rvg9MalgckUl8D0jL+f5wTir/eoogxlt/QLDBGpUQwqeo
         dDvi62dN3UCI/IYvoTcDy76rwcu6iyBUvWzPjdt/4igs2H7g12hyreZbBu627zRH0oj9
         UE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792003417; x=1792608217;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUKrwI694YVDxKZ1g5qsyZmsgUDdISSnPxqJADqeWNM=;
        b=c9lqYSZe2L42onWdugpI68+zjlp9lVv3AGmd1TsSagqeQ7ahrOTDBqV+iPxkzkRymW
         lhJGjd2ySH8CP8h7U4FAnerwFs5B6WBcArJxBhdKhYOf6ebasnSAPp39rfp4TCUzC7GX
         O2GDuYzVwkDYZf3FNQUm6qH0c4WVhhsroyvyApvZAmqP+9/wTDmtqErYEL0V9PMIVsyU
         negW84LH8VMaE1IT6gX/0YEOVACSKPjxzYGHPla4C/0ZwVNSlivFtcnE0PB02aCeTZW+
         3HCdcPbfcVKS2uAVJhT7GXVNptGXdxth7LbMXQtJTT/6Jv5UdgQVwAuDXK/vkbIllRV4
         qC/A==
X-Gm-Message-State: AFq9FYI9FFcKVFvKM61pdHkUsjZeAjY+dZxZXA609OnvHRyZqG7ffwse
	26h2kue+J8FSB1X4B2inrNjshuA3g/4Q1kW8MzgOFzSdngZdRpAQ/P+8DSUTuO+c
X-Gm-Gg: AYBFou2bhUQU0kh6Fh+VEZ07fhTHJ0aWLR2i3Phd5uvi0d4/vqX601tffBjYL/YrgdK
	zwkaO2xptL87gmnPdZnN8hBuFaKXU8HBpmcSV1IFNCkUYhXc5jWZUZobLutm27+OPzLQMBFIbg2
	9zYVkaxxAyqbQLwp5BerObCRzf/LNgZlQa5iJM/f3l/U8dYsGrNCo8b5vqZHR7PDo7UAELz+q1/
	4kvGHwXFjaWEYKGXz7NZFreIgZ8xSBmOzgLKkBFb8BjiY/4prmlk9yOiUmXMdV4gcJGKn7HF4x5
	qfzG6DjFkDJ2LEu7VYxYnpafsAJzbHCDOYMy9os+eyQgYpjKzHeCtSViqAKlfM+Uu/0ysHcUxd1
	QzH0VmWjYucj7z6yR98G9wUiHVh7Erah2URoSMkQlhs1n/jejl/vyNepAXN31NbHMx1avjOuE7K
	HpEIFV9A4yMaVt4obGRfohiD1kdxNlH56tzwaxosl7q1t4ShrBnQ+p9PohRt+XdqWEDKmWrBMg4
	D7rsfB1D1L51obAxWKUmXq+FDNcTkvEmIBntuombZeBNv9Qfqd5MkktYmQSCrI95l4aJE83i1A=
X-Received: by 2002:a05:6102:3753:b0:7c0:b41:145a with SMTP id ada2fe7eead31-7cb373b9ac7mr4006680137.30.1792003417194;
        Wed, 14 Oct 2026 11:43:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f66f94sm10965622241.9.2026.10.14.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:43:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-10-14
Date: Wed, 14 Oct 2026 14:43:25 -0400
Message-ID: <20261014184327.1648397-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 05b5019b01fb9443b09ae4ed34af1135a80a84c8:

  net: alacritech: fix dma_free_coherent() in error path (2026-10-13 15:48:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-10-14

for you to fetch changes up to 397464709a204da9b8dc3b01d6ea42539d951cd2:

  Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs (2026-10-14 14:38:29 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - Move H:4 reassembly into the Bluetooth core
 - Add ge[GIT PULL] bluetooth-next 2026-08-07neric support for vendor packets
 - MGMT: Add management security level changed event
 - MGMT: Allow connection rate request as peripheral
 - L2CAP: Add locking annotations and fix locking of channel operations
 - Enable context analysis for headers

drivers:

 - btusb: Add support for Bulk Serialization Mode
 - btusb: Build the driver from multiple source files
 - btusb: Add support for Qualcomm multi-subsystem QCC2072
 - btusb: Add support for Intel Otter Peak2 (OrP2)
 - btusb: Add USB ID 13d3:3556 for RTL8821CE
 - btusb: Add Realtek RTL8821CE device 13d3:3558
 - btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
 - btusb: Add device ID for MediaTek MT7925 (13d3:3631)
 - btusb: add ASUS 0b05:1825 and 0b05:1868 to QCA Rome quirks
 - btintel: load unlocker.sfi to allow unsigned firmware
 - btintel_pcie: Add support for Intel Draco
 - btintel_pcie: Add PCI ID and CNVi ID for Titan Lake
 - btintel_pcie: add MDBGC multi-buffer DBGC allocation
 - btintel_pcie: unified decoder coredump format
 - btmtk: Add MT7928 support
 - btmtk: Improve BT firmware logging
 - btbcm: Add Synaptics 4384 chip support
 - btbcm: Add entry for BCM4356A3 UART bluetooth

----------------------------------------------------------------
Aaron Kling (1):
      Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth

Adriano Cordova (1):
      Bluetooth: bnep: linearize skb before sending

Ajith P V (1):
      Bluetooth: bnep: refactor deprecated strcpy

Alex Zhou (1):
      MAINTAINERS: add entry for NXP wireless Bluetooth driver

Andy Chang (2):
      Bluetooth: dt-bindings: net: bluetooth: add BCM4384
      Bluetooth: btbcm: Add Synaptics 4384 chip support

Aritra Das (1):
      Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE

Bui Viet Dung (4):
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Catherine L (5):
      Bluetooth: btintel_pcie: Route debug traces to WiFi DBGC by default
      Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
      Bluetooth: btintel_pcie: Add CNVi ID for Titan Lake (Scorpius Peak2 C0)
      Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
      Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID

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

Chandrashekar Devegowda (4):
      Bluetooth: btintel_pcie: parse FW memory addresses via mailbox TLV
      Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
      Bluetooth: btintel_pcie: add MDBGC multi-buffer DBGC allocation
      Bluetooth: btintel_pcie: unified decoder coredump format

Chris Lu (7):
      Bluetooth: btmtksdio: Remove redundant firmware filename override
      Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
      Bluetooth: btmtk: Validate the firmware layout before parsing it
      Bluetooth: btmtk: Improve BT firmware logging
      Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
      Bluetooth: btmtk: Route firmware debug event to the diag channel
      Bluetooth: btmtk: Add MT7928 support

Christophe JAILLET (1):
      Bluetooth: btmrvl: Slightly simplify btmrvl_process_event()

Eric Dumazet (1):
      Bluetooth: btmtk: fix skb double free on ISO padding failure

Frédéric Danis (1):
      Bluetooth: MGMT: Add management security level changed event

George Maraveyas (1):
      Bluetooth: mt7925: trigger reset on WMT timeout

Hans de Goede (1):
      Bluetooth: hci_sync: Factor common cleanup code into a helper

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Ibrahim Abdelkader (1):
      Bluetooth: hci_core: Return -ENOMEM when the sent_cmd clone fails

Jeremy Dean (1):
      Bluetooth: Fix code style error

Junjie Cao (1):
      Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

Kevin Dewald (1):
      Bluetooth: hci_event: Fix LE link drop on remote features command status

Kiran K (5):
      Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
      Bluetooth: btintel_pcie: cap device debug regions at 1 MB
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs
      Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware

Konstantin Nazarov (1):
      Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks

Kyle Pepper (1):
      Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs

Luiz Augusto von Dentz (8):
      Bluetooth: Move H:4 reassembly into the Bluetooth core
      Bluetooth: btusb: Add support for Bulk Serialization Mode
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
      Bluetooth: MGMT: Allow connection rate request as peripheral
      Bluetooth: Fix the LE Read Connection Interval response layout

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Pauli Virtanen (22):
      Bluetooth: hci_core: add lockdep check to hci_conn lookups
      Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
      Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
      Bluetooth: enable context analysis for headers
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
      Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
      Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
      Bluetooth: L2CAP: remove unused l2cap_chan_close()
      Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
      Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: add annotations for l2cap_chan list locking
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
      Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
      Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
      Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
      Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
      Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
      Bluetooth: hci_sync: fix mesh adv timeout units
      Bluetooth: make hdev->adv_instance_timeout a boolean

Peng Fan (1):
      Bluetooth: use assign_bit() where applicable

Quentin Strydom (1):
      Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks

Radek Podgorny (1):
      Bluetooth: forget a peer's RPA once it advertises its identity address

Ravindra (3):
      Bluetooth: btintel: read ROM debug registers on FW download failure
      Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
      Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write

Richard Nunley (1):
      Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558

Sai Teja Aluvala (3):
      Bluetooth: btintel_pcie: Add support for Intel Draco
      Bluetooth: btintel_pcie: Add support for Intel Draco
      Bluetooth: Add support for Intel DRACO

Samuel Alhovuori (1):
      Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)

Sergey Lebedev (1):
      Bluetooth: btintel_pcie: verify and serialize D-state transitions

Shuai Zhang (1):
      Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping

Siwei Zhang (6):
      Bluetooth: L2CAP: Reject mode changes on connected channels
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
      Bluetooth: L2CAP: Use default TxWindow for zero socket option
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests
      Bluetooth: L2CAP: Remove dead configuration state code

Thomas Huth (1):
      Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()

Tzung-Bi Shih (1):
      Bluetooth: btmtksdio: Fix spurious ownership error logs

Vladimir V. Kondratyev (1):
      Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

Xuhua Zhang (3):
      Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
      Bluetooth: hci_h5: Avoid clearing the escape bit for ordinary bytes
      Bluetooth: hci_ll: Sleep while waiting for the controller to power up

ZhaoJinming (3):
      Bluetooth: virtio_bt: Fix use-after-free and memory leak in probe error paths
      Bluetooth: btmtksdio: fix deadlock in close and reset paths
      Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()

Zijun Hu (7):
      Bluetooth: hci_event: Use 254 as max LE Meta subevent payload length in hci_le_ev_table[]
      Bluetooth: hci_event: Use 252 as max CC event payload length in hci_cc_table[]
      Bluetooth: btusb: Add recv_intr() hook to btusb_data
      Bluetooth: Add generic support for vendor packets
      Bluetooth: btusb: Build the driver from multiple source files
      Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
      Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt() by hci_acl_handle()

 .../bindings/net/bluetooth/brcm,bluetooth.yaml     |    1 +
 MAINTAINERS                                        |    2 +
 drivers/bluetooth/Kconfig                          |   15 +
 drivers/bluetooth/Makefile                         |    3 +
 drivers/bluetooth/btbcm.c                          |    7 +-
 drivers/bluetooth/btintel.c                        |  152 +-
 drivers/bluetooth/btintel.h                        |   19 +
 drivers/bluetooth/btintel_pcie.c                   | 1545 ++++++-
 drivers/bluetooth/btintel_pcie.h                   |  257 +-
 drivers/bluetooth/btmrvl_main.c                    |    4 +-
 drivers/bluetooth/btmtk.c                          |  515 ++-
 drivers/bluetooth/btmtk.h                          |   12 +
 drivers/bluetooth/btmtksdio.c                      |   55 +-
 drivers/bluetooth/btnxpuart.c                      |    4 +-
 drivers/bluetooth/{btusb.c => btusb_main.c}        |  370 +-
 drivers/bluetooth/btusb_qcom.c                     | 4557 ++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h                     |   99 +
 drivers/bluetooth/hci_bcm.c                        |    1 +
 drivers/bluetooth/hci_bcsp.c                       |   26 +-
 drivers/bluetooth/hci_h4.c                         |  123 +-
 drivers/bluetooth/hci_h5.c                         |   11 +-
 drivers/bluetooth/hci_ll.c                         |    2 +-
 drivers/bluetooth/hci_serdev.c                     |   46 +-
 drivers/bluetooth/hci_uart.h                       |   39 +-
 drivers/bluetooth/hci_vhci.c                       |    4 +
 drivers/bluetooth/virtio_bt.c                      |   25 +-
 include/net/bluetooth/bluetooth.h                  |    4 +-
 include/net/bluetooth/hci.h                        |    1 +
 include/net/bluetooth/hci_core.h                   |   69 +-
 include/net/bluetooth/hci_h4.h                     |   60 +
 include/net/bluetooth/hci_mon.h                    |    2 +
 include/net/bluetooth/hci_sync.h                   |    1 +
 include/net/bluetooth/l2cap.h                      |  103 +-
 include/net/bluetooth/mgmt.h                       |   14 +
 net/bluetooth/6lowpan.c                            |   48 +-
 net/bluetooth/Makefile                             |    2 +-
 net/bluetooth/bnep/core.c                          |   16 +-
 net/bluetooth/hci_conn.c                           |   28 +
 net/bluetooth/hci_core.c                           |   57 +-
 net/bluetooth/hci_debugfs.c                        |    9 +
 net/bluetooth/hci_event.c                          |  290 +-
 net/bluetooth/hci_h4.c                             |  160 +
 net/bluetooth/hci_sock.c                           |    8 +
 net/bluetooth/hci_sync.c                           |  138 +-
 net/bluetooth/iso.c                                |   18 +-
 net/bluetooth/l2cap_core.c                         |  371 +-
 net/bluetooth/l2cap_sock.c                         |  122 +-
 net/bluetooth/mgmt.c                               |  204 +-
 net/bluetooth/msft.c                               |    6 +
 net/bluetooth/rfcomm/core.c                        |    6 +-
 net/bluetooth/rfcomm/sock.c                        |    5 +-
 net/bluetooth/sco.c                                |   10 +-
 net/bluetooth/selftest.c                           |    1 +
 net/bluetooth/smp.c                                |    5 +-
 scripts/context-analysis-suppression.txt           |    1 +
 55 files changed, 8785 insertions(+), 868 deletions(-)
 rename drivers/bluetooth/{btusb.c => btusb_main.c} (94%)
 create mode 100644 drivers/bluetooth/btusb_qcom.c
 create mode 100644 drivers/bluetooth/btusb_qcom.h
 create mode 100644 include/net/bluetooth/hci_h4.h
 create mode 100644 net/bluetooth/hci_h4.c
