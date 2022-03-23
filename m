Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbiCWUPT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiCWUPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2F6576
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w21so2062415pgm.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMcsHhBjZa8B7B2vdvhCMgDV2TBVZD3rYdNk5h4gG+4=;
        b=Xy+MIo18qQBqWvbyVIF8zToOjhiulDNFojeTUdfYv2BJAmj+0HHC+NTkXtHGpc6PCE
         bp04kO7LJqNGVAt0uqDLc+VH4WAsYyouWDvIVfhiykZBFSmvE82Ee0jcoeONhH2Ka3iC
         ulN5C5x1XVoJBmd4QWfuOI7s0fNjuCTGwRFOEC4O4jlh5m7m+ctH4n/spxsglLc8YfvY
         YbpBHiMkthCtbmSWBlHu3cfmx0ExBlJE+GthB8bFDRbEHgV3Ygqw/jBfiNlRcf1+jgQI
         TEkRGMtRRpwn6+1HHaz/dHnM5uhD9kufmHioRZ7J5wVM4/7pJp3md93mWYOpqUJvxL2l
         1uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMcsHhBjZa8B7B2vdvhCMgDV2TBVZD3rYdNk5h4gG+4=;
        b=Y5y2A5GoqEWQ64ZrWIKztrxLaespF560062gjhE8Bvrd5JCMNz71iZJlm7zSbwDFcx
         wfS/i7lqePDEZkjRfwpCR/zF140D7qI29q/Vpo81EwwaKqj3qodh1yV6ZKDLQiVb1Tmu
         sTVaWAEY/dsY8QlhbRJ0NKOpTHau92dFjhLoZVnDKG1X2kH9SSyzpfpXniAjYRCmliPO
         ufFJdb97z4EGlZ92QptIO+0wzaRhRrF0ZQ/0HV/lcTGDOn+eI0s3SHNyjIPYedFvb/sy
         IK5tj3eb8TPqW38SnTVGQSeBcSp/f6K27H5i/C10IpyfAvvt/StSrP2n/MHnFH1aHqZf
         SjKw==
X-Gm-Message-State: AOAM533Wi2bwLltP1zPZj4BriYHr4nOQzfMOfZ7gDneVPv720ZF96OZE
        wLV+5wmR4pL/JBsNyB4UMo1UJ/F/ddc=
X-Google-Smtp-Source: ABdhPJzGskYnr6Q3tgxzUUlOB8NVRwD5RKInzX46XiiFN0H2MSAh2UXbxkWrXuRBL2qzrHI0Ky8nMw==
X-Received: by 2002:a05:6a00:24cc:b0:4fa:a9c5:4b04 with SMTP id d12-20020a056a0024cc00b004faa9c54b04mr1600990pfv.63.1648066423041;
        Wed, 23 Mar 2022 13:13:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
Date:   Wed, 23 Mar 2022 13:13:32 -0700
Message-Id: <20220323201341.3596128-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes __FILE__ and __func__ from DBG_IDX since users of it may
already contain such information embedded in the format.
---
 src/log.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/log.h b/src/log.h
index 74941beb2..a244fc4d8 100644
--- a/src/log.h
+++ b/src/log.h
@@ -9,6 +9,7 @@
  */
 
 #include <stdint.h>
+#include <stdbool.h>
 
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
@@ -52,10 +53,11 @@ void __btd_enable_debug(struct btd_debug_desc *start,
 		.file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
 	}; \
 	if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
-		btd_debug(idx, "%s:%s() " fmt, __FILE__, __func__ , ## arg); \
+		btd_debug(idx, fmt, ## arg); \
 } while (0)
 
-#define DBG(fmt, arg...) DBG_IDX(0xffff, fmt, ## arg)
+#define DBG(fmt, arg...) \
+	DBG_IDX(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
 #define error(fmt, arg...) \
 	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 #define warn(fmt, arg...) \
-- 
2.35.1

