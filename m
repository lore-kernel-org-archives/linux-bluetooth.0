Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 2/2] Add MAP session management and SetFolder function
Date: Mon, 23 May 2011 16:01:20 +0200
Message-Id: <1306159280-19889-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1306159280-19889-1-git-send-email-lkslawek@gmail.com>
References: <1306159280-19889-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c            |   16 ++++++++--
 plugins/messages-dummy.c |   69 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 243d2f6..8775934 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -88,6 +88,7 @@
 
 struct mas_session {
 	struct mas_request *request;
+	void *backend_data;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -105,13 +106,20 @@ static void *mas_connect(struct obex_session *os, int *err)
 
 	DBG("");
 
-	*err = 0;
-
 	mas = g_new0(struct mas_session, 1);
 
+	*err = messages_connect(&mas->backend_data);
+	if (*err < 0)
+		goto failed;
+
 	manager_register_session(os);
 
 	return mas;
+
+failed:
+	g_free(mas);
+
+	return NULL;
 }
 
 static void mas_disconnect(struct obex_session *os, void *user_data)
@@ -121,6 +129,7 @@ static void mas_disconnect(struct obex_session *os, void *user_data)
 	DBG("");
 
 	manager_unregister_session(os);
+	messages_disconnect(mas->backend_data);
 
 	mas_clean(mas);
 }
@@ -178,6 +187,7 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 {
 	const char *name;
 	uint8_t *nonhdr;
+	struct mas_session *mas = user_data;
 
 	if (OBEX_ObjectGetNonHdrData(obj, &nonhdr) != 2) {
 		error("Set path failed: flag and constants not found!");
@@ -193,7 +203,7 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 		return -EBADR;
 	}
 
-	return 0;
+	return messages_set_folder(mas->backend_data, name, nonhdr[0] & 0x01);
 }
 
 static void *any_open(const char *name, int oflag, mode_t mode,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 7b2e1a1..3b5c98e 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -27,11 +27,17 @@
 
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "messages.h"
 
 static char *root_folder = NULL;
 
+struct session {
+	char *cwd;
+	char *cwd_absolute;
+};
+
 int messages_init(void)
 {
 	char *tmp;
@@ -60,14 +66,26 @@ void messages_exit(void)
 	root_folder = NULL;
 }
 
-int messages_connect(void **session)
+int messages_connect(void **s)
 {
-	*session = 0;
+	struct session *session;
+
+	session = g_new0(struct session, 1);
+	session->cwd = g_strdup("");
+	session->cwd_absolute = g_strdup(root_folder);
+
+	*s = session;
+
 	return 0;
 }
 
-void messages_disconnect(void *session)
+void messages_disconnect(void *s)
 {
+	struct session *session = s;
+
+	g_free(session->cwd);
+	g_free(session->cwd_absolute);
+	g_free(session);
 }
 
 int messages_set_notification_registration(void *session,
@@ -78,9 +96,50 @@ int messages_set_notification_registration(void *session,
 	return -EINVAL;
 }
 
-int messages_set_folder(void *session, const char *name, gboolean cdup)
+int messages_set_folder(void *s, const char *name, gboolean cdup)
 {
-	return -EINVAL;
+	struct session *session = s;
+	char *newrel = NULL;
+	char *newabs;
+	char *tmp;
+
+	if (name && (strchr(name, '/') || strcmp(name, "..") == 0))
+		return -EBADR;
+
+	if (cdup) {
+		if (session->cwd[0] == 0)
+			return -ENOENT;
+
+		newrel = g_path_get_dirname(session->cwd);
+
+		/* We use empty string for indication of the root directory */
+		if (newrel[0] == '.' && newrel[1] == 0)
+			newrel[0] = 0;
+	}
+
+	tmp = newrel;
+	if (!cdup && (!name || name[0] == 0))
+		newrel = g_strdup("");
+	else
+		newrel = g_build_filename(newrel ? newrel : session->cwd, name,
+				NULL);
+	g_free(tmp);
+
+	newabs = g_build_filename(root_folder, newrel, NULL);
+
+	if (!g_file_test(newabs, G_FILE_TEST_IS_DIR)) {
+		g_free(newrel);
+		g_free(newabs);
+		return -ENOENT;
+	}
+
+	g_free(session->cwd);
+	session->cwd = newrel;
+
+	g_free(session->cwd_absolute);
+	session->cwd_absolute = newabs;
+
+	return 0;
 }
 
 int messages_get_folder_listing(void *session,
-- 
1.7.4.1

