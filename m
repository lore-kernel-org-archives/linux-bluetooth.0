Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 05/11] device: Replace pending profile list with services
Date: Tue, 26 Mar 2013 17:13:48 +0100
Message-Id: <1364314434-9796-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use btd_service pointers to represent the list of services pending for
connection.

This list doesn't reference count the btd_service instances, since the
pending services should be a subset of the available services, and thus
they should already be referenced by device->services. This means
special care must be taken to make sure any removed service is also
removed from the pending list, as addressed in service_remove().
---
 src/device.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8b66ad9..68d59cb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -169,7 +169,7 @@ struct btd_device {
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
-	GSList		*pending;		/* Pending profiles */
+	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
 	guint		disconn_timer;
@@ -903,6 +903,7 @@ static void service_remove(struct btd_service *service)
 
 	btd_service_unavailable(service);
 	profile->device_remove(profile, device);
+	device->pending = g_slist_remove(device->pending, service);
 	btd_service_unref(service);
 }
 
@@ -1087,28 +1088,35 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 
 static int connect_next(struct btd_device *dev)
 {
+	struct btd_service *service;
 	struct btd_profile *profile;
 	int err = -ENOENT;
 
 	while (dev->pending) {
 		int err;
-		GSList *l;
 
-		profile = dev->pending->data;
+		service = dev->pending->data;
+		profile = btd_service_get_profile(service);
+
+		if (btd_service_get_state(service) !=
+					BTD_SERVICE_STATE_DISCONNECTED) {
+			dev->pending = g_slist_delete_link(dev->pending,
+								dev->pending);
+			continue;
+		}
 
-		l = g_slist_find_custom(dev->services, profile,
-							service_profile_cmp);
-		btd_service_connecting(l->data);
+		btd_service_connecting(service);
 
 		err = profile->connect(dev, profile);
 		if (err == 0)
 			return 0;
 
-		btd_service_connecting_complete(l->data, err);
+		btd_service_connecting_complete(service, err);
 
 		error("Failed to connect %s: %s", profile->name,
 							strerror(-err));
-		dev->pending = g_slist_remove(dev->pending, profile);
+
+		dev->pending = g_slist_delete_link(dev->pending, dev->pending);
 	}
 
 	return err;
@@ -1117,7 +1125,7 @@ static int connect_next(struct btd_device *dev)
 void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	struct btd_profile *pending;
+	struct btd_service *pending;
 	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
@@ -1126,7 +1134,9 @@ void device_profile_connected(struct btd_device *dev,
 		return;
 
 	pending = dev->pending->data;
-	dev->pending = g_slist_remove(dev->pending, profile);
+	l = g_slist_find_custom(dev->pending, profile, service_profile_cmp);
+	if (l != NULL)
+		dev->pending = g_slist_delete_link(dev->pending, l);
 
 	l = g_slist_find_custom(dev->services, profile, service_profile_cmp);
 	if (l != NULL)
@@ -1136,7 +1146,7 @@ void device_profile_connected(struct btd_device *dev,
 	 * pending, otherwise it will trigger another connect to the same
 	 * profile
 	 */
-	if (profile != pending)
+	if (profile != btd_service_get_profile(pending))
 		return;
 
 	if (connect_next(dev) == 0)
@@ -1214,9 +1224,12 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
-static gint profile_prio_cmp(gconstpointer a, gconstpointer b)
+static gint service_prio_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct btd_profile *p1 = a, *p2 = b;
+	const struct btd_service *s1 = a;
+	const struct btd_service *s2 = b;
+	struct btd_profile *p1 = btd_service_get_profile(s1);
+	struct btd_profile *p2 = btd_service_get_profile(s2);
 
 	return p2->priority - p1->priority;
 }
@@ -1249,8 +1262,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		if (!service)
 			return btd_error_invalid_args(msg);
 
-		p = btd_service_get_profile(service);
-		dev->pending = g_slist_prepend(dev->pending, p);
+		dev->pending = g_slist_prepend(dev->pending, service);
 
 		goto start_connect;
 	}
@@ -1262,15 +1274,15 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
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
@@ -2440,7 +2452,7 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (!profile->auto_connect || !device->general_connect)
 		return;
 
-	device->pending = g_slist_append(device->pending, profile);
+	device->pending = g_slist_append(device->pending, service);
 
 	if (g_slist_length(device->pending) == 1)
 		connect_next(device);
-- 
1.8.1.4

