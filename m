Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/8] adapter: Handle removing of SDP records
Date: Thu, 19 Sep 2013 16:00:43 +0200
Message-ID: <1379599248-7923-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make adapter in charge of updating SDP database. This allow to decouple
SDP of code used for notifying adapters about SDP database change.
---
 plugins/gatt-example.c     |  2 +-
 profiles/audio/a2dp.c      | 11 +++++++----
 profiles/audio/avrcp.c     |  4 ++--
 profiles/health/hdp.c      |  2 +-
 profiles/health/hdp_util.c |  3 ++-
 profiles/network/server.c  |  4 ++--
 profiles/sap/server.c      |  2 +-
 src/adapter.c              | 13 ++++++++-----
 src/adapter.h              |  2 +-
 src/attrib-server.c        |  9 +++++----
 src/attrib-server.h        |  2 +-
 src/profile.c              |  2 +-
 src/sdpd-database.c        |  8 --------
 13 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index b926947..9b4187a 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -72,7 +72,7 @@ static void gatt_example_adapter_free(struct gatt_example_adapter *gadapter)
 	while (gadapter->sdp_handles != NULL) {
 		uint32_t handle = GPOINTER_TO_UINT(gadapter->sdp_handles->data);
 
-		attrib_free_sdp(handle);
+		attrib_free_sdp(gadapter->adapter, handle);
 		gadapter->sdp_handles = g_slist_remove(gadapter->sdp_handles,
 						gadapter->sdp_handles->data);
 	}
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d96a8b5..8477b5d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1326,7 +1326,8 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 			return;
 		server->sources = g_slist_remove(server->sources, sep);
 		if (server->sources == NULL && server->source_record_id) {
-			remove_record_from_server(server->source_record_id);
+			adapter_service_remove(server->adapter,
+						server->source_record_id);
 			server->source_record_id = 0;
 		}
 	} else {
@@ -1334,7 +1335,8 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 			return;
 		server->sinks = g_slist_remove(server->sinks, sep);
 		if (server->sinks == NULL && server->sink_record_id) {
-			remove_record_from_server(server->sink_record_id);
+			adapter_service_remove(server->adapter,
+						server->sink_record_id);
 			server->sink_record_id = 0;
 		}
 	}
@@ -1943,7 +1945,8 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 					(GDestroyNotify) a2dp_unregister_sep);
 
 	if (server->source_record_id) {
-		remove_record_from_server(server->source_record_id);
+		adapter_service_remove(server->adapter,
+					server->source_record_id);
 		server->source_record_id = 0;
 	}
 
