Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765DC46465
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37920827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxyPnWt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E37920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbeKHBpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:45:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42036 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeKHBpk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 20:45:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so11863861lfh.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=W+WaJsuAeaQ1snWcFikHco0tvceHYIWYLAKCVmLnEUQ=;
        b=ZxyPnWt2AIA1IsmzRS3koa3qv1ZILK21yciF5hpeFPPjK6dw4LccholYN/sTCTBpRf
         JkP9H6/vZeJdlrSwvb3ap6A5B/aSQnkWPjJxuIFmLcUp63IDz98BmXDNubOM6JLjNZaU
         fJUvxdibElt0INRXLn6v2vpTGfeH1f41XR2CWrLPuauLT5Kn4CLlhpwAalDwY0kIs+Ux
         laoenFro3h8MhLy7W0908zoE582Dw0uL3q98LejPGXgwodP2+wnS0jUMD/VGjPcZKF0o
         bCC1EydUpPJzdvDxqiHIZgScrFZdzLiGYRBXSJdM84U9sdBork+eNxVsnFm2KiGUGMnY
         jdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=W+WaJsuAeaQ1snWcFikHco0tvceHYIWYLAKCVmLnEUQ=;
        b=W6/hVdF/OI58CDBOLzJ3dsFk3PytY81hiu39z1AfKeAFCF2lOpMNQRmN895sRplHRA
         6pICWoq/CzKYZ4HqTB9ZJZtD/aNxOolsYtN8QIOKQPFTuTzVmMaSw/jbswwkvZFx7bOk
         yWZ4cCkXxG8C8mxeFGmSTrkZVCSwpWxrZlRoZy2P3MmfIX5X2gEDXqsw+HtRETLihdTD
         tb5kr+SnGgGSaLIc0o21lH6stDVbdA3KpBJF/3wh3Zq7Zo9p8KhlH/L5TnM/+ZzbGwAF
         1VCaKnZW1me4jinIunwWlBAz0UODW1H1bcLA+WEWiCw48D+Lk9d5CgKslOIAKr2ULlYJ
         Vrhw==
X-Gm-Message-State: AGRZ1gIuc5TKG2WDKQIVoCz9qWXiQN3TlHmBPFFCh1zqJkOo7+7pEw7N
        SpmdIowCKu/Q4Vr82ICyi2HGxCZQoYs=
X-Google-Smtp-Source: AJdET5fLiwmEKD/BSzdym7Dw+/aZnKEbTqo7yqtLBPVAFaP8KhwBuoGXlNB5UsoNqWyQKHs/94SR8g==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr483707lfc.47.1541607276795;
        Wed, 07 Nov 2018 08:14:36 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id f95-v6sm199905lji.76.2018.11.07.08.14.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:14:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/tester: Make use of shared monitor
Date:   Wed,  7 Nov 2018 18:14:31 +0200
Message-Id: <20181107161432.13081-2-luiz.dentz@gmail.com>
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
 src/shared/tester.c | 112 ++++----------------------------------------
 1 file changed, 9 insertions(+), 103 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 05c81a66d..3dac2a59d 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -46,6 +46,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
+#include "src/shared/monitor.h"
 
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_BLACK	"\x1B[0;30m"
@@ -131,8 +132,6 @@ struct monitor_l2cap_hdr {
 	uint16_t psm;
 } __attribute__((packed));
 
-static int monitor_fd = -1;
-
 static void test_destroy(gpointer data)
 {
 	struct test_case *test = data;
@@ -150,102 +149,6 @@ static void test_destroy(gpointer data)
 	free(test);
 }
 
-static int monitor_open(void)
-{
-	struct sockaddr_hci addr;
-	int fd;
-
-	if (!option_monitor)
-		return -1;
-
-	if (monitor_fd >= 0)
-		return monitor_fd;
-
-	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (fd < 0)
-		return fd;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.hci_family = AF_BLUETOOTH;
-	addr.hci_dev = HCI_DEV_NONE;
-	addr.hci_channel = HCI_CHANNEL_LOGGING;
-
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		option_monitor = FALSE;
-		tester_debug("Failed to open monitor socket: %s",
-			     strerror(errno));
-		close(fd);
-		return -1;
-	}
-
-	monitor_fd = fd;
-
-	return fd;
-}
-
-static void monitor_sendmsg(const char *label, int level, struct iovec *io,
-							size_t io_len)
-{
-	struct monitor_hdr hdr;
-	struct msghdr msg;
-	struct iovec iov[5];
-	size_t i;
-
-	monitor_fd = monitor_open();
-	if (monitor_fd < 0 || io_len > 3)
-		return;
-
-	hdr.opcode = cpu_to_le16(0x0000);
-	hdr.index = cpu_to_le16(0xffff);
-	hdr.ident_len = strlen(label) + 1;
-	hdr.len = cpu_to_le16(2 + hdr.ident_len);
-	hdr.priority = level;
-
-	iov[0].iov_base = &hdr;
-	iov[0].iov_len = sizeof(hdr);
-
-	iov[1].iov_base = (void *) label;
-	iov[1].iov_len = hdr.ident_len;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 2;
-
-	for (i = 0; i < io_len; i++) {
-		iov[i + 2] = io[i];
-		hdr.len += io[i].iov_len;
-		msg.msg_iovlen++;
-	}
-
-	if (sendmsg(monitor_fd, &msg, 0) < 0) {
-		/* Disable monitor */
-		option_monitor = FALSE;
-		tester_debug("Failed to send to monitor: %s", strerror(errno));
-		close(monitor_fd);
-		monitor_fd = -1;
-	}
-}
-
-static void monitor_vprintf(const char *id, int level, const char *format,
-								va_list ap)
-{
-	struct iovec iov;
-	char *str;
-
-	if (!option_monitor)
-		return;
-
-	if (vasprintf(&str, format, ap) < 0)
-		return;
-
-	iov.iov_base = str;
-	iov.iov_len = strlen(str) + 1;
-
-	monitor_sendmsg(id, level, &iov, 1);
-
-	free(str);
-}
-
 static void tester_vprintf(const char *format, va_list ap)
 {
 	if (tester_use_quiet())
@@ -266,7 +169,7 @@ static void tester_log(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_INFO, format, ap);
+	bt_monitor_vprintf(tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -279,7 +182,7 @@ void tester_print(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_INFO, format, ap);
+	bt_monitor_vprintf(tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -292,7 +195,7 @@ void tester_debug(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_DEBUG, format, ap);
+	bt_monitor_vprintf(tester_name, LOG_DEBUG, format, ap);
 	va_end(ap);
 }
 
@@ -305,7 +208,7 @@ void tester_warn(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_WARNING, format, ap);
+	bt_monitor_vprintf(tester_name, LOG_WARNING, format, ap);
 	va_end(ap);
 }
 
@@ -340,7 +243,7 @@ static void monitor_log(char dir, uint16_t cid, uint16_t psm, const void *data,
 	iov[2].iov_base = &term;
 	iov[2].iov_len = sizeof(term);
 
-	monitor_sendmsg(label, LOG_INFO, iov, 3);
+	bt_monitor_sendmsg(label, LOG_INFO, iov, 3);
 }
 
 void tester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
@@ -1032,5 +935,8 @@ int tester_run(void)
 
 	g_list_free_full(test_list, test_destroy);
 
+	if (option_monitor)
+		bt_monitor_close();
+
 	return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.17.2

