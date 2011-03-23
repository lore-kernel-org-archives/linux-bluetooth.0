Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 2/2] Message Access Profile: SetFolder function
Date: Wed, 23 Mar 2011 14:56:20 +0100
Message-Id: <1300888580-19317-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1300888580-19317-1-git-send-email-lkslawek@gmail.com>
References: <1300888580-19317-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for MAP SetFolder function (served by OBEX SetPath
request).

Current directory is kept in plugin code. Storage backend offers
messages_dir_exists() function which is used by MAP plugin to check
whether new path is correct.
---
 plugins/mas.c            |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c |   17 +++++++++++++++++
 plugins/messages.h       |    2 ++
 3 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 243d2f6..1d33ca1 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -27,6 +27,7 @@
 
 #include <errno.h>
 #include <glib.h>
+#include <string.h>
 #include <openobex/obex.h>
 
 #include "plugin.h"
@@ -87,6 +88,7 @@
 </record>"
 
 struct mas_session {
+	char *cwd;
 	struct mas_request *request;
 };
 
@@ -96,6 +98,7 @@ static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 
 static void mas_clean(struct mas_session *mas)
 {
+	g_free(mas->cwd);
 	g_free(mas);
 }
 
@@ -108,6 +111,7 @@ static void *mas_connect(struct obex_session *os, int *err)
 	*err = 0;
 
 	mas = g_new0(struct mas_session, 1);
+	mas->cwd = g_strdup("");
 
 	manager_register_session(os);
 
@@ -173,9 +177,48 @@ failed:
 	return ret;
 }
 
+static int set_folder(struct mas_session *mas, const char *name, int cdup)
+{
+	char *newcwd = NULL;
+	char *tmp;
+
+	if (name && (strchr(name, '/') || strcmp(name, "..") == 0))
+		return -EBADR;
+
+	if (cdup) {
+		if (mas->cwd[0] == 0)
+			return -ENOENT;
+
+		newcwd = g_path_get_dirname(mas->cwd);
+
+		/* We use empty string for indication of the root directory */
+		if (newcwd[0] == '.' && newcwd[1] == 0)
+			newcwd[0] = 0;
+	}
+
+	tmp = newcwd;
+	if (!cdup && (!name || name[0] == 0))
+		newcwd = g_strdup("");
+	else
+		newcwd = g_build_filename(newcwd ? newcwd : mas->cwd, name,
+					NULL);
+	g_free(tmp);
+
+	if (!messages_dir_exists(newcwd)) {
+		g_free(newcwd);
+		return -ENOENT;
+	}
+
+	g_free(mas->cwd);
+	mas->cwd = newcwd;
+
+	return 0;
+}
+
 static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 		void *user_data)
 {
+	struct mas_session *mas = user_data;
 	const char *name;
 	uint8_t *nonhdr;
 
@@ -193,7 +236,7 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 		return -EBADR;
 	}
 
-	return 0;
+	return set_folder(mas, name, nonhdr[0] & 0x01);
 }
 
 static void *any_open(const char *name, int oflag, mode_t mode,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 9bb1ba1..805ce80 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -57,3 +57,20 @@ void messages_exit(void)
 	g_free(root_folder);
 	root_folder = NULL;
 }
+
+gboolean messages_dir_exists(const char *path)
+{
+	char *abs;
+	gboolean ret;
+
+	abs = g_build_filename(root_folder, path, NULL);
+
+	if (g_file_test(abs, G_FILE_TEST_IS_DIR))
+		ret = TRUE;
+	else
+		ret = FALSE;
+
+	g_free(abs);
+
+	return ret;
+}
diff --git a/plugins/messages.h b/plugins/messages.h
index 65e2274..dccdb74 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -24,3 +24,5 @@
 int messages_init(void);
 
 void messages_exit(void);
+
+gboolean messages_dir_exists(const char *path);
-- 
1.7.1

