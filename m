Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 03/23] avrcp: add skeleton of MediaPlayer interface
Date: Fri,  5 Aug 2011 15:15:12 -0300
Message-Id: <1312568132-21112-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/control.h |    4 ++-
 audio/manager.c |   11 ++++++++-
 audio/manager.h |    1 +
 4 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 1ec736f..168cfc0 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -185,8 +185,12 @@ struct avctp_server {
 	uint32_t ct_record_id;
 };
 
+struct media_player {
+};
+
 struct control {
 	struct audio_device *dev;
+	struct media_player *mp;
 
 	avctp_state_t state;
 
@@ -1125,6 +1129,14 @@ static GDBusSignalTable control_signals[] = {
 	{ NULL, NULL }
 };
 
+static GDBusMethodTable mp_methods[] = {
+	{ }
+};
+
+static GDBusSignalTable mp_signals[] = {
+	{ }
+};
+
 static void path_unregister(void *data)
 {
 	struct audio_device *dev = data;
@@ -1140,10 +1152,29 @@ static void path_unregister(void *data)
 	dev->control = NULL;
 }
 
+static void mp_path_unregister(void *data)
+{
+	struct audio_device *dev = data;
+	struct control *control = dev->control;
+	struct media_player *mp = control->mp;
+
+	DBG("Unregistered interface %s on path %s",
+		MEDIA_PLAYER_INTERFACE, dev->path);
+
+	g_free(mp);
+	control->mp = NULL;
+}
+
 void control_unregister(struct audio_device *dev)
 {
+	struct control *control = dev->control;
+
+	if (control->mp)
+		g_dbus_unregister_interface(dev->conn, dev->path,
+						MEDIA_PLAYER_INTERFACE);
+
 	g_dbus_unregister_interface(dev->conn, dev->path,
-		AUDIO_CONTROL_INTERFACE);
+						AUDIO_CONTROL_INTERFACE);
 }
 
 void control_update(struct audio_device *dev, uint16_t uuid16)
@@ -1154,7 +1185,8 @@ void control_update(struct audio_device *dev, uint16_t uuid16)
 		control->target = TRUE;
 }
 
-struct control *control_init(struct audio_device *dev, uint16_t uuid16)
+struct control *control_init(struct audio_device *dev, uint16_t uuid16,
+							gboolean media_player)
 {
 	struct control *control;
 
@@ -1172,6 +1204,26 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16)
 	control->state = AVCTP_STATE_DISCONNECTED;
 	control->uinput = -1;
 
+	if (media_player) {
+		struct media_player *mp;
+
+		mp = g_new0(struct media_player, 1);
+
+		if (!g_dbus_register_interface(dev->conn, dev->path,
+						MEDIA_PLAYER_INTERFACE,
+						mp_methods, mp_signals, NULL,
+						dev, mp_path_unregister)) {
+			error("D-Bus failed do register %s on path %s",
+					MEDIA_PLAYER_INTERFACE, dev->path);
+			g_free(mp);
+		}
+
+		DBG("Registered interface %s on path %s",
+					MEDIA_PLAYER_INTERFACE, dev->path);
+
+		control->mp = mp;
+	}
+
 	if (uuid16 == AV_REMOTE_TARGET_SVCLASS_ID)
 		control->target = TRUE;
 
diff --git a/audio/control.h b/audio/control.h
index 49f25c2..635a2d5 100644
--- a/audio/control.h
+++ b/audio/control.h
@@ -23,6 +23,7 @@
  */
 
 #define AUDIO_CONTROL_INTERFACE "org.bluez.Control"
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
 
 typedef enum {
 	AVCTP_STATE_DISCONNECTED = 0,
@@ -44,7 +45,8 @@ void avrcp_unregister(const bdaddr_t *src);
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
 
-struct control *control_init(struct audio_device *dev, uint16_t uuid16);
+struct control *control_init(struct audio_device *dev, uint16_t uuid16,
+							gboolean media_player);
 void control_update(struct audio_device *dev, uint16_t uuid16);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
diff --git a/audio/manager.c b/audio/manager.c
index 05ca654..4afa688 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -117,7 +117,8 @@ static struct enabled_interfaces enabled = {
 	.source		= FALSE,
 	.control	= TRUE,
 	.socket		= TRUE,
-	.media		= FALSE
+	.media		= FALSE,
+	.media_player	= FALSE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -220,7 +221,8 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		if (device->control)
 			control_update(device, uuid16);
 		else
-			device->control = control_init(device, uuid16);
+			device->control = control_init(device, uuid16,
+							enabled.media_player);
 		if (device->sink && sink_is_active(device))
 			avrcp_connect(device);
 		break;
@@ -1169,6 +1171,9 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.socket = TRUE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = TRUE;
+		else if (g_str_equal(list[i], "MediaPlayer"))
+			enabled.media_player = TRUE;
+
 	}
 	g_strfreev(list);
 
@@ -1189,6 +1194,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.socket = FALSE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = FALSE;
+		else if (g_str_equal(list[i], "MediaPlayer"))
+			enabled.media_player = FALSE;
 	}
 	g_strfreev(list);
 
diff --git a/audio/manager.h b/audio/manager.h
index 0bf7663..cfc646c 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -31,6 +31,7 @@ struct enabled_interfaces {
 	gboolean control;
 	gboolean socket;
 	gboolean media;
+	gboolean media_player;
 };
 
 int audio_manager_init(DBusConnection *conn, GKeyFile *config,
-- 
1.7.6

