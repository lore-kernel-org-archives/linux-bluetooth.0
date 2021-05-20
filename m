Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8062C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDEF60E0B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 11:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhETLlv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 07:41:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:39221 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242344AbhETLjd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 07:39:33 -0400
IronPort-SDR: ODxFkp+tU8E27o96+7VsnIWtPKb80KytBlWJv6lgAse9UBF3UZ4dr1n8QcUqtEX2+91v/+X4g/
 OUZMZD19cUmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="181484186"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181484186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 04:33:03 -0700
IronPort-SDR: HrCUXXoD5NPq5ltQiB2sIwESJo1yVMlWxKiHj4QFKh5dOWWp52RV+BexKdtHVN9wTE1E6zW9qd
 7IN3pyXnoPmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="628132069"
Received: from nsathish-latitude-7480.iind.intel.com ([10.224.186.105])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2021 04:33:01 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Translate additional address type during le_conn_comp
Date:   Thu, 20 May 2021 17:12:01 +0530
Message-Id: <20210520114201.32157-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using controller based address resolution, then the destination
address type during le_conn_complete uses 0x02 & 0x03 if controller
resolves the destination address(RPA).
These address types need to be converted back into either 0x00 0r 0x01

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_event.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4241ae310fcb..3b86e9176de1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5196,6 +5196,23 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		conn->dst_type = irk->addr_type;
 	}
 
+	/* When using controller based address resolution, then the new
+	 * address types 0x02 and 0x03 are used. These types need to be
+	 * converted back into either public address or random address type
+	 */
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		switch (conn->dst_type) {
+		case ADDR_LE_DEV_PUBLIC_RESOLVED:
+			conn->dst_type = ADDR_LE_DEV_PUBLIC;
+			break;
+		case ADDR_LE_DEV_RANDOM_RESOLVED:
+			conn->dst_type = ADDR_LE_DEV_RANDOM;
+			break;
+		}
+	}
+
 	if (status) {
 		hci_le_conn_failed(conn, status);
 		goto unlock;
-- 
2.17.1

