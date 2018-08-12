Return-Path: <sean.wang@mediatek.com>
From: <sean.wang@mediatek.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/2] Bluetooth: mediatek: Add protocol support for MediaTek USB devices
Date: Sun, 12 Aug 2018 16:46:50 +0800
Message-ID: <cover.1534062988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7668U and MT7663U Bluetooth
function running on the top of btusb driver. The patch also adds
a newly created file mtkbt.c able to be reused independently from
the transport type such as UART, USB and SDIO.

Sean Wang (2):
  Bluetooth: mediatek: Add protocol support for MediaTek MT7668U USB
    devices
  Bluetooth: mediatek: Add protocol support for MediaTek MT7663U USB
    devices

 drivers/bluetooth/Kconfig  |  16 +++
 drivers/bluetooth/Makefile |   1 +
 drivers/bluetooth/btmtk.c  | 309 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h  | 100 +++++++++++++++
 drivers/bluetooth/btusb.c  | 177 ++++++++++++++++++++++++++
 5 files changed, 603 insertions(+)
 create mode 100644 drivers/bluetooth/btmtk.c
 create mode 100644 drivers/bluetooth/btmtk.h

-- 
2.7.4
