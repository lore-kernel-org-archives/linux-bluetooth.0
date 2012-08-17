Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 2/2] MAP: Add subject length parameter in
 GetMessageListing
Date: Fri, 17 Aug 2012 20:38:17 +0530
Message-id: <1345216097-8459-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add subject length parameter to allow MAP server to
create subject as per MAP client length preference.
---
 plugins/mas.c              |    7 ++++++-
 plugins/messages-dummy.c   |    1 +
 plugins/messages-tracker.c |    4 ++--
 plugins/messages.h         |    2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 57d9611..1c9199d 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -559,6 +559,9 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 	/* 1024 is the default when there was no MaxListCount sent */
 	uint16_t max = 1024;
 	uint16_t offset = 0;
+	/* If MAP client does not specify the subject length,
+	   then subject_len = 0 and subject should be sent unaltered. */
+	uint8_t subject_len = 0;
 
 	DBG("");
 
@@ -569,6 +572,8 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 
 	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
 	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+	g_obex_apparam_get_uint8(mas->inparams, MAP_AP_SUBJECTLENGTH,
+						&subject_len);
 
 	g_obex_apparam_get_uint32(mas->inparams, MAP_AP_PARAMETERMASK,
 						&filter.parameter_mask);
@@ -588,7 +593,7 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 						&filter.priority);
 
 	*err = messages_get_messages_listing(mas->backend_data, name, max,
-			offset, &filter,
+			offset, subject_len, &filter,
 			get_messages_listing_cb, mas);
 
 	mas->buffer = g_string_new("");
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 833c31c..a47f143 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -331,6 +331,7 @@ int messages_get_folder_listing(void *s, const char *name, uint16_t max,
 
 int messages_get_messages_listing(void *session, const char *name,
 				uint16_t max, uint16_t offset,
+				uint8_t subject_len,
 				const struct messages_filter *filter,
 				messages_get_messages_listing_cb callback,
 				void *user_data)
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index fb45210..92c1767 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -303,9 +303,9 @@ int messages_get_folder_listing(void *s, const char *name,
 	return 0;
 }
 
-int messages_get_messages_listing(void *session,
-				const char *name,
+int messages_get_messages_listing(void *session, const char *name,
 				uint16_t max, uint16_t offset,
+				uint8_t subject_len,
 				const struct messages_filter *filter,
 				messages_get_messages_listing_cb callback,
 				void *user_data)
diff --git a/plugins/messages.h b/plugins/messages.h
index beca3a8..669f7c2 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -216,6 +216,7 @@ int messages_get_folder_listing(void *session, const char *name, uint16_t max,
  * name: Optional subdirectory name.
  * max: Maximum number of entries to retrieve.
  * offset: Offset of the first entry.
+ * subject_len: Maximum string length of the "subject" parameter in the entries.
  * filter: Filter to apply on returned message listing.
  * size: Total size of listing to be returned.
  * newmsg: Indicates presence of unread messages.
@@ -230,6 +231,7 @@ typedef void (*messages_get_messages_listing_cb)(void *session, int err,
 
 int messages_get_messages_listing(void *session, const char *name,
 				uint16_t max, uint16_t offset,
+				uint8_t subject_len,
 				const struct messages_filter *filter,
 				messages_get_messages_listing_cb callback,
 				void *user_data);
-- 
1.7.9.5

