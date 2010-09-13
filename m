Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Add option to enable/disable unix ipc via audio.conf
Date: Mon, 13 Sep 2010 17:15:30 +0300
Message-Id: <1284387337-18822-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>

---
 audio/main.c    |    9 ---------
 audio/manager.c |   12 ++++++++++++
 audio/manager.h |    1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/audio/main.c b/audio/main.c
index 9d316ec..745c307 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -42,7 +42,6 @@
 #include "plugin.h"
 #include "log.h"
 #include "device.h"
-#include "unix.h"
 #include "headset.h"
 #include "manager.h"
 #include "gateway.h"
@@ -151,11 +150,6 @@ static int audio_init(void)
 
 	config = load_config_file(CONFIGDIR "/audio.conf");
 
-	if (unix_init() < 0) {
-		error("Unable to setup unix socket");
-		goto failed;
-	}
-
 	if (audio_manager_init(connection, config, &enable_sco) < 0)
 		goto failed;
 
@@ -174,7 +168,6 @@ static int audio_init(void)
 
 failed:
 	audio_manager_exit();
-	unix_exit();
 
 	if (connection) {
 		dbus_connection_unref(connection);
@@ -194,8 +187,6 @@ static void audio_exit(void)
 
 	audio_manager_exit();
 
-	unix_exit();
-
 	dbus_connection_unref(connection);
 }
 
diff --git a/audio/manager.c b/audio/manager.c
index 3db5987..87e7a2a 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -70,6 +70,7 @@
 #include "manager.h"
 #include "sdpd.h"
 #include "telephony.h"
+#include "unix.h"
 
 typedef enum {
 	HEADSET	= 1 << 0,
@@ -113,6 +114,7 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
+	.socket		= TRUE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -1074,6 +1076,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
+		else if (g_str_equal(list[i], "Socket"))
+			enabled.socket = TRUE;
 	}
 	g_strfreev(list);
 
@@ -1090,6 +1094,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = FALSE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = FALSE;
+		else if (g_str_equal(list[i], "Socket"))
+			enabled.socket = FALSE;
 	}
 	g_strfreev(list);
 
@@ -1117,6 +1123,9 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 		max_connected_headsets = i;
 
 proceed:
+	if (enabled.socket)
+		unix_init();
+
 	if (enabled.headset) {
 		telephony_init();
 		btd_register_adapter_driver(&headset_server_driver);
@@ -1152,6 +1161,9 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
+	if (enabled.socket)
+		unix_exit();
+
 	if (enabled.headset) {
 		btd_unregister_adapter_driver(&headset_server_driver);
 		telephony_exit();
diff --git a/audio/manager.h b/audio/manager.h
index 90fe6f0..c79b761 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -29,6 +29,7 @@ struct enabled_interfaces {
 	gboolean sink;
 	gboolean source;
 	gboolean control;
+	gboolean socket;
 };
 
 int audio_manager_init(DBusConnection *conn, GKeyFile *config,
-- 
1.7.1

