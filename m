Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/AVDTP: Remove get_all parameter for get_capability callback
Date: Mon, 23 Dec 2013 16:08:09 +0200
Message-Id: <1387807690-31617-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is not necessary anymore since all delay reporting is now added
automatically whenever supported.
---
 android/avdtp.c   | 4 ++--
 android/avdtp.h   | 1 -
 unit/test-avdtp.c | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 02ee920..3cf390f 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1192,8 +1192,8 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	if (!sep->ind->get_capability(session, sep, get_all, &caps,
-							&err, sep->user_data))
+	if (!sep->ind->get_capability(session, sep, &caps, &err,
+							sep->user_data))
 		goto failed;
 
 	for (l = caps, rsp_size = 0; l != NULL; l = g_slist_next(l)) {
diff --git a/android/avdtp.h b/android/avdtp.h
index d371653..e8d1907 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -161,7 +161,6 @@ struct avdtp_sep_cfm {
 struct avdtp_sep_ind {
 	gboolean (*get_capability) (struct avdtp *session,
 					struct avdtp_local_sep *sep,
-					gboolean get_all,
 					GSList **caps, uint8_t *err,
 					void *user_data);
 	gboolean (*set_configuration) (struct avdtp *session,
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 458daa7..66c45f3 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -269,8 +269,8 @@ static void execute_context(struct context *context)
 
 static gboolean sep_getcap_ind(struct avdtp *session,
 					struct avdtp_local_sep *sep,
-					gboolean get_all, GSList **caps,
-					uint8_t *err, void *user_data)
+					GSList **caps, uint8_t *err,
+					void *user_data)
 {
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_media_codec_capability *codec_caps;
@@ -550,8 +550,8 @@ static void test_server_0_sep(gconstpointer data)
 
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
 					struct avdtp_local_sep *sep,
-					gboolean get_all, GSList **caps,
-					uint8_t *err, void *user_data)
+					GSList **caps, uint8_t *err,
+					void *user_data)
 {
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_service_capability *content_protection;
-- 
1.8.4.2

