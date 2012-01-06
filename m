Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd] MAP: Add UpdateInbox Function
Date: Fri, 06 Jan 2012 19:01:56 +0530
Message-id: <1325856716-17943-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UpdateInbox function allows remote device to initiate an update of
the MSE inbox, i.e. the MSE shall contact the network to retrieve
new messages if available. If MSE does not support the network
update it shall answer with a 'Not implemented' error response.
---
 plugins/mas.c              |   37 ++++++++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c   |    7 +++++++
 plugins/messages-tracker.c |    7 +++++++
 plugins/messages.h         |   13 +++++++++++++
 4 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 3c3104c..38842e0 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -406,6 +406,20 @@ proceed:
 		obex_object_set_io_flags(mas, G_IO_IN, err);
 }
 
+static void update_inbox_cb(void *session, int err, void *user_data)
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
 static int mas_setpath(struct obex_session *os, void *user_data)
 {
 	const char *name;
@@ -503,6 +517,27 @@ static void *message_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void *message_update_open(const char *name, int oflag, mode_t mode,
+					void *driver_data, size_t *size,
+					int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	if (oflag != O_WRONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	*err = messages_update_inbox(mas->backend_data, update_inbox_cb, mas);
+
+	if (*err < 0)
+		return NULL;
+	else
+		return mas;
+}
+
 static void *any_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
@@ -628,7 +663,7 @@ static struct obex_mime_type_driver mime_message_update = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/MAP-messageUpdate",
-	.open = any_open,
+	.open = message_update_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index e96b13b..ef1d946 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -170,6 +170,13 @@ int messages_get_message(void *session,
 	return -EINVAL;
 }
 
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data)
+{
+	return -EINVAL;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 8f9b30a..713df0c 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -321,6 +321,13 @@ int messages_get_message(void *session,
 	return -EINVAL;
 }
 
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data)
+{
+	return -EINVAL;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages.h b/plugins/messages.h
index 6982edd..705615e 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -268,6 +268,19 @@ int messages_get_message(void *session,
 		messages_get_message_cb callback,
 		void *user_data);
 
+/* Informs Message Server to Update Inbox via network.
+ *
+ * session: Backend session.
+ * user_data: User data if any to be sent.
+ * Callback shall be called for every update inbox request recieved from MCE.
+ */
+typedef void (*messages_update_inbox_cb)(void *session, int err,
+		void *user_data);
+
+int messages_update_inbox(void *session,
+		messages_update_inbox_cb callback,
+		void *user_data);
+
 /* Aborts currently pending request.
  *
  * session: Backend session.
-- 
1.7.0.4

