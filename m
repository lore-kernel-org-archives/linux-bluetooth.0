Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C97611CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTVvC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D4C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n11so17086548plf.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xOnX4wywXUdIP6aUi2FSyevVHfp8//nGSVcWhSw9vw=;
        b=cMOXT+vwzc88YbdnMrwq4ynaaxb+VYBzvquhasXatq2Wha1fbXnb50yeNnWWm9DNXZ
         h4sVvfL4ziH0UhAv+ruquSKOYr2L+7WuMhR+g/o3Xttjti6Rx3jN6mSl3vkAdBB5VLsx
         IF8njbvABLbE6R+bomN966JS6EqGrCmUA85rkuijCabK84vbLFeXoLQST8sPnJZtvjEP
         NDaStBUa25nLNfZlfPNfVS27z5tEyf752DjNFtaEuhtuEQvITQhTaWwropU+Y9k/Pr7B
         na4BME42xunj9TlksWtMjg3ep5MUKVEltolsak/6pWm/wo4pCg9chB7EhYpOk8uEDLk0
         3m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xOnX4wywXUdIP6aUi2FSyevVHfp8//nGSVcWhSw9vw=;
        b=edfN1GUkkb8nxHllmb/RBAIVE9nfGeR6fzC3owgZja/EaXArvOyVs0Vf7b8ITDRj38
         EyU3ag5cSWZGprHNY0GI0hzdhsTzEngokhIga/FYBoAoXK522KTQbuIlQnYqQ+ZeH//3
         sWkB+WDweRQf56qFVaeTanNLZdpTahhkRf+22oBUOtd55RMH+tfGogHEWrFnWe/yrls/
         9pPR92IsWy2mHC1JFtEmMjFNrPte4F/B3q0aMkzqy+Tk0WAExy8xi560eFkcVhQ3kvHy
         0Hg7RzPrCtcdhAwRiUYNu5LEvzS4dEcc4hGZNbqrShLfPM2vAVI8AQbG7bMhzGDA+azJ
         go1A==
X-Gm-Message-State: AOAM530T9JY+oQQyH7YkQXBFPomA0JTu4T2zG6VlaKg0Bq8Ao96Ux4vS
        +qWF8lAMUxZUyb6LxDPG0L+w3Uxho5Q=
X-Google-Smtp-Source: ABdhPJzmLXprbTjZFt1vkNdOzz4JrOpWUfzrdgVj8lKsj3fchQ0CIlH2fUQEhlSWb9j4/41H0Jr2MA==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr1707996pjl.150.1634766526083;
        Wed, 20 Oct 2021 14:48:46 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] monitor/msft: Fix uuid.u128 format
Date:   Wed, 20 Oct 2021 14:48:38 -0700
Message-Id: <20211020214843.431327-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

128 bits are actually 16 octecs not 8.
---
 monitor/msft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/msft.h b/monitor/msft.h
index 79692537f..d2921f4c8 100644
--- a/monitor/msft.h
+++ b/monitor/msft.h
@@ -87,7 +87,7 @@ struct msft_le_monitor_adv_uuid {
 	union {
 		uint16_t u16;
 		uint32_t u32;
-		uint8_t  u128[8];
+		uint8_t  u128[16];
 	} value;
 } __attribute__((packed));
 
-- 
2.31.1

