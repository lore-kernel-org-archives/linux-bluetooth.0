Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78583C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKBR7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKBR7i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 13:59:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BF21EEDD
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667411977; x=1698947977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=InEZeZdNqHj6bbfxfSEZhhK1gaslNg5sOEx6GflAtY8=;
  b=KSqEIsy/N+2KQqZIgvhV5yRCb1PVNluDLMztHSDZaNvkq8O+3b6sF4oR
   RTDb4mvKtH/ZLnc+pALEV6L9VVOrOp4SE+iCac67FMYrNDoQbvuuqVqn+
   uj3Qsa0Vi5zEAy+nbFwJA5KrTQu+JJrQfxUO91WYD9+qPIZBdXJeBds3M
   /LR6jS7jmImgXuYLA1HHzbXd/mRJ+u+qZiTNntwk3ZBsvckUamJwdzwVh
   h3h2UQTSVA6xsSDrUtphKWU/OtiD7peQUx17wM9BEjPJdFoHikdYjqc0t
   NoM02FeqhBD8Cun7POWr4OoQMEswJZZJ5gCABrDy/1/3MVlmM2n+hvZxj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292798251"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="292798251"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 10:59:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="963626147"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="963626147"
Received: from xwang-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.69.185])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 10:59:36 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, marex@denx.de
Subject: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Date:   Wed,  2 Nov 2022 10:59:27 -0700
Message-Id: <20221102175927.401091-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102175927.401091-1-brian.gix@intel.com>
References: <20221102175927.401091-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The msft_set_filter_enable() command was using the deprecated
hci_request mechanism rather than hci_sync. This caused the warning error:
hci0: HCI_REQ-0xfcf0

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/msft.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index bee6a4c656be..bf5cee48916c 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -743,17 +743,12 @@ __u64 msft_get_features(struct hci_dev *hdev)
 }
 
 static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
-						       u8 status, u16 opcode,
-						       struct sk_buff *skb)
+						       void *user_data,
+						       u8 status)
 {
-	struct msft_cp_le_set_advertisement_filter_enable *cp;
-	struct msft_rp_le_set_advertisement_filter_enable *rp;
+	struct msft_cp_le_set_advertisement_filter_enable *cp = user_data;
 	struct msft_data *msft = hdev->msft_data;
 
-	rp = (struct msft_rp_le_set_advertisement_filter_enable *)skb->data;
-	if (skb->len < sizeof(*rp))
-		return;
-
 	/* Error 0x0C would be returned if the filter enabled status is
 	 * already set to whatever we were trying to set.
 	 * Although the default state should be disabled, some controller set
@@ -766,7 +761,6 @@ static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	cp = hci_sent_cmd_data(hdev, hdev->msft_opcode);
 	msft->filter_enabled = cp->enable;
 
 	if (status == 0x0C)
@@ -804,31 +798,23 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	return msft_remove_monitor_sync(hdev, monitor);
 }
 
-void msft_req_add_set_filter_enable(struct hci_request *req, bool enable)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct msft_cp_le_set_advertisement_filter_enable cp;
-
-	cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
-	cp.enable = enable;
-
-	hci_req_add(req, hdev->msft_opcode, sizeof(cp), &cp);
-}
-
 int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 {
-	struct hci_request req;
+	struct msft_cp_le_set_advertisement_filter_enable cp;
 	struct msft_data *msft = hdev->msft_data;
 	int err;
 
 	if (!msft)
 		return -EOPNOTSUPP;
 
-	hci_req_init(&req, hdev);
-	msft_req_add_set_filter_enable(&req, enable);
-	err = hci_req_run_skb(&req, msft_le_set_advertisement_filter_enable_cb);
+	cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
+	cp.enable = enable;
+	err = __hci_cmd_sync_status(hdev, hdev->msft_opcode, sizeof(cp), &cp,
+				    HCI_CMD_TIMEOUT);
+
+	msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);
 
-	return err;
+	return 0;
 }
 
 bool msft_curve_validity(struct hci_dev *hdev)
-- 
2.38.1

