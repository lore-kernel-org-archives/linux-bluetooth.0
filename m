Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] audio: Move AVRCP related code to its own plugin
Date: Tue, 23 Jul 2013 18:01:22 +0300
Message-Id: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves AVRCP related code to avrcp plugin and making it possible to
disable by passing -P avrcp and increasing the modularity of the code.
---
 Makefile.plugins         |  10 +-
 profiles/audio/avrcp.c   | 345 ++++++++++++++++++++++++++++-------------------
 profiles/audio/avrcp.h   |   7 -
 profiles/audio/manager.c | 113 +---------------
 4 files changed, 214 insertions(+), 261 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 7fd9e2d..0f07b11 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -33,18 +33,20 @@ endif
 builtin_modules += audio
 builtin_sources += profiles/audio/main.c \
 			profiles/audio/manager.h profiles/audio/manager.c \
-			profiles/audio/control.h profiles/audio/control.c \
-			profiles/audio/avctp.h profiles/audio/avctp.c \
-			profiles/audio/avrcp.h profiles/audio/avrcp.c \
 			profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
 			profiles/audio/a2dp.h profiles/audio/a2dp.c \
 			profiles/audio/avdtp.h profiles/audio/avdtp.c \
 			profiles/audio/media.h profiles/audio/media.c \
 			profiles/audio/transport.h profiles/audio/transport.c \
-			profiles/audio/player.h profiles/audio/player.c \
 			profiles/audio/a2dp-codecs.h
 
+builtin_modules += avrcp
+builtin_sources += profiles/audio/control.h profiles/audio/control.c \
+			profiles/audio/avctp.h profiles/audio/avctp.c \
+			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/player.h profiles/audio/player.c
+
 builtin_modules += network
 builtin_sources += profiles/network/manager.c \
 			profiles/network/common.h profiles/network/common.c \
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9baf0d3..a9373f3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -47,20 +47,19 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
+#include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
+#include "src/profile.h"
 #include "src/service.h"
 
 #include "log.h"
 #include "error.h"
-#include "manager.h"
 #include "avctp.h"
 #include "avrcp.h"
 #include "sdpd.h"
 #include "dbus-common.h"
 #include "control.h"
-#include "avdtp.h"
-#include "sink.h"
 #include "player.h"
 #include "transport.h"
 
@@ -3538,46 +3537,11 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 	}
 }
 
-gboolean avrcp_connect(struct btd_device *dev)
+static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter)
 {
-	struct avctp *session;
-
-	session = avctp_connect(dev);
-	if (session)
-		return FALSE;
-
-	return TRUE;
-}
-
-void avrcp_disconnect(struct btd_device *dev)
-{
-	struct avctp *session;
-
-	session = avctp_get(dev);
-	if (!session)
-		return;
-
-	avctp_disconnect(session);
-}
-
-static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter,
-							GKeyFile *config)
-{
-	gboolean tmp, master = TRUE;
-	GError *err = NULL;
 	struct avrcp_server *server;
 
-	if (config) {
-		tmp = g_key_file_get_boolean(config, "General",
-							"Master", &err);
-		if (err) {
-			DBG("audio.conf: %s", err->message);
-			g_error_free(err);
-		} else
-			master = tmp;
-	}
-
-	if (avctp_register(adapter, master) < 0)
+	if (avctp_register(adapter, TRUE) < 0)
 		return NULL;
 
 	server = g_new0(struct avrcp_server, 1);
@@ -3591,70 +3555,6 @@ static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter,
 	return server;
 }
 
-int avrcp_target_register(struct btd_adapter *adapter, GKeyFile *config)
-{
-	sdp_record_t *record;
-	struct avrcp_server *server;
-
-	server = find_server(servers, adapter);
-	if (server != NULL)
-		goto done;
-
-	server = avrcp_server_register(adapter, config);
-	if (server == NULL)
-		return -EPROTONOSUPPORT;
-
-done:
-	record = avrcp_tg_record();
-	if (!record) {
-		error("Unable to allocate new service record");
-		avrcp_target_unregister(adapter);
-		return -1;
-	}
-
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
-		error("Unable to register AVRCP target service record");
-		avrcp_target_unregister(adapter);
-		sdp_record_free(record);
-		return -1;
-	}
-	server->tg_record_id = record->handle;
-
-	return 0;
-}
-
-int avrcp_remote_register(struct btd_adapter *adapter, GKeyFile *config)
-{
-	sdp_record_t *record;
-	struct avrcp_server *server;
-
-	server = find_server(servers, adapter);
-	if (server != NULL)
-		goto done;
-
-	server = avrcp_server_register(adapter, config);
-	if (server == NULL)
-		return -EPROTONOSUPPORT;
-
-done:
-	record = avrcp_ct_record();
-	if (!record) {
-		error("Unable to allocate new service record");
-		avrcp_remote_unregister(adapter);
-		return -1;
-	}
-
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
-		error("Unable to register AVRCP service record");
-		sdp_record_free(record);
-		avrcp_remote_unregister(adapter);
-		return -1;
-	}
-	server->ct_record_id = record->handle;
-
-	return 0;
-}
-
 static void avrcp_server_unregister(struct avrcp_server *server)
 {
 	g_slist_free_full(server->sessions, g_free);
@@ -3675,40 +3575,6 @@ static void avrcp_server_unregister(struct avrcp_server *server)
 	}
 }
 
