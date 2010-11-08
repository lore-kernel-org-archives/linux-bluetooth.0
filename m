Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Add __btd_error_not_connected()
Date: Mon,  8 Nov 2010 04:29:42 -0200
Message-Id: <1289197787-16715-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289197787-16715-4-git-send-email-padovan@profusion.mobi>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    8 ++------
 audio/device.c  |    3 +--
 audio/gateway.c |    4 +---
 audio/headset.c |   24 ++++++------------------
 audio/sink.c    |    4 +---
 audio/source.c  |    4 +---
 src/error.c     |    7 +++++++
 src/error.h     |    1 +
 8 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index e9f59fc..043785e 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -1015,9 +1015,7 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotConnected",
-					"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	if (!control->target)
 		return __btd_error_not_supported(msg);
@@ -1043,9 +1041,7 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotConnected",
-					"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	if (!control->target)
 		return __btd_error_not_supported(msg);
diff --git a/audio/device.c b/audio/device.c
index eff8231..97badac 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -562,8 +562,7 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	struct dev_priv *priv = dev->priv;
 
 	if (priv->state == AUDIO_STATE_DISCONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotConnected",
-						"Not connected");
+		return __btd_error_not_connected(msg);
 
 	if (priv->dc_req)
 		return dbus_message_new_method_return(msg);
diff --git a/audio/gateway.c b/audio/gateway.c
index ae0ee75..ce1ec53 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -426,9 +426,7 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return  __btd_error_not_connected(msg);
 
 	gateway_close(device);
 	ba2str(&device->dst, gw_addr);
diff --git a/audio/headset.c b/audio/headset.c
index 2cca5ca..1ec48a4 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1622,9 +1622,7 @@ static DBusMessage *hs_stop(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply = NULL;
 
 	if (hs->state < HEADSET_STATE_PLAY_IN_PROGRESS)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1663,9 +1661,7 @@ static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 	char hs_address[18];
 
 	if (hs->state == HEADSET_STATE_DISCONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	headset_shutdown(device);
 	ba2str(&device->dst, hs_address);
@@ -1741,9 +1737,7 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1778,9 +1772,7 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 	DBusMessage *reply = NULL;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1812,9 +1804,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 	switch (hs->state) {
 	case HEADSET_STATE_DISCONNECTED:
 	case HEADSET_STATE_CONNECTING:
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
 		if (hs->pending && hs->pending->msg == NULL) {
 			hs->pending->msg = dbus_message_ref(msg);
@@ -1905,9 +1895,7 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	err = headset_set_gain(device, gain, type);
 	if (err < 0)
diff --git a/audio/sink.c b/audio/sink.c
index a9f6307..3c55c74 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -456,9 +456,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 	int err;
 
 	if (!sink->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	if (sink->connect || sink->disconnect)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/audio/source.c b/audio/source.c
index 8258fcd..4d47853 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -423,9 +423,7 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 	int err;
 
 	if (!source->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return __btd_error_not_connected(msg);
 
 	if (source->connect || source->disconnect)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/src/error.c b/src/error.c
index 4429903..b2d0ced 100644
--- a/src/error.c
+++ b/src/error.c
@@ -69,3 +69,10 @@ DBusMessage *__btd_error_not_supported(DBusMessage *msg)
 					".NotSupported",
 					"Operation is not supported");
 }
+
+DBusMessage *__btd_error_not_connected(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotConnected",
+					"Not Connected");
+}
diff --git a/src/error.h b/src/error.h
index 7dbb8b3..06345da 100644
--- a/src/error.h
+++ b/src/error.h
@@ -33,3 +33,4 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 DBusMessage *__btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *__btd_error_already_exists(DBusMessage *msg);
 DBusMessage *__btd_error_not_supported(DBusMessage *msg);
+DBusMessage *__btd_error_not_connected(DBusMessage *msg);
-- 
1.7.3.1

