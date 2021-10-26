Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8BD610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhJZXFv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhJZXFu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:05:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A559C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so861484pfc.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdcYLFA0f47AHcX/3ua4TjqtVQ2ovlHA5WeMOuB4QSc=;
        b=bsPVg6wMk2sW/MnTUdYNg64Y69A4/4aPIY5kgD2m6WwfrtqvybRyj72M+aYns451hl
         y+oV8RJEAH7CadE+Ylqwng8seYnwY1Z7rca/3C/wn6Jls8am7omMUJT57QFmNOIGGAzv
         hvNN1DrQKI7HQK5x3bl+6PtU+F1rcxqmnjFEhF3nWFn5RPScJKG7GbXHyCIGL2yqRzkI
         CAueUeYPaNBwffVS+0kgGnv+vtXwv1kJ53ZWRalW5zmKOzMwskeguy5JJWq5QdGUU+vR
         fksUuLPteXRO1i4CCt421II03i96ez+F9AfPo/2OJfcBvxAkkMZCzrcGWF7J8dvi8geP
         V1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdcYLFA0f47AHcX/3ua4TjqtVQ2ovlHA5WeMOuB4QSc=;
        b=oB+iUY5mIMSTpCNnPeSur7itdXhY+ogl2nXJa5FNDO8bH1JBYXOGzJw1M+ViSSIYDJ
         nXeuN7LHnFCEGVgumes4TL1/Nv4pgeUtlpHmNCR5M4TTTPkSGJYKMTZa5BMILBHwMiTX
         cIRNhOpAxStXhm3O88xxynKteRUJR0bGC/9dypIqQ08MEuwsIsruybf/QC1VixkQtI5Z
         ZN3molRKN82fgV9QdGPsra9u3rQC4UN9IywwF9psmJJ+oQXkv6emt6ZfkxDIaWS+c6ao
         zytTnzQeg3QGEz39qlMLJhi9Cj/yrsF3oEbtDXUZdVR2FeTvA5TbSbz21qMKf9Qc40hJ
         3nFw==
X-Gm-Message-State: AOAM533q1TQaILHz9ASQ/2MS+pA5TUOnGJA5TbOeJ81gG2km6d279YR+
        sgHC02g+et+TXp0fXVb9sf8xg5uDYjU=
X-Google-Smtp-Source: ABdhPJwgi1bXBB9T7NFFUACfR7XFs1k2ubg8y/sA9dx8T+bOayb88lgzvaSV4vYm0xZa0gjz1PaVvw==
X-Received: by 2002:aa7:90d0:0:b0:44d:b8a:8837 with SMTP id k16-20020aa790d0000000b0044d0b8a8837mr28973815pfk.47.1635289405590;
        Tue, 26 Oct 2021 16:03:25 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 00/23] Bluetooth: HCI command synchronization
Date:   Tue, 26 Oct 2021 16:03:01 -0700
Message-Id: <20211026230324.1533907-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is the initial work to move away from the current design of
batch up commands with hci_req_run to be executed asynchronously to
instead run them synchronously which enables handling errors properly.

It specially targets enabling the so called LL Privacy feature and
simplifying Suspend/Resume code paths since those are the most
complicated ones involving multiple state machines (Connection,
Advertising, Scanning and Adv Monitor) which requires a bunch commands
to be send making the code very complicated to follow.

As a result of these changes the LL Privacy is enabled for the
peripheral role, previously only central role had support for it, so it
is possible to have advertising sets when LL Privacy is enabled.

Suspend/Resume have been reworked so it no longer needs a state machine
to track its progress, the whole process of suspending is handled by
hci_suspend_sync and hci_resume_sync for resuming, we also took the time
to document the source code to make clear what is their expected behavior.

In order to properly test these changes a number of new tests are being
introduced see:

https://patchwork.kernel.org/project/bluetooth/list/?series=565857

v6: Fix CI findings, fix using ERR_PTR/PTR_ERR to pass parameters as user_data
and change the use of hci_dev *dev to hci_dev *hdev.

Brian Gix (13):
  Bluetooth: hci_sync: Convert MGMT_OP_SET_FAST_CONNECTABLE
  Bluetooth: hci_sync: Enable synch'd set_bredr
  Bluetooth: hci_sync: Convert MGMT_OP_GET_CONN_INFO
  Bluetooth: hci_sync: Convert MGMT_OP_SET_SECURE_CONN
  Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO
  Bluetooth: hci_sync: Convert MGMT_OP_SET_LE
  Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_DATA
  Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
  Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME
  Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
  Bluetooth: hci_sync: Convert MGMT_OP_SET_ADVERTISING
  Bluetooth: hci_sync: Convert adv_expire
  Bluetooth: hci_sync: Convert MGMT_OP_SSP

Luiz Augusto von Dentz (9):
  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1
  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2
  Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3
  Bluetooth: hci_sync: Enable advertising when LL privacy is enabled
  Bluetooth: hci_sync: Rework background scan
  Bluetooth: hci_sync: Convert MGMT_SET_POWERED
  Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY
  Bluetooth: hci_sync: Rework init stages
  Bluetooth: hci_sync: Rework hci_suspend_notifier

Marcel Holtmann (1):
  Bluetooth: Add helper for serialized HCI command execution

 include/net/bluetooth/bluetooth.h |    2 +
 include/net/bluetooth/hci_core.h  |   21 +-
 include/net/bluetooth/hci_sync.h  |   98 +
 net/bluetooth/Makefile            |    2 +-
 net/bluetooth/hci_conn.c          |   20 +-
 net/bluetooth/hci_core.c          | 1333 +-------
 net/bluetooth/hci_event.c         |  153 +-
 net/bluetooth/hci_request.c       |  338 +-
 net/bluetooth/hci_request.h       |   10 +
 net/bluetooth/hci_sync.c          | 4788 +++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              | 2050 ++++++------
 net/bluetooth/mgmt_util.c         |   15 +-
 net/bluetooth/mgmt_util.h         |    4 +
 net/bluetooth/msft.c              |  511 +--
 net/bluetooth/msft.h              |   15 +-
 15 files changed, 6370 insertions(+), 2990 deletions(-)
 create mode 100644 include/net/bluetooth/hci_sync.h
 create mode 100644 net/bluetooth/hci_sync.c

-- 
2.31.1

