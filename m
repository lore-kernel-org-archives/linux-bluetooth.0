Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 02/11] device: Use btd_service to represent profiles
Date: Tue, 19 Mar 2013 08:40:46 +0100
Message-Id: <1363678855-12765-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Maintain a list of btd_service pointers instead of btd_profile pointers,
for services that have been probed for this device.

This list will reference count the btd_service instances.
---
 src/device.c | 76 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3cd7f10..c84a042 100644
--- a/src/device.c
+++ b/src/device.c
@@ -56,6 +56,7 @@
 #include "attio.h"
 #include "device.h"
 #include "profile.h"
+#include "service.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "glib-helper.h"
@@ -167,7 +168,7 @@ struct btd_device {
 	struct btd_adapter	*adapter;
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
-	GSList		*profiles;		/* Probed profiles */
+	GSList		*services;		/* List of btd_service */
 	GSList		*pending;		/* Pending profiles */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
@@ -217,6 +218,17 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 							gboolean reverse);
 
+static gint service_profile_cmp(gconstpointer a, gconstpointer b)
+{
+	struct btd_service *service = (gpointer) a;
+	struct btd_profile *profile = (gpointer) b;
+
+	if (service_get_profile(service) == profile)
+		return 0;
+	else
+		return 1;
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -870,12 +882,14 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void profile_remove(gpointer data, gpointer user_data)
+static void service_remove(struct btd_service *service)
 {
-	struct btd_profile *profile = data;
-	struct btd_device *device = user_data;
+	struct btd_profile *profile = service_get_profile(service);
+	struct btd_device *device = service_get_device(service);
 
+	service_unavailable(service);
 	profile->device_remove(profile, device);
+	btd_service_unref(service);
 }
 
 static gboolean do_disconnect(gpointer user_data)
@@ -900,9 +914,8 @@ int device_block(struct btd_device *device, gboolean update_only)
 	if (device->connected)
 		do_disconnect(device);
 
-	g_slist_foreach(device->profiles, profile_remove, device);
-	g_slist_free(device->profiles);
-	device->profiles = NULL;
+	g_slist_free_full(device->services, (GDestroyNotify) service_remove);
+	device->services = NULL;
 
 	if (!update_only)
 		err = btd_adapter_block_address(device->adapter,
@@ -1156,8 +1169,9 @@ static struct btd_profile *find_connectable_profile(struct btd_device *dev,
 {
 	GSList *l;
 
-	for (l = dev->profiles; l != NULL; l = g_slist_next(l)) {
-		struct btd_profile *p = l->data;
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+		struct btd_profile *p = service_get_profile(service);
 
 		if (!p->connect || !p->remote_uuid)
 			continue;
@@ -1179,6 +1193,7 @@ static gint profile_prio_cmp(gconstpointer a, gconstpointer b)
 static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 							const char *uuid)
 {
+	struct btd_service *service;
 	struct btd_profile *p;
 	GSList *l;
 	int err;
@@ -1208,8 +1223,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 		goto start_connect;
 	}
 
-	for (l = dev->profiles; l != NULL; l = g_slist_next(l)) {
-		p = l->data;
+	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
+		service = l->data;
+		p = service_get_profile(service);
 
 		if (!p->auto_connect)
 			continue;
@@ -2245,9 +2261,8 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (remove_stored)
 		device_remove_stored(device);
 
-	g_slist_foreach(device->profiles, profile_remove, device);
-	g_slist_free(device->profiles);
-	device->profiles = NULL;
+	g_slist_free_full(device->services, (GDestroyNotify) service_remove);
+	device->services = NULL;
 
 	btd_device_unref(device);
 }
@@ -2323,6 +2338,7 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 {
 	struct probe_data *d = user_data;
 	GSList *probe_uuids;
+	struct btd_service *service;
 	int err;
 
 	if (p->device_probe == NULL)
@@ -2333,14 +2349,18 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 
 	probe_uuids = g_slist_append(NULL, (char *) p->remote_uuid);
 
+	service = service_create(d->dev, p);
+
 	err = p->device_probe(p, d->dev, probe_uuids);
 	if (err < 0) {
 		error("%s profile probe failed for %s", p->name, d->addr);
+		btd_service_unref(service);
 		g_slist_free(probe_uuids);
 		return;
 	}
 
-	d->dev->profiles = g_slist_append(d->dev->profiles, p);
+	service_probed(service);
+	d->dev->services = g_slist_append(d->dev->services, service);
 	g_slist_free(probe_uuids);
 }
 
@@ -2348,6 +2368,7 @@ void device_probe_profile(gpointer a, gpointer b)
 {
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
+	struct btd_service *service;
 	GSList *probe_uuids;
 	char addr[18];
 	int err;
@@ -2362,14 +2383,18 @@ void device_probe_profile(gpointer a, gpointer b)
 
 	ba2str(&device->bdaddr, addr);
 
+	service = service_create(device, profile);
+
 	err = profile->device_probe(profile, device, probe_uuids);
 	if (err < 0) {
 		error("%s profile probe failed for %s", profile->name, addr);
+		btd_service_unref(service);
 		g_slist_free(probe_uuids);
 		return;
 	}
 
-	device->profiles = g_slist_append(device->profiles, profile);
+	service_probed(service);
+	device->services = g_slist_append(device->services, service);
 	g_slist_free(probe_uuids);
 
 	if (!profile->auto_connect || !device->general_connect)
@@ -2385,15 +2410,19 @@ void device_remove_profile(gpointer a, gpointer b)
 {
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
+	struct btd_service *service;
+	GSList *l;
 
-	if (!g_slist_find(device->profiles, profile))
+	l = g_slist_find_custom(device->services, profile, service_profile_cmp);
+	if (l == NULL)
 		return;
 
 	device->connected_profiles = g_slist_remove(device->connected_profiles,
 								profile);
-	device->profiles = g_slist_remove(device->profiles, profile);
 
-	profile->device_remove(profile, device);
+	service = l->data;
+	device->services = g_slist_delete_link(device->services, l);
+	service_remove(service);
 }
 
 void device_probe_profiles(struct btd_device *device, GSList *uuids)
@@ -2442,15 +2471,16 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 	device->uuids = NULL;
 	store_device_info(device);
 
-	for (l = device->profiles; l != NULL; l = next) {
-		struct btd_profile *profile = l->data;
+	for (l = device->services; l != NULL; l = next) {
+		struct btd_service *service = l->data;
+		struct btd_profile *profile = service_get_profile(service);
 
 		next = l->next;
 		if (device_match_profile(device, profile, device->uuids))
 			continue;
 
-		profile->device_remove(profile, device);
-		device->profiles = g_slist_remove(device->profiles, profile);
+		device->services = g_slist_delete_link(device->services, l);
+		service_remove(service);
 	}
 }
 
-- 
1.8.1.4

