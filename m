Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 06/15] audio: Split A2DP into three btd_profile
Date: Fri, 19 Oct 2012 17:39:23 +0200
Message-Id: <1350661172-18125-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Merging the three audio profiles (AVDTP, A2DP sink and A2DP source)
into one was convenient in the past was doesn't fit very well the new
btd_profile approach. The split is also more consistent with the
approach of the HFP/HSP profile.
---
 audio/a2dp.c    |  88 ++++++++++++++++++++++-------------------------
 audio/a2dp.h    |   4 ++-
 audio/manager.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 133 insertions(+), 64 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 7799420..6bfc8c2 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1167,73 +1167,67 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
-int a2dp_register(const bdaddr_t *src, GKeyFile *config)
+int a2dp_server_register(const bdaddr_t *src, GKeyFile *config)
 {
-	gboolean source = TRUE, sink = FALSE;
 	gboolean delay_reporting = FALSE;
-	char *str;
-	GError *err = NULL;
 	struct a2dp_server *server;
+	int av_err;
 
-	if (!config)
-		goto proceed;
+	server = find_server(servers, src);
+	if (server)
+		return 0;
 
-	str = g_key_file_get_string(config, "General", "Enable", &err);
+	server = g_new0(struct a2dp_server, 1);
 
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		if (strstr(str, "Sink"))
-			source = TRUE;
-		if (strstr(str, "Source"))
-			sink = TRUE;
-		g_free(str);
+	av_err = avdtp_init(src, config, &server->version);
+	if (av_err < 0) {
+		g_free(server);
+		return av_err;
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
+	if (config)
+		delay_reporting = g_key_file_get_boolean(config, "A2DP",
+						"DelayReporting", NULL);
 
-proceed:
+	if (delay_reporting)
+		server->version = 0x0103;
+	else
+		server->version = 0x0102;
+
+	return 0;
+}
+
+int a2dp_source_register(const bdaddr_t *src, GKeyFile *config)
+{
+	struct a2dp_server *server;
 
 	server = find_server(servers, src);
 	if (!server) {
-		int av_err;
+		DBG("AVDTP not registered");
+		return -EPROTONOSUPPORT;
 
-		server = g_new0(struct a2dp_server, 1);
+	}
 
-		av_err = avdtp_init(src, config, &server->version);
-		if (av_err < 0) {
-			g_free(server);
-			return av_err;
-		}
+	server->source_enabled = TRUE;
 
-		bacpy(&server->src, src);
-		servers = g_slist_append(servers, server);
-	}
+	return 0;
+}
 
-	if (config)
-		delay_reporting = g_key_file_get_boolean(config, "A2DP",
-						"DelayReporting", NULL);
+int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config)
+{
+	struct a2dp_server *server;
 
-	if (delay_reporting)
-		server->version = 0x0103;
-	else
-		server->version = 0x0102;
+	server = find_server(servers, src);
+	if (!server) {
+		DBG("AVDTP not registered");
+		return -EPROTONOSUPPORT;
 
-	server->source_enabled = source;
+	}
 
-	server->sink_enabled = sink;
+	server->sink_enabled = TRUE;
 
 	return 0;
 }
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 736bc66..c471499 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -64,7 +64,9 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					struct avdtp_error *err,
 					void *user_data);
 
-int a2dp_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_server_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_source_register(const bdaddr_t *src, GKeyFile *config);
+int a2dp_sink_register(const bdaddr_t *src, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
diff --git a/audio/manager.c b/audio/manager.c
index 4ea61bf..c5d295e 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -722,7 +722,7 @@ static int ag_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static int a2dp_probe(struct btd_profile *p, struct btd_device *device,
+static int a2dp_source_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	struct audio_device *audio_dev;
@@ -733,13 +733,23 @@ static int a2dp_probe(struct btd_profile *p, struct btd_device *device,
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
@@ -975,7 +985,7 @@ static int a2dp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	err = a2dp_register(adapter_get_address(adapter), config);
+	err = a2dp_server_register(adapter_get_address(adapter), config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -998,6 +1008,40 @@ static void a2dp_server_remove(struct btd_profile *p,
 	audio_adapter_unref(adp);
 }
 
+static int a2dp_source_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	adp = audio_adapter_get(adapter);
+	if (!adp)
+		return -EINVAL;
+
+	audio_adapter_unref(adp); /* Referenced by a2dp server */
+
+	return a2dp_source_register(adapter_get_address(adapter), config);
+}
+
+static int a2dp_sink_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	adp = audio_adapter_get(adapter);
+	if (!adp)
+		return -EINVAL;
+
+	audio_adapter_unref(adp); /* Referenced by a2dp server */
+
+	return a2dp_sink_register(adapter_get_address(adapter), config);
+}
+
 static int avrcp_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -1090,18 +1134,35 @@ static struct btd_profile gateway_profile = {
 	.adapter_remove = gateway_server_remove,
 };
 
-static struct btd_profile a2dp_profile = {
-	.name		= "audio-a2dp",
+static struct btd_profile avdtp_profile = {
+	.name		= "audio-avdtp",
 
-	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID, A2DP_SINK_UUID,
-							ADVANCED_AUDIO_UUID),
-	.device_probe	= a2dp_probe,
-	.device_remove	= audio_remove,
+	.remote_uuids	= BTD_UUIDS(ADVANCED_AUDIO_UUID),
 
 	.adapter_probe	= a2dp_server_probe,
 	.adapter_remove = a2dp_server_remove,
 };
 
+static struct btd_profile a2dp_source_profile = {
+	.name		= "audio-source",
+
+	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID),
+	.device_probe	= a2dp_source_probe,
+	.device_remove	= audio_remove,
+
+	.adapter_probe	= a2dp_source_server_probe,
+};
+
+static struct btd_profile a2dp_sink_profile = {
+	.name		= "audio-sink",
+
+	.remote_uuids	= BTD_UUIDS(A2DP_SINK_UUID),
+	.device_probe	= a2dp_sink_probe,
+	.device_remove	= audio_remove,
+
+	.adapter_probe	= a2dp_sink_server_probe,
+};
+
 static struct btd_profile avrcp_profile = {
 	.name		= "audio-avrcp",
 
@@ -1194,7 +1255,13 @@ proceed:
 		btd_profile_register(&gateway_profile);
 
 	if (enabled.source || enabled.sink)
-		btd_profile_register(&a2dp_profile);
+		btd_profile_register(&avdtp_profile);
+
+	if (enabled.source)
+		btd_profile_register(&a2dp_source_profile);
+
+	if (enabled.sink)
+		btd_profile_register(&a2dp_sink_profile);
 
 	if (enabled.control)
 		btd_profile_register(&avrcp_profile);
@@ -1219,8 +1286,14 @@ void audio_manager_exit(void)
 	if (enabled.gateway)
 		btd_profile_unregister(&gateway_profile);
 
+	if (enabled.source)
+		btd_profile_unregister(&a2dp_source_profile);
+
+	if (enabled.sink)
+		btd_profile_unregister(&a2dp_sink_profile);
+
 	if (enabled.source || enabled.sink)
-		btd_profile_unregister(&a2dp_profile);
+		btd_profile_unregister(&avdtp_profile);
 
 	if (enabled.control)
 		btd_profile_unregister(&avrcp_profile);
-- 
1.7.11.7

