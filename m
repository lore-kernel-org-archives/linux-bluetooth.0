Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 6/6] media: Add version suffix to all media interfaces
Date: Wed,  5 Dec 2012 17:15:34 +0100
Message-Id: <1354724134-7354-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Append the version number to all D-Bus interface names in the Media API.
---
 doc/audio-telephony-design.txt |  4 ++--
 doc/media-api.txt              | 20 ++++++++++----------
 profiles/audio/media.c         |  8 ++++----
 profiles/audio/player.c        |  2 +-
 profiles/audio/transport.c     |  2 +-
 test/mpris-player.c            | 14 +++++++-------
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
index ec575f2..308986b 100644
--- a/doc/audio-telephony-design.txt
+++ b/doc/audio-telephony-design.txt
@@ -35,9 +35,9 @@ When a new device is connected, NewConnection method of Profile1 agent
 is called with informations related to connecting profile (like RFCOMM
 client file descriptor, version, features, media end point path, ...).
 
-The telephony application is in charge to implement a MediaTransport for
+The telephony application is in charge to implement a MediaTransport1 for
 its audio connection with remote device and interact with the
-MediaTransport of the audio component (i.e. PulseAudio).
+MediaTransport1 of the audio component (i.e. PulseAudio).
 
 Flow charts
 ===========
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 5e052b4..ce7502a 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -5,7 +5,7 @@ Media hierarchy
 ===============
 
 Service		org.bluez
-Interface	org.bluez.Media
+Interface	org.bluez.Media1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		void RegisterEndpoint(object endpoint, dict properties)
@@ -123,12 +123,12 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender media player.
 
-MediaPlayer hierarchy
-=====================
+MediaPlayer1 hierarchy
+======================
 
 Service		unique name (Target role)
 		org.bluez (Controller role)
-Interface	org.bluez.MediaPlayer
+Interface	org.bluez.Media1Player1
 Object path	freely definable (Target role)
 		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
 		(Controller role)
@@ -219,11 +219,11 @@ Properties	string Equalizer [readwrite]
 			possible to signal its end by setting position to the
 			maximum uint32 value.
 
-MediaEndpoint hierarchy
-=======================
+MediaEndpoint1 hierarchy
+========================
 
 Service		unique name
-Interface	org.bluez.MediaEndpoint
+Interface	org.bluez.Media1Endpoint1
 Object path	freely definable
 
 Methods		void SetConfiguration(object transport, dict properties)
@@ -254,11 +254,11 @@ Methods		void SetConfiguration(object transport, dict properties)
 			endpoint, because when this method gets called it has
 			already been unregistered.
 
-MediaTransport hierarchy
-========================
+MediaTransport1 hierarchy
+=========================
 
 Service		org.bluez
-Interface	org.bluez.MediaTransport
+Interface	org.bluez.MediaTransport1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
 
 Methods		fd, uint16, uint16 Acquire()
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 2041d23..7c0bc0a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -50,9 +50,9 @@
 #include "avrcp.h"
 #include "manager.h"
 
-#define MEDIA_INTERFACE "org.bluez.Media"
-#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
-#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+#define MEDIA_INTERFACE "org.bluez.Media1"
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.Media1Endpoint1"
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -402,7 +402,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	path = media_transport_get_path(transport);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport", &iter);
+	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
 	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 34b1f20..368bfa8 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -42,7 +42,7 @@
 #include "dbus-common.h"
 #include "error.h"
 
-#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 
 struct player_callback {
 	const struct media_player_callback *cbs;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 666f68a..165ebd3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -48,7 +48,7 @@
 #include "source.h"
 #include "avrcp.h"
 
-#define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
+#define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
diff --git a/test/mpris-player.c b/test/mpris-player.c
index 7985cdd..90c87aa 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -186,7 +186,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 						DBUS_TYPE_STRING, &value);
 		else
 			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer", "Status",
+					"org.bluez.MediaPlayer1", "Status",
 					DBUS_TYPE_STRING, &value);
 	} else if (strcasecmp(key, "Position") == 0) {
 		int64_t usec, msec;
@@ -203,7 +203,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 						DBUS_TYPE_UINT32, &msec);
 		else
 			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer", "Position",
+					"org.bluez.MediaPlayer1", "Position",
 					DBUS_TYPE_UINT32, &msec);
 	} else if (strcasecmp(key, "Shuffle") == 0) {
 		dbus_bool_t value;
@@ -221,7 +221,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 						DBUS_TYPE_STRING, &str);
 		else
 			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer", "Shuffle",
+					"org.bluez.MediaPlayer1", "Shuffle",
 					DBUS_TYPE_STRING, &str);
 	}
 
@@ -446,7 +446,7 @@ static char *sender2path(const char *sender)
 static DBusHandlerResult player_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	if (dbus_message_is_method_call(msg, "org.bluez.MediaPlayer",
+	if (dbus_message_is_method_call(msg, "org.bluez.MediaPlayer1",
 								"Release")) {
 		printf("Release\n");
 		exit(1);
@@ -472,7 +472,7 @@ static void add_player(DBusConnection *conn, const char *name,
 		return;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Media",
+					"org.bluez.Media1",
 					"RegisterPlayer");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -539,7 +539,7 @@ static void remove_player(DBusConnection *conn, const char *sender)
 	char *path;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Media",
+					"org.bluez.Media1",
 					"UnregisterPlayer");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -578,7 +578,7 @@ static DBusHandlerResult properties_changed(DBusConnection *conn,
 	path = sender2path(dbus_message_get_sender(msg));
 	parse_properties(conn, path, &iter, NULL);
 
-	signal = dbus_message_new_signal(path, "org.bluez.MediaPlayer",
+	signal = dbus_message_new_signal(path, "org.bluez.MediaPlayer1",
 							"TrackChanged");
 	if (!signal) {
 		fprintf(stderr, "Unable to allocate new PropertyChanged"
-- 
1.7.11.7

