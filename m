Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Update service class on adapter-by-adapter basis
Date: Wed,  7 Apr 2010 18:34:13 -0300
Message-Id: <1270676053-15699-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Elvis Pfutzenreuter <epx@signove.com>

When a service is added (or removed) for a specific adapter,
only the service class of that specific adapter shall be updated.
---
 src/adapter.c      |   15 +++++++++++++++
 src/adapter.h      |    2 ++
 src/sdpd-service.c |   24 +++++++++++++++---------
 src/sdpd.h         |    1 -
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8fc47b9..1530f83 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1103,6 +1103,21 @@ void adapter_service_remove(const bdaddr_t *bdaddr, void *rec)
 	adapter_service_ins_rem(bdaddr, rec, FALSE);
 }
 
+sdp_list_t *adapter_service_list(const bdaddr_t *bdaddr)
+{
+	struct btd_adapter *adapter;
+	sdp_list_t *list = NULL;
+
+	if (bacmp(bdaddr, BDADDR_ANY) != 0) {
+		/* Only one adapter */
+		adapter = manager_find_adapter(bdaddr);
+		if (adapter)
+			list = adapter->services;
+	}
+
+	return list;
+}
+
 struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address)
diff --git a/src/adapter.h b/src/adapter.h
index e4307d8..5975299 100644
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
+sdp_list_t *adapter_service_list(const bdaddr_t *bdaddr);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 4551577..cddd87e 100644
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
+static void update_adapter_svclass_list(const bdaddr_t *src)
 {
-	sdp_list_t *list = sdp_get_record_list();
+	sdp_list_t *list = adapter_service_list(src);
 	uint8_t val = 0;
 
 	for (; list; list = list->next) {
@@ -156,14 +155,21 @@ static void update_svclass_list(const bdaddr_t *src)
 
 	SDPDBG("Service classes 0x%02x", val);
 
-	service_classes = val;
-
 	manager_update_svc(src, val);
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
+			update_adapter_svclass_list(&bdaddr);
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
index 1f0a229..d496a4a 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -93,7 +93,6 @@ void stop_sdp_server(void);
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
 int remove_record_from_server(uint32_t handle);
 
-uint8_t get_service_classes(const bdaddr_t *bdaddr);
 void create_ext_inquiry_response(const char *name,
 					int8_t tx_power, sdp_list_t *services,
 					uint8_t *data);
-- 
1.6.3.3

