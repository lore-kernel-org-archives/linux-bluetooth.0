Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/16] a2dp: Use btd_adapter ref in a2dp_server instead of bdaddr_t
Date: Wed, 12 Dec 2012 11:28:01 +0100
Message-ID: <1355308088-9080-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use local refs to device and adapter object instead of addresses.
This allows a2dp code to pass adapter object instead of address.
---
 profiles/audio/a2dp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 593fbf6..da54717 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -48,6 +48,7 @@
 #include "a2dp.h"
 #include "a2dp-codecs.h"
 #include "sdpd.h"
+#include "../src/manager.h"
 
 /* The duration that streams without users are allowed to stay in
  * STREAMING state. */
@@ -98,7 +99,7 @@ struct a2dp_setup {
 };
 
 struct a2dp_server {
-	bdaddr_t src;
+	struct btd_adapter *adapter;
 	GSList *sinks;
 	GSList *sources;
 	uint32_t source_record_id;
@@ -1147,13 +1148,13 @@ static sdp_record_t *a2dp_record(uint8_t type)
 	return record;
 }
 
-static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
+static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 {
 
 	for (; list; list = list->next) {
 		struct a2dp_server *server = list->data;
 
-		if (bacmp(&server->src, src) == 0)
+		if (server->adapter == a)
 			return server;
 	}
 
@@ -1175,7 +1176,7 @@ static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter,
 		return NULL;
 	}
 
-	bacpy(&server->src, adapter_get_address(adapter));
+	server->adapter = btd_adapter_ref(adapter);
 	servers = g_slist_append(servers, server);
 
 	return server;
@@ -1185,7 +1186,7 @@ int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, adapter_get_address(adapter));
+	server = find_server(servers, adapter);
 	if (server != NULL)
 		goto done;
 
@@ -1203,7 +1204,7 @@ int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, adapter_get_address(adapter));
+	server = find_server(servers, adapter);
 	if (server != NULL)
 		goto done;
 
@@ -1232,7 +1233,7 @@ void a2dp_unregister(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
 
-	server = find_server(servers, adapter_get_address(adapter));
+	server = find_server(servers, adapter);
 	if (!server)
 		return;
 
@@ -1250,6 +1251,7 @@ void a2dp_unregister(struct btd_adapter *adapter)
 	if (server->sink_record_id)
 		remove_record_from_server(server->sink_record_id);
 
+	btd_adapter_unref(server->adapter);
 	g_free(server);
 }
 
@@ -1265,7 +1267,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	uint32_t *record_id;
 	sdp_record_t *record;
 
-	server = find_server(servers, adapter_get_address(adapter));
+	server = find_server(servers, adapter);
 	if (server == NULL) {
 		if (err)
 			*err = -EPROTONOSUPPORT;
@@ -1327,7 +1329,8 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 		return NULL;
 	}
 
-	if (add_record_to_server(&server->src, record) < 0) {
+	if (add_record_to_server(adapter_get_address(server->adapter),
+								record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
 		avdtp_unregister_sep(sep->lsep);
@@ -1492,7 +1495,7 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	bdaddr_t src;
 
 	avdtp_get_peers(session, &src, NULL);
-	server = find_server(servers, &src);
+	server = find_server(servers, manager_find_adapter(&src));
 	if (!server)
 		return NULL;
 
@@ -1571,7 +1574,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	bdaddr_t src;
 
 	avdtp_get_peers(session, &src, NULL);
-	server = find_server(servers, &src);
+	server = find_server(servers, manager_find_adapter(&src));
 	if (!server)
 		return 0;
 
@@ -1888,7 +1891,7 @@ struct a2dp_sep *a2dp_get_sep(struct avdtp *session,
 	for (l = servers; l; l = l->next) {
 		server = l->data;
 
-		if (bacmp(&src, &server->src) == 0)
+		if (bacmp(&src, adapter_get_address(server->adapter)) == 0)
 			break;
 	}
 
-- 
1.8.0

