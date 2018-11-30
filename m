Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C9C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DD2146D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPfLEmKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629DD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeK3V3K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:10 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36457 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3V3J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:09 -0500
Received: by mail-lf1-f54.google.com with SMTP id a16so3710503lfg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0mWStA882Q3rupQZGd999wQpJB5prJ4Yn5kWqeL7y7U=;
        b=HPfLEmKCbAGpBNdx+kgxylNOB4Ncd4HIBpxX5aCeofavwa43/umxIo/IMVfApuZpYR
         slSIxZiy2+13XHSG6rSESr8DszFHAyvpfZfCWhQmH6F8SK5K8lAg/nyoK1HxqCCmuYX2
         /0OVtQ6CiNRHcxBfM4jcDK3CHINRjYFSrpZkdQVMIXInVyue0qq82VThAb/UIXEOgsLX
         j7u/x3CT2V8veXUpTHtT7BvbFiBvuhRLyIuKQ8gr4/3fz6gec2b2DPiyitZ7f//qjv13
         5g6lHXUfT27UcbZfOMkjzWCzYUXIxk3rpQZnG7gdfAZZBPHcM1tjT0Xj5lyZqghQAcVw
         kOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0mWStA882Q3rupQZGd999wQpJB5prJ4Yn5kWqeL7y7U=;
        b=mUyA4pl38U/R/CTGyvIcWadWaZUVyYcqN4NEnSXDXNswAlsJrXrgIhpbiljwFHDJoY
         CHmfF0e9bVOv1n5X3LpdxMiQhpT//B+0CaZoE61xO3yx9BEIhZ8Lofxugu9N7LZv9of1
         Pq7JDlXwdpzfTj2vs8ZFDMPgKOIn7OxsYcznS/mLcjHNtdQEsitQ3ooIeKPYuRx5YJE9
         lEMll4WPx6icOcN4SB1OhILuZ2DdIcNHaMVZBzDom66KKxi6sKR8HUAzKYPEIVjrVUmf
         u4sdJ7ZUO1TrZMD4wb43QvPXTKvxqNdzL6PrjEfxlL+eQEipy1phKgV/ZB1kjNZpRWfH
         hJfw==
X-Gm-Message-State: AA+aEWYNCjzcXefhKoykw8O/gMWgJcv19FfTu8HVwsK6a3UPcndVafGF
        /DckQ/FLSsrBs7fTsXYmHh4E1S1cY8A=
X-Google-Smtp-Source: AFSGD/W2+TJ7TJEP2HJKQFgX9hdehGxXFJB6qpc4WEK0ZOTIQl7BK7YpAuMfpQLz5MgqMamoJEzAzg==
X-Received: by 2002:a19:6806:: with SMTP id d6mr3165215lfc.48.1543573219059;
        Fri, 30 Nov 2018 02:20:19 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:18 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/10] tool/btmon-logger: Use mainloop_notify instead of sd_notify
Date:   Fri, 30 Nov 2018 12:20:06 +0200
Message-Id: <20181130102013.29023-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mainloop_notify takes care of sending the messages to NOTIFY_SOCKET and
includes the handling of WATCHDOG_USEC as well.
---
 tools/btmon-logger.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index c3ba17939..1a42824ee 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -48,8 +48,6 @@
 #include "src/shared/mainloop.h"
 #include "src/shared/btsnoop.h"
 
-#include "src/systemd.h"
-
 #define MONITOR_INDEX_NONE 0xffff
 
 struct monitor_hdr {
@@ -283,7 +281,7 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	sd_notify(0, "STATUS=Starting up");
+	mainloop_sd_notify("STATUS=Starting up");
 
 	while (true) {
 		int opt;
@@ -375,12 +373,12 @@ int main(int argc, char *argv[])
 
 	printf("Bluetooth monitor logger ver %s\n", VERSION);
 
-	sd_notify(0, "STATUS=Running");
-	sd_notify(0, "READY=1");
+	mainloop_sd_notify("STATUS=Running");
+	mainloop_sd_notify("READY=1");
 
 	exit_status = mainloop_run();
 
-	sd_notify(0, "STATUS=Quitting");
+	mainloop_sd_notify("STATUS=Quitting");
 
 	btsnoop_unref(btsnoop_file);
 
-- 
2.17.2

