Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/8] adapter: Handle adding new SDP records
Date: Thu, 19 Sep 2013 16:00:42 +0200
Message-ID: <1379599248-7923-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make adapter in charge of updating SDP database. This allow to decouple
SDP of code used for notifying adapters about SDP database change.
---
 profiles/audio/a2dp.c      |  3 +--
 profiles/audio/avrcp.c     |  4 ++--
 profiles/health/hdp_util.c |  3 +--
 profiles/network/server.c  |  2 +-
 profiles/sap/server.c      |  2 +-
 src/adapter.c              | 22 +++++++++++++++++++---
 src/adapter.h              |  3 ++-
 src/attrib-server.c        |  3 +--
 src/profile.c              |  7 +++----
 src/sdpd-database.c        | 12 ------------
 10 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3f3cc1b..d96a8b5 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1298,8 +1298,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 		return NULL;
 	}
 
-	if (add_record_to_server(adapter_get_address(server->adapter),
-								record) < 0) {
+	if (adapter_service_add(server->adapter, record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
 		avdtp_unregister_sep(sep->lsep);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9f164e4..e75e804 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3829,7 +3829,7 @@ done:
 		return -1;
 	}
 
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+	if (adapter_service_add(adapter, record) < 0) {
 		error("Unable to register AVRCP target service record");
 		avrcp_target_server_remove(p, adapter);
 		sdp_record_free(record);
@@ -3912,7 +3912,7 @@ done:
 		return -1;
 	}
 
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+	if (adapter_service_add(adapter, record) < 0) {
 		error("Unable to register AVRCP service record");
 		avrcp_controller_server_remove(p, adapter);
 		sdp_record_free(record);
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index b53f1db..7748a90 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -733,8 +733,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	if (sdp_set_record_state(sdp_record, adapter->record_state++) < 0)
 		goto fail;
 
-	if (add_record_to_server(adapter_get_address(adapter->btd_adapter),
-					sdp_record) < 0)
+	if (adapter_service_add(adapter->btd_adapter, sdp_record) < 0)
 		goto fail;
 	adapter->sdp_handler = sdp_record->handle;
 	return TRUE;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 043e1fc..d537531 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -587,7 +587,7 @@ static uint32_t register_server_record(struct network_server *ns)
 		return 0;
 	}
 
-	if (add_record_to_server(&ns->src, record) < 0) {
+	if (adapter_service_add(ns->na->adapter, record) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(record);
 		return 0;
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 1aacfe9..089bc7a 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1360,7 +1360,7 @@ int sap_server_register(struct btd_adapter *adapter)
 		goto sdp_err;
 	}
 
-	if (add_record_to_server(adapter_get_address(adapter), record) < 0) {
+	if (adapter_service_add(adapter, record) < 0) {
 		error("Adding SAP SDP record to the SDP server failed.");
 		sdp_record_free(record);
 		goto sdp_err;
diff --git a/src/adapter.c b/src/adapter.c
index 62783a6..678bc5d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -934,9 +934,8 @@ static int uuid_cmp(const void *a, const void *b)
 	return sdp_uuid_cmp(&rec->svclass, uuid);
 }
 
-void adapter_service_insert(struct btd_adapter *adapter, void *r)
+static void adapter_service_insert(struct btd_adapter *adapter, sdp_record_t *rec)
 {
-	sdp_record_t *rec = r;
 	sdp_list_t *browse_list = NULL;
 	uuid_t browse_uuid;
 	gboolean new_uuid;
@@ -944,8 +943,10 @@ void adapter_service_insert(struct btd_adapter *adapter, void *r)
 	DBG("%s", adapter->path);
 
 	/* skip record without a browse group */
-	if (sdp_get_browse_groups(rec, &browse_list) < 0)
+	if (sdp_get_browse_groups(rec, &browse_list) < 0) {
+		DBG("skipping record without browse group");
 		return;
+	}
 
 	sdp_uuid16_create(&browse_uuid, PUBLIC_BROWSE_GROUP);
 
@@ -970,6 +971,21 @@ done:
 	sdp_list_free(browse_list, free);
 }
 
+int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
+{
+	int ret;
+
+	DBG("%s", adapter->path);
+
+	ret = add_record_to_server(&adapter->bdaddr, rec);
+	if (ret < 0)
+		return ret;
+
+	adapter_service_insert(adapter, rec);
+
+	return 0;
+}
+
 void adapter_service_remove(struct btd_adapter *adapter, void *r)
 {
 	sdp_record_t *rec = r;
diff --git a/src/adapter.h b/src/adapter.h
index 32b12c0..ef6d4ed 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -102,7 +102,8 @@ struct btd_device *adapter_find_device(struct btd_adapter *adapter,
 const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
-void adapter_service_insert(struct btd_adapter *adapter, void *rec);
+
+int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
 void adapter_service_remove(struct btd_adapter *adapter, void *rec);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3f629b0..5a76d2e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -326,8 +326,7 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 				"http://www.bluez.org/");
 	}
 
-	if (add_record_to_server(adapter_get_address(server->adapter), record)
-			== 0)
+	if (adapter_service_add(server->adapter, record) == 0)
 		return record->handle;
 
 	sdp_record_free(record);
diff --git a/src/profile.c b/src/profile.c
index 523e119..f2c1e6f 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1179,7 +1179,7 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 static uint32_t ext_register_record(struct ext_profile *ext,
 							struct ext_io *l2cap,
 							struct ext_io *rfcomm,
-							const bdaddr_t *src)
+							struct btd_adapter *a)
 {
 	sdp_record_t *rec;
 	char *dyn_record = NULL;
@@ -1202,7 +1202,7 @@ static uint32_t ext_register_record(struct ext_profile *ext,
 		return 0;
 	}
 
-	if (add_record_to_server(src, rec) < 0) {
+	if (adapter_service_add(a, rec) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(rec);
 		return 0;
@@ -1304,8 +1304,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 		}
 	}
 
-	return ext_register_record(ext, l2cap, rfcomm,
-						adapter_get_address(adapter));
+	return ext_register_record(ext, l2cap, rfcomm, adapter);
 
 failed:
 	if (l2cap) {
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index cf33f19..600ddbf 100644
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
@@ -333,7 +323,5 @@ void sdp_init_services_list(bdaddr_t *device)
 			continue;
 
 		SDPDBG("adding record with handle %x", access->handle);
-
-		adapter_foreach(adapter_service_insert, rec);
 	}
 }
-- 
1.8.4

