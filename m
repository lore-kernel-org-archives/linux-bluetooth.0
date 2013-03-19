Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 03/11] device: Replace connected_profiles with btd_service
Date: Tue, 19 Mar 2013 08:40:47 +0100
Message-Id: <1363678855-12765-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The service state can provide enough information not to maintain such
a connected_profiles list. Therefore, avoid duplicated information and
remove the list.
---
 src/device.c | 82 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/src/device.c b/src/device.c
index c84a042..3e81899 100644
--- a/src/device.c
+++ b/src/device.c
@@ -186,7 +186,6 @@ struct btd_device {
 	guint		attachid;		/* Attrib server attach */
 
 	gboolean	connected;
-	GSList		*connected_profiles;
 
 	sdp_list_t	*tmp_records;
 
@@ -229,6 +228,17 @@ static gint service_profile_cmp(gconstpointer a, gconstpointer b)
 		return 1;
 }
 
+static gint service_state_cmp(gconstpointer a, gconstpointer b)
+{
+	struct btd_service *service = (gpointer) a;
+	service_state_t state = (service_state_t) GPOINTER_TO_INT(b);
+
+	if (service_get_state(service) == state)
+		return 0;
+	else
+		return 1;
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -981,15 +991,24 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 	adapter_cancel_bonding(adapter, &device->bdaddr, device->bdaddr_type);
 }
 
-static void dev_disconn_profile(gpointer a, gpointer b)
+static void dev_disconn_service(gpointer a, gpointer b)
 {
-	struct btd_profile *profile = a;
-	struct btd_device *dev = b;
+	struct btd_service *service = a;
+	struct btd_profile *profile = service_get_profile(service);
+	struct btd_device *dev = service_get_device(service);
+	service_state_t state = service_get_state(service);
 
 	if (!profile->disconnect)
 		return;
 
-	profile->disconnect(dev, profile);
+	if (state != SERVICE_STATE_CONNECTING &&
+					state != SERVICE_STATE_CONNECTED)
+		return;
+
+	if (profile->disconnect(dev, profile) != 0)
+		return;
+
+	service_disconnecting(service);
 }
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
@@ -1015,10 +1034,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->disconn_timer)
 		return;
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -1074,8 +1090,16 @@ static int connect_next(struct btd_device *dev)
 		profile = dev->pending->data;
 
 		err = profile->connect(dev, profile);
-		if (err == 0)
+		if (err == 0) {
+			GSList *l;
+
+			l = g_slist_find_custom(dev->services, profile,
+							service_profile_cmp);
+			if (l != NULL)
+				service_connecting(l->data);
+
 			return 0;
+		}
 
 		error("Failed to connect %s: %s", profile->name,
 							strerror(-err));
@@ -1089,6 +1113,7 @@ void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
 	struct btd_profile *pending;
+	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
@@ -1098,10 +1123,9 @@ void device_profile_connected(struct btd_device *dev,
 	pending = dev->pending->data;
 	dev->pending = g_slist_remove(dev->pending, profile);
 
-	if (!err)
-		dev->connected_profiles =
-				g_slist_append(dev->connected_profiles,
-								profile);
+	l = g_slist_find_custom(dev->services, profile, service_profile_cmp);
+	if (l != NULL)
+		service_connecting_complete(l->data, err);
 
 	/* Only continue connecting the next profile if it matches the first
 	 * pending, otherwise it will trigger another connect to the same
@@ -1122,7 +1146,11 @@ void device_profile_connected(struct btd_device *dev,
 
 	DBG("returning response to %s", dbus_message_get_sender(dev->connect));
 
-	if (err && dev->connected_profiles == NULL)
+	l = g_slist_find_custom(dev->services,
+				GINT_TO_POINTER(SERVICE_STATE_CONNECTED),
+				service_state_cmp);
+
+	if (err && l == NULL)
 		g_dbus_send_message(dbus_conn,
 				btd_error_failed(dev->connect, strerror(-err)));
 	else
@@ -1233,7 +1261,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (g_slist_find(dev->pending, p))
 			continue;
 
-		if (g_slist_find(dev->connected_profiles, p))
+		if (service_get_state(service) != SERVICE_STATE_DISCONNECTED)
 			continue;
 
 		dev->pending = g_slist_insert_sorted(dev->pending, p,
@@ -1302,8 +1330,11 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 void device_profile_disconnected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	dev->connected_profiles = g_slist_remove(dev->connected_profiles,
-								profile);
+	GSList *l;
+
+	l = g_slist_find_custom(dev->services, profile, service_profile_cmp);
+	if (l != NULL)
+		service_disconnecting_complete(l->data, err);
 
 	if (!dev->disconnect)
 		return;
@@ -1324,10 +1355,12 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *dev = user_data;
+	struct btd_service *service;
 	struct btd_profile *p;
 	const char *pattern;
 	char *uuid;
 	int err;
+	GSList *l;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 							DBUS_TYPE_INVALID))
@@ -1343,6 +1376,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (!p)
 		return btd_error_invalid_args(msg);
 
+	l = g_slist_find_custom(dev->services, p, service_profile_cmp);
+	service = l->data;
+
 	if (!p->disconnect)
 		return btd_error_not_supported(msg);
 
@@ -1350,6 +1386,8 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
+	service_disconnecting(service);
+
 	dev->disconnect = dbus_message_ref(msg);
 
 	return NULL;
@@ -2239,10 +2277,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -2417,9 +2452,6 @@ void device_remove_profile(gpointer a, gpointer b)
 	if (l == NULL)
 		return;
 
-	device->connected_profiles = g_slist_remove(device->connected_profiles,
-								profile);
-
 	service = l->data;
 	device->services = g_slist_delete_link(device->services, l);
 	service_remove(service);
-- 
1.8.1.4

