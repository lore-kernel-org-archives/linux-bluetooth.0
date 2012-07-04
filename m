Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 04/28] sink: remove deprecated DBus method
Date: Wed,  4 Jul 2012 10:17:23 +0200
Message-Id: <1341389867-30749-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 audio/sink.c      |   24 ------------------------
 doc/audio-api.txt |    5 -----
 2 files changed, 29 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 8ba4e2a..64e38f4 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -492,27 +492,6 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *sink_is_connected(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct sink *sink = device->sink;
-	DBusMessage *reply;
-	dbus_bool_t connected;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	connected = (sink->stream_state >= AVDTP_STATE_CONFIGURED);
-
-	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &connected,
-					DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
 static DBusMessage *sink_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -556,9 +535,6 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 static const GDBusMethodTable sink_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, sink_connect) },
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, sink_disconnect) },
-	{ GDBUS_DEPRECATED_METHOD("IsConnected",
-			NULL, GDBUS_ARGS({ "connected", "b" }),
-			sink_is_connected) },
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				sink_get_properties) },
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 2419531..ca430fc 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -193,11 +193,6 @@ Methods		void Connect()
 
 			Disconnect from the remote device.
 
-		boolean IsConnected() {deprecated}
-
-			Returns TRUE if a stream is setup to a A2DP sink on
-			the remote device.
-
 		dict GetProperties()
 
 			Returns all properties for the interface. See the
-- 
1.7.10.2

