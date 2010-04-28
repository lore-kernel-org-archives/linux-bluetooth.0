Return-Path: <cyrus@holtmann.org>
From: Elvis Pfutzenreuter <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Update service class on adapter-by-adapter basis
Date: Wed, 28 Apr 2010 14:46:38 -0300
Message-Id: <1272476798-10161-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a service is added (or removed) for a specific adapter,
only the service class of that specific adapter shall be updated.
---
 src/adapter.c      |    5 +++++
 src/adapter.h      |    2 ++
 src/manager.c      |   16 ++--------------
 src/manager.h      |    2 +-
 src/sdpd-service.c |   26 ++++++++++++++++----------
 src/sdpd.h         |    1 -
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b87f7d7..dd79877 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1104,6 +1104,11 @@ void adapter_service_remove(const bdaddr_t *bdaddr, void *rec)
 	adapter_service_ins_rem(bdaddr, rec, FALSE);
 }
 
+sdp_list_t *adapter_service_list(struct btd_adapter *adapter)
+{
+	return adapter->services;
+}
+
 struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address)
diff --git a/src/adapter.h b/src/adapter.h
index e4307d8..1598dea 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -23,6 +23,7 @@
  */
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
 #include <dbus/dbus.h>
 #include <glib.h>
 
@@ -123,6 +124,7 @@ void adapter_update_tx_power(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_service_insert(const bdaddr_t *bdaddr, void *rec);
 void adapter_service_remove(const bdaddr_t *bdaddr, void *rec);
+sdp_list_t *adapter_service_list(struct btd_adapter *adapter);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
diff --git a/src/manager.c b/src/manager.c
index da7b91f..0c75ff7 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -61,21 +61,9 @@ const char *manager_get_base_path(void)
 	return base_path;
 }
 
-void manager_update_svc(const bdaddr_t *bdaddr, uint8_t svc)
+void manager_update_svc(struct btd_adapter* adapter, uint8_t svc)
 {
-	GSList *l;
-	bdaddr_t src;
-
-	for (l = adapters; l != NULL; l = l->next) {
-		struct btd_adapter *adapter = l->data;
-
-		adapter_get_address(adapter, &src);
-
-		if (bacmp(bdaddr, BDADDR_ANY) != 0 && bacmp(bdaddr, &src) != 0)
-			continue;
-
-		adapter_update(adapter, svc);
-	}
+	adapter_update(adapter, svc);
 }
 
 static inline DBusMessage *invalid_args(DBusMessage *msg)
diff --git a/src/manager.h b/src/manager.h
index 55d316f..6bf3e76 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -43,5 +43,5 @@ int manager_stop_adapter(int id);
 void manager_add_adapter(const char *path);
 int manager_get_default_adapter();
 void manager_set_default_adapter(int id);
-void manager_update_svc(const bdaddr_t *bdaddr, uint8_t svc);
+void manager_update_svc(struct btd_adapter *adapter, uint8_t svc);
 void btd_manager_set_offline(gboolean offline);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 4551577..23f7989 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -47,11 +47,10 @@
 #include "sdpd.h"
 #include "logging.h"
 #include "manager.h"
+#include "adapter.h"
 
 static sdp_record_t *server = NULL;
 
-static uint8_t service_classes = 0x00;
-
 static uint16_t did_vendor = 0x0000;
 static uint16_t did_product = 0x0000;
 static uint16_t did_version = 0x0000;
@@ -98,9 +97,9 @@ static void update_db_timestamp(void)
 	sdp_attr_replace(server, SDP_ATTR_SVCDB_STATE, d);
 }
 
-static void update_svclass_list(const bdaddr_t *src)
+static void update_adapter_svclass_list(struct btd_adapter *adapter)
 {
-	sdp_list_t *list = sdp_get_record_list();
+	sdp_list_t *list = adapter_service_list(adapter);
 	uint8_t val = 0;
 
 	for (; list; list = list->next) {
@@ -156,14 +155,21 @@ static void update_svclass_list(const bdaddr_t *src)
 
 	SDPDBG("Service classes 0x%02x", val);
 
-	service_classes = val;
-
-	manager_update_svc(src, val);
+	manager_update_svc(adapter, val);
 }
 
-uint8_t get_service_classes(const bdaddr_t *bdaddr)
+static void update_svclass_list(const bdaddr_t *src)
 {
-	return service_classes;
+	bdaddr_t bdaddr;
+	GSList *adapters = manager_get_adapters();
+
+	for (; adapters; adapters = adapters->next) {
+		adapter_get_address(adapters->data, &bdaddr);
+
+		if (bacmp(src, BDADDR_ANY) == 0 || bacmp(src, &bdaddr) == 0)
+			update_adapter_svclass_list(adapters->data);
+	}
+
 }
 
 void create_ext_inquiry_response(const char *name,
@@ -613,7 +619,7 @@ success:
 	}
 
 	update_db_timestamp();
-	update_svclass_list(BDADDR_ANY);
+	update_svclass_list(&req->device);
 
 	/* Build a rsp buffer */
 	bt_put_unaligned(htonl(rec->handle), (uint32_t *) rsp->data);
diff --git a/src/sdpd.h b/src/sdpd.h
index ce189ca..e93b0b6 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -94,7 +94,6 @@ void stop_sdp_server(void);
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
 int remove_record_from_server(uint32_t handle);
 
-uint8_t get_service_classes(const bdaddr_t *bdaddr);
 void create_ext_inquiry_response(const char *name,
 					int8_t tx_power, sdp_list_t *services,
 					uint8_t *data);
-- 
1.6.3.3

