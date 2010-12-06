Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Add btd_error_busy()
Date: Mon,  6 Dec 2010 17:10:46 -0200
Message-Id: <1291662648-10651-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-6-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c |    4 +---
 audio/sink.c    |    6 ++----
 audio/source.c  |    3 +--
 input/device.c  |    6 ------
 src/error.c     |    6 ++++++
 src/error.h     |    1 +
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 0413588..8402789 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1804,9 +1804,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 			hs->pending->msg = dbus_message_ref(msg);
 			return NULL;
 		}
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".InProgress",
-						"Play in Progress");
+		return btd_error_busy(msg);
 	case HEADSET_STATE_PLAYING:
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 						".AlreadyConnected",
diff --git a/audio/sink.c b/audio/sink.c
index e9a529b..37ba8c0 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -439,8 +439,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 						"Unable to get a session");
 
 	if (sink->connect || sink->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return btd_error_busy(msg);
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
@@ -475,8 +474,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 		return btd_error_not_connected(msg);
 
 	if (sink->connect || sink->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return btd_error_busy(msg);
 
 	if (sink->stream_state < AVDTP_STATE_OPEN) {
 		DBusMessage *reply = dbus_message_new_method_return(msg);
diff --git a/audio/source.c b/audio/source.c
index 75f50ff..a6fd8e7 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -390,8 +390,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 						"Unable to get a session");
 
 	if (source->connect || source->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return btd_error_busy(msg);
 
 	if (source->stream_state >= AVDTP_STATE_OPEN)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
diff --git a/input/device.c b/input/device.c
index ac425a0..f7f96be 100644
--- a/input/device.c
+++ b/input/device.c
@@ -321,12 +321,6 @@ static inline DBusMessage *not_supported(DBusMessage *msg)
 							"Not supported");
 }
 
-static inline DBusMessage *in_progress(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-				"Device connection already in progress");
-}
-
 static inline DBusMessage *already_connected(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyConnected",
diff --git a/src/error.c b/src/error.c
index 3f9acd9..cf3c54d 100644
--- a/src/error.c
+++ b/src/error.c
@@ -56,6 +56,12 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg)
 					"Invalid arguments in method call");
 }
 
+DBusMessage *btd_error_busy(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+					"Operation already in progress");
+}
+
 DBusMessage *btd_error_already_exists(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg,
diff --git a/src/error.h b/src/error.h
index 623860e..7ffd8b7 100644
--- a/src/error.h
+++ b/src/error.h
@@ -31,6 +31,7 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 					const char *name, const char *descr);
 
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
+DBusMessage *btd_error_busy(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
-- 
1.7.3.2

