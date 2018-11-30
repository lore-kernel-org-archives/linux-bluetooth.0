Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D7AC64EB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BD42145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf3rzHWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BD42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeK3V3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45574 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3V3O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so3682103lfa.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Uck3kpTBn/Y1u3tK3jEu1U31YH8X/iQ748CQFtkvLpY=;
        b=Xf3rzHWoChKZZmnCwigu8ZJ8lhe115pS5rNkUOmzRC0hiKb+7R5+SNIO8GgOAzzqA1
         GAJDfGRagkeZWbMhJt6gUTqTWMK3QQqUewSXwn6Tp3FMfp53Xlt1BRCcNxjwkrzuK5+S
         D1GH48/nYzC0ClNuu/8RmSBy9LAkzoco6CSNGw4cKYmFsq/cmLnoB/PtFYLHJbnzE8Sc
         jkI+/zo9Pj33iSO29lzPB/yeNFmgB/hcFPrsSiUl21ojK1xJitir32fgQWvLaU0Uul5q
         wO6F2R5SuhJB8scLfA8PVeacuJ/BYq0LTbV6iPXV6yEBJrxQWabe/9Vy3Wc9ofajn+w7
         ALGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Uck3kpTBn/Y1u3tK3jEu1U31YH8X/iQ748CQFtkvLpY=;
        b=aJKnOb5vRa9nhsL9XuSdFNytMN4Fx/pFFOtVT2cAB7iHaOm7WcV2KRGUy8SQOj6mxn
         GeyCc6cJXS30zMmMIGjiw9A6ZjSrfri2NsXakgplilLTWHblsTNSbPmgNEAjucjEpybv
         0hRzD6UIM7U2aVt2a2ubOd0m7yrEmdrnwXND2JCqZw2YXPWfFVrTJJY1V9PJ+ibzpWi+
         95dU7h5oYxzvdXD1k/ewvlLXX+cdkozKsXJiftAk7CiVxuZTym9C0eL1YuLzLajF8SmI
         t6QKRXCmVR3v2sa6YhrTpJe1zuhyBprcTODy42xpbKsf3m3JFNDweB/x4jb2N6EIijGw
         XRkQ==
X-Gm-Message-State: AA+aEWaXYusiEPSB3lEZw5HsX0b0NBzQlasgkgV6z2u1qqzyL4mg23Ny
        1tmupLbmxBILaSkapZs2QpTAhC7mFGY=
X-Google-Smtp-Source: AFSGD/U1iOSV6NOKi1nEa+x2ap3/BC1Xhm1DWxoXzkmqxcJvg+z0EmZ4O80zk4QWEnEd/tUpx/kVlQ==
X-Received: by 2002:a19:518d:: with SMTP id g13mr3169663lfl.143.1543573224404;
        Fri, 30 Nov 2018 02:20:24 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/10] shared/mainloop: Add mainloop_run_with_signal
Date:   Fri, 30 Nov 2018 12:20:10 +0200
Message-Id: <20181130102013.29023-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidates the handling of signalfd in similar ways as ELL does.
---
 src/shared/mainloop-glib.c   |  1 +
 src/shared/mainloop-notify.c | 85 ++++++++++++++++++++++++++++++++++++
 src/shared/mainloop.h        |  1 +
 3 files changed, 87 insertions(+)

diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 42abfddf8..e44197315 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -37,6 +37,7 @@
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
+#include "io.h"
 
 static GMainLoop *main_loop;
 static int exit_status;
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 2e3b08f06..17bf2c027 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -31,13 +31,17 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <string.h>
+#include <signal.h>
 
+#include <sys/signalfd.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
 #include "timeout.h"
+#include "util.h"
+#include "io.h"
 
 #define WATCHDOG_TRIGGER_FREQ 2
 
@@ -45,6 +49,14 @@ static int notify_fd = -1;
 
 static unsigned int watchdog;
 
+struct signal_data {
+	struct io *io;
+	mainloop_signal_func func;
+	void *user_data;
+};
+
+static struct signal_data *signal_data;
+
 static bool watchdog_callback(void *user_data)
 {
 	mainloop_sd_notify("WATCHDOG=1");
@@ -119,3 +131,76 @@ int mainloop_sd_notify(const char *state)
 
 	return err;
 }
+
+static bool signal_read(struct io *io, void *user_data)
+{
+	struct signal_data *data = user_data;
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	fd = io_get_fd(io);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return false;
+
+	if (data && data->func)
+		data->func(si.ssi_signo, data->user_data);
+
+	return true;
+}
+
+static struct io *setup_signalfd(void *user_data)
+{
+	struct io *io;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGUSR2);
+	sigaddset(&mask, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
+		return NULL;
+
+	fd = signalfd(-1, &mask, SFD_NONBLOCK | SFD_CLOEXEC);
+	if (fd < 0)
+		return NULL;
+
+	io = io_new(fd);
+
+	io_set_close_on_destroy(io, true);
+	io_set_read_handler(io, signal_read, user_data, free);
+
+	return io;
+}
+
+int mainloop_run_with_signal(mainloop_signal_func func, void *user_data)
+{
+	struct signal_data *data;
+	struct io *io;
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	data = new0(struct signal_data, 1);
+	data->func = func;
+	data->user_data = user_data;
+
+	io = setup_signalfd(data);
+	if (!io) {
+		free(data);
+		return -errno;
+	}
+
+	ret = mainloop_run();
+
+	io_destroy(io);
+	free(signal_data);
+
+	return ret;
+}
diff --git a/src/shared/mainloop.h b/src/shared/mainloop.h
index 73ed81187..1ede62797 100644
--- a/src/shared/mainloop.h
+++ b/src/shared/mainloop.h
@@ -36,6 +36,7 @@ void mainloop_quit(void);
 void mainloop_exit_success(void);
 void mainloop_exit_failure(void);
 int mainloop_run(void);
+int mainloop_run_with_signal(mainloop_signal_func func, void *user_data);
 
 int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
 				void *user_data, mainloop_destroy_func destroy);
-- 
2.17.2

