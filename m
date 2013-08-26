Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] sdp: Move spd_init_services_list to adapter
Date: Mon, 26 Aug 2013 15:07:19 +0200
Message-Id: <1377522441-28671-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sdp_init_services_list to be runned in adapter instead of
sdp-database. sdp_init_service is invoked by adapter_register function.

Change-Id: Iddf5afbe410608ca96df727a7c9bb791e457ca77
---
 src/adapter.c       |   27 ++++++++++++++++++++++++++-
 src/adapter.h       |    2 ++
 src/sdpd-database.c |   31 ++++++++-----------------------
 src/sdpd.h          |    3 +--
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 723e3a8..fd20d61 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5603,7 +5603,7 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
-	sdp_init_services_list(&adapter->bdaddr);
+	adapter_sdp_init_services_list(&adapter->bdaddr);
 
 	btd_adapter_gatt_server_start(adapter);
 
@@ -6306,3 +6306,28 @@ void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags) {
 	for (; services; services = services->next)
 		adapter_foreach(adapter_service_insert, services->data);
 }
+
+void adapter_sdp_init_services_list(bdaddr_t *device)
+{
+	sdp_list_t *p;
+
+	p = sdp_get_access_list();
+
+	DBG("");
+
+	for (; p != NULL; p = p->next) {
+		sdp_access_t *access = p->data;
+		sdp_record_t *rec;
+
+		if (bacmp(BDADDR_ANY, &access->device))
+			continue;
+
+		rec = sdp_record_find(access->handle);
+		if (rec == NULL)
+			continue;
+
+		SDPDBG("adding record with handle %x", access->handle);
+
+		adapter_foreach(adapter_service_insert, rec);
+	}
+}
diff --git a/src/adapter.h b/src/adapter.h
index a60a29f..ad01710 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -214,3 +214,5 @@ gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter);
 void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void (*cb)(struct btd_device *device, void *data),
 			void *data);
+
+void adapter_sdp_init_services_list(bdaddr_t *device);
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index cf33f19..7228cd7 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -285,6 +285,14 @@ sdp_list_t *sdp_get_record_list(void)
 	return service_db;
 }
 
+/*
+ * Return a pointer to the linked list containing the access db in sorted order
+ */
+sdp_list_t *sdp_get_access_list(void)
+{
+	return access_db;
+}
+
 int sdp_check_access(uint32_t handle, bdaddr_t *device)
 {
 	sdp_list_t *p = access_locate(handle);
@@ -314,26 +322,3 @@ uint32_t sdp_next_handle(void)
 
 	return handle;
 }
-
-void sdp_init_services_list(bdaddr_t *device)
-{
-	sdp_list_t *p;
-
-	DBG("");
-
-	for (p = access_db; p != NULL; p = p->next) {
-		sdp_access_t *access = p->data;
-		sdp_record_t *rec;
-
-		if (bacmp(BDADDR_ANY, &access->device))
-			continue;
-
-		rec = sdp_record_find(access->handle);
-		if (rec == NULL)
-			continue;
-
-		SDPDBG("adding record with handle %x", access->handle);
-
-		adapter_foreach(adapter_service_insert, rec);
-	}
-}
diff --git a/src/sdpd.h b/src/sdpd.h
index 9a0e1e9..ad384bd 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -68,6 +68,7 @@ sdp_record_t *sdp_record_find(uint32_t handle);
 void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec);
 int sdp_record_remove(uint32_t handle);
 sdp_list_t *sdp_get_record_list(void);
+sdp_list_t *sdp_get_access_list(void);
 int sdp_check_access(uint32_t handle, bdaddr_t *device);
 uint32_t sdp_next_handle(void);
 
@@ -81,5 +82,3 @@ void stop_sdp_server(void);
 
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
 int remove_record_from_server(uint32_t handle);
-
-void sdp_init_services_list(bdaddr_t *device);
-- 
1.7.9.5

