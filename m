Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/8] attrib-server: Add bluetooth adapter in attrib_create_sdp function
Date: Wed, 28 Dec 2011 11:24:49 +0100
Message-Id: <1325067890-6953-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-7-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
 <1325067890-6953-2-git-send-email-sancane@gmail.com>
 <1325067890-6953-3-git-send-email-sancane@gmail.com>
 <1325067890-6953-4-git-send-email-sancane@gmail.com>
 <1325067890-6953-5-git-send-email-sancane@gmail.com>
 <1325067890-6953-6-git-send-email-sancane@gmail.com>
 <1325067890-6953-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-example.c |    6 ++++--
 src/attrib-server.c    |   13 ++++++-------
 src/attrib-server.h    |    3 ++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 332c190..ae9d41d 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -231,7 +231,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	g_assert(h - start_handle == svc_size);
 
 	/* Add an SDP record for the above service */
-	sdp_handle = attrib_create_sdp(start_handle, "Thermometer");
+	sdp_handle = attrib_create_sdp(adapter->adapter, start_handle,
+								"Thermometer");
 	if (sdp_handle)
 		adapter->sdp_handles = g_slist_prepend(adapter->sdp_handles,
 						GUINT_TO_POINTER(sdp_handle));
@@ -496,7 +497,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 	g_assert(h - start_handle == svc_size);
 
 	/* Add an SDP record for the above service */
-	sdp_handle = attrib_create_sdp(start_handle, "Weight Service");
+	sdp_handle = attrib_create_sdp(adapter->adapter, start_handle,
+							"Weight Service");
 	if (sdp_handle)
 		adapter->sdp_handles = g_slist_prepend(adapter->sdp_handles,
 						GUINT_TO_POINTER(sdp_handle));
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 56cd909..1e8129d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1264,17 +1264,16 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 	gatt_server_free(server);
 }
 
-uint32_t attrib_create_sdp(uint16_t handle, const char *name)
+uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
+							const char *name)
 {
-	struct gatt_server *server;
-
-	DBG("Deprecated function!");
+	GSList *l;
 
-	server = get_default_gatt_server();
-	if (server == NULL)
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
 		return 0;
 
-	return attrib_create_sdp_new(server, handle, name);
+	return attrib_create_sdp_new(l->data, handle, name);
 }
 
 void attrib_free_sdp(uint32_t sdp_handle)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index becb3a8..dc08bfb 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -32,7 +32,8 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 int attrib_db_del(struct btd_adapter *adapter, uint16_t handle);
 int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 						const uint8_t *value, int len);
-uint32_t attrib_create_sdp(uint16_t handle, const char *name);
+uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
+							const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
 guint attrib_channel_attach(GAttrib *attrib, gboolean out);
 gboolean attrib_channel_detach(guint id);
-- 
1.7.8.1

