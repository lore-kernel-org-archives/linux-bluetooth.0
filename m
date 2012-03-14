Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v4 3/3] MAP/dummy: Add sorting of folder listing
Date: Wed, 14 Mar 2012 14:29:51 +0100
Message-Id: <1331731791-26685-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331731791-26685-1-git-send-email-lkslawek@gmail.com>
References: <1331731791-26685-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v4: Change pre- to post-increments
 plugins/messages-dummy.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 6b06e58..833c31c 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -52,6 +52,36 @@ struct folder_listing_data {
 	void *user_data;
 };
 
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
+		for (ia = 0; order[ia]; ia++) {
+			if (g_strcmp0(a, order[ia]) == 0)
+				break;
+		}
+		for (ib = 0; order[ib]; ib++) {
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
 static char *get_next_subdir(DIR *dp, char *path)
 {
 	struct dirent *ep;
@@ -113,6 +143,8 @@ static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
 	closedir(dp);
 	g_free(path);
 
+	*list = g_slist_sort_with_data(*list, folder_names_cmp, fld->session);
+
 	return n;
 }
 
-- 
1.7.4.1

