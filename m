Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiCWUPR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbiCWUPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F36450
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o13so2049317pgc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IP07YkQg0rPEBTHMn8DcG1oqgtBsAiOLeh56Bth5JYA=;
        b=cyESw/5IbCg0TBBMMJSmU4eDHeLpsGugfyrLP1x3XdAJPY2f5ewzEhzytb9Z3W3/n4
         y9Dy1vLKc5Yl5wOAYqwVHJGc3B2CapvM1BSMrqsGC+BF4ZEj+KWTA2Zu9YwWMCIFB9/L
         6/lGQCIwlIGHa8qXCPhXGLdxK2jjxnIpvz2vGwmJFldlOqBIjDuaSc5oEPzr4TxS5LSL
         TFuAl5zUBtx3YSZTszeHMDbWSHNd3MnCC7+y10epYSLhxfsrc9y75p76NTDfm85jDzlF
         lDq0PY9SwbXwhf66BgU1nxXKwqCXNlVdZWCPXzfDCG0i34mrUBA8i6vsVEg2qpx3htWV
         kqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IP07YkQg0rPEBTHMn8DcG1oqgtBsAiOLeh56Bth5JYA=;
        b=ee25C6WRkurEYSQWTu9agZZTxuduyCVrMw7lGkXP36o9pc8T22Ddr/ZgIcl9cykjvy
         b0m5r9SZqPSMQJt2p3MX5z59LP1d0aSWYuPlSXOamp8RoKqEi3NIBGN+sWfGhtRV14AG
         v2KTrmHlqQnD7tVu8mzDQ/NdkkS1XN8ZD5XQka4e36Q/uFlJ0kjq5w96Oz2H6yNxN6lq
         QJhSj7Nvuk0yt+2iF7pmJYQ9qb3ueFAkoIBVuCaAjwRsYl23Cz8tkLvOYPwTti6Oi/9W
         LYpac82/zwLQzR9kL5ionN2mC7JRpyhpzzNgZhzAe0g4QDlPSyddEnrxk584xoNumL3D
         s7Aw==
X-Gm-Message-State: AOAM532CSEyundVldFvIax2vj3dzTm0X9DO9i+380lNIEw92P3s8cF3s
        cSzGBlc0J2Lb7ifMG9LcmxG3fl7WntE=
X-Google-Smtp-Source: ABdhPJxvHBVcLm6lYi86H3rgKrbeOYI6SiHYHEAw/u0F5ExKo7lfxMpIwuuKqU8Jg4JsZ/L2Gfk/Hw==
X-Received: by 2002:a63:4041:0:b0:37f:8077:e0de with SMTP id n62-20020a634041000000b0037f8077e0demr1228436pga.138.1648066423866;
        Wed, 23 Mar 2022 13:13:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/9] log: Introduce DBG_IS_ENABLED
Date:   Wed, 23 Mar 2022 13:13:33 -0700
Message-Id: <20220323201341.3596128-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces DBG_IS_ENABLE macro which can be used to check if
BTD_DEBUG_FLAG_PRINT has been enabled for the current file.
---
 src/log.c | 12 ++++++++++++
 src/log.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/src/log.c b/src/log.c
index 0155a6bba..1157859ef 100644
--- a/src/log.c
+++ b/src/log.c
@@ -179,6 +179,18 @@ void __btd_log_init(const char *debug, int detach)
 	info("Bluetooth daemon %s", VERSION);
 }
 
+bool __btd_log_is_enabled(const char *file)
+{
+	struct btd_debug_desc *desc;
+
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
+		if (desc->file && g_pattern_match_simple(file, desc->file))
+			return desc->flags & BTD_DEBUG_FLAG_PRINT;
+	}
+
+	return false;
+}
+
 void __btd_log_cleanup(void)
 {
 	closelog();
diff --git a/src/log.h b/src/log.h
index 74941beb2..e35238870 100644
--- a/src/log.h
+++ b/src/log.h
@@ -9,6 +9,7 @@
  */
 
 #include <stdint.h>
+#include <stdbool.h>
 
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
@@ -27,6 +28,7 @@ void btd_debug(uint16_t index, const char *format, ...)
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
 void __btd_toggle_debug(void);
+bool __btd_log_is_enabled(const char *file);
 
 struct btd_debug_desc {
 	const char *file;
@@ -38,6 +40,15 @@ struct btd_debug_desc {
 void __btd_enable_debug(struct btd_debug_desc *start,
 					struct btd_debug_desc *stop);
 
+/* DBG_IS_ENABLED:
+ *
+ * Simple macro that can be used to check if debug has been enabled for the
+ * __FILE__.
+ * Note: This does a lookup thus why it was not used by the likes of
+ * DBG/DBG_IDX which loads it directly from section("__debug").
+ */
+#define DBG_IS_ENABLED() __btd_log_is_enabled(__FILE__)
+
 /**
  * DBG:
  * @fmt: format string
-- 
2.35.1

