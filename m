Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA3C25B47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Oct 2023 05:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0Fyd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Oct 2023 01:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Fyc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Oct 2023 01:54:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2701A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 22:54:29 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 36E2F3F67E
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 05:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698386067;
        bh=7qt60tzR0dp2LNxB7cAs92LC2Rjy+ydVBOnQqrAetiE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hzKx72aedfEh+TteDdC9CG2i8hxtMNkYQ0YT6NdD0/8Qj1GZnuWrgdV6V4EfYtAZ8
         baxRFSDK6Kanugwsc3tZlCK1bfU8up3cMGfZxas0jQtZAyox07Ir6Wt3TKKFMCsqcd
         4Hrq6xGn0Dev2WMTpY5qJwQOslWoHAbodgCpZAlbEznqOCk03JkbgOOjM2AExgSbbx
         32I36l/ysFd7sXqtuZ7R5+Cu3kZtBKC5JhD61sWQg9qK/4uR1m9E03TUAOMJ3mLGKj
         MQsJeoJ/l55v5ZmH7PLCvTCeGM4dCOwjT7Sfi92GKH8NXqM9FQg6krnCUQFi9wDlc7
         h4impu98XPAxw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53db0df5b7cso1286900a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 22:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386067; x=1698990867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qt60tzR0dp2LNxB7cAs92LC2Rjy+ydVBOnQqrAetiE=;
        b=oSZmfrvk/ZnMdPGiEzccPGPGn3TckYJ+ZrJ3Y+tjx0Vxob6WMWDXginYt84HmnvmcW
         N1OyZXq+RI8l2lryRu7tdeCImUNH5ARoEZLCKw1ZSERyVo0nCXmxb+g36BDqqaQv8AlM
         L3ZW+Lu+kghlan/3ofsNzTnON6+uxAHOJHXwxm0lWY/20eVFQs9OgBy4JoYVQopNOYWu
         hsyTZZij+ucSi2cOa5oZw4ZDnnN4JHVCM0vbFrw6uS8hlCrrQSvUupkf3Bzg5fTA/Z3f
         CGiDeRdKP705ONaG0IB9oNhtS6jSY5CL3ngq5rxXbs3iMSMhxtxdV+EsuXvnoupnBW0/
         BtLw==
X-Gm-Message-State: AOJu0YyLoxnveYvs1LyyhcvtF7vr321BDKILqbYesMuIF2oFtoVE2OgA
        dLllpnB5+xuqhj+px25jyXFkMoV8+zQXiMX3D7A2cyFXKQ5uoxQD3z7CCP/hGpwD6GB67Cx/Zqq
        753SObufIblxaFzK8z3DQ8ypKTEFMW8PATDgx83rNTHq37w==
X-Received: by 2002:a17:907:78b:b0:9b2:ccd8:2d42 with SMTP id xd11-20020a170907078b00b009b2ccd82d42mr1267452ejb.32.1698386066912;
        Thu, 26 Oct 2023 22:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN5AIZiepHqcrh5VA9kwLckibjl2ZQtuMzUiao5z76/hQIeB4pBsBWds56zKwK5RbjoHC7TQ==
X-Received: by 2002:a17:907:78b:b0:9b2:ccd8:2d42 with SMTP id xd11-20020a170907078b00b009b2ccd82d42mr1267436ejb.32.1698386066493;
        Thu, 26 Oct 2023 22:54:26 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id kt12-20020a170906aacc00b009ad8acac02asm636089ejb.172.2023.10.26.22.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 22:54:26 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] shared/shell: Fix --init-script commandline option
Date:   Fri, 27 Oct 2023 07:54:23 +0200
Message-Id: <20231027055423.13617-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026182426.032a776d@gollum>
References: <20231026182426.032a776d@gollum>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The newly added option -i/--init-script introduced a short option
namespace collision with btmgmt's --index, both of which use '-i'.

As a result, a provided --index is treated as a file name:

$ sudo btmgmt --index 0 info
Unable to open 0: No such file or directory (2)

Fix this by using '-s' for --init-script.

Fixes: f2f7c742ad0b ("shared/shell: Add support for -i/--init-script")
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 src/shared/shell.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index db79c882ca3a..fbccff5b54d9 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1128,7 +1128,7 @@ static void rl_init(void)
 static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
-	{ "init-script", required_argument, 0, 'i' },
+	{ "init-script", required_argument, 0, 's' },
 	{ "timeout",	required_argument, 0, 't' },
 	{ "monitor",	no_argument, 0, 'm' },
 	{ "zsh-complete",	no_argument, 0, 'z' },
@@ -1169,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (opt) {
 		memcpy(options + offset, opt->options,
 				sizeof(struct option) * opt->optno);
-		snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->optstr);
+		snprintf(optstr, sizeof(optstr), "+mhvs:t:%s", opt->optstr);
 	} else
-		snprintf(optstr, sizeof(optstr), "+mhvi:t:");
+		snprintf(optstr, sizeof(optstr), "+mhvs:t:");
 
 	data.name = strrchr(argv[0], '/');
 	if (!data.name)
@@ -1193,7 +1193,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.argv = &cmplt;
 			data.mode = 1;
 			goto done;
-		case 'i':
+		case 's':
 			if (optarg)
 				data.init_fd = open(optarg, O_RDONLY);
 			if (data.init_fd < 0)
-- 
2.39.2

