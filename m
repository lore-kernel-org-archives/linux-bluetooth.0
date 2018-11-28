Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C34C43610
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED1208E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG2E+bzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECED1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeK2CCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39665 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeK2CCb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so22328388edt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=uG2E+bzf5FO/CJwcFOYZp4g2m8LmIHJrC7B9bEacQXNV61eFWdOMjm0XzFInfcvpRl
         oLaiu7xClBE6TE0L79sOXX6oDxTYJXn/bNxeUtnXmqQUiPWiLImGLbV6ZthamL90/SPH
         3ql1TfpxJ1dGTzLuA+L7B/0dHZOOWBFo2F/PK98hXgrdu+FogfHup2VCvlyCBcjj01/2
         Y60pwUIAN9XmyXmvClI1csPLW2Ww7W6wRzpj7104q8Jpv9k3W1acW6fy943ILz74QKkp
         0EpSEvbnUPhz3QY1fe4anArUi47x9Am7HYejw+RC9sTMGRRK1nlhGzQjnk832At0BiQL
         A9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=AtCx7EapHczElzpm+ofmlNpu9DYd10+IiQcavx5bxC8aUbiyDH8AYtWlbY5Oaokqzs
         VTMnnfq1lXz3v4jmywC6heYvotTQIc6LC7lW+a5mfFDTDDyOjQgiiFv+qfLzi+FSugek
         qQ/GrJCKA6gokpwTzouq/QGlAUk9OOjS1+1jHTKKi6QD6YybqPxkxtoOMdMDTunPOvDb
         Ht5FJgAGgxT7HJyafywaQx6vtcDmij9XZCuRkfQtEL1cjrAdUj5WidoY/bI0rP3GNRaA
         cuYuHGL/ew50yl3XBjkn8TH4jc35i3wwdqvzxdlhfI0yqI9Ebswcw3k01PSp6Jq3JI+3
         2aPQ==
X-Gm-Message-State: AA+aEWY+f1ZtBJ+fXPT5S3tQICLC6gVqpGhMiT1VmJY70FoEOLub273r
        kEM/8+3VJU9gx+Vra3uwsKVimk+r
X-Google-Smtp-Source: AFSGD/VxlevqSdaDA+77JOpPYKM793OqFOXJ6iOQUlVkhdEQllVedOoUrRq/ycBDPldysmB/K4rQaQ==
X-Received: by 2002:a50:f19b:: with SMTP id x27mr31281550edl.140.1543417233133;
        Wed, 28 Nov 2018 07:00:33 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] shared/timeout-glib: Check 0 id when removing timeout
Date:   Wed, 28 Nov 2018 17:00:19 +0200
Message-Id: <20181128150023.1576-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
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

