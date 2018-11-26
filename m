Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFAC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6F120862
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWKQGUH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6F120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeK0DTT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:19:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37121 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0DTT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:19:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so17170973lja.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=48OphCe2+oC+yDdWhZmjruXfXcENpYxibjnmew9VZ84=;
        b=CWKQGUH5rjLIxFTIGC/JI3/vpudEJu9zoLZ9nqHklhwtX9kXqiG3mVj/CjyzsNHuMK
         AvFi2vpgPXEaD8yQP5kX847ETCnE8N105i+v4eQ/CcXqINy8vsSbSpxxBGnHoM+4EHwV
         VGDJULN4s5eKeB6GoKJHKaBNKxc6un7i8yl1Ge8m7sQ9/i0x+LdJ7HvszFWLEgDvRQfL
         p4lsN2/XmR8qCjPrvMPXaEA1aJblUKy4ga/hP456DZrSgt5c4pxqrg3daB/0jEhpXBax
         ooqLQURP47hlb3FFhIk2jTyPovFKiOUtEIGqYIsVvO++RRnzD5LJohsOgh/v7cdtRc4I
         MHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=48OphCe2+oC+yDdWhZmjruXfXcENpYxibjnmew9VZ84=;
        b=LWsPjtmWu9LWYYPT2zTK1jwBpS9+L3+HOFZdnT3GmsEKW/ciusLNc8l5+YmRvLGNha
         Qec48gaXYNlgDDWtATmUl9EIsFoD7BAQq/hVwYV70SRIdDOxngduwVwfzCGpy6WkfhGq
         6gB25p3agACOhThmVcx6IRtOY1t8drk8zvFB4oUjm95DGEG+q9VXZy3QtnR75RuPtXud
         KhRdVuGDV6WDdAI/Js8dn+SYMJni9kg/aHLhD/wrLJBafYnJPeD3jdOJ0sIGqXex//tB
         Ldx1STPkfPD/o889ZYaqn7TB6ygqUu05vlJkRtBinBnKBN+f1cV8hsa9oiuZrQfg0sjr
         aAjQ==
X-Gm-Message-State: AA+aEWa1shHqipDaqwg8kgFLSS0Mshr3fGB3KTD+v1Jods7CvA0WRq0m
        XJKqMP70VM9Af2ehEvtvMaTImwzK
X-Google-Smtp-Source: AFSGD/UUoSqA71HpACrr7WVfVGOkJ376s6WijOsYyi6zJAK7BbC/cFWoMlbLijEpCYf+ou3w56JWHw==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr17185368ljk.76.1543249482295;
        Mon, 26 Nov 2018 08:24:42 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id g70-v6sm120787ljg.92.2018.11.26.08.24.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:24:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] share/mainloop: Add watchdog support
Date:   Mon, 26 Nov 2018 18:24:34 +0200
Message-Id: <20181126162438.27872-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126162438.27872-1-luiz.dentz@gmail.com>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds watchdog notification support by sending "WATCHDOG=1" twice
as frequent as required by WATCHDOG_USEC.
---
 src/shared/mainloop-notify.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index fef333c24..cb895086f 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -37,13 +37,27 @@
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
+#include "timeout.h"
+
+#define WATCHDOG_THRESHOLD 2
 
 static char *notify_sock;
 static int notify_fd = -1;
 
+static unsigned int watchdog;
+
+static bool watchdog_callback(void *user_data)
+{
+	mainloop_notify("WATCHDOG=1");
+
+	return true;
+}
+
 void mainloop_notify_init(void)
 {
 	const char *sock;
+	const char *watchdog_usec;
+	int msec;
 
 	sock = getenv("NOTIFY_SOCKET");
 	if (!sock)
@@ -56,6 +70,17 @@ void mainloop_notify_init(void)
 	notify_sock = strdup(sock);
 
 	notify_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+
+	watchdog_usec = getenv("WATCHDOG_USEC");
+	if (!watchdog_usec)
+		return;
+
+	msec = atoi(watchdog_usec) / 1000;
+	if (msec < 0)
+		return;
+
+	watchdog = timeout_add(msec / WATCHDOG_THRESHOLD,
+				watchdog_callback, NULL, NULL);
 }
 
 void mainloop_notify_exit(void)
@@ -67,6 +92,8 @@ void mainloop_notify_exit(void)
 
 	free(notify_sock);
 	notify_sock = NULL;
+
+	timeout_remove(watchdog);
 }
 
 int mainloop_notify(const char *state)
-- 
2.17.2

