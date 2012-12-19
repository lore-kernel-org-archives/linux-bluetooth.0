Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] a2dp: Fix server unregister
Date: Wed, 19 Dec 2012 14:51:34 +0100
Message-ID: <1355925094-22695-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When removing sink or source unregister its sep and sdp record. When
both sink and source are unregistered also unregister a2dp server.
---
 profiles/audio/a2dp.c    | 48 +++++++++++++++++++++++++++++++++++++++---------
 profiles/audio/a2dp.h    |  3 ++-
 profiles/audio/manager.c | 14 ++++++++++++++
 3 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 145b1aa..3ec8b43 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1224,7 +1224,20 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 	g_free(sep);
 }
 
-void a2dp_unregister(struct btd_adapter *adapter)
+static void a2dp_unregister(struct a2dp_server *server)
+{
+	if (server->sink_enabled || server->source_enabled)
+		return;
+
+	avdtp_exit(server->adapter);
+
+	servers = g_slist_remove(servers, server);
+
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
+void a2dp_source_unregister(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
 
@@ -1232,22 +1245,39 @@ void a2dp_unregister(struct btd_adapter *adapter)
 	if (!server)
 		return;
 
-	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
+	server->source_enabled = FALSE;
+
 	g_slist_free_full(server->sources,
 					(GDestroyNotify) a2dp_unregister_sep);
+	server->sources = NULL;
 
-	avdtp_exit(adapter);
+	if (server->source_record_id > 0) {
+		remove_record_from_server(server->source_record_id);
+		server->source_record_id = 0;
+	}
 
-	servers = g_slist_remove(servers, server);
+	a2dp_unregister(server);
+}
 
-	if (server->source_record_id)
-		remove_record_from_server(server->source_record_id);
+void a2dp_sink_unregister(struct btd_adapter *adapter)
+{
+	struct a2dp_server *server;
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	server->sink_enabled = FALSE;
+
+	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
+	server->sinks = NULL;
 
-	if (server->sink_record_id)
+	if (server->sink_record_id > 0) {
 		remove_record_from_server(server->sink_record_id);
+		server->sink_record_id = 0;
+	}
 
-	btd_adapter_unref(server->adapter);
-	g_free(server);
+	a2dp_unregister(server);
 }
 
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 54c3bf3..af5c27d 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -66,7 +66,8 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 
 int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
 int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
-void a2dp_unregister(struct btd_adapter *adapter);
+void a2dp_source_unregister(struct btd_adapter *adapter);
+void a2dp_sink_unregister(struct btd_adapter *adapter);
 
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b6b2385..5e30fa8 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -348,6 +348,12 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 	return a2dp_source_register(adapter, config);
 }
 
+static void a2dp_source_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	a2dp_source_unregister(adapter);
+}
+
 static int a2dp_sink_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -365,6 +371,12 @@ static int a2dp_sink_server_probe(struct btd_profile *p,
 	return a2dp_sink_register(adapter, config);
 }
 
+static void a2dp_sink_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	a2dp_sink_unregister(adapter);
+}
+
 static int avrcp_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -446,6 +458,7 @@ static struct btd_profile a2dp_source_profile = {
 	.disconnect	= a2dp_source_disconnect,
 
 	.adapter_probe	= a2dp_source_server_probe,
+	.adapter_remove = a2dp_source_server_remove,
 };
 
 static struct btd_profile a2dp_sink_profile = {
@@ -461,6 +474,7 @@ static struct btd_profile a2dp_sink_profile = {
 	.disconnect	= a2dp_sink_disconnect,
 
 	.adapter_probe	= a2dp_sink_server_probe,
+	.adapter_remove = a2dp_sink_server_remove,
 };
 
 static struct btd_profile avrcp_profile = {
-- 
1.8.0

