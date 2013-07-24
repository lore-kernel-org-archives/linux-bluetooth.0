Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4 v2] audio: Move A2DP code to its own plugin
Date: Wed, 24 Jul 2013 14:56:22 +0300
Message-Id: <1374666984-14158-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374666984-14158-1-git-send-email-luiz.dentz@gmail.com>
References: <1374666984-14158-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves A2DP related code to a2dp plugin and making it possible to
disable by passing -P a2dp and increasing the modularity of the code.
---
 Makefile.plugins         |   6 +-
 profiles/audio/a2dp.c    | 319 +++++++++++++++++++++++++++++++++++------------
 profiles/audio/a2dp.h    |   5 -
 profiles/audio/avdtp.c   |  18 +--
 profiles/audio/avdtp.h   |   2 +-
 profiles/audio/manager.c | 165 ------------------------
 profiles/audio/media.c   |   2 +-
 7 files changed, 245 insertions(+), 272 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 0f07b11..b6743ba 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -32,8 +32,10 @@ endif
 
 builtin_modules += audio
 builtin_sources += profiles/audio/main.c \
-			profiles/audio/manager.h profiles/audio/manager.c \
-			profiles/audio/source.h profiles/audio/source.c \
+			profiles/audio/manager.h profiles/audio/manager.c
+
+builtin_modules += a2dp
+builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
 			profiles/audio/a2dp.h profiles/audio/a2dp.c \
 			profiles/audio/avdtp.h profiles/audio/avdtp.c \
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8db43f9..40c68af 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -38,8 +38,10 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "lib/uuid.h"
+#include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
+#include "src/profile.h"
 #include "src/service.h"
 
 #include "log.h"
@@ -50,6 +52,7 @@
 #include "a2dp.h"
 #include "a2dp-codecs.h"
 #include "sdpd.h"
+#include "media.h"
 
 /* The duration that streams without users are allowed to stay in
  * STREAMING state. */
@@ -1182,15 +1185,14 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
-static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter,
-							GKeyFile *config)
+static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
 	int av_err;
 
 	server = g_new0(struct a2dp_server, 1);
 
-	av_err = avdtp_init(adapter, config);
+	av_err = avdtp_init(adapter);
 	if (av_err < 0) {
 		DBG("AVDTP not registered");
 		g_free(server);
@@ -1203,42 +1205,6 @@ static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter,
 	return server;
 }
 
-int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config)
-{
-	struct a2dp_server *server;
-
-	server = find_server(servers, adapter);
-	if (server != NULL)
-		goto done;
-
-	server = a2dp_server_register(adapter, config);
-	if (server == NULL)
-		return -EPROTONOSUPPORT;
-
-done:
-	server->source_enabled = TRUE;
-
-	return 0;
-}
-
-int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config)
-{
-	struct a2dp_server *server;
-
-	server = find_server(servers, adapter);
-	if (server != NULL)
-		goto done;
-
-	server = a2dp_server_register(adapter, config);
-	if (server == NULL)
-		return -EPROTONOSUPPORT;
-
-done:
-	server->sink_enabled = TRUE;
-
-	return 0;
-}
-
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
 {
 	if (sep->destroy) {
@@ -1259,49 +1225,6 @@ static void a2dp_server_unregister(struct a2dp_server *server)
 	g_free(server);
 }
 
-void a2dp_sink_unregister(struct btd_adapter *adapter)
-{
-	struct a2dp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
-	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
-
-	if (server->sink_record_id) {
-		remove_record_from_server(server->sink_record_id);
-		server->sink_record_id = 0;
-	}
-
-	if (server->source_record_id)
-		return;
-
-	a2dp_server_unregister(server);
-}
-
-void a2dp_source_unregister(struct btd_adapter *adapter)
-{
-	struct a2dp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
-	g_slist_free_full(server->sources,
-					(GDestroyNotify) a2dp_unregister_sep);
-
-	if (server->source_record_id) {
-		remove_record_from_server(server->source_record_id);
-		server->source_record_id = 0;
-	}
-
-	if (server->sink_record_id)
-		return;
-
-	a2dp_server_unregister(server);
-}
-
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
@@ -1915,3 +1838,235 @@ struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
 
 	return avdtp_get_device(setup->session);
 }
