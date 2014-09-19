Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/13] sap: Fix compilation errors with musl
Date: Fri, 19 Sep 2014 16:10:04 +0200
Message-Id: <1411135816-18966-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix multiple errors similar to:

profiles/sap/sap-u8500.c: In function 'send_request':
profiles/sap/sap-u8500.c:288:3: error: implicit declaration of
    function 'strerror' [-Werror=implicit-function-declaration]
   sap_error("sending request failed: %s", strerror(ENOMEM));
   ^
profiles/sap/sap-u8500.c:288:3: error: format '%s' expects argument
    of type 'char *', but argument 2 has type 'int' [-Werror=format=]
profiles/sap/sap-u8500.c:297:3: error: implicit declaration of function
    'memcpy' [-Werror=implicit-function-declaration]
   memcpy(msg->payload, param->val, param->len);
   ^
---
 profiles/sap/sap-u8500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/sap/sap-u8500.c b/profiles/sap/sap-u8500.c
index d043029..5417d59 100644
--- a/profiles/sap/sap-u8500.c
+++ b/profiles/sap/sap-u8500.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <glib.h>
+#include <string.h>
 
 #include <sys/socket.h>
 #include <sys/un.h>
-- 
1.9.3

