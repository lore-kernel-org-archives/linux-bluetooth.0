Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 03/11] device: Replace connected_profiles with btd_service
Date: Tue, 26 Mar 2013 17:13:46 +0100
Message-Id: <1364314434-9796-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The service state can provide enough information not to maintain such
a connected_profiles list. Therefore, avoid duplicated information and
remove the list.
---
 src/device.c | 88 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 25 deletions(-)

diff --git a/src/device.c b/src/device.c
index a258454..4b814c8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -186,7 +186,6 @@ struct btd_device {
 	guint		attachid;		/* Attrib server attach */
 
 	gboolean	connected;
-	GSList		*connected_profiles;
 
 	sdp_list_t	*tmp_records;
 
@@ -229,6 +228,21 @@ static gint service_profile_cmp(gconstpointer a, gconstpointer b)
 		return 1;
 }
 
+static GSList *find_service_with_state(GSList *list,
+						btd_service_state_t state)
+{
+	GSList *l;
+
+	for (l = list; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+
+		if (btd_service_get_state(service) == state)
+			return l;
+	}
+
+	return NULL;
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -981,15 +995,26 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 	adapter_cancel_bonding(adapter, &device->bdaddr, device->bdaddr_type);
 }
 
-static void dev_disconn_profile(gpointer a, gpointer b)
+static void dev_disconn_service(gpointer a, gpointer b)
 {
-	struct btd_profile *profile = a;
-	struct btd_device *dev = b;
+	struct btd_service *service = a;
+	struct btd_profile *profile = btd_service_get_profile(service);
+	struct btd_device *dev = btd_service_get_device(service);
+	btd_service_state_t state = btd_service_get_state(service);
+	int err;
 
 	if (!profile->disconnect)
 		return;
 
-	profile->disconnect(dev, profile);
+	if (state != BTD_SERVICE_STATE_CONNECTING &&
+					state != BTD_SERVICE_STATE_CONNECTED)
+		return;
+
+	btd_service_disconnecting(service);
+
+	err = profile->disconnect(dev, profile);
+	if (err != 0)
+		btd_service_disconnecting_complete(service, err);
 }
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
@@ -1015,10 +1040,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->disconn_timer)
 		return;
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -1070,13 +1092,20 @@ static int connect_next(struct btd_device *dev)
 
 	while (dev->pending) {
 		int err;
+		GSList *l;
 
 		profile = dev->pending->data;
 
+		l = g_slist_find_custom(dev->services, profile,
+							service_profile_cmp);
+		btd_service_connecting(l->data);
+
 		err = profile->connect(dev, profile);
 		if (err == 0)
 			return 0;
 
+		btd_service_connecting_complete(l->data, err);
+
 		error("Failed to connect %s: %s", profile->name,
 							strerror(-err));
 		dev->pending = g_slist_remove(dev->pending, profile);
@@ -1089,6 +1118,7 @@ void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
 	struct btd_profile *pending;
+	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
@@ -1098,10 +1128,9 @@ void device_profile_connected(struct btd_device *dev,
 	pending = dev->pending->data;
 	dev->pending = g_slist_remove(dev->pending, profile);
 
-	if (!err)
-		dev->connected_profiles =
-				g_slist_append(dev->connected_profiles,
-								profile);
+	l = g_slist_find_custom(dev->services, profile, service_profile_cmp);
+	if (l != NULL)
+		btd_service_connecting_complete(l->data, err);
 
 	/* Only continue connecting the next profile if it matches the first
 	 * pending, otherwise it will trigger another connect to the same
@@ -1122,7 +1151,9 @@ void device_profile_connected(struct btd_device *dev,
 
 	DBG("returning response to %s", dbus_message_get_sender(dev->connect));
 
-	if (err && dev->connected_profiles == NULL)
+	l = find_service_with_state(dev->services, BTD_SERVICE_STATE_CONNECTED);
+
+	if (err && l == NULL)
 		g_dbus_send_message(dbus_conn,
 				btd_error_failed(dev->connect, strerror(-err)));
 	else
@@ -1233,7 +1264,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (g_slist_find(dev->pending, p))
 			continue;
 
-		if (g_slist_find(dev->connected_profiles, p))
+		if (btd_service_get_state(service) !=
+						BTD_SERVICE_STATE_DISCONNECTED)
 			continue;
 
 		dev->pending = g_slist_insert_sorted(dev->pending, p,
@@ -1302,8 +1334,11 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 void device_profile_disconnected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	dev->connected_profiles = g_slist_remove(dev->connected_profiles,
-								profile);
+	GSList *l;
+
+	l = g_slist_find_custom(dev->services, profile, service_profile_cmp);
+	if (l != NULL)
+		btd_service_disconnecting_complete(l->data, err);
 
 	if (!dev->disconnect)
 		return;
@@ -1324,10 +1359,12 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
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
@@ -1343,12 +1380,19 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (!p)
 		return btd_error_invalid_args(msg);
 
+	l = g_slist_find_custom(dev->services, p, service_profile_cmp);
+	service = l->data;
+
 	if (!p->disconnect)
 		return btd_error_not_supported(msg);
 
+	btd_service_disconnecting(service);
+
 	err = p->disconnect(dev, p);
-	if (err < 0)
+	if (err < 0) {
+		btd_service_disconnecting_complete(service, err);
 		return btd_error_failed(msg, strerror(-err));
+	}
 
 	dev->disconnect = dbus_message_ref(msg);
 
@@ -2239,10 +2283,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -2417,9 +2458,6 @@ void device_remove_profile(gpointer a, gpointer b)
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

