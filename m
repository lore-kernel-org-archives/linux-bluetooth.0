Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A9C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0356D613B5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhDEOWB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 10:22:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:23691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237153AbhDEOWA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 10:22:00 -0400
IronPort-SDR: BfAqDGYBsQxa7rNSZMgg9iu1eWfJRlrQxj8J4u060RHncUhx7lny0qE4Jjz2OLk4cjug1HOneh
 VYmDqUXDieuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="179989776"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="179989776"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 07:21:54 -0700
IronPort-SDR: /bl9dBuDc+bvrd8vrfJ1PS7nZwl6rvmQCLq0LBDFOk1/eINN4G6D4nn/FlJybnh9Ojx1olW7gi
 exMKxdTrRQcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="448065409"
Received: from nsathish-latitude-7480.iind.intel.com ([10.224.186.105])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 07:21:52 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 1/2] Bluetooth: FIX: Own address type change with HCI_ENABLE_LL_PRIVACY
Date:   Mon,  5 Apr 2021 20:00:23 +0530
Message-Id: <20210405143023.16120-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

own_address_type has to changed to 0x02 and 0x03 only when
HCI_ENABLE_LL_PRIVACY flag is set.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 5b4eb87b19f0..0d78122342d5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2043,7 +2043,8 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (use_ll_privacy(hdev) &&
+		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
@@ -2517,7 +2518,8 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (use_ll_privacy(hdev) &&
+		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
-- 
2.17.1

