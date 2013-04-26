Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 16/27] device: Replace connected_profiles with btd_service
Date: Fri, 26 Apr 2013 08:17:12 +0200
Message-Id: <1366957043-2383-17-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The service state can provide enough information not to maintain such
a connected_profiles list. Therefore, avoid duplicated information and
remove the list.
---
 src/device.c | 62 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/src/device.c b/src/device.c
index abdd3af..2e91499 100644
--- a/src/device.c
+++ b/src/device.c
@@ -187,7 +187,6 @@ struct btd_device {
 	guint		attachid;		/* Attrib server attach */
 
 	gboolean	connected;
-	GSList		*connected_profiles;
 
 	sdp_list_t	*tmp_records;
 
@@ -233,6 +232,21 @@ static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
 	return NULL;
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
@@ -986,16 +1000,9 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 	adapter_cancel_bonding(adapter, &device->bdaddr, device->bdaddr_type);
 }
 
-static void dev_disconn_profile(gpointer a, gpointer b)
+static void dev_disconn_service(gpointer a, gpointer b)
 {
-	struct btd_profile *profile = a;
-	struct btd_device *dev = b;
-	struct btd_service *service;
-	GSList *l;
-
-	l = find_service_with_profile(dev->services, profile);
-	service = l->data;
-	btd_service_disconnect(service);
+	btd_service_disconnect(a);
 }
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
@@ -1021,10 +1028,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->disconn_timer)
 		return;
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -1096,6 +1100,7 @@ void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
 	struct btd_profile *pending;
+	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
@@ -1105,10 +1110,9 @@ void device_profile_connected(struct btd_device *dev,
 	pending = dev->pending->data;
 	dev->pending = g_slist_remove(dev->pending, profile);
 
-	if (!err)
-		dev->connected_profiles =
-				g_slist_append(dev->connected_profiles,
-								profile);
+	l = find_service_with_profile(dev->services, profile);
+	if (l != NULL)
+		btd_service_connecting_complete(l->data, err);
 
 	/* Only continue connecting the next profile if it matches the first
 	 * pending, otherwise it will trigger another connect to the same
@@ -1129,7 +1133,9 @@ void device_profile_connected(struct btd_device *dev,
 
 	DBG("returning response to %s", dbus_message_get_sender(dev->connect));
 
-	if (err && dev->connected_profiles == NULL)
+	l = find_service_with_state(dev->services, BTD_SERVICE_STATE_CONNECTED);
+
+	if (err && l == NULL)
 		g_dbus_send_message(dbus_conn,
 				btd_error_failed(dev->connect, strerror(-err)));
 	else
@@ -1240,7 +1246,8 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (g_slist_find(dev->pending, p))
 			continue;
 
-		if (g_slist_find(dev->connected_profiles, p))
+		if (btd_service_get_state(service) !=
+						BTD_SERVICE_STATE_DISCONNECTED)
 			continue;
 
 		dev->pending = g_slist_insert_sorted(dev->pending, p,
@@ -1309,8 +1316,11 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 void device_profile_disconnected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	dev->connected_profiles = g_slist_remove(dev->connected_profiles,
-								profile);
+	GSList *l;
+
+	l = find_service_with_profile(dev->services, profile);
+	if (l != NULL)
+		btd_service_disconnecting_complete(l->data, err);
 
 	if (!dev->disconnect)
 		return;
@@ -2257,10 +2267,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
-	g_slist_foreach(device->connected_profiles, dev_disconn_profile,
-								device);
-	g_slist_free(device->connected_profiles);
-	device->connected_profiles = NULL;
+	g_slist_foreach(device->services, dev_disconn_service, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -2414,9 +2421,6 @@ void device_remove_profile(gpointer a, gpointer b)
 	if (l == NULL)
 		return;
 
-	device->connected_profiles = g_slist_remove(device->connected_profiles,
-								profile);
-
 	service = l->data;
 	device->services = g_slist_delete_link(device->services, l);
 	remove_service(service);
-- 
1.8.1.4

