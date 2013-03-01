Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 2/7] audio: Split AVRCP into two btd_profile
Date: Fri,  1 Mar 2013 14:59:08 +0100
Message-Id: <1362146353-23799-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1362146353-23799-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1362146353-23799-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Register a separate btd_profile for each role of AVRCP.
---
 profiles/audio/avrcp.c   | 80 +++++++++++++++++++++++++++++++++++++-----------
 profiles/audio/avrcp.h   |  6 ++--
 profiles/audio/manager.c | 71 ++++++++++++++++++++++++++++++------------
 3 files changed, 118 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 836ba9b..108fe4b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2785,41 +2785,63 @@ static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter,
 	return server;
 }
 
-int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
+int avrcp_target_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	sdp_record_t *record;
 	struct avrcp_server *server;
 
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
 	server = avrcp_server_register(adapter, config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
+done:
 	record = avrcp_tg_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		avrcp_unregister(adapter);
+		avrcp_target_unregister(adapter);
 		return -1;
 	}
 
 	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP target service record");
-		avrcp_unregister(adapter);
+		avrcp_target_unregister(adapter);
 		sdp_record_free(record);
 		return -1;
 	}
 	server->tg_record_id = record->handle;
 
+	return 0;
+}
+
+int avrcp_remote_register(struct btd_adapter *adapter, GKeyFile *config)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = avrcp_server_register(adapter, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
 	record = avrcp_ct_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		avrcp_unregister(adapter);
+		avrcp_remote_unregister(adapter);
 		return -1;
 	}
 
 	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP service record");
 		sdp_record_free(record);
-		avrcp_unregister(adapter);
+		avrcp_remote_unregister(adapter);
 		return -1;
 	}
 	server->ct_record_id = record->handle;
@@ -2827,25 +2849,13 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 	return 0;
 }
 
-void avrcp_unregister(struct btd_adapter *adapter)
+static void avrcp_server_unregister(struct avrcp_server *server)
 {
-	struct avrcp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
 	g_slist_free_full(server->sessions, g_free);
 	g_slist_free_full(server->players, player_destroy);
 
 	servers = g_slist_remove(servers, server);
 
-	if (server->ct_record_id != 0)
-		remove_record_from_server(server->ct_record_id);
-
-	if (server->tg_record_id != 0)
-		remove_record_from_server(server->tg_record_id);
-
 	avctp_unregister(server->adapter);
 	btd_adapter_unref(server->adapter);
 	g_free(server);
@@ -2859,6 +2869,40 @@ void avrcp_unregister(struct btd_adapter *adapter)
 	}
 }
 
