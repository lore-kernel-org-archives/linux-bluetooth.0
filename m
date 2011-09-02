Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 8/8] MAP Tracker: Refactor session struct
Date: Fri,  2 Sep 2011 10:58:00 +0200
Message-Id: <1314953880-4663-8-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Session struct grown to rather large size, and it become necessary to
reset some flags and counter for each request. After refactorization
there is one struct exclusive for each request and it is freed after
request is completed.
---
 plugins/messages-tracker.c |  154 ++++++++++++++++++++++++++------------------
 1 files changed, 90 insertions(+), 64 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 29f3ccd..ada4a42 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -113,9 +113,7 @@ struct message_folder {
 	char *query;
 };
 
-struct session {
-	char *cwd;
-	struct message_folder *folder;
+struct request {
 	char *name;
 	uint16_t max;
 	uint16_t offset;
@@ -134,6 +132,14 @@ struct session {
 	} cb;
 };
 
+struct session {
+	char *cwd;
+	struct message_folder *folder;
+	gboolean aborted;
+	void *event_user_data;
+	struct request *request;
+};
+
 static struct message_folder *folder_tree = NULL;
 static DBusConnection *session_connection = NULL;
 
@@ -280,7 +286,7 @@ static void query_reply(DBusPendingCall *call, void *user_data)
 		node = string_array_from_iter(element, QUERY_RESPONSE_SIZE);
 
 		if (node != NULL)
-			session->generate_response((const char **) node,
+			session->request->generate_response((const char **) node,
 								session);
 
 		g_free(node);
@@ -289,7 +295,7 @@ static void query_reply(DBusPendingCall *call, void *user_data)
 	}
 
 done:
-	session->generate_response(NULL, session);
+	session->request->generate_response(NULL, session);
 
 	dbus_message_unref(reply);
 }
