Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E15C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 23:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiCAXb3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiCAXb3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 18:31:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE35E14C
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 15:30:47 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i14so122628ilv.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 15:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuZHkMLJd8wiweYKFEy4u/853MBXSBHLttigQ9HsVKs=;
        b=PFU05ut5fx0UF8e9MJnH9P892tPhSs+pnpSNFUF466PT2AQv/xr1NmBSkqi/8Uq+5W
         1dgFddLB7lehp24vDMg+JnFBnQ0EvTGqljUDAXp71sTasXsXaEi66v97LLJtL2BxWcVe
         9aaMTogqyzgLLPg1XwgewQSnIeP4Qd2U/kmpr/QuIJ+Vymoptpa1d5t08+lGNOkPQ8an
         R/giRyxfADd9JJyGVlfQmJcdGB2ppmrBLc/lIIIL9oQZP1xp/AVvqsPVTo49QnW2Lo89
         RurV18DXkcPTlkGc0zmZmzSQt6vLvEOkpW5tmN2lhqLB5xmckAG3HXu1MttUVOj8svbX
         Gbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuZHkMLJd8wiweYKFEy4u/853MBXSBHLttigQ9HsVKs=;
        b=diTLuG8qF8Psx8jn07wRd+H2n5W9XUYwErc1+UDe9cG6jwZEoy0EQj887aPV3KhShw
         TvtG+YmvqAzQU/RbjgY3mqqmHKz2Izaw+ePWMqzW9h//2PA7Io4EUQDSfDvqejuLNHQA
         SB7ErxcB3G6tj7zf41znrbrX6vRlr6v4T4tYmYW3hY1vvfFJqm5PRS2PUzELBBHjsbhS
         I1sNzBgCvVO3JrEAvdHPevmGj31weHoD6i4Ha6ygb92qyOr6cz8R7sHiY/II0MGVUijH
         OHkjLGUH/iAembbyr0fLsKO8Qx+pEYQAIqtVkuaa6gOs17ELGf3qKOgk/QAvqnLacovH
         2jyw==
X-Gm-Message-State: AOAM532sazzXjF0qsfzWWYyYgfZKo6jBxG236hh2gvPvAsf4noU8wPsK
        eCCHVe7Qz/zTcdtefS/wjlvXPHh+/IE=
X-Google-Smtp-Source: ABdhPJz06YR6KxAR7RCq0A2nl+uOSetTP+dl7cZ61lAqDDaWWZcs5P6DBswBXuQvR8eD/OgnrhC6Qw==
X-Received: by 2002:a05:6e02:12ef:b0:2c2:cd1a:37c with SMTP id l15-20020a056e0212ef00b002c2cd1a037cmr15917871iln.110.1646177446649;
        Tue, 01 Mar 2022 15:30:46 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g5-20020a92c7c5000000b002b864923195sm8553208ilk.62.2022.03.01.15.30.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:30:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Introduce bt_shell_exec
Date:   Tue,  1 Mar 2022 15:30:44 -0800
Message-Id: <20220301233045.109794-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces bt_shell_exec which can be used to inject commands into
a bt_shell without using stdin/user input.
---
 src/shared/shell.c | 34 ++++++++++++++++++++++++----------
 src/shared/shell.h |  1 +
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index cbb9b8b88..0d82bc282 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -678,7 +678,6 @@ int bt_shell_release_prompt(const char *input)
 
 static void rl_handler(char *input)
 {
-	wordexp_t w;
 	HIST_ENTRY *last;
 
 	if (!input) {
@@ -703,16 +702,8 @@ static void rl_handler(char *input)
 	if (data.monitor)
 		bt_log_printf(0xffff, data.name, LOG_INFO, "%s", input);
 
-	if (wordexp(input, &w, WRDE_NOCMD))
-		goto done;
-
-	if (w.we_wordc == 0) {
-		wordfree(&w);
-		goto done;
-	}
+	bt_shell_exec(input);
 
-	shell_exec(w.we_wordc, w.we_wordv);
-	wordfree(&w);
 done:
 	free(input);
 }
@@ -1178,6 +1169,29 @@ int bt_shell_run(void)
 	return status;
 }
 
+int bt_shell_exec(const char *input)
+{
+	wordexp_t w;
+	int err;
+
+	if (!input)
+		return 0;
+
+	if (wordexp(input, &w, WRDE_NOCMD))
+		return -ENOEXEC;
+
+	if (w.we_wordc == 0) {
+		wordfree(&w);
+		return -ENOEXEC;
+	}
+
+	err = shell_exec(w.we_wordc, w.we_wordv);
+
+	wordfree(&w);
+
+	return err;
+}
+
 void bt_shell_cleanup(void)
 {
 	bt_shell_release_prompt("");
diff --git a/src/shared/shell.h b/src/shared/shell.h
index cc4f822fb..8baa2854a 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -55,6 +55,7 @@ struct bt_shell_opt {
 void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt);
 
 int bt_shell_run(void);
+int bt_shell_exec(const char *input);
 
 void bt_shell_quit(int status);
 void bt_shell_noninteractive_quit(int status);
-- 
2.35.1

