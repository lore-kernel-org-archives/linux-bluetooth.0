Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] sdp: Make sdp_record_remove to be handled by adapter
Date: Thu, 29 Aug 2013 11:56:47 +0200
Message-Id: <1377770207-22688-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sdp_record_remove to be called from adapter. First remove service
from sdp db then from adapter db without revokes to adapter.

Change-Id: I13a3113909bab2b4494a00ef05e25dc8d113e3ac
---
 profiles/audio/a2dp.c      |    8 ++++----
 profiles/audio/avrcp.c     |    4 ++--
 profiles/health/hdp.c      |    2 +-
 profiles/health/hdp_util.c |    2 +-
 profiles/network/server.c  |    4 ++--
 profiles/sap/server.c      |    2 +-
 src/adapter.c              |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h              |    2 ++
 src/attrib-server.c        |    6 +++---
 src/profile.c              |    2 +-
 src/sdpd-database.c        |   12 ------------
 src/sdpd.h                 |    5 +++++
 12 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4b8d4f3..364383b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1327,7 +1327,7 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 			return;
 		server->sources = g_slist_remove(server->sources, sep);
 		if (server->sources == NULL && server->source_record_id) {
-			remove_record_from_server(server->source_record_id);
+			adapter_remove_record_from_server(server->source_record_id);
 			server->source_record_id = 0;
 		}
 	} else {
@@ -1335,7 +1335,7 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 			return;
 		server->sinks = g_slist_remove(server->sinks, sep);
 		if (server->sinks == NULL && server->sink_record_id) {
-			remove_record_from_server(server->sink_record_id);
+			adapter_remove_record_from_server(server->sink_record_id);
 			server->sink_record_id = 0;
 		}
 	}
@@ -1944,7 +1944,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 					(GDestroyNotify) a2dp_unregister_sep);
 
 	if (server->source_record_id) {
-		remove_record_from_server(server->source_record_id);
+		adapter_remove_record_from_server(server->source_record_id);
 		server->source_record_id = 0;
 	}
 
