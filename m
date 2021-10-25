Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7410FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6EB60F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhJYXn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhJYXn1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C44C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w16so370542plg.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4RcHhvqOeHJOnULxKttT+7jKGmubwaTQfyZzVejIXM=;
        b=DTJoECgqLkI6xBdODwaf20bBXgNh/mCtocxtWLX/c4noXmrMKB1UDRvY6H1RGk/JaP
         l3H0Z0dTeJPsN5vSH7oPouFo8vFBICqDNFw5Vuw99ZbnkOPG/rVbu1onRNUSmeTSmF4R
         CDhHa5HjFSscTVWX/NhviGiAruuBC57avi0UBM1i0srokoGvKw3L7uMfjBkrXmoqssbC
         9AsVcqSubu7H+qZGSx3pZu3GCXTWCPwEnog7YwyjwVcihtIoe+1LIupz+Er8SjF6Zq05
         6ChxB2cOu2bRoWktrd/W1hOQeO9yPDg/JzytMR8qJhoSGBacvuOdw35aknDIwl85EOYk
         CK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4RcHhvqOeHJOnULxKttT+7jKGmubwaTQfyZzVejIXM=;
        b=7iCr0TsQaUrOso2IR5PpIGF+OwJdWL0Dac7Mvwl7gx3zXGgh7KZ0jWzZu58/soviEZ
         cEk1g5Cv7bqqvZXs57VkwEmiuDfAHzRXeS9YOn9iXi9SiEemTjd0Aulqto13/0WXGl3R
         Zq87Z2kzO/S121UsDHOoM215V1Ocxu3BRZObJo7GYs3jEnakxMHCecmZh0X8WAESGqsJ
         ms837HGYx8VkR2Af9rezD00ONGk2f84ixhRn8pfPQhqdCqDD+y2i64HVMeTHhqujcL6I
         BhBIMakeoqYubsIbdbkNn9RtfPnp7L6H7cZ1jad2f3GendKoFoBnHHxP0oEJVNNbuXu7
         xHdQ==
X-Gm-Message-State: AOAM531mEVmj8HAy5cIZzUeiVWdQxi9hKFdQr6RrvBYDsW3mjS1ndxg0
        0yYWjEtEOTSWlI6YUF9yfkC9nx64NtU=
X-Google-Smtp-Source: ABdhPJz0Pjq6ptw/d/+c0vTdF4QGxj/XbUwDEpVgqu+0Z4Gz+M79pxhhuxzHnnGkuhJ4S+5lZG/RZA==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr38955742pjb.34.1635205263358;
        Mon, 25 Oct 2021 16:41:03 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 00/23] Bluetooth: HCI command synchronization
Date:   Mon, 25 Oct 2021 16:40:39 -0700
Message-Id: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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

