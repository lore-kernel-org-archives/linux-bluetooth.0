Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C7ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 18:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIASZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIASZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 14:25:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F03AE5F
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662056745; x=1693592745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Gd5OHkFpGgmPftdR/J34+T4MyzeM4uQWhHflynTUko=;
  b=KrI+G8oAlKnhEW9pWLSq1tplenoruxAnFK2I9G4a+XJh4HCc/5pNppDP
   jTe+6BFRFuKimXvSJPZS7YiodQHf3NW9sA0ETk5nZyAZiaGsL1QZw2tJO
   W4RGrQYhSqZrkgb+jd4qm1UQHZ162mLIehcKIaE7lpCB3/lnDpKQrPxe8
   Gt5nP89eHfXE2RmumsSIHf8sj3BWu44QlCfV7A6ldCx2cL/CFHrih11eK
   rAC4eVbeB0gTvSchdDi49VecN9j9SHGsF3Z+mkCYutSe4gLityNjUydSm
   +9Any8w5akASP/RO1UYa4ccdOZY6NPYxWJ21WGCcukHz4G2mvNi7Q0uGu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295803457"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="295803457"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 11:25:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="940962376"
Received: from ghonawax-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.58.197])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 11:25:45 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 0/2] Add Mesh functionality to net/bluetooth
Date:   Thu,  1 Sep 2022 11:25:25 -0700
Message-Id: <20220901182528.13487-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Housekeeping and implementation

v2: Add checking for Packet Ownership when querying Tx queue state
    Add cleanup of Tx queue when MGMT socket closes

v3: Fix CI complaints

v4: More indent clean-ups and proper var types

v5: Conform to the ADV Instance mechanism, and make fully compatible
    with Extended Advertising mechanism.

v6: Paired with BlueZ user space unit tests (tools/mesh-tester)

Brian Gix (2):
  Bluetooth: Implement support for Mesh
  Bluetooth: Add experimental wrapper for MGMT based mesh

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   4 +
 include/net/bluetooth/hci_core.h  |  16 +-
 include/net/bluetooth/mgmt.h      |  52 +++
 net/bluetooth/hci_core.c          |  13 +-
 net/bluetooth/hci_event.c         |  61 ++--
 net/bluetooth/hci_sock.c          |   1 +
 net/bluetooth/hci_sync.c          |  87 ++++-
 net/bluetooth/mgmt.c              | 589 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  74 ++++
 net/bluetooth/mgmt_util.h         |  18 +
 11 files changed, 864 insertions(+), 52 deletions(-)

-- 
2.37.2

