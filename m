Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jonah Petri <jonah@sense.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
Message-Id: <53567ACD-6033-4ED3-92C2-C91E13DD7B73@sense.com>
Date: Fri, 28 Jul 2017 13:16:11 -0400
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It can be useful for programs using GATT to be aware of the maximum
transmittable attribute size, as negotiated by bluetoothd.  This change
exposes the negotiated size over D-Bus, if such a negotiation has
occurred.
---
 attrib/gattrib.c         |  6 +++++-
 doc/device-api.txt       | 11 +++++++++++
 src/device.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 src/shared/att.c         | 15 +++++++++++++++
 src/shared/gatt-server.c |  1 +
 src/shared/gatt-server.h |  3 +++
 6 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 2e1e39a..f080b6b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -468,7 +468,11 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
=20
 	attrib->buflen =3D mtu;
=20
-	return bt_att_set_mtu(attrib->att, mtu);
+	if (bt_att_set_mtu(attrib->att, mtu)) {
+		bt_att_set_mtu_negotiated(attrib->att, true);
+		return true;
+	} else
+		return false;
 }
=20
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 13b2881..fc04011 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -234,3 +234,14 @@ Properties	string Address [readonly]
 		array{byte} AdvertisingFlags [readonly, experimental]
=20
 			The Advertising Data Flags of the remote device.
+
+		int16 NegotiatedMaxAttributeSize [readonly,
+		                                  optional,
+		                                  experimental]
+
+			The maximum supported byte size of attributes, =
as
+			negotiated between this host and the remote =
device.
+			This attribute is only available once the =
negotiation
+			is complete.  If the attribute is not available,
+			clients should assume the default maximum size =
for
+			the underlying technology, e.g. 20 bytes for =
BTLE.
diff --git a/src/device.c b/src/device.c
index 8693eb8..cd3983b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -92,6 +92,8 @@
 #define GATT_INCLUDE_UUID_STR "2802"
 #define GATT_CHARAC_UUID_STR "2803"
=20
+#define ATT_PACKET_HEADER_SIZE 3
+
 static DBusConnection *dbus_conn =3D NULL;
 static unsigned service_state_cb_id;
=20
@@ -930,6 +932,41 @@ static gboolean dev_property_exists_tx_power(const =
GDBusPropertyTable *property,
 	return TRUE;
 }
=20
+static gboolean dev_property_get_negotiated_max_att_payload(
+					const GDBusPropertyTable * =
property,
+					DBusMessageIter *iter, void =
*data)
+{
+	const struct btd_device *dev =3D data;
+	dbus_int16_t val =3D 0;
+	int err;
+
+	/* The spec for this API requires a failure if
+	 * MTU negotiation is incomplete.
+	 */
+	if (!bt_att_is_mtu_negotiated(dev->att))
+		return FALSE;
+
+	val =3D bt_att_get_mtu(dev->att);
+	// subtract off the ATT header length to get the max payload
+	val -=3D ATT_PACKET_HEADER_SIZE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
+
+	return TRUE;
+}
+
+static gboolean dev_property_exists_negotiated_max_att_payload(
+					const GDBusPropertyTable * =
property,
+					void *data)
+{
+	const struct btd_device *dev =3D data;
+
+	/* The spec for this API requires the property
+	 * be absent until MTU negotiation is incomplete.
+	 */
+	return bt_att_is_mtu_negotiated(dev->att);
+}
+
 static gboolean
 dev_property_get_svc_resolved(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void =
*data)
@@ -2561,6 +2598,10 @@ static const GDBusPropertyTable =
device_properties[] =3D {
 				NULL, dev_property_service_data_exist },
 	{ "TxPower", "n", dev_property_get_tx_power, NULL,
 					dev_property_exists_tx_power },
+	{ "NegotiatedMaxAttributeSize", "n",
+					=
dev_property_get_negotiated_max_att_payload,
+					NULL, =
dev_property_exists_negotiated_max_att_payload,
+					=
G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, =
NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist,
diff --git a/src/shared/att.c b/src/shared/att.c
index ca2d051..bf20a01 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -70,6 +70,7 @@ struct bt_att {
=20
 	uint8_t *buf;
 	uint16_t mtu;
+	bool mtu_negotiated;
=20
 	unsigned int next_send_id;	/* IDs for "send" ops */
 	unsigned int next_reg_id;	/* IDs for registered callbacks =
*/
@@ -1100,6 +1101,20 @@ bool bt_att_set_debug(struct bt_att *att, =
bt_att_debug_func_t callback,
 	return true;
 }
=20
+bool bt_att_is_mtu_negotiated(struct bt_att *att)
+{
+	if (!att)
+		return false;
+
+	return att->mtu_negotiated;
+}
+
+void bt_att_set_mtu_negotiated(struct bt_att *att, bool negotiated)
+{
+	if (att && !att->mtu_negotiated)
+		att->mtu_negotiated =3D negotiated;
+}
+
 uint16_t bt_att_get_mtu(struct bt_att *att)
 {
 	if (!att)
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 79e01c8..c76ca23 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1379,6 +1379,7 @@ static void exchange_mtu_cb(uint8_t opcode, const =
void *pdu,
 	/* Set MTU to be the minimum */
 	server->mtu =3D final_mtu;
 	bt_att_set_mtu(server->att, final_mtu);
+	bt_att_set_mtu_negotiated(server->att, true);
=20
 	util_debug(server->debug_callback, server->debug_data,
 			"MTU exchange complete, with MTU: %u", =
final_mtu);
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

