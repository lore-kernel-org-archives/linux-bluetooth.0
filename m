Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BDC46464
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CA220827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZYg8iZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CA220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeKHBpm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:45:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39392 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKHBpm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 20:45:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so11878707lfh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=HadbgAgwLkMmDFCi+b1XP+2c3Izl6pWVK0C5s8iabpU=;
        b=dZYg8iZPqGkVqvhomHzeky3z5aUS7YPQ7RhCDa0nT5t1/cWrZ6u7Jf9AoMI9zbikdL
         U8hNohYkTmT/7F/gWHGGK4R9XVRFa6ZEkKRB8bpxskCy4aM/zLNJa52pf7plhT1f2xkM
         9g/lNZmtuwDHUi6fKMz0ObnK/JpbWKhjGDSTGm1s4EjkeueOL6/WMUhsrbeGM90MENH+
         4PQMdoPJAH6dv2xrDiwTfscb6Xywde4QkE0CNLEPxBUId+R63CQ2BVhIcGVrORexKezz
         Y5yRiGPuziYkd6H3Uo517fvLs1gKeNccSOgUPzM5HPGu8F56pRN7CVuH4SY/GBMrpH6D
         9+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=HadbgAgwLkMmDFCi+b1XP+2c3Izl6pWVK0C5s8iabpU=;
        b=BmfJey7eGBWZhYiulDoP7EIsbubnzc5ACiezy9Wtktxj6AhcsJZaWAiwpY8AGOgm7I
         TqOHwsH07zdsl8QNfWmcjHln3yXgiCfmRvDCoYbP4Ed18EsWFOxXuOYHVV9R04Rx4Rks
         Jmgv2tzZv6JQODfF/UixBdNOcL9oYzX3IC0R5rMV1BHM83blTiAyaFAuBUZgRF8Tkj/I
         1TVoDuzeZPx7QYmXK/kh1h8pChbpaTkjZ/+PVzGydvwPnixicYkjYM5tfKB+f1cHgTyo
         QCb8aE2AnKvdrk69YjkI6yW9q9eHMpiXn0Ay1uzjzl4hBqfb8S98nxv8k0Z461E8acNR
         NHMA==
X-Gm-Message-State: AGRZ1gKrCYZIO+UKzXxyhY681entY48bB2r82F5nld+xuoigHHvHhuje
        KsP72jOWEmXga/a9LrNMNP7rhTBglOA=
X-Google-Smtp-Source: AJdET5cpwlTjQ5uilOPeVkdW89P7Qe07PL36mH1/NmM1q2Unyj/A3YFCJ9RYmv2baT0Wm9FPpyruMA==
X-Received: by 2002:a19:2106:: with SMTP id h6mr499598lfh.29.1541607278109;
        Wed, 07 Nov 2018 08:14:38 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id f95-v6sm199905lji.76.2018.11.07.08.14.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:14:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] log: Use shared monitor code
Date:   Wed,  7 Nov 2018 18:14:32 +0200
Message-Id: <20181107161432.13081-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181107161432.13081-1-luiz.dentz@gmail.com>
References: <20181107161432.13081-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use bt_monitor_* to send messages to the monitor.
---
 android/Makefile.am  |   1 +
 src/log.c            | 132 +++++--------------------------------------
 src/shared/monitor.c |  28 +++++----
 src/shared/monitor.h |  11 ++--
 src/shared/tester.c  |  10 ++--
 5 files changed, 43 insertions(+), 139 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 154f8db56..e9a6e0242 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -107,6 +107,7 @@ android_avdtptest_SOURCES = android/avdtptest.c \
 				btio/btio.h btio/btio.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/queue.h src/shared/queue.c \
+				src/shared/monitor.h src/shared/monitor.c \
 				android/avdtp.h android/avdtp.c
 android_avdtptest_CFLAGS = $(AM_CFLAGS)
 android_avdtptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
diff --git a/src/log.c b/src/log.c
index d2a20de78..7dceeb617 100644
--- a/src/log.c
+++ b/src/log.c
@@ -41,95 +41,15 @@
 #include "lib/hci.h"
 
 #include "src/shared/util.h"
