Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C1C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiHARP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiHARPS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A56315
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659374116; x=1690910116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1pF1gYPCY7F7+C+u6fZi8e0ZulNq6em06lp2WdlG3nM=;
  b=b7nI0Rt4ITyW4KSVM/VARFTo0EXAyF6V0FZp1xTO1LTUFznYxCbJTA5I
   64PE0P9KcFy8wADDszbYIIcrVshIFc65CQEoPypmqljEPrQMW5c8OXj+S
   7oj+bh4DqWmuBgx/YXd2qKNAm478ZPmKE8M/fYlAvlY1s/E8IjYv4tZss
   QGqSQZWYeKIww7b2jNvvmhBBXLNAqiclwgHjwXstn/PPrg/IKeUDYOG7T
   11ZI2j9IwhfO3ggMJl6Y12dIgSamGDxwJhJdmZLPiXrCHhnJUHwexSQ6m
   y99Qml3N7q0d3ZL1RAbNw5EsYLcZ/H/mqM/U4YKlOOYmiagFozq/3wuL9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276104765"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276104765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847899602"
Received: from gestarne-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.120.49])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 00/10] Clean-up stale/unused hci_request.c code
Date:   Mon,  1 Aug 2022 10:14:55 -0700
Message-Id: <20220801171505.1271059-1-brian.gix@intel.com>
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

Brian Gix (10):
  Bluetooth: Convert le_scan_disable timeout to hci_sync
  Bluetooth: Rework le_scan_restart for hci_sync
  Bluetooth: Delete unused hci_req_stop_discovery()
  Bluetooth: Convert SCO configure_datapath to hci_sync
  Bluetooth: Convert Interleave Scanning timeout to hci_sync
  Bluetooth: Move Adv Instance timer to hci_sync
  Bluetooth: Delete unreference hci_request code
  Bluetooth: move hci_get_random_address() to hci_sync
  Bluetooth: convert hci_update_adv_data to hci_sync
  Bluetooth: Convert hci_abort_conn to hci_sync

 include/net/bluetooth/hci_sync.h |   10 +-
 net/bluetooth/hci_conn.c         |   92 +-
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_request.c      | 2002 +-----------------------------
 net/bluetooth/hci_request.h      |   61 -
 net/bluetooth/hci_sync.c         |  567 ++++++++-
 net/bluetooth/mgmt.c             |    7 +-
 8 files changed, 646 insertions(+), 2099 deletions(-)

-- 
2.37.1

