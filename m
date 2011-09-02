Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 5/5] MAP: Use pointers to const where appropriate
Date: Fri,  2 Sep 2011 10:57:44 +0200
Message-Id: <1314953864-25686-5-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
References: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c   |    5 +++--
 plugins/messages-tracker.c |   26 +++++++++++---------------
 plugins/messages.h         |    5 +++--
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 9295864..e96b13b 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -90,7 +90,7 @@ void messages_disconnect(void *s)
 
 int messages_set_notification_registration(void *session,
 		void (*send_event)(void *session,
-			struct messages_event *event, void *user_data),
+			const struct messages_event *event, void *user_data),
 		void *user_data)
 {
 	return -EINVAL;
@@ -153,7 +153,8 @@ int messages_get_folder_listing(void *session,
 
 int messages_get_messages_listing(void *session,
 		const char *name,
-		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		uint16_t max, uint16_t offset,
+		const struct messages_filter *filter,
 		messages_get_messages_listing_cb callback,
 		void *user_data)
 {
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 22d923d..43321f6 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -182,7 +182,7 @@ void messages_disconnect(void *s)
 
 int messages_set_notification_registration(void *session,
 		void (*send_event)(void *session,
-			struct messages_event *event, void *user_data),
+			const struct messages_event *event, void *user_data),
 		void *user_data)
 {
 	return -EINVAL;
@@ -280,12 +280,10 @@ static gboolean async_get_folder_listing(void *s) {
 	return FALSE;
 }
 
-int messages_get_folder_listing(void *s,
-		const char *name,
-		uint16_t max, uint16_t offset,
-		void (*callback)(void *session, int err, uint16_t size,
-			const char *name, void *user_data),
-		void *user_data)
+int messages_get_folder_listing(void *s, const char *name,
+					uint16_t max, uint16_t offset,
+					messages_folder_listing_cb callback,
+					void *user_data)
 {
 	struct session *session = s;
 	session->name = name;
@@ -301,12 +299,11 @@ int messages_get_folder_listing(void *s,
 }
 
 int messages_get_messages_listing(void *session,
-		const char *name,
-		uint16_t max, uint16_t offset, struct messages_filter *filter,
-		void (*callback)(void *session, int err, uint16_t size,
-			gboolean newmsg, const struct messages_message *message,
-			void *user_data),
-		void *user_data)
+				const char *name,
+				uint16_t max, uint16_t offset,
+				const struct messages_filter *filter,
+				messages_get_messages_listing_cb callback,
+				void *user_data)
 {
 	return -EINVAL;
 }
@@ -314,8 +311,7 @@ int messages_get_messages_listing(void *session,
 int messages_get_message(void *session,
 		const char *handle,
 		unsigned long flags,
-		void (*callback)(void *session, int err, gboolean fmore,
-			const char *chunk, void *user_data),
+		messages_get_message_cb callback,
 		void *user_data)
 {
 	return -EINVAL;
diff --git a/plugins/messages.h b/plugins/messages.h
index 9e0b091..6982edd 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -179,7 +179,7 @@ void messages_disconnect(void *session);
  */
 int messages_set_notification_registration(void *session,
 		void (*send_event)(void *session,
-			struct messages_event *event, void *user_data),
+			const struct messages_event *event, void *user_data),
 		void *user_data);
 
 /* Changes current directory.
@@ -230,7 +230,8 @@ typedef void (*messages_get_messages_listing_cb)(void *session, int err,
 
 int messages_get_messages_listing(void *session,
 		const char *name,
-		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		uint16_t max, uint16_t offset,
+		const struct messages_filter *filter,
 		messages_get_messages_listing_cb callback,
 		void *user_data);
 
-- 
1.7.4.1

