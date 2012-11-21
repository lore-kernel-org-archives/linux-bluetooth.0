Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] audio: Split A2DP into two btd_profile
Date: Wed, 21 Nov 2012 14:10:14 +0200
Message-Id: <1353499818-10153-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
References: <1353499818-10153-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Merging the three audio profiles (AVDTP, A2DP sink and A2DP source)
into one was convenient in the past was doesn't fit very well the new
btd_profile approach. The split is also more consistent with other
existing profiles.
---
 profiles/audio/a2dp.c    | 80 +++++++++++++++++++++++------------------------
 profiles/audio/a2dp.h    |  3 +-
 profiles/audio/manager.c | 81 +++++++++++++++++++++++++++++++-----------------
 3 files changed, 92 insertions(+), 72 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 50c0f43..177f653 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1166,63 +1166,59 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
-int a2dp_register(const bdaddr_t *src, GKeyFile *config)
+static struct a2dp_server *a2dp_server_register(const bdaddr_t *src,
+							GKeyFile *config)
 {
-	gboolean source = TRUE, sink = FALSE;
-	char *str;
-	GError *err = NULL;
 	struct a2dp_server *server;
+	int av_err;
 
-	if (!config)
-		goto proceed;
+	server = g_new0(struct a2dp_server, 1);
 
-	str = g_key_file_get_string(config, "General", "Enable", &err);
-
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		if (strstr(str, "Sink"))
-			source = TRUE;
-		if (strstr(str, "Source"))
-			sink = TRUE;
-		g_free(str);
+	av_err = avdtp_init(src, config);
+	if (av_err < 0) {
+		DBG("AVDTP not registered");
+		g_free(server);
+		return NULL;
 	}
 
-	str = g_key_file_get_string(config, "General", "Disable", &err);
+	bacpy(&server->src, src);
+	servers = g_slist_append(servers, server);
 
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		if (strstr(str, "Sink"))
-			source = FALSE;
-		if (strstr(str, "Source"))
-			sink = FALSE;
-		g_free(str);
-	}
+	return server;
+}
 
-proceed:
+int a2dp_source_register(const bdaddr_t *src, GKeyFile *config)
+{
+	struct a2dp_server *server;
 
 	server = find_server(servers, src);
-	if (!server) {
-		int av_err;
+	if (server != NULL)
+		goto done;
 
-		server = g_new0(struct a2dp_server, 1);
+	server = a2dp_server_register(src, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
 
-		av_err = avdtp_init(src, config);
-		if (av_err < 0) {
-			g_free(server);
-			return av_err;
-		}
+done:
+	server->source_enabled = TRUE;
 
-		bacpy(&server->src, src);
-		servers = g_slist_append(servers, server);
-	}
+	return 0;
+}
 
-	server->source_enabled = source;
+int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config)
+{
+	struct a2dp_server *server;
 
-	server->sink_enabled = sink;
+	server = find_server(servers, src);
+	if (server != NULL)
+		goto done;
+
+	server = a2dp_server_register(src, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
+
+done:
+	server->sink_enabled = TRUE;
 
 	return 0;
 }
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 736bc66..ded1060 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -64,7 +64,8 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					struct avdtp_error *err,
 					void *user_data);
 
-int a2dp_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_source_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index e453e26..2f36efd 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -122,7 +122,7 @@ static void audio_remove(struct btd_profile *p, struct btd_device *device)
 	audio_device_unregister(dev);
 }
 
