Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE4E23A9A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbhAHTFG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbhAHTFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 14:05:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A6C061380
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 11:04:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a188so6812307pfa.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ylsb5NyQ3oFVpAQCIHeIiDlXNUKeqObj9MTroL10KcE=;
        b=e/+XPyOe4wM6H9kdhmiWFRZiKzcXFkXmj5+2yeRfVxzvx3oLvXBcAJzXQtpUYEoz6d
         iFCBUBIA0eVkt9g1VVWwc44IgP2j4dNWpBNMobeYxh3tBS1f/tozgRmom+tIo3QwO5C6
         31IDJNy5nnboVoK8/iWTafNKIs+bTdL/7I7XMamq0fzypoYzFaJb20tNJ8lFWaStEJ4h
         6WqNk5VtbQ7y9hF5k5RhL113cgqeE8E9oJnvjV6sx8vLLbK0XLuv1JZopgMuL3Uxs2Cg
         6gcRNz+64P6EQM3IQoDfHf+NF5nLx9qDY9o7YE4Xjm60rZ3/hE+c2xYV/cmHhNQYAIcu
         Dirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ylsb5NyQ3oFVpAQCIHeIiDlXNUKeqObj9MTroL10KcE=;
        b=TPRM6HhXFt5W79oDC9RXBQkNgJ4K575OXnpJ57/GWBefgycehlElRBzKRehZB8Pb4j
         ArfQNmwiesHEy3J4B7kAeZkv7ot1TFg85iZt6DMSVchHTy0+jdVbr6gR1hGRAHUjBOVV
         h1d6ED2YF5gW/De8M/EUXiOacqaSpCpzXFkZ4T2+uR2VOyfgmEMWESyHIkhNoMbAMKPF
         ihIQsTLXe2kkPyfFiJLaUcz1yFPEb/yBuiIlvW9ExEIAaNdybSv3LmC3C66OrGTGeAoz
         v5izQ17B9Qj/cpYFmrwsxWmVn3SzSo5oUcQrmgBD1SYx1ocZuRMolRigs1rGZT4SgLiB
         MI/A==
X-Gm-Message-State: AOAM530b+Ssq44/FR4nIj06OKzT9S4kFqEbzyesZmobB7gAfJyD26vES
        OWkQm7Fj8TyPqB0Ok2neTWCMMc2/PLU=
X-Google-Smtp-Source: ABdhPJygiCUXULT60AgeL1a1rPl77W5iDwTkYkem3MeboQSbn4ndiD63xxxmIGjKZEuN9UQs92AeJQ==
X-Received: by 2002:a65:458d:: with SMTP id o13mr8371595pgq.450.1610132665515;
        Fri, 08 Jan 2021 11:04:25 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g16sm9304181pfh.187.2021.01.08.11.04.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:04:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] util: Introduce util_debug_va
Date:   Fri,  8 Jan 2021 11:04:21 -0800
Message-Id: <20210108190423.4185474-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces util_debug_va which can take a va_list that enables
callers to create wrapper functions if they need to.
---
 src/shared/util.c | 19 ++++++++++++++-----
 src/shared/util.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 525302164..9c2054211 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -15,7 +15,6 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <ctype.h>
-#include <stdarg.h>
 #include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -42,20 +41,30 @@ void *btd_malloc(size_t size)
 	return NULL;
 }
 
+void util_debug_va(util_debug_func_t function, void *user_data,
+				const char *format, va_list va)
+{
+	char str[78];
+
+	if (!function || !format)
+		return;
+
+	vsnprintf(str, sizeof(str), format, va);
+
+	function(str, user_data);
+}
+
 void util_debug(util_debug_func_t function, void *user_data,
 						const char *format, ...)
 {
-	char str[78];
 	va_list ap;
 
 	if (!function || !format)
 		return;
 
 	va_start(ap, format);
-	vsnprintf(str, sizeof(str), format, ap);
+	util_debug_va(function, user_data, format, ap);
 	va_end(ap);
-
-	function(str, user_data);
 }
 
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
diff --git a/src/shared/util.h b/src/shared/util.h
index 6fb702797..d6de55885 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -10,6 +10,7 @@
 
 #include <stdint.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <alloca.h>
 #include <byteswap.h>
 #include <string.h>
@@ -89,6 +90,9 @@ void *btd_malloc(size_t size);
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
+void util_debug_va(util_debug_func_t function, void *user_data,
+				const char *format, va_list va);
+
 void util_debug(util_debug_func_t function, void *user_data,
 						const char *format, ...)
 					__attribute__((format(printf, 3, 4)));
-- 
2.26.2

