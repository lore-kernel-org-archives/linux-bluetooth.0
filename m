Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117FC25B45
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Oct 2023 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjJWSV0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Oct 2023 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjJWSVZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Oct 2023 14:21:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E58F;
        Mon, 23 Oct 2023 11:21:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d129e2e7cso2586386a91.3;
        Mon, 23 Oct 2023 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698085281; x=1698690081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPyUiOJZ2q35fZ0XB5Sq4AM4l5aO57NWrIRPv3lvLC8=;
        b=LK8vNysg+Om0pDW/bw4VXm8L9hugFRAK0WPXIJlzAALNtVG36gfRqFPS819QSXdbAZ
         n1+00juRzimB9GeE60y3cG8EltMzyc6lJYIrMg5LTTwQBYalP7XBNBkotySPglOYfjFD
         p+XW6sp+PcvtfXISb/S+5SN7wvzdUI2XxN4XiOGNnQnX9aoR8u+U1x54HlDlEdQCxCpV
         +9fCHQOSqXBTG4vaBW8Zu6idnEZKXhoKOTA0bpqVMTtScjQZvBag7K/PVeAg1uDj2SnV
         akN+nljqqY86a4sPP3jFNHr2Y0yHVlkT9Vx2HB3RSVL/qLrbkLvIP3JvuFa45KiyJQ3v
         fw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085281; x=1698690081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPyUiOJZ2q35fZ0XB5Sq4AM4l5aO57NWrIRPv3lvLC8=;
        b=FoKsQyzSys350ul5dGk43JlnC8nXvqDPPCKWMxOY2lISNM7p9i+gdD0l6DeV/C8zl0
         u9pYdZygFuhIK41p1oGApobQL5twt77UdtfKHZFLyZUH8VCtL/7j5RaMMYMlE/rw/7gP
         cVslOyf6vDbO2lD6LWLpMgwXZ71GspgXVKvnsKFCIrh8Puhgr+Shk7t4gI8PHUzU8zoG
         v4XVPMeSlkR8I1R3Gz1y3OOCN5zdGeW6/P/7+qMx7J9sIOFYVpBmVsjJKR/5vHD7CF4T
         Stqs7183674OyPhe7QKU6MZLDghmmipkzwwJ1vin0Pl3q2wnDDds7xIHcEJEKkFsrVUV
         P/KA==
X-Gm-Message-State: AOJu0YwYtRY7KMpCa4EGwb+ZgrSK1hdtYsa+2+QmZSXTfuuOGDhpCG0S
        SJBs4NBd3i7wq0bnNDgxg1Q=
X-Google-Smtp-Source: AGHT+IFoEt17HWYkQBkTd5gf+xEa9oBMi7JNVrUhDIs1qlYCY9vg1nZrhP6wnLF58WJSYTYycXydBQ==
X-Received: by 2002:a17:90a:fa8f:b0:268:2658:3b01 with SMTP id cu15-20020a17090afa8f00b0026826583b01mr6924882pjb.39.1698085281334;
        Mon, 23 Oct 2023 11:21:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001c5bcc9d916sm6205360plh.176.2023.10.23.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:21:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2023-10-23
Date:   Mon, 23 Oct 2023 11:21:19 -0700
Message-ID: <20231023182119.3629194-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit d6e48462e88fe7efc78b455ecde5b0ca43ec50b7:

  net: mdio: xgene: Fix unused xgene_mdio_of_match warning for !CONFIG_OF (2023-10-23 10:16:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-10-23

for you to fetch changes up to 530886897c789cf77c9a0d4a7cc5549f0768b5f8:

  Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err (2023-10-23 11:05:32 -0700)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add 0bda:b85b for Fn-Link RTL8852BE
 - ISO: Many fixes for broadcast support
 - Mark bcm4378/bcm4387 as BROKEN_LE_CODED
 - Add support ITTIM PE50-M75C
 - Add RTW8852BE device 13d3:3570
 - Add support for QCA2066
 - Add support for Intel Misty Peak - 8087:0038

----------------------------------------------------------------
Claudia Draghicescu (1):
      Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

Dan Carpenter (1):
      Bluetooth: msft: __hci_cmd_sync() doesn't return NULL

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Iulia Tanasescu (5):
      Bluetooth: ISO: Fix BIS cleanup
      Bluetooth: ISO: Pass BIG encryption info through QoS
      Bluetooth: ISO: Allow binding a bcast listener to 0 bises
      Bluetooth: ISO: Match QoS adv handle with BIG handle
      Bluetooth: ISO: Fix bcast listener cleanup

Janne Grunau (1):
      Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Jingyang Wang (1):
      Bluetooth: Add support ITTIM PE50-M75C

Marcel Ziswiler (1):
      Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Tim Jiang (1):
      Bluetooth: qca: add support for QCA2066

Vijay Satija (1):
      Bluetooth: Add support for Intel Misty Peak - 8087:0038

Vlad Pruteanu (1):
      Bluetooth: ISO: Set CIS bit only for devices with CIS support

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhengping Jiang (1):
      Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend

Ziyang Xuan (1):
      Bluetooth: Make handle of hci_conn be unique

youwan Wang (1):
      Bluetooth: btusb: Add date->evt_skb is NULL check

 drivers/bluetooth/btmtksdio.c    |  44 ++++++++++++--
 drivers/bluetooth/btqca.c        |  68 ++++++++++++++++++++++
 drivers/bluetooth/btqca.h        |   5 +-
 drivers/bluetooth/btusb.c        |  11 ++++
 drivers/bluetooth/hci_bcm4377.c  |   5 ++
 drivers/bluetooth/hci_qca.c      |  11 ++++
 include/net/bluetooth/hci.h      |   3 +
 include/net/bluetooth/hci_core.h |  40 ++++++++++---
 include/net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/amp.c              |   3 +-
 net/bluetooth/hci_conn.c         | 123 +++++++++++++++++++++++++++------------
 net/bluetooth/hci_core.c         |   3 +
 net/bluetooth/hci_event.c        |  92 ++++++++++++++++-------------
 net/bluetooth/hci_sync.c         |  36 +++++-------
 net/bluetooth/hci_sysfs.c        |  23 ++++----
 net/bluetooth/iso.c              |  38 ++++++++----
 net/bluetooth/msft.c             |  20 +++----
 17 files changed, 375 insertions(+), 152 deletions(-)
