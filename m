Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/5] MAP: Add typedef for folder listing callback
Date: Fri,  2 Sep 2011 10:57:40 +0200
Message-Id: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c |    3 +--
 plugins/messages.h       |    6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 295eb61..408651e 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -145,8 +145,7 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 int messages_get_folder_listing(void *session,
 		const char *name,
 		uint16_t max, uint16_t offset,
-		void (*callback)(void *session, int err, uint16_t size,
-			const char *name, void *user_data),
+		messages_folder_listing_cb callback,
 		void *user_data)
 {
 	return -EINVAL;
diff --git a/plugins/messages.h b/plugins/messages.h
index c862b07..d9348c7 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -202,11 +202,13 @@ int messages_set_folder(void *session, const char *name, gboolean cdup);
  * Callback shall be called for every entry of the listing. 'name' is the
  * subdirectory name.
  */
+typedef void (*messages_folder_listing_cb)(void *session, int err,
+		uint16_t size, const char *name, void *user_data);
+
 int messages_get_folder_listing(void *session,
 		const char *name,
 		uint16_t max, uint16_t offset,
-		void (*callback)(void *session, int err, uint16_t size,
-			const char *name, void *user_data),
+		messages_folder_listing_cb callback,
 		void *user_data);
 
 /* Retrieves messages listing from a current directory.
-- 
1.7.4.1

