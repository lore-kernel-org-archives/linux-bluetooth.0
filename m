Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Add btd_error_not_connected()
Date: Mon,  6 Dec 2010 17:10:43 -0200
Message-Id: <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
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
index e710f8f..98b6682 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -1014,9 +1014,7 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotConnected",
-					"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	if (!control->target)
 		return btd_error_not_supported(msg);
@@ -1042,9 +1040,7 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotConnected",
-					"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	if (!control->target)
 		return btd_error_not_supported(msg);
diff --git a/audio/device.c b/audio/device.c
index 30ae30d..72c103b 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -562,8 +562,7 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	struct dev_priv *priv = dev->priv;
 
 	if (priv->state == AUDIO_STATE_DISCONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotConnected",
-						"Not connected");
+		return btd_error_not_connected(msg);
 
 	if (priv->dc_req)
 		return dbus_message_new_method_return(msg);
diff --git a/audio/gateway.c b/audio/gateway.c
index 79847b7..93c4301 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -423,9 +423,7 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return  btd_error_not_connected(msg);
 
 	gateway_close(device);
 	ba2str(&device->dst, gw_addr);
diff --git a/audio/headset.c b/audio/headset.c
index 0932477..7fc5afb 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1618,9 +1618,7 @@ static DBusMessage *hs_stop(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply = NULL;
 
 	if (hs->state < HEADSET_STATE_PLAY_IN_PROGRESS)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1659,9 +1657,7 @@ static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 	char hs_address[18];
 
 	if (hs->state == HEADSET_STATE_DISCONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	headset_shutdown(device);
 	ba2str(&device->dst, hs_address);
@@ -1737,9 +1733,7 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1774,9 +1768,7 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 	DBusMessage *reply = NULL;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1808,9 +1800,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 	switch (hs->state) {
 	case HEADSET_STATE_DISCONNECTED:
 	case HEADSET_STATE_CONNECTING:
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
 		if (hs->pending && hs->pending->msg == NULL) {
 			hs->pending->msg = dbus_message_ref(msg);
@@ -1901,9 +1891,7 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	err = headset_set_gain(device, gain, type);
 	if (err < 0)
diff --git a/audio/sink.c b/audio/sink.c
index 1d350c0..e9a529b 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -472,9 +472,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 	int err;
 
 	if (!sink->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	if (sink->connect || sink->disconnect)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/audio/source.c b/audio/source.c
index 8258fcd..75f50ff 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -423,9 +423,7 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 	int err;
 
 	if (!source->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".NotConnected",
-						"Device not Connected");
+		return btd_error_not_connected(msg);
 
 	if (source->connect || source->disconnect)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
diff --git a/src/error.c b/src/error.c
index 0ea007a..c8cccf9 100644
--- a/src/error.c
+++ b/src/error.c
@@ -69,3 +69,10 @@ DBusMessage *btd_error_not_supported(DBusMessage *msg)
 					".NotSupported",
 					"Operation is not supported");
 }
+
+DBusMessage *btd_error_not_connected(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotConnected",
+					"Not Connected");
+}
diff --git a/src/error.h b/src/error.h
index 71b40d9..7450029 100644
--- a/src/error.h
+++ b/src/error.h
@@ -33,3 +33,4 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
+DBusMessage *btd_error_not_connected(DBusMessage *msg);
-- 
1.7.3.2

