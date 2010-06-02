Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 11/32] Initial support for connecting instances
Date: Wed,  2 Jun 2010 15:19:07 +0200
Message-Id: <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 6d18626..44b3c8f 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -76,6 +76,16 @@ static struct hdp_device *find_device(GSList *devices, struct btd_device *dev)
 	return NULL;
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
 static void append_dict_features(DBusMessageIter *iter, GSList *end_points)
 {
 	DBusMessageIter entry, array;
@@ -225,9 +235,40 @@ static void dev_path_unregister(void *data)
 	health_device_free(device);
 }
 
+static DBusMessage *hdp_connect(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct hdp_device *device = user_data;
+	struct hdp_instance *hdpi;
+	uint32_t lid, rid;
+	GSList *l;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_UINT32, &lid,
+					DBUS_TYPE_UINT32, &rid,
+					DBUS_TYPE_INVALID)) {
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+	}
+
+	l = g_slist_find_custom(device->hdp_adapter->instances, &lid,
+							hdp_instance_idcmp);
+	if (!l)
+		return g_dbus_create_error(msg,
+					   ERROR_INTERFACE ".InvalidArguments",
+					   "Invalid local instance id");
+	hdpi = l->data;
+
+
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".HdpError",
+					"Function is not yet implemented");
+}
+
 static GDBusMethodTable device_methods[] = {
 	{ "GetHealthInstances", "", "aa{sv}", get_health_instances,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Connect", "uu", "o", hdp_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ NULL }
 };
 
@@ -235,33 +276,30 @@ static struct hdp_device *create_health_device(DBusConnection *conn,
 						struct btd_device *device)
 {
 	const gchar *path = device_get_path(device);
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct hdp_device *dev;
 
 	dev = g_new0(struct hdp_device, 1);
 	dev->conn = dbus_connection_ref(conn);
 	dev->dev = btd_device_ref(device);
+	dev->hdp_adapter = find_adapter(adapters, adapter);
+
+	if (!dev->hdp_adapter)
+		goto fail;
 
 	if (!g_dbus_register_interface(conn, path,
 					HEALTH_DEVICE,
 					device_methods, NULL, NULL,
 					dev, dev_path_unregister)) {
 		error("D-Bus failed to register %s interface", HEALTH_DEVICE);
-		health_device_free(dev);
-		return NULL;
+		goto fail;
 	}
 
 	debug("Registered interface %s on path %s", HEALTH_DEVICE, path);
 	return dev;
-}
-
-static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
-{
-	const struct hdp_instance *hdpi = instance;
-	const uint32_t *id = p;
-
-	if (hdpi->id == *id)
-		return 0;
-	return -1;
+fail:
+	health_device_free(dev);
+	return NULL;
 }
 
 static void hdp_set_instance_id(struct hdp_instance *hdpi)
-- 
1.6.3.3

