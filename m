Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Removing the service_classes_callback mechanism.
Date: Wed, 22 Jul 2009 17:36:54 +0530
Message-Id: <1248264414-16998-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/main.c         |   46 +---------------------------------------------
 src/manager.c      |   25 ++++++++++---------------
 src/manager.h      |    3 +--
 src/sdpd-service.c |   13 +++++--------
 src/sdpd.h         |    3 ---
 5 files changed, 17 insertions(+), 73 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8c2b475..e8b39a7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -203,49 +203,6 @@ static void parse_config(GKeyFile *config)
 						HCI_LP_HOLD | HCI_LP_PARK;
 }
 
-static void update_service_classes(const bdaddr_t *bdaddr, uint8_t value)
-{
-	struct hci_dev_list_req *dl;
-	struct hci_dev_req *dr;
-	int i, sk;
-
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sk < 0)
-		return;
-
-	dl = g_malloc0(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
-
-	dl->dev_num = HCI_MAX_DEV;
-
-	if (ioctl(sk, HCIGETDEVLIST, dl) < 0) {
-		close(sk);
-		g_free(dl);
-		return;
-	}
-
-	dr = dl->dev_req;
-
-	for (i = 0; i < dl->dev_num; i++, dr++) {
-		struct hci_dev_info di;
-
-		if (hci_devinfo(dr->dev_id, &di) < 0)
-			continue;
-
-		if (hci_test_bit(HCI_RAW, &di.flags))
-			continue;
-
-		if (bacmp(bdaddr, BDADDR_ANY) != 0 &&
-				bacmp(bdaddr, &di.bdaddr) != 0)
-			continue;
-
-		manager_update_adapter(di.dev_id, value);
-	}
-
-	g_free(dl);
-
-	close(sk);
-}
-
 /*
  * Device name expansion
  *   %d - device id
@@ -460,7 +417,6 @@ int main(int argc, char *argv[])
 	}
 
 	start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
-	set_service_classes_callback(update_service_classes);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
@@ -475,7 +431,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	manager_startup_complete();
+	manager_update_svc(BDADDR_ANY, 0);
 
 	debug("Entering main loop");
 
diff --git a/src/manager.c b/src/manager.c
index ab69e4e..99d16ba 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -61,27 +61,22 @@ const char *manager_get_base_path(void)
 	return base_path;
 }
 
-int manager_update_adapter(uint16_t dev_id, uint8_t svc)
-{
-	struct btd_adapter *adapter;
-
-	adapter = manager_find_adapter_by_id(dev_id);
-	if (!adapter)
-		return -EINVAL;
-
-	return adapter_update(adapter, svc);
-}
-
-int manager_startup_complete(void)
+void manager_update_svc(const bdaddr_t *bdaddr, uint8_t svc)
 {
 	GSList *l;
+	bdaddr_t src;
 
 	for (l = adapters; l != NULL; l = l->next) {
 		struct btd_adapter *adapter = l->data;
-		adapter_update(adapter, 0);
-	}
 
-	return 0;
+		adapter_get_address(adapter, &src);
+
+		if (bacmp(bdaddr, BDADDR_ANY) != 0 &&
+				bacmp(bdaddr, &src) != 0)
+			continue;
+
+		adapter_update(adapter, svc);
+	}
 }
 
 int manager_get_adapter_class(uint16_t dev_id, uint8_t *cls)
diff --git a/src/manager.h b/src/manager.h
index caf0b61..056d257 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -40,7 +40,6 @@ int manager_stop_adapter(int id);
 void manager_add_adapter(const char *path);
 int manager_get_default_adapter();
 void manager_set_default_adapter(int id);
-int manager_update_adapter(uint16_t id, uint8_t svc);
-int manager_startup_complete(void);
+void manager_update_svc(const bdaddr_t *bdaddr, uint8_t svc);
 int manager_get_adapter_class(uint16_t dev_id, uint8_t *cls);
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index f19e1d4..66f144f 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -40,13 +40,16 @@
 
 #include <netinet/in.h>
 
+#include <glib.h>
+#include <dbus/dbus.h>
+
 #include "sdpd.h"
 #include "logging.h"
+#include "manager.h"
 
 static sdp_record_t *server = NULL;
 
 static uint8_t service_classes = 0x00;
-static service_classes_callback_t service_classes_callback = NULL;
 
 static uint16_t did_vendor = 0x0000;
 static uint16_t did_product = 0x0000;
@@ -154,8 +157,7 @@ static void update_svclass_list(const bdaddr_t *src)
 
 	service_classes = val;
 
-	if (service_classes_callback)
-		service_classes_callback(src, val);
+	manager_update_svc(src, val);
 }
 
 uint8_t get_service_classes(const bdaddr_t *bdaddr)
@@ -163,11 +165,6 @@ uint8_t get_service_classes(const bdaddr_t *bdaddr)
 	return service_classes;
 }
 
-void set_service_classes_callback(service_classes_callback_t callback)
-{
-	service_classes_callback = callback;
-}
-
 void create_ext_inquiry_response(const char *name, uint8_t *data)
 {
 	sdp_list_t *list = sdp_get_record_list();
diff --git a/src/sdpd.h b/src/sdpd.h
index ac8155e..414bcd4 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -93,8 +93,5 @@ void stop_sdp_server(void);
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
 int remove_record_from_server(uint32_t handle);
 
-typedef void (*service_classes_callback_t) (const bdaddr_t *bdaddr, uint8_t value);
-
 uint8_t get_service_classes(const bdaddr_t *bdaddr);
-void set_service_classes_callback(service_classes_callback_t callback);
 void create_ext_inquiry_response(const char *name, uint8_t *data);
-- 
1.5.6.3

