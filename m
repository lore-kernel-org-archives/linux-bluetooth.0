Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 02/22] avrcp: add skeleton of MediaPlayer interface
Date: Thu, 11 Aug 2011 12:53:13 -0300
Message-Id: <1313078013-19103-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 audio/control.h |    7 +++-
 audio/manager.c |   14 ++++++++--
 audio/manager.h |    1 +
 4 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c3ef737..6ceda11 100644
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
@@ -1140,21 +1152,72 @@ static void path_unregister(void *data)
 	dev->control = NULL;
 }
 
-void control_unregister(struct audio_device *dev)
+static void mp_path_unregister(void *data)
 {
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
+static void mp_unregister(struct control *control)
+{
+	struct audio_device *dev = control->dev;
+
 	g_dbus_unregister_interface(dev->conn, dev->path,
-		AUDIO_CONTROL_INTERFACE);
+						MEDIA_PLAYER_INTERFACE);
 }
 
-void control_update(struct audio_device *dev, uint16_t uuid16)
+void control_unregister(struct audio_device *dev)
 {
 	struct control *control = dev->control;
 
+	if (control->mp)
+		mp_unregister(control);
+
+	g_dbus_unregister_interface(dev->conn, dev->path,
+						AUDIO_CONTROL_INTERFACE);
+}
+
+static void mp_register(struct control *control)
+{
+	struct audio_device *dev = control->dev;
+	struct media_player *mp;
+
+	mp = g_new0(struct media_player, 1);
+
+	if (!g_dbus_register_interface(dev->conn, dev->path,
+						MEDIA_PLAYER_INTERFACE,
+						mp_methods, mp_signals, NULL,
+						dev, mp_path_unregister)) {
+		error("D-Bus failed do register %s on path %s",
+					MEDIA_PLAYER_INTERFACE, dev->path);
+		g_free(mp);
+		return;
+	}
+
+	DBG("Registered interface %s on path %s",
+					MEDIA_PLAYER_INTERFACE, dev->path);
+
+	control->mp = mp;
+}
+
+void control_update(struct control *control, uint16_t uuid16,
+							gboolean media_player)
+{
 	if (uuid16 == AV_REMOTE_TARGET_SVCLASS_ID)
 		control->target = TRUE;
+	else if (media_player && !control->mp)
+		mp_register(control);
 }
 
-struct control *control_init(struct audio_device *dev, uint16_t uuid16)
+struct control *control_init(struct audio_device *dev, uint16_t uuid16,
+							gboolean media_player)
 {
 	struct control *control;
 
@@ -1172,8 +1235,7 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16)
 	control->state = AVCTP_STATE_DISCONNECTED;
 	control->uinput = -1;
 
-	if (uuid16 == AV_REMOTE_TARGET_SVCLASS_ID)
-		control->target = TRUE;
+	control_update(control, uuid16, media_player);
 
 	return control;
 }
diff --git a/audio/control.h b/audio/control.h
index 49f25c2..77e7595 100644
--- a/audio/control.h
+++ b/audio/control.h
@@ -23,6 +23,7 @@
  */
 
 #define AUDIO_CONTROL_INTERFACE "org.bluez.Control"
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
 
 typedef enum {
 	AVCTP_STATE_DISCONNECTED = 0,
@@ -44,7 +45,9 @@ void avrcp_unregister(const bdaddr_t *src);
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
 
-struct control *control_init(struct audio_device *dev, uint16_t uuid16);
-void control_update(struct audio_device *dev, uint16_t uuid16);
+struct control *control_init(struct audio_device *dev, uint16_t uuid16,
+							gboolean media_player);
+void control_update(struct control *control, uint16_t uuid16,
+							gboolean media_player);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
diff --git a/audio/manager.c b/audio/manager.c
index 05ca654..6e583cf 100644
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
@@ -218,9 +219,11 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		DBG("Found AV %s", uuid16 == AV_REMOTE_SVCLASS_ID ?
 							"Remote" : "Target");
 		if (device->control)
-			control_update(device, uuid16);
+			control_update(device->control, uuid16,
+							enabled.media_player);
 		else
-			device->control = control_init(device, uuid16);
+			device->control = control_init(device, uuid16,
+							enabled.media_player);
 		if (device->sink && sink_is_active(device))
 			avrcp_connect(device);
 		break;
@@ -1169,6 +1172,9 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.socket = TRUE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = TRUE;
+		else if (g_str_equal(list[i], "MediaPlayer"))
+			enabled.media_player = TRUE;
+
 	}
 	g_strfreev(list);
 
@@ -1189,6 +1195,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
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

