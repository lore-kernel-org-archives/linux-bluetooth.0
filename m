Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56880C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbiBKIBu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbiBKIBu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 03:01:50 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 00:01:49 PST
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D111CBC4
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 00:01:49 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644566509; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KMBfuQ9cnWhBdTSAfP+/B5gEDLZBEABwyfbhSdmF+zE=; b=v+MwjOtkg71n560Vo8jgJpwT7VQGBJOfeGCHhndU9JlLhI0O34BsOhE6FrWj6m5zwOM2uyqF
 2UOUBgxASk6cZj+sF6VZ2787PVvhdbO+VkQMHCDKzvDz2XJcsaBAr/eEInSDyqVaL0c+XI28
 YqTTRH69IsLkOg9YUBqcYmklzvM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 620616be2afeb7f9b5f89408 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Feb 2022 07:56:46
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1B83C43616; Fri, 11 Feb 2022 07:56:45 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 518FDC4338F;
        Fri, 11 Feb 2022 07:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 518FDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        zijuhu@codeaurora.org, tjiang@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: btusb: Improve stability for QCA devices
Date:   Fri, 11 Feb 2022 15:56:36 +0800
Message-Id: <1644566196-15424-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Zijun Hu <quic_zijuhu@quicinc.com>

Controller will reset after NVM is downloaded for QCA
device, so wait a moment for reset Done then go ahead
to improve stability.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e03dfbd92fcc..0ec2f17fe1d3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2994,6 +2994,7 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 #define QCA_PATCH_UPDATED	0x80
 #define QCA_DFU_TIMEOUT		3000
 #define QCA_FLAG_MULTI_NVM      0x80
+#define QCA_BT_RESET_WAIT_MS    100
 
 #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
 #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
@@ -3320,6 +3321,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
 		if (err < 0)
 			return err;
+		/* Controller will reset after NVM is downloaded, so wait a moment
+		 * for reset Done, it will prevent controller from potential crash.
+		 */
+		msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

