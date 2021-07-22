Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78455C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5966C60EB0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGVUXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhGVUXG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 16:23:06 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jul 2021 14:03:41 PDT
Received: from mail.heine.tech (mail.heine.tech [IPv6:2a01:4f8:1c0c:5073::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EDC06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 14:03:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FD5618287E;
        Thu, 22 Jul 2021 22:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.tech; s=dkim;
        t=1626987244; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=7xtrgocX4eKOY9Km77Rwz/psRsH9AjL47BAb3JJSf24=;
        b=DNZHGWrWnRSH0RRlT+6K54d4fSzCfpla/6C3k1OCJky5+w0RYJ1t6UdvFTjx2xyFdDWqwh
        2RZvcxyyBlMIhQgzuc8l5kPmLRjn+dXlAOsoqd3Pnr5vKtGxAW240L+UhJP7wQO4zsrWDe
        p9AESnw72rCStb7zWwNEUMz7FDXigkU=
From:   Michael Nosthoff <bluez@heine.tech>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <bluez@heine.tech>
Subject: [PATCH BlueZ] tools/mesh-cfgtest: include limits.h
Date:   Thu, 22 Jul 2021 22:49:24 +0200
Message-Id: <20210722204923.29735-1-bluez@heine.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

mesh-cfgtest.c uses MAX_PATH so it should include limits.h.

fixes compilation error with musl-based toolchains.
---
 tools/mesh-cfgtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mesh-cfgtest.c b/tools/mesh-cfgtest.c
index fa0474faa..116ab7f16 100644
--- a/tools/mesh-cfgtest.c
+++ b/tools/mesh-cfgtest.c
@@ -21,6 +21,7 @@
 #include <ftw.h>
 #include <getopt.h>
 #include <libgen.h>
+#include <limits.h>
 #include <signal.h>
 #include <stdio.h>
 #include <time.h>
-- 
2.32.0

