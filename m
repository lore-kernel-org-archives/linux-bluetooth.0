Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C7C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiHEXmv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiHEXms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA21A833
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742968; x=1691278968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pdi7GLOeDdzo27RXCfruuBd42kylveNEtLM6UvBHLwc=;
  b=L2XAKECGMm/5npwyXXp/8tFpi5t0G9QIit99ggTlMUxCAlC8N+tBqYey
   bqsyAdY94ELs8g2RX8GseeQmxKqb2ZNgSatCDlzzHS3QxVC9BKrz315Nr
   3wkLQsV9D5aA3x6SXNRhyUwPElIdOoLMAOtU0M/hxy/4+wMu2Jc0unB9S
   APj/hbk5rjCC0eB1GLOgJbI4ya+7mhkzWX9fJM8QYYPtTAwls1YRhuUJw
   pRHPK+g7oCBlPT6DlwihBQdE4cVHrEx2aZ4E5tSL209YBc2tXJYbzxn9R
   msEcQro7Qd82HNUFxbO220HkTk0oBdDr6Cl8z9Z4ptGhpXge2f5SuyeNk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362745"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362745"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661799"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:47 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 0/9] Clean-up stale/unused hci_request.c code
Date:   Fri,  5 Aug 2022 16:42:27 -0700
Message-Id: <20220805234236.704986-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This will be a growing patch-set of conversions and dead-code removal
towards the goal of retiring hci_request.c

The patch sets will be split amoung the work queues and delayed work
queues as initialized in hci_request_setup(), with the ultimate goal of
eliminating hci_request.c entirely.

v2: Published

v3: Continuing work.  This does include one conversion
(SCO configure_datapath) that has been tested with mgmt-tester and
sco-tester, but has not been tested with a controller with an
off-loadable codec.

v4: Clean-up checkpatch warnings.

v5: Remove remaining procedures from hci_request.c/h. Not that other
entities (notably amp.c, hci_event.c and hci_core.c) are still using
the hci_request mechanism, however, the mgmt-tester unit test only
currently execute opcode 0x1408 - HCI_OP_READ_ENC_KEY_SIZE during normal
testing.

v6: Fix CI reported errors, and recoded hci_abort_conn for optional sync
queue usage to fix some L2CAP test cases.

v7: Delete and rebase to remove conflicting interleave scan clean-up.
Will be done using work Luiz has been working on.

Brian Gix (9):
  Bluetooth: Convert le_scan_disable timeout to hci_sync
  Bluetooth: Rework le_scan_restart for hci_sync
  Bluetooth: Delete unused hci_req_stop_discovery()
  Bluetooth: Convert SCO configure_datapath to hci_sync
  Bluetooth: Move Adv Instance timer to hci_sync
  Bluetooth: Delete unreferenced hci_request code
  Bluetooth: move hci_get_random_address() to hci_sync
  Bluetooth: convert hci_update_adv_data to hci_sync
  Bluetooth: Convert hci_abort_conn to hci_sync

 include/net/bluetooth/hci_sync.h |   10 +-
 net/bluetooth/hci_conn.c         |   92 +-
 net/bluetooth/hci_core.c         |    2 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_request.c      | 1650 +++---------------------------
 net/bluetooth/hci_request.h      |   53 -
 net/bluetooth/hci_sync.c         |  500 ++++++++-
 net/bluetooth/mgmt.c             |    7 +-
 8 files changed, 733 insertions(+), 1583 deletions(-)

-- 
2.37.1

