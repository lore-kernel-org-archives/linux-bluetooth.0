Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76CEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGTTpY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGTTpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 15:45:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC51145B
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658346323; x=1689882323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mmkRY9l9rqqszJETUwX8Y84EM0MdZ6QZPI57Vdl+woM=;
  b=i2xWkXbtPpHxbkr+PD74lx2DXTUr0lsHN9zK4X6WJmGqGxpkWg2R6bEJ
   WbCEX5b8f9oYDBl95A0W4idiLNk8VsBId1ERMEava7/xvq3T9GhRLv5Of
   2wSxrwY7fMvNjeqo+zciNme1V7SxPaVyOYQeLU7ecE9PICloDCsx3xUxs
   CWJjFd/W9Y/gWHiAsAGji+gUnyf4clIgUJ5bdchTBFfXSAGcMchdha0xz
   bm87NsBAdMPHMq2EroSGlMtnZOOw2YI/whpTdO0J06P6xLkSNvmddvi9W
   5SDEiNOno7W+DGgnBRIrjwj7x79rl15AL5G1Bwoe/ujfCqvEi1tPAOudX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287615648"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="287615648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:45:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="740410342"
Received: from kjmoraji-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.165.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:45:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 0/2] Add Mesh functionality to net/bluetooth
Date:   Wed, 20 Jul 2022 12:45:09 -0700
Message-Id: <20220720194511.320773-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
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

Brian Gix (2):
  Bluetooth: Implement support for Mesh
  Bluetooth: Add experimental wrapper for MGMT based mesh

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   4 +
 include/net/bluetooth/hci_core.h  |  15 +-
 include/net/bluetooth/mgmt.h      |  52 +++
 net/bluetooth/hci_core.c          |  11 +-
 net/bluetooth/hci_event.c         |  61 ++--
 net/bluetooth/hci_request.c       |  96 ++++-
 net/bluetooth/hci_sock.c          |   1 +
 net/bluetooth/hci_sync.c          |  43 ++-
 net/bluetooth/mgmt.c              | 589 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  74 ++++
 net/bluetooth/mgmt_util.h         |  18 +
 12 files changed, 899 insertions(+), 66 deletions(-)

-- 
2.36.1

