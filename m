Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72723C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 23:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiDHABy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 20:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiDHABx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 20:01:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70619853C
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 16:59:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m16so6472378plx.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Apr 2022 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUcOW+b/B0sVL/nrOuOnCZl8YB85FuSY2th6iPJ2wGo=;
        b=CuKGtU1MeOjeUrKUd9/erYqfDFC8eyDWORurJ7yyd4oZugMT6PZItYtqswE5VptHBn
         XLkgwzxJPraC/DmnZMpOirUzwQDlQLi9jwojSZBCyE1sHit4wFrRpWSY8ZDe3/cjfMOM
         rcOuH7m/4cBJmo7itMZRtaJ60BcYWge+DrLJcidxu42Sf4bOLkuE6Z5w4N11zaz6GA2g
         UiO1hejfMW5sFvjEwoC2DsewcEDbesIfrn+qao3CFMG8pJiCM+C9FTBqBRdXPmG6Zf0H
         fbT9IDqr8PmkH5H2DMQQ7YxIGetCYdVtpzuDqI+qMhzrHopBwJVVyXNRO00jGQM1nA0t
         gHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUcOW+b/B0sVL/nrOuOnCZl8YB85FuSY2th6iPJ2wGo=;
        b=iZ1qLNLwtyUHlxERB5cvVnwXm28xTgKShbTIfBqVFbClN/MSu511CaOdddTm4fPvJp
         p3EESqxvaTXkiUjxtqfDQBFmi6W4Mu8PWJUTJBcIxIx96yJpfaYe05op746YvwmQxjuT
         vF+EMB+puB5YYoITtf4Gro2myU9GzXN8IhJld6GiXEbrnQ51VnUKFCEDvMBoOJesUGR2
         RuDD55t+zAAvUtPdBCOrV0Od6nfErquVUGJ9zHw72Wrwu3J/WoeRhg6qiVwKWbLtkOxz
         GUB/Ygk9pj0jawx8gO8EbzHb8+bg5x3k0BJnHifN7u5zBbF/ausFectTa0aZgoFVs0pN
         kwYg==
X-Gm-Message-State: AOAM532WwC1i1b26UZCODVboxv+wbG0nwK6LSsz/t16k1YdXAUMrVHD2
        S7bmpBVtoY9dTKplaqTFLE2Jx3oDWBE=
X-Google-Smtp-Source: ABdhPJz8dG0Hjwlc40tgEmXpcS9sp9YNeQTlu2UjURsSxuayX07r852bLQtrzQ4AE80QMrjd+ZpGcA==
X-Received: by 2002:a17:902:e84d:b0:156:bf35:6449 with SMTP id t13-20020a170902e84d00b00156bf356449mr16517980plg.26.1649375991064;
        Thu, 07 Apr 2022 16:59:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bg13-20020a17090b0d8d00b001caa8f51098sm9770532pjb.9.2022.04.07.16.59.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 16:59:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shell: Fix not being able to auto complete submenus
Date:   Thu,  7 Apr 2022 16:59:48 -0700
Message-Id: <20220407235949.2428708-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

submenus should be part of the list of possible auto completes just as
other commands.
---
 src/shared/shell.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7ba264b99..72232f7c0 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -139,14 +139,22 @@ static void cmd_help(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static const struct bt_shell_menu *find_menu(const char *name, size_t len)
+static const struct bt_shell_menu *find_menu(const char *name, size_t len,
+							int *index)
 {
 	const struct queue_entry *entry;
+	int i;
 
-	for (entry = queue_get_entries(data.submenus); entry;
-						entry = entry->next) {
+	for (i = 0, entry = queue_get_entries(data.submenus); entry;
+						entry = entry->next, i++) {
 		struct bt_shell_menu *menu = entry->data;
 
+		if (index) {
+			if (i < *index)
+				continue;
+			(*index)++;
+		}
+
 		if (!strncmp(menu->name, name, len))
 			return menu;
 	}
@@ -188,7 +196,7 @@ static void cmd_menu(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	menu = find_menu(argv[1], strlen(argv[1]));
+	menu = find_menu(argv[1], strlen(argv[1]), NULL);
 	if (!menu) {
 		bt_shell_printf("Unable find menu with name: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -485,7 +493,7 @@ static int submenu_exec(int argc, char *argv[])
 	len = name - argv[0];
 	name[0] = '\0';
 
-	submenu = find_menu(argv[0], strlen(argv[0]));
+	submenu = find_menu(argv[0], strlen(argv[0]), NULL);
 	if (!submenu)
 		return -ENOENT;
 
@@ -735,7 +743,7 @@ static char *find_cmd(const char *text,
 static char *cmd_generator(const char *text, int state)
 {
 	static int index;
-	static bool default_menu_enabled, submenu_enabled;
+	static bool default_menu_enabled, menu_enabled, submenu_enabled;
 	static const struct bt_shell_menu *menu;
 	char *cmd;
 
@@ -754,9 +762,22 @@ static char *cmd_generator(const char *text, int state)
 			index = 0;
 			menu = data.menu;
 			default_menu_enabled = false;
+
+			if (data.main == data.menu)
+				menu_enabled = true;
 		}
 	}
 
+	if (menu_enabled) {
+		menu = find_menu(text, strlen(text), &index);
+		if (menu)
+			return strdup(menu->name);
+
+		index = 0;
+		menu = data.menu;
+		menu_enabled = false;
+	}
+
 	if (!submenu_enabled) {
 		cmd = find_cmd(text, menu->entries, &index);
 		if (cmd || menu != data.main)
@@ -766,7 +787,7 @@ static char *cmd_generator(const char *text, int state)
 		if (!cmd)
 			return NULL;
 
-		menu = find_menu(text, cmd - text);
+		menu = find_menu(text, cmd - text, NULL);
 		if (!menu)
 			return NULL;
 
-- 
2.35.1

