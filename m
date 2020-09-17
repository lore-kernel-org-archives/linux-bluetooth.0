Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685AC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2362072E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 13:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="EU43U2NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIQNQE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:16:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64492 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgIQNP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 09:15:59 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:15:57 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600348544; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+exb4SkAt82PbgJkbLQGaVlcoCDQLiY2MVs1jWjuReQ=; b=EU43U2NOYf0JpJ/9zvhsmDS0fJ4UMIFgzrHaARfDczYu1Nlhs/pvOlR7J9g/da2EUniTqWXI
 O7pFsQgbVeBfqWqXAlUItyWyuSw+zwhDuA/oz0YmYactt+O2DW84IxpTJrRMTroLtQQV8s3X
 Ot3eXIPw/uzPYXNMLGMox671AVU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f63603af1e3eb89c7f05a89 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 13:10:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7145AC433F1; Thu, 17 Sep 2020 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [139.227.220.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79E1DC433CA;
        Thu, 17 Sep 2020 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79E1DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: btusb: Enable wide band speech support for BTUSB_QCA_ROME
Date:   Thu, 17 Sep 2020 21:09:23 +0800
Message-Id: <20200917130923.15237-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QCA Rome supports wide band speech, this patch enables the wide band
speech support by set the BTUSB_WIDEBAND_SPEECH flag.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 54 ++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fe80588c7bd3..9f294b941943 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -254,24 +254,42 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
-	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe010), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x04ca, 0x3021), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
-	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe010), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04ca, 0x3021), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

