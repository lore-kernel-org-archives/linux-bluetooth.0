Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/5] MAP/dummy: Add stub for asynchronous folder listing
Date: Tue,  6 Mar 2012 18:42:24 +0100
Message-Id: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 511857e..3ba333c 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -36,8 +36,23 @@ static char *root_folder = NULL;
 struct session {
 	char *cwd;
 	char *cwd_absolute;
+	void *request;
 };
 
+struct folder_listing_data {
+	struct session *session;
+	const char *name;
+	uint16_t max;
+	uint16_t offset;
+	messages_folder_listing_cb callback;
+	void *user_data;
+};
+
+static gboolean get_folder_listing(void *d)
+{
+	return FALSE;
+}
+
 int messages_init(void)
 {
 	char *tmp;
@@ -142,12 +157,28 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 	return 0;
 }
 
-int messages_get_folder_listing(void *session, const char *name, uint16_t max,
+int messages_get_folder_listing(void *s, const char *name, uint16_t max,
 					uint16_t offset,
 					messages_folder_listing_cb callback,
 					void *user_data)
 {
-	return -ENOSYS;
+	struct session *session =  s;
+	struct folder_listing_data *fld;
+
+	fld = g_new0(struct folder_listing_data, 1);
+	fld->session = session;
+	fld->name = name;
+	fld->max = max;
+	fld->offset = offset;
+	fld->callback = callback;
+	fld->user_data = user_data;
+
+	session->request = fld;
+
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, get_folder_listing,
+								fld, g_free);
+
+	return 0;
 }
 
 int messages_get_messages_listing(void *session, const char *name,
@@ -173,6 +204,12 @@ int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 	return -ENOSYS;
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
1.7.5.1