-void avrcp_target_unregister(struct btd_adapter *adapter)
-{
-	struct avrcp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
-	if (server->tg_record_id != 0) {
-		remove_record_from_server(server->tg_record_id);
-		server->tg_record_id = 0;
-	}
-
-	if (server->ct_record_id == 0)
-		avrcp_server_unregister(server);
-}
-
-void avrcp_remote_unregister(struct btd_adapter *adapter)
-{
-	struct avrcp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
-	if (server->ct_record_id != 0) {
-		remove_record_from_server(server->ct_record_id);
-		server->ct_record_id = 0;
-	}
-
-	if (server->tg_record_id == 0)
-		avrcp_server_unregister(server);
-}
-
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
 						void *user_data,
@@ -3841,3 +3707,206 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 
 	return 0;
 }
+
+static int avrcp_connect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return control_connect(service);
+}
+
+static int avrcp_disconnect(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	const char *path = device_get_path(dev);
+
+	DBG("path %s", path);
+
+	return control_disconnect(service);
+}
+
+static int avrcp_target_probe(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(dev));
+
+	return control_init_target(service);
+}
+
+static void avrcp_target_remove(struct btd_service *service)
+{
+	control_unregister(service);
+}
+
+static void avrcp_target_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct avrcp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	if (server->tg_record_id != 0) {
+		remove_record_from_server(server->tg_record_id);
+		server->tg_record_id = 0;
+	}
+
+	if (server->ct_record_id == 0)
+		avrcp_server_unregister(server);
+}
+
+static int avrcp_target_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = avrcp_server_register(adapter);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
+	record = avrcp_tg_record();
+	if (!record) {
+		error("Unable to allocate new service record");
+		avrcp_target_server_remove(p, adapter);
+		return -1;
+	}
+
+	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+		error("Unable to register AVRCP target service record");
+		avrcp_target_server_remove(p, adapter);
+		sdp_record_free(record);
+		return -1;
+	}
+	server->tg_record_id = record->handle;
+
+	return 0;
+}
+
+static struct btd_profile avrcp_target_profile = {
+	.name		= "audio-avrcp-target",
+
+	.remote_uuid	= AVRCP_TARGET_UUID,
+	.device_probe	= avrcp_target_probe,
+	.device_remove	= avrcp_target_remove,
+
+	.connect	= avrcp_connect,
+	.disconnect	= avrcp_disconnect,
+
+	.adapter_probe	= avrcp_target_server_probe,
+	.adapter_remove = avrcp_target_server_remove,
+};
+
+static int avrcp_controller_probe(struct btd_service *service)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(dev));
+
+	return control_init_remote(service);
+}
+
+static void avrcp_controller_remove(struct btd_service *service)
+{
+	control_unregister(service);
+}
+
+static void avrcp_controller_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct avrcp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	if (server->ct_record_id != 0) {
+		remove_record_from_server(server->ct_record_id);
+		server->ct_record_id = 0;
+	}
+
+	if (server->tg_record_id == 0)
+		avrcp_server_unregister(server);
+}
+
+static int avrcp_controller_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = avrcp_server_register(adapter);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
+	record = avrcp_ct_record();
+	if (!record) {
+		error("Unable to allocate new service record");
+		avrcp_controller_server_remove(p, adapter);
+		return -1;
+	}
+
+	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+		error("Unable to register AVRCP service record");
+		avrcp_controller_server_remove(p, adapter);
+		sdp_record_free(record);
+		return -1;
+	}
+	server->ct_record_id = record->handle;
+
+	return 0;
+}
+
+static struct btd_profile avrcp_controller_profile = {
+	.name		= "avrcp-controller",
+
+	.remote_uuid	= AVRCP_REMOTE_UUID,
+	.device_probe	= avrcp_controller_probe,
+	.device_remove	= avrcp_controller_remove,
+
+	.connect	= avrcp_connect,
+	.disconnect	= avrcp_disconnect,
+
+	.adapter_probe	= avrcp_controller_server_probe,
+	.adapter_remove = avrcp_controller_server_remove,
+};
+
+static int avrcp_init(void)
+{
+	btd_profile_register(&avrcp_controller_profile);
+	btd_profile_register(&avrcp_target_profile);
+
+	return 0;
+}
+
+static void avrcp_exit(void)
+{
+	btd_profile_unregister(&avrcp_controller_profile);
+	btd_profile_unregister(&avrcp_target_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(avrcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							avrcp_init, avrcp_exit)
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 2ec1664..4c520ca 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -100,13 +100,6 @@ struct avrcp_player_cb {
 	bool (*previous) (void *user_data);
 };
 
-int avrcp_target_register(struct btd_adapter *adapter, GKeyFile *config);
-void avrcp_target_unregister(struct btd_adapter *adapter);
-int avrcp_remote_register(struct btd_adapter *adapter, GKeyFile *config);
-void avrcp_remote_unregister(struct btd_adapter *adapter);
-
-gboolean avrcp_connect(struct btd_device *dev);
-void avrcp_disconnect(struct btd_device *dev);
 int avrcp_set_volume(struct btd_device *dev, uint8_t volume);
 
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b7522e1..6eeb207 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -99,34 +99,6 @@ static void a2dp_sink_remove(struct btd_service *service)
 	sink_unregister(service);
 }
 
-static int avrcp_target_probe(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(dev));
-
-	return control_init_target(service);
-}
-
-static void avrcp_target_remove(struct btd_service *service)
-{
-	control_unregister(service);
-}
-
-static int avrcp_remote_probe(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-
-	DBG("path %s", device_get_path(dev));
-
-	return control_init_remote(service);
-}
-
-static void avrcp_remote_remove(struct btd_service *service)
-{
-	control_unregister(service);
-}
-
 static int a2dp_source_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
