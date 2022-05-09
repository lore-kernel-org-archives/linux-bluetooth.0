Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D284C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiEIWJW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiEIWJS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 18:09:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921EC2A83C7
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652133923; x=1683669923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrK8pGnl6RSOXNFy4YwHctfUS1puFOClfvhqPlU3GwU=;
  b=VuINwch96P+w41phTeNwS0GbH1t3o0kIaPjI9iBS2QwPjAv7tqhV4GVV
   fwiC3cHFLOhQKAcFZkZN/ORHykjVbmL+jcUHe+9/8FLkkTFdiOtKtcEde
   WZ60serQpmoFt363vW/Vx0ZyetCn48XXxvLaFemF2btZFgxdg06nvgsPO
   mNQ9XdUq0eVIYEymhEocl+KY85Zmw5XX9qXgo7qXBexGhpEx9tCUe/Fce
   0+8aE7JiNeBKy2thQRo6Kd34Z67UzFcF23++2Y26pIM3EMIyGauSC9fHk
   LAf1+UfyReFLiDMFQ0c9rG5BMpQ8X0hlXQEABxEyNXAAopxoWRwdotU9U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329776688"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="329776688"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:05:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="657329488"
Received: from sameeram-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.88.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:05:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 0/2] Add Mesh functionality to net/bluetooth
Date:   Mon,  9 May 2022 15:05:10 -0700
Message-Id: <20220509220512.482695-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Housekeeping and implementation

v2: Add checking for Packet Ownership when querying Tx queue state
    Add cleanup of Tx queue when MGMT socket closes

Brian Gix (2):
  Bluetooth: Implement support for Mesh
  Bluetooth: Add experimental wrapper for MGMT based mesh

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   4 +
 include/net/bluetooth/hci_core.h  |  18 +-
 include/net/bluetooth/hci_sync.h  |   3 +
 include/net/bluetooth/mgmt.h      |  51 +++
 net/bluetooth/hci_conn.c          |   2 +-
 net/bluetooth/hci_core.c          |   1 +
 net/bluetooth/hci_event.c         |  61 ++--
 net/bluetooth/hci_request.c       | 115 +++++--
 net/bluetooth/hci_sock.c          |   1 +
 net/bluetooth/hci_sync.c          | 104 ++++--
 net/bluetooth/mgmt.c              | 551 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  69 ++++
 net/bluetooth/mgmt_util.h         |  17 +
 14 files changed, 915 insertions(+), 83 deletions(-)

-- 
2.35.1