+
+static int a2dp_source_probe(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(dev));
+
+	source_init(service);
+
+	return 0;
+}
+
+static void a2dp_source_remove(struct btd_service *service)
+{
+	source_unregister(service);
+}
+
+static int a2dp_sink_probe(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(dev));
+
+	return sink_init(service);
+}
+
+static void a2dp_sink_remove(struct btd_service *service)
+{
+	sink_unregister(service);
+}
+
+static int a2dp_source_connect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return source_connect(service);
+}
+
+static int a2dp_source_disconnect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return source_disconnect(service, FALSE);
+}
+
+static int a2dp_sink_connect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return sink_connect(service);
+}
+
+static int a2dp_sink_disconnect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return sink_disconnect(service, FALSE);
+}
+
+static int a2dp_source_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = a2dp_server_register(adapter);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
+	server->source_enabled = TRUE;
+
+	return 0;
+}
+
+static void a2dp_source_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	g_slist_free_full(server->sources,
+					(GDestroyNotify) a2dp_unregister_sep);
+
+	if (server->source_record_id) {
+		remove_record_from_server(server->source_record_id);
+		server->source_record_id = 0;
+	}
+
+	if (server->sink_record_id)
+		return;
+
+	a2dp_server_unregister(server);
+}
+
+static int a2dp_sink_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = a2dp_server_register(adapter);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
+	server->sink_enabled = TRUE;
+
+	return 0;
+}
+
+static void a2dp_sink_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
+
+	if (server->sink_record_id) {
+		remove_record_from_server(server->sink_record_id);
+		server->sink_record_id = 0;
+	}
+
+	if (server->source_record_id)
+		return;
+
+	a2dp_server_unregister(server);
+}
+
+static int media_server_probe(struct btd_adapter *adapter)
+{
+	DBG("path %s", adapter_get_path(adapter));
+
+	return media_register(adapter);
+}
+
+static void media_server_remove(struct btd_adapter *adapter)
+{
+	DBG("path %s", adapter_get_path(adapter));
+
+	media_unregister(adapter);
+}
+
+static struct btd_profile a2dp_source_profile = {
+	.name		= "a2dp-source",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+
+	.remote_uuid	= A2DP_SOURCE_UUID,
+	.device_probe	= a2dp_source_probe,
+	.device_remove	= a2dp_source_remove,
+
+	.auto_connect	= true,
+	.connect	= a2dp_source_connect,
+	.disconnect	= a2dp_source_disconnect,
+
+	.adapter_probe	= a2dp_sink_server_probe,
+	.adapter_remove	= a2dp_sink_server_remove,
+};
+
+static struct btd_profile a2dp_sink_profile = {
+	.name		= "a2dp-sink",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+
+	.remote_uuid	= A2DP_SINK_UUID,
+	.device_probe	= a2dp_sink_probe,
+	.device_remove	= a2dp_sink_remove,
+
+	.auto_connect	= true,
+	.connect	= a2dp_sink_connect,
+	.disconnect	= a2dp_sink_disconnect,
+
+	.adapter_probe	= a2dp_source_server_probe,
+	.adapter_remove	= a2dp_source_server_remove,
+};
+
+static struct btd_adapter_driver media_driver = {
+	.name		= "media",
+	.probe		= media_server_probe,
+	.remove		= media_server_remove,
+};
+
+static int a2dp_init(void)
+{
+	btd_register_adapter_driver(&media_driver);
+	btd_profile_register(&a2dp_source_profile);
+	btd_profile_register(&a2dp_sink_profile);
+
+	return 0;
+}
+
+static void a2dp_exit(void)
+{
+	btd_unregister_adapter_driver(&media_driver);
+	btd_profile_unregister(&a2dp_source_profile);
+	btd_profile_unregister(&a2dp_sink_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(a2dp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							a2dp_init, a2dp_exit)
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 2c06f74..ef3be5c 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -63,11 +63,6 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					struct avdtp_error *err,
 					void *user_data);
 
-int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
-void a2dp_source_unregister(struct btd_adapter *adapter);
-int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
-void a2dp_sink_unregister(struct btd_adapter *adapter);
-
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 07644e5..f6c9408 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3846,27 +3846,13 @@ struct btd_device *avdtp_get_device(struct avdtp *session)
 	return session->device;
 }
 
