Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96697C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiCWAIZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAIY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5E5DE5A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i184so2947665pgc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IP07YkQg0rPEBTHMn8DcG1oqgtBsAiOLeh56Bth5JYA=;
        b=FMSZabAKhK5Lvv0HUAAPvBv4X+AIDYep4Kt0rJhgVKw5qhJlR2vv+HXcDp4qXSI8CP
         D8d2GRljxU7LByflhPjZNHAFecRceeeCLufc1xRIG5YUKnObwh8NLemmp5t1dlSkVogz
         yQaF2/OiZ++tlXvhB9bP0PamDHHR7jQHPdvmRze1KOseM04HjwbBe6erX/UUDNGq/zIy
         056eXBwi0ZdnT8tc2uSAJM6quhhtk7eFl37YCOIS3+r1gW44YW/BBRVrk84H+1DZqOsd
         EDEF8BZbrVTayprydameDJDBT85WLlthf2qB7TZZoukakiL9AJO/DHaif9d+pQsv5kV0
         tbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IP07YkQg0rPEBTHMn8DcG1oqgtBsAiOLeh56Bth5JYA=;
        b=AefJXC3GIRkboMkUHD77lB2+6ju6b3CspBLxuKitqEyLmLyRCSGyCcqjNrBUE2kIEV
         moBV0ehovpfYu250Ixp8cWlrNgF+RraGlA91uBOPha/sJp46xKYeTcvPV1wD16SMryhj
         /DR8wrENhprp9xzrW39pAUJhjGjNgx8kKYgn/YXjAQ2zWSF2/T4H4sxptF5Ahp8aDGDA
         U8vu3/AT9aoahQmMMqHGuGUw4YkaeHuRVOBB79LnPZ/XB6k7pDk3c5y9rpv+9syCEg9o
         MJBwihvSgJ2pyowK9ANVQS/U763zzxlSDfIONgvkGOoDDPirXWb/33Fu3uODpQ4aDzgs
         OVqg==
X-Gm-Message-State: AOAM531OUYCebMxiCFPEpetuFUWvDaGv1pWZ3rhOwIuaTYtVD8aWVtWi
        oR+G5oJlPsHAUATqhGnqFxB6YM0m590=
X-Google-Smtp-Source: ABdhPJyhaTxC1d9RPb4ldK07rxIjj2IKzrm6BprOZmhx6mpUSf/shZIba1QlA16i6nB7hH5CM6PUAg==
X-Received: by 2002:a63:ce58:0:b0:380:103:64ee with SMTP id r24-20020a63ce58000000b00380010364eemr23929298pgi.213.1647994015496;
        Tue, 22 Mar 2022 17:06:55 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/9] log: Introduce DBG_IS_ENABLED
Date:   Tue, 22 Mar 2022 17:06:46 -0700
Message-Id: <20220323000654.3157833-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
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

