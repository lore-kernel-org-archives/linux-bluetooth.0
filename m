Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 4/4] Remove unnecessary disconnect callback from source.c
Date: Wed, 22 Sep 2010 16:35:21 +0300
Message-Id: <1285162521-21997-4-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Headsets for proper disconnecting need to disconnect profiles in specified
order(by ex. disconnect a2dp, then sink and hfp at the end). Instead of
adding separate callbacks for disconnecting each profile, now adding only
one callback in audio/device.c for calling audio disconnect functions in
correct order.
---
 audio/source.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/audio/source.c b/audio/source.c
index 01173f5..e8671ed 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -62,7 +62,6 @@ struct source {
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint dc_id;
 	guint retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
@@ -133,12 +132,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		if (source->state != SOURCE_STATE_CONNECTING &&
-				source->dc_id) {
-			device_remove_disconnect_watch(dev->btd_dev,
-							source->dc_id);
-			source->dc_id = 0;
-		}
 		source_set_state(dev, SOURCE_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
@@ -164,17 +157,6 @@ static void pending_request_free(struct audio_device *dev,
 	g_free(pending);
 }
 
-static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
-				void *user_data)
-{
-	struct audio_device *device = user_data;
-	struct source *source = device->source;
-
-	DBG("Source: disconnect %s", device->path);
-
-	avdtp_close(source->session, source->stream, TRUE);
-}
-
 static void stream_state_changed(struct avdtp_stream *stream,
 					avdtp_state_t old_state,
 					avdtp_state_t new_state,
@@ -201,12 +183,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 			pending_request_free(dev, p);
 		}
 
-		if (source->dc_id) {
-			device_remove_disconnect_watch(dev->btd_dev,
-							source->dc_id);
-			source->dc_id = 0;
-		}
-
 		if (source->session) {
 			avdtp_unref(source->session);
 			source->session = NULL;
@@ -215,12 +191,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		source->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
-		if (old_state == AVDTP_STATE_CONFIGURED &&
-				source->state == SOURCE_STATE_CONNECTING) {
-			source->dc_id = device_add_disconnect_watch(dev->btd_dev,
-								disconnect_cb,
-								dev, NULL);
-		}
 		source_set_state(dev, SOURCE_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
@@ -536,9 +506,6 @@ static void source_free(struct audio_device *dev)
 		avdtp_stream_remove_cb(source->session, source->stream,
 					source->cb_id);
 
-	if (source->dc_id)
-		device_remove_disconnect_watch(dev->btd_dev, source->dc_id);
-
 	if (source->session)
 		avdtp_unref(source->session);
 
-- 
1.7.0.4