@@ -659,6 +665,7 @@ static struct messages_message *pull_message_data(const char **reply)
 static void get_messages_listing_resp(const char **reply, void *user_data)
 {
 	struct session *session = user_data;
+	struct request *request = session->request;
 	struct messages_message *msg_data;
 
 	DBG("reply %p", reply);
@@ -667,44 +674,48 @@ static void get_messages_listing_resp(const char **reply, void *user_data)
 		goto done;
 
 	if (session->aborted)
-		return;
+		goto aborted;
 
 	msg_data = pull_message_data(reply);
 
-	session->size++;
+	request->size++;
 
 	if (!msg_data->read)
-			session->new_message = TRUE;
+			request->new_message = TRUE;
 
-	if (session->count == TRUE) {
+	if (request->count == TRUE) {
 		free_msg_data(msg_data);
 		return;
 	}
 
-	if (session->size > session->offset &&
-				filter_message(msg_data, session->filter))
-		session->cb.messages_list(session, -EAGAIN, 1,
-						session->new_message, msg_data,
-						session->user_data);
+	if (request->size > request->offset && filter_message(msg_data,
+							request->filter))
+		request->cb.messages_list(session, -EAGAIN, 1,
+						request->new_message, msg_data,
+						request->user_data);
 
 	free_msg_data(msg_data);
 	return;
 
 done:
-	session->cb.messages_list(session, 0, session->size,
-						session->new_message, NULL,
-						session->user_data);
-
-	g_free(session->filter->period_begin);
-	g_free(session->filter->period_end);
-	g_free(session->filter->originator);
-	g_free(session->filter->recipient);
-	g_free(session->filter);
+	request->cb.messages_list(session, 0, request->size,
+						request->new_message, NULL,
+						request->user_data);
+
+aborted:
+	g_free(request->filter->period_begin);
+	g_free(request->filter->period_end);
+	g_free(request->filter->originator);
+	g_free(request->filter->recipient);
+	g_free(request->filter);
+
+	g_free(request);
 }
 
 static void get_message_resp(const char **reply, void *s)
 {
 	struct session *session = s;
+	struct request *request = session->request;
 	struct messages_message *msg_data;
 	struct bmsg *bmsg;
 	char *final_bmsg, *status, *folder, *handle;
@@ -738,26 +749,27 @@ static void get_message_resp(const char **reply, void *s)
 
 	final_bmsg = bmsg_text(bmsg);
 
-	session->cb.message(session, 0, FALSE, final_bmsg, session->user_data);
+	request->cb.message(session, 0, FALSE, final_bmsg, request->user_data);
 
 	bmsg_destroy(bmsg);
 	g_free(folder);
 	g_free(final_bmsg);
 
-	session->count++;
+	request->count++;
 
 	return;
 
 done:
-	if (session->count == 0)
+	if (request->count == 0)
 		err = -ENOENT;
 	else
 		err = 0;
 
-	session->cb.message(session, err, FALSE, NULL, session->user_data);
+	request->cb.message(session, err, FALSE, NULL, request->user_data);
 
 aborted:
-	g_free(session->name);
+	g_free(request->name);
+	g_free(request);
 }
 
 int messages_init(void)
@@ -860,19 +872,20 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 
 static gboolean async_get_folder_listing(void *s) {
 	struct session *session = s;
+	struct request *request = session->request;
 	gboolean count = FALSE;
 	int folder_count = 0;
 	char *path = NULL;
 	struct message_folder *folder;
 	GSList *dir;
 
-	if (session->name && strchr(session->name, '/') != NULL)
-		goto done;
-
 	if (session->aborted)
 		goto aborted;
 
-	path = g_build_filename(session->cwd, session->name, NULL);
+	if (request->name && strchr(request->name, '/') != NULL)
+		goto done;
+
+	path = g_build_filename(session->cwd, request->name, NULL);
 
 	if (path == NULL || strlen(path) == 0)
 		goto done;
@@ -882,30 +895,32 @@ static gboolean async_get_folder_listing(void *s) {
 	if (folder == NULL)
 		goto done;
 
-	if (session->max == 0) {
-		session->max = 0xffff;
-		session->offset = 0;
+	if (request->max == 0) {
+		request->max = 0xffff;
+		request->offset = 0;
 		count = TRUE;
 	}
 
 	for (dir = folder->subfolders; dir &&
-				(folder_count - session->offset) < session->max;
+				(folder_count - request->offset) < request->max;
 				folder_count++, dir = g_slist_next(dir)) {
 		struct message_folder *dir_data = dir->data;
 
-		if (count == FALSE && session->offset <= folder_count)
-			session->cb.folder_list(session, -EAGAIN, 1,
-					dir_data->name, session->user_data);
+		if (count == FALSE && request->offset <= folder_count)
+			request->cb.folder_list(session, -EAGAIN, 1,
+							dir_data->name,
+							request->user_data);
 	}
 
 done:
-	session->cb.folder_list(session, 0, folder_count, NULL,
-							session->user_data);
+	request->cb.folder_list(session, 0, folder_count, NULL,
+							request->user_data);
 
 	g_free(path);
 
 aborted:
-	g_free(session->name);
+	g_free(request->name);
+	g_free(request);
 
 	return FALSE;
 }
@@ -916,12 +931,16 @@ int messages_get_folder_listing(void *s, const char *name,
 					void *user_data)
 {
 	struct session *session = s;
-	session->name = g_strdup(name);
-	session->max = max;
-	session->offset = offset;
-	session->cb.folder_list = callback;
-	session->user_data = user_data;
+	struct request *request = g_new0(struct request, 1);
+
+	request->name = g_strdup(name);
+	request->max = max;
+	request->offset = offset;
+	request->cb.folder_list = callback;
+	request->user_data = user_data;
+
 	session->aborted = FALSE;
+	session->request = request;
 
 	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, async_get_folder_listing,
 						session, NULL);
@@ -936,6 +955,7 @@ int messages_get_messages_listing(void *s, const char *name,
 				void *user_data)
 {
 	struct session *session = s;
+	struct request *request;
 	char *path, *query;
 	struct message_folder *folder = NULL;
 	DBusPendingCall *call;
@@ -964,21 +984,22 @@ int messages_get_messages_listing(void *s, const char *name,
 	if (query == NULL)
 		return -ENOENT;
 
-	session->filter = copy_messages_filter(filter);
-	session->generate_response = get_messages_listing_resp;
-	session->cb.messages_list = callback;
-	session->offset = offset;
-	session->max = max;
-	session->user_data = user_data;
-	session->new_message = FALSE;
-	session->count = FALSE;
-	session->size = 0;
+	request = g_new0(struct request, 1);
+
+	request->filter = copy_messages_filter(filter);
+	request->generate_response = get_messages_listing_resp;
+	request->cb.messages_list = callback;
+	request->offset = offset;
+	request->max = max;
+	request->user_data = user_data;
+
 	session->aborted = FALSE;
+	session->request = request;
 
 	if (max == 0) {
-		session->max = 0xffff;
-		session->offset = 0;
-		session->count = TRUE;
+		request->max = 0xffff;
+		request->offset = 0;
+		request->count = TRUE;
 	}
 
 	call = query_tracker(query, session, &err);
@@ -994,6 +1015,7 @@ int messages_get_message(void *s, const char *h, unsigned long flags,
 				messages_get_message_cb cb, void *user_data)
 {
 	struct session *session = s;
+	struct request *request;
 	DBusPendingCall *call;
 	int err = 0;
 	char *handle = strip_handle(h);
@@ -1013,12 +1035,16 @@ int messages_get_message(void *s, const char *h, unsigned long flags,
 		goto failed;
 	}
 
-	session->name = g_strdup(handle);
-	session->flags = flags;
-	session->cb.message = cb;
-	session->generate_response = get_message_resp;
-	session->user_data = user_data;
+	request = g_new0(struct request, 1);
+
+	request->name = g_strdup(handle);
+	request->flags = flags;
+	request->cb.message = cb;
+	request->generate_response = get_message_resp;
+	request->user_data = user_data;
+
 	session->aborted = FALSE;
+	session->request = request;
 
 	call = query_tracker(query, session, &err);
 	if (err == 0)
-- 
1.7.4.1

