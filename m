Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 06/32] Add delete instance petition
Date: Wed,  2 Jun 2010 15:19:02 +0200
Message-Id: <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |   64 +++++++++++++++++++++++++++++++++++++++++++----------
 health/hdp_util.c |   35 +++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index ae6add4..6e3c2fc 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -34,7 +34,6 @@
 #include "../src/dbus-common.h"
 
 #define HEALTH_MANAGER_INTERFACE       "org.bluez.HealthAdapter"
-#define HEALTH_INSTANCE_INTERFACE      "org.bluez.HealthInstance"
 #define HEALTH_DEVICE                  "org.bluez.HealthDevice"
 
 static GSList *adapters = NULL;
@@ -147,6 +146,16 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 	return dev;
 }
 
+static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
+{
+	const struct hdp_instance *hdpi = instance;
+	const uint32_t *id = p;
+
+	if (hdpi->id == *id)
+		return 0;
+	return -1;
+}
+
 static void hdp_set_instance_id(struct hdp_instance *hdpi)
 {
 	struct hdp_adapter *adapter = hdpi->adapter;
@@ -187,24 +196,20 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 	hdpi->aname = g_strdup(name);
 	hdpi->apath = g_strdup(path);
 	hdpi->config = config;
-	if (!config->svc_dsc)
-		config->svc_dsc = g_strdup(HDP_SERVICE_DSC);
-	if (!config->svc_name)
-		config->svc_name = g_strdup(HDP_SERVICE_NAME);
-	if (!config->svc_prov)
-		config->svc_prov = g_strdup(HDP_SERVICE_PROVIDER);
 	hdp_set_instance_id(hdpi);
 
 	/* TODO: Create mcap instance */
 
 	if (!hdp_register_sdp_record(hdpi)) {
+		hdp_instance_free(hdpi);
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
 					"Session can't be registered");
 	}
 
-	return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".HealthError",
-					"Incomplete call yet");
+	adapter->instances = g_slist_prepend(adapter->instances, hdpi);
+	info("HDP instance created with path %d", hdpi->id);
+	return g_dbus_create_reply(msg, DBUS_TYPE_UINT32, &hdpi->id,
+							DBUS_TYPE_INVALID);
 error:
 	if (err) {
 		reply = g_dbus_create_error(msg,
@@ -218,16 +223,51 @@ error:
 	return reply;
 }
 
+static DBusMessage *hdp_delete_instance(DBusConnection *conn,
+				      DBusMessage *msg, void *user_data)
+{
+	struct hdp_adapter *adapter = user_data;
+	struct hdp_instance *hdpi;
+	GSList *l;
+	const char *name;
+	uint32_t id;
+
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &id,
+							DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	l = g_slist_find_custom(adapter->instances, &id, hdp_instance_idcmp);
+	if (!l)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".NotFound",
+					"The session was not found");
+
+	name = dbus_message_get_sender(msg);
+	hdpi = l->data;
+	if (g_strcmp0(hdpi->aname, name) != 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+				"This session was created by an other process");
+	adapter->instances = g_slist_remove(adapter->instances, hdpi);
+	hdp_instance_free(hdpi);
+
+	debug("Stop HDP Session %d deleted", id);
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static GDBusMethodTable hdp_methods[] = {
 	{ "CreateInstance", "oa{sv}", "u", hdp_create_instance },
+	{ "DeleteInstance", "u", "",  hdp_delete_instance },
 	{ NULL }
 };
 
 void hdp_delete_instance_iter(gpointer data, gpointer user_data)
 {
-	/* struct hdp_instance *hdpi = data; */
+	struct hdp_instance *hdpi = data;
 
-	/* TODO: Create  a free function */
+	hdp_instance_free(hdpi);
 }
 
 static void hdp_path_unregister(void *data)
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 816078a..b047aa2 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -109,6 +109,28 @@ static void free_config(struct hdp_config *config)
 	g_free(config);
 }
 
+void hdp_instance_free(struct hdp_instance *hdpi)
+{
+	debug("HDP instance %d is deleted", hdpi->id);
+	/* TODO: Complete this part */
+	/*
+	g_slist_foreach(hdpi->devices, hdp_device_unregister, NULL);
+	g_slist_free(hdpi->devices);
+	hdpi->devices = NULL;
+	*/
+
+	if (hdpi->sdp_handler)
+		remove_record_from_server(hdpi->sdp_handler);
+	/* TODO: stop mcap instance */
+	if (hdpi->apath)
+		g_free(hdpi->apath);
+	if (hdpi->aname)
+		g_free(hdpi->aname);
+	if (hdpi->config)
+		free_config(hdpi->config);
+	g_free(hdpi);
+}
+
 static gboolean parse_dict_entry(struct dict_entry_func dict_context[],
 					DBusMessageIter *iter,
 					GError **err,
@@ -441,8 +463,17 @@ struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err)
 			"\"data_spec\" and \"end_point\" should be set or not");
 		goto error;
 	}
-	if (!config->ds_present)
-		goto error;
+	if (!config->ds_present) {
+		g_free(config);
+		return NULL;
+	}
+	if (!config->svc_dsc)
+		config->svc_dsc = g_strdup(HDP_SERVICE_DSC);
+	if (!config->svc_name)
+		config->svc_name = g_strdup(HDP_SERVICE_NAME);
+	if (!config->svc_prov)
+		config->svc_prov = g_strdup(HDP_SERVICE_PROVIDER);
+
 	debug("config->data_spec %d", config->data_spec);
 	g_slist_foreach(config->supp_fts, print_features, NULL);
 	return config;
-- 
1.6.3.3

