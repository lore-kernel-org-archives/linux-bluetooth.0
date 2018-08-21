Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v2 1/2] Allow Adapter1 ConnectDevice method to connect a
 limited set of service UUIDs
Date: Tue, 21 Aug 2018 15:37:51 +0000
Message-ID: <BN7PR07MB430521CFEF873D600804B73A9D310@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c24432125..33c25a49b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2298,7 +2298,7 @@ done:
 	return btd_error_failed(msg, strerror(-err));
 }
=20
-static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *f=
ilter)
+static bool get_uuids_from_iter(DBusMessageIter *value, GSList **uuids)
 {
 	DBusMessageIter arriter;
=20
@@ -2323,7 +2323,7 @@ static bool parse_uuids(DBusMessageIter *value, struc=
t discovery_filter *filter)
 		bt_uuid_to_uuid128(&uuid, &u128);
 		bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
=20
-		filter->uuids =3D g_slist_prepend(filter->uuids, strdup(uuidstr));
+		*uuids =3D g_slist_prepend(*uuids, strdup(uuidstr));
=20
 		dbus_message_iter_next(&arriter);
 	}
@@ -2331,6 +2331,11 @@ static bool parse_uuids(DBusMessageIter *value, stru=
ct discovery_filter *filter)
 	return true;
 }
=20
+static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *f=
ilter)
+{
+	return get_uuids_from_iter(value, &filter->uuids);
+}
+
 static bool parse_rssi(DBusMessageIter *value, struct discovery_filter *fi=
lter)
 {
 	if (dbus_message_iter_get_arg_type(value) !=3D DBUS_TYPE_INT16)
@@ -3206,15 +3211,77 @@ struct device_connect_data {
 	struct btd_adapter *adapter;
 	bdaddr_t dst;
 	uint8_t dst_type;
+	GSList *uuids;
 	DBusMessage *msg;
 };
=20
+static GSList *find_matching_strings(GSList *list1, GSList *list2)
+{
+	GSList *l, *matches =3D NULL;
+
+	if (!list1 || !list2)
+		return NULL;
+
+	for (l =3D list1; l; l =3D g_slist_next(l)) {
+		char *item =3D l->data;
+
+		if (g_slist_find_custom(list2, item, g_strcmp))
+			matches =3D g_slist_append(matches, item);
+	}
+	return matches;
+}
+
+static GSList *device_get_services(struct btd_device *dev, GSList *uuids)
+{
+	GSList *l, *services =3D NULL;
+
+	if (uuids =3D=3D NULL)
+		return NULL;
+
+	for (l =3D uuids; l; l =3D g_slist_next(l)) {
+		char *uuid =3D l->data;
+		struct btd_service *service =3D btd_device_get_service(dev,
+								     uuid);
+		services =3D g_slist_append(services, service);
+	}
+
+	return services;
+}
+
+static GSList *device_get_matching_services(struct btd_device *dev,
+					    GSList *uuids)
+{
+	GSList *matching_uuids =3D NULL, *services =3D NULL;
+	GSList *device_uuids =3D btd_device_get_uuids(dev);
+
+	matching_uuids =3D find_matching_strings(uuids,
+					       device_uuids);
+	services =3D device_get_services(dev, matching_uuids);
+	g_slist_free(matching_uuids);
+
+	return services;
+}
+
 static void device_browse_cb(struct btd_device *dev, int err, void *user_d=
ata)
 {
 	DBG("err %d (%s)", err, strerror(-err));
=20
-	if (!err)
-		btd_device_connect_services(dev, NULL);
+	if (!err) {
+		GSList *services;
+
+		if (!user_data) {
+			btd_device_connect_services(dev, NULL);
+			return;
+		}
+
+		services =3D device_get_matching_services(dev, user_data);
+		if (services) {
+			btd_device_connect_services(dev, services);
+			g_slist_free(services);
+		} else
+			DBG("no matching services");
+		g_slist_free(user_data);
+	}
 }
=20
 static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_=
data)
@@ -3249,7 +3316,7 @@ static void device_connect_cb(GIOChannel *io, GError =
*gerr, gpointer user_data)
 	}
=20
 	device_discover_services(device);
-	device_wait_for_svc_complete(device, device_browse_cb, NULL);
+	device_wait_for_svc_complete(device, device_browse_cb, data->uuids);
=20
 	g_io_channel_unref(io);
 	dbus_message_unref(data->msg);
@@ -3264,7 +3331,7 @@ failed:
 }
=20
 static void device_connect(struct btd_adapter *adapter, const bdaddr_t *ds=
t,
-					uint8_t dst_type, DBusMessage *msg)
+			   uint8_t dst_type, GSList *uuids, DBusMessage *msg)
 {
 	struct device_connect_data *data;
 	GIOChannel *io;
@@ -3273,6 +3340,7 @@ static void device_connect(struct btd_adapter *adapte=
r, const bdaddr_t *dst,
 	data->adapter =3D adapter;
 	bacpy(&data->dst, dst);
 	data->dst_type =3D dst_type;
+	data->uuids =3D uuids;
 	data->msg =3D dbus_message_ref(msg);
=20
 	if (dst_type =3D=3D BDADDR_BREDR)
@@ -3309,6 +3377,7 @@ static DBusMessage *connect_device(DBusConnection *co=
nn,
 	DBusMessageIter iter, subiter, dictiter, value;
 	uint8_t addr_type =3D BDADDR_BREDR;
 	bdaddr_t addr =3D *BDADDR_ANY;
+	GSList *uuids =3D NULL;
=20
 	DBG("sender %s", dbus_message_get_sender(msg));
=20
@@ -3364,6 +3433,14 @@ static DBusMessage *connect_device(DBusConnection *c=
onn,
 				addr_type =3D BDADDR_LE_RANDOM;
 			else
 				return btd_error_invalid_args(msg);
+		} else if (!strcmp(key, "UUIDs")) {
+			if ((dbus_message_iter_get_arg_type(&value) !=3D
+			     DBUS_TYPE_ARRAY) ||
+			    (dbus_message_iter_get_element_type(&value) !=3D
+			     DBUS_TYPE_STRING))
+				return btd_error_invalid_args(msg);
+			if (!get_uuids_from_iter(&value, &uuids))
+				return btd_error_invalid_args(msg);
 		} else {
 			return btd_error_invalid_args(msg);
 		}
@@ -3377,7 +3454,7 @@ static DBusMessage *connect_device(DBusConnection *co=
nn,
 	if (btd_adapter_find_device(adapter, &addr, addr_type))
 		return btd_error_already_exists(msg);
=20
-	device_connect(adapter, &addr, addr_type, msg);
+	device_connect(adapter, &addr, addr_type, uuids, msg);
 	return NULL;
 }
=20
--=20
2.17.1
