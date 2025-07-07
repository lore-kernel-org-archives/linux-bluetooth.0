Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D52E06D4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898237; cv=none; b=lHCDVUfwqCFWII4pDT0YOIT2VM+w5FpfVg1mN3mFJT7OLGWwQCUy/3WnOj/mB5dQpPETh1/20Twpmi+nyZenv2j7lnbskl62HlCW43w3Hty2HLljcAMzgpv44kJq/9ITb+lufc9K55EWUPnHkiJEWc22B5Likh0zRC2EeBMNkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898237; c=relaxed/simple;
	bh=rGeQqb8ZZxjNlNaRY0Px+0wXaCzKHNTmYCy63eFjd4E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qmmIHiPRjiQ5XVcHsODggugD6Yl1zunlRWopfStlopW5Xqfhm2zILt+WXQGlNgaa/njquX+soF2gk7UdQxyg9h8F2BvKfcdR/neclq0yPhr3VhA3YAG4Pay8c7P3n6FxELK8QcphPsFLFfWuLCBXaSXqjfGY2h9B/0c2/okJGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTVNW6no; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTVNW6no"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so2598022241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751898233; x=1752503033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GENq62yfO52KioGAvTC6cOC1cqrItEeW5r6WyDO59I0=;
        b=UTVNW6nolVvp5urnzaijAKAMSjSglsHqxFUZqURtMJP/5A9qlN77MrwSNcq/6FpCod
         48taSAv2nZq74JjrZ9sWw7kO/vtt9ceBcWCsDHKnEiDG75DDk2lVOy3NUJibEoQ3MmSd
         /txIW3Ba0EQwhjBDEoKsuW/EgN7i4ENbxpamf4t7EbKpKz8wbKo4RShlwC+4IY+K8j5F
         Nu4G9pvhxNc2ZfMcesb5vVcP9nL25NP4KGIad4Eh2kpXynoHIrkGFLmyH5uCp2wwaUdk
         HIB4t5x6s14ELbQwjqR58+PN27jWJWLodpOXdwcjEebb7x9xRUQHhvfH6iKyvss+ESeu
         RDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751898233; x=1752503033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GENq62yfO52KioGAvTC6cOC1cqrItEeW5r6WyDO59I0=;
        b=Eyw7fRmeehbHjLNvKq+WNxjYBrEh1RDSfQsMs8C5ihM/wpo3b1Xx837vrfl8epOdWX
         4+6KDjSr9NFSjSMvQxFErM0XpIqsomSBIUNwUw6UsLZjrMmCtnfUvS1iOXjR03bVq7s+
         m/DzfmQX1PJQkQ2F79mIAd286iGnvvWz8hW1fz+a9BSAJ02mj73NaPR71LZ15NnNGOpX
         keEpELRT6DuDCwZlg/AJoigWCpFqVUWkRrL9lfGc/lRbsk2OHfPkW38lMKR6dy4b3ymM
         3ER6ZjAdt6Rn6x/kr2h+tJs8rbvPV2nTAuwES1H3Pppa0CfB6YWxueV9N8Q2BU5eN9hX
         IfLA==
X-Gm-Message-State: AOJu0YzVLCcrPPxJ84qcj5og+bxswOHS8OqN32Dw+QFsM3pIYzh2aCZP
	9pzikz8LYUcPYPQrFAFEiT4NGF7i0YAHdbKgdaoR/kFFKLF+3tTqdwQgeVDUAjWH
X-Gm-Gg: ASbGnct8wC0cZ44XnecI6ufl243TOp1A0TGA05TOEmK2vh5ifP5lLMwM3wgf86OtAD/
	7N+hQ3/tnYEtQ1bQcLUOfWYo6Wu8L3NSYxTCnitXGkvWdNVidWTwXPfzhHXxmTtUDjCS3OymgS2
	ji0zcqOAT4R9i1aQbmY0Iekvpdxv4z1iQDaCiCarnoPPfoLMxBdMgpkUVIBBwY24TtVrvZ8Mgff
	K1qHEYkdnsJYyqsomySWoPiVo4vppjc+XW/tjNuxJQ9zMJHj0mSlRdPB/9asO3Aug5oh5I55kst
	viNKLX0NaubAnAUYnNb5b7p9oX6g1tiQv+C1AVWV9ypyuD8TapI30SGyNxbcL6V1SCeyfEMbJhy
	8Sti72i4xHxZc3qosxcy4lAFIBHOAqt0=
X-Google-Smtp-Source: AGHT+IFxZ6oai6/4/2xuURLWGHBO94yhDLxvzYivAZIXpG7NM4ZzHz4BdmnnsU2h10/00gRp4GTCZg==
X-Received: by 2002:a05:6122:54c:b0:530:2c65:5bb9 with SMTP id 71dfb90a1353d-534f668e635mr4809751e0c.8.1751898233206;
        Mon, 07 Jul 2025 07:23:53 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5347909e054sm1260966e0c.36.2025.07.07.07.23.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 07:23:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE
