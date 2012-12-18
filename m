Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 2/5] audio: Split AVRCP into two btd_profile
Date: Tue, 18 Dec 2012 15:01:24 +0100
Message-Id: <1355839287-8373-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Register a separate btd_profile for each role of AVRCP.
---
 profiles/audio/audio.conf |  2 +-
 profiles/audio/avrcp.c    | 80 ++++++++++++++++++++++++++++++++++++-----------
 profiles/audio/avrcp.h    |  6 ++--
 profiles/audio/manager.c  | 80 ++++++++++++++++++++++++++++++++++++++++-------
 profiles/audio/manager.h  |  1 +
 5 files changed, 137 insertions(+), 32 deletions(-)

diff --git a/profiles/audio/audio.conf b/profiles/audio/audio.conf
index f556610..566454b 100644
--- a/profiles/audio/audio.conf
+++ b/profiles/audio/audio.conf
@@ -8,5 +8,5 @@
 #Master=true
 
 # If we want to disable support for specific services
-# Defaults to supporting the services: Sink, Control
+# Defaults to supporting the services: Sink, Control, Target
 #Disable=Source
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b32c422..22dd1a5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2305,41 +2305,63 @@ static struct avrcp_server *avrcp_server_register(const bdaddr_t *src,
 	return server;
 }
 
-int avrcp_register(const bdaddr_t *src, GKeyFile *config)
+int avrcp_target_register(const bdaddr_t *src, GKeyFile *config)
 {
 	sdp_record_t *record;
 	struct avrcp_server *server;
 
+	server = find_server(servers, src);
+	if (server != NULL)
+		goto done;
+
 	server = avrcp_server_register(src, config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
+done:
 	record = avrcp_tg_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		avrcp_unregister(src);
+		avrcp_target_unregister(src);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP target service record");
-		avrcp_unregister(src);
+		avrcp_target_unregister(src);
 		sdp_record_free(record);
 		return -1;
 	}
 	server->tg_record_id = record->handle;
 
+	return 0;
+}
+
+int avrcp_control_register(const bdaddr_t *src, GKeyFile *config)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	server = find_server(servers, src);
+	if (server != NULL)
+		goto done;
+
+	server = avrcp_server_register(src, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
 	record = avrcp_ct_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		avrcp_unregister(src);
+		avrcp_control_unregister(src);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP service record");
 		sdp_record_free(record);
-		avrcp_unregister(src);
+		avrcp_control_unregister(src);
 		return -1;
 	}
 	server->ct_record_id = record->handle;
@@ -2347,25 +2369,13 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	return 0;
 }
 
-void avrcp_unregister(const bdaddr_t *src)
+static void avrcp_server_unregister(struct avrcp_server *server)
 {
-	struct avrcp_server *server;
-
-	server = find_server(servers, src);
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
 	avctp_unregister(&server->src);
 	g_free(server);
 
@@ -2378,6 +2388,40 @@ void avrcp_unregister(const bdaddr_t *src)
 	}
 }
 
