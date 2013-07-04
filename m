Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio/source: Fix not notifying service about connection state
Date: Thu,  4 Jul 2013 15:00:45 +0300
Message-Id: <1372939245-18040-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
References: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_service_connecting_complete should be called whenever the service
is connected otherwise the service state will not be consistent.
---
 profiles/audio/source.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 226c372..73c3185 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -165,6 +165,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		source->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
+		btd_service_connecting_complete(source->service, 0);
 		source_set_state(dev, SOURCE_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
@@ -183,20 +184,14 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean stream_setup_retry(gpointer user_data)
 {
 	struct source *source = user_data;
-	int err;
 
 	source->retry_id = 0;
 
-	if (source->stream_state >= AVDTP_STATE_OPEN) {
-		DBG("Stream successfully created, after XCASE connect:connect");
-		err = 0;
-	} else {
+	if (source->stream_state < AVDTP_STATE_OPEN) {
 		DBG("Stream setup failed, after XCASE connect:connect");
-		err = -EIO;
+		btd_service_connecting_complete(source->service, -EIO);
 	}
 
-	btd_service_connecting_complete(source->service, err);
-
 	if (source->connect_id > 0) {
 		a2dp_cancel(source->dev, source->connect_id);
 		source->connect_id = 0;
@@ -213,11 +208,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	source->connect_id = 0;
 
-	if (stream) {
-		DBG("Stream successfully created");
-		btd_service_connecting_complete(source->service, 0);
+	if (stream)
 		return;
-	}
 
 	avdtp_unref(source->session);
 	source->session = NULL;
-- 
1.8.1.4

