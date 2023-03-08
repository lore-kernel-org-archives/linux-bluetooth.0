Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E0C678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCHScw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCHScu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 13:32:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64810C8898
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678300369; x=1709836369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tr9w+4yorS3jGsEsPJ6CZH0sYjEcTKE3IRD7bBTih/A=;
  b=Jb2bUHc97PJCFEIpmf7FD0Gs2O/iX/2mcJ79fF6vbBgocataAXzQQP0F
   I4HGUUAUQ29XWTmg5x5qKrMCUdSzg8JpKnim5A1Ze6/ugcqZIhGQAn7qf
   CuGfMuTzHzpWN4WtlBspI9LcIg5tIb718Y3bA5xz9BJ5UzJb7YhNRSZXx
   oLgsxHGXbDnK1OGKLWHmneU14/yBsqAlbnq62B8lfSI+wH6xkHRBCCXt/
   PqjDpbVjo7CapNZpv0hDyhi3IMnIL1uPbJcILsRIBeAS+h9YFP/pnFyxQ
   OjHDdN4LfuD/DlU/ycyZ1+8liip0GtlcfXc4jHlAeZPj7WEGZmWpmePCe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316637181"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="316637181"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627034101"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="627034101"
Received: from istotlan-mobl1.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.209.120.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:32:48 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] Bluetooth: hci_sync: Remove duplicate statement
Date:   Wed,  8 Mar 2023 10:32:35 -0800
Message-Id: <20230308183235.326109-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes the following duplicate statement in
hci_le_ext_directed_advertising_sync():
cp.own_addr_type = own_addr_type;

Signed-off-by: Inga Stotland <inga.stotland@intel.com>
---
 net/bluetooth/hci_sync.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 450d9690bc30..8e5fe73873a8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5849,7 +5849,6 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	memset(&cp, 0, sizeof(cp));
 
 	cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
-	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.tx_power = HCI_TX_POWER_INVALID;
 	cp.primary_phy = HCI_ADV_PHY_1M;
-- 
2.39.2

