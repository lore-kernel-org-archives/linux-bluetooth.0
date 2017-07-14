Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jonah Petri <jonah@sense.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
Message-Id: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
Date: Fri, 14 Jul 2017 11:56:03 -0400
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It can be useful for programs using GATT to be aware of the maximum
transmittable packet size, as negotiated by bluetoothd.  This change
exposes the negotiated MTU over D-Bus, if such a negotiation has
occurred.
---
 client/main.c            |  1 +
 doc/device-api.txt       |  5 +++++
 src/device.c             | 31 +++++++++++++++++++++++++++++++
 src/shared/gatt-server.c | 15 +++++++++++++++
 src/shared/gatt-server.h |  3 +++
 5 files changed, 55 insertions(+)

diff --git a/client/main.c b/client/main.c
index 255cbd5..6435674 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1372,6 +1372,7 @@ static void cmd_info(const char *arg)
 	print_property(proxy, "ServiceData");
 	print_property(proxy, "RSSI");
 	print_property(proxy, "TxPower");
+	print_property(proxy, "NegotiatedMTU");
 }
=20
 static void pair_reply(DBusMessage *message, void *user_data)
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 13b2881..908616b 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -234,3 +234,8 @@ Properties	string Address [readonly]
 		array{byte} AdvertisingFlags [readonly, experimental]
=20
 			The Advertising Data Flags of the remote device.
+
+		int16 NegotiatedMTU [readonly, optional, experimental]
+
+			The ATT MTU negotiated with the connected host.
+			Available only once MTU negotiation is complete.
diff --git a/src/device.c b/src/device.c
index 8693eb8..1b171ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -930,6 +930,35 @@ static gboolean dev_property_exists_tx_power(const =
GDBusPropertyTable *property,
 	return TRUE;
 }
=20
+static gboolean dev_property_get_negotiated_mtu(
+					const GDBusPropertyTable * =
property,
+					DBusMessageIter *iter, void =
*data)
+{
+	const struct btd_device *dev =3D data;
+	dbus_int16_t val =3D 0;
+	int err;
+
+	err =3D bt_gatt_server_get_negotiated_mtu(dev->server, &val);
+	if (err !=3D 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
+
+	return TRUE;
+}
+
+static gboolean dev_property_exists_negotiated_mtu(
+					const GDBusPropertyTable * =
property,
+					void *data)
+{
+	const struct btd_device *dev =3D data;
+	int err;
+
+	err =3D bt_gatt_server_get_negotiated_mtu(dev->server, NULL);
+
+	return err =3D=3D 0;
+}
+
 static gboolean
 dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void =
*data)
@@ -2561,6 +2590,8 @@ static const GDBusPropertyTable =
device_properties[] =3D {
 				NULL, dev_property_service_data_exist },
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
+	{ "NegotiatedMTU", "n", dev_property_get_negotiated_mtu, NULL,
+					=
dev_property_exists_negotiated_mtu },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, =
NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist,
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 79e01c8..2727f09 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -89,6 +89,7 @@ struct bt_gatt_server {
 	struct bt_att *att;
 	int ref_count;
 	uint16_t mtu;
+	bool mtu_negotiated;
=20
 	unsigned int mtu_id;
 	unsigned int read_by_grp_type_id;
@@ -1378,12 +1379,25 @@ static void exchange_mtu_cb(uint8_t opcode, =
const void *pdu,
=20
 	/* Set MTU to be the minimum */
 	server->mtu =3D final_mtu;
+	server->mtu_negotiated =3D true;
 	bt_att_set_mtu(server->att, final_mtu);
=20
 	util_debug(server->debug_callback, server->debug_data,
 			"MTU exchange complete, with MTU: %u", =
final_mtu);
 }
=20
+int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server =
*server,
+				int16_t *mtu)
+{
+	if (!server || !server->mtu_negotiated)
+		return -1;
+
+	if (mtu)
+		*mtu =3D server->mtu;
+
+	return 0;
+}
+
 static bool gatt_server_register_att_handlers(struct bt_gatt_server =
*server)
 {
 	/* Exchange MTU */
@@ -1493,6 +1507,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct =
gatt_db *db,
 	server->db =3D gatt_db_ref(db);
 	server->att =3D bt_att_ref(att);
 	server->mtu =3D MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
+	server->mtu_negotiated =3D false;
 	server->max_prep_queue_len =3D DEFAULT_MAX_PREP_QUEUE_LEN;
 	server->prep_queue =3D queue_new();
=20
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index 0e480e1..0b99da5 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -31,6 +31,9 @@ struct bt_gatt_server *bt_gatt_server_new(struct =
gatt_db *db,
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server =
*server);
 void bt_gatt_server_unref(struct bt_gatt_server *server);
=20
+int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server =
*server,
+					int16_t *mtu);
+
 typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_server_debug_func_t)(const char *str, void =
*user_data);
 typedef void (*bt_gatt_server_conf_func_t)(void *user_data);
--=20
2.10.0


