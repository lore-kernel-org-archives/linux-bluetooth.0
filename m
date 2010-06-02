Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jos=C3=A9=20Antonio=20Santos=20Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 05/32] Register healt_driver interfaces in d-bus
Date: Wed,  2 Jun 2010 15:19:01 +0200
Message-Id: <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos Cadenas <santoscadenas@gmail.com>

Register interface for each hdp_driver plugged
Unregister driver
Device_get_health_instances method added
Add function to get data exchange spec from a remote record
---
 health/hdp.c       |  126 +++++++++++++++++++++++++++++++++++++++++++++++++---
 health/hdp.h       |    4 +-
 health/hdp_types.h |   10 ++++
 health/hdp_util.c  |   11 +++++
 health/hdp_util.h  |    2 +
 health/manager.c   |   20 +++-----
 6 files changed, 151 insertions(+), 22 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 1094170..ae6add4 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -29,12 +29,16 @@
 
 #include "hdp_types.h"
 #include "hdp_util.h"
-
-#define HEALTH_MANAGER_INTERFACE 	"org.bluez.HealthAdapter"
+#include "device.h"
 
 #include "../src/dbus-common.h"
 
+#define HEALTH_MANAGER_INTERFACE       "org.bluez.HealthAdapter"
+#define HEALTH_INSTANCE_INTERFACE      "org.bluez.HealthInstance"
+#define HEALTH_DEVICE                  "org.bluez.HealthDevice"
+
 static GSList *adapters = NULL;
+static GSList *devices = NULL;
 
 static struct hdp_adapter *find_adapter(GSList *list,
 					struct btd_adapter *btd_adapter)
@@ -51,6 +55,98 @@ static struct hdp_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
+static struct hdp_device *find_device(GSList *devices, struct btd_device *dev)
+{
+	GSList *l;
+	struct hdp_device *device;
+
+	for (l = devices; l != NULL; l = l->next) {
+		device = l->data;
+
+		if (device->dev == dev)
+			return device;
+	}
+
+	return NULL;
+}
+
+static DBusMessage *get_health_instances(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct hdp_device *device = user_data;
+	const sdp_record_t *rec;
+	guint8 data_spec;
+
+	rec = btd_device_get_record(device->dev, HDP_UUID);
+
+	if (!rec) {
+		debug("No record found");
+		goto error;
+	}
+
+	if (!hdp_get_data_exchange_spec(rec, &data_spec))
+		goto error;
+
+	debug("Get data exchange spec %d", data_spec);
+error:
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+					"Cannot get the remote SDP record");
+}
+
+static void health_device_free(struct hdp_device *device)
+{
+	if (device->conn) {
+		dbus_connection_unref(device->conn);
+		device->conn = NULL;
+	}
+
+	if (device->dev) {
+		btd_device_unref(device->dev);
+		device->dev = NULL;
+	}
+
+	g_free(device);
+}
+
+static void dev_path_unregister(void *data)
+{
+	struct hdp_device *device = data;
+
+
+	debug("Unregistered interface %s on path %s", HEALTH_DEVICE,
+						device_get_path(device->dev));
+	devices = g_slist_remove(devices, device);
+	health_device_free(device);
+}
+
+static GDBusMethodTable device_methods[] = {
+	{ "GetHealthInstances",	"",	"a{sv}",	get_health_instances },
+	{ NULL }
+};
+
+static struct hdp_device *create_health_device(DBusConnection *conn,
+						struct btd_device *device)
+{
+	const gchar *path = device_get_path(device);
+	struct hdp_device *dev;
+
+	dev = g_new0(struct hdp_device, 1);
+	dev->conn = dbus_connection_ref(conn);
+	dev->dev = btd_device_ref(device);
+
+	if (!g_dbus_register_interface(conn, path,
+					HEALTH_DEVICE,
+					device_methods, NULL, NULL,
+					dev, dev_path_unregister)) {
+		error("D-Bus failed to register %s interface", HEALTH_DEVICE);
+		health_device_free(dev);
+		return NULL;
+	}
+
+	debug("Registered interface %s on path %s", HEALTH_DEVICE, path);
+	return dev;
+}
+
 static void hdp_set_instance_id(struct hdp_instance *hdpi)
 {
 	struct hdp_adapter *adapter = hdpi->adapter;
@@ -59,7 +155,7 @@ static void hdp_set_instance_id(struct hdp_instance *hdpi)
 }
 
 static DBusMessage *hdp_create_instance(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+				      DBusMessage *msg, void *user_data)
 {
 	struct hdp_adapter *adapter = user_data;
 	const char *path, *name;
@@ -185,13 +281,29 @@ void hdp_adapter_unregister(struct btd_adapter *btd_adapter)
 	debug("HDP exit");
 }
 
