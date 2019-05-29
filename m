Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F7AC28CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834C2403F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 18:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp1oPPnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfE2SMv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 14:12:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37925 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfE2SMv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 14:12:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id 18so2063772oij.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wwq4/gOqyd4p2OV3PLszSKYsxJ0Bj9uRa+aan5WS3wU=;
        b=cp1oPPnQxKwrJw8lykL02tNGefMG/kscm4p1nzci4CJUhB5N/CKX5pEpfWnmNxsVea
         qbE/4rEUh4YoXJ4tG1kSEJkse4P3FoZQGwHlYPtw5D/vb7z6lpsOAGojyF5aV0x1/t8X
         RO44BOD2ROLRIg8Suf+0LwWt+fGymK00mk7/FE6uXhei8eEgJeKtyVZig0k+6KCP6n77
         f4C3h+qbojv3g41TSR2dXajyCtJ4nDGCWu9pT0aW5QKLKrzVaDUmSd6NSpCfDCth7yrn
         WQ+f5d+2BMOff4cgGyhH/9iQqOU2lpMvvHyxtt3Yandt/1XfoCDf3cDjNB1yveYrZsio
         Ylfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Wwq4/gOqyd4p2OV3PLszSKYsxJ0Bj9uRa+aan5WS3wU=;
        b=dshLu3LpPiL8atS6Ohh2C2YRFhozoSuy+rt3xh+d8t30VqGfN6r3QoP+Nq7UoFLyDe
         Gdpqis3q2To/3rywbo1saD4VmKRtfMyON7wj3Z+oN0NA+AT47wCjnZzYYmeCDMcxksXC
         UZPGX3c+5UVKRpGlxKKD67IMyjhgc9Ew/O0JHCS9ElhOKKo5+44W4JfYTROHh5TBocz9
         TEWbaxyUBkE2Jz9HKkcdeIpk66EJaC+AzaJTo9rMPqXGtHcN+18Gf5I04VdEK2vy/iPe
         /m5jSisYbPzvqsUhWd3QnViaZglg2EehwAYNinyvn/w820yHqLnC/zJBCTfth1jGsQ/6
         nhfA==
X-Gm-Message-State: APjAAAWTgL73esu5CsrEQ3EXhtSi9NkVrEFN/R7u1XtDgEAw5unWMB8k
        flKpdO0xYVQx3nzxC0EOAuE=
X-Google-Smtp-Source: APXvYqzhiNIyYwqUfmFuME1Bu81y19Nh236ws8SaRauLBRgpmqyieTqBPq9g+3gC+A8StBmKbrVr7Q==
X-Received: by 2002:aca:c243:: with SMTP id s64mr6792598oif.160.1559153566115;
        Wed, 29 May 2019 11:12:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 62sm90249oid.35.2019.05.29.11.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 11:12:45 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth:: btrtl: Add support for RTL8723DU
Date:   Wed, 29 May 2019 13:12:34 -0500
Message-Id: <20190529181234.12744-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This device is functionally equivalent to the BT part of the RTL8723DE,
uses the same firmware, but the LMP subversion and HCI revision are unique.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c91bba00df4e..751d468c3e56 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -31,6 +31,7 @@
 #define RTL_ROM_LMP_3499	0x3499
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
+#define RTL_ROM_LMP_8723D	0x8873
 #define RTL_ROM_LMP_8821A	0x8821
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
@@ -117,6 +118,13 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723ds_config" },
 
+	/* 8723DU */
+	{ IC_INFO(RTL_ROM_LMP_8723D, 0x826C),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723d_config" },
+
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
 	  .config_needed = false,
-- 
2.21.0

