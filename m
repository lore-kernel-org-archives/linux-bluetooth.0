Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 1/7] avrcp: Refactor server registration
Date: Wed,  6 Feb 2013 10:16:21 +0100
Message-Id: <1360142187-15347-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use a helper function to install the AVRCP server, just like other audio
profiles such as in a2dp.c do.
---
 profiles/audio/avrcp.c | 54 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 00eeea1..277f9f3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2681,9 +2681,9 @@ void avrcp_disconnect(struct audio_device *dev)
 	avctp_disconnect(session);
 }
 
-int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
+static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter,
+							GKeyFile *config)
 {
-	sdp_record_t *record;
 	gboolean tmp, master = TRUE;
 	GError *err = NULL;
 	struct avrcp_server *server;
@@ -2698,18 +2698,39 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 			master = tmp;
 	}
 
+	if (avctp_register(adapter, master) < 0)
+		return NULL;
+
 	server = g_new0(struct avrcp_server, 1);
+	server->adapter = btd_adapter_ref(adapter);
+
+	servers = g_slist_append(servers, server);
+
+	if (!avctp_id)
+		avctp_id = avctp_add_state_cb(state_changed, NULL);
+
+	return server;
+}
+
+int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
+{
+	sdp_record_t *record;
+	struct avrcp_server *server;
+
+	server = avrcp_server_register(adapter, config);
+	if (server == NULL)
+		return -EPROTONOSUPPORT;
 
 	record = avrcp_tg_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		g_free(server);
+		avrcp_unregister(adapter);
 		return -1;
 	}
 
 	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP target service record");
-		g_free(server);
+		avrcp_unregister(adapter);
 		sdp_record_free(record);
 		return -1;
 	}
@@ -2718,32 +2739,18 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 	record = avrcp_ct_record();
 	if (!record) {
 		error("Unable to allocate new service record");
-		g_free(server);
+		avrcp_unregister(adapter);
 		return -1;
 	}
 
 	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP service record");
 		sdp_record_free(record);
-		g_free(server);
+		avrcp_unregister(adapter);
 		return -1;
 	}
 	server->ct_record_id = record->handle;
 
-	if (avctp_register(adapter, master) < 0) {
-		remove_record_from_server(server->ct_record_id);
-		remove_record_from_server(server->tg_record_id);
-		g_free(server);
-		return -1;
-	}
-
-	server->adapter = btd_adapter_ref(adapter);
-
-	servers = g_slist_append(servers, server);
-
-	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL);
-
 	return 0;
 }
 
@@ -2760,8 +2767,11 @@ void avrcp_unregister(struct btd_adapter *adapter)
 
 	servers = g_slist_remove(servers, server);
 
-	remove_record_from_server(server->ct_record_id);
-	remove_record_from_server(server->tg_record_id);
+	if (server->ct_record_id != 0)
+		remove_record_from_server(server->ct_record_id);
+
+	if (server->tg_record_id != 0)
+		remove_record_from_server(server->tg_record_id);
 
 	avctp_unregister(server->adapter);
 	btd_adapter_unref(server->adapter);
-- 
1.8.1

