Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/16] avrcp: Convert to accept btd_adapter instead of bdaddr_t
Date: Wed, 12 Dec 2012 11:28:02 +0100
Message-ID: <1355308088-9080-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes avrcp code use reference to btd_adapter structure instead
of adapter source address.
---
 profiles/audio/avrcp.c   | 37 ++++++++++++++++---------------------
 profiles/audio/avrcp.h   |  6 +++---
 profiles/audio/manager.c |  4 ++--
 profiles/audio/media.c   |  5 ++---
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3ab7d35..668cd87 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -159,7 +159,7 @@ struct avrcp_browsing_header {
 #define AVRCP_BROWSING_HEADER_LENGTH 3
 
 struct avrcp_server {
-	bdaddr_t src;
+	struct btd_adapter *adapter;
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 	GSList *players;
@@ -1536,12 +1536,12 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
-static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
+static struct avrcp_server *find_server(GSList *list, struct btd_adapter *a)
 {
 	for (; list; list = list->next) {
 		struct avrcp_server *server = list->data;
 
-		if (bacmp(&server->src, src) == 0)
+		if (server->adapter == a)
 			return server;
 	}
 
@@ -2217,11 +2217,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
-	const bdaddr_t *src;
 
-	src = adapter_get_address(device_get_adapter(dev->btd_dev));
-
-	server = find_server(servers, src);
+	server = find_server(servers, device_get_adapter(dev->btd_dev));
 	if (!server)
 		return;
 
@@ -2275,7 +2272,7 @@ void avrcp_disconnect(struct audio_device *dev)
 	avctp_disconnect(session);
 }
 
-int avrcp_register(const bdaddr_t *src, GKeyFile *config)
+int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 {
 	sdp_record_t *record;
 	gboolean tmp, master = TRUE;
@@ -2301,7 +2298,7 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 		return -1;
 	}
 
-	if (add_record_to_server(src, record) < 0) {
+	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP target service record");
 		g_free(server);
 		sdp_record_free(record);
@@ -2316,7 +2313,7 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 		return -1;
 	}
 
-	if (add_record_to_server(src, record) < 0) {
+	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
 		error("Unable to register AVRCP service record");
 		sdp_record_free(record);
 		g_free(server);
@@ -2324,14 +2321,14 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	}
 	server->ct_record_id = record->handle;
 
-	if (avctp_register(src, master) < 0) {
+	if (avctp_register(adapter_get_address(adapter), master) < 0) {
 		remove_record_from_server(server->ct_record_id);
 		remove_record_from_server(server->tg_record_id);
 		g_free(server);
 		return -1;
 	}
 
-	bacpy(&server->src, src);
+	server->adapter = btd_adapter_ref(adapter);
 
 	servers = g_slist_append(servers, server);
 
@@ -2341,11 +2338,11 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	return 0;
 }
 
-void avrcp_unregister(const bdaddr_t *src)
+void avrcp_unregister(struct btd_adapter *adapter)
 {
 	struct avrcp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter);
 	if (!server)
 		return;
 
@@ -2357,7 +2354,8 @@ void avrcp_unregister(const bdaddr_t *src)
 	remove_record_from_server(server->ct_record_id);
 	remove_record_from_server(server->tg_record_id);
 
-	avctp_unregister(&server->src);
+	avctp_unregister(adapter_get_address(server->adapter));
+	btd_adapter_unref(server->adapter);
 	g_free(server);
 
 	if (servers)
@@ -2369,7 +2367,7 @@ void avrcp_unregister(const bdaddr_t *src)
 	}
 }
 
-struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
+struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
 						void *user_data,
 						GDestroyNotify destroy)
@@ -2378,7 +2376,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 	struct avrcp_player *player;
 	GSList *l;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter);
 	if (!server)
 		return NULL;
 
@@ -2448,11 +2446,8 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 	struct avrcp *session;
 	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
 	struct avrcp_header *pdu = (void *) buf;
-	const bdaddr_t *src;
-
-	src = adapter_get_address(device_get_adapter(dev->btd_dev));
 
-	server = find_server(servers, src);
+	server = find_server(servers, device_get_adapter(dev->btd_dev));
 	if (server == NULL)
 		return -EINVAL;
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index e607fb1..b2c0d61 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -92,14 +92,14 @@ struct avrcp_player_cb {
 							void *user_data);
 };
 
-int avrcp_register(const bdaddr_t *src, GKeyFile *config);
-void avrcp_unregister(const bdaddr_t *src);
+int avrcp_register(struct btd_adapter *adapter, GKeyFile *config);
+void avrcp_unregister(struct btd_adapter *adapter);
 
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
 int avrcp_set_volume(struct audio_device *dev, uint8_t volume);
 
-struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
+struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
 						void *user_data,
 						GDestroyNotify destroy);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index d4c52a6..b2e4841 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -384,7 +384,7 @@ static int avrcp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	err = avrcp_register(adapter_get_address(adapter), config);
+	err = avrcp_register(adapter, config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -403,7 +403,7 @@ static void avrcp_server_remove(struct btd_profile *p,
 	if (!adp)
 		return;
 
-	avrcp_unregister(adapter_get_address(adapter));
+	avrcp_unregister(adapter);
 	audio_adapter_unref(adp);
 }
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 905538e..37eb809 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1441,9 +1441,8 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						"TrackChanged",
 						track_changed,
 						mp, NULL);
-	mp->player = avrcp_register_player(adapter_get_address(adapter->btd_adapter),
-							&player_cb, mp,
-							media_player_free);
+	mp->player = avrcp_register_player(adapter->btd_adapter, &player_cb,
+							mp, media_player_free);
 	if (!mp->player) {
 		if (err)
 			*err = -EPROTONOSUPPORT;
-- 
1.8.0

