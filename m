Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B2FC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 17:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBXR5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBXR5N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 12:57:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425611815F
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677261432; x=1708797432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g4wXpprkRa/iB6MZBs6i+t/POeRRKYTneJSFBgpCB/4=;
  b=WnEk6kj9zdxWH2whnxD8hc7RKQSLkTnf65fHDry969cDkVyV1Fd1Gm8K
   /BBOXEX39WYCaVQKBVuUWVv1GF7EK7ybD9ETa46YtijKZiauKYQR+kE2N
   PO6hYILJ3iEdm7UraV6xCfYam3Noi5jihkv2rQ55TmsqQT//C+yr/UdMU
   pwtOekxXlzY8GIQCqTAWGnpMyz6K3TLuLIo8OWyCK4HuQ/Fwi4h2NL2za
   51cFa7dWsQ3004CEHkJZZWV4w1lBpLuNkgQCj/N3+b+ZfjHF1c12a5ylr
   p3+5cOpsnc5lvlLl2cuKQ35pG3FcvGUBJcKInL/I3NfqqO4AWnEjWl1aP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="334964200"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="334964200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 09:56:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="1001905060"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="1001905060"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.115.155])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 09:56:50 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Date:   Fri, 24 Feb 2023 09:56:32 -0800
Message-Id: <20230224175632.461834-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.39.2
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
2.39.2

