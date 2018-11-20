Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA2C18DF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3CC2075B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvxDLILl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3CC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKUA1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:27:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38150 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKUA1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 19:27:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so2002879ede.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6XV+fA4WdSqgGMOCcumxqGupDzn7LUIFSTl0WNGNKuY=;
        b=LvxDLILlqTJHU83OkWcm2I9+evaJZK9RKkG4CGbkks74rIbYkj1WUgD4MOrg2/OS8g
         2ILJ29iVcfRJndiqfZYOp0rhKF3df5xfyxMQBgPgAsufo6I/Osl0EapE31fXNB9ef+10
         AZZ6A8jPA4EN1oIxbUYw1IcHVipLuT2D5R+xmyVH0vKYNoRAr7YVI+3jGFXUtD6WMxuL
         cK1k4A7GedtuUd3p37xy9aHTivBTH9BsAWSFDn42sK3XfInybTWoUtCJt/G3ygpAoblV
         BNhpHfzSfY5Cbs4rHo+OECK7o/GyWNRnPOkrkX5UXOJznJtqY3Ds/0icWsnks1M7mz6N
         Z2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6XV+fA4WdSqgGMOCcumxqGupDzn7LUIFSTl0WNGNKuY=;
        b=is3kkjpMfY9LtVz2koQ4X4qIC+I0Hy/4kdqntRocURnBD87k3X62X7AC8dFrwUJMjY
         7hN5k2GLOyiDtLkwWt2XWKr2egNezFGeGPy7zyyuAprv/J2sfdlNtzmH0cvG3SNQdBSQ
         qBx/Hg8fHaWphELUzqJzgjFK73vjF3dszl8/4jima0lHXILUrUcxsFlCAGj/g5QfAZyx
         U2ReOWvUHuH0+Bs3iiZYZkOPdG6ha6GhM4fNEP8OmptZ6RuP0SGC4tWsi48gc0F4X+Xo
         JC3DEHOOj+FP0kNYQQoRFuu+dg9VQv51u1zCxEuoHsYgSkEJ2UtQFqWVQjn+zCEQwdS3
         64AQ==
X-Gm-Message-State: AGRZ1gLlemKT7tnbH8JwQtwKsdnC7v+XBWWZqL3szaKIhL6QyCqnjLai
        Zb2N8+mmNGWNJZ8utoULkdPW+HHd
X-Google-Smtp-Source: AJdET5cPwqYC4wwbHE41jWaOUPUirTNiPyPZEfl8St4hkGswbhhWwMwwHy+CQIiaysFgjwUMNMICSQ==
X-Received: by 2002:a17:906:5a0a:: with SMTP id p10-v6mr2098064ejq.43.1542722306673;
        Tue, 20 Nov 2018 05:58:26 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id c29sm7200768eda.75.2018.11.20.05.58.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:58:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] shared/tester: Make use of shared log
Date:   Tue, 20 Nov 2018 15:58:19 +0200
Message-Id: <20181120135821.18082-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181120135821.18082-1-luiz.dentz@gmail.com>
References: <20181120135821.18082-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use bt_monitor_* to send messages to the logging channel.
---
 src/shared/tester.c | 112 ++++----------------------------------------
 1 file changed, 9 insertions(+), 103 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 05c81a66d..168d0de91 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -46,6 +46,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
+#include "src/shared/log.h"
 
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
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -279,7 +182,7 @@ void tester_print(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_INFO, format, ap);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_INFO, format, ap);
 	va_end(ap);
 }
 
@@ -292,7 +195,7 @@ void tester_debug(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_DEBUG, format, ap);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_DEBUG, format, ap);
 	va_end(ap);
 }
 
@@ -305,7 +208,7 @@ void tester_warn(const char *format, ...)
 	va_end(ap);
 
 	va_start(ap, format);
-	monitor_vprintf(tester_name, LOG_WARNING, format, ap);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_WARNING, format, ap);
 	va_end(ap);
 }
 
@@ -340,7 +243,7 @@ static void monitor_log(char dir, uint16_t cid, uint16_t psm, const void *data,
 	iov[2].iov_base = &term;
 	iov[2].iov_len = sizeof(term);
 
-	monitor_sendmsg(label, LOG_INFO, iov, 3);
+	bt_log_sendmsg(HCI_DEV_NONE, label, LOG_INFO, iov, 3);
 }
 
 void tester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
@@ -1032,5 +935,8 @@ int tester_run(void)
 
 	g_list_free_full(test_list, test_destroy);
 
+	if (option_monitor)
+		bt_log_close();
+
 	return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.17.2

