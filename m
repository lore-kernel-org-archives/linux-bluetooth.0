Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 12/32] Complete the response dictionary in GetHealthInstances response
Date: Wed,  2 Jun 2010 15:19:08 +0200
Message-Id: <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |  169 ++++++++++++++++++++++++++++++++++-------------------
 health/hdp_util.c |   56 +++++++++++++++++-
 health/hdp_util.h |   12 ++++
 3 files changed, 175 insertions(+), 62 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 44b3c8f..abae2df 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -46,6 +46,12 @@ struct instances_aux {
 	DBusMessage		*msg;
 };
 
+struct health_instances_aux {
+	guint32		handler;
+	guint8		data_spec;
+	GSList		*end_points;
+};
+
 static struct hdp_adapter *find_adapter(GSList *list,
 					struct btd_adapter *btd_adapter)
 {
@@ -86,41 +92,114 @@ static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 	return -1;
 }
 
-static void append_dict_features(DBusMessageIter *iter, GSList *end_points)
+static void fill_up_one_spec(DBusMessageIter *dict, gpointer data)
 {
-	DBusMessageIter entry, array;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, "end_points");
-
-	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-			DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_TYPE_ARRAY_AS_STRING
-			DBUS_TYPE_ARRAY_AS_STRING
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
-
-	dbus_message_iter_close_container(&entry, &array);
-	dbus_message_iter_close_container(iter, &entry);
+	struct hdp_feature *feature = data;
+
+	dict_append_entry(dict, "dtype", DBUS_TYPE_UINT16, &feature->dtype);
+	if (feature->dscr)
+		dict_append_entry(dict, "description", DBUS_TYPE_STRING,
+								&feature->dscr);
 }
 
-static void append_array_entry(DBusMessageIter *iter, uint32_t *handler,
-					uint8_t *spec, GSList *end_points)
+static void fill_up_specs(DBusMessageIter *dict, gpointer data)
 {
-	DBusMessageIter dict;
+	GSList *specs = data;
+	GSList *l;
+	struct hdp_feature *feature;
+
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	for (l = specs; l; l = l->next) {
+		feature = l->data;
 
-	dict_append_entry(&dict, "id", DBUS_TYPE_UINT32, handler);
-	dict_append_entry(&dict, "data_spec", DBUS_TYPE_BYTE, spec);
-	append_dict_features(&dict, end_points);
+		hdp_append_dict(dict, fill_up_one_spec, feature);
+	}
+}
+
+static void fill_up_specs_array(DBusMessageIter *array, gpointer data)
+{
+	hdp_append_array_of_dicts(array, fill_up_specs, data);
+}
 
-	dbus_message_iter_close_container(iter, &dict);
+static void fill_up_one_end_point(DBusMessageIter *dict, gpointer data)
+{
+	struct hdp_supp_fts *fts = data;
+	const char *role;
+
+	if (fts->role == HDP_SOURCE)
+		role = HDP_SOURCE_ROLE_AS_STRING;
+	else if (fts->role == HDP_SINK)
+		role = HDP_SINK_ROLE_AS_STRING;
+
+	dict_append_entry(dict, "mdepid", DBUS_TYPE_BYTE, &fts->mdepid);
+	dict_append_entry(dict, "role", DBUS_TYPE_STRING, &role);
+	hdp_append_variant_array_entry(dict, "specs", fill_up_specs_array,
+								fts->features);
+}
+
+static void fill_up_end_points(DBusMessageIter *dict, gpointer data)
+{
+	GSList *end_points = data;
+	struct hdp_supp_fts *fts;
+	GSList *l;
+
+	for (l = end_points; l; l = l->next) {
+		fts = l->data;
+
+		if (fts->role != HDP_SOURCE && fts->role != HDP_SINK)
+			continue;
+
+		hdp_append_dict(dict, fill_up_one_end_point, fts);
+	}
+}
+
+static void fill_up_end_points_array(DBusMessageIter *iter, gpointer data)
+{
+	hdp_append_array_of_dicts(iter, fill_up_end_points, data);
+}
+
+static void fill_up_instance(DBusMessageIter *entry, gpointer data)
+{
+	struct health_instances_aux *aux = data;
+	guint32 handler = aux->handler;
+	guint8 data_spec = aux->data_spec;
+	GSList *end_points = aux->end_points;
+
+	dict_append_entry(entry, "id", DBUS_TYPE_UINT32, &handler);
+	dict_append_entry(entry, "data_spec", DBUS_TYPE_BYTE, &data_spec);
+	hdp_append_variant_array_entry(entry, "end_points",
+					fill_up_end_points_array, end_points);
+}
+
+static void fill_up_health_instances(DBusMessageIter *dict, gpointer data)
+{
+	sdp_list_t *recs = data;
+	sdp_record_t *rec;
+	sdp_list_t *l;
+	guint8 data_spec;
+	GSList *end_points;
+	struct health_instances_aux *aux;
+
+	for (l = recs; l; l = l->next) {
+		rec = l->data;
+		debug("Record found 0x%x", rec->handle);
+
+		if (!hdp_get_data_exchange_spec(rec, &data_spec)) {
+			error("Error getting data exchange info");
+			continue;
+		}
+		end_points = hdp_get_end_points(rec);
+		if (!end_points) {
+			error("Error getting end points");
+			continue;
+		}
+		aux = g_new0(struct health_instances_aux, 1);
+		aux->handler = rec->handle;
+		aux->data_spec = data_spec;
+		aux->end_points = end_points;
+		hdp_append_dict(dict, fill_up_instance, aux);
+		g_free(aux);
+	}
 }
 
 static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
