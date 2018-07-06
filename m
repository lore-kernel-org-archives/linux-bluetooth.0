Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 05 Jul 2018 20:45:51 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH BlueZ 1/3] src: provide MTU on GATT value reads and writes
Message-ID: <XAjZ_u2zxaEC4cpUO3nVGIrc5Pztl1y4DU9fXOAw3bOBKWOCTz7NCVvsxe2AB13K8Kg5RdtxbDNtUvdPvwPayRTMjV1Le4dbtSUA2cnlktg=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt-database.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c8ea231..c34da2d71 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1932,7 +1932,9 @@ static void append_options(DBusMessageIter *iter, voi=
d *user_data)
 {
 =09struct pending_op *op =3D user_data;
 =09const char *path =3D device_get_path(op->device);
+=09struct bt_gatt_server *server;
 =09const char *link;
+=09uint16_t mtu;
=20
 =09switch (op->link_type) {
 =09case BT_ATT_LINK_BREDR:
@@ -1955,6 +1957,11 @@ static void append_options(DBusMessageIter *iter, vo=
id *user_data)
 =09if (op->prep_authorize)
 =09=09dict_append_entry(iter, "prepare-authorize", DBUS_TYPE_BOOLEAN,
 =09=09=09=09=09=09=09&op->prep_authorize);
+
+=09server =3D btd_device_get_gatt_server(op->device);
+=09mtu =3D bt_gatt_server_get_mtu(server);
+
+=09dict_append_entry(iter, "MTU", DBUS_TYPE_UINT16, &mtu);
 }
=20
 static void read_setup_cb(DBusMessageIter *iter, void *user_data)
@@ -2234,8 +2241,6 @@ static void acquire_write_setup(DBusMessageIter *iter=
, void *user_data)
 {
 =09struct pending_op *op =3D user_data;
 =09DBusMessageIter dict;
-=09struct bt_gatt_server *server;
-=09uint16_t mtu;
=20
 =09dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 =09=09=09=09=09DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -2246,12 +2251,6 @@ static void acquire_write_setup(DBusMessageIter *ite=
r, void *user_data)
=20
 =09append_options(&dict, op);
=20
-=09server =3D btd_device_get_gatt_server(op->device);
-
-=09mtu =3D bt_gatt_server_get_mtu(server);
-
-=09dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
-
 =09dbus_message_iter_close_container(iter, &dict);
 }
=20
@@ -2320,8 +2319,6 @@ static void acquire_notify_setup(DBusMessageIter *ite=
r, void *user_data)
 {
 =09DBusMessageIter dict;
 =09struct pending_op *op =3D user_data;
-=09struct bt_gatt_server *server;
-=09uint16_t mtu;
=20
 =09dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 =09=09=09=09=09DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -2332,12 +2329,6 @@ static void acquire_notify_setup(DBusMessageIter *it=
er, void *user_data)
=20
 =09append_options(&dict, op);
=20
-=09server =3D btd_device_get_gatt_server(op->device);
-
-=09mtu =3D bt_gatt_server_get_mtu(server);
-
-=09dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
-
 =09dbus_message_iter_close_container(iter, &dict);
 }
=20
--=20
2.18.0

