Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd] MAP: Add UpdateInbox Function
Date: Thu, 05 Jan 2012 15:13:52 +0530
Message-id: <1325756632-29335-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UpdateInbox function allows remote device to initiate an update of
the server's inbox, i.e. the Map server shall contact the network
to retrieve new messages if available. If the server does not allow
the network update it shall answer with a 'Not implemented'
error response.
---
 plugins/mas.c              |   32 +++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c   |    7 +++++++
 plugins/messages-tracker.c |   10 +++++++++-
 plugins/messages.h         |   14 ++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 3c3104c..639d0b6 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -503,6 +503,36 @@ static void *message_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void inbox_update_cb(void *session, int err, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	DBG("");
+
+	mas->finished = TRUE;
+
+	if (err < 0)
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+	else
+		obex_object_set_io_flags(mas, G_IO_OUT, 0);
+}
+
+static void *message_update_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	*err = messages_update_inbox(mas->backend_data, inbox_update_cb, mas);
+
+	if (*err < 0) {
+		mas->finished = TRUE;
+		return NULL;
+	} else
+		return mas;
+}
+
 static void *any_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
@@ -628,7 +658,7 @@ static struct obex_mime_type_driver mime_message_update = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/MAP-messageUpdate",
-	.open = any_open,
+	.open = message_update_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index e96b13b..58f04f6 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -173,3 +173,10 @@ int messages_get_message(void *session,
 void messages_abort(void *session)
 {
 }
+
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data)
+{
+	return -EINVAL;
+}
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 8f9b30a..6a68b5b 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -237,7 +237,8 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 	return 0;
 }
 
-static gboolean async_get_folder_listing(void *s) {
+static gboolean async_get_folder_listing(void *s)
+{
 	struct session *session = s;
 	gboolean count = FALSE;
 	int folder_count = 0;
@@ -324,3 +325,10 @@ int messages_get_message(void *session,
 void messages_abort(void *session)
 {
 }
+
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data)
+{
+	return -EINVAL;
+}
diff --git a/plugins/messages.h b/plugins/messages.h
index 6982edd..ea231a3 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -273,3 +273,17 @@ int messages_get_message(void *session,
  * session: Backend session.
  */
 void messages_abort(void *session);
+
+/*  Informs Message Server to Update Inbox via network
+ *
+ * session: Backend session.
+ * user_data: User data if any to be sent
+ * Callback shall be called for every update inbox request, where if any error
+ * should be reported to the remote end.
+ */
+typedef void (*messages_update_inbox_cb)(void *session, int err,
+		void *user_data);
+
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data);
-- 
1.7.0.4

