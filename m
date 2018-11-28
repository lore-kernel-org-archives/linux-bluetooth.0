Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F76C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36420832
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZtvTa3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E36420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeK2CCd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37249 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CCd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so22350061edb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9AEEOuiw6alxiILa7mWTdhOfXwHHN9har5P+ikw0MzM=;
        b=qZtvTa3Dya9udH6YG9aD+uIew+SLHIZZ5oLJ9vxKki7dqFv29X+N5yVV/ynRr76myK
         rcCywInY5rQLNuyOh6E5QWG+4L+zrtdoZAZZuvU0VxvdCTwLySXOUpQdo2Geyv5dI1EN
         3Qznu9Ik0Poa18/Uj38tdPOQIHnUJzIBJzfxrnZThmnqdJbECemvFOErLxB5oCg4pCcQ
         JBCktrSz0Yb6gsnCFOgNtXWSGcUGyXVPBu82pxaNsY7uedIVCT4WjBbUtXvZ8GR1De5/
         YQoGvkO6JDJLGG1LQQSy5kv8pwK0x3Wo9b8TrhwxBzMKmuPBjsMgub/qtEXwQae/7PJ1
         r6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9AEEOuiw6alxiILa7mWTdhOfXwHHN9har5P+ikw0MzM=;
        b=KuCSYAd35b5ZKKjsoYN3E3cvnEzBL9A0rGqgFAbYdsjJm1O+eTByNBFOGn16+NTZ6M
         a0m+iZWoxzhMNd56rBvAuxhH5HcAXfZfwlc30IMW3flK4lZvE9Vtklzpg5EOr2QDQ+jU
         TTMUjoQg7+ynL+x8/1xgSvDGGrRo9Wyzug8lHpDlzX3jwMGroWngdw9VHquWHCYaVeTM
         xuJwzY6M3kl+FI4NsmSr/H+dKjeOa/jBAjdUKiQ9+X74RjcTWifDYnjcqCOvd185yKRW
         Gb3ffPlUvvfDwX1+85bpNEJUernG1HDttjV9YRUndHQPs7UiWCth+sy9NIERLaUrqhpL
         AQaA==
X-Gm-Message-State: AA+aEWagRxExFBUwP+fF1RCGlay0YoXHRrXqr3pRk49dilKC17CikfMx
        ALsdBWSvBhqoW97UtvrFBds9aXBj
X-Google-Smtp-Source: AFSGD/UJ16C56eHJuIfo6uTV4W/0mcz/SODvbl968bmxYGu9Dqx1tc7uorKPqm6yMcQ9PXVUBGTJeA==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr30997934edq.170.1543417234507;
        Wed, 28 Nov 2018 07:00:34 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] shared/mainloop: Add mainloop_run_with_signal
Date:   Wed, 28 Nov 2018 17:00:20 +0200
Message-Id: <20181128150023.1576-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidates the handling of signalfd in similar ways as ELL does.
---
 src/shared/mainloop-glib.c   |  1 +
 src/shared/mainloop-notify.c | 81 ++++++++++++++++++++++++++++++++++++
 src/shared/mainloop.h        |  1 +
 3 files changed, 83 insertions(+)

diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 4403d02d8..a83c35482 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -37,6 +37,7 @@
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
+#include "io.h"
 
 static GMainLoop *main_loop;
 static int exit_status;
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 49ca4f6c9..81a2cef28 100644
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
 
@@ -46,6 +50,14 @@ static int notify_fd = -1;
 
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
@@ -129,3 +141,72 @@ int mainloop_sd_notify(const char *state)
 
 	return sendmsg(notify_fd, &msghdr, MSG_NOSIGNAL);
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
+static struct io *setup_signalfd(void)
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
+	io_set_read_handler(io, signal_read, NULL, NULL);
+
+	return io;
+}
+
+int mainloop_run_with_signal(mainloop_signal_func func, void *user_data)
+{
+	struct io *io;
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	io = setup_signalfd();
+	if (!io)
+		return -errno;
+
+	signal_data = new0(struct signal_data, 1);
+	signal_data->io = io;
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

