Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1FDC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DF660F02
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhGWHbc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:31:32 -0400
Received: from mail.heine.tech ([195.201.24.99]:38408 "EHLO mail.heine.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHbb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 03:31:31 -0400
X-Greylist: delayed 40680 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 03:31:31 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE33218287E;
        Fri, 23 Jul 2021 10:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.tech; s=dkim;
        t=1627027924; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=lNGO98eKLTVbPOW7v/19BUw7k+abndJKGzqx5VrbiZg=;
        b=KlMrZaRp4J4hnAc90aNSpDIskQvkgwpk7KUULtlEn/U7p1IDv78V+3WukGFmc+b9akcGx/
        BksCf9ENGGWbbeVSvxD22vBaDoUkGlDoWkrxbyr0qauLINVUZK1e/uFr7w32y45Go/0NzP
        rWpFBB+znNr3EyQeXZtgWsMBWHzYlPk=
From:   Michael Nosthoff <bluez@heine.tech>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <bluez@heine.tech>
Subject: [PATCH BlueZ v2] tools/mesh-cfgtest: include limits.h
Date:   Fri, 23 Jul 2021 10:10:40 +0200
Message-Id: <20210723081039.30396-1-bluez@heine.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

mesh-cfgtest.c uses PATH_MAX so it should include limits.h.

fixes compilation error when enabling mesh support with musl-based
toolchains observed in buildroot autobuilders.

http://autobuild.buildroot.net/results/20cc47f54de0b0d4bdf108c3715c590ae8ab476f/
http://autobuild.buildroot.net/results/003968b25906579dbcf5a95d1e43fec0ab504ef5/

---

v2:
 * use correct identifier in description
 * add links to failing builds
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