+void avrcp_target_unregister(const bdaddr_t *src)
+{
+	struct avrcp_server *server;
+
+	server = find_server(servers, src);
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
+void avrcp_control_unregister(const bdaddr_t *src)
+{
+	struct avrcp_server *server;
+
+	server = find_server(servers, src);
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
 struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 						struct avrcp_player_cb *cb,
 						void *user_data,
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index e607fb1..cddf40b 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -92,8 +92,10 @@ struct avrcp_player_cb {
 							void *user_data);
 };
 
-int avrcp_register(const bdaddr_t *src, GKeyFile *config);
-void avrcp_unregister(const bdaddr_t *src);
+int avrcp_target_register(const bdaddr_t *src, GKeyFile *config);
+void avrcp_target_unregister(const bdaddr_t *src);
+int avrcp_control_register(const bdaddr_t *src, GKeyFile *config);
+void avrcp_control_unregister(const bdaddr_t *src);
 
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 422316e..976a879 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -82,6 +82,7 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
+	.target		= TRUE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -371,7 +372,7 @@ static int a2dp_sink_server_probe(struct btd_profile *p,
 	return a2dp_sink_register(adapter_get_address(adapter), config);
 }
 
-static int avrcp_server_probe(struct btd_profile *p,
+static int avrcp_target_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -384,14 +385,50 @@ static int avrcp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	err = avrcp_register(adapter_get_address(adapter), config);
+	err = avrcp_target_register(adapter_get_address(adapter), config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
 	return err;
 }
 
-static void avrcp_server_remove(struct btd_profile *p,
+static int avrcp_control_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+	int err;
+
+	DBG("path %s", path);
+
+	adp = audio_adapter_get(adapter);
+	if (!adp)
+		return -EINVAL;
+
+	err = avrcp_control_register(adapter_get_address(adapter), config);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
+}
+
+static void avrcp_target_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	avrcp_target_unregister(adapter_get_address(adapter));
+	audio_adapter_unref(adp);
+}
+
+static void avrcp_control_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -403,7 +440,7 @@ static void avrcp_server_remove(struct btd_profile *p,
 	if (!adp)
 		return;
 
-	avrcp_unregister(adapter_get_address(adapter));
+	avrcp_control_unregister(adapter_get_address(adapter));
 	audio_adapter_unref(adp);
 }
 
@@ -471,10 +508,21 @@ static struct btd_profile a2dp_sink_profile = {
 	.adapter_probe	= a2dp_sink_server_probe,
 };
 
-static struct btd_profile avrcp_profile = {
-	.name		= "audio-avrcp",
+static struct btd_profile avrcp_target_profile = {
+	.name		= "audio-avrcp-target",
+
+	.remote_uuids	= BTD_UUIDS(AVRCP_TARGET_UUID),
+	.device_probe	= avrcp_probe,
+	.device_remove	= audio_remove,
+
+	.adapter_probe	= avrcp_target_server_probe,
+	.adapter_remove = avrcp_target_server_remove,
+};
+
+static struct btd_profile avrcp_control_profile = {
+	.name		= "audio-avrcp-control",
 
-	.remote_uuids	= BTD_UUIDS(AVRCP_TARGET_UUID, AVRCP_REMOTE_UUID),
+	.remote_uuids	= BTD_UUIDS(AVRCP_REMOTE_UUID),
 	.device_probe	= avrcp_probe,
 	.device_remove	= audio_remove,
 
@@ -482,8 +530,8 @@ static struct btd_profile avrcp_profile = {
 	.connect	= avrcp_control_connect,
 	.disconnect	= avrcp_control_disconnect,
 
-	.adapter_probe	= avrcp_server_probe,
-	.adapter_remove = avrcp_server_remove,
+	.adapter_probe	= avrcp_control_server_probe,
+	.adapter_remove = avrcp_control_server_remove,
 };
 
 static struct btd_adapter_driver media_driver = {
@@ -531,6 +579,8 @@ int audio_manager_init(GKeyFile *conf)
 			enabled.source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
+		else if (g_str_equal(list[i], "Target"))
+			enabled.target = TRUE;
 	}
 	g_strfreev(list);
 
@@ -543,6 +593,8 @@ int audio_manager_init(GKeyFile *conf)
 			enabled.source = FALSE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = FALSE;
+		else if (g_str_equal(list[i], "Target"))
+			enabled.target = FALSE;
 	}
 	g_strfreev(list);
 
@@ -554,7 +606,10 @@ proceed:
 		btd_profile_register(&a2dp_sink_profile);
 
 	if (enabled.control)
-		btd_profile_register(&avrcp_profile);
+		btd_profile_register(&avrcp_control_profile);
+
+	if (enabled.target)
+		btd_profile_register(&avrcp_target_profile);
 
 	btd_register_adapter_driver(&media_driver);
 
@@ -575,7 +630,10 @@ void audio_manager_exit(void)
 		btd_profile_unregister(&a2dp_sink_profile);
 
 	if (enabled.control)
-		btd_profile_unregister(&avrcp_profile);
+		btd_profile_unregister(&avrcp_control_profile);
+
+	if (enabled.target)
+		btd_profile_unregister(&avrcp_target_profile);
 
 	btd_unregister_adapter_driver(&media_driver);
 }
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 2b924dc..fc5362b 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -26,6 +26,7 @@ struct enabled_interfaces {
 	gboolean sink;
 	gboolean source;
 	gboolean control;
+	gboolean target;
 	gboolean media_player;
 };
 
-- 
1.7.11.7

