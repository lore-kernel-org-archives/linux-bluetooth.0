Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 5/9] Battery: Add Battery list to btd_device
Date: Tue, 17 Jul 2012 16:59:50 +0300
Message-ID: <1342533594-10413-6-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1342533594-10413-1-git-send-email-chen.ganir@ti.com>
References: <1342533594-10413-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add peer battery list to the btd_device. New property added to Device
called Batteries.
---
 doc/device-api.txt                   |    5 +++
 profiles/batterystate/batterystate.c |    6 ++++
 src/device.c                         |   66 ++++++++++++++++++++++++++++++++++
 src/device.h                         |    3 ++
 4 files changed, 80 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 0f34210..f8b1584 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -213,3 +213,8 @@ Properties	string Address [readonly]
 			Note that this property can exhibit false-positives
 			in the case of Bluetooth 2.1 (or newer) devices that
 			have disabled Extended Inquiry Response support.
+
+		array{string} Batteries [readonly]
+
+			List of device battery object paths that represents the available
+			batteries on the remote device.
diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
index 49e0bc7..ab6ee53 100644
--- a/profiles/batterystate/batterystate.c
+++ b/profiles/batterystate/batterystate.c
@@ -50,6 +50,7 @@ struct battery {
 static GSList *servers;
 
 struct characteristic {
+	char			*path;          /* object path */
 	struct gatt_char	attr;		/* Characteristic */
 	struct battery		*batt;		/* Parent Battery Service */
 	GSList				*desc;	/* Descriptors */
@@ -215,6 +216,11 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 			ch->attr.value_handle = c->value_handle;
 			memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
 			ch->batt = batt;
+			ch->path = g_strdup_printf("%s/BATT%04X",
+						device_get_path(batt->dev),
+						c->handle);
+
+			device_add_battery(batt->dev, ch->path);
 
 			batt->chars = g_slist_append(batt->chars, ch);
 
diff --git a/src/device.c b/src/device.c
index 09518f3..6ba8522 100644
--- a/src/device.c
+++ b/src/device.c
@@ -126,6 +126,10 @@ struct att_callbacks {
 	gpointer user_data;
 };
 
+struct btd_battery {
+	char *path;
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
@@ -171,6 +175,7 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+	GSList		*batteries;
 };
 
 static uint16_t uuid_list[] = {
@@ -261,6 +266,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->batteries, g_free);
 
 	att_cleanup(device);
 
@@ -432,6 +438,15 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	ptr = adapter_get_path(adapter);
 	dict_append_entry(&dict, "Adapter", DBUS_TYPE_OBJECT_PATH, &ptr);
 
+	/* Batteries */
+	str = g_new0(char *, g_slist_length(device->batteries) + 1);
+	for (i = 0, l = device->batteries; l; l = l->next, i++) {
+		struct btd_battery *b = l->data;
+		str[i] = b->path;
+	}
+	dict_append_array(&dict, "Batteries", DBUS_TYPE_OBJECT_PATH, &str, i);
+	g_free(str);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -1218,6 +1233,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	g_slist_free(device->drivers);
 	device->drivers = NULL;
 
+	g_slist_free(device->batteries);
+	device->batteries = NULL;
+
 	attrib_client_unregister(device->services);
 
 	btd_device_unref(device);
@@ -3163,3 +3181,51 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 	device_set_product(device, product_id);
 	device_set_version(device, product_ver);
 }
+
+static void batteries_changed(struct btd_device *device)
+{
+	DBusConnection *conn = get_dbus_connection();
+	char **batteries;
+	GSList *l;
+	int i;
+
+	batteries = g_new0(char *, g_slist_length(device->batteries) + 1);
+	for (i = 0, l = device->batteries; l; l = l->next, i++) {
+		struct btd_battery *batt = l->data;
+		batteries[i] = batt->path;
+	}
+
+	emit_array_property_changed(conn, device->path, DEVICE_INTERFACE,
+					"Batteries", DBUS_TYPE_STRING, &batteries,
+					i);
+
+	g_free(batteries);
+}
+
+void device_add_battery(struct btd_device *device, char *path)
+{
+	struct btd_battery *batt;
+
+	batt = g_new0(struct btd_battery, 1);
+	batt->path = g_strdup(path);
+	device->batteries = g_slist_append(device->batteries, batt);
+	batteries_changed(device);
+}
+
+void device_remove_battery(struct btd_device *device, char *path)
+{
+	GSList *l;
+
+	for (l = device->batteries; l; l = l->next) {
+		struct btd_battery *b = l->data;
+
+		if (g_strcmp0(path, b->path) == 0) {
+			device->batteries = g_slist_remove(device->batteries, b);
+			g_free(b->path);
+			g_free(b);
+			return;
+		}
+	}
+
+	batteries_changed(device);
+}
diff --git a/src/device.h b/src/device.h
index 26e17f7..db71a8a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -126,3 +126,6 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
+
+void device_add_battery(struct btd_device *device, char *path);
+void device_remove_battery(struct btd_device *device, char *path);
-- 
1.7.9.5

