Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0AFC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3C061041
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhHaM4A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 08:56:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:2326 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhHaMz7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 08:55:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="198700647"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="198700647"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 05:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="509929053"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2021 05:54:59 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel: Fix boot address
Date:   Tue, 31 Aug 2021 18:30:04 +0530
Message-Id: <20210831130005.4920-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Cache Boot address present in firmware file which
is later used in Intel_Soft_Reset command to bring
controller from boot mode to operational mode.

Signed-off-by: Kiran K <kiran.k@intel.com>
---

Notes:
    * changes in v2:
     - move reading of boot address to seprate patch
    
    * changes in v1:
     - cache boot address
     - read boot address irrespective of mode

 drivers/bluetooth/btintel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 778d803159f3..14360370a2ac 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1037,8 +1037,9 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			params = (void *)(fw_ptr + sizeof(*cmd));
 
-			bt_dev_info(hdev, "Boot Address: 0x%x",
-				    le32_to_cpu(params->boot_addr));
+			*boot_addr = le32_to_cpu(params->boot_addr);
+
+			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
 				    params->fw_build_num, params->fw_build_ww,
-- 
2.17.1

