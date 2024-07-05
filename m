Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64659145B35
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169985; cv=none; b=M2yy+EsxI/qPy5ykuEFpbDy/82MTn4zsYCbIUxbAWT8Aw/kxCSSBUgJAYuCUj2C9Jq6q0vOSsLMcCjnfL/Dqp17PPT0nzkDRvkKVePNH4Fc7JlraQ1WhDOT64Mpx01/+dcTTPwBDklvrl+8juHeKnNj7VzOJVzYooLuHijiOH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169985; c=relaxed/simple;
	bh=4ytoBu9zBmLCrOkNhrHSufutx9uCfY9Mn/5GXh3TmSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+9ypZv1gWG9OA/5IKT7/zIoDfWzIUPNIgFcV1XdUIWQ7lPrfZoP5MnXXRPC/EGefiskM2sxKFq+XWnv2POUirVXPlEU10Bc7DvrRwBBQhEYspWnu+Vbsg/3EC7FRFf2MPr0Hw9jR4zMHs0HnM9l28F7o6/F/AxsAGC6G6wAThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D9786000A;
	Fri,  5 Jul 2024 08:59:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 02/11] shared/shell: Free memory allocated by wordexp()
Date: Fri,  5 Jul 2024 10:57:30 +0200
Message-ID: <20240705085935.1255725-3-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
bluez-5.76/src/shared/shell.c:519:2: alloc_arg: "parse_args" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:523:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
521|			"Unable to parse mandatory command arguments: %s", man );
522|		free(man);
523|->		return -EINVAL;
524|	}
525|

Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
bluez-5.76/src/shared/shell.c:1113:3: alloc_arg: "wordexp" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:1114:4: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
1112|
1113|			if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
1114|->				return NULL;
1115|
1116|			matches = menu_completion(default_menu, text, w.we_wordc,

Error: RESOURCE_LEAK (CWE-772): [#def42] [important]
bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:1415:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
1413|		switch (err) {
1414|		case WRDE_BADCHAR:
1415|->			return -EBADMSG;
1416|		case WRDE_BADVAL:
1417|		case WRDE_SYNTAX:

Error: RESOURCE_LEAK (CWE-772): [#def43] [important]
bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:1418:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
1416|		case WRDE_BADVAL:
1417|		case WRDE_SYNTAX:
1418|->			return -EINVAL;
1419|		case WRDE_NOSPACE:
1420|			return -ENOMEM;

Error: RESOURCE_LEAK (CWE-772): [#def44] [important]
bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:1420:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
1418|			return -EINVAL;
1419|		case WRDE_NOSPACE:
1420|->			return -ENOMEM;
1421|		case WRDE_CMDSUB:
1422|			if (wordexp(input, &w, 0))

Error: RESOURCE_LEAK (CWE-772): [#def45] [important]
bluez-5.76/src/shared/shell.c:1422:3: alloc_arg: "wordexp" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:1423:4: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
1421|		case WRDE_CMDSUB:
1422|			if (wordexp(input, &w, 0))
1423|->				return -ENOEXEC;
1424|			break;
1425|		};
---
 src/shared/shell.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index add4fa131c7a..e8f75124f167 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -452,13 +452,23 @@ static void shell_print_menu_zsh_complete(void)
 	}
 }
 
+static int _wordexp(const char *restrict s, wordexp_t *restrict p, int flags)
+{
+	int ret;
+
+	ret = wordexp(s, p, flags);
+	if (ret != 0)
+		wordfree(p);
+	return ret;
+}
+
 static int parse_args(char *arg, wordexp_t *w, char *del, int flags)
 {
 	char *str;
 
 	str = strdelimit(arg, del, '"');
 
-	if (wordexp(str, w, flags)) {
+	if (_wordexp(str, w, flags) != 0) {
 		free(str);
 		return -EINVAL;
 	}
@@ -537,7 +547,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 		goto fail;
 	}
 
-	flags |= WRDE_APPEND;
+	flags |= WRDE_APPEND | WRDE_REUSE;
 	opt = strdup(entry->arg + len + 1);
 
 optional:
@@ -1043,7 +1053,7 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 	args.we_offs = 0;
 	wordfree(&args);
 
-	if (wordexp(str, &args, WRDE_NOCMD))
+	if (_wordexp(str, &args, WRDE_NOCMD))
 		goto done;
 
 	rl_completion_display_matches_hook = NULL;
@@ -1115,7 +1125,7 @@ static char **shell_completion(const char *text, int start, int end)
 	if (start > 0) {
 		wordexp_t w;
 
-		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
+		if (_wordexp(rl_line_buffer, &w, WRDE_NOCMD))
 			return NULL;
 
 		matches = menu_completion(default_menu, text, w.we_wordc,
@@ -1416,7 +1426,7 @@ int bt_shell_exec(const char *input)
 	if (data.monitor)
 		bt_log_printf(0xffff, data.name, LOG_INFO, "%s", input);
 
-	err = wordexp(input, &w, WRDE_NOCMD);
+	err = _wordexp(input, &w, WRDE_NOCMD);
 	switch (err) {
 	case WRDE_BADCHAR:
 		return -EBADMSG;
@@ -1426,7 +1436,7 @@ int bt_shell_exec(const char *input)
 	case WRDE_NOSPACE:
 		return -ENOMEM;
 	case WRDE_CMDSUB:
-		if (wordexp(input, &w, 0))
+		if (_wordexp(input, &w, 0))
 			return -ENOEXEC;
 		break;
 	};
-- 
2.45.2