@@ -167,26 +139,6 @@ static int a2dp_sink_disconnect(struct btd_service *service)
 	return sink_disconnect(service, FALSE);
 }
 
-static int avrcp_control_connect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return control_connect(service);
-}
-
-static int avrcp_control_disconnect(struct btd_service *service)
-{
-	struct btd_device *dev = btd_service_get_device(service);
-	const char *path = device_get_path(dev);
-
-	DBG("path %s", path);
-
-	return control_disconnect(service);
-}
-
 static int a2dp_source_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -219,38 +171,6 @@ static void a2dp_sink_server_remove(struct btd_profile *p,
 	a2dp_sink_unregister(adapter);
 }
 
-static int avrcp_target_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	return avrcp_target_register(adapter, config);
-}
-
-static int avrcp_remote_server_probe(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	return avrcp_remote_register(adapter, config);
-}
-
-static void avrcp_target_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	avrcp_target_unregister(adapter);
-}
-
-static void avrcp_remote_server_remove(struct btd_profile *p,
-						struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	avrcp_remote_unregister(adapter);
-}
-
 static int media_server_probe(struct btd_adapter *adapter)
 {
 	DBG("path %s", adapter_get_path(adapter));
@@ -297,34 +217,6 @@ static struct btd_profile a2dp_sink_profile = {
 	.adapter_remove	= a2dp_source_server_remove,
 };
 
-static struct btd_profile avrcp_target_profile = {
-	.name		= "audio-avrcp-target",
-
-	.remote_uuid	= AVRCP_TARGET_UUID,
-	.device_probe	= avrcp_target_probe,
-	.device_remove	= avrcp_target_remove,
-
-	.connect	= avrcp_control_connect,
-	.disconnect	= avrcp_control_disconnect,
-
-	.adapter_probe	= avrcp_target_server_probe,
-	.adapter_remove = avrcp_target_server_remove,
-};
-
-static struct btd_profile avrcp_remote_profile = {
-	.name		= "audio-avrcp-control",
-
-	.remote_uuid	= AVRCP_REMOTE_UUID,
-	.device_probe	= avrcp_remote_probe,
-	.device_remove	= avrcp_remote_remove,
-
-	.connect	= avrcp_control_connect,
-	.disconnect	= avrcp_control_disconnect,
-
-	.adapter_probe	= avrcp_remote_server_probe,
-	.adapter_remove = avrcp_remote_server_remove,
-};
-
 static struct btd_adapter_driver media_driver = {
 	.name	= "media",
 	.probe	= media_server_probe,
@@ -338,8 +230,7 @@ int audio_manager_init(GKeyFile *conf)
 
 	btd_profile_register(&a2dp_source_profile);
 	btd_profile_register(&a2dp_sink_profile);
-	btd_profile_register(&avrcp_remote_profile);
-	btd_profile_register(&avrcp_target_profile);
+
 
 	btd_register_adapter_driver(&media_driver);
 
@@ -355,8 +246,6 @@ void audio_manager_exit(void)
 
 	btd_profile_unregister(&a2dp_source_profile);
 	btd_profile_unregister(&a2dp_sink_profile);
-	btd_profile_unregister(&avrcp_remote_profile);
-	btd_profile_unregister(&avrcp_target_profile);
 
 	btd_unregister_adapter_driver(&media_driver);
 }
-- 
1.8.3.1

