Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 1/2] Change the experimental Adapter1 ConnectDevice api
 to default to not connecting all profiles, using an optional parameter to
 restore the current behavior.
Date: Thu, 16 Aug 2018 20:29:11 +0000
Message-ID: <BN7PR07MB43059BC3407EA28011668EE79D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 src/adapter.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c24432125..a3ff97571 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3206,6 +3206,7 @@ struct device_connect_data {
 	struct btd_adapter *adapter;
 	bdaddr_t dst;
 	uint8_t dst_type;
+	dbus_bool_t connect_all_profiles;
 	DBusMessage *msg;
 };
=20
@@ -3249,7 +3250,8 @@ static void device_connect_cb(GIOChannel *io, GError =
*gerr, gpointer user_data)
 	}
=20
 	device_discover_services(device);
-	device_wait_for_svc_complete(device, device_browse_cb, NULL);
+	if (data->connect_all_profiles)
+		device_wait_for_svc_complete(device, device_browse_cb, NULL);
=20
 	g_io_channel_unref(io);
 	dbus_message_unref(data->msg);
@@ -3264,7 +3266,8 @@ failed:
 }
=20
 static void device_connect(struct btd_adapter *adapter, const bdaddr_t *ds=
t,
-					uint8_t dst_type, DBusMessage *msg)
+					uint8_t dst_type, DBusMessage *msg,
+					dbus_bool_t connect_all_profiles)
 {
 	struct device_connect_data *data;
 	GIOChannel *io;
@@ -3273,6 +3276,7 @@ static void device_connect(struct btd_adapter *adapte=
r, const bdaddr_t *dst,
 	data->adapter =3D adapter;
 	bacpy(&data->dst, dst);
 	data->dst_type =3D dst_type;
+	data->connect_all_profiles =3D connect_all_profiles;
 	data->msg =3D dbus_message_ref(msg);
=20
 	if (dst_type =3D=3D BDADDR_BREDR)
@@ -3309,6 +3313,7 @@ static DBusMessage *connect_device(DBusConnection *co=
nn,
 	DBusMessageIter iter, subiter, dictiter, value;
 	uint8_t addr_type =3D BDADDR_BREDR;
 	bdaddr_t addr =3D *BDADDR_ANY;
+	dbus_bool_t connect_all_profiles =3D FALSE;
=20
 	DBG("sender %s", dbus_message_get_sender(msg));
=20
@@ -3364,6 +3369,13 @@ static DBusMessage *connect_device(DBusConnection *c=
onn,
 				addr_type =3D BDADDR_LE_RANDOM;
 			else
 				return btd_error_invalid_args(msg);
+		} else if (!strcmp(key, "ConnectAllProfiles")) {
+			if (dbus_message_iter_get_arg_type(&value) !=3D
+							DBUS_TYPE_BOOLEAN)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&value,
+						    &connect_all_profiles);
 		} else {
 			return btd_error_invalid_args(msg);
 		}
@@ -3377,7 +3389,7 @@ static DBusMessage *connect_device(DBusConnection *co=
nn,
 	if (btd_adapter_find_device(adapter, &addr, addr_type))
 		return btd_error_already_exists(msg);
=20
-	device_connect(adapter, &addr, addr_type, msg);
+	device_connect(adapter, &addr, addr_type, msg, connect_all_profiles);
 	return NULL;
 }
=20
--=20
2.17.1
