Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C8C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 11:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8A6206BB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 11:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSPFflQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBVLm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:42:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33254 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBVLm6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 06:42:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id q12so1494993lfm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Feb 2019 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=uNRNcoKt2x2QoiHyZwoFYa1P+h0do1GZRh7wOmmUyBU=;
        b=KSPFflQxFPdH7dg+AVO22+S/o075lVRU4x6EUMmfHrPiOvQDHqcDBOaxKVJSP4KAYX
         vCY85Sbn8yOZS/SYMEfM8ZtcD/mtSssP6jsFsfFsgOXfPkaSKoWhcJKwxr9QNEoKBeWi
         4lnjkg0gZdmmm5vLSYrMRuY+zS/aUWgbFsIUogvbZJByY42RLrGxfS6WF8vTjbOBh9eU
         edp5mVpAqUeiDsbI699EV02K50nXGgAk0eo11Te1eOFjv9AgzjLqPjw27qHExVO3a7sf
         no7MlgEYTqJd8FvUGfIhWNr0x/1PFIMNkqyfGXsgydQqKlWzM8uzTyH0J/q+w5lubKbK
         qx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=uNRNcoKt2x2QoiHyZwoFYa1P+h0do1GZRh7wOmmUyBU=;
        b=VOXtd6vgR54le3dRCfKP+rS9ojXIrn6ASPHeHXn+EYAYCPtr4om7i7766ouDzXywS0
         SRSLEpG9o72xqC7VCt3QeNc5g05foStljTdl8M8460qCn8D0CrB+4eXK6U7q046KFGU1
         PVluwWFid0u44YHWjvU7vM8U44l+GELspkWELknNx1ZN89WSHaRo7ZsPDLK+da1dlbIw
         ssVr4mes8Cn22U435MkhtQDBDh5k51ssUXUGVQ45LVw9JphIj0ua8sZxqVp2K2RIfctT
         nojPlJ1k+xSmughisi5WHtKuA7PY7PmDMRfjlvDk742DA1coB2oyvlgO/8xf3yfc5I+v
         ukVg==
X-Gm-Message-State: AHQUAubfk2UkrXW90b7qBu21FcRR0YjteGOEssHL3vTw0xw3ZW/jKAI4
        G2T5AtWedtUHw2pu2oEjvm9OpbWF
X-Google-Smtp-Source: AHgI3IaUG2QOM7V2xCALq4fH4jzBaoAlApZD9c9t8yhS9FU2iZ+Wk1gjGc5Hs9YrqZK+yuHc9VqoHw==
X-Received: by 2002:ac2:5104:: with SMTP id q4mr2236226lfb.59.1550835776303;
        Fri, 22 Feb 2019 03:42:56 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id u15sm462576lff.3.2019.02.22.03.42.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 03:42:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shell: Allow multiple prompt inputs
Date:   Fri, 22 Feb 2019 13:42:54 +0200
Message-Id: <20190222114254.21369-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allow queueing input prompts so that the application don't have to
queue themselves.
---
 src/shared/shell.c | 66 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 709d20556..d7fbf46aa 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -66,6 +66,12 @@ struct bt_shell_env {
 
 static char *cmplt = "help";
 
+struct bt_shell_prompt_input {
+	char *str;
+	bt_shell_prompt_input_func func;
+	void *user_data;
+};
+
 static struct {
 	bool init;
 	char *name;
@@ -81,6 +87,8 @@ static struct {
 	bt_shell_prompt_input_func saved_func;
 	void *saved_user_data;
 
+	struct queue *prompts;
+
 	const struct bt_shell_menu *menu;
 	const struct bt_shell_menu *main;
 	struct queue *submenus;
@@ -560,6 +568,17 @@ void bt_shell_usage()
 					data.exec->arg ? data.exec->arg : "");
 }
 
+static void prompt_input(const char *str, bt_shell_prompt_input_func func,
+							void *user_data)
+{
+	data.saved_prompt = true;
+	data.saved_func = func;
+	data.saved_user_data = user_data;
+
+	rl_save_prompt();
+	bt_shell_set_prompt(str);
+}
+
 void bt_shell_prompt_input(const char *label, const char *msg,
 			bt_shell_prompt_input_func func, void *user_data)
 {
@@ -568,25 +587,43 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 	if (!data.init || data.mode)
 		return;
 
-	/* Normal use should not prompt for user input to the value a second
-	 * time before it releases the prompt, but we take a safe action. */
-	if (data.saved_prompt)
+	if (data.saved_prompt) {
+		struct bt_shell_prompt_input *prompt;
+
+		prompt = new0(struct bt_shell_prompt_input, 1);
+
+		if (asprintf(&prompt->str, "[%s] %s ", label, msg) < 0) {
+			free(prompt);
+			return;
+		}
+
+		prompt->func = func;
+		prompt->user_data = user_data;
+
+		queue_push_tail(data.prompts, prompt);
+
 		return;
+	}
 
 	if (asprintf(&str, "[%s] %s ", label, msg) < 0)
 		return;
 
-	data.saved_prompt = true;
-	data.saved_func = func;
-	data.saved_user_data = user_data;
+	prompt_input(str, func, user_data);
 
-	rl_save_prompt();
-	bt_shell_set_prompt(str);
 	free(str);
 }
 
+static void prompt_free(void *data)
+{
+	struct bt_shell_prompt_input *prompt = data;
+
+	free(prompt->str);
+	free(prompt);
+}
+
 int bt_shell_release_prompt(const char *input)
 {
+	struct bt_shell_prompt_input *prompt;
 	bt_shell_prompt_input_func func;
 	void *user_data;
 
@@ -600,11 +637,20 @@ int bt_shell_release_prompt(const char *input)
 	func = data.saved_func;
 	user_data = data.saved_user_data;
 
+	prompt = queue_pop_head(data.prompts);
+	if (prompt)
+		data.saved_prompt = true;
+
 	data.saved_func = NULL;
 	data.saved_user_data = NULL;
 
 	func(input, user_data);
 
+	if (prompt) {
+		prompt_input(prompt->str, prompt->func, prompt->user_data);
+		prompt_free(prompt);
+	}
+
 	return 0;
 }
 
@@ -1070,6 +1116,7 @@ done:
 	rl_init();
 
 	data.init = true;
+	data.prompts = queue_new();
 }
 
 static void rl_cleanup(void)
@@ -1118,6 +1165,9 @@ void bt_shell_cleanup(void)
 
 	rl_cleanup();
 
+	queue_destroy(data.prompts, prompt_free);
+	data.prompts = NULL;
+
 	data.init = false;
 	free(data.name);
 }
-- 
2.17.2

