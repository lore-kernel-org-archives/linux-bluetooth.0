Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CD1AB90F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088783; cv=none; b=gPHogRC5gCNmrQHnzcW2A+nbLOg5b+9qC7MjbGDhRpCf5xvZ1p1b98yeChrzStgo8118XvpFDY6RyqWxyMkxj7Qp+UeVth+AXk2JspMmd7XP2rmzuwC872P7NaxFziSvb1MSDf3bvBJFcx7aDBNpiQyokwVXo8aXBgXnBeyPOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088783; c=relaxed/simple;
	bh=7DO1kCsO38UYhE5wxbDolZXtkXl/MAdWhfekreVst+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljTYqUzlT2rDFVJoxhCA+RNBtJS63BH/JRxZ/SjknYQ0AxYs3deXH1Yhn37ow3LY6IEgmnKQJbgwEZWmVJNJf7bDl5fxNWQYFr8I5S0erE5+GZsH8euPT5W1mZ0C4obCCjYcYC8bE1lO9lQJGuXE1fIR8QPVXZzaphPvnXX5SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E762240004;
	Thu,  4 Jul 2024 10:26:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 03/12] shared/shell: Free memory allocated by wordexp()
Date: Thu,  4 Jul 2024 12:24:34 +0200
Message-ID: <20240704102617.1132337-4-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

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
 src/shared/shell.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 878be140c336..c09d41ee54df 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1117,8 +1117,10 @@ static char **shell_completion(const char *text, int start, int end)
 	if (start > 0) {
 		wordexp_t w;
 
-		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
+		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD)) {
+			wordfree(&w);
 			return NULL;
+		}
 
 		matches = menu_completion(default_menu, text, w.we_wordc,
 							w.we_wordv[0]);
@@ -1421,15 +1423,20 @@ int bt_shell_exec(const char *input)
 	err = wordexp(input, &w, WRDE_NOCMD);
 	switch (err) {
 	case WRDE_BADCHAR:
+		wordfree(&w);
 		return -EBADMSG;
 	case WRDE_BADVAL:
 	case WRDE_SYNTAX:
+		wordfree(&w);
 		return -EINVAL;
 	case WRDE_NOSPACE:
+		wordfree(&w);
 		return -ENOMEM;
 	case WRDE_CMDSUB:
-		if (wordexp(input, &w, 0))
+		if (wordexp(input, &w, 0)) {
+			wordfree(&w);
 			return -ENOEXEC;
+		}
 		break;
 	};
 
-- 
2.45.2

