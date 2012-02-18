Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/8] map: Use ENOSYS to indicate not implemented function
Date: Sat, 18 Feb 2012 17:19:03 +0200
Message-Id: <1329578343-31663-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/mas.c              |    4 ++--
 plugins/messages-dummy.c   |   10 +++++-----
 plugins/messages-tracker.c |    8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 17e54d8..23b1823 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -501,7 +501,7 @@ static void *message_open(const char *name, int oflag, mode_t mode,
 
 	if (oflag != O_RDONLY) {
 		DBG("Message pushing unsupported");
-		*err = -EINVAL;
+		*err = -ENOSYS;
 
 		return NULL;
 	}
@@ -542,7 +542,7 @@ static void *any_open(const char *name, int oflag, mode_t mode,
 {
 	DBG("");
 
-	*err = -EINVAL;
+	*err = -ENOSYS;
 
 	return NULL;
 }
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index dd97ee1..511857e 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -93,7 +93,7 @@ int messages_set_notification_registration(void *session,
 			const struct messages_event *event, void *user_data),
 		void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_set_folder(void *s, const char *name, gboolean cdup)
@@ -147,7 +147,7 @@ int messages_get_folder_listing(void *session, const char *name, uint16_t max,
 					messages_folder_listing_cb callback,
 					void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_get_messages_listing(void *session, const char *name,
@@ -156,7 +156,7 @@ int messages_get_messages_listing(void *session, const char *name,
 				messages_get_messages_listing_cb callback,
 				void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_get_message(void *session, const char *handle,
@@ -164,13 +164,13 @@ int messages_get_message(void *session, const char *handle,
 					messages_get_message_cb callback,
 					void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 							void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 void messages_abort(void *session)
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 8d9d8bd..fb45210 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -185,7 +185,7 @@ int messages_set_notification_registration(void *session,
 			const struct messages_event *event, void *user_data),
 		void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_set_folder(void *s, const char *name, gboolean cdup)
@@ -310,7 +310,7 @@ int messages_get_messages_listing(void *session,
 				messages_get_messages_listing_cb callback,
 				void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_get_message(void *session, const char *handle,
@@ -318,13 +318,13 @@ int messages_get_message(void *session, const char *handle,
 				messages_get_message_cb callback,
 				void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 							void *user_data)
 {
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 void messages_abort(void *session)
-- 
1.7.7.6

