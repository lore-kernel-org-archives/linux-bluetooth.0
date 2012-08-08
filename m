Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <jprvita@openbossa.org>, Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 5/9] Battery: Add Battery list to btd_device
Date: Wed, 8 Aug 2012 17:26:16 +0300
Message-ID: <1344435980-9866-6-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
References: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add peer battery list to the btd_device. New property added to Device
called Batteries.
---
 doc/device-api.txt         |    5 ++++
 profiles/battery/battery.c |   14 ++++++++--
 src/device.c               |   65 ++++++++++++++++++++++++++++++++++++++++++++
 src/device.h               |    3 ++
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1f0dc96..5d760b1 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -179,3 +179,8 @@ Properties	string Address [readonly]
 			Note that this property can exhibit false-positives
 			in the case of Bluetooth 2.1 (or newer) devices that
 			have disabled Extended Inquiry Response support.
+
+		array{string} Batteries [readonly]
+
+			List of device battery object paths that represents the available
+			batteries on the remote device.
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index a33ac8c..3f79c1f 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -50,6 +50,7 @@ struct battery {
 static GSList *servers;
 
 struct characteristic {
+	char			*path;          /* object path */
 	struct gatt_char	attr;		/* Characteristic */
 	struct battery		*batt;		/* Parent Battery Service */
 	GSList				*desc;	/* Descriptors */
@@ -151,12 +152,12 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (status != 0) {
 		error("Discover all characteristic descriptors failed [%s]: %s",
 					ch->attr.uuid, att_ecode2str(status));
-		return;
+		goto update_char;
 	}
 
 	list = dec_find_info_resp(pdu, len, &format);
 	if (list == NULL)
-		return;
+		goto update_char;
 
 	for (i = 0; i < list->num; i++) {
 		struct descriptor *desc;
@@ -177,6 +178,14 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 	att_data_list_free(list);
+
+update_char:
+	ch->path = g_strdup_printf("%s/BATT-%02X-%04X",
+				device_get_path(ch->batt->dev),
+				ch->ns,
+				ch->description);
+
+	device_add_battery(ch->batt->dev, ch->path);
 }
 
 
@@ -206,7 +215,6 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 			ch->attr.value_handle = c->value_handle;
 			memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
 			ch->batt = batt;
-
 			batt->chars = g_slist_append(batt->chars, ch);
 
 			start = c->value_handle + 1;
diff --git a/src/device.c b/src/device.c
index 45ad1ae..98331db 100644
--- a/src/device.c
+++ b/src/device.c
@@ -124,6 +124,10 @@ struct att_callbacks {
 	gpointer user_data;
 };
 
+struct btd_battery {
+	char *path;
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
@@ -169,6 +173,7 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+	GSList		*batteries;
 };
 
 static uint16_t uuid_list[] = {
@@ -259,6 +264,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->batteries, g_free);
 
 	attio_cleanup(device);
 
@@ -433,6 +439,15 @@ static DBusMessage *get_properties(DBusConnection *conn,
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
@@ -1215,6 +1230,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	g_slist_free(device->drivers);
 	device->drivers = NULL;
 
+	g_slist_free(device->batteries);
+	device->batteries = NULL;
+
 	attrib_client_unregister(device->services);
 
 	btd_device_unref(device);
@@ -3143,3 +3161,50 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
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
+				    "Batteries", DBUS_TYPE_STRING, &batteries,
+				    i);
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
+			batteries_changed(device);
+			return;
+		}
+	}
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

