Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F0C25B45
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Oct 2023 18:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjJWSVQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Oct 2023 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjJWSVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Oct 2023 14:21:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0ECBE
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 11:21:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578b4997decso2647102a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698085271; x=1698690071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPyUiOJZ2q35fZ0XB5Sq4AM4l5aO57NWrIRPv3lvLC8=;
        b=QJill0QdgrQP+JIDSlabAsQUPxJ32JVBF33yGC7xt7XpAyeoEowKPhcY9o9j/larDK
         sUpFjSZdX6lqCDEu08fwARFlYeJt/VEIgF1BM4cXtK86efAVVCarSqUNkf8APW1IYh65
         Kl1hcanhEJjJo4e6ijyvWL5V6c54HmTFPZKHTaQDI3Jsg8/qnKOXj2aZN37hHYJwwcrO
         Z6mrH/XG6JNhnYfOfaH2QlQFCjsd2Ce8XKLhUiqwxbKTRP0yOBI0Q9PgnyTuIxV7hoOP
         j1fvIO7RzSyx8L2Jz7nJxOkR5wlXaSJSD45NkprJKDDvSmkfUMUjhwCG3COEuy0vjE0W
         QhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085271; x=1698690071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPyUiOJZ2q35fZ0XB5Sq4AM4l5aO57NWrIRPv3lvLC8=;
        b=RnIj3Anaim/dRYE5UPZadPReTYoGkf09PlBgjCg5XNxyAGV1H+/dsgjigTK4ZBPQzP
         ERLSm5Oylnac5xNRvazXcIqhI17hP+o/LkXSlgr69GyRrLeFizM3zxXYdLnP/aKzY/zf
         OOkhUnH38XSTWMQHkUWlqTj/06hPDhhzGJ1lmPiEvoLluCPPtANJhc0MSGKznbouXQVe
         nZFSmLU5Uoz0tPHG75kwflylNWDxeoOEU5zy+D9XoNhnXpoqrOs3Y4uNmtdY9Sm6xr1B
         gYIYzGcD+jgX7fdBTlNW0s+kBAu87wgqsR/Mou5NHaliqiPouvuhQc341TjB/F/IFjge
         beTw==
X-Gm-Message-State: AOJu0YzQJS7nvcWYhycRr8fmTTOe/5sXDesmcI4Fg45AD0tzfV5q01Mq
        vRhhDz0jQMxyNKvtSZEa/xYf73cLSbKEEqFr+Mc=
X-Google-Smtp-Source: AGHT+IHHXWhvVl6frUC5/s2+5kgUMyvK1QIMNl39/IC/Jwk4Ar2IgX7cLge9/rlRGstKAq/GyUYFBg==
X-Received: by 2002:a05:6a20:da8d:b0:13f:9cee:ff42 with SMTP id iy13-20020a056a20da8d00b0013f9ceeff42mr500464pzb.41.1698085271137;
        Mon, 23 Oct 2023 11:21:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006b341144ad0sm6705652pfb.102.2023.10.23.11.21.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:21:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2023-10-23
Date:   Mon, 23 Oct 2023 11:21:08 -0700
Message-ID: <20231023182108.3629137-1-luiz.dentz@gmail.com>
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
