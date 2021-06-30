Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0786C11F68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BD061D0D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhF3IG3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:06:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:5410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232966AbhF3IG2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 04:06:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272164643"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="272164643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="643997959"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2021 01:03:59 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v10 05/10] Bluetooth: btintel: Define callback to fetch data_path_id
Date:   Wed, 30 Jun 2021 13:38:02 +0530
Message-Id: <20210630080807.12600-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630080807.12600-1-kiran.k@intel.com>
References: <20210630080807.12600-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For Intel controllers supporting HFP offload usecase,
define a callback function to fetch data_path_id

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes on v10:
  - new patch due to refactoring

 drivers/bluetooth/btintel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 7f9b5f82d01f..cdb098235e88 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1273,6 +1273,13 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
 #if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
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
@@ -1297,6 +1304,9 @@ int btintel_configure_offload_usecases(struct hci_dev *hdev)
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

