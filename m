Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 1/2] tools: Fix workaround to build with recent flex
Date: Sun, 29 Jul 2012 03:30:34 -0300
Message-Id: <1343543435-8429-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Flex 2.5.36 no longer defines isatty(), resulting in the following build
error:

	tools/lexer.c:1402:9: error: implicit declaration of function
	‘isatty’ [-Werror=implicit-function-declaration]

Include the header unistd.h so we get the definition of that function
and at the same time keep the fix for older versions of flex, since this
header defines _UNISTD_H.
---
 tools/lexer.l | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/lexer.l b/tools/lexer.l
index ff9ce81..0d449ac 100644
--- a/tools/lexer.l
+++ b/tools/lexer.l
@@ -26,9 +26,7 @@
 #include <config.h>
 #endif
 
-/* Nasty workaround, but flex defines isatty() twice */
-#define _UNISTD_H
-
+#include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
 #include <sys/socket.h>
-- 
1.7.11.3

