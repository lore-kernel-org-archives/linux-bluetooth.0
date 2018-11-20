Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D629C41536
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B011206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzzlqoEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B011206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeKUA1t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:27:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35236 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKUA1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 19:27:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so2014265edx.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 05:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zFMlPMPQF+xrGURWDxSoB24BvNe3hRE05sVQscDl7Cw=;
        b=FzzlqoEl0f2HLuNxiyXizemnnyRM4r929n0qGxHcCMnmo/CfdHoew3g7nnb3exzsov
         HEz8MV/eYmE598izhDa0QHYeYL9/FMBr4vHxyiBikKMEvvJvHlgfH/flKRuq4JljQArl
         i1Wua90M2z3eoMAMGqoUmX7BqUIPWZYLeiH61SnXz5okV1uo8POHN9+6qxL/GO6eZxlN
         duiHc3S6K0mDHe2wBwEnDnvDFEgX0PMidipGJgLowp+8OUczDVaDPr9m+vSzTo+eGZR5
         bzOMq/mv9f1mZkBIp93ejGesUgpYfzzFIqdtbIQjOsm2yOvSoGvNUmwHsYwzgrabPBA3
         cKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zFMlPMPQF+xrGURWDxSoB24BvNe3hRE05sVQscDl7Cw=;
        b=HfTKYEo3ZkAGWv01QHAlm45l9y9HC9MMkNW9L9tCAK4BYFmethRkITHkMUH6fEatkp
         Nk8FuWSgLzlVJ7fu/+S2aFm09Rw3pvjhTMWbMwWZbxGHtS6CIhz6rDU4AK74kGibpAA7
         jYzi/uiQe4LDBux8h7sh2JbPEy4uhCdLO60xprU8EDn3fRLK2c40/an0w+awI5cP5/1h
         OL1qAZddUiNUhei7EorQ1m160L+bI8m50LCWicITYb4B5NYfARxBreGqor+XwaBwT7eP
         qStJ2uUCUeX5QC1byqsPoubfvFr+cuqq4eJh3qd2znu8cMkxA5GN+Z8Px24xkn3Jm2CT
         FZ/w==
X-Gm-Message-State: AGRZ1gLJjUCFdoyzsQQzZXAid+3NoBC+/hNcYX3TwXNEr0p1oFJkuGFj
        ggelc3ghbW4Pa4G96/Mbzq10LnuJ
X-Google-Smtp-Source: AJdET5eEGin5prXqDIV3bkCryLtB27iU1pHdy6iBwZQuAVVl0c3Y6/ZvMJ9qFuw1vAMZe7dnaTAqZA==
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr2033762ejf.177.1542722309555;
        Tue, 20 Nov 2018 05:58:29 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id c29sm7200768eda.75.2018.11.20.05.58.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:58:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] log: Use shared log code
Date:   Tue, 20 Nov 2018 15:58:21 +0200
Message-Id: <20181120135821.18082-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181120135821.18082-1-luiz.dentz@gmail.com>
References: <20181120135821.18082-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use bt_log_* to send messages to the logging channel.
---
 Makefile.tools      |   6 +-
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 src/log.c           | 130 +++++---------------------------------------
 4 files changed, 19 insertions(+), 119 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index f81fd0a4c..231a4b09b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -223,13 +223,15 @@ tools_mcaptest_SOURCES = tools/mcaptest.c \
 				btio/btio.h btio/btio.c \
 				src/log.c src/log.h \
 				profiles/health/mcap.h profiles/health/mcap.c
-tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lrt
+tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ \
+				src/libshared-mainloop.la -lrt
 
 tools_bneptest_SOURCES = tools/bneptest.c \
 				btio/btio.h btio/btio.c \
 				src/log.h src/log.c \
 				profiles/network/bnep.h profiles/network/bnep.c
-tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ \
+				src/libshared-mainloop.la
 
 tools_cltest_SOURCES = tools/cltest.c
 tools_cltest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
diff --git a/android/Android.mk b/android/Android.mk
index 76a826b47..8f842e775 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -228,6 +228,7 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
+	bluez/src/shared/log.c \
 	bluez/src/log.c \
 	bluez/btio/btio.c \
 	bluez/lib/bluetooth.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 154f8db56..d665d1e14 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -107,6 +107,7 @@ android_avdtptest_SOURCES = android/avdtptest.c \
 				btio/btio.h btio/btio.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/queue.h src/shared/queue.c \
+				src/shared/log.h src/shared/log.c \
 				android/avdtp.h android/avdtp.c
 android_avdtptest_CFLAGS = $(AM_CFLAGS)
 android_avdtptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
diff --git a/src/log.c b/src/log.c
index d2a20de78..ea639cbd6 100644
--- a/src/log.c
+++ b/src/log.c
@@ -41,95 +41,15 @@
 #include "lib/hci.h"
 
 #include "src/shared/util.h"
+#include "src/shared/log.h"
 #include "log.h"
 
 #define LOG_IDENT "bluetoothd"
-#define LOG_IDENT_LEN sizeof(LOG_IDENT)
 