@@ -1989,7 +1989,7 @@ static void a2dp_sink_server_remove(struct btd_profile *p,
 	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
 
 	if (server->sink_record_id) {
-		remove_record_from_server(server->sink_record_id);
+		adapter_remove_record_from_server(server->sink_record_id);
 		server->sink_record_id = 0;
 	}
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d64f228..da8d06a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3797,7 +3797,7 @@ static void avrcp_target_server_remove(struct btd_profile *p,
 		return;
 
 	if (server->tg_record_id != 0) {
-		remove_record_from_server(server->tg_record_id);
+		adapter_remove_record_from_server(server->tg_record_id);
 		server->tg_record_id = 0;
 	}
 
@@ -3880,7 +3880,7 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
 		return;
 
 	if (server->ct_record_id != 0) {
-		remove_record_from_server(server->ct_record_id);
+		adapter_remove_record_from_server(server->ct_record_id);
 		server->ct_record_id = 0;
 	}
 
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 7f24756..eeac102 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1403,7 +1403,7 @@ void hdp_adapter_unregister(struct btd_adapter *adapter)
 	hdp_adapter = l->data;
 	adapters = g_slist_remove(adapters, hdp_adapter);
 	if (hdp_adapter->sdp_handler > 0)
-		remove_record_from_server(hdp_adapter->sdp_handler);
+		adapter_remove_record_from_server(hdp_adapter->sdp_handler);
 	release_adapter_instance(hdp_adapter);
 	btd_adapter_unref(hdp_adapter->btd_adapter);
 	g_free(hdp_adapter);
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 7692ca2..55f1fb9 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -693,7 +693,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	sdp_record_t *sdp_record;
 
 	if (adapter->sdp_handler > 0)
-		remove_record_from_server(adapter->sdp_handler);
+		adapter_remove_record_from_server(adapter->sdp_handler);
 
 	if (app_list == NULL) {
 		adapter->sdp_handler = 0;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index d321998..6e36818 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -628,7 +628,7 @@ static void server_disconnect(DBusConnection *conn, void *user_data)
 	ns->watch_id = 0;
 
 	if (ns->record_id) {
-		remove_record_from_server(ns->record_id);
+		adapter_remove_record_from_server(ns->record_id);
 		ns->record_id = 0;
 	}
 
@@ -722,7 +722,7 @@ static void server_free(void *data)
 	server_remove_sessions(ns);
 
 	if (ns->record_id)
-		remove_record_from_server(ns->record_id);
+		adapter_remove_record_from_server(ns->record_id);
 
 	g_free(ns->name);
 	g_free(ns->bridge);
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index d1e2581..c837668 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1318,7 +1318,7 @@ static void server_remove(struct sap_server *server)
 
 	sap_server_remove_conn(server);
 
-	remove_record_from_server(server->record_id);
+	adapter_remove_record_from_server(server->record_id);
 
 	if (server->listen_io) {
 		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
diff --git a/src/adapter.c b/src/adapter.c
index 6478ca7..57ae6b3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6336,6 +6336,48 @@ int adapter_add_record_to_server_bdaddr(const bdaddr_t *device, sdp_record_t *re
 	return error;
 }
 
+int adapter_remove_record_from_server(uint32_t handle)
+{
+	int error;
+	sdp_list_t *p;
+	sdp_record_t *r;
+	sdp_access_t *a;
+	sdp_record_t rh, ah;
+
+	error = remove_record_from_server(handle);
+
+	/* if no errors for removing records from sdp server */
+	if (!error) {
+		/* record locate */
+		rh.handle = handle;
+		p = sdp_list_find(sdp_get_record_list(), &rh, record_sort);
+
+		r = p->data;
+
+		/* device locate */
+		ah.handle = handle;
+		p = sdp_list_find(sdp_get_access_list(), &ah, record_sort);
+
+		if (p == NULL || p->data == NULL)
+			return 0;
+
+		a = p->data;
+
+		/* remove services from adapter/s */
+		if (bacmp(&a->device, BDADDR_ANY) != 0) {
+			struct btd_adapter *adapter = adapter_find(&a->device);
+			if (adapter)
+				adapter_service_remove(adapter, r);
+		} else
+			adapter_foreach(adapter_service_remove, r);
+
+		free(a);
+	}
+
+	/* return 0 if no error */
+	return error;
+}
+
 void adapter_sdp_init_services_list(bdaddr_t *device)
 {
 	sdp_list_t *p;
diff --git a/src/adapter.h b/src/adapter.h
index 8a5fc73..a56e8f7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -217,4 +217,6 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 
 int adapter_add_record_to_server_adapter(struct btd_adapter *adapter, sdp_record_t *rec);
 int adapter_add_record_to_server_bdaddr(const bdaddr_t *device, sdp_record_t *rec);
+int adapter_remove_record_from_server(uint32_t handle);
+
 void adapter_sdp_init_services_list(bdaddr_t *device);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 19b878d..65952d3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -139,10 +139,10 @@ static void gatt_server_free(struct gatt_server *server)
 	g_slist_free_full(server->clients, (GDestroyNotify) channel_free);
 
 	if (server->gatt_sdp_handle > 0)
-		remove_record_from_server(server->gatt_sdp_handle);
+		adapter_remove_record_from_server(server->gatt_sdp_handle);
 
 	if (server->gap_sdp_handle > 0)
-		remove_record_from_server(server->gap_sdp_handle);
+		adapter_remove_record_from_server(server->gap_sdp_handle);
 
 	if (server->adapter != NULL)
 		btd_adapter_unref(server->adapter);
@@ -1380,7 +1380,7 @@ uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 
 void attrib_free_sdp(uint32_t sdp_handle)
 {
-	remove_record_from_server(sdp_handle);
+	adapter_remove_record_from_server(sdp_handle);
 }
 
 static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
diff --git a/src/profile.c b/src/profile.c
index 9a1687d..08ce410 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1389,7 +1389,7 @@ static void ext_remove_records(struct ext_profile *ext,
 
 		ext->records = g_slist_remove(ext->records, r);
 
-		remove_record_from_server(r->handle);
+		adapter_remove_record_from_server(r->handle);
 		btd_adapter_unref(r->adapter);
 		g_free(r);
 	}
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 335ea0e..0bfb118 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -41,11 +41,6 @@
 static sdp_list_t *service_db;
 static sdp_list_t *access_db;
 
-typedef struct {
-	uint32_t handle;
-	bdaddr_t device;
-} sdp_access_t;
-
 /*
  * Ordering function called when inserting a service record.
  * The service repository is a linked list in sorted order
@@ -254,13 +249,6 @@ int sdp_record_remove(uint32_t handle)
 
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
 
diff --git a/src/sdpd.h b/src/sdpd.h
index ad384bd..769dc63 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -45,6 +45,11 @@ typedef struct request {
 	int      len;
 } sdp_req_t;
 
+typedef struct {
+	uint32_t handle;
+	bdaddr_t device;
+} sdp_access_t;
+
 void handle_internal_request(int sk, int mtu, void *data, int len);
 void handle_request(int sk, uint8_t *data, int len);
 
-- 
1.7.9.5

