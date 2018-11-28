Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC92C43610
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232E020832
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am0JCL9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232E020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeK2CC2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:28 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34671 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CC1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:27 -0500
Received: by mail-ed1-f41.google.com with SMTP id b3so22362274ede.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0mWStA882Q3rupQZGd999wQpJB5prJ4Yn5kWqeL7y7U=;
        b=Am0JCL9a1NXg4+RJpiq1UtufM/l0RL/iNwDNiR4g/1MnXLjwxQymzOSaBCAyKJ0NYJ
         HkO23SLI4yJow9Wj9CMyje3NsxUqLfAN2lCfqyoR0jLFwwjHEMbX6XV0WQRPNtOZFTDr
         RhEs6s+RIQ5S3apck1ns6ZnKiseofvZcAcIOQVSHmOXe0Kg/D/zb3h0fPcOg/1v8ohPf
         olowgrG8NiM+KJhhDJ4WW8PbLlBukPWAxHvTx670qxKvf9KVwv3ySxQTLSYjj5n1A4qB
         lUda1TyC2TzY5swGoewZCpLQnXcN3SXZ+qI0bH7DE36oTX1/RUwLKX6sM1k3t2V6Etc1
         RAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0mWStA882Q3rupQZGd999wQpJB5prJ4Yn5kWqeL7y7U=;
        b=ddINDBF6yB/x2jErlzSSWUL0hE8DiVs5UWD2wYDEr8SvJMG6714PYLN2OwYorkX1pt
         lklnhNpFwPVnk4MfduQvBfmyW0Vc/a0TzWZYO+IUR7AplaSzOwBCFLbLdAjG3xOEOZ6o
         hMuE/7zi6P9/yc3QzvEC3SGdJLQvI0YPg9Curzv2P0f+QwU7qSRBcl6qLTPf/xOfJvAb
         NDnw8AxjAVFwUNozOjrI50bxAGKCKDkXNP1VxEfWAkFFMGmELBwdBVdLN+gpgfGA+WnG
         0J24cbCdMISb/cGmn5PQpuM3RX0mDdqjIUqgFOhTk7hA2xI+UU842+i0j5QsD50CNX3d
         NNLQ==
X-Gm-Message-State: AA+aEWbsyOv7DQPpXm47nmQnr4pxG8wOtWQHpdzFGC9CeTcEP22TLsxB
        S5QxDhilQVj/5SaYNWITD4lC6C0H
X-Google-Smtp-Source: AFSGD/WPKI2OtdNUduOsP318xVCPBzYI91woRJOmv3/pjesnT0T/IsaddEakImMPyZYY3PMNa3EXRQ==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9-v6mr20677916ejh.236.1543417229236;
        Wed, 28 Nov 2018 07:00:29 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] tool/btmon-logger: Use mainloop_notify instead of sd_notify
Date:   Wed, 28 Nov 2018 17:00:16 +0200
Message-Id: <20181128150023.1576-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
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