@@ -129,11 +208,7 @@ static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 	DBusMessage *msg = cb_data->msg;
 	struct hdp_device *device = cb_data->device;
 	DBusMessage *reply;
-	sdp_record_t *rec;
-	sdp_list_t *l;
-	guint8 data_spec;
-	GSList *end_points;
-	DBusMessageIter iter, dict;
+	DBusMessageIter iter;
 
 	g_free(cb_data);
 
@@ -151,34 +226,8 @@ static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 
 	dbus_message_iter_init_append(reply, &iter);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_TYPE_ARRAY_AS_STRING
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	for (l = recs; l; l = l->next) {
-		rec = l->data;
-		debug("Record found 0x%x", rec->handle);
+	hdp_append_array_of_dicts(&iter, fill_up_health_instances, recs);
 
-		if (!hdp_get_data_exchange_spec(rec, &data_spec)) {
-			error("Error getting data exchange info");
-			continue;
-		}
-		end_points = hdp_get_end_points(rec);
-		if (!end_points) {
-			error("Error getting end points");
-			continue;
-		}
-		append_array_entry(&dict, &rec->handle, &data_spec,
-								end_points);
-	}
-
-	dbus_message_iter_close_container(&iter, &dict);
-/*
-	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
-							"Not implemented yet");
-*/
 	g_dbus_send_message(device->conn, reply);
 }
 
diff --git a/health/hdp_util.c b/health/hdp_util.c
index f6ab8e7..4f50550 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -328,9 +328,9 @@ static gboolean parse_role(DBusMessageIter *iter, GError **err, gpointer data)
 	}
 
 	dbus_message_iter_get_basic(string, &role);
-	if (g_strcmp0(role, "sink") == 0)
+	if (g_strcmp0(role, HDP_SINK_ROLE_AS_STRING) == 0)
 		fts->role = HDP_SINK;
-	else if (g_strcmp0(role, "source") == 0)
+	else if (g_strcmp0(role, HDP_SOURCE_ROLE_AS_STRING) == 0)
 		fts->role = HDP_SOURCE;
 	else {
 		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
@@ -949,3 +949,55 @@ GSList *hdp_get_end_points(const sdp_record_t *rec)
 
 	return epl;
 }
+
+void hdp_append_array_of_dicts(DBusMessageIter *iter, hdp_dbus_fill_up fill_up,
+							gpointer user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	fill_up(&dict, user_data);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+void hdp_append_dict(DBusMessageIter *iter, hdp_dbus_fill_up fill_up,
+							gpointer user_data)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &entry);
+
+	fill_up(&entry, user_data);
+
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+void hdp_append_variant_array_entry(DBusMessageIter *iter, char *key,
+				hdp_dbus_fill_up fill_up, gpointer user_data)
+{
+	DBusMessageIter entry, array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
+								NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+
+	fill_up(&array, user_data);
+
+	dbus_message_iter_close_container(&entry, &array);
+	dbus_message_iter_close_container(iter, &entry);
+}
diff --git a/health/hdp_util.h b/health/hdp_util.h
index beafa00..08e6471 100644
--- a/health/hdp_util.h
+++ b/health/hdp_util.h
@@ -29,10 +29,22 @@
 #include <gdbus.h>
 #include "hdp_types.h"
 
+#define HDP_SINK_ROLE_AS_STRING	"sink"
+#define HDP_SOURCE_ROLE_AS_STRING	"source"
+
+typedef void (*hdp_dbus_fill_up)(DBusMessageIter *iter, gpointer data);
+
 struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
 gboolean hdp_register_sdp_record(struct hdp_instance *hdps);
 gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val);
 GSList *hdp_get_end_points(const sdp_record_t *rec);
 void hdp_instance_free(struct hdp_instance *hdpi);
 
+void hdp_append_array_of_dicts(DBusMessageIter *iter, hdp_dbus_fill_up fill_up,
+							gpointer user_data);
+void hdp_append_dict(DBusMessageIter *iter, hdp_dbus_fill_up fil_up,
+							gpointer user_data);
+void hdp_append_variant_array_entry(DBusMessageIter *iter, char *key,
+				hdp_dbus_fill_up fill_up, gpointer user_data);
+
 #endif /* __HDP_UTIL_H__ */
-- 
1.6.3.3

