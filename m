Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 1/5] avrcp: Refactor server registration
Date: Tue, 18 Dec 2012 15:01:23 +0100
Message-Id: <1355839287-8373-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use a helper function to install the AVRCP server, just like other audio
profiles such as in a2dp.c do.
---
 profiles/audio/avrcp.c | 55 +++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3ab7d35..b32c422 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2275,12 +2275,12 @@ void avrcp_disconnect(struct audio_device *dev)
 	avctp_disconnect(session);
 }
 
-int avrcp_register(const bdaddr_t *src, GKeyFile *config)
+static struct avrcp_server *avrcp_server_register(const bdaddr_t *src,
+							GKeyFile *config)
 {
-	sdp_record_t *record;
+	struct avrcp_server *server;
 	gboolean tmp, master = TRUE;
 	GError *err = NULL;
-	struct avrcp_server *server;
 
 	if (config) {
 		tmp = g_key_file_get_boolean(config, "General",
@@ -2292,18 +2292,38 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 			master = tmp;
 	}
 
+	if (avctp_register(src, master) < 0)
+		return NULL;
+
 	server = g_new0(struct avrcp_server, 1);
+	bacpy(&server->src, src);
+	servers = g_slist_append(servers, server);
+
+	if (!avctp_id)
+		avctp_id = avctp_add_state_cb(state_changed, NULL);
+
+	return server;
+}
+
+int avrcp_register(const bdaddr_t *src, GKeyFile *config)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	server = avrcp_server_register(src, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
 
 	record = avrcp_tg_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		g_free(server);
+		avrcp_unregister(src);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP target service record");
-		g_free(server);
+		avrcp_unregister(src);
 		sdp_record_free(record);
 		return -1;
 	}
@@ -2312,32 +2332,18 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	record = avrcp_ct_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		g_free(server);
+		avrcp_unregister(src);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP service record");
 		sdp_record_free(record);
-		g_free(server);
+		avrcp_unregister(src);
 		return -1;
 	}
 	server->ct_record_id = record->handle;
 
-	if (avctp_register(src, master) < 0) {
-		remove_record_from_server(server->ct_record_id);
-		remove_record_from_server(server->tg_record_id);
-		g_free(server);
-		return -1;
-	}
-
-	bacpy(&server->src, src);
-
-	servers = g_slist_append(servers, server);
-
-	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL);
-
 	return 0;
 }
 
@@ -2354,8 +2360,11 @@ void avrcp_unregister(const bdaddr_t *src)
 
 	servers = g_slist_remove(servers, server);
 
-	remove_record_from_server(server->ct_record_id);
-	remove_record_from_server(server->tg_record_id);
+	if (server->ct_record_id != 0)
+		remove_record_from_server(server->ct_record_id);
+
+	if (server->tg_record_id != 0)
+		remove_record_from_server(server->tg_record_id);
 
 	avctp_unregister(&server->src);
 	g_free(server);
-- 
1.7.11.7

