Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Dec 2020 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBA722287
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Dec 2020 17:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3RSS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Dec 2020 12:18:18 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27907 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgL3RSR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Dec 2020 12:18:17 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 30 Dec 2020 09:17:37 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Dec 2020 09:17:35 -0800
X-QCInternal: smtphost
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg02-blr.qualcomm.com with ESMTP; 30 Dec 2020 22:47:11 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 283B821298; Wed, 30 Dec 2020 22:47:10 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Wait for SSR completion during suspend
Date:   Wed, 30 Dec 2020 22:47:08 +0530
Message-Id: <1609348628-3932-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During SSR after memory dump collection,BT controller will be powered off,
powered on and then FW will be downloaded.During suspend if BT controller
is powered off due to SSR then we should wait until SSR is completed and
then suspend.

Fixes: 2be43abac5a8 ("Bluetooth: hci_qca: Wait for timeout during suspend")
Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4a96368..6ad4079 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -50,7 +50,8 @@
 #define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
 #define CMD_TRANS_TIMEOUT_MS		100
 #define MEMDUMP_TIMEOUT_MS		8000
-#define IBS_DISABLE_SSR_TIMEOUT_MS	(MEMDUMP_TIMEOUT_MS + 1000)
+#define IBS_DISABLE_SSR_TIMEOUT_MS \
+	(MEMDUMP_TIMEOUT_MS + FW_DOWNLOAD_TIMEOUT_MS)
 #define FW_DOWNLOAD_TIMEOUT_MS		3000
 
 /* susclk rate */
@@ -2100,7 +2101,12 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
-	if (test_bit(QCA_BT_OFF, &qca->flags))
+	/* During SSR after memory dump collection, controller will be
+	 * powered off and then powered on.If controller is powered off
+	 * during SSR then we should wait until SSR is completed.
+	 */
+	if (test_bit(QCA_BT_OFF, &qca->flags) &&
+	    !test_bit(QCA_SSR_TRIGGERED, &qca->flags))
 		return 0;
 
 	if (test_bit(QCA_IBS_DISABLED, &qca->flags)) {
@@ -2110,7 +2116,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 		/* QCA_IBS_DISABLED flag is set to true, During FW download
 		 * and during memory dump collection. It is reset to false,
-		 * After FW download complete and after memory dump collections.
+		 * After FW download complete.
 		 */
 		wait_on_bit_timeout(&qca->flags, QCA_IBS_DISABLED,
 			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(wait_timeout));
@@ -2122,10 +2128,6 @@ static int __maybe_unused qca_suspend(struct device *dev)
 		}
 	}
 
-	/* After memory dump collection, Controller is powered off.*/
-	if (test_bit(QCA_BT_OFF, &qca->flags))
-		return 0;
-
 	cancel_work_sync(&qca->ws_awake_device);
 	cancel_work_sync(&qca->ws_awake_rx);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

