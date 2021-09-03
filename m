Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5403760F56
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbhICKyL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:35135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349198AbhICKyJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206611724"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206611724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090350"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:07 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 05/12] Bluetooth: btintel: Define callback to fetch data_path_id
Date:   Fri,  3 Sep 2021 16:28:06 +0530
Message-Id: <20210903105813.2440-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For Intel controllers supporting HFP offload usecase,
define a callback function to fetch data_path_id

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v14:
      - no changes
    
    * changes in v13:
      - no changes
    
    * changes in v12:
      - no changes
    
    * changes in v11:
      - no changes
    
    * changes in v10:
      - new patch due to refactoring

 drivers/bluetooth/btintel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 60f9866c6792..751e0f0b8242 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2158,6 +2158,13 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
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
@@ -2182,6 +2189,9 @@ static int btintel_configure_offload(struct hci_dev *hdev)
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

