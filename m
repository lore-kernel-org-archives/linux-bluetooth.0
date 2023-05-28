Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A49C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE1RoU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE1RoS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:18 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB9A0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 921AA240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:16 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHh0xxqz6tw8;
        Sun, 28 May 2023 19:44:16 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/6] LE Set CIG Parameters / Create CIS fixes
Date:   Sun, 28 May 2023 17:44:08 +0000
Message-Id: <cover.1685294131.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset fixes a few issues with emission of HCI Remove CIG, Set
CIG Parameters, Create CIS when multiple ISO sockets in the same CIG are
closed and reconnected rapidly.

These were found when trying to make Samsung Galaxy Buds2 Pro stream
disabling and re-enabling work, and with a few additional emulator test
improvements.  In these cases, the user is closing and reconnecting ISO
sockets rapidly.  With this and the associated BlueZ patchset, disabling
and re-enabling streams on this device works correctly and the problem
in https://github.com/bluez/bluez/issues/516 is solved; this kernel
patchset contains nothing device specific though.

The last Create CIS patch probably could be done in different ways,
but seemed simplest to have hci_le_create_cis_sync be idempotent.

Pauli Virtanen (6):
  Bluetooth: ISO: fix maximum number of CIS in Set CIG Parameters
  Bluetooth: ISO: use hci_sync for setting CIG parameters
  Bluetooth: ISO: don't try to do Set CIG Parameters if CIG known busy
  Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
  Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
  Bluetooth: ISO: do not emit new LE Create CIS if previous is pending

 include/net/bluetooth/hci_core.h |   4 +-
 include/net/bluetooth/hci_sync.h |   2 +-
 net/bluetooth/hci_conn.c         | 139 +++++++++++++++++++------------
 net/bluetooth/hci_event.c        |  79 ++++++++++++++----
 net/bluetooth/hci_sync.c         |  90 ++++++++++++++------
 net/bluetooth/iso.c              |   2 +-
 6 files changed, 217 insertions(+), 99 deletions(-)

-- 
2.40.1

