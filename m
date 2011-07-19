Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/3] MAP: Folder listing for messages-dummy.c
Date: Tue, 19 Jul 2011 13:16:12 +0200
Message-Id: <1311074172-15953-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1311074172-15953-1-git-send-email-lkslawek@gmail.com>
References: <1311074172-15953-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c |  181 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 176 insertions(+), 5 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 295eb61..1cadb4d 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -25,10 +25,12 @@
 #include <config.h>
 #endif
 
+#include <dirent.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
 
+#include "log.h"
 #include "messages.h"
 
 static char *root_folder = NULL;
@@ -36,6 +38,16 @@ static char *root_folder = NULL;
 struct session {
 	char *cwd;
 	char *cwd_absolute;
+	void *request;
+};
+
+struct folder_listing_data {
+	struct session *session;
+	const char *name;
+	messages_folder_listing_cb callback;
+	void *user_data;
+	uint16_t max;
+	uint16_t offset;
 };
 
 int messages_init(void)
@@ -142,14 +154,167 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 	return 0;
 }
 
-int messages_get_folder_listing(void *session,
+/* NOTE: Neither IrOBEX nor MAP specs says that folder listing needs to
+ * be sorted (in IrOBEX examples it is not). However existing implementations
+ * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
+ * test suite requiring folder listing to be in that order.
+ */
+static gint folder_names_cmp(gconstpointer a, gconstpointer b,
+						gpointer user_data)
+{
+	static const char *order[] = {
+		"inbox", "outbox", "sent", "deleted", "draft", NULL
+	};
+	struct session *session = user_data;
+	int ia, ib;
+
+	if (g_strcmp0(session->cwd, "telecom/msg") == 0) {
+		for (ia = 0; order[ia]; ++ia) {
+			if (g_strcmp0(a, order[ia]) == 0)
+				break;
+		}
+		for (ib = 0; order[ib]; ++ib) {
+			if (g_strcmp0(b, order[ib]) == 0)
+				break;
+		}
+		if (ia != ib)
+			return ia - ib;
+	}
+
+	return g_strcmp0(a, b);
+}
+
+static int get_subdirs(struct folder_listing_data *fld, GSList **list,
+								uint16_t *n)
+{
+	DIR *dp;
+	struct dirent *ep;
+	char *path;
+	char *abs;
+	char *name;
+
+	*n = 0;
+
+	path = g_build_filename(fld->session->cwd_absolute, fld->name, NULL);
+	dp = opendir(path);
+
+	if (dp == NULL) {
+		int err = errno;
+
+		DBG("opendir(): %d, %s", err, strerror(err));
+		g_free(path);
+
+		return -err;
+	}
+
+	while ((ep = readdir(dp)) != NULL) {
+		if (ep->d_name[0] == '.' &&
+				(ep->d_name[1] == 0 || ep->d_name[1] == '.'))
+			continue;
+
+		abs = g_build_filename(path, ep->d_name,
+				NULL);
+
+		if (!g_file_test(abs, G_FILE_TEST_IS_DIR)) {
+			g_free(abs);
+			continue;
+		}
+
+		g_free(abs);
+		name = g_filename_to_utf8(ep->d_name, -1, NULL, NULL, NULL);
+
+		if (name == NULL) {
+			error("g_filename_to_utf8(): invalid filename");
+			continue;
+		}
+
+		++*n;
+
+		if (fld->max != 0)
+			*list = g_slist_prepend(*list, name);
+	}
+
+	closedir(dp);
+	g_free(path);
+
+	*list = g_slist_sort_with_data(*list, folder_names_cmp, fld->session);
+
+	return 0;
+}
+
+static gboolean get_folder_listing(void *d)
+{
+	struct folder_listing_data *fld = d;
+	struct session *session = fld->session;
+	uint16_t n;
+	uint16_t o;
+	GSList *list = NULL;
+	GSList *cur;
+	int err;
+
+	err = get_subdirs(fld, &list, &n);
+
+	if (err < 0) {
+		fld->callback(session, 0, err, NULL, fld->user_data);
+		return FALSE;
+	}
+
+	if (fld->max == 0) {
+		fld->callback(session, 0, n, NULL, fld->user_data);
+		return FALSE;
+	}
+
+	n = 0;
+	o = 0;
+
+	/* XXX: This isn't really documented for MAP. Need to take a look at
+	 * other implementations.
+	 */
+	if (session->cwd[0] != 0 && fld->offset == 0) {
+		++n;
+		fld->callback(session, 0, -EAGAIN, "..", fld->user_data);
+	} else {
+		++o;
+	}
+
+	for (cur = list; o < fld->offset; ++o) {
+		cur = cur->next;
+		if (cur == NULL)
+			break;
+	}
+
+	for (; cur != NULL && n < fld->max; cur = cur->next, ++n)
+		fld->callback(session, -EAGAIN, 0, cur->data, fld->user_data);
+
+	fld->callback(session, 0, 0, NULL, fld->user_data);
+
+	g_slist_free_full(list, g_free);
+
+	return FALSE;
+}
+
+int messages_get_folder_listing(void *s,
 		const char *name,
 		uint16_t max, uint16_t offset,
-		void (*callback)(void *session, int err, uint16_t size,
-			const char *name, void *user_data),
+		messages_folder_listing_cb callback,
 		void *user_data)
 {
-	return -EINVAL;
+	struct session *session = s;
+	struct folder_listing_data *fld;
+
+	fld = g_new0(struct folder_listing_data, 1);
+	fld->name = name;
+	fld->max = max;
+	fld->offset = offset;
+	fld->callback = callback;
+	fld->session = session;
+	fld->user_data = user_data;
+	session->request = fld;
+
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, get_folder_listing,
+				fld, g_free);
+
+	return 0;
 }
 
 int messages_get_messages_listing(void *session,
@@ -173,6 +338,12 @@ int messages_get_message(void *session,
 	return -EINVAL;
 }
 
-void messages_abort(void *session)
+void messages_abort(void *s)
 {
+	struct session *session = s;
+
+	if (session->request) {
+		g_idle_remove_by_data(session->request);
+		session->request = NULL;
+	}
 }
-- 
1.7.4.1

