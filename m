Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 2/3] Add MSETime application parameter
Date: Thu, 08 Nov 2012 16:14:41 +0530
Message-id: <1352371481-18074-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MSETime application parameter shall be used in the response
to report the Local Time basis of the MSE.
---
 plugins/mas.c      |    4 +++-
 plugins/messages.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 319c87f..bdf2b6b 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -284,7 +284,7 @@ static const char *yesorno(gboolean a)
 }
 
 static void get_messages_listing_cb(void *session, int err, uint16_t size,
-					gboolean newmsg,
+					gboolean newmsg, gchar *msetime,
 					const struct messages_message *entry,
 					void *user_data)
 {
@@ -403,6 +403,8 @@ proceed:
 		mas->outparams = g_obex_apparam_set_uint8(mas->outparams,
 						MAP_AP_NEWMESSAGE,
 						newmsg ? 1 : 0);
+		mas->outparams = g_obex_apparam_set_string(mas->outparams,
+						MAP_AP_MSETIME, msetime);
 	}
 
 	if (err != -EAGAIN)
diff --git a/plugins/messages.h b/plugins/messages.h
index 00a16b1..2ab4ba1 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -226,6 +226,7 @@ int messages_get_folder_listing(void *session, const char *name, uint16_t max,
  */
 typedef void (*messages_get_messages_listing_cb)(void *session, int err,
 					uint16_t size, gboolean newmsg,
+					gchar *msetime,
 					const struct messages_message *message,
 					void *user_data);
 
-- 
1.7.9.5

