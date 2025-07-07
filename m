Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDC14883F
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896198; cv=none; b=Ew2LoJMPEIOftgTxB2csyQlrluZUODLKO2SNOU9wT6+LeZ53IuGv6xfChQuB5MLh/ksCpxeXfKd8KjOBbGpuiI3GeX9+psShm1M/c960Et/Qj7607etkh2vytoHjGOLWtLD+NtcHkse6ctPNwdNIwIR3yiGQl6Qlfo8ySO8azf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896198; c=relaxed/simple;
	bh=uDj/onimzvEunITZXqhv0n2Je6KXJeIM6UfTKghDB4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JrhvVy6Qp/QCQsyUbwF5y0GtReZOhIFEue3X+g+Iw1lZgfGULl2WKfSuLg5/GQHfsHmtFxwVJ4T4RlgRNZR7D5V/nRJyxg4ae7f1v2blG9KiWACm/UN1RpmqlKPwCwvp0Fijn6ZlEV/WjOjoPOnbRqF52cna44EYt80E8164NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/rqpreZ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/rqpreZ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-531426c7143so1085664e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751896195; x=1752500995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpGg8MhX42Vv8ZRaUWedSwENd12DdMAoemdh0caGmH0=;
        b=N/rqpreZ6Hugj7BWvrn+O5wg1Br52dV/NPIge5RZJMRrgafyVxFNJXTIE3lgGdk/YX
         OrXyNFw3IGYCRSfQydn5aDb7NSE1e2BIPbNR8uffTruyRQq/RxJPB0Y5lUaS0dN0EyXr
         oEzQphl79TzzGlPYlQQR0f1HiGE6p3jG4Vqs+aNC4vCk+A54e0rMvsZCf1PBN61F5E1j
         Oq7oKX+f+jyOp0yxFRFvKx5yWTPh0vRHqpPxkUnRNLxluKNa/8+dcnXH+NosBGw+++PB
         KS/hX54FlR4UFFXQ18ksvl9ynrpC/8b4pJgSyWuhYcAPODd8AFp/gFWwCHBIgzBnpbXZ
         7o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751896195; x=1752500995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpGg8MhX42Vv8ZRaUWedSwENd12DdMAoemdh0caGmH0=;
        b=tJU/vTvILkCU+pD/yhnm//r9oC1ZzZwta/I5j2Eu3S0jvuXc9G3Z6em5dzzBb3LF+p
         r+ycJtKUMDFxbdGSVKizO4m0s906cE9AIuGcf31PVhNeyduGSeLTiCJg/CP5AtVAkXN/
         GLpC7CsgpFAFvQnbuvLSi4m5ShhtvCSsthSIa3SsVBOtvUkE3BC6V4IX6NDOYM37eKVo
         bHx1uzr+HidkEO32FySAuBBSBRliOVKpV00NBP4ZqaBUGU+RvjzKZNDPuEtO/H4tTgrJ
         iOeCt/+BnL8N0kAY+eDvyE7wUIo5VRQhNBfqVQcMpo4onNnHI2MLXPBGNcP7yBahgflB
         I9Ag==
X-Gm-Message-State: AOJu0YwEWnFc0VYesAItTEAiy936zHlwUnE6F/wK4ZIdYLNRX8nZIEmt
	7wKLcLirNiNOPuf4GYJ8QmrkfrgNh19pwSKCDUzq05xdGL7sPWFSr+A10lcs7U5S
X-Gm-Gg: ASbGncuCmYTUoXTeuX7jyfo93TZIk0IhVuGm8TlRPTL1HuzYbd/gtoTezx1BfFKbsgG
	xqCfFF6Nw0ILOFNeVK0QF3sFcGeVWMIjyP1HtgmpwBoD/lqKgiDx+VB1aJQUlcABtKNjVmJiIec
	WwW7LN2vLMh078itaOLv27PL8xcjUvOe0eTHlLcziIMwmba9R+Z6Klb5msOFPBhQw18Ckec2J69
	seEcsqFgdKdVODcIT5F8vbNuRTzkfEPVMIzDF+9tvahVOEwvNe8p4/wpfc/vSSe27N1AA10pF8z
	OGyWZ8evVsTUNGkTl4bJRp0ROL8RbxMGG35cMMdD+c/L5/vD71fn8FC6RRboem47iW1REGZYaCZ
	fUVwcya1g7ADoXyricSQoWdYA6dVLUbQ=
X-Google-Smtp-Source: AGHT+IHrVMd5oG4d9ivgCf2+NFcEf9V8qB7YFEpYnaQUIf6l7p7D2Ntrlpw7H3FriZjt/U0BJ7JVNw==
X-Received: by 2002:a05:6102:4b0e:b0:4e5:93f5:e836 with SMTP id ada2fe7eead31-4f2f25dad9emr7601417137.25.1751896194666;
        Mon, 07 Jul 2025 06:49:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f2ea6c1a59sm1142282137.19.2025.07.07.06.49.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:49:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE
Date: Mon,  7 Jul 2025 09:49:50 -0400
Message-ID: <20250707134950.2395216-1-luiz.dentz@gmail.com>
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

