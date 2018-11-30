Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8948BC65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443EE2145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/A0eW9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443EE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeK3V3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:08 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40570 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeK3V3I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:08 -0500
Received: by mail-lf1-f52.google.com with SMTP id v5so3697704lfe.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yOoGU4G6G/yN25yc9JsJyYEQgLXFUCV6qi4F1n+/MUA=;
        b=f/A0eW9OXjCgAcqGqC+6l2yYkPQuDebO84WymShRlKB3CAjfoH3MI1xjAdYVI1f+xY
         Tw49YolqmkPM3R386U+H2SLcFn0JyEloAfmeQN08PJMMlzUhOaVNdhdw9o+1BN9EmK6D
         9DaIeiqBZQ8/L/ED8TO7vw9FibM0mM2oqcqhoGUgDJ6dBueCDySf3S/bRYIJtyaWcW+M
         4SZ8MBE4iaqvTtYLVQQbKrE+jDUzqy6cZUulT0DypXWhVgZIzuhk5+IOy2TNCcBxISYn
         d/C03mHKOwACUQXMHkcrMjiXmDvax75qU6nek3q1rgxTqtZtPRlfCPhJDp3SInWS071D
         jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yOoGU4G6G/yN25yc9JsJyYEQgLXFUCV6qi4F1n+/MUA=;
        b=mPqv1VSCPEf/tPEZSXhM7JQMGaUSpmsmHWGQuDy0yv2bjk7i11QgYm6Z0yqssqdOkW
         bMl17cKM7AZF+XHwSUwhCARe0QQZf/TVK6tUMDEj7M6Z/Xj9X/0t93UhjMLT8Yks1O6i
         bD/XXEBsjoMhhMZKLZnOxUCs96d1MNii9kmhMFZJT466MV5p8t6zMvtXzsUmBOYUShPk
         ALJf7FeNnUbK2SEHuO/NPtssN38YnKzKbfyjjI3UAAhTvNnef4G7WWVAo/Zn4o3E9p/I
         f2eNFvuhncvdrh8+uUZfAyYiRDq/C9RkzXAlCNqolQfRPmfuogo34NAKJckg1mvAur1y
         nYpQ==
X-Gm-Message-State: AA+aEWbifybtbtTI2IiNBKZVpV0WMz9zaCOAPLL8E35HpTvLzqIdYfCb
        B+d6nGrpu38k+pcUPtYVYlMLiYtbeAc=
X-Google-Smtp-Source: AFSGD/XgKkejuB0DP3rM/u4vO7s67pSn7xwssTllUIrgfUT0thNdgz2NlhU7sueAuhpXA4vKU9MbMw==
X-Received: by 2002:a19:aace:: with SMTP id t197mr3187786lfe.7.1543573217919;
        Fri, 30 Nov 2018 02:20:17 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:16 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/10] share/mainloop: Add watchdog support
Date:   Fri, 30 Nov 2018 12:20:05 +0200
Message-Id: <20181130102013.29023-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds watchdog notification support by sending "WATCHDOG=1" twice
as frequent as required by WATCHDOG_USEC.
---
 src/shared/mainloop-notify.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index fdc2f25ec..2e3b08f06 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -37,13 +37,27 @@
 
 #include "mainloop.h"
 #include "mainloop-notify.h"
+#include "timeout.h"
+
+#define WATCHDOG_TRIGGER_FREQ 2
 
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
 	struct sockaddr_un addr;
+	const char *watchdog_usec;
+	int msec;
 
 	sock = getenv("NOTIFY_SOCKET");
 	if (!sock)
@@ -67,7 +81,19 @@ void mainloop_notify_init(void)
 	if (bind(notify_fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		close(notify_fd);
 		notify_fd = -1;
+		return;
 	}
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
@@ -76,6 +102,8 @@ void mainloop_notify_exit(void)
 		close(notify_fd);
 		notify_fd = -1;
 	}
+
+	timeout_remove(watchdog);
 }
 
 int mainloop_sd_notify(const char *state)
-- 
2.17.2

