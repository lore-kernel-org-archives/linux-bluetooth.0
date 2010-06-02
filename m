Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 10/32] Insert end_point in array returned by get_health_instances
Date: Wed,  2 Jun 2010 15:19:06 +0200
Message-Id: <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 health/hdp_util.c |    2 -
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 68bd809..6d18626 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -76,6 +76,43 @@ static struct hdp_device *find_device(GSList *devices, struct btd_device *dev)
 	return NULL;
 }
 
+static void append_dict_features(DBusMessageIter *iter, GSList *end_points)
+{
+	DBusMessageIter entry, array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
+								NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, "end_points");
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+			DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+
+	dbus_message_iter_close_container(&entry, &array);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+static void append_array_entry(DBusMessageIter *iter, uint32_t *handler,
+					uint8_t *spec, GSList *end_points)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "id", DBUS_TYPE_UINT32, handler);
+	dict_append_entry(&dict, "data_spec", DBUS_TYPE_BYTE, spec);
+	append_dict_features(&dict, end_points);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct instances_aux *cb_data = user_data;
@@ -86,6 +123,7 @@ static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 	sdp_list_t *l;
 	guint8 data_spec;
 	GSList *end_points;
+	DBusMessageIter iter, dict;
 
 	g_free(cb_data);
 
@@ -97,10 +135,22 @@ static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 		return;
 	}
 
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
 	for (l = recs; l; l = l->next) {
 		rec = l->data;
 		debug("Record found 0x%x", rec->handle);
-		/* TODO: Check record */
+
 		if (!hdp_get_data_exchange_spec(rec, &data_spec)) {
 			error("Error getting data exchange info");
 			continue;
@@ -110,11 +160,15 @@ static void sink_health_instances(sdp_list_t *recs, int err, gpointer user_data)
 			error("Error getting end points");
 			continue;
 		}
-		debug("Get data exchange spec %d", data_spec);
+		append_array_entry(&dict, &rec->handle, &data_spec,
+								end_points);
 	}
 
+	dbus_message_iter_close_container(&iter, &dict);
+/*
 	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
 							"Not implemented yet");
+*/
 	g_dbus_send_message(device->conn, reply);
 }
 
@@ -172,7 +226,7 @@ static void dev_path_unregister(void *data)
 }
 
 static GDBusMethodTable device_methods[] = {
-	{ "GetHealthInstances", "", "a{sv}", get_health_instances,
+	{ "GetHealthInstances", "", "aa{sv}", get_health_instances,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ NULL }
 };
diff --git a/health/hdp_util.c b/health/hdp_util.c
index b59e4e3..f6ab8e7 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -947,7 +947,5 @@ GSList *hdp_get_end_points(const sdp_record_t *rec)
 		epl = get_feature(epl, l->val.dataseq);
 	}
 
-	g_slist_foreach(epl, print_features, NULL);
-
 	return epl;
 }
-- 
1.6.3.3

