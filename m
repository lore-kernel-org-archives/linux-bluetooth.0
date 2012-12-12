Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/16] a2dp: Convert a2dp_unregister to accept btd_adapter
Date: Wed, 12 Dec 2012 11:27:57 +0100
Message-ID: <1355308088-9080-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass btd_adapter directly or use getters to get needed data from
adapter object.
---
 profiles/audio/a2dp.c | 6 +++---
 profiles/audio/a2dp.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index eeecb43..c145ca4 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1228,11 +1228,11 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 	g_free(sep);
 }
 
-void a2dp_unregister(const bdaddr_t *src)
+void a2dp_unregister(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter_get_address(adapter));
 	if (!server)
 		return;
 
@@ -1240,7 +1240,7 @@ void a2dp_unregister(const bdaddr_t *src)
 	g_slist_free_full(server->sources,
 					(GDestroyNotify) a2dp_unregister_sep);
 
-	avdtp_exit(src);
+	avdtp_exit(adapter_get_address(adapter));
 
 	servers = g_slist_remove(servers, server);
 
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 827d5cc..f45e40d 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -66,7 +66,7 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 
 int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
 int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
-void a2dp_unregister(const bdaddr_t *src);
+void a2dp_unregister(struct btd_adapter *adapter);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
-- 
1.8.0

