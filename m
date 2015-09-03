Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/2] core/gatt: Cleanup service probe
Date: Thu,  3 Sep 2015 15:22:51 +0300
Message-Id: <1441282972-22182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This cleanup code related to service probe making it use a single
function, because of that now all driver must implement device_probe in
order for the service probe to work properly.

In addition to that a new flag called external was introduced to
btd_profile to be possible to distinguish whether it is a internal
plugin or external client, this was needed in order to decide if an
attribute should be claimed which whould prevent it to be exported over
D-Bus.
---
 src/device.c        | 167 +++++++++++++++-------------------------------------
 src/gatt-database.c |  30 ++++++++--
 src/profile.c       |  11 +++-
 src/profile.h       |   1 +
 4 files changed, 84 insertions(+), 125 deletions(-)

diff --git a/src/device.c b/src/device.c
index bdea55b..999f09f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2814,14 +2814,6 @@ static void device_add_uuids(struct btd_device *device, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
-struct gatt_probe_data {
-	struct btd_device *dev;
-	bool all_services;
-	GSList *uuids;
-	struct gatt_db_attribute *cur_attr;
-	char cur_uuid[MAX_LEN_UUID_STR];
-};
-
 static bool device_match_profile(struct btd_device *device,
 					struct btd_profile *profile,
 					GSList *uuids)
@@ -2836,99 +2828,42 @@ static bool device_match_profile(struct btd_device *device,
 	return true;
 }
 
-static void dev_probe_gatt(struct btd_profile *p, void *user_data)
+static void probe_gatt_profile(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct gatt_probe_data *data = user_data;
+	struct btd_device *device = user_data;
 	struct btd_service *service;
-
-	if (!p->remote_uuid || bt_uuid_strcmp(p->remote_uuid, data->cur_uuid))
-		return;
-
-	/*
-	 * Add device to auto connect list in case the driver has the auto
-	 * connect flag set.
-	 * NOTE: This should work regardless if a service is created and
-	 * probed since external drivers don't need to maintain any
-	 * states they don't implement device_probe callback.
-	 */
-	if (p->auto_connect)
-		device_set_auto_connect(data->dev, TRUE);
-
-	if (p->device_probe == NULL)
-		return;
-
-	service = service_create(data->dev, p);
-	if (!service)
-		return;
-
-	if (service_probe(service) < 0) {
-		btd_service_unref(service);
-		return;
-	}
-
-	/* Mark service as active to skip discovering it again */
-	gatt_db_service_set_active(data->cur_attr, true);
-
-	/* Mark service as claimed */
-	gatt_db_service_set_claimed(data->cur_attr, true);
-
-	data->dev->services = g_slist_append(data->dev->services, service);
-}
-
-static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
-							void *user_data)
-{
-	struct gatt_probe_data *data = user_data;
+	struct btd_profile *profile;
 	bt_uuid_t uuid;
-	GSList *l = NULL;
+	char uuid_str[MAX_LEN_UUID_STR];
+	GSList *l;
 
 	gatt_db_attribute_get_service_uuid(attr, &uuid);
-	bt_uuid_to_string(&uuid, data->cur_uuid, sizeof(data->cur_uuid));
-
-	data->cur_attr = attr;
-
-	/*
-	 * If we're probing for all services, store the UUID since device->uuids
-	 * was cleared.
-	 */
-	if (data->all_services)
-		data->uuids = g_slist_append(data->uuids,
-						g_strdup(data->cur_uuid));
-
-	/* Don't probe the profiles if a matching service already exists. */
-	if (find_service_with_uuid(data->dev->services, data->cur_uuid)) {
-		/* Mark service as active to skip discovering it again */
-		gatt_db_service_set_active(data->cur_attr, true);
-		/* Mark the service as claimed by the existing profile. */
-		gatt_db_service_set_claimed(data->cur_attr, true);
-		return;
-	}
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 
-	btd_profile_foreach(dev_probe_gatt, data);
+	/* Add UUID and probe service */
+	btd_device_add_uuid(device, uuid_str);
 
-	if (data->all_services)
+	/* Check if service was probed */
+	l = find_service_with_uuid(device->services, uuid_str);
+	if (!l)
 		return;
 
-	l = g_slist_append(l, g_strdup(data->cur_uuid));
-	device_add_uuids(data->dev, l);
-}
-
-static void device_probe_gatt_profile(struct btd_device *device,
-						struct gatt_db_attribute *attr)
-{
-	struct gatt_probe_data data;
+	/* Mark service as active to skip discovering it again */
+	gatt_db_service_set_active(attr, true);
 
-	memset(&data, 0, sizeof(data));
+	service = l->data;
+	profile = btd_service_get_profile(service);
 
-	data.dev = device;
+	/* Don't claim attributes of external profiles */
+	if (profile->external)
+		return;
 
-	dev_probe_gatt_profile(attr, &data);
-	g_slist_free_full(data.uuids, g_free);
+	/* Mark the service as claimed by the existing profile. */
+	gatt_db_service_set_claimed(attr, true);
 }
 
 static void device_probe_gatt_profiles(struct btd_device *device)
 {
-	struct gatt_probe_data data;
 	char addr[18];
 
 	ba2str(&device->bdaddr, addr);
@@ -2938,16 +2873,7 @@ static void device_probe_gatt_profiles(struct btd_device *device)
 		return;
 	}
 
