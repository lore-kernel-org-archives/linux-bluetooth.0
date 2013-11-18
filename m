Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio/sink: Remove shutdown parameter from sink_disconnect
Date: Mon, 18 Nov 2013 13:50:14 +0200
Message-Id: <1384775415-10159-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
References: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parameter is always false so it never do anything.
---
 profiles/audio/a2dp.c | 2 +-
 profiles/audio/sink.c | 5 +----
 profiles/audio/sink.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 95ffa12..29a1593 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1919,7 +1919,7 @@ static int a2dp_sink_disconnect(struct btd_service *service)
 
 	DBG("path %s", path);
 
-	return sink_disconnect(service, FALSE);
+	return sink_disconnect(service);
 }
 
 static int a2dp_source_server_probe(struct btd_profile *p,
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 400af06..4f39622 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -388,16 +388,13 @@ gboolean sink_new_stream(struct btd_service *service, struct avdtp *session,
 	return TRUE;
 }
 
-int sink_disconnect(struct btd_service *service, gboolean shutdown)
+int sink_disconnect(struct btd_service *service)
 {
 	struct sink *sink = btd_service_get_user_data(service);
 
 	if (!sink->session)
 		return -ENOTCONN;
 
-	if (shutdown)
-		avdtp_set_device_disconnect(sink->session, TRUE);
-
 	/* cancel pending connect */
 	if (sink->connect_id > 0) {
 		a2dp_cancel(sink->connect_id);
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 904a33d..93c62a2 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -47,4 +47,4 @@ int sink_connect(struct btd_service *service);
 gboolean sink_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session);
-int sink_disconnect(struct btd_service *service, gboolean shutdown);
+int sink_disconnect(struct btd_service *service);
-- 
1.8.3.1

