Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E09C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FB620832
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNBTcC8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FB620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeK2CC1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36737 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2CC1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so22369112edb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ME10onneWLlhCofm5WP7Z5Gpdz9mEtMZSKNZM4kptVw=;
        b=CNBTcC8aSDthJR+kXNM9j9rAKfoM9cg5ffVNcVe6+focStYf2Ej0TAPYuDacYRg/3R
         DLFyZNEfEJEwd3VGbb5/K0hBcPWh/WHOPew2nH6nhQYu0nzK6DMIONgYNB601nRYjfjo
         UGXFF3Ge9TQoatTOb1zacdrDEiTweHMUys7dwPlpzy8nBGG6H6q7fwhIiXosfAvOoNkf
         xBCzTw5WgSJIuUGLAi74Jk4vvV4FgQ/wZeGuwR1N8vDTmRBxcRH3E0BxAfa7u6oB+Y8g
         jf+POpEVpJCZvvKzmp8QFDs+H/KPDEHngqILQBq7EUMXF39OJnGxvwx15uAXALxL4/Jc
         0idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ME10onneWLlhCofm5WP7Z5Gpdz9mEtMZSKNZM4kptVw=;
        b=mzdkrucslRZYmXyEFB08l8b/KDRRvlMsLZN+hfLU+KKckJBQn5CQ99jkoJLSvzUBVx
         zBIzdD7PhN9mdBYB+CJzD+1j8YOrL2Q1MkeSx65FXCHPsOJ1IHZXklzJV+EASPK5/bZk
         vU49sutHvqVDXHC2bM5R7ezdajpmSijJglQ6FC5flh1VpwhCDb7saReitFUmcTnZuViz
         2sbaDs4ttJAKUhlPxBBayvdmX6sLtvsBjD3aqJbngJ6AHAbTQcVuWiGxOUsqQsf+1gqd
         kWn1ORmLNw++F4fbHpm3CijnVXTO4RH1acCfWz+hvXOzYi7iDUyXvIUb7MFRlug6k+CY
         Yk/w==
X-Gm-Message-State: AA+aEWaWQfbYjr6WYGV3vclb89jLtTX04EU9cYI7Ilq2OlmA/HKBve56
        oAXfNh8cF33wsV8Cy7TBJkbWGFiM
X-Google-Smtp-Source: AFSGD/VSY6DbrrTMXGyQnL8aawNJGDyuZ0oQPJ1PvME/qEej2VovObAKY75o5Gm3fIVaQ//Jke9Tpg==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr31880510edm.172.1543417227978;
        Wed, 28 Nov 2018 07:00:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] share/mainloop: Add watchdog support
Date:   Wed, 28 Nov 2018 17:00:15 +0200
Message-Id: <20181128150023.1576-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
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
index 81b0e15ba..49ca4f6c9 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -37,13 +37,27 @@
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
+#include "timeout.h"
+
+#define WATCHDOG_TRIGGER_FREQ 2
 
 static char *notify_sock;
 static int notify_fd = -1;
 
+static unsigned int watchdog;
+
+static bool watchdog_callback(void *user_data)
+{
+	mainloop_sd_notify("WATCHDOG=1");
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
+	watchdog = timeout_add(msec / WATCHDOG_TRIGGER_FREQ,
+				watchdog_callback, NULL, NULL);
 }
 
 void mainloop_notify_exit(void)
@@ -67,6 +92,8 @@ void mainloop_notify_exit(void)
 
 	free(notify_sock);
 	notify_sock = NULL;
+
+	timeout_remove(watchdog);
 }
 
 int mainloop_sd_notify(const char *state)
-- 
2.17.2

