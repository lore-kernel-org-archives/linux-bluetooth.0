Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 00:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiCAABF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiCAABE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 19:01:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EE38798
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 16:00:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g1so12571425pfv.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuZHkMLJd8wiweYKFEy4u/853MBXSBHLttigQ9HsVKs=;
        b=I1ZPCe3V3OBTqRJdIFc/paEM/OOQYp7uxuj4ckysXrXH/w0K3/AOuxHzmMsc+j5ufo
         hNHwwTG9sM1BTwlB99VZZ7dZ0Ez8C7tzc0eLSIXGZZYEOJ15TISM7MVhh5oBShaqWiOb
         eSS4CQJznOUp7NvR5VJTwQcF7oaXeHIxSpMl4bdQjaitg27dne3pS2OTlvH6/U4QB4E2
         RmcoMDe7WQzjn0VmqXqQcnm5n8iMmLQt1X/NROfGBM4+NB1ba0fwY7Ih4TzxDRd7Hp6P
         VZSm98LsclGAawJNP8VQGCrLzbLs++YCkclchCIi12PTrmIDIjtGy2tsEFtP8TXvJLnv
         kLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuZHkMLJd8wiweYKFEy4u/853MBXSBHLttigQ9HsVKs=;
        b=vxcPqsp5pvh51RjrPsHUx/T1eiptMeCPRAkLy0wRHNy+Kud4kLwkA6GLz4gXWNqfwU
         cuSOVvk91q7CWtvmFJdwBKAeCeP+hThHtWlef8ZKKus8EZOIC917zra21eNO63Atvzrg
         gcR8gIF44XRkN4A+9udxltKirFkQliTXS0HI7OkDhNn1sMhzg7tw2wo8UukMvrSXeZwY
         TYmQjFUCj40jm+nn/0QiHwpnDK/d32KpZAzIve/Wdm8CVXGhjxILId1voEddDr6w+Qxg
         4pKsMsTq+Dk3b23T0hdWzUaiYrA+onZUtYfo9s0zdao39Sx/VRDxRbrXTmdA6HF3T9l5
         wp+A==
X-Gm-Message-State: AOAM533Z9FzxUr/Wh/2tY+icPmRfHzTscPYWtXM+jp47emENd5wsUpDt
        FvmeDyEJA+oDbzW98PSnC0ftzXRkJ/c=
X-Google-Smtp-Source: ABdhPJwGocRjFEBuTW2fsBdbfFuPZ2xKvnqKTXbHs+ViDTRN1/2VJbGu+cHJmdiR+DuDerT8rl3k0w==
X-Received: by 2002:a65:6805:0:b0:373:dd4e:d7a2 with SMTP id l5-20020a656805000000b00373dd4ed7a2mr19183822pgt.569.1646092823532;
        Mon, 28 Feb 2022 16:00:23 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090a658900b001bd6972d384sm397328pjj.28.2022.02.28.16.00.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 16:00:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Introduce bt_shell_exec
Date:   Mon, 28 Feb 2022 16:00:22 -0800
Message-Id: <20220301000022.1628080-1-luiz.dentz@gmail.com>
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

