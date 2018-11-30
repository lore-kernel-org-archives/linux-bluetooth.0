Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB419C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C072145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeJzyiKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C072145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeK3V3O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:14 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36457 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeK3V3N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:13 -0500
Received: by mail-lf1-f48.google.com with SMTP id a16so3710658lfg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=CeJzyiKSbG11YSy3dl5mXgPml09mwgsU+1jK/6KcdOhW3Ud5pPC2N9+L8lqT6MTTCI
         rfhjSDS6xHv2/xtiP5embBZEP233gaZmfoAImBXnkrQUaTgHRaa3NtgEi+X9XG77zAUA
         Fvkt1+QBE8im/Kz8tHe+KihHtt3PJcMqxyllWvIF3t8tAqkxoUYbkulgL/9/dSRXdMLC
         NHhL5hNDk6VfO9Sm4aNXRJLaHwzSyVPHoOANA93AR2eO5fNGkZ3qEDqK6GxXgu1iPb40
         65ndrZXjyhrob//OizoI1QMYALJ+WYFeEBg4oOWBZo5Dg8dhfyyZa3AGFE0autnvjJV5
         qUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=UZfOoBjkD8rnwmPTZ6Xo1HlfXJ22c2px7nKdF3Da28J8BSDp6w32EuQAvvAKCjY6Tu
         hklMcYc2xnApOMWS6Qk+p+l2M3lwBNUyXl5u8yuYTYikrNU2HzW5edHQDRA+ezfSLprX
         XSmR9eVBJwkNU4JcDOC41HEY2zwUc4xgeT39WeeDHBHvR/OsottqcyAqASVBQ/IZutzW
         vtqXRfyTXGK1heCLUdr0f6zWnKkXOEVn7MJMUKhy+ZCoFNPFY7XMaHbMD58UOkjyoHaL
         NIN3itZA53Dt5gAn9k8nOQf8iuMwuYAXE4MSJKWW8m0JYu7lXDi6yiG6LrR1tu8vVfES
         RLQg==
X-Gm-Message-State: AA+aEWZcaqxsvFLYxxMTC5tvZ+XCNV56kQjQ0O4p7KYLGjFyhhfG5DEk
        JUXelZPHTijt07yicAQhR7j+yUKZQn4=
X-Google-Smtp-Source: AFSGD/V4TU+I4McyRwshi8+PE3+ByoBqLwECvd+hzyYLBq3wV6KYoyWcj4qqaw/sp/mo7Nj2mLgXsQ==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr3129269lfc.47.1543573223098;
        Fri, 30 Nov 2018 02:20:23 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/10] shared/timeout-glib: Check 0 id when removing timeout
Date:   Fri, 30 Nov 2018 12:20:09 +0200
Message-Id: <20181130102013.29023-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the id is 0 that makes it is invalid already.
---
 src/shared/timeout-glib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
index 4163bced7..fd71ca430 100644
--- a/src/shared/timeout-glib.c
+++ b/src/shared/timeout-glib.c
@@ -71,8 +71,12 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 
 void timeout_remove(unsigned int id)
 {
-	GSource *source = g_main_context_find_source_by_id(NULL, id);
+	GSource *source;
 
+	if (!id)
+		return;
+
+	source = g_main_context_find_source_by_id(NULL, id);
 	if (source)
 		g_source_destroy(source);
 }
-- 
2.17.2

