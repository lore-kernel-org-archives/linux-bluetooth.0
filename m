Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v1 7/9] adapter: add Pairing property to report ongoing Pairing Session
Date: Tue, 11 Jun 2013 01:03:29 +0100
Message-Id: <1370909011-19315-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Pairing is a readonly property that will be true whenever on or more
Pairing Sessions are running.
---
 src/adapter.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5e8c675..f4b0892 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -169,8 +169,11 @@ struct btd_adapter {
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *connect_list;		/* Devices to connect when found */
+
+	bool pairing;			/* pairing property state */
 	uint32_t pairing_settings;	/* settings before pairing session*/
 	GSList *pairing_list;		/* list of pairing sessions */
+
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -1734,6 +1737,11 @@ static void discoverable_disconnect(DBusConnection *conn, void *user_data)
 
 	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
 		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x00);
+
+	adapter->pairing = false;
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Pairing");
 }
 
 static DBusMessage *request_pairing_session(DBusConnection *conn,
@@ -1781,6 +1789,11 @@ static DBusMessage *request_pairing_session(DBusConnection *conn,
 	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
 		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x01);
 
+	adapter->pairing = true;
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Pairing");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -1821,6 +1834,11 @@ static DBusMessage *release_pairing_session(DBusConnection *conn,
 	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
 		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x00);
 
+	adapter->pairing = false;
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Pairing");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -2175,6 +2193,17 @@ static void property_set_pairable_timeout(const GDBusPropertyTable *property,
 	trigger_pairable_timeout(adapter);
 }
 
+static gboolean property_get_pairing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_bool_t pairing = adapter->pairing;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &pairing);
+
+	return TRUE;
+}
+
 static gboolean property_get_discovering(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2300,6 +2329,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Pairable", "b", property_get_pairable, property_set_pairable },
 	{ "PairableTimeout", "u", property_get_pairable_timeout,
 					property_set_pairable_timeout },
+	{ "Pairing", "b", property_get_pairing },
 	{ "Discovering", "b", property_get_discovering },
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
-- 
1.8.1.4

