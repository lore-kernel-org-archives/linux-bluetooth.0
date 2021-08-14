Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96390C43216
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7776960F51
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhHNHWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:22:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:42835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhHNHWm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 03:22:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="213817657"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="213817657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 00:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="640022023"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2021 00:22:14 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v12 05/10] Bluetooth: btintel: Define callback to fetch data_path_id
Date:   Sat, 14 Aug 2021 12:56:24 +0530
Message-Id: <20210814072629.11748-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210814072629.11748-1-kiran.k@intel.com>
References: <20210814072629.11748-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For Intel controllers supporting HFP offload use cases,
define a callback function to fetch data_path_id.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

* changes in v12:
  - no changes

* changes in v11:
  - no changes

* changes in v10:
  - new patch due to refactoring

 drivers/bluetooth/btintel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fd7afaf42f5f..d4e23464a8d2 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2083,6 +2083,13 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	return err;
 }
 
+static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
+{
+	/* Intel uses 1 as data path id for all the usecases */
+	*data_path_id = 1;
+	return 0;
+}
+
 static int btintel_configure_offload(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2107,6 +2114,9 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 		err = -bt_to_errno(skb->data[0]);
 		goto error;
 	}
+
+	if (use_cases->preset[0] & 0x03)
+		hdev->get_data_path_id = btintel_get_data_path_id;
 error:
 	kfree_skb(skb);
 	return err;
-- 
2.17.1

