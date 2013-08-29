Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] sdp: Make sdp_record_add to be handled by adapter
Date: Thu, 29 Aug 2013 11:56:46 +0200
Message-Id: <1377770207-22688-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1377770207-22688-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sdp_record_add to be called from adapter. First write services to
sdp db then to adapter db without revokes to adapter.

Change-Id: I65d638096c91aadacc3cb5ef7a8a9181fa4dae6e
---
 profiles/audio/a2dp.c      |    2 +-
 profiles/audio/avrcp.c     |    4 ++--
 profiles/health/hdp_util.c |    2 +-
 profiles/network/server.c  |    2 +-
 profiles/sap/server.c      |    2 +-
 src/adapter.c              |   28 ++++++++++++++++++++++++++++
 src/adapter.h              |    3 +++
 src/attrib-server.c        |    2 +-
 src/profile.c              |    7 +++----
 src/sdpd-database.c        |   10 ----------
 10 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3f3cc1b..4b8d4f3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1298,7 +1298,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 		return NULL;
 	}
 
-	if (add_record_to_server(adapter_get_address(server->adapter),
+	if (adapter_add_record_to_server_adapter(server->adapter,
 								record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9f164e4..d64f228 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3829,7 +3829,7 @@ done:
 		return -1;
 	}
 
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+	if (adapter_add_record_to_server_adapter(adapter, record) < 0) {
 		error("Unable to register AVRCP target service record");
 		avrcp_target_server_remove(p, adapter);
 		sdp_record_free(record);
@@ -3912,7 +3912,7 @@ done:
 		return -1;
 	}
 
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+	if (adapter_add_record_to_server_adapter(adapter, record) < 0) {
 		error("Unable to register AVRCP service record");
 		avrcp_controller_server_remove(p, adapter);
 		sdp_record_free(record);
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index b53f1db..7692ca2 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -733,7 +733,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	if (sdp_set_record_state(sdp_record, adapter->record_state++) < 0)
 		goto fail;
 
-	if (add_record_to_server(adapter_get_address(adapter->btd_adapter),
+	if (adapter_add_record_to_server_adapter(adapter->btd_adapter,
 					sdp_record) < 0)
 		goto fail;
 	adapter->sdp_handler = sdp_record->handle;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index de48bec..d321998 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -587,7 +587,7 @@ static uint32_t register_server_record(struct network_server *ns)
 		return 0;
 	}
 
-	if (add_record_to_server(&ns->src, record) < 0) {
+	if (adapter_add_record_to_server_bdaddr(&ns->src, record) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(record);
 		return 0;
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index dfcf0f1..d1e2581 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1358,7 +1358,7 @@ int sap_server_register(const char *path, const bdaddr_t *src)
 		goto sdp_err;
 	}
 
-	if (add_record_to_server(src, record) < 0) {
+	if (adapter_add_record_to_server_bdaddr(src, record) < 0) {
 		error("Adding SAP SDP record to the SDP server failed.");
 		sdp_record_free(record);
 		goto sdp_err;
diff --git a/src/adapter.c b/src/adapter.c
index ba7be8a..6478ca7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6308,6 +6308,34 @@ void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags)
 		adapter_foreach(adapter_service_insert, services->data);
 }
 
+int adapter_add_record_to_server_adapter(struct btd_adapter *adapter, sdp_record_t *rec)
+{
+	return adapter_add_record_to_server_bdaddr(adapter_get_address(adapter), rec);
+}
+
+int adapter_add_record_to_server_bdaddr(const bdaddr_t *device, sdp_record_t *rec)
+{
+	int error;
+	struct btd_adapter *adapter;
+
+	error = add_record_to_server(device, rec);
+
+	/* Check if add_record_to server error occurs */
+	if (!error) {
+		/* Add rec for each adapter */
+		if (bacmp(device, BDADDR_ANY) == 0) {
+			adapter_foreach(adapter_service_insert, rec);
+			return error;
+		}
+		/*  Add rec for single adapter */
+		adapter = adapter_find(device);
+		if (adapter)
+			adapter_service_insert(adapter, rec);
+	}
+
+	return error;
+}
+
 void adapter_sdp_init_services_list(bdaddr_t *device)
 {
 	sdp_list_t *p;
diff --git a/src/adapter.h b/src/adapter.h
index bd54372..8a5fc73 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -214,4 +214,7 @@ gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter);
 void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void (*cb)(struct btd_device *device, void *data),
 			void *data);
+
+int adapter_add_record_to_server_adapter(struct btd_adapter *adapter, sdp_record_t *rec);
+int adapter_add_record_to_server_bdaddr(const bdaddr_t *device, sdp_record_t *rec);
 void adapter_sdp_init_services_list(bdaddr_t *device);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3f629b0..19b878d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -326,7 +326,7 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 				"http://www.bluez.org/");
 	}
 
-	if (add_record_to_server(adapter_get_address(server->adapter), record)
+	if (adapter_add_record_to_server_adapter(server->adapter, record)
 			== 0)
 		return record->handle;
 
diff --git a/src/profile.c b/src/profile.c
index 90c3535..9a1687d 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1197,7 +1197,7 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 static uint32_t ext_register_record(struct ext_profile *ext,
 							struct ext_io *l2cap,
 							struct ext_io *rfcomm,
-							const bdaddr_t *src)
+							struct btd_adapter *adapter)
 {
 	sdp_record_t *rec;
 	char *dyn_record = NULL;
@@ -1220,7 +1220,7 @@ static uint32_t ext_register_record(struct ext_profile *ext,
 		return 0;
 	}
 
-	if (add_record_to_server(src, rec) < 0) {
+	if (adapter_add_record_to_server_adapter(adapter, rec) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(rec);
 		return 0;
@@ -1322,8 +1322,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 		}
 	}
 
-	return ext_register_record(ext, l2cap, rfcomm,
-						adapter_get_address(adapter));
+	return ext_register_record(ext, l2cap, rfcomm, adapter);
 
 failed:
 	if (l2cap) {
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 7228cd7..335ea0e 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -168,7 +168,6 @@ void sdp_svcdb_set_collectable(sdp_record_t *record, int sock)
  */
 void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec)
 {
-	struct btd_adapter *adapter;
 	sdp_access_t *dev;
 
 	SDPDBG("Adding rec : 0x%lx", (long) rec);
@@ -184,15 +183,6 @@ void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec)
 	dev->handle = rec->handle;
 
 	access_db = sdp_list_insert_sorted(access_db, dev, access_sort);
-
-	if (bacmp(device, BDADDR_ANY) == 0) {
-		adapter_foreach(adapter_service_insert, rec);
-		return;
-	}
-
-	adapter = adapter_find(device);
-	if (adapter)
-		adapter_service_insert(adapter, rec);
 }
 
 static sdp_list_t *record_locate(uint32_t handle)
-- 
1.7.9.5

