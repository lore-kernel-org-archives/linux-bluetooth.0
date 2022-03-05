Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiCEBXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCEBXV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903462F4
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:31 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 27so8848422pgk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnQLZQ+47xiR7bPIhf/j9mqGbUUqU3OVpPtAhF5eO5k=;
        b=BtZ30PcBFePFUulbjF3lzrSXynYrwJzfGnWTAIuR3MFWiX8SeVmV7GTnRxzflEGktk
         8699xJJ+yYtxYG6LLJ+T1bKZrkKGEBvVKbaoYPDeo6Ikmgi+2QepepZ5GOm/D9Rkqqoo
         f9r8NY2FJYLnlWJHV3pcYzQMUh4PJz7YOh5bt4L95txH/dUuAiuzcQ56BVH0qy5P9lFd
         oOhbTD58tU/Pq6YTnJNM1e4TdSzlJ7Rxn61LcDLr8LQZC+0bxxPZ9P+/Vsmi4UdzIF2b
         5LJk95Q9ilG5fA4W4oJh0rXfTP+wL4j1LYDuJwXyGuUOo3+ZjTh2vUTbVkEWEFTG8cJK
         oBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnQLZQ+47xiR7bPIhf/j9mqGbUUqU3OVpPtAhF5eO5k=;
        b=uQ09GbCZlotl17tgUpz/M6mGhGlyVBi797FJld5ehZiUbgA7QRFm6Q7BYKllDw0WRZ
         IHK1P9BonYZKned9zgjkLQmqie0eg4ghqoqJr1k0IBG0oR+MMpgewj8ejjLUYWpWDwpD
         FxACbK/Oj7GM0dSy5HS1mlHwUtjS6vdG+leReMwT3HGquGkAwFiR6wIL/gctzIsOBxKc
         dqH2ymtQH53BIpBVBwyllpKzqi5QPhpOZ9M7XL4gFfGdmxo5Y0C3rkrnHl7Wcy4kGAnL
         JUif/XvLMDXN++QBIC0JFh9dG0yAynGhujfvRx8ecVq3ALIuTkLVTD3bk2+0cnrvxjaP
         UO6A==
X-Gm-Message-State: AOAM5301vh4xaccSzRg2JgoaEhOLUIzPqg92tWIJEXrLdueAVcUBKdHW
        bq16QyjZgQA2I4aKtzKI4zwhGovrAxY=
X-Google-Smtp-Source: ABdhPJyvfUkXoco1KeuBZNE7b0tlsS4Shf5ZNG+eciHpXYaU+rKYEYz1vplbcpW3ZdmSmsf3kOgBeQ==
X-Received: by 2002:a05:6a00:84b:b0:4f2:a695:e356 with SMTP id q11-20020a056a00084b00b004f2a695e356mr1444481pfk.0.1646443351065;
        Fri, 04 Mar 2022 17:22:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 00/12] emulator: Initial Broacast Receiver
Date:   Fri,  4 Mar 2022 17:22:17 -0800
Message-Id: <20220305012229.853784-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the necessary commands to be able to emulate a Broadcast
Receiver:

BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED
BT_HCI_CMD_LE_BIG_CREATE_SYNC
BT_HCI_CMD_LE_BIG_TERM_SYNC

v2: Adds support for BT_H4_ISO_PKT to bthost.

Luiz Augusto von Dentz (12):
  monitor: Fix Create BIG PDU
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
  btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED when scan is initiated
  btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote start pa
  monitor: Rename Periodic Advertising terms to PA/pa
  btdev: Implements BT_HCI_CMD_LE_BIG_CREATE_SYNC
  btdev: Implements BT_HCI_CMD_LE_BIG_TERM_SYNC
  bthost: Add support for BT_H4_ISO_PKT
  bthost: Add support for Periodic Advertising
  bthost: Add support for Create BIG

 emulator/btdev.c  | 455 +++++++++++++++++++++++++++++++++++++++-------
 emulator/bthost.c | 392 ++++++++++++++++++++++++++++++++++-----
 emulator/bthost.h |  14 ++
 emulator/hciemu.c |   1 +
 monitor/bt.h      |  93 +++++-----
 monitor/packet.c  | 113 ++++++------
 6 files changed, 862 insertions(+), 206 deletions(-)

-- 
2.35.1

