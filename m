Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EE1610C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhJ0WUd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhJ0WUc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACAAC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa4so3172795pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaWprdpzkTYH7GBe0ZIyKMsHRON8pa07h23gy+F+n5M=;
        b=BFsXuE3Ojv1uN3DI2je0SfwsLpKspzVSP2JwLCRC3mr9y+1/vZw27g7JT1XcKHSlPr
         iVj+omx87QFNGUAUbgH8jyXbsLheAWdO/FW6WDjGeRmsTzfWxKwIDj1NtlzQdS09cyPF
         hkHAKk5BKtJciAU7/Zuob4d0RyfKxwutgoJzXrr1EHT9kNIv/n5bFyC09d5DNqEOl1PS
         JP0uXlo/e4InFil2GldURxAI0xUvha1e+v1hchu+9AK6OfIDho8CF0VsAwhMuolsYZpD
         cULEIn9lYwErCObTcjCpRXEZmsdkOOvYnYrH91aF6rBs/kvNPuTCRHsoyuBfBhwU3tCp
         0ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JaWprdpzkTYH7GBe0ZIyKMsHRON8pa07h23gy+F+n5M=;
        b=v0KURYlrRCImBKsvvDETiIZHSbksMZDMRHialqcT0oOqfasclLE/DXnkJqui6e5rl7
         Xn/6Uu2L1kIrqgCxhwRUvaUMR16Bxxw4y27/HAV76OqhuMg1ysdAXWKsmaDM+lBdSKwQ
         sPvCyP2NVlLqnPglEvx+O2DoK1Rf9gFcJyyBJnG7X3govdBpPgSz1OPeJWmcLBTL2Uxy
         hiQ1YEUelVipJpE9JxTRQ5lzMZKeiy3G6ZCK5Dx6hCEqSLhrSFXtj7Cvr+JNe16woq7V
         uwY4aX0ctSFtMIokfeFBiCqedEyIOIEBJGVdODjhG5avOdt/7UYkGuREEnaJl1zvetsx
         chfA==
X-Gm-Message-State: AOAM530lcFBFnSUYvLHvagZkAO7CiVfBccgLFGheKCyV25BWS4GbRwCM
        GeJ0YxAHg1rIVgsaeZWOSxL6i6RCTtM=
X-Google-Smtp-Source: ABdhPJw5wZzfedEwV4q5BL70/3qj8oUu6leGYHnehwdujZkYSX9Pmp0YMBc8W3nvNnptqZWt7COb7g==
X-Received: by 2002:a17:902:6b0c:b0:13f:aaf4:3db4 with SMTP id o12-20020a1709026b0c00b0013faaf43db4mr267137plk.46.1635373085324;
        Wed, 27 Oct 2021 15:18:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 00/23] Bluetooth: HCI command synchronization
Date:   Wed, 27 Oct 2021 15:17:39 -0700
Message-Id: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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

