Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09536C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D461760F93
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhJRVco (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:32:44 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:10542 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRVcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 17:32:43 -0400
X-UUID: 6237dea838a84217b7a40a5d1a170a4a-20211018
X-UUID: 6237dea838a84217b7a40a5d1a170a4a-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2101277503; Mon, 18 Oct 2021 14:30:29 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 14:30:24 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 05:30:23 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v2 00/10] Add MT7921 SDIO Bluetooth support
Date:   Tue, 19 Oct 2021 05:30:11 +0800
Message-ID: <cover.1634592181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

The patchset adds the MT7921 SDIO (MT7921S) Blutooth support to btmtksdio
driver, which basically are made up of 3 parts.

PART 1: patch 1-3 to create btmtk module to rely on

These are preliminary patches for MT7921s driver to move the common
firmware download procedure and the common functions from MT7921u to btmtk
module to make MT7921u, MT7921s and other devices can share with to reduce
the unnecessary duplicated code being created.

PART 2: patch 4-8 to refactor btmtksdio prior to adding mt7921s

These are preliminary patches for MT7921s driver to refactor the current
btmtksdio to make MT7921S is able to coexist with the devices the current
driver can support with the generic code and improve the performance on
packet transmitting and receving process.

PART 3: patch 9-10 to add specific mt7921s logic

Add the specific logic regarding to mt7921s bluetooth.

The changelog from v1 to v2:
- fix the test failure reported from bluez test bot
- fix the test warning reported from kernel test robot
- rebase onto the up-to-date bluetooth-next/master 
- fix the typo from mt7961_data to mt7921_data
- improve the function btsdio_mtk_reg_read with dropping the hard coding

Mark-yw Chen (1):
  Bluetooth: btmtksdio: transmit packet according to status TX_EMPTY

Sean Wang (9):
  Bluetooth: mediatek: add BT_MTK module
  Bluetooth: btmtksido: rely on BT_MTK module
  Bluetooth: btmtksdio: add .set_bdaddr support
  Bluetooth: btmtksdio: explicitly set WHISR as write-1-clear
  Bluetooth: btmtksdio: move interrupt service to work
  Bluetooth: btmtksdio: update register CSDIOCSR operation
  Bluetooth: btmtksdio: use register CRPLR to read packet length
  mmc: add MT7921 SDIO identifiers for MediaTek Bluetooth devices
  Bluetooth: btmtksdio: add MT7921s Bluetooth support

 drivers/bluetooth/Kconfig     |   6 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btmtk.c     | 289 ++++++++++++++++++++
 drivers/bluetooth/btmtk.h     | 111 ++++++++
 drivers/bluetooth/btmtksdio.c | 496 +++++++++++++++++-----------------
 drivers/bluetooth/btusb.c     | 331 +----------------------
 include/linux/mmc/sdio_ids.h  |   1 +
 7 files changed, 658 insertions(+), 577 deletions(-)
 create mode 100644 drivers/bluetooth/btmtk.c
 create mode 100644 drivers/bluetooth/btmtk.h

-- 
2.25.1

