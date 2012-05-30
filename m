Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Remove compatibility check for DBUS_TYPE_UNIX_FD
Date: Wed, 30 May 2012 17:16:19 -0400
Message-Id: <1338412579-22890-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit c89b589a586e97ad875fbdd1d41f03979157ebb0, D-Bus >= 1.4.0 is
required. This version already contains Unix FD passing support,
therefore code that checks for DBUS_TYPE_UNIX_FD definition is
unnecessary.
---
 audio/gateway.c      |    7 -------
 audio/gstavdtpsink.c |    4 ----
 audio/manager.c      |    4 ----
 audio/media.c        |    7 -------
 audio/transport.c    |    4 ----
 doc/hfp-api.txt      |    4 +---
 health/hdp.c         |    4 ----
 serial/port.c        |    7 -------
 8 files changed, 1 insertion(+), 40 deletions(-)

Note: only compilation tested.

diff --git a/audio/gateway.c b/audio/gateway.c
index dcc4f55..6162948 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -50,10 +50,6 @@
 #include "btio.h"
 #include "dbus-common.h"
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 struct hf_agent {
 	char *name;	/* Bus id */
 	char *path;	/* D-Bus path */
@@ -755,9 +751,6 @@ void gateway_unregister(struct audio_device *dev)
 
 struct gateway *gateway_init(struct audio_device *dev)
 {
-	if (DBUS_TYPE_UNIX_FD < 0)
-		return NULL;
-
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_GATEWAY_INTERFACE,
 					gateway_methods, gateway_signals,
diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index b5dfae4..1f374fc 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -64,10 +64,6 @@ GST_DEBUG_CATEGORY_STATIC(avdtp_sink_debug);
 		g_mutex_unlock(s->sink_lock);		\
 	} G_STMT_END
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 struct bluetooth_data {
 	struct bt_get_capabilities_rsp *caps; /* Bluetooth device caps */
 	guint link_mtu;
diff --git a/audio/manager.c b/audio/manager.c
index fb7af98..0b21322 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -70,10 +70,6 @@
 #include "telephony.h"
 #include "unix.h"
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 typedef enum {
 	HEADSET	= 1 << 0,
 	GATEWAY	= 1 << 1,
diff --git a/audio/media.c b/audio/media.c
index 2a2cf37..147538c 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -48,10 +48,6 @@
 #include "gateway.h"
 #include "manager.h"
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 #define MEDIA_INTERFACE "org.bluez.Media"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
@@ -1857,9 +1853,6 @@ int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src)
 {
 	struct media_adapter *adapter;
 
-	if (DBUS_TYPE_UNIX_FD < 0)
-		return -EPERM;
-
 	adapter = g_new0(struct media_adapter, 1);
 	adapter->conn = dbus_connection_ref(conn);
 	bacpy(&adapter->src, src);
diff --git a/audio/transport.c b/audio/transport.c
index 4273282..40d093b 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -45,10 +45,6 @@
 #include "gateway.h"
 #include "avrcp.h"
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
 
 struct media_request {
diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
index cf2e730..fad89ae 100644
--- a/doc/hfp-api.txt
+++ b/doc/hfp-api.txt
@@ -66,9 +66,7 @@ Methods		void NewConnection(filedescriptor fd, uint16 version)
 
 			This method gets called whenever a new handsfree
 			connection has been established.  The objectpath
-			contains the object path of the remote device.  This
-			method assumes that DBus daemon with file descriptor
-			passing capability is being used.
+			contains the object path of the remote device.
 
 			The agent should only return successfully once the
 			establishment of the service level connection (SLC)
diff --git a/health/hdp.c b/health/hdp.c
index 2f04d2e..2316204 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -42,10 +42,6 @@
 #include "hdp.h"
 #include "mcap.h"
 
-#ifndef DBUS_TYPE_UNIX_FD
-	#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 #define ECHO_TIMEOUT	1 /* second */
 #define HDP_ECHO_LEN	15
 
diff --git a/serial/port.c b/serial/port.c
index f288f90..f90bb6a 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -64,10 +64,6 @@
 #define MAX_OPEN_TRIES		5
 #define OPEN_WAIT		300	/* ms. udev node creation retry wait */
 
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
 struct serial_device {
 	DBusConnection	*conn;		/* for name listener handling */
 	bdaddr_t	src;		/* Source (local) address */
@@ -495,9 +491,6 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	const char *pattern;
 	int err;
 
-	if (dbus_message_has_member(msg, "ConnectFD") && DBUS_TYPE_UNIX_FD < 0)
-		return btd_error_not_supported(msg);
-
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 						DBUS_TYPE_INVALID) == FALSE)
 		return NULL;
-- 
1.7.9.5