Date: Mon,  7 Jul 2025 10:23:50 -0400
Message-ID: <20250707142350.2404116-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command is given to be run in non-interactive mode the code would
not attempt to execute .pre_run first since some (sub)menus requires that
in order to properly initialize things.

Fixes: https://github.com/bluez/bluez/issues/1394
Fixes: https://github.com/bluez/bluez/issues/1317
---
 src/shared/shell.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index ec9e5f7dc984..ea285c72631d 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -423,7 +423,8 @@ static void cmd_script(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static const struct bt_shell_menu_entry default_menu[] = {
+static const struct bt_shell_menu default_menu = {
+	.entries = {
 	{ "back",         NULL,       cmd_back, "Return to main menu", NULL,
 							NULL, cmd_back_exists },
 	{ "menu",         "<name>",   cmd_menu, "Select submenu",
@@ -437,7 +438,7 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ "export",       NULL,       cmd_export,
 						"Print environment variables" },
 	{ "script",       "<filename>", cmd_script, "Run script" },
-	{ }
+	{} },
 };
 
 static void shell_print_help(void)
@@ -480,7 +481,7 @@ static void shell_print_menu(void)
 		print_menu(entry->cmd, entry->arg ? : "", entry->desc ? : "");
 	}
 
-	for (entry = default_menu; entry->cmd; entry++) {
+	for (entry = default_menu.entries; entry->cmd; entry++) {
 		if (entry->exists && !entry->exists(data.menu))
 			continue;
 
@@ -495,7 +496,7 @@ static void shell_print_menu_zsh_complete(void)
 	for (entry = data.menu->entries; entry->cmd; entry++)
 		printf("%s:%s\n", entry->cmd, entry->desc ? : "");
 
-	for (entry = default_menu; entry->cmd; entry++) {
+	for (entry = default_menu.entries; entry->cmd; entry++) {
 		if (entry->exists && !entry->exists(data.menu))
 			continue;
 
@@ -627,9 +628,11 @@ fail:
 	return -EINVAL;
 }
 
-static int menu_exec(const struct bt_shell_menu_entry *entry,
+static int menu_exec(const struct bt_shell_menu *menu,
 					int argc, char *argv[])
 {
+	const struct bt_shell_menu_entry *entry = menu->entries;
+
 	for (; entry->cmd; entry++) {
 		if (strcmp(argv[0], entry->cmd))
 			continue;
@@ -642,6 +645,9 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
 			continue;
 
+		if (data.mode == MODE_NON_INTERACTIVE && menu->pre_run)
+			menu->pre_run(menu);
+
 		return cmd_exec(entry, argc, argv);
 	}
 
@@ -673,7 +679,7 @@ static int submenu_exec(int argc, char *argv[])
 	memmove(argv[0], argv[0] + len + 1, tlen - len - 1);
 	memset(argv[0] + tlen - len - 1, 0, len + 1);
 
-	return menu_exec(submenu->entries, argc, argv);
+	return menu_exec(submenu, argc, argv);
 }
 
 static int shell_exec(int argc, char *argv[])
@@ -686,9 +692,9 @@ static int shell_exec(int argc, char *argv[])
 	if (!argsisutf8(argc, argv))
 		return -EINVAL;
 
-	err  = menu_exec(default_menu, argc, argv);
+	err  = menu_exec(&default_menu, argc, argv);
 	if (err == -ENOENT) {
-		err  = menu_exec(data.menu->entries, argc, argv);
+		err  = menu_exec(data.menu, argc, argv);
 		if (err == -ENOENT) {
 			err = submenu_exec(argc, argv);
 			if (err == -ENOENT) {
@@ -980,7 +986,7 @@ static char *cmd_generator(const char *text, int state)
 	}
 
 	if (default_menu_enabled) {
-		cmd = find_cmd(text, default_menu, &index);
+		cmd = find_cmd(text, default_menu.entries, &index);
 		if (cmd) {
 			return cmd;
 		} else {
@@ -1171,8 +1177,8 @@ static char **shell_completion(const char *text, int start, int end)
 		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
 			return NULL;
 
-		matches = menu_completion(default_menu, text, w.we_wordc,
-							w.we_wordv[0]);
+		matches = menu_completion(default_menu.entries, text,
+						w.we_wordc, w.we_wordv[0]);
 		if (!matches) {
 			matches = menu_completion(data.menu->entries, text,
 							w.we_wordc,
@@ -1449,6 +1455,12 @@ int bt_shell_run(void)
 	int status;
 	const struct queue_entry *submenu;
 
+	/* Check if on non-interactive mode skip pre-run since that is on-demand
+	 * by shell_exec() only for the menu in use.
+	 */
+	if (data.mode == MODE_NON_INTERACTIVE)
+		goto done;
+
 	if (data.menu && data.menu->pre_run)
 		data.menu->pre_run(data.menu);
 
@@ -1460,6 +1472,7 @@ int bt_shell_run(void)
 			menu->pre_run(menu);
 	}
 
+done:
 	status = mainloop_run_with_signal(signal_callback, NULL);
 
 	bt_shell_cleanup();
-- 
2.49.0

