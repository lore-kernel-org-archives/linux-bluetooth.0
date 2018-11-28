Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584DC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A301321104
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOLBpROS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A301321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeK2CCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46833 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CCa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so22293495edt.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=g6sefQQGqWf0sNzDHIx3/xmJOVDB4Nf8s92vAHKX6Go=;
        b=FOLBpROS3AY4hIlgzkc8shVHo44w9vvMoAt0/M7jZ52Nuxd8n5lMwCih9UCRbyb2EL
         PBlpr5ENHkdKbymIybAqLaeqoCR8n6Tm7ds4HYTIVwUhcRPrSR/ggkr7wNwubxZlPfYM
         /7ripe+A9SPp3UhSYnSvx5b7lNjH/3Qi4wSj8mF7DP11p5YAbWGuFXKId5g4NXJ/f80r
         wz3cN0zjynclZVny7VYPxKqSSlgArJr68UdEm7Z6FwvgEi7HtYkFgcan5XGDdg+y9bWa
         T0iPqBfsIFCS1Merv9GYuvFi1QCe3V0VW5HNmshR+Iy9LSFqdB7sFBOeK2iyMSM+go59
         3R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=g6sefQQGqWf0sNzDHIx3/xmJOVDB4Nf8s92vAHKX6Go=;
        b=egq1kVZuxn2vvl9RXMEs+ZlBFq9sTGrX3QL360roIbeHdEnA3x5k6AOX74mXs4VeIE
         69Mp49K10YrBYHVkOM1fpF4CWhJ8y0MjyOneSl9XRSXF+frLVGwrUJ/Tq3UZCXw/k3QU
         aYso/Jex0STQAR4gkRm5ImFnTCZFUHWIk1rG0NeFey2ExhQaXNSlQfO4jefbq7bKNP43
         +TYLBX3N1HXArMyxumzY72lt6Lyk1tEnS2uOwGdwLyRx/aC/W9YccMZLMqA1ty6EVpeQ
         /SCp8KPc1I9HffwTgEfg8wAHsUml+QOqd7y7znWUfd5Y35WKnpYkucLWDXInfTeMa8WJ
         TtgA==
X-Gm-Message-State: AA+aEWbQFsTleZT3crO4xxINhKSRQo45iu48IHTBfOqYa2YMR3uiBS5K
        mc+pdmm5H+UDbOIiDFJEqCKWISxW
X-Google-Smtp-Source: AFSGD/WiNu1EDKX9Mw1IWoUUlVCEYMnBjfsJBgeF85sPuwD6110nTdqMv/RwGN4nPY8V6icuYLf1jA==
X-Received: by 2002:a50:8c04:: with SMTP id p4mr2757100edp.274.1543417231994;
        Wed, 28 Nov 2018 07:00:31 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] core: Remove old code related to sd_notify
Date:   Wed, 28 Nov 2018 17:00:18 +0200
Message-Id: <20181128150023.1576-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is no longer needed since mainloop instances can handle it now.
---
 Makefile.am    |   1 -
 Makefile.tools |   2 +-
 src/systemd.c  | 107 -------------------------------------------------
 src/systemd.h  |  28 -------------
 4 files changed, 1 insertion(+), 137 deletions(-)
 delete mode 100644 src/systemd.c
 delete mode 100644 src/systemd.h

diff --git a/Makefile.am b/Makefile.am
index 124c32482..a69baea10 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -185,7 +185,6 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
-			src/systemd.h src/systemd.c \
 			src/rfkill.c src/hcid.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
diff --git a/Makefile.tools b/Makefile.tools
index 35412ca61..d3d901bc9 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -46,7 +46,7 @@ endif
 if LOGGER
 libexec_PROGRAMS += tools/btmon-logger
 
-tools_btmon_logger_SOURCES = tools/btmon-logger.c src/systemd.c src/systemd.h
+tools_btmon_logger_SOURCES = tools/btmon-logger.c
 tools_btmon_logger_LDADD = src/libshared-mainloop.la
 tools_btmon_logger_DEPENDENCIES = src/libshared-mainloop.la \
 					tools/bluetooth-logger.service
diff --git a/src/systemd.c b/src/systemd.c
deleted file mode 100644
index 0a4b35d06..000000000
--- a/src/systemd.c
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stddef.h>
-#include <string.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-
-#include "systemd.h"
-
-int sd_listen_fds(int unset_environment)
-{
-	return 0;
-}
-
-int sd_notify(int unset_environment, const char *state)
-{
-	const char *sock;
-	struct sockaddr_un addr;
-	struct msghdr msghdr;
-	struct iovec iovec;
-	int fd, err;
-
-	if (!state) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	sock = getenv("NOTIFY_SOCKET");
-	if (!sock)
-		return 0;
-
-	/* check for abstract socket or absolute path */
-	if (sock[0] != '@' && sock[0] != '/') {
-		err = -EINVAL;
-		goto done;
-	}
-
-	fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
-	if (fd < 0) {
-		err = -errno;
-		goto done;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-	strncpy(addr.sun_path, sock, sizeof(addr.sun_path) - 1);
-
-	if (addr.sun_path[0] == '@')
-		addr.sun_path[0] = '\0';
-
-	memset(&iovec, 0, sizeof(iovec));
-	iovec.iov_base = (char *) state;
-	iovec.iov_len = strlen(state);
-
-	memset(&msghdr, 0, sizeof(msghdr));
-	msghdr.msg_name = &addr;
-	msghdr.msg_namelen = offsetof(struct sockaddr_un, sun_path) +
-								strlen(sock);
-
-	if (msghdr.msg_namelen > sizeof(struct sockaddr_un))
-		msghdr.msg_namelen = sizeof(struct sockaddr_un);
-
-	msghdr.msg_iov = &iovec;
-	msghdr.msg_iovlen = 1;
-
-	if (sendmsg(fd, &msghdr, MSG_NOSIGNAL) < 0)
-		err = -errno;
-	else
-		err = 1;
-
-	close(fd);
-
-done:
-	if (unset_environment)
-		unsetenv("NOTIFY_SOCKET");
-
-	return err;
-}
diff --git a/src/systemd.h b/src/systemd.h
deleted file mode 100644
index 0ef7c82a9..000000000
--- a/src/systemd.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#define SD_LISTEN_FDS_START 3
-
-int sd_listen_fds(int unset_environment);
-
-int sd_notify(int unset_environment, const char *state);
-- 
2.17.2