+#include "src/shared/monitor.h"
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
+static void monitor_log(uint16_t index, int level, const char *format,
+							va_list ap)
 {
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
-					const char *format, va_list ap)
-{
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
+	bt_monitor_vprintf(index, LOG_IDENT, level, format, ap);
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
+	bt_monitor_open();
 
 	if (!detach)
 		option |= LOG_PERROR;
@@ -325,7 +221,7 @@ void __btd_log_cleanup(void)
 {
 	closelog();
 
-	logging_close();
+	bt_monitor_close();
 
 	g_strfreev(enabled);
 }
diff --git a/src/shared/monitor.c b/src/shared/monitor.c
index 78766ed1a..019147ab3 100644
--- a/src/shared/monitor.c
+++ b/src/shared/monitor.c
@@ -56,8 +56,8 @@ struct monitor_l2cap_hdr {
 
 static int monitor_fd = -1;
 
-int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
-							size_t io_len)
+int bt_monitor_sendmsg(uint16_t index, const char *label, int level,
+					struct iovec *io, size_t io_len)
 {
 	struct monitor_hdr hdr;
 	struct msghdr msg;
@@ -73,7 +73,7 @@ int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
 		return monitor_fd;
 
 	hdr.opcode = cpu_to_le16(0x0000);
-	hdr.index = cpu_to_le16(0xffff);
+	hdr.index = cpu_to_le16(index);
 	hdr.ident_len = strlen(label) + 1;
 	hdr.len = cpu_to_le16(2 + hdr.ident_len);
 	hdr.priority = level;
@@ -108,14 +108,19 @@ int bt_monitor_open(void)
 {
 	struct sockaddr_hci addr;
 	int fd;
-	int err;
+	static int err;
+
+	if (err < 0)
+		return err;
 
 	if (monitor_fd >= 0)
 		return monitor_fd;
 
 	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (fd < 0)
+	if (fd < 0) {
+		err = -errno;
 		return -errno;
+	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.hci_family = AF_BLUETOOTH;
@@ -123,7 +128,7 @@ int bt_monitor_open(void)
 	addr.hci_channel = HCI_CHANNEL_LOGGING;
 
 	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
-	if (err < 0 ){
+	if (err < 0) {
 		err = -errno;
 		close(fd);
 		return err;
@@ -134,8 +139,8 @@ int bt_monitor_open(void)
 	return fd;
 }
 
-int bt_monitor_vprintf(const char *label, int level, const char *format,
-								va_list ap)
+int bt_monitor_vprintf(uint16_t index, const char *label, int level,
+					const char *format, va_list ap)
 {
 	struct iovec iov;
 	char *str;
@@ -148,20 +153,21 @@ int bt_monitor_vprintf(const char *label, int level, const char *format,
 	iov.iov_base = str;
 	iov.iov_len = strlen(str) + 1;
 
-	err = bt_monitor_sendmsg(label, level, &iov, 1);
+	err = bt_monitor_sendmsg(index, label, level, &iov, 1);
 
 	free(str);
 
 	return err;
 }
 
-int bt_monitor_printf(const char *label, int level, const char *format, ...)
+int bt_monitor_printf(uint16_t index, const char *label, int level,
+						const char *format, ...)
 {
 	va_list ap;
 	int err;
 
 	va_start(ap, format);
-	err = bt_monitor_vprintf(label, level, format, ap);
+	err = bt_monitor_vprintf(index, label, level, format, ap);
 	va_end(ap);
 
 	return err;
diff --git a/src/shared/monitor.h b/src/shared/monitor.h
index 0aa538e36..2a4cc768a 100644
--- a/src/shared/monitor.h
+++ b/src/shared/monitor.h
@@ -22,9 +22,10 @@
  */
 
 int bt_monitor_open(void);
-int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
-							size_t io_len);
-int bt_monitor_vprintf(const char *label, int level, const char *format,
-								va_list ap);
-int bt_monitor_printf(const char *label, int level, const char *format, ...);
+int bt_monitor_sendmsg(uint16_t index, const char *label, int level,
+					struct iovec *io, size_t io_len);
+int bt_monitor_vprintf(uint16_t index, const char *label, int level,
+					const char *format, va_list ap);
+int bt_monitor_printf(uint16_t index, const char *label, int level,
+					const char *format, ...);
 void bt_monitor_close(void);
diff --git a/src/shared/tester.c b/src/shared/tester.c
index 3dac2a59d..8e406cb1f 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -169,7 +169,7 @@ static void tester_log(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	bt_monitor_vprintf(tester_name, LOG_INFO, format, ap);
+	bt_monitor_vprintf(HCI_DEV_NONE, tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -182,7 +182,7 @@ void tester_print(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	bt_monitor_vprintf(tester_name, LOG_INFO, format, ap);
+	bt_monitor_vprintf(HCI_DEV_NONE, tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -195,7 +195,7 @@ void tester_debug(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	bt_monitor_vprintf(tester_name, LOG_DEBUG, format, ap);
+	bt_monitor_vprintf(HCI_DEV_NONE, tester_name, LOG_DEBUG, format, ap);
 	va_end(ap);
 }
 
@@ -208,7 +208,7 @@ void tester_warn(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	bt_monitor_vprintf(tester_name, LOG_WARNING, format, ap);
+	bt_monitor_vprintf(HCI_DEV_NONE, tester_name, LOG_WARNING, format, ap);
 	va_end(ap);
 }
 
@@ -243,7 +243,7 @@ static void monitor_log(char dir, uint16_t cid, uint16_t psm, const void *data,
 	iov[2].iov_base = &term;
 	iov[2].iov_len = sizeof(term);
 
-	bt_monitor_sendmsg(label, LOG_INFO, iov, 3);
+	bt_monitor_sendmsg(HCI_DEV_NONE, label, LOG_INFO, iov, 3);
 }
 
 void tester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
-- 
2.17.2

