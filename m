Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 06 Jul 2018 19:23:59 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v2 BlueZ 1/3] src: provide MTU on GATT value reads and writes
Message-ID: <sm7FuU2Jm6ho8hX9S57lb9nA9SC_p-XR3kNb3De0on-YbFe7gLbxkxs3ux1Ib5ltx1g_HVIxCG_Qp0XlDE2MdsdaWAn7WGoxGYqlY4B2KNc=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt-database.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c8ea231..287074f0a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1932,7 +1932,9 @@ static void append_options(DBusMessageIter *iter, voi=
d *user_data)
 {
        struct pending_op *op =3D user_data;
        const char *path =3D device_get_path(op->device);
+       struct bt_gatt_server *server;
        const char *link;
+       uint16_t mtu;
=20
        switch (op->link_type) {
        case BT_ATT_LINK_BREDR:
@@ -1955,6 +1957,14 @@ static void append_options(DBusMessageIter *iter, vo=
id *user_data)
        if (op->prep_authorize)
                dict_append_entry(iter, "prepare-authorize", DBUS_TYPE_BOOL=
EAN,
                                                        &op->prep_authorize=
);
+
+       server =3D btd_device_get_gatt_server(op->device);
+       mtu =3D bt_gatt_server_get_mtu(server);
+
+       dict_append_entry(iter, "mtu", DBUS_TYPE_UINT16, &mtu);
+
+        /* deprecated */
+       dict_append_entry(iter, "MTU", DBUS_TYPE_UINT16, &mtu);
 }
=20
 static void read_setup_cb(DBusMessageIter *iter, void *user_data)
@@ -2234,8 +2244,6 @@ static void acquire_write_setup(DBusMessageIter *iter=
, void *user_data)
 {
        struct pending_op *op =3D user_data;
        DBusMessageIter dict;
-       struct bt_gatt_server *server;
-       uint16_t mtu;
=20
        dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
                                        DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRIN=
G
@@ -2246,12 +2254,6 @@ static void acquire_write_setup(DBusMessageIter *ite=
r, void *user_data)
=20
        append_options(&dict, op);
=20
-       server =3D btd_device_get_gatt_server(op->device);
-
-       mtu =3D bt_gatt_server_get_mtu(server);
-
-       dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
-
        dbus_message_iter_close_container(iter, &dict);
 }
=20
@@ -2320,8 +2322,6 @@ static void acquire_notify_setup(DBusMessageIter *ite=
r, void *user_data)
 {
        DBusMessageIter dict;
        struct pending_op *op =3D user_data;
-       struct bt_gatt_server *server;
-       uint16_t mtu;
=20
        dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
                                        DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRIN=
G
@@ -2332,12 +2332,6 @@ static void acquire_notify_setup(DBusMessageIter *it=
er, void *user_data)
=20
        append_options(&dict, op);
=20
-       server =3D btd_device_get_gatt_server(op->device);
-
-       mtu =3D bt_gatt_server_get_mtu(server);
-
-       dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
-
        dbus_message_iter_close_container(iter, &dict);
 }
=20
--
2.18.0

