Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22164C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 21:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbiAFVDV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 16:03:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3CC061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 13:03:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id oa15so2634378pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGinPNIizwvmMT8UpB/acvdDMS45g4m5JG42VtZ6eFA=;
        b=q3lqj1so+hfO6kI2L6r++FzVkHJgoVkgMJGhk3f4PMLh/ZPvc3+b2b7yCUAwZVrxTS
         nRHYe3d7ujxvjNvzhYWaKG7AF49N5oRldFzgph+wVnpD/NcC0A79PGIY9qyO+O5a5UiO
         KjNlNlVjVvD5NVSIB/TntPHtDHJGwCHhaZ9uViRigdCSCW3/pks8doqgKIdg87fhKslc
         LuN6IC2Ak4MP/jee8Cv7z29vWiYpb/hxuHsv02iP4KgdDlbH7HyYfsAYpnyNAlBoygNd
         EvVPke85GOVqlM3c/d1cEhWmIFomBOxfz991UxtZpGiMQ2oxw7BAf/hDuhkJklQ76RtR
         LRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGinPNIizwvmMT8UpB/acvdDMS45g4m5JG42VtZ6eFA=;
        b=zMfdH+siq3so4XX5kXnOOJDXmgg0Zqy+kcPAKK0pgryrIbuz52bNWe2XOzm/cFWXQh
         JTRfL31wniadZe4Guh8+hffKSXSi+l6UBlcJNVD8nU1VujwyIDcLOjH6y5hNL3BizXMw
         rOzs12IVCF0GDP6NH+3iJL28FftmVNscMbCXHYr1Kohu3XR1mXh0f6Py9bc1GKcKyLb7
         pDfm50/WOtdmayw151+KBqviVAnqqiUWyuze0IVN6Up8hR0c1kMz9EX+NiNJ3+PP/9Tq
         NSPLZk5QEALZHNnePD9jzFFDyvoq7sK11j4kd1Ai5xa8I8TUEQyiV77XQunmvhl6fLpi
         iRHw==
X-Gm-Message-State: AOAM530jD16iEb6pxvaI5oKvcdcLUnrtn2aHDUwqWgtVIDWJAYtufhlG
        yv+iSYFvRrwpwmELSIJKskaqdxocxrA=
X-Google-Smtp-Source: ABdhPJy0/1ayQXVFnp1DbpDuwmmryBlNhpTDfaqc0XpOHnath5k3nJ2S7DGcktPN9r9P0pTdEqHnvQ==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr12260117pjb.80.1641503000527;
        Thu, 06 Jan 2022 13:03:20 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s25sm3091853pfg.208.2022.01.06.13.03.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:03:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/util: Rename btd_malloc to util_malloc
Date:   Thu,  6 Jan 2022 13:03:16 -0800
Message-Id: <20220106210319.3620823-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

util functions are not limited to daemon only which is normally the case
when using btd prefix.
---
 profiles/audio/avdtp.c | 2 +-
 src/shared/util.c      | 2 +-
 src/shared/util.h      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d3dfbf96d..f2b461330 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1333,7 +1333,7 @@ static GSList *caps_to_list(uint8_t *data, size_t size,
 			break;
 		}
 
-		cpy = btd_malloc(sizeof(*cpy) + cap->length);
+		cpy = util_malloc(sizeof(*cpy) + cap->length);
 		memcpy(cpy, cap, sizeof(*cap) + cap->length);
 
 		size -= sizeof(*cap) + cap->length;
diff --git a/src/shared/util.c b/src/shared/util.c
index 81b20d86f..93110047b 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -25,7 +25,7 @@
 
 #include "src/shared/util.h"
 
-void *btd_malloc(size_t size)
+void *util_malloc(size_t size)
 {
 	if (__builtin_expect(!!size, 1)) {
 		void *ptr;
diff --git a/src/shared/util.h b/src/shared/util.h
index ac70117ca..11d09979d 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -75,7 +75,7 @@ do {						\
 		size_t __n = (size_t) (count);	\
 		size_t __s = sizeof(type);	\
 		void *__p;			\
-		__p = btd_malloc(__n * __s);	\
+		__p = util_malloc(__n * __s);	\
 		memset(__p, 0, __n * __s);	\
 		__p;				\
 	}))
@@ -86,7 +86,7 @@ do {						\
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 
-void *btd_malloc(size_t size);
+void *util_malloc(size_t size);
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
-- 
2.33.1