-int avdtp_init(struct btd_adapter *adapter, GKeyFile *config)
+int avdtp_init(struct btd_adapter *adapter)
 {
-	GError *err = NULL;
-	gboolean tmp, master = TRUE;
 	struct avdtp_server *server;
 
-	if (!config)
-		goto proceed;
-
-	tmp = g_key_file_get_boolean(config, "General",
-			"Master", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else
-		master = tmp;
-
-proceed:
 	server = g_new0(struct avdtp_server, 1);
 
-	server->io = avdtp_server_socket(adapter_get_address(adapter), master);
+	server->io = avdtp_server_socket(adapter_get_address(adapter), TRUE);
 	if (!server->io) {
 		g_free(server);
 		return -1;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 4d3e6c8..b8aaf1d 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -312,5 +312,5 @@ struct btd_device *avdtp_get_device(struct avdtp *session);
 gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
 
-int avdtp_init(struct btd_adapter *adapter, GKeyFile *config);
+int avdtp_init(struct btd_adapter *adapter);
 void avdtp_exit(struct btd_adapter *adapter);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 6eeb207..8065b70 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -69,171 +69,11 @@
 
 static GKeyFile *config = NULL;
 
-static int a2dp_source_probe(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(dev));
-
-	source_init(service);
-
-	return 0;
-}
-
-static void a2dp_source_remove(struct btd_service *service)
-{
-	source_unregister(service);
-}
-
-static int a2dp_sink_probe(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(dev));
-
-	return sink_init(service);
-}
-
-static void a2dp_sink_remove(struct btd_service *service)
-{
-	sink_unregister(service);
-}
-
-static int a2dp_source_connect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return source_connect(service);
-}
-
-static int a2dp_source_disconnect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return source_disconnect(service, FALSE);
-}
-
-static int a2dp_sink_connect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return sink_connect(service);
-}
-
-static int a2dp_sink_disconnect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return sink_disconnect(service, FALSE);
-}
-
-static int a2dp_source_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	return a2dp_source_register(adapter, config);
-}
-
-static void a2dp_source_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	a2dp_source_unregister(adapter);
-}
-
-static int a2dp_sink_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	return a2dp_sink_register(adapter, config);
-}
-
-static void a2dp_sink_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	a2dp_sink_unregister(adapter);
-}
-
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
-static struct btd_profile a2dp_source_profile = {
-	.name		= "audio-source",
-	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
-
-	.remote_uuid	= A2DP_SOURCE_UUID,
-	.device_probe	= a2dp_source_probe,
-	.device_remove	= a2dp_source_remove,
-
-	.auto_connect	= true,
-	.connect	= a2dp_source_connect,
-	.disconnect	= a2dp_source_disconnect,
-
-	.adapter_probe	= a2dp_sink_server_probe,
-	.adapter_remove	= a2dp_sink_server_remove,
-};
-
-static struct btd_profile a2dp_sink_profile = {
-	.name		= "audio-sink",
-	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
-
-	.remote_uuid	= A2DP_SINK_UUID,
-	.device_probe	= a2dp_sink_probe,
-	.device_remove	= a2dp_sink_remove,
-
-	.auto_connect	= true,
-	.connect	= a2dp_sink_connect,
-	.disconnect	= a2dp_sink_disconnect,
-
-	.adapter_probe	= a2dp_source_server_probe,
-	.adapter_remove	= a2dp_source_server_remove,
-};
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
 
-	btd_profile_register(&a2dp_source_profile);
-	btd_profile_register(&a2dp_sink_profile);
-
-
-	btd_register_adapter_driver(&media_driver);
-
 	return 0;
 }
 
@@ -243,11 +83,6 @@ void audio_manager_exit(void)
 		g_key_file_free(config);
 		config = NULL;
 	}
-
-	btd_profile_unregister(&a2dp_source_profile);
-	btd_profile_unregister(&a2dp_sink_profile);
-
-	btd_unregister_adapter_driver(&media_driver);
 }
 
 static void set_fast_connectable(struct btd_adapter *adapter,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 715d49c..5a06b99 100644
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
-- 
1.8.3.1

