Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CBECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIATTa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIATT3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 15:19:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697B79610
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662059969; x=1693595969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uFRUKsYAFjNr+8T8mDNeSwDaoFD9Cp0au2UQnB4g4YI=;
  b=l7L9L8v4xeMFiahOjnKKgO8l46VcEuf9PV7AXHmujTNr/msPGpV/FDoW
   pJW695uX3WPR0ZHA7CJkzbHqAf7kF91hn1QpVT4t9qV1zR03im0qxYYin
   BvYNxlNlX7Szt2PCVbYVWpcn3UjV+Sr7P8QPC7otnxwDElCqdg+XgwIm/
   puWgXGqRdWcySD+MyxYW9IRJzf3kjc8jQPf4yVDM7yoZUgCvwnWB50Eid
   YCSIuyg+lwR4fVflPTvJtigLSAwczsBGFmv/6EhbE7/6dhi1ZIc1dzx1x
   Z7/Vq2TK5//K1s7BvTbE7qK3+qF8hcD4fQWmkiAOZeBLkBo7iD//MUFFI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296590697"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296590697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674007689"
Received: from ghonawax-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.58.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:27 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 0/2] Add Mesh functionality to net/bluetooth
Date:   Thu,  1 Sep 2022 12:19:12 -0700
Message-Id: <20220901191914.22706-1-brian.gix@intel.com>
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

v7: Fix white space -- Note: Will fail mgmt-tester until new version
with Mesh Experimental feature patch is applied to BlueZ.

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
 net/bluetooth/mgmt.c              | 588 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  74 ++++
 net/bluetooth/mgmt_util.h         |  18 +
 11 files changed, 863 insertions(+), 52 deletions(-)

-- 
2.37.2

