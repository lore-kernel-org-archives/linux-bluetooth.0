Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918E2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC960F21
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhICKyY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:30312 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349215AbhICKyR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="199614849"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="199614849"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090451"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:16 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 09/12] Bluetooth: btintel: Define a callback to fetch codec config data
Date:   Fri,  3 Sep 2021 16:28:10 +0530
Message-Id: <20210903105813.2440-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define callback function to get codec config data. In HFP offload
usecase, controllers need to be set codec details before opening SCO.
This callback function is used to fetch vendor specific codec config
data.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v14:
     - No changes
    
    * changes in v13:
     - No changes
    
    * changes in v12:
     - No changes
    
    * changes in v11:
     - Remove changes related to Kconfig
    
    * changes in v10:
      - new patch due to refactoring

 drivers/bluetooth/btintel.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 751e0f0b8242..115bb2d07a8d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2158,6 +2158,55 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	return err;
 }
 
+static int btintel_get_codec_config_data(struct hci_dev *hdev,
+					 __u8 link, struct bt_codec *codec,
+					 __u8 *ven_len, __u8 **ven_data)
+{
+	int err = 0;
+
+	if (!ven_data || !ven_len)
+		return -EINVAL;
+
+	*ven_len = 0;
+	*ven_data = NULL;
+
+	if (link != ESCO_LINK) {
+		bt_dev_err(hdev, "Invalid link type(%u)", link);
+		return -EINVAL;
+	}
+
+	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
+	if (!ven_data) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	/* supports only CVSD and mSBC offload codecs */
+	switch (codec->id) {
+	case 0x02:
+		**ven_data = 0x00;
+		break;
+	case 0x05:
+		**ven_data = 0x01;
+		break;
+	default:
+		err = -EINVAL;
+		bt_dev_err(hdev, "Invalid codec id(%u)", codec->id);
+		goto error;
+	}
+	/* codec and its capabilities are pre-defined to ids
+	 * preset id = 0x00 represents CVSD codec with sampling rate 8K
+	 * preset id = 0x01 represents mSBC codec with sampling rate 16K
+	 */
+	*ven_len = sizeof(__u8);
+	return err;
+
+error:
+	kfree(*ven_data);
+	*ven_data = NULL;
+	return err;
+}
+
 static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
 {
 	/* Intel uses 1 as data path id for all the usecases */
@@ -2190,8 +2239,10 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 		goto error;
 	}
 
-	if (use_cases->preset[0] & 0x03)
+	if (use_cases->preset[0] & 0x03) {
 		hdev->get_data_path_id = btintel_get_data_path_id;
+		hdev->get_codec_config_data = btintel_get_codec_config_data;
+	}
 error:
 	kfree_skb(skb);
 	return err;
-- 
2.17.1

