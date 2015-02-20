Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 9/9] audio/avdtp: Use SEP queue instead of avdtp_server in avdtp code
Date: Fri, 20 Feb 2015 14:43:23 +0200
Message-Id: <1424436203-28935-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This makes register/unregister sep code inside avdtp.c similar between
profiles/ and android/
---
 profiles/audio/a2dp.c      | 7 +++----
 profiles/audio/avdtp.c     | 8 ++++----
 profiles/audio/avdtp.h     | 5 ++---
 profiles/audio/media.c     | 1 +
 profiles/audio/sink.c      | 1 +
 profiles/audio/source.c    | 1 +
 profiles/audio/transport.c | 1 +
 7 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8b812c3..b024742 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1257,11 +1257,10 @@ static void a2dp_clean_lsep(struct a2dp_sep *sep)
 	struct avdtp_local_sep *lsep = sep->lsep;
 	struct avdtp_server *server = sep->avdtp_server;
 
-	queue_remove(server->seps, lsep);
+	avdtp_unregister_sep(server->seps, lsep);
+
 	if (queue_isempty(server->seps))
 		avdtp_server_destroy(server);
-
-	avdtp_unregister_sep(lsep);
 }
 
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
@@ -1421,7 +1420,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 			return NULL;
 	}
 
-	sep->lsep = avdtp_register_sep(avdtp_server, type,
+	sep->lsep = avdtp_register_sep(avdtp_server->seps, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 882e20d..f3d4087 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3598,8 +3598,7 @@ void avdtp_accept(struct avdtp *session)
 	session->stream_setup = TRUE;
 }
 
-struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
-						uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -3628,7 +3627,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 
-	if (!queue_push_tail(server->seps, sep)) {
+	if (!queue_push_tail(lseps, sep)) {
 		g_free(sep);
 		return NULL;
 	}
@@ -3636,7 +3635,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 	return sep;
 }
 
-int avdtp_unregister_sep(struct avdtp_local_sep *sep)
+int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
 {
 	if (!sep)
 		return -EINVAL;
@@ -3648,6 +3647,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 			sep->info.type, sep->codec, sep->info.seid);
 
 	util_clear_uid(&seids, sep->info.seid);
+	queue_remove(lseps, sep);
 	g_free(sep);
 
 	return 0;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index be2c3e5..c2c223a 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -267,8 +267,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
-						uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -280,7 +279,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep);
 
-int avdtp_unregister_sep(struct avdtp_local_sep *sep);
+int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 965b32a..633695c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -44,6 +44,7 @@
 #include "src/uuid-helper.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/queue.h"
 
 #include "avdtp.h"
 #include "media.h"
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 3ecdab8..7cf22d9 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -44,6 +44,7 @@
 #include "src/service.h"
 #include "src/error.h"
 #include "src/dbus-common.h"
+#include "src/shared/queue.h"
 
 #include "avdtp.h"
 #include "media.h"
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index c00e354..fd68917 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -45,6 +45,7 @@
 #include "src/service.h"
 #include "src/error.h"
 #include "src/dbus-common.h"
+#include "src/shared/queue.h"
 
 #include "avdtp.h"
 #include "media.h"
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index cfb9125..a267bfd 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -39,6 +39,7 @@
 
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/queue.h"
 
 #include "avdtp.h"
 #include "media.h"
-- 
2.1.0

