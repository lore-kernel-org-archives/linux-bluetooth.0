Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F797C83000
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CDA2137B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMpGIpHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD2WQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726852AbgD2WQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 18:16:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4285C035494
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 15:16:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so1387646plp.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eitYCCeQNN+sixvGb3M64Jsh3uV7JK+bLFOwI6jYrg=;
        b=VMpGIpHg09NvG1b+cyygdFEYhNySJjktShUOAI93lQQagdOiPN700WAKasDfApiMLj
         ckoRBJjr4J5pGQvKrix7DDoc2I3Zy6sesO7AZIOUiIud0XSAHgsjZ5E2sJM9Jd5xnPYM
         fRqAC6ovJiEecOFOXKv4hBSYPK7WM4r8NdMWtYQC/0J5LJwT/tJY6fxXfEUQEcxPxouu
         3Mc6MNhefur3tKjmYHzNMXZZN4+0xM+dX3yRFMBxxKmLrWfCVsH/bNBdA0uS0g5p4AEH
         BvzlO8Hr+UXW8eXAT8iHGYTEOUNcOzD4zqH0khHm4q08cfjJsvXBnmQ7lXrtG8+FNkDe
         gzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eitYCCeQNN+sixvGb3M64Jsh3uV7JK+bLFOwI6jYrg=;
        b=TTQ0wy82YzzwlrBivVYBoJ96tvmavfypGWfTmSckItz2SkTnit+UdIN6Nuy0Dfmib2
         zO4E1uRQ7p6WRyihqhPcmG9LllMhDLESR8X5skjkSvOhobQK5JiyS7S8il1vSlSNP4mJ
         QVp/9zoa9M7CFfEOjMvOs+/52ZwaQ6oAc9jzKfUQOw26RwXJmD3CxJgsluuRyCJMzExq
         kGyjX00WMwBAizu2SOpRo/vYgiX/zUyeEw0Zzw3VkmakTqrm/4wlsufIVTHLXGQUORNW
         hEoG7HiUqfnmF3Eyji1NS8DIWWu9APO45Azb4+EoxWYSDldskZadyQElQEGyy+/6V3+9
         7vhg==
X-Gm-Message-State: AGi0PuZvcNzoj3o2qPIHPEM46y5pnj5dXIwA5aViopBzrp7nAFZ8YgLg
        upV2ymJmechMLBYeUYJW3INi+epsM2s=
X-Google-Smtp-Source: APiQypJeklDQcF+feZNfOYQxTAkNQWoj6lPTziYVEr6xZkTVZ0YREgHg/iKKifw1+9n/D/mN1Wc99Q==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr718328pjb.27.1588198575030;
        Wed, 29 Apr 2020 15:16:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m7sm1890667pfb.48.2020.04.29.15.16.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:16:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] log: Make error and warn log file and function information
Date:   Wed, 29 Apr 2020 15:16:13 -0700
Message-Id: <20200429221613.1574274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it a lot simpler to find out where errors/warnings come from
and also remove the possibility of clashes when having multiple places
where the message would be exactly the same.
---
 src/log.c | 26 --------------------------
 src/log.h |  6 ++++--
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/src/log.c b/src/log.c
index 11d26d508..a42c5941d 100644
--- a/src/log.c
+++ b/src/log.c
@@ -53,32 +53,6 @@ static void monitor_log(uint16_t index, int priority,
 	bt_log_vprintf(index, LOG_IDENT, priority, format, ap);
 }
 
-void error(const char *format, ...)
-{
-	va_list ap;
-
-	va_start(ap, format);
-	vsyslog(LOG_ERR, format, ap);
-	va_end(ap);
-
-	va_start(ap, format);
-	monitor_log(HCI_DEV_NONE, LOG_ERR, format, ap);
-	va_end(ap);
-}
-
-void warn(const char *format, ...)
-{
-	va_list ap;
-
-	va_start(ap, format);
-	vsyslog(LOG_WARNING, format, ap);
-	va_end(ap);
-
-	va_start(ap, format);
-	monitor_log(HCI_DEV_NONE, LOG_WARNING, format, ap);
-	va_end(ap);
-}
-
 void info(const char *format, ...)
 {
 	va_list ap;
diff --git a/src/log.h b/src/log.h
index 0d243ceca..e83431151 100644
--- a/src/log.h
+++ b/src/log.h
@@ -23,8 +23,6 @@
 
 #include <stdint.h>
 
-void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
-void warn(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void btd_log(uint16_t index, int priority, const char *format, ...)
@@ -71,3 +69,7 @@ void __btd_enable_debug(struct btd_debug_desc *start,
 } while (0)
 
 #define DBG(fmt, arg...) DBG_IDX(0xffff, fmt, ## arg)
+#define error(fmt, arg...) \
+	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+#define warn(fmt, arg...) \
+	btd_warn(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
-- 
2.25.3

