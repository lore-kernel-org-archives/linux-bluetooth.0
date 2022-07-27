Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F2C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiG0N67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiG0N6o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 09:58:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E21F2F9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658930323; x=1690466323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GJqHTmbeQKPAuc0dp1qLtdjVRbcPBTx15mikx66D5ps=;
  b=g2aKr3M7TdfXGON0EcHKzc4dDPTwLkOtg1BpwGKtG9FEclcXrMpf68po
   b3cTCrzL6UOSME1wGm7xXQDirK++2hp35oJ6lUSTTp1uj5vmqF++k9Pfn
   4yR2govlz6j0HWBudiUFd2QuCGOCEU8e5K2k8MH4o+ffEmGNGqeicA0G4
   YBlcJNf4ECBNVrHqpl970SllMMSIr93zLi9IeiyPhpFM2hBrss4UM9aH5
   wgUkx2PSI8ILhyI7daSK3KUJIiYp++lMqq01+3bLNt4jX1GimhvJgFVQ7
   kxjo3H+2j8Ho1Z0Cx/JRwW/NzdiNwiWdRGzL8UpgpfdGk3uuQvxFSL8fU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="352232997"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="352232997"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 06:58:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="689874774"
Received: from ksloan-mobl7.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.184.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 06:58:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v4 0/4] Clean-up stale/unused hci_request.c code
Date:   Wed, 27 Jul 2022 06:58:30 -0700
Message-Id: <20220727135834.294184-1-brian.gix@intel.com>
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

Brian Gix (4):
  Bluetooth: Convert le_scan_disable timeout to hci_sync
  Bluetooth: Rework le_scan_restart for hci_sync
  Bluetooth: Delete unused hci_req_stop_discovery()
  Bluetooth: Convert SCO configure_datapath to hci_sync

 net/bluetooth/hci_conn.c    |  86 +++++++++--
 net/bluetooth/hci_request.c | 282 +-----------------------------------
 net/bluetooth/hci_request.h |   4 -
 net/bluetooth/hci_sync.c    | 148 +++++++++++++++++++
 4 files changed, 224 insertions(+), 296 deletions(-)

-- 
2.37.1

