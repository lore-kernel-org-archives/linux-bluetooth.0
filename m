Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Add btd_error_already_connected()
Date: Wed,  8 Dec 2010 18:26:01 -0200
Message-Id: <1291839961-14940-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-6-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-4-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-5-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c       |    4 +---
 audio/headset.c      |    8 ++------
 audio/sink.c         |    4 +---
 audio/source.c       |    4 +---
 input/device.c       |    8 +-------
 network/connection.c |    2 +-
 src/error.c          |    6 ++++++
 src/error.h          |    1 +
 8 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 6e005a5..fe7aed4 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -521,9 +521,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	if (priv->state == AUDIO_STATE_CONNECTING)
 		return btd_error_in_progress(msg);
 	else if (priv->state == AUDIO_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".AlreadyConnected",
-						"Already Connected");
+		return btd_error_already_connected(msg);
 
 	dev->auto_connect = TRUE;
 
diff --git a/audio/headset.c b/audio/headset.c
index 8402789..3d584e0 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1697,9 +1697,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	if (hs->state == HEADSET_STATE_CONNECTING)
 		return btd_error_in_progress(msg);
 	else if (hs->state > HEADSET_STATE_CONNECTING)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".AlreadyConnected",
-						"Already Connected");
+		return btd_error_already_connected(msg);
 
 	if (hs->hfp_handle && !ag.telephony_ready)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
@@ -1806,9 +1804,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 		}
 		return btd_error_busy(msg);
 	case HEADSET_STATE_PLAYING:
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".AlreadyConnected",
-						"Device Already Connected");
+		return btd_error_already_connected(msg);
 	case HEADSET_STATE_CONNECTED:
 	default:
 		break;
diff --git a/audio/sink.c b/audio/sink.c
index 37ba8c0..176a4ed 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -442,9 +442,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 		return btd_error_busy(msg);
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".AlreadyConnected",
-						"Device Already Connected");
+		return btd_error_already_connected(msg);
 
 	if (!sink_setup_stream(sink, NULL))
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/audio/source.c b/audio/source.c
index 9b9dab7..c106eaa 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -393,9 +393,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 		return btd_error_busy(msg);
 
 	if (source->stream_state >= AVDTP_STATE_OPEN)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".AlreadyConnected",
-						"Device Already Connected");
+		return btd_error_already_connected(msg);
 
 	if (!source_setup_stream(source, NULL))
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/input/device.c b/input/device.c
index 3c3f9fd..dee943b 100644
--- a/input/device.c
+++ b/input/device.c
@@ -315,12 +315,6 @@ failed:
 	return FALSE;
 }
 
-static inline DBusMessage *already_connected(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyConnected",
-					"Already connected to a device");
-}
-
 static inline DBusMessage *connection_attempt_failed(DBusMessage *msg,
 							const char *err)
 {
@@ -937,7 +931,7 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 		return btd_error_in_progress(msg);
 
 	if (is_connected(iconn))
-		return already_connected(msg);
+		return btd_error_already_connected(msg);
 
 	iconn->pending_connect = dbus_message_ref(msg);
 	fake = iconn->fake;
diff --git a/network/connection.c b/network/connection.c
index a652b98..89c38d8 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -396,7 +396,7 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 		return btd_error_not_supported(msg);
 
 	if (nc->state != DISCONNECTED)
-		return already_connected(msg);
+		return btd_error_already_connected(msg);
 
 	nc->io = bt_io_connect(BT_IO_L2CAP, connect_cb, nc,
 				NULL, &err,
diff --git a/src/error.c b/src/error.c
index 0d33fb5..e1f0598 100644
--- a/src/error.c
+++ b/src/error.c
@@ -79,6 +79,12 @@ DBusMessage *btd_error_not_connected(DBusMessage *msg)
 					"Not Connected");
 }
 
+DBusMessage *btd_error_already_connected(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyConnected",
+					"Already Connected");
+}
+
 DBusMessage *btd_error_in_progress(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
diff --git a/src/error.h b/src/error.h
index a7028bd..9d80fa0 100644
--- a/src/error.h
+++ b/src/error.h
@@ -35,6 +35,7 @@ DBusMessage *btd_error_busy(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
+DBusMessage *btd_error_already_connected(DBusMessage *msg);
 DBusMessage *btd_error_not_available(DBusMessage *msg);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
-- 
1.7.3.2