-	memset(&data, 0, sizeof(data));
-
-	data.dev = device;
-	data.all_services = true;
-
-	gatt_db_foreach_service(device->db, NULL, dev_probe_gatt_profile,
-									&data);
-
-	device_add_uuids(device, data.uuids);
-	g_slist_free_full(data.uuids, g_free);
+	gatt_db_foreach_service(device->db, NULL, probe_gatt_profile, device);
 }
 
 static void device_accept_gatt_profiles(struct btd_device *device)
@@ -3028,9 +2954,7 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
 			service_accept(l->data);
 	}
 
-	device_probe_gatt_profile(device, attr);
-
-	store_device_info(device);
+	btd_device_add_uuid(device, uuid_str);
 
 	btd_gatt_client_service_added(device->client_dbus, attr);
 
@@ -3645,45 +3569,52 @@ struct probe_data {
 	GSList *uuids;
 };
 
-static void dev_probe(struct btd_profile *p, void *user_data)
+static struct btd_service *probe_service(struct btd_device *device,
+						struct btd_profile *profile,
+						GSList *uuids)
 {
-	struct probe_data *d = user_data;
 	struct btd_service *service;
 
-	if (p->device_probe == NULL)
-		return;
+	if (profile->device_probe == NULL)
+		return NULL;
 
-	if (!device_match_profile(d->dev, p, d->uuids))
-		return;
+	if (!device_match_profile(device, profile, uuids))
+		return NULL;
 
-	service = service_create(d->dev, p);
+	service = service_create(device, profile);
 
-	if (service_probe(service) < 0) {
+	if (service_probe(service)) {
 		btd_service_unref(service);
-		return;
+		return NULL;
 	}
 
-	d->dev->services = g_slist_append(d->dev->services, service);
+	if (profile->auto_connect)
+		device_set_auto_connect(device, TRUE);
+
+	return service;
 }
 
-void device_probe_profile(gpointer a, gpointer b)
+static void dev_probe(struct btd_profile *p, void *user_data)
 {
-	struct btd_device *device = a;
-	struct btd_profile *profile = b;
+	struct probe_data *d = user_data;
 	struct btd_service *service;
 
-	if (profile->device_probe == NULL)
+	service = probe_service(d->dev, p, d->uuids);
+	if (!service)
 		return;
 
-	if (!device_match_profile(device, profile, device->uuids))
-		return;
+	d->dev->services = g_slist_append(d->dev->services, service);
+}
 
-	service = service_create(device, profile);
+void device_probe_profile(gpointer a, gpointer b)
+{
+	struct btd_device *device = a;
+	struct btd_profile *profile = b;
+	struct btd_service *service;
 
-	if (service_probe(service) < 0) {
-		btd_service_unref(service);
+	service = probe_service(device, profile, device->uuids);
+	if (!service)
 		return;
-	}
 
 	device->services = g_slist_append(device->services, service);
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 97cef77..774b19e 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -43,6 +43,7 @@
 #include "gatt-database.h"
 #include "dbus-common.h"
 #include "profile.h"
+#include "service.h"
 
 #ifndef ATT_CID
 #define ATT_CID 4
@@ -1074,7 +1075,7 @@ static void client_disconnect_cb(DBusConnection *conn, void *user_data)
 	service_remove_helper(user_data);
 }
 
-static void service_remove(void *data)
+static void remove_service(void *data)
 {
 	struct external_service *service = data;
 
@@ -1453,7 +1454,7 @@ static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 
 	DBG("Proxy removed - removing service: %s", service->path);
 
-	service_remove(service);
+	remove_service(service);
 }
 
 static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
@@ -2142,10 +2143,10 @@ reply:
 	service->reg = NULL;
 
 	if (fail)
-		service_remove(service);
+		remove_service(service);
 }
 
