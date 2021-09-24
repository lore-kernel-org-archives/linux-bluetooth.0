Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547BC61039
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbhIXJbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbhIXJbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 05:31:02 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0AC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 02:29:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id da19-20020a05621408d300b00382307badfeso449756qvb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nqejF+iEkzA+Wb1GzwvyyPKXZSAGBGaNNmXYrhpofGk=;
        b=FB65Qtvpj3TCB/jzTTEyEFq4gh7YV86s63MDBgmzg3KRzPfiOf6irFFhJ3dSUzygKq
         sfG3y4bpmBWG1mmYbTUsGt+0aKbOhk8g52/Lay6t0Y63lOItDiwP4PYXmtQNtfTpbJLz
         yFBYDvlm6VekWYDwj0w1CB3C+tVwgjU833Lsz0cGWHGvzsSvG6EP8ga3e4kPGCsJ0Cbc
         LiStwhd+BRJh19gKiBM13BpJd8YunmPmNl/bVW3cdqp/Vdc/8zx4bXQbTM4GZkQT8yZC
         sr4esPX93f0wQZhNt+yYyKvD9BaUnM++2xVqZITcouNmuuNatCJFBoXgeiEKoYdKcJ35
         Gy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nqejF+iEkzA+Wb1GzwvyyPKXZSAGBGaNNmXYrhpofGk=;
        b=KpbE01uJHCg/Nudgq6Bm91d8j6S4ib7qpKm78hHrMobY83RS6fx7jTr0lnaAo9MzdL
         S5vpn3ZFIKO2DuDRf4r8FosGq8HjUMZkI+7KdMNu2nD72AKJuQGG7QiazXq50SX7BXl/
         PAWg/YdZzqU7+VBnG5FVxjI68yYsgCjJmevbQ5B+FFa/K531WP83KoDtgxZUZG3xer4r
         asj0kiLEMd6fS2/6GgLUDxUt6eghlOcS85vm7sKSl9pbbEvlx2IKYRhttC1PZog/odSq
         aRXUh0DzPDa5lq/2I3roqXiJumm9j6oOFNWPA9Rz+x71OCivc99ulwL7zY/bUWg0Oubb
         gXcQ==
X-Gm-Message-State: AOAM531YfRJ9dn8CBzk2gCA8ofnxG0gz9g1VFpwcvypyOi0h4YJe1bXQ
        WSMjaun6mcJ1jwTQbDyBv77OaNLQ4/y/4tDsNlqpNPHxQZrWbyFR80x71uB237WF4fCoR7GT+O6
        XWk37IgPMUmbhZlW6YPYQgiHZ7yBnTo3Tg07c1GcC/Wd6kE/RMRyKY2oNE/cs2h53emC0N0kCRj
        Su
X-Google-Smtp-Source: ABdhPJyTm+7bWVNFrv+WJaGpReMtfiEPHqSbvm3emasqaRkZIggSOxP+h38NM5zwoW6hxEGhIyvlC1F8r9d2
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ad44:810f:6cc1:6931])
 (user=apusaka job=sendgmr) by 2002:a05:6214:6ed:: with SMTP id
 bk13mr9009934qvb.47.1632475769018; Fri, 24 Sep 2021 02:29:29 -0700 (PDT)
Date:   Fri, 24 Sep 2021 17:29:21 +0800
Message-Id: <20210924172910.Bluez.1.I9b71a5f022d2b7197de347c7afa6005bd1d21b5b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [Bluez PATCH] tools/hcitool: Fix the descriptions of leal* commands
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The descriptions of leal* commands are copied from lewl* commands.
However they should use "accept list" instead.
---

 tools/hcitool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index b6f4a4e665..639ee6a511 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3400,10 +3400,10 @@ static struct {
 	{ "clock",    cmd_clock,   "Read local or remote clock"           },
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "leinfo",   cmd_leinfo,  "Get LE remote information"            },
-	{ "lealadd",  cmd_lealadd, "Add device to LE White List"          },
-	{ "lealrm",   cmd_lealrm,  "Remove device from LE White List"     },
-	{ "lealsz",   cmd_lealsz,  "Read size of LE White List"           },
-	{ "lealclr",  cmd_lealclr, "Clear LE White List"                  },
+	{ "lealadd",  cmd_lealadd, "Add device to LE Accept List"         },
+	{ "lealrm",   cmd_lealrm,  "Remove device from LE Accept List"    },
+	{ "lealsz",   cmd_lealsz,  "Read size of LE Accept List"          },
+	{ "lealclr",  cmd_lealclr, "Clear LE Accept List"                 },
 	{ "lewladd",  cmd_lealadd, "Deprecated. Use lealadd instead."     },
 	{ "lewlrm",   cmd_lealrm,  "Deprecated. Use lealrm instead."      },
 	{ "lewlsz",   cmd_lealsz,  "Deprecated. Use lealsz instead."      },
-- 
2.33.0.685.g46640cef36-goog

