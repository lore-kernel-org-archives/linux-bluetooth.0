Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 1/3] MAP/dummy: Actual code for folder listing retrieval
Date: Fri,  9 Mar 2012 07:53:23 +0100
Message-Id: <1331276005-4434-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v2: Changes as suggested on the ML

 plugins/messages-dummy.c |   63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index db15a75..8727951 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -31,6 +31,8 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "log.h"
+
 #include "messages.h"
 
 static char *root_folder = NULL;
@@ -50,9 +52,68 @@ struct folder_listing_data {
 	void *user_data;
 };
 
+static char *get_next_subdir(DIR *dp, char *path)
+{
+	struct dirent *ep;
+	char *abs, *name;
+
+	for (;;) {
+		if ((ep = readdir(dp)) == NULL)
+			return NULL;
+
+		if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
+			continue;
+
+		abs = g_build_filename(path, ep->d_name, NULL);
+
+		if (g_file_test(abs, G_FILE_TEST_IS_DIR)) {
+			g_free(abs);
+			break;
+		}
+
+		g_free(abs);
+	}
+
+	name = g_filename_to_utf8(ep->d_name, -1, NULL, NULL, NULL);
+
+	if (name == NULL) {
+		DBG("g_filename_to_utf8(): invalid filename");
+		return NULL;
+	}
+
+	return name;
+}
+
 static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
 {
-	return 0;
+	DIR *dp;
+	char *path, *name;
+	size_t n;
+
+	path = g_build_filename(fld->session->cwd_absolute, fld->name, NULL);
+	dp = opendir(path);
+
+	if (dp == NULL) {
+		int err = -errno;
+
+		DBG("opendir(): %d, %s", err, strerror(err));
+		g_free(path);
+
+		return err;
+	}
+
+	n = 0;
+
+	while ((name = get_next_subdir(dp, path)) != NULL) {
+		n++;
+		if (fld->max > 0)
+			*list = g_slist_prepend(*list, name);
+	}
+
+	closedir(dp);
+	g_free(path);
+
+	return n;
 }
 
 static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
-- 
1.7.4.1