-int health_device_register(struct btd_device *device, const char *uuid)
+int hdp_device_register(DBusConnection *conn, struct btd_device *device)
 {
-	debug("HDP_DRIVER_PROBE with uuid %s", uuid);
+	struct hdp_device *hdp_dev;
+
+	hdp_dev = find_device(devices, device);
+	if (!hdp_dev) {
+		hdp_dev = create_health_device(conn, device);
+		if (!hdp_dev)
+			return -1;
+		devices = g_slist_append(devices, hdp_dev);
+	}
 	return 0;
 }
 
-void health_device_unregister(struct btd_device *device)
+void hdp_device_unregister(struct btd_device *device)
 {
-	debug("TODO: Remove device");
+	struct hdp_device *hdp_dev;
+	const char *path;
+
+	hdp_dev = find_device(devices, device);
+	if (!hdp_dev)
+		return;
+
+	path = device_get_path(hdp_dev->dev);
+	g_dbus_unregister_interface(hdp_dev->conn, path, HEALTH_DEVICE);
 }
diff --git a/health/hdp.h b/health/hdp.h
index 0aae7b9..edb06a0 100644
--- a/health/hdp.h
+++ b/health/hdp.h
@@ -26,5 +26,5 @@
 int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter);
 void hdp_adapter_unregister(struct btd_adapter *btd_adapter);
 
-int health_device_register(struct btd_device *device, const char *uuid);
-void health_device_unregister(struct btd_device *device);
+int hdp_device_register(DBusConnection *conn, struct btd_device *device);
+void hdp_device_unregister(struct btd_device *device);
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 2db9adf..171910a 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -30,6 +30,10 @@
 #include <glib.h>
 #include "mcap_lib.h"
 
+#define HDP_UUID		"00001400-0000-1000-8000-00805F9B34FB"
+#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805F9B34FB"
+#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805F9B34FB"
+
 #define HDP_SERVICE_NAME	"Bluez HDP"
 #define HDP_SERVICE_DSC		"A Bluez health device profile implementation"
 #define HDP_SERVICE_PROVIDER	"Bluez"
@@ -96,4 +100,10 @@ struct hdp_instance {
 	uint32_t		sdp_handler;	/* SDP record handler */
 };
 
+struct hdp_device {
+	DBusConnection		*conn;		/* for name listener handling */
+	struct btd_device	*dev;		/* Device reference */
+	struct hdp_adapter	*hdp_adapter;	/* hdp_adapater */
+};
+
 #endif /* __HDP_TYPES_H__ */
diff --git a/health/hdp_util.c b/health/hdp_util.c
index b386be5..816078a 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -838,3 +838,14 @@ error:
 		sdp_record_free(sdp_record);
 	return FALSE;
 }
+
+gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val)
+{
+	sdp_data_t *exspec;
+
+	exspec = sdp_data_get(rec, SDP_ATTR_DATA_EXCHANGE_SPEC);
+	if (exspec->dtd != SDP_UINT8)
+		return FALSE;
+	*val = exspec->val.uint8;
+	return TRUE;
+}
diff --git a/health/hdp_util.h b/health/hdp_util.h
index fb114c7..0fdaaec 100644
--- a/health/hdp_util.h
+++ b/health/hdp_util.h
@@ -31,5 +31,7 @@
 
 struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
 gboolean hdp_register_sdp_record(struct hdp_instance *hdps);
+gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val);
+void hdp_instance_free(struct hdp_instance *hdpi);
 
 #endif /* __HDP_UTIL_H__ */
diff --git a/health/manager.c b/health/manager.c
index 9b3b1a5..2f87db9 100644
--- a/health/manager.c
+++ b/health/manager.c
@@ -28,20 +28,19 @@
 #endif
 
 #include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
 #include <gdbus.h>
 
-#include "adapter.h"
-#include "device.h"
+#include "hdp_types.h"
 
 #include "logging.h"
 #include "manager.h"
 #include "hdp.h"
 
-#define HDP_UUID		"00001400-0000-1000-8000-00805F9B34FB"
-#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805F9B34FB"
-#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805F9B34FB"
+#include "device.h"
+#include "glib-helper.h"
 
 static DBusConnection *connection = NULL;
 
@@ -63,22 +62,17 @@ static struct btd_adapter_driver hdp_adapter_driver = {
 
 static int hdp_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	while (uuids) {
-		health_device_register(device, uuids->data);
-		uuids = uuids->next;
-	}
-
-	return 0;
+	return hdp_device_register(connection, device);
 }
 
 static void hdp_driver_remove(struct btd_device *device)
 {
-	health_device_unregister(device);
+	hdp_device_unregister(device);
 }
 
 static struct btd_device_driver hdp_device_driver = {
 	.name	= "hdp-device-driver",
-	.uuids	= BTD_UUIDS(HDP_UUID, HDP_SOURCE_UUID, HDP_SINK_UUID),
+	.uuids	= BTD_UUIDS(HDP_UUID),
 	.probe	= hdp_driver_probe,
 	.remove	= hdp_driver_remove,
 };
-- 
1.6.3.3