+void avrcp_target_unregister(struct btd_adapter *adapter)
+{
+	struct avrcp_server *server;
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
+void avrcp_remote_unregister(struct btd_adapter *adapter)
+{
+	struct avrcp_server *server;
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
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
 						void *user_data,
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 3799da1..1f98090 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -93,8 +93,10 @@ struct avrcp_player_cb {
 							void *user_data);
 };
 
-int avrcp_register(struct btd_adapter *adapter, GKeyFile *config);
-void avrcp_unregister(struct btd_adapter *adapter);
+int avrcp_target_register(struct btd_adapter *adapter, GKeyFile *config);
+void avrcp_target_unregister(struct btd_adapter *adapter);
+int avrcp_remote_register(struct btd_adapter *adapter, GKeyFile *config);
+void avrcp_remote_unregister(struct btd_adapter *adapter);
 
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 934227e..3023249 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -229,7 +229,7 @@ static int a2dp_sink_disconnect(struct btd_device *dev,
 	return sink_disconnect(audio_dev, FALSE);
 }
 
-static int avrcp_control_connect(struct btd_device *dev,
+static int avrcp_target_connect(struct btd_device *dev,
 						struct btd_profile *profile)
 {
 	const char *path = device_get_path(dev);
@@ -246,7 +246,7 @@ static int avrcp_control_connect(struct btd_device *dev,
 	return control_connect(audio_dev);
 }
 
-static int avrcp_control_disconnect(struct btd_device *dev,
+static int avrcp_target_disconnect(struct btd_device *dev,
 						struct btd_profile *profile)
 {
 	const char *path = device_get_path(dev);
@@ -295,20 +295,36 @@ static void a2dp_sink_server_remove(struct btd_profile *p,
 	a2dp_sink_unregister(adapter);
 }
 
-static int avrcp_server_probe(struct btd_profile *p,
+static int avrcp_target_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	DBG("path %s", adapter_get_path(adapter));
 
-	return avrcp_register(adapter, config);
+	return avrcp_target_register(adapter, config);
 }
 
-static void avrcp_server_remove(struct btd_profile *p,
+static int avrcp_remote_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	DBG("path %s", adapter_get_path(adapter));
 
-	return avrcp_unregister(adapter);
+	return avrcp_remote_register(adapter, config);
+}
+
+static void avrcp_target_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	DBG("path %s", adapter_get_path(adapter));
+
+	avrcp_target_unregister(adapter);
+}
+
+static void avrcp_remote_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	DBG("path %s", adapter_get_path(adapter));
+
+	avrcp_remote_unregister(adapter);
 }
 
 static int media_server_probe(struct btd_adapter *adapter)
@@ -357,19 +373,30 @@ static struct btd_profile a2dp_sink_profile = {
 	.adapter_remove	= a2dp_sink_server_remove,
 };
 
-static struct btd_profile avrcp_profile = {
-	.name		= "audio-avrcp",
+static struct btd_profile avrcp_target_profile = {
+	.name		= "audio-avrcp-target",
 
-	.remote_uuids	= BTD_UUIDS(AVRCP_TARGET_UUID, AVRCP_REMOTE_UUID),
+	.remote_uuids	= BTD_UUIDS(AVRCP_TARGET_UUID),
 	.device_probe	= avrcp_probe,
 	.device_remove	= audio_remove,
 
 	.auto_connect	= true,
-	.connect	= avrcp_control_connect,
-	.disconnect	= avrcp_control_disconnect,
+	.connect	= avrcp_target_connect,
+	.disconnect	= avrcp_target_disconnect,
+
+	.adapter_probe	= avrcp_target_server_probe,
+	.adapter_remove = avrcp_target_server_remove,
+};
+
+static struct btd_profile avrcp_remote_profile = {
+	.name		= "audio-avrcp-control",
 
-	.adapter_probe	= avrcp_server_probe,
-	.adapter_remove = avrcp_server_remove,
+	.remote_uuids	= BTD_UUIDS(AVRCP_REMOTE_UUID),
+	.device_probe	= avrcp_probe,
+	.device_remove	= audio_remove,
+
+	.adapter_probe	= avrcp_remote_server_probe,
+	.adapter_remove = avrcp_remote_server_remove,
 };
 
 static struct btd_adapter_driver media_driver = {
@@ -400,12 +427,14 @@ void audio_source_disconnected(struct btd_device *dev, int err)
 
 void audio_control_connected(struct btd_device *dev, int err)
 {
-	device_profile_connected(dev, &avrcp_profile, err);
+	device_profile_connected(dev, &avrcp_target_profile, err);
+	device_profile_connected(dev, &avrcp_remote_profile, err);
 }
 
 void audio_control_disconnected(struct btd_device *dev, int err)
 {
-	device_profile_disconnected(dev, &avrcp_profile, err);
+	device_profile_disconnected(dev, &avrcp_target_profile, err);
+	device_profile_disconnected(dev, &avrcp_remote_profile, err);
 }
 
 int audio_manager_init(GKeyFile *conf)
@@ -449,8 +478,10 @@ proceed:
 	if (enabled.sink)
 		btd_profile_register(&a2dp_sink_profile);
 
-	if (enabled.control)
-		btd_profile_register(&avrcp_profile);
+	if (enabled.control) {
+		btd_profile_register(&avrcp_remote_profile);
+		btd_profile_register(&avrcp_target_profile);
+	}
 
 	btd_register_adapter_driver(&media_driver);
 
@@ -470,8 +501,10 @@ void audio_manager_exit(void)
 	if (enabled.sink)
 		btd_profile_unregister(&a2dp_sink_profile);
 
-	if (enabled.control)
-		btd_profile_unregister(&avrcp_profile);
+	if (enabled.control) {
+		btd_profile_unregister(&avrcp_remote_profile);
+		btd_profile_unregister(&avrcp_target_profile);
+	}
 
 	btd_unregister_adapter_driver(&media_driver);
 }
-- 
1.8.1

