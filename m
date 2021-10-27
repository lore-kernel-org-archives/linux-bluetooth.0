Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCA9610C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJ1AB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1AB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270AC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v1-20020a17090a088100b001a21156830bso6495114pjc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJ+jI33BK+IYABzbLprukt/esmp8Kd2Mu/RCj0l/WTU=;
        b=T/QQk8mZ5khtsooA8O9RhM7bsk2Pn4h2CH7YUfO460Y0ALYYG63btwB+zzTUBcVTnV
         IdjpBJbXVrc1FRs3+k9GJBwVZP/fwtWjRVswH/TaiOJLkhkI405u4LrR8Uc8a37IEKSa
         YQCHhuL/ce4+Zd7kSRJkfjwwbUwG0gdhdJqzqygh4APjr2VlwYa+xy984QLHBmwQ9uNg
         5ZUGJdbxYA7bYL/rKFjDEx3OfB7lHYWyE/TWd2LHmayE7GfuBVI7gIEJzOBIYhN4CyUK
         Xfws2MaG13aBPNWlYiGIW+dHD+edm1ykZI6OFzM+tNALXjUPOtQlEnTvwR68U9Rggvjt
         7rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJ+jI33BK+IYABzbLprukt/esmp8Kd2Mu/RCj0l/WTU=;
        b=2o/wpnnbl+EyQQVRRTCfr9x+M2bWDVU0zk9XBEjxTAdCF984lxwXYz/9JccXHE9D74
         NKxOCwWiZMq6ttx5zhoAAeyU6ItJ72N9Bp1PSjPFF33lS5s/1JrL0kolSGZOUmQdzZjG
         I+waqVpyj7Gard2hSBk4IAGDfglaEm9Iil1duXkACz6hq0OYgW4cghu2z9KLL4WC1MpC
         BxxkSjjHgQ6QJjddKHcXmX5JC1AdNOoiE5jsSAYLsKYMjND6KF5kLHDxAGaUHr4CppHg
         paVsyeiFwcw68B0fc6o592UuEx3YiQc/IVh+InVvYbwkm6oFo2ZcROGB8hrN5aEEvRY+
         HKFQ==
X-Gm-Message-State: AOAM533p/BIMzHP9MDkR5BfrwIBechQadqZMCcU1I9okxYA49g2Ib00C
        R/BfVdNHdg6/XlLexVRKrNKpN4zNYZg=
X-Google-Smtp-Source: ABdhPJyslLPn7FWWEPWV1cYi9/hF3sivwECLibE49scPIwcj823lKlDUWaloHAw9fWMYs+WmattCeg==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr8941424pjb.231.1635379141554;
        Wed, 27 Oct 2021 16:59:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 00/23] Bluetooth: HCI command synchronization
Date:   Wed, 27 Oct 2021 16:58:37 -0700
Message-Id: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
v7: More fixes for CI findings.
v8: Even more fixes for CI findings.

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

