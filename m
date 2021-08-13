Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F3C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1F61101
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhHMMUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbhHMMUm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8CCC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j6-20020a17090ac486b0290178ffdbd20dso2907754pjt.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iyAYbcC4s/NWf+n/ms4uj/u8ixL0E3asRmRgBJgfIAA=;
        b=CDoB9oryEiq4qKPVoLwOPsSzylZ8PVj58wor0+onggK7ZVkWAoW/W/iJ9WYZvmqT9U
         0jjrv0RqVAdO7iEhLP8a+Gx43SPknqghP8SB11l9P8gxbc6ulM7m6dPwfaF3FoTrp3rH
         Zd5lNZHt3qc8TO44kFOIZ+yYxwm9Jy6AftSUS0uoZbtGfHV0cEBs+HBldNdXlKwzXnux
         ppi9+4g73R9IiuhbS9jAsHoTL7a+FaRXzwhjbHsvllwTU8srvWvHgl8zbuhEi8OmU6Uk
         1sn18fSJpLwVRhdOcz/YZzhiFILETvRMMvA22DNnvBy86/chW3vmkrw1QsMttKMVXMhq
         PlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iyAYbcC4s/NWf+n/ms4uj/u8ixL0E3asRmRgBJgfIAA=;
        b=pjlyy9lyaabN9uOVGTjV4lzMZ49iK6qfle+JBnA/PIn4xB4t5lYmwMxh2lRXkYqfB8
         FERgninI4j5prfUTLyVH0QMQ2iP148H5tQ3CyOX1vA6QRFxvFDOT+CixK37OXwmg7A0T
         EEQLP2k0h0Z6Q2QNgMXGmLHDn5SsHSrQVB0+W9vpH5f5X4ztI4jwZP/xpoSYh3h6JPtg
         6Av0P8KS+VNP71AFXKHdTvG2Ru2B+05lAVnELzQz/qkn1L10lk/1r67NquNF1YhptmMr
         YVigNTnaiFFT4QpVy2Z1SuUFpphcxi5nLXLRfGhisMemcIXvatATnpCsIQQFaO9soxif
         /DFA==
X-Gm-Message-State: AOAM5311NVnZQoDTWy7iXz6Fv62amFmolQhqcB8XEclWLgSAwdC/WPOs
        rxI+DK/MoGftfxUia5/j72k4WD0mjrwbsoZAGjCfjBFJ/GhBw6+dlpXNf5zx1VQ2gwuyICbXg8h
        9wo/BWPdTHDj7+qemUzLtqNSJyU+JWTk9jFCnc6YPyh5PlHlamMt9sA4VcQJXEHa/Fj1PEIUNj0
        Nm
X-Google-Smtp-Source: ABdhPJyMoD6PtclKBB+8ikkDhJxo+TDla5vZdIFAx9Qwqw0htlZ5wU5VHlxohZy8NYuAsMq9pJSMowM9Ji3U
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:8c7:b029:3a1:119b:736 with SMTP
 id s7-20020a056a0008c7b02903a1119b0736mr2324163pfu.52.1628857215439; Fri, 13
 Aug 2021 05:20:15 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:56 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.11.Idba293f890e2f391c383815e31e7c2708918e77e@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 11/62] shared/hfp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Prefer to use "rejected", as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 android/handsfree-client.c | 2 +-
 src/shared/hfp.c           | 4 ++--
 src/shared/hfp.h           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 4c682fbb8f..c8f9e690ea 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -405,7 +405,7 @@ static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
 	case HFP_RESULT_DELAYED:
 		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_DELAYED;
 		break;
-	case HFP_RESULT_BLACKLISTED:
+	case HFP_RESULT_REJECTED:
 		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BACKLISTED;
 		break;
 	case HFP_RESULT_CME_ERROR:
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f41c70dfec..df6eab35d6 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -721,7 +721,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 	case HFP_RESULT_BUSY:
 	case HFP_RESULT_NO_ANSWER:
 	case HFP_RESULT_DELAYED:
-	case HFP_RESULT_BLACKLISTED:
+	case HFP_RESULT_REJECTED:
 	case HFP_RESULT_CME_ERROR:
 	case HFP_RESULT_NO_DIALTONE:
 	case HFP_RESULT_CONNECT:
@@ -1018,7 +1018,7 @@ static bool is_response(const char *prefix, enum hfp_result *result,
 	}
 
 	if (strcmp(prefix, "BLACKLISTED") == 0) {
-		*result = HFP_RESULT_BLACKLISTED;
+		*result = HFP_RESULT_REJECTED;
 		*cme_err = 0;
 		return true;
 	}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 1fb3ee8d32..600d084a73 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -20,7 +20,7 @@ enum hfp_result {
 	HFP_RESULT_BUSY		= 7,
 	HFP_RESULT_NO_ANSWER	= 8,
 	HFP_RESULT_DELAYED	= 9,
-	HFP_RESULT_BLACKLISTED	= 10,
+	HFP_RESULT_REJECTED	= 10,
 	HFP_RESULT_CME_ERROR	= 11,
 };
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