-static struct external_service *service_create(DBusConnection *conn,
+static struct external_service *create_service(DBusConnection *conn,
 					DBusMessage *msg, const char *path)
 {
 	struct external_service *service;
@@ -2223,7 +2224,7 @@ static DBusMessage *manager_register_service(DBusConnection *conn,
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
 		return btd_error_invalid_args(msg);
 
-	service = service_create(conn, msg, path);
+	service = create_service(conn, msg, path);
 	if (!service)
 		return btd_error_failed(msg, "Failed to register service");
 
@@ -2279,6 +2280,22 @@ static void profile_exited(DBusConnection *conn, void *user_data)
 	profile_free(profile);
 }
 
+static int profile_device_probe(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	DBG("%s probed", p->name);
+
+	return 0;
+}
+
+static void profile_device_remove(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	DBG("%s removed", p->name);
+}
+
 static int profile_add(struct external_profile *profile, const char *uuid)
 {
 	struct btd_profile *p;
@@ -2302,7 +2319,10 @@ static int profile_add(struct external_profile *profile, const char *uuid)
 		return -ENOMEM;
 	}
 
+	p->device_probe = profile_device_probe;
+	p->device_remove = profile_device_remove;
 	p->auto_connect = true;
+	p->external = true;
 
 	queue_push_tail(profile->profiles, p);
 
diff --git a/src/profile.c b/src/profile.c
index f54749e..70ee4c1 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -719,13 +719,19 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 
 int btd_profile_register(struct btd_profile *profile)
 {
-	profiles = g_slist_append(profiles, profile);
+	if (profile->external)
+		ext_profiles = g_slist_append(ext_profiles, profile);
+	else
+		profiles = g_slist_append(profiles, profile);
 	return 0;
 }
 
 void btd_profile_unregister(struct btd_profile *profile)
 {
-	profiles = g_slist_remove(profiles, profile);
+	if (profile->external)
+		ext_profiles = g_slist_remove(ext_profiles, profile);
+	else
+		profiles = g_slist_remove(profiles, profile);
 }
 
 static struct ext_profile *find_ext_profile(const char *owner,
@@ -2291,6 +2297,7 @@ static struct ext_profile *create_ext(const char *owner, const char *path,
 	p->name = ext->name;
 	p->local_uuid = ext->service ? ext->service : ext->uuid;
 	p->remote_uuid = ext->remote_uuid;
+	p->external = true;
 
 	if (ext->enable_server) {
 		p->adapter_probe = ext_adapter_probe;
diff --git a/src/profile.h b/src/profile.h
index f5a3ded..4448a2a 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -35,6 +35,7 @@ struct btd_profile {
 	const char *remote_uuid;
 
 	bool auto_connect;
+	bool external;
 
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
-- 
2.4.3

