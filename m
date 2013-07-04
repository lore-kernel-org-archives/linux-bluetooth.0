Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio/sink: Fix not notifying service about connection state
Date: Thu,  4 Jul 2013 15:00:44 +0300
Message-Id: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_service_connecting_complete should be called whenever the service
is connected otherwise the service state will not be consistent.
---
 profiles/audio/sink.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 3969417..f55efe8 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -164,6 +164,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		sink->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
+		btd_service_connecting_complete(sink->service, 0);
 		sink_set_state(dev, SINK_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
@@ -182,20 +183,14 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean stream_setup_retry(gpointer user_data)
 {
 	struct sink *sink = user_data;
-	int err;
 
 	sink->retry_id = 0;
 
-	if (sink->stream_state >= AVDTP_STATE_OPEN) {
-		DBG("Stream successfully created, after XCASE connect:connect");
-		err = 0;
-	} else {
+	if (sink->stream_state < AVDTP_STATE_OPEN) {
 		DBG("Stream setup failed, after XCASE connect:connect");
-		err = -EIO;
+		btd_service_connecting_complete(sink->service, -EIO);
 	}
 
-	btd_service_connecting_complete(sink->service, err);
-
 	if (sink->connect_id > 0) {
 		a2dp_cancel(sink->dev, sink->connect_id);
 		sink->connect_id = 0;
@@ -212,11 +207,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	sink->connect_id = 0;
 
-	if (stream) {
-		DBG("Stream successfully created");
-		btd_service_connecting_complete(sink->service, 0);
+	if (stream)
 		return;
-	}
 
 	avdtp_unref(sink->session);
 	sink->session = NULL;
-- 
1.8.1.4

