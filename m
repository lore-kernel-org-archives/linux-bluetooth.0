Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3756C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbiCWWlh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiCWWlg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A3D3631A
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so3286595pjp.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FHmrDzWf34S+VIdONSZXDksFW5be3bZdPT1V47AMKuk=;
        b=U0+ijJyuiwN/VsQM0kUvQ1kUQa4l+CrFTIKKdQezUq/d/snnt7xsZnPrl4UnKu5oCH
         uBJ3Xj2oO24jMbIHceYxtFUNeuhW0pkkKP31bkdw/qt+9wjUyZ6YL55+SsnV+ti0xy3X
         wFaTWssaYUjCLHQP83/f7DgetQCqc/QkG6gqZuOYhQLemfay3g5gog0hrEgO/p/kvILE
         gWoDzm+lsPlJ/sNNDETWp67pK0NqkUcMtI9Kx+SDC6WHI0PBkk4JI910nhDSoT0p0Psm
         gh3tBBCKA1cK4Sj4GZibV/uLLtEOEdUc0xc7XPIphUP611uFQrelbFd1bwRrrOx6jDZm
         q2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHmrDzWf34S+VIdONSZXDksFW5be3bZdPT1V47AMKuk=;
        b=ohG1DAV61RmY9JOIMI+UdkbSx4cAfhmAUmyL3LmbF6K65vY6cSk53rIQICCuJrnOJ4
         JD5jAxn5KrAyO0aD7u7/11x65gC6BfHJBES4Lbxy/E3iO4sWRnHp5xvfiWCPfL6GGjFn
         4pxaB05gtCmliKyE19Xc1YpYE5/UvrAfKpIVQ7z+uA6ky6fXRjJI7AKq9kpZM4Zo2xcI
         xC/14mha6Tv/zIvjQ2PWg7IjpOdCnNhMmvdCE/t90dIA34gKJflvDtn2W2V+YIorXTnf
         G19LOyaaGt/V5QPD5M6YWOHmMNG1OwHU40TAplJ/WnXVV7lLwoT5dy0G9q3AqD1GzVzh
         0ohA==
X-Gm-Message-State: AOAM5333AgP8flu+kxTEYKGhfyDf/xxgKz0o4b+fgidJeLTzeZbu0NqM
        obJYLrm80f+GZwV34lqXp2E35anoKLg=
X-Google-Smtp-Source: ABdhPJz392a64SXhInlh6t/l3RPZXBbr2o2kRDxgcA98Ub6Xiw/tmSmEs065Ay7QMEFBM7VXEA62EA==
X-Received: by 2002:a17:90b:33d2:b0:1c6:f3c1:49c3 with SMTP id lk18-20020a17090b33d200b001c6f3c149c3mr2309990pjb.82.1648075205426;
        Wed, 23 Mar 2022 15:40:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
Date:   Wed, 23 Mar 2022 15:39:55 -0700
Message-Id: <20220323224003.3736525-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
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
index 74941beb2..1ed742a0d 100644
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
+	DBG_IDX(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 #define error(fmt, arg...) \
 	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 #define warn(fmt, arg...) \
-- 
2.35.1

