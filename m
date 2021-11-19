Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2583C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D561AD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhKSISH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbhKSISG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098367"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468739"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:03 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 05/14] Bluetooth: btintel: Add support to fetch data path id for a2dp offload
Date:   Fri, 19 Nov 2021 13:50:18 +0530
Message-Id: <20211119082027.12809-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During *setup*, when configuring offload, set get_data_path_id callback
function and support fetching of data path id for a2dp offload use case.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 4b6d7ea08425..1501376ccf72 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2214,16 +2214,30 @@ static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 transport,
 {
 	struct btintel_data *intel_data;
 
-	if (transport != HCI_TRANSPORT_SCO_ESCO)
+	if (transport != HCI_TRANSPORT_SCO_ESCO &&
+	    transport != HCI_TRANSPORT_ACL) {
+		bt_dev_err(hdev, "Invalid transport type %u", transport);
 		return -EINVAL;
+	}
 
 	intel_data = hci_get_priv((hdev));
 
-	if (intel_data->use_cases.preset[0] & 0x03) {
-		/* Intel uses 1 as data path id for all the usecases */
-		*data_path_id = 1;
-		return 0;
+	switch (transport) {
+	case HCI_TRANSPORT_SCO_ESCO:
+		if (intel_data->use_cases.preset[0] & 0x03) {
+			*data_path_id = 1;
+			return 0;
+		}
+		break;
+	case HCI_TRANSPORT_ACL:
+		if (intel_data->use_cases.preset[0] & 0x08) {
+			*data_path_id = 1;
+			return 0;
+		}
+		break;
 	}
+	bt_dev_err(hdev, "Required preset is not supported 0x%02x",
+		   intel_data->use_cases.preset[0]);
 	return  -EOPNOTSUPP;
 }
 
@@ -2262,6 +2276,10 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 		hdev->get_codec_config_data = btintel_get_codec_config_data;
 	}
 
+	/* supports SBC codec for a2dp offload */
+	if (use_cases->preset[0] & 0x08)
+		hdev->get_data_path_id = btintel_get_data_path_id;
+
 error:
 	kfree_skb(skb);
 	return err;
-- 
2.17.1