@@ -1988,7 +1991,7 @@ static void a2dp_sink_server_remove(struct btd_profile *p,
 	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
 
 	if (server->sink_record_id) {
-		remove_record_from_server(server->sink_record_id);
+		adapter_service_remove(server->adapter, server->sink_record_id);
 		server->sink_record_id = 0;
 	}
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e75e804..b1b2ae6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3797,7 +3797,7 @@ static void avrcp_target_server_remove(struct btd_profile *p,
 		return;
 
 	if (server->tg_record_id != 0) {
-		remove_record_from_server(server->tg_record_id);
+		adapter_service_remove(adapter, server->tg_record_id);
 		server->tg_record_id = 0;
 	}
 
@@ -3880,7 +3880,7 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
 		return;
 
 	if (server->ct_record_id != 0) {
-		remove_record_from_server(server->ct_record_id);
+		adapter_service_remove(adapter, server->ct_record_id);
 		server->ct_record_id = 0;
 	}
 
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 7f24756..7b4e799 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1403,7 +1403,7 @@ void hdp_adapter_unregister(struct btd_adapter *adapter)
 	hdp_adapter = l->data;
 	adapters = g_slist_remove(adapters, hdp_adapter);
 	if (hdp_adapter->sdp_handler > 0)
-		remove_record_from_server(hdp_adapter->sdp_handler);
+		adapter_service_remove(adapter, hdp_adapter->sdp_handler);
 	release_adapter_instance(hdp_adapter);
 	btd_adapter_unref(hdp_adapter->btd_adapter);
 	g_free(hdp_adapter);
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 7748a90..34e4671 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -693,7 +693,8 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	sdp_record_t *sdp_record;
 
 	if (adapter->sdp_handler > 0)
-		remove_record_from_server(adapter->sdp_handler);
+		adapter_service_remove(adapter->btd_adapter,
+					adapter->sdp_handler);
 
 	if (app_list == NULL) {
 		adapter->sdp_handler = 0;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index d537531..7b784e5 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -628,7 +628,7 @@ static void server_disconnect(DBusConnection *conn, void *user_data)
 	ns->watch_id = 0;
 
 	if (ns->record_id) {
-		remove_record_from_server(ns->record_id);
+		adapter_service_remove(ns->na->adapter, ns->record_id);
 		ns->record_id = 0;
 	}
 
@@ -722,7 +722,7 @@ static void server_free(void *data)
 	server_remove_sessions(ns);
 
 	if (ns->record_id)
-		remove_record_from_server(ns->record_id);
+		adapter_service_remove(ns->na->adapter, ns->record_id);
 
 	g_dbus_remove_watch(btd_get_dbus_connection(), ns->watch_id);
 	g_free(ns->name);
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 089bc7a..63314a7 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1320,7 +1320,7 @@ static void server_remove(struct sap_server *server)
 
 	sap_server_remove_conn(server);
 
-	remove_record_from_server(server->record_id);
+	adapter_service_remove(server->adapter, server->record_id);
 
 	if (server->listen_io) {
 		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
diff --git a/src/adapter.c b/src/adapter.c
index 678bc5d..fb005a6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -986,18 +986,21 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 	return 0;
 }
 
-void adapter_service_remove(struct btd_adapter *adapter, void *r)
+void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle)
 {
-	sdp_record_t *rec = r;
+	sdp_record_t *rec = sdp_record_find(handle);
 
 	DBG("%s", adapter->path);
 
+	if (!rec)
+		return;
+
 	adapter->services = sdp_list_remove(adapter->services, rec);
 
-	if (sdp_list_find(adapter->services, &rec->svclass, uuid_cmp))
-		return;
+	if (sdp_list_find(adapter->services, &rec->svclass, uuid_cmp) == NULL)
+		remove_uuid(adapter, &rec->svclass);
 
-	remove_uuid(adapter, &rec->svclass);
+	remove_record_from_server(rec->handle);
 }
 
 static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
diff --git a/src/adapter.h b/src/adapter.h
index ef6d4ed..5d124e7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -104,7 +104,7 @@ const bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
-void adapter_service_remove(struct btd_adapter *adapter, void *rec);
+void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5a76d2e..2861a00 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -139,10 +139,11 @@ static void gatt_server_free(struct gatt_server *server)
 	g_slist_free_full(server->clients, (GDestroyNotify) channel_free);
 
 	if (server->gatt_sdp_handle > 0)
-		remove_record_from_server(server->gatt_sdp_handle);
+		adapter_service_remove(server->adapter,
+					server->gatt_sdp_handle);
 
 	if (server->gap_sdp_handle > 0)
-		remove_record_from_server(server->gap_sdp_handle);
+		adapter_service_remove(server->adapter, server->gap_sdp_handle);
 
 	if (server->adapter != NULL)
 		btd_adapter_unref(server->adapter);
@@ -1377,9 +1378,9 @@ uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 	return attrib_create_sdp_new(l->data, handle, name);
 }
 
-void attrib_free_sdp(uint32_t sdp_handle)
+void attrib_free_sdp(struct btd_adapter *adapter, uint32_t sdp_handle)
 {
-	remove_record_from_server(sdp_handle);
+	adapter_service_remove(adapter, sdp_handle);
 }
 
 static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 2148017..90ba17c 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -36,6 +36,6 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 					const uint8_t *value, size_t len);
 uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
-void attrib_free_sdp(uint32_t sdp_handle);
+void attrib_free_sdp(struct btd_adapter *adapter, uint32_t sdp_handle);
 guint attrib_channel_attach(GAttrib *attrib);
 gboolean attrib_channel_detach(GAttrib *attrib, guint id);
diff --git a/src/profile.c b/src/profile.c
index f2c1e6f..accd007 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1371,7 +1371,7 @@ static void ext_remove_records(struct ext_profile *ext,
 
 		ext->records = g_slist_remove(ext->records, r);
 
-		remove_record_from_server(r->handle);
+		adapter_service_remove(adapter, r->handle);
 		btd_adapter_unref(r->adapter);
 		g_free(r);
 	}
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 600ddbf..e4d4f98 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -36,7 +36,6 @@
 
 #include "sdpd.h"
 #include "log.h"
-#include "adapter.h"
 
 static sdp_list_t *service_db;
 static sdp_list_t *access_db;
@@ -254,13 +253,6 @@ int sdp_record_remove(uint32_t handle)
 
 	a = p->data;
 
-	if (bacmp(&a->device, BDADDR_ANY) != 0) {
-		struct btd_adapter *adapter = adapter_find(&a->device);
-		if (adapter)
-			adapter_service_remove(adapter, r);
-	} else
-		adapter_foreach(adapter_service_remove, r);
-
 	access_db = sdp_list_remove(access_db, a);
 	access_free(a);
 
-- 
1.8.4

