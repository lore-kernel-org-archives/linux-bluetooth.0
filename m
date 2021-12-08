Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbhLHA62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbhLHA61 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87301C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so3157200pjc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RInqyw9zZIqeT0BZBcJLRmW4AvPHDt4uFyn3ne7vqec=;
        b=puUsFnAJQ2AEEgtiWlPMDkB3SwIRoCxJ2aRhHjoAr1hxD7Tx2nQKIPcGaErj1VLa5b
         5YXXQYmipICj4nE45hagzH2TTrw1qsrzer41rvJ6v44kjPJ0gvGMZl7ernRD7CWyirxf
         dVvaIn5qi/qHbtXlmZjEBndRtjg4p8k9rwR+wUwdZFtfXnrdVoWnhAkVL3FiCeaLp9QL
         a9PAKLDZ6hkmq5ql5VFYlsHCFxO9/CpoEQs2KDyDjte+c/i9vuD7KrByXt6465SqH2b2
         CWGt1Lu79s01zg/syeoQamP8LLI00y5K1JegDNMtcjleTZySm2DznpRS65RnYt7ZT8kQ
         SCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RInqyw9zZIqeT0BZBcJLRmW4AvPHDt4uFyn3ne7vqec=;
        b=Ti9/Q2sKfWPxQxkxPur/epk2f03UReVZCWMzorZ4nqF0MDV5/nSMcOe36/0hcUOaYL
         HbMS9kfgykdJAkj4KRUEpMCd5Wf9gQgo2dtIKLeqtGhm6R4Uca/drgB6lgroe2QeVT3y
         wMebb545HwoHm5YtsS0MMWf4pM9NkfVr+3KsAmvaNohN4Yo4YJW/cTRRTGsaHxLGhuJ0
         +bhYUBRorXbae3pJ7r9/1IDllryOE2xh8N82WZBt1N87SJmJKSSP89Trh+p6CHLt3Ff3
         GHv+OQ9YN+1lfDZWfidpYxchzaWDr4Jdx9MyksvhkUpcOGAwG+zlzPLFaDHbfjRDVpDX
         BDPQ==
X-Gm-Message-State: AOAM532wS9XHc+7754a3QK86E8JKgZ/N1mlpuJTUqXvoktortoAsT5Ar
        fkFh5JYw2E5sS+3HAoJXqvFykaWpJC8=
X-Google-Smtp-Source: ABdhPJyoubMx4Nsa+/J1PuyI5ZWF4kSxFdDRrUg15Dpl1sNSMw1VIqvKYjUHBxF64P2eC4vwdCVJfQ==
X-Received: by 2002:a17:902:e74a:b0:142:114c:1f1e with SMTP id p10-20020a170902e74a00b00142114c1f1emr55195331plf.78.1638924895818;
        Tue, 07 Dec 2021 16:54:55 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:55 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 5/5] profiles/health: Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:46 -0800
Message-Id: <20211208005446.196637-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208005446.196637-1-hj.tedd.an@gmail.com>
References: <20211208005446.196637-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the l_getrandom() from ELL,
which uses the getrandom() system call.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 Makefile.plugins      | 1 +
 profiles/health/hdp.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index c771b2dfb..7817035c6 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -87,6 +87,7 @@ builtin_sources += profiles/health/mcap.h profiles/health/mcap.c \
 			profiles/health/hdp_manager.c \
 			profiles/health/hdp.h profiles/health/hdp.c \
 			profiles/health/hdp_util.h profiles/health/hdp_util.c
+builtin_ldadd += src/libshared-ell.la $(ell_ldadd)
 endif
 
 builtin_modules += gap
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 6bc41946f..e77f963a4 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <unistd.h>
+#include <ell/ell.h>
 
 #include <glib.h>
 
@@ -1484,13 +1485,12 @@ static void destroy_create_dc_data(gpointer data)
 static void *generate_echo_packet(void)
 {
 	uint8_t *buf;
-	int i;
 
 	buf = g_malloc(HDP_ECHO_LEN);
-	srand(time(NULL));
+	if (buf == NULL)
+		return NULL;
 
-	for(i = 0; i < HDP_ECHO_LEN; i++)
-		buf[i] = rand() % UINT8_MAX;
+	l_getrandom(buf, HDP_ECHO_LEN);
 
 	return buf;
 }
-- 
2.25.1

