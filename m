Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 3/4] device: Appearance characteristic from GAP service
Date: Tue, 27 Mar 2012 09:29:37 -0400
Message-Id: <1332854978-26072-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After searching for primary services, the appearance characteristic is
read from GAP service and saved in "appearance" file. Running
GetProperty in device interface, will show the Class equals to zero
(meaning the device is discovered over GATT and has an Appearance
characteristic) and the respective icon.
---
 src/device.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index eab7e4c..4243263 100644
--- a/src/device.c
+++ b/src/device.c
@@ -73,6 +73,9 @@
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
+#define GAP_SVC_UUID "00001800-0000-1000-8000-00805f9b34fb"
+#define APPEARANCE_CHR_UUID 0x2a01
+
 struct btd_disconnect_data {
 	guint id;
 	disconnect_watch watch;
@@ -319,9 +322,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	bdaddr_t src;
 	char name[MAX_NAME_LENGTH + 1], srcaddr[18], dstaddr[18];
 	char **str;
-	const char *ptr;
+	const char *ptr, *icon = NULL;
 	dbus_bool_t boolean;
 	uint32_t class;
+	uint16_t app;
 	int i;
 	GSList *l;
 
@@ -363,15 +367,19 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	/* Class */
 	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
-		const char *icon = class_to_icon(class);
+		icon = class_to_icon(class);
 
 		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
+	} else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0) {
+		/* Appearance */
+		icon = gap_appearance_to_icon(app);
+		class = 0;
 
-		if (icon)
-			dict_append_entry(&dict, "Icon",
-						DBUS_TYPE_STRING, &icon);
+		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
 	}
 
+	dict_append_entry(&dict, "Icon", DBUS_TYPE_STRING, &icon);
+
 	/* Vendor */
 	if (device->vendor)
 		dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
@@ -1784,10 +1792,50 @@ done:
 	return FALSE;
 }
 
+static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device->adapter;
+	struct att_data_list *list =  NULL;
+	uint16_t app;
+	bdaddr_t src;
+	uint8_t *atval;
+
+	if (status != 0) {
+		DBG("Read characteristics by UUID failed: %s\n",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		goto done;
+
+	if (list->len != 4) {
+		DBG("Appearance value: invalid data");
+		goto done;
+	}
+
+	/* A device shall have only one instance of the
+	Appearance characteristic. */
+	atval = list->data[0] + 2; /* skip handle value */
+	app = att_get_u16(atval);
+
+	adapter_get_address(adapter, &src);
+	write_remote_appearance(&src, &device->bdaddr, app);
+
+done:
+	att_data_list_free(list);
+	if (device->attios == NULL && device->attios_offline == NULL)
+		att_cleanup(device);
+}
+
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
+	struct gatt_primary *gap_prim = NULL;
 	GSList *l, *uuids = NULL;
 
 	if (status) {
@@ -1804,13 +1852,25 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
+
+		if (strcmp(prim->uuid, GAP_SVC_UUID) == 0)
+			gap_prim = prim;
+
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
-	if (device->attios == NULL && device->attios_offline == NULL)
+	if (gap_prim) {
+		/* Read appearance characteristic */
+		bt_uuid_t uuid;
+
+		bt_uuid16_create(&uuid, APPEARANCE_CHR_UUID);
+
+		gatt_read_char_by_uuid(device->attrib, gap_prim->range.start,
+			gap_prim->range.end, &uuid, appearance_cb, device);
+	} else if (device->attios == NULL && device->attios_offline == NULL)
 		att_cleanup(device);
 
 	g_slist_free(uuids);
-- 
1.7.5.4

