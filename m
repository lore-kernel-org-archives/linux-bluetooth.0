Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E3C83004
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6329B206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzjJDaFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2VEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726869AbgD2VEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 17:04:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC9C03C1AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:04:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so1262767pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44cT6vg9o/XB4HDE3z3zf4ENTZzCjtOf3V3z37ECrMg=;
        b=kzjJDaFS1Fr2bqCHv45FhjQIece6lcQ/ewfiP04OPxF3BuppPpdgi3Oikd9AJsT3K0
         KmVbFbu6oeDQOATbmdG6zbB6zsF1GxM81rzlpT9waFXAB6zwGfI4pjY2Lrj/qMPvZU7d
         /b0Sk7RtSTFSILa8/EbyaeMNUoUEWA1lD4VXIQAj4mE5e6Ggkigz/IRmOHRwG4FTpQv3
         TbTix3ko8m2mXF4HAEg/AiFtm3Hd5OD9KYmZgrqlJIG4QK0uR4S/piTiGAYgW6iUU7Dm
         3tiMVs6GVbBUz7xAKLlBm8O/CvXlMUToCfh+LOdBugpp4Bm/z1NXQ+RsVMbFOgkRKbmx
         bk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44cT6vg9o/XB4HDE3z3zf4ENTZzCjtOf3V3z37ECrMg=;
        b=ucL63Qb2CxEui16nKxCL2ups2c5p83xTGr/X3X32qutONKGmD2PiBcKFuMLlN6JNdp
         Qzq08cBhSZuA2WYGEUNFdw2cOcJQf4/+kuK1GvBQuxg3ZKp9U8JLcH0D/ggCP7G3Fdq3
         J0pnSbhmfoAMP9Pohp9OFue2+apJAqRE4HwzzgYJJaI2bKuRh2j7gUlu+kHVJoMaHO6i
         f06d+mnEEbmUf1pTQ/uW49b06K7AfOlVP91I65icO4HZmf2Jp4o/3dyeG75l8EHZBExd
         ErDF7Qgshi94KDvMpLZ+avMW+7eKBaQOWwBIyEydEjmE0OSJcRxth8V5Nd/mCgkT+aCf
         psWg==
X-Gm-Message-State: AGi0PuaASJ4INX53P5jJe/ttmiZ01hURSkizQYa8+OBpWI7QmUkMRTYY
        9tXXPcymDDKN6FEOsRkZmwJUNdFo/uk=
X-Google-Smtp-Source: APiQypKchtDtHsga3HX20O2098MPVEPXGLOZJZvdYQqSlBoPsst4NhU0wtQ+LzqeCAQ/XIquTozmqA==
X-Received: by 2002:a17:90a:68c1:: with SMTP id q1mr414198pjj.35.1588194260867;
        Wed, 29 Apr 2020 14:04:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a136sm1783969pfa.99.2020.04.29.14.04.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:04:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] log: Make error and warn log file and function information
Date:   Wed, 29 Apr 2020 14:04:19 -0700
Message-Id: <20200429210419.1569840-1-luiz.dentz@gmail.com>
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
index 0d243ceca..73240e259 100644
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
+	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
+#define warn(fmt, arg...) \
+	btd_warn(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
-- 
2.25.3

