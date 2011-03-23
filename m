Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 1/2] Add messages backend initialization and finalization
Date: Wed, 23 Mar 2011 14:56:19 +0100
Message-Id: <1300888580-19317-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1300888580-19317-1-git-send-email-lkslawek@gmail.com>
References: <1300888580-19317-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds functions for initializing and freeing resources used by
message storage access backend and example implementation in the dummy
(or rather - filesystem) backend.

Dummy backend uses $HOME/map-messages for its message storage. This
directory should at least contain basic folders required by the MAP
specification. It represents the root as seen from the perspective of
MAP client. You can prepare it as follows:

$ MAPROOT=$HOME/map-messages
$ mkdir -p "$MAPROOT/telecom/msg/inbox"
$ mkdir "$MAPROOT/telecom/msg/sent"
$ mkdir "$MAPROOT/telecom/msg/deleted"
$ mkdir "$MAPROOT/telecom/msg/outbox"
---
 plugins/mas.c            |    8 ++++++++
 plugins/messages-dummy.c |   31 +++++++++++++++++++++++++++++++
 plugins/messages.h       |    4 ++++
 3 files changed, 43 insertions(+), 0 deletions(-)

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
index fd9679d..9bb1ba1 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -25,4 +25,35 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <stdlib.h>
+
 #include "messages.h"
+
+static char *root_folder = NULL;
+
+int messages_init(void)
+{
+	char *home;
+
+	if (root_folder)
+		return 0;
+
+	home = getenv("HOME");
+	if (!home)
+		return -1;
+
+	/* XXX: It would be great to have per plugin parameters support, for
+	 * example $ obexd --mas=param1=value1:param2:param3, so user would be
+	 * able to select different root directory.
+	 */
+	root_folder = g_build_filename(home, "map-messages", NULL);
+
+	return 0;
+}
+
+void messages_exit(void)
+{
+	g_free(root_folder);
+	root_folder = NULL;
+}
diff --git a/plugins/messages.h b/plugins/messages.h
index c510244..65e2274 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -20,3 +20,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+int messages_init(void);
+
+void messages_exit(void);
-- 
1.7.1

