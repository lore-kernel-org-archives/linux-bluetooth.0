Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01DC54FCF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3582072B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Cpx7MQs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDTMHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 08:07:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9436C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n6so6250311ljg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGG4/yjvuMH3FlIn0X+Fl1fHjCz3q6wAoOFCkN6ckTE=;
        b=Cpx7MQs8uUNpqY3C/kpzCDmBRbkFa69ZJgq+nZ/aZ1uxKI3evF8n1TRIKO3+MId/mk
         V60HgCXJ5BCGxCyVeisHwR3QJu+S3FZxA5DqyAQEaPIqk79IKep0uBbh4iyvwPg9/4eL
         JAvj8rZ9zVP4i76Uv3mlIXcZHiqXyBexFK4fa90apmZ9DaCgxDLI/BzKGXQbCsFRM6Ek
         qkP8CWeotd+kObIypEzZORyUshfQsJQtTo0yGmULdItVDio8d9vE48eBayk52+YKmTxs
         1IbEDMteX+TriN8Avm7U2As/MAzNV3TFS7Sr8n8MaFe/1fW0QvB5D6vOxpS1LdafIIjH
         fDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGG4/yjvuMH3FlIn0X+Fl1fHjCz3q6wAoOFCkN6ckTE=;
        b=Baxr88ysp2+bwHRzIFPXXW4JrQSA5TNVIe+C6xxceKGrRxTlWyXRg8EcsPTnGYYZ47
         b5mE9P4m3KHSCRhFKXTleJOpBIPJ7QHGcNm/vgRiikFwX1jGCVb9B5/ba7NwAy39AzFG
         pM1qYyRck9PxFKxTyGdzO5gS1Z4S1Q/GZJIhZmIvoSsmpw2q9Yd7Cb6tJRlMw0VBbwOl
         G9UKrQ0oMYYMB1jOkiWSnmcpj1NehfT+2C/XhAYQfBhR5+JSCwCRnTeE0tD0DN+lf7UP
         qNKULAhEdmj4MaBX9eYzZjYP7qkCIkp3PocFMScTZvYs/oHBYF0b8fMGIruxiG8opral
         QwLA==
X-Gm-Message-State: AGi0PuY/xkBaNzgM2W+HyPfv31KESpvOJhn1yD4j1pulTfPOkvN5ZZML
        zLCe9dlnva9eczdERpmGHGC9eWX97fs=
X-Google-Smtp-Source: APiQypKBnEbDSxSAnW9CX8zoHBTv5VixvfIdrMEoRdRfYj8UGCH9VXOEoCtgidmuMtYGZ2pLPLfNnA==
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr1664258ljp.186.1587384432835;
        Mon, 20 Apr 2020 05:07:12 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id i18sm666814lfo.57.2020.04.20.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:07:12 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 3/4] avctp: Fix compilation with GCC 10
Date:   Mon, 20 Apr 2020 14:07:04 +0200
Message-Id: <20200420120705.89691-3-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420120705.89691-1-szymon.janc@codecoup.pl>
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This one is a false positive but since we never use more than
UINPUT_MAX_NAME_SIZE bytes of name we can silence GCC by reducing
size of source string.

  CC       profiles/audio/bluetoothd-avctp.o
In function ‘uinput_create’,
    inlined from ‘init_uinput’ at profiles/audio/avctp.c:1259:20:
profiles/audio/avctp.c:1188:3: error: ‘strncpy’ output may be truncated copying 79 bytes from a string of length 248 [-Werror=stringop-truncation]
 1188 |   strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 37ffde9e7..058b44a8b 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1246,7 +1246,7 @@ static int uinput_create(struct btd_device *device, const char *name,
 
 static void init_uinput(struct avctp *session)
 {
-	char name[248 + 1];
+	char name[UINPUT_MAX_NAME_SIZE];
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
-- 
2.26.0

