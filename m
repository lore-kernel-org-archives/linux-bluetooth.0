Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Add __btd_error_busy()
Date: Mon,  8 Nov 2010 04:29:45 -0200
Message-Id: <1289197787-16715-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289197787-16715-7-git-send-email-padovan@profusion.mobi>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-4-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-5-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-6-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-7-git-send-email-padovan@profusion.mobi>
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
index 017f02e..15853a8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1808,9 +1808,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 			hs->pending->msg = dbus_message_ref(msg);
 			return NULL;
 		}
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".InProgress",
-						"Play in Progress");
+		return __btd_error_busy(msg);
 	case HEADSET_STATE_PLAYING:
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 						".AlreadyConnected",
diff --git a/audio/sink.c b/audio/sink.c
index 3c55c74..49c8bfc 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -423,8 +423,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 						"Unable to get a session");
 
 	if (sink->connect || sink->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return __btd_error_busy(msg);
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
@@ -459,8 +458,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 		return __btd_error_not_connected(msg);
 
 	if (sink->connect || sink->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return __btd_error_busy(msg);
 
 	if (sink->stream_state < AVDTP_STATE_OPEN) {
 		DBusMessage *reply = dbus_message_new_method_return(msg);
diff --git a/audio/source.c b/audio/source.c
index 4d47853..6767591 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -390,8 +390,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 						"Unable to get a session");
 
 	if (source->connect || source->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return __btd_error_busy(msg);
 
 	if (source->stream_state >= AVDTP_STATE_OPEN)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
diff --git a/input/device.c b/input/device.c
index 1ccb2b0..6968b6c 100644
--- a/input/device.c
+++ b/input/device.c
@@ -325,12 +325,6 @@ static inline DBusMessage *not_supported(DBusMessage *msg)
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
index 8b91a03..8000467 100644
--- a/src/error.c
+++ b/src/error.c
@@ -56,6 +56,12 @@ DBusMessage *__btd_error_invalid_args(DBusMessage *msg)
 					"Invalid arguments in method call");
 }
 
+DBusMessage *__btd_error_busy(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+					"Operation already in progress");
+}
+
 DBusMessage *__btd_error_already_exists(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg,
diff --git a/src/error.h b/src/error.h
index dfdc933..c023809 100644
--- a/src/error.h
+++ b/src/error.h
@@ -31,6 +31,7 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 					const char *name, const char *descr);
 
 DBusMessage *__btd_error_invalid_args(DBusMessage *msg);
+DBusMessage *__btd_error_busy(DBusMessage *msg);
 DBusMessage *__btd_error_already_exists(DBusMessage *msg);
 DBusMessage *__btd_error_not_supported(DBusMessage *msg);
 DBusMessage *__btd_error_not_connected(DBusMessage *msg);
-- 
1.7.3.1

