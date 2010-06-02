Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 08/32] Work in getting remote SDP records
Date: Wed,  2 Jun 2010 15:19:04 +0200
Message-Id: <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |   80 ++++++++++++++++++++++++++++++++++++++++++++--------
 health/hdp_util.c |    5 +++
 health/hdp_util.h |    1 +
 3 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 9ca2e52..68bd809 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -31,6 +31,8 @@
 #include "hdp_util.h"
 #include "device.h"
 
+#include "glib-helper.h"
+
 #include "../src/dbus-common.h"
 
 #define HEALTH_MANAGER_INTERFACE       "org.bluez.HealthAdapter"
@@ -39,6 +41,11 @@
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
+struct instances_aux {
+	struct hdp_device	*device;
+	DBusMessage		*msg;
+};
+
 static struct hdp_adapter *find_adapter(GSList *list,
 					struct btd_adapter *btd_adapter)
 {
@@ -69,27 +76,73 @@ static struct hdp_device *find_device(GSList *devices, struct btd_device *dev)
 	return NULL;
 }
 
+static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct instances_aux *cb_data = user_data;
+	DBusMessage *msg = cb_data->msg;
+	struct hdp_device *device = cb_data->device;
+	DBusMessage *reply;
+	sdp_record_t *rec;
+	sdp_list_t *l;
+	guint8 data_spec;
+	GSList *end_points;
+
+	g_free(cb_data);
+
+	if (err != 0) {
+		error("Error getting sink records");
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+					"Error getting remote information");
+		g_dbus_send_message(device->conn, reply);
+		return;
+	}
+
+	for (l = recs; l; l = l->next) {
+		rec = l->data;
+		debug("Record found 0x%x", rec->handle);
+		/* TODO: Check record */
+		if (!hdp_get_data_exchange_spec(rec, &data_spec)) {
+			error("Error getting data exchange info");
+			continue;
+		}
+		end_points = hdp_get_end_points(rec);
+		if (!end_points) {
+			error("Error getting end points");
+			continue;
+		}
+		debug("Get data exchange spec %d", data_spec);
+	}
+
+	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+							"Not implemented yet");
+	g_dbus_send_message(device->conn, reply);
+}
+
 static DBusMessage *get_health_instances(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct hdp_device *device = user_data;
-	const sdp_record_t *rec;
-	guint8 data_spec;
+	struct btd_adapter *adapter;
+	struct instances_aux *cb_data;
+	bdaddr_t src, dst;
+	uuid_t uuid;
 
-	rec = btd_device_get_record(device->dev, HDP_UUID);
+	adapter = device_get_adapter(device->dev);
+	adapter_get_address(adapter, &src);
+	device_get_address(device->dev, &dst);
 
-	if (!rec) {
-		debug("No record found");
-		goto error;
-	}
+	cb_data = g_new0(struct instances_aux, 1);
+	cb_data->device = device;
+	cb_data->msg = dbus_message_ref(msg);
 
-	if (!hdp_get_data_exchange_spec(rec, &data_spec))
-		goto error;
 
-	debug("Get data exchange spec %d", data_spec);
-error:
+	bt_string2uuid(&uuid, HDP_UUID);
+	if (bt_search_service(&src, &dst, &uuid, sink_health_instances,
+						cb_data, NULL) == 0)
+		return NULL;
+
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
-					"Cannot get the remote SDP record");
+				"Error getting remote information");
 }
 
 static void health_device_free(struct hdp_device *device)
@@ -119,7 +172,8 @@ static void dev_path_unregister(void *data)
 }
 
 static GDBusMethodTable device_methods[] = {
-	{ "GetHealthInstances",	"",	"a{sv}",	get_health_instances },
+	{ "GetHealthInstances", "", "a{sv}", get_health_instances,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ NULL }
 };
 
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 42f28bf..a6d09c5 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -781,6 +781,11 @@ static gboolean register_data_exchange_spec(struct hdp_config *config,
 	return TRUE;
 }
 
+GSList *hdp_get_end_points(const sdp_record_t *rec)
+{
+	return NULL;
+}
+
 static gboolean register_mcap_features(sdp_record_t *sdp_record)
 {
 	sdp_data_t *mcap_proc;
diff --git a/health/hdp_util.h b/health/hdp_util.h
index 0fdaaec..beafa00 100644
--- a/health/hdp_util.h
+++ b/health/hdp_util.h
@@ -32,6 +32,7 @@
 struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
 gboolean hdp_register_sdp_record(struct hdp_instance *hdps);
 gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val);
+GSList *hdp_get_end_points(const sdp_record_t *rec);
 void hdp_instance_free(struct hdp_instance *hdpi);
 
 #endif /* __HDP_UTIL_H__ */
-- 
1.6.3.3

