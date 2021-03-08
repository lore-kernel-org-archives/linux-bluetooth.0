Return-Path: <SRS0=kCXZ=IG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F165BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDD0651CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 13:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHNMn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:12:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:2616 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhCHNMl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 08:12:41 -0500
IronPort-SDR: 65/raWrl9Xl9stv19Y0XDcDWQn0pO3SAMAMz5WGgFzy2n2J2Kf1ULOEw3X2HjfKILTv3Y34EFp
 gOoxLQlvS4Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="249403087"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="249403087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 05:12:40 -0800
IronPort-SDR: eLzWOlMdb/1741JX49b8M1kosZokKJ116XPWoTUnMQPYATjvwWhAm45lZnsHUjB3QiPl803Ocs
 v2yTYgmvFiCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="598853427"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2021 05:12:38 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] btintel: Fix offset calculation boot address parameter
Date:   Mon,  8 Mar 2021 18:46:01 +0530
Message-Id: <20210308131601.5799-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Boot address parameter was not getting updated properly
due to wrong offset

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..ea3edf28d513 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -863,7 +863,8 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 			/* The boot parameter is the first 32-bit value
 			 * and rest of 3 octets are reserved.
 			 */
-			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
+			*boot_param = get_unaligned_le32(fw_ptr + frag_len
+							 + sizeof(*cmd));
 
 			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
 		}
-- 
2.17.1

