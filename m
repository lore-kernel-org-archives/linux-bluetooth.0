Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624CC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59CF2145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgcN1eKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59CF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3V3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44319 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3V3H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so3688077lfe.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=u3h+sNI/i/dX6f0blZwp1ZVvMfx4rZwgdtYqbJSkUBA=;
        b=MgcN1eKOIQGRC0PYqdmGUXhbYjSovmeRLhvkfZE3DOTgmFRkYFaicmgzzuDwLG6lRS
         lvx8Oe/XOpgAxwzoWsCOeCG4vndkE/IrtR7CH45+hEJF9pykdKj15oBBQaLGb/zeMiDc
         F0MimB/TPhS8c+Bv+eOCS1LOoefb9okMnyXhRNs8JowLt6brJ+bA+7qV8r62fT9idmQT
         Qgt+mXLTU826qrretn94BBk8FZDIxhG8LUKzHAHUiaQD/7voqqgM84/y801ExReN7eLu
         E9809a/r6vhwhZTk50VTc9nQMkrwskCjFOUM6d3jiHMB3wXCJXegfwD0mut0z8GLO6K6
         rLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=u3h+sNI/i/dX6f0blZwp1ZVvMfx4rZwgdtYqbJSkUBA=;
        b=nekHFcNtvb5hyJdxk+sZrsVeXKVqzbLROK//3sH7/f7/nYh1imtILJlNMMFpcDow1G
         TscpL5E/H+1JpQq66gtO/9I2kiVPlKfopsLM9nSyH87qmaVMB+ZRzzpGLQP2sBa3oHkV
         Gs7jh1BQ9hHv6X9DOytRd44P5ZTLojaMjFh1TYoQ7fWEVBROvMrfn+rkVPZKETZROkZ3
         /Ohk1+aOvzJPh5I2DKdYPraHOAtWFMmqaQRA9PzzNYGsanLklMmH/T4TdKgZrY+Gnuta
         quJ33DTqann05COmgB13E3nSEdMJZzOBc5lQ5wqdYbzOULQuX6qzjh4czXKYNPYGQfcH
         WOgw==
X-Gm-Message-State: AA+aEWYeNGgPpMg2Cssg0bfAKLPEWEeAtxnlNXQaCc0V0fkgt+jz6T0U
        V3PU/exBaW3TawCOleubWvWJJtmLk9I=
X-Google-Smtp-Source: AFSGD/WRMrnH8kpjb+xwuAjTaHh1Dqv88sRMR8khfzs1v4j4BvI+M8IXEqYHxwWbsvo3A/uZhl9zMA==
X-Received: by 2002:a19:1cb:: with SMTP id 194mr3247585lfb.61.1543573216290;
        Fri, 30 Nov 2018 02:20:16 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/10] share/mainloop: Add handling of NOTIFY_SOCKET
Date:   Fri, 30 Nov 2018 12:20:04 +0200
Message-Id: <20181130102013.29023-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handling of systemd NOTIFY_SOCKET so application using
mainloop instance do properly notify systemd what is their state.
---
 Makefile.am                  |  8 +++-
 src/shared/mainloop-glib.c   |  6 +++
 src/shared/mainloop-notify.c | 93 ++++++++++++++++++++++++++++++++++++
 src/shared/mainloop-notify.h | 25 ++++++++++
 src/shared/mainloop.c        | 10 ++++
 src/shared/mainloop.h        |  1 +
 6 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/mainloop-notify.c
 create mode 100644 src/shared/mainloop-notify.h

diff --git a/Makefile.am b/Makefile.am
index 0b26ccc3e..124c32482 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -130,12 +130,16 @@ endif
 src_libshared_glib_la_SOURCES = $(shared_sources) \
 				src/shared/io-glib.c \
 				src/shared/timeout-glib.c \
-				src/shared/mainloop-glib.c
+				src/shared/mainloop-glib.c \
+				src/shared/mainloop-notify.h \
+				src/shared/mainloop-notify.c
 
 src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/io-mainloop.c \
 				src/shared/timeout-mainloop.c \
