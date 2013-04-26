Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 18/27] device: Replace pending profile list with services
Date: Fri, 26 Apr 2013 08:17:14 +0200
Message-Id: <1366957043-2383-19-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use btd_service pointers to represent the list of services pending for
connection.

This list doesn't reference count the btd_service instances, since the
pending services should be a subset of the available services, and thus
they should already be referenced by device->services. This means
special care must be taken to make sure any removed service is also
removed from the pending list, as addressed in remove_service().
---
 src/device.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index a5301df..91fcd89 100644
--- a/src/device.c
+++ b/src/device.c
@@ -170,7 +170,7 @@ struct btd_device {
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
-	GSList		*pending;		/* Pending profiles */
+	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
 	guint		disconn_timer;
@@ -906,8 +906,10 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 static void remove_service(gpointer data)
 {
 	struct btd_service *service = data;
+	struct btd_device *device = btd_service_get_device(service);
 
 	service_shutdown(service);
+	device->pending = g_slist_remove(device->pending, service);
 	btd_service_unref(service);
 }
 
@@ -1075,22 +1077,16 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 
 static int connect_next(struct btd_device *dev)
 {
-	struct btd_profile *profile;
 	struct btd_service *service;
 	int err = -ENOENT;
 
 	while (dev->pending) {
-		GSList *l;
-
-		profile = dev->pending->data;
-
-		l = find_service_with_profile(dev->services, profile);
-		service = l->data;
+		service = dev->pending->data;
 
 		if (btd_service_connect(service) == 0)
 			return 0;
 
-		dev->pending = g_slist_remove(dev->pending, profile);
+		dev->pending = g_slist_delete_link(dev->pending, dev->pending);
 	}
 
 	return err;
@@ -1099,7 +1095,7 @@ static int connect_next(struct btd_device *dev)
 void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	struct btd_profile *pending;
+	struct btd_service *pending;
 	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
@@ -1108,7 +1104,9 @@ void device_profile_connected(struct btd_device *dev,
 		return;
 
 	pending = dev->pending->data;
-	dev->pending = g_slist_remove(dev->pending, profile);
+	l = find_service_with_profile(dev->pending, profile);
+	if (l != NULL)
+		dev->pending = g_slist_delete_link(dev->pending, l);
 
 	l = find_service_with_profile(dev->services, profile);
 	if (l != NULL)
@@ -1118,7 +1116,7 @@ void device_profile_connected(struct btd_device *dev,
 	 * pending, otherwise it will trigger another connect to the same
 	 * profile
 	 */
-	if (profile != pending)
+	if (profile != btd_service_get_profile(pending))
 		return;
 
 	if (connect_next(dev) == 0)
@@ -1196,9 +1194,10 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
-static gint profile_prio_cmp(gconstpointer a, gconstpointer b)
+static gint service_prio_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct btd_profile *p1 = a, *p2 = b;
+	struct btd_profile *p1 = btd_service_get_profile(a);
+	struct btd_profile *p2 = btd_service_get_profile(b);
 
 	return p2->priority - p1->priority;
 }
@@ -1231,8 +1230,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (!service)
 			return btd_error_invalid_args(msg);
 
-		p = btd_service_get_profile(service);
-		dev->pending = g_slist_prepend(dev->pending, p);
+		dev->pending = g_slist_prepend(dev->pending, service);
 
 		goto start_connect;
 	}
@@ -1244,15 +1242,15 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (!p->auto_connect)
 			continue;
 
-		if (g_slist_find(dev->pending, p))
+		if (g_slist_find(dev->pending, service))
 			continue;
 
 		if (btd_service_get_state(service) !=
 						BTD_SERVICE_STATE_DISCONNECTED)
 			continue;
 
-		dev->pending = g_slist_insert_sorted(dev->pending, p,
-							profile_prio_cmp);
+		dev->pending = g_slist_insert_sorted(dev->pending, service,
+							service_prio_cmp);
 	}
 
 	if (!dev->pending)
@@ -2400,7 +2398,7 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (!profile->auto_connect || !device->general_connect)
 		return;
 
-	device->pending = g_slist_append(device->pending, profile);
+	device->pending = g_slist_append(device->pending, service);
 
 	if (g_slist_length(device->pending) == 1)
 		connect_next(device);
-- 
1.8.1.4

