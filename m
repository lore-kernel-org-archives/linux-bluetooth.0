Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] obexd: Remove dead code
Date: Tue,  5 Jan 2016 11:12:30 +0200
Message-Id: <1451985150-6447-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Variables file and name are always NULL making code dead.
---
 obexd/src/log.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/obexd/src/log.c b/obexd/src/log.c
index f259728..7c48664 100644
--- a/obexd/src/log.c
+++ b/obexd/src/log.c
@@ -102,20 +102,11 @@ void __obex_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
 	struct obex_debug_desc *desc;
-	const char *name = NULL, *file = NULL;
 
 	if (debug != NULL)
 		enabled = g_strsplit_set(debug, ":, ", 0);
 
 	for (desc = __start___debug; desc < __stop___debug; desc++) {
-		if (file != NULL || name != NULL) {
-			if (g_strcmp0(desc->file, file) == 0) {
-				if (desc->name == NULL)
-					desc->name = name;
-			} else
-				file = NULL;
-		}
-
 		if (is_enabled(desc))
 			desc->flags |= OBEX_DEBUG_FLAG_PRINT;
 	}
-- 
2.5.0

