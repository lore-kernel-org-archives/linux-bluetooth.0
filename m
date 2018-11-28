Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC07FC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D282086B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuORMM2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D282086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK2CC0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33524 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CC0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so22369499eda.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=JiI4kDwnecUGQsOhDwUoJ7QFEIpLNIsj5bUtiZwwtmo=;
        b=YuORMM2e07Eg3Q/hom4meArSTueDCCnSCAGX5t2UCrysdahQZqcsVgPM9ifCpdQIyc
         B5gPRBiR4dAd3EsTMPrXa2J9v1gpvo0d+60ZMcJ4Tvfjv6h6Z4eENcOHwdnk2PBuu/NV
         nj92jb/M/quMJjUBwQu518aJzhomkBm4tcSf8B/8+v7kn1HKio+sAvgiMTmDWashi8KM
         SryByYgwU5BFG+4Zu4SBBdmgg8f7DRWU1CFy3j5KQ03uuvqXasHtjq596nXF8oWXegdz
         F+N0cy+t6mfjd2GyhhmNiY/SgZGSqeJdGkauLRmvnCwtTdg0P77/huRIV69nielrhPnn
         PCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=JiI4kDwnecUGQsOhDwUoJ7QFEIpLNIsj5bUtiZwwtmo=;
        b=FiA4fD7NOpXnVgA75NGga3jZ0V8iArNkzMdDRGy6vakRsuAimpGpTBdvbet6WnWinW
         iWWvj6pFn2qIm5datn0/URIgZuYnOAQIK9DlFGfHbo4ik7AVRfoBbNb5vQgkIqh7t/zA
         B4rR69O41DX7GXOuVd8y7io+1tRjHyvvUnxQ3cXyrWlB29b/VWXcofk562iCcSsoemv2
         Vrz9T9kDKrszaz7ZbCUSCJw5xrOSnQ46m5Na8vbLkP3eOpkg+fgCfIIxNxHXTnxx9tEg
         0b0zTOMgLgu7GTrhWcmlyKLPWLnphc+Jx4OzVxNFcHtFolOXjY/0uvwrXUPNDaKrPGka
         pGrg==
X-Gm-Message-State: AGRZ1gIayvWDA1aE2S/rgtMhMzFc8wC6G6o8aPEq5ysNbHrwESdJLnqf
        Z0yhODUnotFQ+3hBK9tOX01jjuH8
X-Google-Smtp-Source: AJdET5dRmsgIkhmw/vn2OXkroeWU3ha7E5x5oOAuAA3Ry7YAXYq1qweyCkok0l9JL/5dfa1kgWdV3w==
X-Received: by 2002:a17:906:94c3:: with SMTP id d3-v6mr27465055ejy.104.1543417226514;
        Wed, 28 Nov 2018 07:00:26 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] share/mainloop: Add handling of NOTIFY_SOCKET
Date:   Wed, 28 Nov 2018 17:00:14 +0200
Message-Id: <20181128150023.1576-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handling of systemd NOTIFY_SOCKET so application using
mainloop instance do properly notify systemd what is their state.
---
 Makefile.am                  |   8 ++-
 src/shared/mainloop-glib.c   |   6 ++
 src/shared/mainloop-notify.c | 104 +++++++++++++++++++++++++++++++++++
 src/shared/mainloop-notify.h |  25 +++++++++
 src/shared/mainloop.c        |  10 ++++
 src/shared/mainloop.h        |   1 +
 6 files changed, 152 insertions(+), 2 deletions(-)
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
index 8436969bb..4403d02d8 100644
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
@@ -72,9 +74,13 @@ int mainloop_run(void)
 
 	g_main_loop_run(main_loop);
 
+	mainloop_sd_notify("STOPPING=1");
+
 	g_main_loop_unref(main_loop);
 	main_loop = NULL;
 
+	mainloop_notify_exit();
+
 	return exit_status;
 }
 
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
new file mode 100644
index 000000000..81b0e15ba
--- /dev/null
+++ b/src/shared/mainloop-notify.c
@@ -0,0 +1,104 @@
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
+static char *notify_sock;
+static int notify_fd = -1;
+
+void mainloop_notify_init(void)
+{
+	const char *sock;
+
+	sock = getenv("NOTIFY_SOCKET");
+	if (!sock)
+		return;
+
+	/* check for abstract socket or absolute path */
+	if (sock[0] != '@' && sock[0] != '/')
+		return;
+
+	notify_sock = strdup(sock);
+
+	notify_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+}
+
+void mainloop_notify_exit(void)
+{
+	if (notify_fd > 0) {
+		close(notify_fd);
+		notify_fd = -1;
+	}
+
+	free(notify_sock);
+	notify_sock = NULL;
+}
+
+int mainloop_sd_notify(const char *state)
+{
+	struct sockaddr_un addr;
+	struct msghdr msghdr;
+	struct iovec iovec;
+
+	if (notify_fd <= 0)
+		return -ENOTCONN;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, notify_sock, sizeof(addr.sun_path) - 1);
+
+	if (addr.sun_path[0] == '@')
+		addr.sun_path[0] = '\0';
+
+	memset(&iovec, 0, sizeof(iovec));
+	iovec.iov_base = (char *) state;
+	iovec.iov_len = strlen(state);
+
+	memset(&msghdr, 0, sizeof(msghdr));
+	msghdr.msg_name = &addr;
+	msghdr.msg_namelen = offsetof(struct sockaddr_un, sun_path) +
+							strlen(notify_sock);
+
+	if (msghdr.msg_namelen > sizeof(struct sockaddr_un))
+		msghdr.msg_namelen = sizeof(struct sockaddr_un);
+
+	msghdr.msg_iov = &iovec;
+	msghdr.msg_iovlen = 1;
+
+	return sendmsg(notify_fd, &msghdr, MSG_NOSIGNAL);
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
index e6ab9c43d..d7200a837 100644
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
 
@@ -83,6 +87,8 @@ void mainloop_init(void)
 		mainloop_list[i] = NULL;
 
 	epoll_terminate = 0;
+
+	mainloop_notify_init();
 }
 
 void mainloop_quit(void)
@@ -180,9 +186,13 @@ int mainloop_run(void)
 		}
 	}
 
+	mainloop_sd_notify("STOPPING=1");
+
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

