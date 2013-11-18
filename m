Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] audio/source: Remove shutdown parameter from source_disconnect
Date: Mon, 18 Nov 2013 13:50:13 +0200
Message-Id: <1384775415-10159-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
References: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parameter is always false so it never do anything.
---
 profiles/audio/a2dp.c   | 2 +-
 profiles/audio/source.c | 5 +----
 profiles/audio/source.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 864cb18..95ffa12 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1887,7 +1887,7 @@ static int a2dp_source_disconnect(struct btd_service *service)
 
 	DBG("path %s", path);
 
-	return source_disconnect(service, FALSE);
+	return source_disconnect(service);
 }
 
 static int a2dp_sink_connect(struct btd_service *service)
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 24a4353..7b129b7 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -380,16 +380,13 @@ gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
 	return TRUE;
 }
 
-int source_disconnect(struct btd_service *service, gboolean shutdown)
+int source_disconnect(struct btd_service *service)
 {
 	struct source *source = btd_service_get_user_data(service);
 
 	if (!source->session)
 		return -ENOTCONN;
 
-	if (shutdown)
-		avdtp_set_device_disconnect(source->session, TRUE);
-
 	/* cancel pending connect */
 	if (source->connect_id > 0) {
 		a2dp_cancel(source->connect_id);
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index c16fb4b..a014c68 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -48,4 +48,4 @@ gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean source_setup_stream(struct btd_service *service,
 							struct avdtp *session);
-int source_disconnect(struct btd_service *service, gboolean shutdown);
+int source_disconnect(struct btd_service *service);
-- 
1.8.3.1

