Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC1360EE2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhHKHJ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhHKHJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:09:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD5C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 18-20020a05620a0792b02903b8e915ccceso772487qka.18
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hde/dLDTwirEFGpsGtOQHG+Oo/g2VbRm8E2+ZjtytWI=;
        b=XgTQegfgwY266bOjdOdx6f5DtCXkAVT9QmoNvDCrOfVJgYudJ1ZZgSSF0QFXbpq4WS
         eOz3xMq/DWk4CSgFxJOkTroRRWGC2I6/OLlLWvhdFYZqg42eejw5Y2bRjcCmRViDmWGy
         vJSePRobZtIQYl9wuXZq6QG7CToRn0CaiMXzjj+piSBX1tmvrizFHxctDjzQePrmPyFt
         fh/0RT2orYHT7DFrrcW4FIgu6+TCg3+hQaafZQD545V3e5r9uBM1uQ4J8FmToELgROWV
         eeUxo/n9P0bJOQplpaFfp0J3i6GLXV543Rc5x/Pld9mKSSSow4kvFGKM/HFGBP/rEO3X
         c+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hde/dLDTwirEFGpsGtOQHG+Oo/g2VbRm8E2+ZjtytWI=;
        b=F9/TJW9BAA4Q2gjt1FnCGmb5zfuADnAmNGet0NacFe30xxrgu1HE5/KYGs7zmZzB46
         chAK8C7XHYfxlQWbOGWX2PgxN5Miehn2ulA4vcqDfUFaz7ghhBQYAgU6++KzyaAkRNO6
         ZnLPkRZCv06SCgVEw82HXursjOYF7//noXZhbQJeDSzI0h1FJPGzGHQ3MsU7kQBiRvNY
         XG+eOpWW4d8zxdTekRNVDjrekO16viRbGZk/T0Q2o0EI7Qu3lFwM/5i0Tm5k/Ctq1jsX
         oBknQEQP+E+68jUWwvpalAR4fuxM4J0nwrOq6wlzqW4OslM1QkZbmsOW1XJCTC+4FTIh
         BVpg==
X-Gm-Message-State: AOAM531sWeXAHSP4PmIWnvu+D/Mdu5V194k8rxK4m/+4Dgs9Qz5lypJf
        lreG8/Yw72diBbVK/evcBPtS7tbyTIp0zZN4evGdHIJ3HMx2b8Oc3iMFvwlHGDrC+4AT058ajmH
        ri8rioeQKqBHPfmlq4zRK77s6bYN7x5niPuo4G8ja3zHHmLFUhdUQBiSUkVQQ3fJwvFoaE4/nJQ
        TPa4GBHFJVYL4=
X-Google-Smtp-Source: ABdhPJw0ok8m/BWxrni1gIlstQ0CRFqUA/YxJX+TO+qLeaBps238wdZRXK0E3Qism+hZAd2Epx/jcRYcwdtJeA9Y+Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:42fe:de1a:97f8:9006])
 (user=howardchung job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr32678432qvs.28.1628665742022; Wed, 11 Aug 2021 00:09:02 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:08:55 +0800
Message-Id: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v3 1/3] shared/shell: fix missing stdbool in shell.h
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

bt_shell_menu_exists_t returns bool, but stdbool.h is not included.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v3:
- Rename client/admin_policy.* to client/admin.*

Changes in v2:
- refactor command to |allow| instead of |set-service-allowlist| and
|get-service-allowlist|

 src/shared/shell.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/shell.h b/src/shared/shell.h
index 415194a40736..cc4f822fbf1d 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -8,6 +8,7 @@
  *
  */
 #include <getopt.h>
+#include <stdbool.h>
 
 #define COLOR_OFF	"\001\x1B[0m\002"
 #define COLOR_RED	"\001\x1B[0;91m\002"
-- 
2.32.0.605.g8dce9f2422-goog