-				src/shared/mainloop.h src/shared/mainloop.c
+				src/shared/mainloop.h src/shared/mainloop.c \
+				src/shared/mainloop-notify.h \
+				src/shared/mainloop-notify.c
 
 if ELL
 src_libshared_ell_la_SOURCES = $(shared_sources) \
diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 8436969bb..42abfddf8 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -36,6 +36,7 @@
 #include <glib.h>
 
 #include "mainloop.h"
+#include "mainloop-notify.h"
 
 static GMainLoop *main_loop;
 static int exit_status;
@@ -43,6 +44,7 @@ static int exit_status;
 void mainloop_init(void)
 {
 	main_loop = g_main_loop_new(NULL, FALSE);
+	mainloop_notify_init();
 }
 
 void mainloop_quit(void)
@@ -51,6 +53,8 @@ void mainloop_quit(void)
 		return;
 
 	g_main_loop_quit(main_loop);
+
+	mainloop_sd_notify("STOPPING=1");
 }
 
 void mainloop_exit_success(void)
@@ -75,6 +79,8 @@ int mainloop_run(void)
 	g_main_loop_unref(main_loop);
 	main_loop = NULL;
 
+	mainloop_notify_exit();
+
 	return exit_status;
 }
 
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
new file mode 100644
index 000000000..fdc2f25ec
--- /dev/null
+++ b/src/shared/mainloop-notify.c
@@ -0,0 +1,93 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "mainloop.h"
+#include "mainloop-notify.h"
+
+static int notify_fd = -1;
+
+void mainloop_notify_init(void)
+{
+	const char *sock;
+	struct sockaddr_un addr;
+
+	sock = getenv("NOTIFY_SOCKET");
+	if (!sock)
+		return;
+
+	/* check for abstract socket or absolute path */
+	if (sock[0] != '@' && sock[0] != '/')
+		return;
+
+	notify_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (notify_fd < 0)
+		return;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, sock, sizeof(addr.sun_path) - 1);
+
+	if (addr.sun_path[0] == '@')
+		addr.sun_path[0] = '\0';
+
+	if (bind(notify_fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(notify_fd);
+		notify_fd = -1;
+	}
+}
+
+void mainloop_notify_exit(void)
+{
+	if (notify_fd > 0) {
+		close(notify_fd);
+		notify_fd = -1;
+	}
+}
+
+int mainloop_sd_notify(const char *state)
+{
+	int err;
+
+	if (notify_fd <= 0)
+		return -ENOTCONN;
+
+	err = send(notify_fd, state, strlen(state), MSG_NOSIGNAL);
+	if (err < 0)
+		return -errno;
+
+	return err;
+}
diff --git a/src/shared/mainloop-notify.h b/src/shared/mainloop-notify.h
new file mode 100644
index 000000000..721b5fbed
--- /dev/null
+++ b/src/shared/mainloop-notify.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+void mainloop_notify_init(void);
+void mainloop_notify_exit(void);
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index e6ab9c43d..e9ec6e8cd 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -30,13 +30,17 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/signalfd.h>
 #include <sys/timerfd.h>
 #include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
 #include "mainloop.h"
+#include "mainloop-notify.h"
 
 #define MAX_EPOLL_EVENTS 10
 
@@ -83,11 +87,15 @@ void mainloop_init(void)
 		mainloop_list[i] = NULL;
 
 	epoll_terminate = 0;
+
+	mainloop_notify_init();
 }
 
 void mainloop_quit(void)
 {
 	epoll_terminate = 1;
+
+	mainloop_sd_notify("STOPPING=1");
 }
 
 void mainloop_exit_success(void)
@@ -183,6 +191,8 @@ int mainloop_run(void)
 	close(epoll_fd);
 	epoll_fd = 0;
 
+	mainloop_notify_exit();
+
 	return exit_status;
 }
 
diff --git a/src/shared/mainloop.h b/src/shared/mainloop.h
index b83caabc8..73ed81187 100644
--- a/src/shared/mainloop.h
+++ b/src/shared/mainloop.h
@@ -49,3 +49,4 @@ int mainloop_remove_timeout(int id);
 
 int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
 				void *user_data, mainloop_destroy_func destroy);
+int mainloop_sd_notify(const char *state);
-- 
2.17.2

