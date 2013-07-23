Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] audio: Move media code to its own plugin
Date: Tue, 23 Jul 2013 18:01:24 +0300
Message-Id: <1374591686-22646-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
References: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves media inface related code to media plugin and making it
possible to disable by passing -P media and increasing the modularity
of the code.
---
 Makefile.plugins         |  8 +++++---
 profiles/audio/manager.c | 24 ------------------------
 profiles/audio/media.c   | 47 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index b9dc2f0..41d5be9 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -32,9 +32,7 @@ endif
 
 builtin_modules += audio
 builtin_sources += profiles/audio/main.c \
-			profiles/audio/manager.h profiles/audio/manager.c \
-			profiles/audio/media.h profiles/audio/media.c \
-			profiles/audio/transport.h profiles/audio/transport.c
+			profiles/audio/manager.h profiles/audio/manager.c
 
 builtin_modules += a2dp
 builtin_sources += profiles/audio/source.h profiles/audio/source.c \
@@ -49,6 +47,10 @@ builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
 			profiles/audio/player.h profiles/audio/player.c
 
+builtin_modules += media
+builtin_sources += profiles/audio/media.h profiles/audio/media.c \
+			profiles/audio/transport.h profiles/audio/transport.c
+
 builtin_modules += network
 builtin_sources += profiles/network/manager.c \
 			profiles/network/common.h profiles/network/common.c \
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 91c9a4c..8065b70 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -69,33 +69,11 @@
 
 static GKeyFile *config = NULL;
 
-static int media_server_probe(struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	return media_register(adapter);
-}
-
-static void media_server_remove(struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	media_unregister(adapter);
-}
-
-static struct btd_adapter_driver media_driver = {
-	.name	= "media",
-	.probe	= media_server_probe,
-	.remove	= media_server_remove,
-};
-
 int audio_manager_init(GKeyFile *conf)
 {
 	if (conf)
 		config = conf;
 
-	btd_register_adapter_driver(&media_driver);
-
 	return 0;
 }
 
@@ -105,8 +83,6 @@ void audio_manager_exit(void)
 		g_key_file_free(config);
 		config = NULL;
 	}
-
-	btd_unregister_adapter_driver(&media_driver);
 }
 
 static void set_fast_connectable(struct btd_adapter *adapter,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 715d49c..794362e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -34,6 +34,7 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
+#include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/dbus-common.h"
@@ -47,7 +48,6 @@
 #include "transport.h"
 #include "a2dp.h"
 #include "avrcp.h"
-#include "manager.h"
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -1812,10 +1812,27 @@ static void path_free(void *data)
 	g_free(adapter);
 }
 
-int media_register(struct btd_adapter *btd_adapter)
+struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint)
+{
+	return endpoint->sep;
+}
+
+const char *media_endpoint_get_uuid(struct media_endpoint *endpoint)
+{
+	return endpoint->uuid;
+}
+
+uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
+{
+	return endpoint->codec;
+}
+
+static int media_server_probe(struct btd_adapter *btd_adapter)
 {
 	struct media_adapter *adapter;
 
+	DBG("path %s", adapter_get_path(btd_adapter));
+
 	adapter = g_new0(struct media_adapter, 1);
 	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
 
@@ -1835,10 +1852,12 @@ int media_register(struct btd_adapter *btd_adapter)
 	return 0;
 }
 
-void media_unregister(struct btd_adapter *btd_adapter)
+static void media_server_remove(struct btd_adapter *btd_adapter)
 {
 	GSList *l;
 
+	DBG("path %s", adapter_get_path(btd_adapter));
+
 	for (l = adapters; l; l = l->next) {
 		struct media_adapter *adapter = l->data;
 
@@ -1851,17 +1870,23 @@ void media_unregister(struct btd_adapter *btd_adapter)
 	}
 }
 
-struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint)
-{
-	return endpoint->sep;
-}
+static struct btd_adapter_driver media_driver = {
+	.name	= "media",
+	.probe	= media_server_probe,
+	.remove	= media_server_remove,
+};
 
-const char *media_endpoint_get_uuid(struct media_endpoint *endpoint)
+static int media_init(void)
 {
-	return endpoint->uuid;
+	btd_register_adapter_driver(&media_driver);
+
+	return 0;
 }
 
-uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
+static void media_exit(void)
 {
-	return endpoint->codec;
+	btd_unregister_adapter_driver(&media_driver);
 }
+
+BLUETOOTH_PLUGIN_DEFINE(media, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							media_init, media_exit)
-- 
1.8.3.1

