Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A3C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BD2611AD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350838AbhERQhB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 12:37:01 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37168 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbhERQgq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 12:36:46 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2021 09:35:28 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 May 2021 09:35:26 -0700
X-QCInternal: smtphost
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg02-blr.qualcomm.com with ESMTP; 18 May 2021 22:04:49 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 8108D22176; Tue, 18 May 2021 22:04:48 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v4 3/5] Bluetooth: btqca: Moved extracting rom version info to common place
Date:   Tue, 18 May 2021 22:04:44 +0530
Message-Id: <1621355686-29550-4-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621355686-29550-1-git-send-email-gubbaven@codeaurora.org>
References: <1621355686-29550-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Moved extracting rom version info to common place as this code is
common in all if else ladder in qca_uart_setup.

Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 3210283..be04d74 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -546,24 +546,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	config.user_baud_rate = baudrate;
 
+	/* Firmware files to download are based on ROM version.
+	 * ROM version is derived from last two bytes of soc_ver.
+	 */
+	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
+
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	if (qca_is_wcn399x(soc_type)) {
-		/* Firmware files to download are based on ROM version.
-		 * ROM version is derived from last two bytes of soc_ver.
-		 */
-		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
-			    (soc_ver & 0x0000000f);
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
 	} else if (soc_type == QCA_QCA6390) {
-		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
-			    (soc_ver & 0x0000000f);
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
 	} else if (soc_type == QCA_WCN6750) {
-		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
-			    (soc_ver & 0x0000000f);
 		/* Choose mbn file by default.If mbn file is not found
 		 * then choose tlv file
 		 */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

