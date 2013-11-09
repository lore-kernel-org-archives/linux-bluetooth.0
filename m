Return-Path: <cyrus@holtmann.org>
Message-ID: <1384016598.3880.38.camel@nuvo>
Subject: [PATCH 3/3] obex: Use XDG_RUNTIME_DIR as a default root
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Nov 2013 18:03:18 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


It's per-user, so we won't try to overwrite somebody else's
files in /tmp when that happens.
---
 obexd/src/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index 61a06b2..15777f5 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -50,8 +50,6 @@
 #include "obexd.h"
 #include "server.h"
 
-#define DEFAULT_ROOT_PATH "/tmp"
-
 #define DEFAULT_CAP_FILE CONFIGDIR "/capability.xml"
 
 static GMainLoop *main_loop = NULL;
@@ -286,7 +284,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (option_root == NULL)
-		option_root = g_strdup(DEFAULT_ROOT_PATH);
+		option_root = g_build_filename (g_get_user_runtime_dir (), "obexd", NULL);
 
 	if (option_root[0] != '/') {
 		char *old_root = option_root, *home = getenv("HOME");
-- 
1.8.4.2


