Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 1/2] Add messages backend initialization and finalization
Date: Mon, 23 May 2011 16:01:19 +0200
Message-Id: <1306159280-19889-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds functions for initializing and freeing resources used by
message storage access backend and example implementation in the dummy
(or rather - filesystem) backend.

Dummy backend uses $MAP_ROOT (if set) and falls back to
$HOME/map-messages for its message storage. This directory should at
least contain basic folders required by the MAP specification. It
represents the root as seen from the perspective of MAP client. You can
prepare it as follows:

$ mkdir -p "$MAP_ROOT/telecom/msg/inbox"
$ mkdir "$MAP_ROOT/telecom/msg/sent"
$ mkdir "$MAP_ROOT/telecom/msg/deleted"
$ mkdir "$MAP_ROOT/telecom/msg/outbox"
---
 plugins/mas.c            |    8 ++++++++
 plugins/messages-dummy.c |   22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index a84b8fd..243d2f6 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -261,6 +261,10 @@ static int mas_init(void)
 {
 	int err;
 
+	err = messages_init();
+	if (err < 0)
+		goto failed_messages_init;
+
 	err = obex_mime_type_driver_register(&mime_map);
 	if (err < 0)
 		goto failed_mime;
@@ -275,6 +279,9 @@ failed_mas_reg:
 	obex_mime_type_driver_unregister(&mime_map);
 
 failed_mime:
+	messages_exit();
+
+failed_messages_init:
 	return err;
 }
 
@@ -282,6 +289,7 @@ static void mas_exit(void)
 {
 	obex_service_driver_unregister(&mas);
 	obex_mime_type_driver_unregister(&mime_map);
+	messages_exit();
 }
 
 OBEX_PLUGIN_DEFINE(mas, mas_init, mas_exit)
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index a536d81..7b2e1a1 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -26,16 +26,38 @@
 #endif
 
 #include <errno.h>
+#include <stdlib.h>
 
 #include "messages.h"
 
+static char *root_folder = NULL;
+
 int messages_init(void)
 {
+	char *tmp;
+
+	if (root_folder)
+		return 0;
+
+	tmp = getenv("MAP_ROOT");
+	if (tmp) {
+		root_folder = g_strdup(tmp);
+		return 0;
+	}
+
+	tmp = getenv("HOME");
+	if (!tmp)
+		return -1;
+
+	root_folder = g_build_filename(tmp, "map-messages", NULL);
+
 	return 0;
 }
 
 void messages_exit(void)
 {
+	g_free(root_folder);
+	root_folder = NULL;
 }
 
 int messages_connect(void **session)
-- 
1.7.4.1

