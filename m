Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA421C43214
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2026121E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhG0Im7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:42:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:2131 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhG0Im7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 04:42:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192677090"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="192677090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 01:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="662541284"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2021 01:42:58 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v11 05/10] Bluetooth: btintel: Define callback to fetch data_path_id
Date:   Tue, 27 Jul 2021 14:17:08 +0530
Message-Id: <20210727084713.23038-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210727084713.23038-1-kiran.k@intel.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For Intel controllers supporting HFP offload usecase,
define a callback function to fetch data_path_id

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v11:
  - no changes
* changes in v10:
  - new patch due to refactoring

 drivers/bluetooth/btintel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a6b81914766e..49813f2d2e27 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1272,6 +1272,13 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
+{
+	/* Intel uses 1 as data path id for all the usecases */
+	*data_path_id = 1;
+	return 0;
+}
+
 int btintel_configure_offload_usecases(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1296,6 +1303,9 @@ int btintel_configure_offload_usecases(struct hci_dev *hdev)
 		err = -bt_to_errno(skb->data[0]);
 		goto error;
 	}
+
+	if (usecases->preset[0] & 0x03)
+		hdev->get_data_path_id = btintel_get_data_path_id;
 error:
 	kfree_skb(skb);
 	return err;
-- 
2.17.1

