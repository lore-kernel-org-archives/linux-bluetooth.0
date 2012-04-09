Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Apr 2012 10:01:49 +0200
Subject: RFC: [PATCH BlueZ 2/2] AVRCP 1.4 - Implemented volume_changed
 callback function
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B221E0A6C8C@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the second patch which has the implementation of the media callback function - volume_changed.

>From c2bc84bcbc581dbef34400cc5496fff8e22eed59 Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 9 Apr 2012 12:40:02 +0530
Subject: [PATCH BlueZ 2/2] AVRCP 1.4 - Implemented volume_changed callback function

---
 audio/media.c     |   42 +++++++++++++++++++++++++++++++++++++++++-
 audio/transport.c |    5 +++++
 audio/transport.h |    1 +
 3 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..4e91fb5 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -55,6 +55,7 @@
 #define MEDIA_INTERFACE "org.bluez.Media"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+#define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -103,6 +104,7 @@ struct media_player {
 	uint8_t			status;
 	uint32_t		position;
 	GTimer			*timer;
+	uint8_t         	volume;
 };
 
 struct metadata_value {
@@ -1255,6 +1257,43 @@ static uint32_t get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;
 }
 
+static void volume_changed(uint8_t volume, void *user_data, struct audio_device *dev)
+{
+ 	struct media_player *mp = user_data;
+ 	DBusMessage *msg; 
+ 	DBusMessageIter iter, value;
+ 	const char *property = "InputGain";
+
+	GSList *l;
+	mp->volume = volume;
+
+	for (l = mp->adapter->endpoints; l; l = l->next) {
+
+		struct media_endpoint *endpoint = l->data;
+		if (endpoint->transport == NULL )
+			continue;
+		if (media_transport_get_dev (endpoint->transport) != dev)	
+			continue;
+		const char *path = media_transport_get_path(endpoint->transport);
+
+		msg = dbus_message_new_signal(path, MEDIA_TRANSPORT_INTERFACE, "PropertyChanged");
+		if (!msg) {
+			DBG( "Unable to allocate new.PropertyChanged msg\n");
+			continue ;
+		}
+		dbus_message_iter_init_append(msg, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, DBUS_TYPE_BYTE_AS_STRING, &value);
+		dbus_message_iter_append_basic(&value, DBUS_TYPE_BYTE, &volume);
+		dbus_message_iter_close_container(&iter, &value);
+		if ( !dbus_connection_send(media_transport_get_conn (endpoint->transport),msg,NULL))
+			continue;
+
+	}
+
+ 	return ;	
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1262,7 +1301,8 @@ static struct avrcp_player_cb player_cb = {
 	.get_uid = get_uid,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
-	.get_status = get_status
+	.get_status = get_status,
+	.volume_changed = volume_changed
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
diff --git a/audio/transport.c b/audio/transport.c
index 7bf7309..6ea0748 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -1054,3 +1054,8 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 {
 	return transport->device;
 }
+
+DBusConnection *media_transport_get_conn(struct media_transport *transport)
+{
+	return transport->conn;
+}
diff --git a/audio/transport.h b/audio/transport.h
index 1f86cde..94dbb69 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -37,3 +37,4 @@ void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
+DBusConnection *media_transport_get_conn(struct media_transport *transport);
-- 
1.7.5.4


-Regards,
Vani Patel