-struct log_hdr {
-	uint16_t opcode;
-	uint16_t index;
-	uint16_t len;
-	uint8_t  priority;
-	uint8_t  ident_len;
-} __attribute__((packed));
-
-static int logging_fd = -1;
-
-static void logging_open(void)
-{
-	struct sockaddr_hci addr;
-	int fd;
-
-	if (logging_fd >= 0)
-		return;
-
-	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (fd < 0)
-		return;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.hci_family = AF_BLUETOOTH;
-	addr.hci_dev = HCI_DEV_NONE;
-	addr.hci_channel = HCI_CHANNEL_LOGGING;
-
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		close(fd);
-		return;
-	}
-
-	logging_fd = fd;
-}
-
-static void logging_close(void)
-{
-	if (logging_fd >= 0) {
-		close(logging_fd);
-		logging_fd = -1;
-	}
-}
-
-static void logging_log(uint16_t index, int priority,
+static void monitor_log(uint16_t index, int priority,
 					const char *format, va_list ap)
 {
-	struct log_hdr hdr;
-	struct msghdr msg;
-	struct iovec iov[3];
-	uint16_t len;
-	char *str;
-
-	if (vasprintf(&str, format, ap) < 0)
-		return;
-
-	len = strlen(str) + 1;
-
-	hdr.opcode = cpu_to_le16(0x0000);
-	hdr.index = cpu_to_le16(index);
-	hdr.len = cpu_to_le16(2 + LOG_IDENT_LEN + len);
-	hdr.priority = priority;
-	hdr.ident_len = LOG_IDENT_LEN;
-
-	iov[0].iov_base = &hdr;
-	iov[0].iov_len = sizeof(hdr);
-
-	iov[1].iov_base = LOG_IDENT;
-	iov[1].iov_len = LOG_IDENT_LEN;
-
-	iov[2].iov_base = str;
-	iov[2].iov_len = len;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 3;
-
-	if (sendmsg(logging_fd, &msg, 0) < 0) {
-		if (errno != ENODEV) {
-			close(logging_fd);
-			logging_fd = -1;
-		}
-	}
-
-	free(str);
+	bt_log_vprintf(index, LOG_IDENT, priority, format, ap);
 }
 
 void error(const char *format, ...)
@@ -140,11 +60,8 @@ void error(const char *format, ...)
 	vsyslog(LOG_ERR, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(HCI_DEV_NONE, LOG_ERR, format, ap);
+	monitor_log(HCI_DEV_NONE, LOG_ERR, format, ap);
 	va_end(ap);
 }
 
@@ -156,11 +73,8 @@ void warn(const char *format, ...)
 	vsyslog(LOG_WARNING, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(HCI_DEV_NONE, LOG_WARNING, format, ap);
+	monitor_log(HCI_DEV_NONE, LOG_WARNING, format, ap);
 	va_end(ap);
 }
 
@@ -172,11 +86,8 @@ void info(const char *format, ...)
 	vsyslog(LOG_INFO, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(HCI_DEV_NONE, LOG_INFO, format, ap);
+	monitor_log(HCI_DEV_NONE, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -188,11 +99,8 @@ void btd_log(uint16_t index, int priority, const char *format, ...)
 	vsyslog(priority, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(index, priority, format, ap);
+	monitor_log(index, priority, format, ap);
 	va_end(ap);
 }
 
@@ -204,11 +112,8 @@ void btd_error(uint16_t index, const char *format, ...)
 	vsyslog(LOG_ERR, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(index, LOG_ERR, format, ap);
+	monitor_log(index, LOG_ERR, format, ap);
 	va_end(ap);
 }
 
@@ -220,11 +125,8 @@ void btd_warn(uint16_t index, const char *format, ...)
 	vsyslog(LOG_WARNING, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(index, LOG_WARNING, format, ap);
+	monitor_log(index, LOG_WARNING, format, ap);
 	va_end(ap);
 }
 
@@ -236,11 +138,8 @@ void btd_info(uint16_t index, const char *format, ...)
 	vsyslog(LOG_INFO, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(index, LOG_INFO, format, ap);
+	monitor_log(index, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -252,11 +151,8 @@ void btd_debug(uint16_t index, const char *format, ...)
 	vsyslog(LOG_DEBUG, format, ap);
 	va_end(ap);
 
-	if (logging_fd < 0)
-		return;
-
 	va_start(ap, format);
-	logging_log(index, LOG_DEBUG, format, ap);
+	monitor_log(index, LOG_DEBUG, format, ap);
 	va_end(ap);
 }
 
@@ -311,7 +207,7 @@ void __btd_log_init(const char *debug, int detach)
 
 	__btd_enable_debug(__start___debug, __stop___debug);
 
-	logging_open();
+	bt_log_open();
 
 	if (!detach)
 		option |= LOG_PERROR;
@@ -325,7 +221,7 @@ void __btd_log_cleanup(void)
 {
 	closelog();
 
-	logging_close();
+	bt_log_close();
 
 	g_strfreev(enabled);
 }
-- 
2.17.2

