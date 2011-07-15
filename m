Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/2 v2] Add SetFolder function for MAP tracker backend
Date: Fri, 15 Jul 2011 14:29:46 +0200
Message-Id: <1310732986-7695-1-git-send-email-bulislaw@linux.com>
In-Reply-To: <20110714140834.GH2770@dell.ger.corp.intel.com>
References: <20110714140834.GH2770@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |  170 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 88e7493..de16337 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -26,27 +26,152 @@
 #endif
 
 #include <errno.h>
+#include <glib.h>
+#include <string.h>
 
 #include "messages.h"
 
+struct message_folder {
+	char *name;
+	GSList *subfolders;
+	char *query;
+};
+
+struct session {
+	char *cwd;
+	struct message_folder *folder;
+};
+
+static struct message_folder *folder_tree = NULL;
+
+static struct message_folder *get_folder(const char *folder)
+{
+	GSList *current = folder_tree->subfolders;
+	GSList *last;
+	int i;
+	char **path;
+
+	if (g_strcmp0(folder, "/") == 0)
+		return folder_tree;
+
+	path = g_strsplit(folder, "/", 0);
+
+	for (i = 1; path[i] != NULL; i++) {
+		GSList *l = current;
+		gboolean match_find = FALSE;
+
+		for (l = current; l != NULL; l = g_slist_next(l)) {
+			struct message_folder *l_data = l->data;
+
+			if (g_strcmp0(l_data->name, path[i]) == 0) {
+				match_find = TRUE;
+				last = l;
+				current = l_data->subfolders;
+
+				break;
+			}
+		}
+
+		if (!match_find) {
+			g_strfreev(path);
+			return NULL;
+		}
+	}
+
+	g_strfreev(path);
+	return last->data;
+}
+
+static struct message_folder *create_folder(const char *name, const char *query)
+{
+	struct message_folder *folder = g_new0(struct message_folder, 1);
+
+	folder->name = g_strdup(name);
+	folder->query = g_strdup(query);
+
+	return folder;
+}
+
+static void destroy_folder_tree(void *root)
+{
+	struct message_folder *folder = root;
+	GSList *tmp, *next;
+
+	if (folder == NULL)
+		return;
+
+	g_free(folder->name);
+	g_free(folder->query);
+
+	tmp = folder->subfolders;
+	while (tmp != NULL) {
+		next = g_slist_next(tmp);
+		destroy_folder_tree(tmp->data);
+		tmp = next;
+	}
+
+	g_slist_free(folder->subfolders);
+	g_free(folder);
+}
+
+static void create_folder_tree()
+{
+	struct message_folder *parent, *child;
+
+	folder_tree = create_folder("/", NULL);
+
+	parent = create_folder("telecom", NULL);
+	folder_tree->subfolders = g_slist_append(folder_tree->subfolders,
+								parent);
+
+	child = create_folder("msg", NULL);
+	parent->subfolders = g_slist_append(parent->subfolders, child);
+
+	parent = child;
+
+	child = create_folder("inbox", "?msg nmo:isSent \"false\" ; "
+				"nmo:isDeleted \"false\" ; "
+				"nmo:isDraft \"false\". ");
+	parent->subfolders = g_slist_append(parent->subfolders, child);
+
+	child = create_folder("sent", "?msg nmo:isDeleted \"false\" ; "
+				"nmo:isSent \"true\" . ");
+	parent->subfolders = g_slist_append(parent->subfolders, child);
+
+	child = create_folder("deleted", "?msg nmo:isDeleted \"true\" . ");
+	parent->subfolders = g_slist_append(parent->subfolders, child);
+}
+
 int messages_init(void)
 {
+	create_folder_tree();
+
 	return 0;
 }
 
 void messages_exit(void)
 {
+	destroy_folder_tree(folder_tree);
 }
 
 int messages_connect(void **s)
 {
-	*s = NULL;
+	struct session *session = g_new0(struct session, 1);
+
+	session->cwd = g_strdup("/");
+	session->folder = folder_tree;
+
+	*s = session;
 
 	return 0;
 }
 
 void messages_disconnect(void *s)
 {
+	struct session *session = s;
+
+	g_free(session->cwd);
+	g_free(session);
 }
 
 int messages_set_notification_registration(void *session,
@@ -59,7 +184,48 @@ int messages_set_notification_registration(void *session,
 
 int messages_set_folder(void *s, const char *name, gboolean cdup)
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
+									NULL);
+	g_free(tmp);
+
+	newabs = g_build_filename("/", newrel, NULL);
+
+	session->folder = get_folder(newabs);
+	if (session->folder == NULL) {
+		g_free(newrel);
+		g_free(newabs);
+
+		return -ENOENT;
+	}
+
+	g_free(newrel);
+	g_free(session->cwd);
+	session->cwd = newabs;
+
+	return 0;
 }
 
 int messages_get_folder_listing(void *session,
-- 
1.7.4.1