-static int a2dp_probe(struct btd_profile *p, struct btd_device *device,
+static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	struct audio_device *audio_dev;
@@ -133,13 +133,23 @@ static int a2dp_probe(struct btd_profile *p, struct btd_device *device,
 		return -1;
 	}
 
-	if (g_slist_find_custom(uuids, A2DP_SINK_UUID, bt_uuid_strcmp) &&
-						audio_dev->sink == NULL)
-		audio_dev->sink = sink_init(audio_dev);
+	audio_dev->source = source_init(audio_dev);
 
-	if (g_slist_find_custom(uuids, A2DP_SOURCE_UUID, bt_uuid_strcmp) &&
-						audio_dev->source == NULL)
-		audio_dev->source = source_init(audio_dev);
+	return 0;
+}
+
+static int a2dp_sink_probe(struct btd_profile *p, struct btd_device *device,
+								GSList *uuids)
+{
+	struct audio_device *audio_dev;
+
+	audio_dev = get_audio_dev(device);
+	if (!audio_dev) {
+		DBG("unable to get a device object");
+		return -1;
+	}
+
+	audio_dev->sink = sink_init(audio_dev);
 
 	return 0;
 }
@@ -213,12 +223,11 @@ static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
 	return adp;
 }
 
-static int a2dp_server_probe(struct btd_profile *p,
+static int a2dp_source_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	int err;
 
 	DBG("path %s", path);
 
@@ -226,14 +235,12 @@ static int a2dp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	err = a2dp_register(adapter_get_address(adapter), config);
-	if (err < 0)
-		audio_adapter_unref(adp);
+	audio_adapter_unref(adp); /* Referenced by a2dp server */
 
-	return err;
+	return a2dp_source_register(adapter_get_address(adapter), config);
 }
 
-static void a2dp_server_remove(struct btd_profile *p,
+static int a2dp_sink_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -241,12 +248,13 @@ static void a2dp_server_remove(struct btd_profile *p,
 
 	DBG("path %s", path);
 
-	adp = find_adapter(adapters, adapter);
+	adp = audio_adapter_get(adapter);
 	if (!adp)
-		return;
+		return -EINVAL;
 
-	a2dp_unregister(adapter_get_address(adapter));
-	audio_adapter_unref(adp);
+	audio_adapter_unref(adp); /* Referenced by a2dp server */
+
+	return a2dp_sink_register(adapter_get_address(adapter), config);
 }
 
 static int avrcp_server_probe(struct btd_profile *p,
@@ -319,17 +327,26 @@ static void media_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
-static struct btd_profile a2dp_profile = {
-	.name		= "audio-a2dp",
+static struct btd_profile a2dp_source_profile = {
+	.name		= "audio-source",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 
-	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID, A2DP_SINK_UUID,
-							ADVANCED_AUDIO_UUID),
-	.device_probe	= a2dp_probe,
+	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID),
+	.device_probe	= a2dp_source_probe,
 	.device_remove	= audio_remove,
 
-	.adapter_probe	= a2dp_server_probe,
-	.adapter_remove = a2dp_server_remove,
+	.adapter_probe	= a2dp_source_server_probe,
+};
+
+static struct btd_profile a2dp_sink_profile = {
+	.name		= "audio-sink",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+
+	.remote_uuids	= BTD_UUIDS(A2DP_SINK_UUID),
+	.device_probe	= a2dp_sink_probe,
+	.device_remove	= audio_remove,
+
+	.adapter_probe	= a2dp_sink_server_probe,
 };
 
 static struct btd_profile avrcp_profile = {
@@ -402,8 +419,11 @@ int audio_manager_init(GKeyFile *conf)
 		max_connected_headsets = i;
 
 proceed:
-	if (enabled.source || enabled.sink)
-		btd_profile_register(&a2dp_profile);
+	if (enabled.source)
+		btd_profile_register(&a2dp_source_profile);
+
+	if (enabled.sink)
+		btd_profile_register(&a2dp_sink_profile);
 
 	if (enabled.control)
 		btd_profile_register(&avrcp_profile);
@@ -420,8 +440,11 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
-	if (enabled.source || enabled.sink)
-		btd_profile_unregister(&a2dp_profile);
+	if (enabled.source)
+		btd_profile_unregister(&a2dp_source_profile);
+
+	if (enabled.sink)
+		btd_profile_unregister(&a2dp_sink_profile);
 
 	if (enabled.control)
 		btd_profile_unregister(&avrcp_profile);
-- 
1.7.11.7

