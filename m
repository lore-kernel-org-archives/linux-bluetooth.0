Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C4C64FA3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBEWbu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:31:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:51762 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhBEORE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:04 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 Feb 2021 07:37:44 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Feb 2021 07:37:42 -0800
X-QCInternal: smtphost
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Feb 2021 21:07:18 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 3161A21E01; Fri,  5 Feb 2021 21:07:18 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca:Fixed issue during suspend
Date:   Fri,  5 Feb 2021 21:07:16 +0530
Message-Id: <1612539436-8498-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If BT SoC is running with ROM FW then just return in
qca_suspend function as ROM FW does not support
in-band sleep.

Fixes: 2be43abac5a8 ("Bluetooth: hci_qca: Wait for timeout during suspend")
Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ff2fb68..de36af6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -77,7 +77,8 @@ enum qca_flags {
 	QCA_MEMDUMP_COLLECTION,
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
-	QCA_BT_OFF
+	QCA_BT_OFF,
+	QCA_ROM_FW
 };
 
 enum qca_capabilities {
@@ -1664,6 +1665,7 @@ static int qca_setup(struct hci_uart *hu)
 	if (ret)
 		return ret;
 
+	clear_bit(QCA_ROM_FW, &qca->flags);
 	/* Patch downloading has to be done without IBS mode */
 	set_bit(QCA_IBS_DISABLED, &qca->flags);
 
@@ -1721,12 +1723,14 @@ static int qca_setup(struct hci_uart *hu)
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
+		set_bit(QCA_ROM_FW, &qca->flags);
 		ret = 0;
 	} else if (ret == -EAGAIN) {
 		/*
 		 * Userspace firmware loader will return -EAGAIN in case no
 		 * patch/nvm-config is found, so run with original fw/config.
 		 */
+		set_bit(QCA_ROM_FW, &qca->flags);
 		ret = 0;
 	}
 
@@ -2103,6 +2107,12 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
+	/* if BT SoC is running with default firmware then it does not
+	 * support in-band sleep
+	 */
+	if (test_bit(QCA_ROM_FW, &qca->flags))
+		return 0;
+
 	/* During SSR after memory dump collection, controller will be
 	 * powered off and then powered on.If controller is powered off
 	 * during SSR then we should wait until SSR is completed.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

