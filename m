Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12472C43610
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048D20664
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/rjo4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C048D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeK0DTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:19:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34001 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0DTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:19:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so17164237ljd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=d6sryCCzo/e2SxDQ07TFHKqho61B/5kVGp9hdcuvb5o=;
        b=mH/rjo4T+oeyIbrQuCpBazQUD0DOtnxV3fM++Wq/Fqd+ZXTZHQl0mzXwMEBQHtbxlz
         GY3/0wWdhe6pefm8SUnG0TB+Ea95nfWFylt+dUjBEjaYZy+2Q0+ry0PZrpK0htLZO1ov
         sOreYgke7l0J2X3Q6zLmb32Nu22LfHROi+T0jJGknGkRrjTP/70wedD8r/S2CWOxBHVY
         g1HiQ+HP+cSfKmN7B2oFFgOXxYwmFzbAVxHqX6wivVlyrYLym/pxSUJS7qPhey/atCbn
         wXDHi4SZpeg/lI/NhGVo9MLT/KwgoZI5aR3N6/DA1FSX/64Ha9Wc8iXhiRqTxaeMCwWV
         SVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=d6sryCCzo/e2SxDQ07TFHKqho61B/5kVGp9hdcuvb5o=;
        b=gPx92QLbiBzD4k7C4lpvGv9Cg8arQZvrXJj+WqepoN/SRAN8dtZvQ3o6zhOmuAQsgl
         gC0CkTpQmh/Xhyujvvf7dsWmaUBBIl2hdMaJuB8rBwJ92+cfpmyV5YtWR+vVnu/im+2W
         GL0hZyIWONHUPHtvQrDOQ/z2G9JVBTATZ9EVcb1fhCN+iObD8aIzB04/H4v6qoXsuzVm
         h5D2umFBVYsaKmkWykCB9rWLtiL2Z5tD4sbWpiodJPtqBsJPAZHWwoGRCHEKhjbfchih
         WjE/L8FbjbfXk82Auhg8HTTxT2AJHfguehL+au68eFqFZJf3ZjNMQXDTOvdU5SLqlxNH
         /LBg==
X-Gm-Message-State: AA+aEWbopZzYbHZKu8KuooPTstKVqiEXs8Kz7J/k0iAZsD6hNnMrvhfq
        eRLxXLSEPoPmD/bLw2D1hejGcqEC
X-Google-Smtp-Source: AFSGD/UzRFDo2NbGYNa0LCFWeIs6QBG2Ay1u8i5iHBqYwujjvLAhDGZ28WXBHT6m62GAM0FuzB2TTA==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr17935285ljs.118.1543249483534;
        Mon, 26 Nov 2018 08:24:43 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id g70-v6sm120787ljg.92.2018.11.26.08.24.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:24:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] tool/btmon-logger: Use mainloop_notify instead of sd_notify
Date:   Mon, 26 Nov 2018 18:24:35 +0200
Message-Id: <20181126162438.27872-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126162438.27872-1-luiz.dentz@gmail.com>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mainloop_notify takes care of sending the messages to NOTIFY_SOCKET and
includes the handling of WATCHDOG_USEC as well.
---
 tools/btmon-logger.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index c3ba17939..65c497dbb 100644
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
+	mainloop_notify("STATUS=Starting up");
 
 	while (true) {
 		int opt;
@@ -375,12 +373,11 @@ int main(int argc, char *argv[])
 
 	printf("Bluetooth monitor logger ver %s\n", VERSION);
 
-	sd_notify(0, "STATUS=Running");
-	sd_notify(0, "READY=1");
+	mainloop_notify("STATUS=Running");
 
 	exit_status = mainloop_run();
 
-	sd_notify(0, "STATUS=Quitting");
+	mainloop_notify("STATUS=Quitting");
 
 	btsnoop_unref(btsnoop_file);
 
-- 
2.17.2

