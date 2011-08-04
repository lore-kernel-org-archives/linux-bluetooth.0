Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Remove bogus extra semicolons
Date: Thu,  4 Aug 2011 13:33:54 -0400
Message-Id: <1312479234-20142-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avdtp.c            |    4 ++--
 audio/telephony-maemo5.c |    2 +-
 audio/telephony-maemo6.c |    2 +-
 health/mcap.c            |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 76526b6..00762f2 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3393,7 +3393,7 @@ unsigned int avdtp_stream_add_cb(struct avdtp *session,
 	stream_cb->user_data = data;
 	stream_cb->id = ++id;
 
-	stream->callbacks = g_slist_append(stream->callbacks, stream_cb);;
+	stream->callbacks = g_slist_append(stream->callbacks, stream_cb);
 
 	return stream_cb->id;
 }
@@ -3932,7 +3932,7 @@ unsigned int avdtp_add_state_cb(avdtp_session_state_cb cb, void *user_data)
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
-	avdtp_callbacks = g_slist_append(avdtp_callbacks, state_cb);;
+	avdtp_callbacks = g_slist_append(avdtp_callbacks, state_cb);
 
 	return state_cb->id;
 }
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 350df9e..23801c0 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1684,7 +1684,7 @@ static void call_info_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
 	DBusMessage *reply;
-	DBusMessageIter iter, sub;;
+	DBusMessageIter iter, sub;
 
 	get_calls_active = FALSE;
 
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 4430cc1..1e4a23c 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1656,7 +1656,7 @@ static void call_info_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
 	DBusMessage *reply;
-	DBusMessageIter iter, sub;;
+	DBusMessageIter iter, sub;
 
 	get_calls_active = FALSE;
 
diff --git a/health/mcap.c b/health/mcap.c
index d251a39..bc8c606 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -2058,7 +2058,7 @@ struct mcap_instance *mcap_create_instance(bdaddr_t *src,
 	/* Initialize random seed to generate mdlids for this instance */
 	srand(time(NULL));
 
-	return mcap_instance_ref(mi);;
+	return mcap_instance_ref(mi);
 }
 
 void mcap_release_instance(struct mcap_instance *mi)
-- 
1.7.0.4

