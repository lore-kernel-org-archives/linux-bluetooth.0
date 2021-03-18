Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BFD64F18
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 08:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCRInh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhCRInR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 04:43:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15170C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 01:43:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m17so3262001lfg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmWWVnA2BeznKKhOQ5vd6CoetMdjLD8g6uWFA8Uontw=;
        b=cZaVOUJpVRyxRg8FQjHUwiW7Qu0jxwy/cXk/kp9M/qMTRgT6JBr8tpji7DG9naxSYl
         bTGA11TGH+sJFNZnXn9zO+e46u+zlmFFvcbPuMWySGnYKa0IdiDQRJ4SVbNW+GWt7Ve5
         RyDlRZtEtsOC0GLKPyPe01Fo1XhBnKoArm0cKfSqTlWO+mTnaHzKZVBiMMwDZXRTTNMg
         VcFexjUVHlqqI7Fgw+8a+AXeSZ6oLoUQSZlp/qM2JO4vhUAbhMaViGn2gSgyKnuCmHJB
         CqjO7Ub9tY5m3hksvxAgmua87n4Nths8OYDU4nRYih3OCBMwH1pXOrg2Mjawg4tEgrT4
         THeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmWWVnA2BeznKKhOQ5vd6CoetMdjLD8g6uWFA8Uontw=;
        b=XOfkFN4Fvzzwx16GxHY1jKyiueV+MLui0Jb3ylKKSvQ4sMYO4s8N59X9H/29qv3JUy
         9Jn0SPmQdXm8EoGCDaWmYZs1mIHbn6j2VBw2BZJAWHx+W3cLO9lS7q21crROjocqjRYM
         zxIqov8DBDZ9FEVGaqlfr0M4HB9ClwtVziN+iaF4IYwr5+YKRF2eEcr0UBbTvZm4el+v
         KWHCWPbLnv7qJJHIDOabC6862ppn1ZAa1Q+Tc82fpfN5ehTkpcVHTLTk0ua3577Ptkpo
         vrZvub/3ShJyRWUJ8CSaV/HHC4chTiTeIDvRY+2P8Ziq8lXaBru4Xdch3iRzB8sdbZsv
         KFCw==
X-Gm-Message-State: AOAM533o/wF+m91lPFj57llOAap58PlWz2/ytiuOhrLspob2/CxaXUXb
        9CDUpL1unZYG2sKgpNppW5b39w==
X-Google-Smtp-Source: ABdhPJwumLUgcGgNArBAgc3j1u1e/AFubvIGT4GEohlfwHB7v6Qi2YrZ7pJMnxQi9cj4gFBLyS5Cjw==
X-Received: by 2002:ac2:4e6f:: with SMTP id y15mr4741557lfs.428.1616056995564;
        Thu, 18 Mar 2021 01:43:15 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id u11sm141982lfm.78.2021.03.18.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:43:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles
Date:   Thu, 18 Mar 2021 09:43:09 +0100
Message-Id: <20210318084309.401951-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210318084309.401951-1-linus.walleij@linaro.org>
References: <20210318084309.401951-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the missing brcm,bcm4330-bt and brcm,bcm4334-bt to the
match table so device trees can use this compatible as well
and not need to use the fallback brcm,bcm4329-bt.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3764ceb6fa0d..c6e9237e084e 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1482,6 +1482,8 @@ static struct bcm_device_data bcm43438_device_data = {
 static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm20702a1" },
 	{ .compatible = "brcm,bcm4329-bt" },
+	{ .compatible = "brcm,bcm4330-bt" },
+	{ .compatible = "brcm,bcm4334-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
-- 
2.29.2

