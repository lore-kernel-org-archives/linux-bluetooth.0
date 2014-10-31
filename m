Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/2] shared/hfp: Remove reduntant check
Date: Fri, 31 Oct 2014 10:32:32 +0100
Message-Id: <1414747952-22446-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To make this check strcmp is good enought. Not need to check len first
and then do memory compare.
---
 src/shared/hfp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 9a66ed2..0ce38cc 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -135,10 +135,7 @@ static bool match_handler_prefix(const void *a, const void *b)
 	const struct cmd_handler *handler = a;
 	const char *prefix = b;
 
-	if (strlen(handler->prefix) != strlen(prefix))
-		return false;
-
-	if (memcmp(handler->prefix, prefix, strlen(prefix)))
+	if (strcmp(handler->prefix, prefix) != 0)
 		return false;
 
 	return true;
-- 
1.8.4

