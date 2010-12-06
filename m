Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Add btd_error_in_progress()
Date: Mon,  6 Dec 2010 17:10:44 -0200
Message-Id: <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c  |    3 +--
 audio/headset.c |    3 +--
 input/device.c  |    2 +-
 src/device.c    |   11 ++---------
 src/error.c     |    7 +++++++
 src/error.h     |    1 +
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 72c103b..6e005a5 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -519,8 +519,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	struct dev_priv *priv = dev->priv;
 
 	if (priv->state == AUDIO_STATE_CONNECTING)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-						"Connect in Progress");
+		return btd_error_in_progress(msg);
 	else if (priv->state == AUDIO_STATE_CONNECTED)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 						".AlreadyConnected",
diff --git a/audio/headset.c b/audio/headset.c
index 7fc5afb..c3d7f82 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1695,8 +1695,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (hs->state == HEADSET_STATE_CONNECTING)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-						"Connect in Progress");
+		return btd_error_in_progress(msg);
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 						".AlreadyConnected",
diff --git a/input/device.c b/input/device.c
index e09a6cf..ac425a0 100644
--- a/input/device.c
+++ b/input/device.c
@@ -946,7 +946,7 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 		return not_supported(msg);
 
 	if (iconn->pending_connect)
-		return in_progress(msg);
+		return btd_error_in_progress(msg);
 
 	if (is_connected(iconn))
 		return already_connected(msg);
diff --git a/src/device.c b/src/device.c
index 6363ed0..3f94efc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -177,12 +177,6 @@ static inline DBusMessage *no_such_adapter(DBusMessage *msg)
 							"No such adapter");
 }
 
-static inline DBusMessage *in_progress(DBusMessage *msg, const char *str)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-								"%s", str);
-}
-
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -611,8 +605,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 	int err;
 
 	if (device->browse)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-						"Discover in progress");
+		return btd_error_in_progress(msg);
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -1991,7 +1984,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	ba2str(&device->bdaddr, dstaddr);
 
 	if (device->bonding)
-		return in_progress(msg, "Bonding in progress");
+		return btd_error_in_progress(msg);
 
 	/* check if a link key already exists */
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr,
diff --git a/src/error.c b/src/error.c
index c8cccf9..9b18842 100644
--- a/src/error.c
+++ b/src/error.c
@@ -76,3 +76,10 @@ DBusMessage *btd_error_not_connected(DBusMessage *msg)
 					".NotConnected",
 					"Not Connected");
 }
+
+DBusMessage *btd_error_in_progress(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".InProgress",
+					"In Progress");
+}
diff --git a/src/error.h b/src/error.h
index 7450029..b8066ce 100644
--- a/src/error.h
+++ b/src/error.h
@@ -34,3 +34,4 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg);
 DBusMessage *btd_error_already_exists(DBusMessage *msg);
 DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
+DBusMessage *btd_error_in_progress(DBusMessage *msg);
-- 
1.7.3.2

