Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio: Fix not releasing all references to btd_adapter
Date: Wed, 19 Dec 2012 16:29:07 +0200
Message-Id: <1355927348-19430-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A2DP server now take a reference to btd_adapter which needs to be
released properly once the adapter is unplugged.
---
 profiles/audio/a2dp.c    | 44 +++++++++++++++++++++++++++++++++++---------
 profiles/audio/a2dp.h    |  3 ++-
 profiles/audio/manager.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 145b1aa..46f41a6 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1224,7 +1224,16 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 	g_free(sep);
 }
 
-void a2dp_unregister(struct btd_adapter *adapter)
+static void a2dp_server_unregister(struct a2dp_server *server)
+{
+	avdtp_exit(server->adapter);
+
+	servers = g_slist_remove(servers, server);
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
+void a2dp_sink_unregister(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
 
@@ -1233,21 +1242,38 @@ void a2dp_unregister(struct btd_adapter *adapter)
 		return;
 
 	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
-	g_slist_free_full(server->sources,
-					(GDestroyNotify) a2dp_unregister_sep);
-
-	avdtp_exit(adapter);
 
-	servers = g_slist_remove(servers, server);
+	if (server->sink_record_id) {
+		remove_record_from_server(server->sink_record_id);
+		server->sink_record_id = 0;
+	}
 
 	if (server->source_record_id)
+		return;
+
+	a2dp_server_unregister(server);
+}
+
+void a2dp_source_unregister(struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	g_slist_free_full(server->sources,
+					(GDestroyNotify) a2dp_unregister_sep);
+
+	if (server->source_record_id) {
 		remove_record_from_server(server->source_record_id);
+		server->source_record_id = 0;
+	}
 
 	if (server->sink_record_id)
-		remove_record_from_server(server->sink_record_id);
+		return;
 
-	btd_adapter_unref(server->adapter);
-	g_free(server);
+	a2dp_server_unregister(server);
 }
 
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 54c3bf3..4819f7b 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -65,8 +65,9 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					void *user_data);
 
 int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
+void a2dp_source_unregister(struct btd_adapter *adapter);
 int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
-void a2dp_unregister(struct btd_adapter *adapter);
+void a2dp_sink_unregister(struct btd_adapter *adapter);
 
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b6b2385..bb5688f 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -336,6 +336,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
+	int err;
 
 	DBG("path %s", path);
 
@@ -343,9 +344,27 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	audio_adapter_unref(adp); /* Referenced by a2dp server */
+	err = a2dp_source_register(adapter, config);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
+}
+
+static void a2dp_source_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
 
-	return a2dp_source_register(adapter, config);
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	a2dp_source_unregister(adapter);
+	audio_adapter_unref(adp);
 }
 
 static int a2dp_sink_server_probe(struct btd_profile *p,
@@ -353,6 +372,7 @@ static int a2dp_sink_server_probe(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
+	int err;
 
 	DBG("path %s", path);
 
@@ -360,9 +380,27 @@ static int a2dp_sink_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	audio_adapter_unref(adp); /* Referenced by a2dp server */
+	err = a2dp_sink_register(adapter, config);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
+}
+
+static void a2dp_sink_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
 
-	return a2dp_sink_register(adapter, config);
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	a2dp_sink_unregister(adapter);
+	audio_adapter_unref(adp);
 }
 
 static int avrcp_server_probe(struct btd_profile *p,
@@ -446,6 +484,7 @@ static struct btd_profile a2dp_source_profile = {
 	.disconnect	= a2dp_source_disconnect,
 
 	.adapter_probe	= a2dp_source_server_probe,
+	.adapter_remove	= a2dp_source_server_remove,
 };
 
 static struct btd_profile a2dp_sink_profile = {
@@ -461,6 +500,7 @@ static struct btd_profile a2dp_sink_profile = {
 	.disconnect	= a2dp_sink_disconnect,
 
 	.adapter_probe	= a2dp_sink_server_probe,
+	.adapter_remove	= a2dp_sink_server_remove,
 };
 
 static struct btd_profile avrcp_profile = {
-- 
1.7.11.7

