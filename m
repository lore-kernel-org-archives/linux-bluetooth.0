Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC] adapter: Add support for Limited Discoverable mode
Date: Thu,  8 Feb 2018 12:10:29 +0100
Message-Id: <20180208111029.523-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set adapter in Limited Discoverable mode for up to 60
seconds. Any registered advertising instances flags are updated as
well.
---
 doc/adapter-api.txt |  20 ++++++++
 src/adapter.c       | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h       |   1 +
 src/advertising.c   |   4 +-
 4 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 0533b674a..ea50eeb72 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -225,6 +225,26 @@ Properties	string Address [readonly]
 
 			For any new adapter this settings defaults to false.
 
+		boolean LimitedDiscoverable [readwrite, experimental]
+
+			Switch an adapter to limited discoverable or
+			non-discoverable to either make it visible or hide it.
+			This is a global setting and should only be used by the
+			settings application.
+
+			Adapter can be in limited discoverable mode for up to
+			60 seconds. DiscoverableTimeout is honored but capped to
+			60 seconds limit.
+
+			In case the adapter is switched off or already
+			general discoverable, setting this value will fail.
+
+			When changing the Powered property the new state of
+			this property will be updated via a PropertiesChanged
+			signal.
+
+			For any new adapter this settings defaults to false.
+
 		boolean Pairable [readwrite]
 
 			Switch an adapter to pairable or non-pairable. This is
diff --git a/src/adapter.c b/src/adapter.c
index 5070c0f09..3898156e3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -97,6 +97,8 @@
 #define DISTANCE_VAL_INVALID	0x7FFF
 #define PATHLOSS_MAX		137
 
+#define LIMITED_TIMEOUT (60)
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
@@ -205,6 +207,7 @@ struct btd_adapter {
 	char *modalias;			/* device id (modalias) */
 	bool stored_discoverable;	/* stored discoverable mode */
 	uint32_t discoverable_timeout;	/* discoverable time(sec) */
+	bool limited;			/* if limited discoverable */
 	uint32_t pairable_timeout;	/* pairable time(sec) */
 
 	char *current_alias;		/* current adapter name alias */
@@ -540,6 +543,22 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 					ADAPTER_INTERFACE, "Connectable");
 
 	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
+		if (adapter->limited) {
+			bool discoverable;
+			bool powered;
+
+			discoverable = adapter->current_settings &
+						MGMT_SETTING_DISCOVERABLE;
+			powered = adapter->current_settings &
+							MGMT_SETTING_POWERED;
+
+			adapter->limited = discoverable && powered;
+
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+							ADAPTER_INTERFACE,
+							"LimitedDiscoverable");
+		}
+
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discoverable");
 		store_adapter_info(adapter);
@@ -2830,6 +2849,107 @@ static void property_set_discoverable(const GDBusPropertyTable *property,
 	property_set_mode(adapter, MGMT_SETTING_DISCOVERABLE, iter, id);
 }
 
+static gboolean property_get_limited(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_bool_t enable;
+
+	enable = adapter->limited &&
+			(adapter->current_settings & MGMT_SETTING_DISCOVERABLE);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &enable);
+
+	return TRUE;
+}
+
+static void set_limited(struct btd_adapter *adapter, bool enable,
+						GDBusPendingPropertySet id)
+{
+	struct property_set_data *data;
+	struct mgmt_cp_set_discoverable cp;
+	void *param;
+	uint16_t opcode, len;
+	uint8_t mode;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (enable) {
+		if (kernel_conn_control)
+			set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
+
+		cp.val = 0x02;
+		if (adapter->discoverable_timeout)
+			cp.timeout = htobs(MIN(adapter->discoverable_timeout,
+							LIMITED_TIMEOUT));
+		else
+			cp.timeout = htobs(LIMITED_TIMEOUT);
+
+		opcode = MGMT_OP_SET_DISCOVERABLE;
+		param = &cp;
+		len = sizeof(cp);
+	} else {
+		if (kernel_conn_control) {
+			mode = 0x00;
+			opcode = MGMT_OP_SET_CONNECTABLE;
+			param = &mode;
+			len = sizeof(mode);
+		} else {
+			cp.val = 0x00;
+			opcode = MGMT_OP_SET_DISCOVERABLE;
+			param = &cp;
+			len = sizeof(cp);
+		}
+	}
+
+	DBG("sending %s command for index %u", mgmt_opstr(opcode),
+							adapter->dev_id);
+
+	data = g_new0(struct property_set_data, 1);
+	data->adapter = adapter;
+	data->id = id;
+
+	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
+				property_set_mode_complete, data, g_free) > 0)
+		return;
+
+	g_free(data);
+	btd_error(adapter->dev_id, "Failed to set mode for index %u",
+							adapter->dev_id);
+
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed", NULL);
+}
+
+static void property_set_limited(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_bool_t enable;
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+								"Not Powered");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &enable);
+
+	if (adapter->limited == !!enable) {
+		g_dbus_pending_property_success(id);
+		return;
+	}
+
+	if (enable && (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)) {
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+						"General Discoverable");
+		return;
+	}
+
+	adapter->limited = true;
+	set_limited(adapter, enable, id);
+}
+
 static gboolean property_get_discoverable_timeout(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
@@ -3101,6 +3221,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Powered", "b", property_get_powered, property_set_powered },
 	{ "Discoverable", "b", property_get_discoverable,
 					property_set_discoverable },
+	{ "LimitedDiscoverable", "b", property_get_limited,
+		property_set_limited, NULL, G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,
 					property_set_discoverable_timeout },
 	{ "Pairable", "b", property_get_pairable, property_set_pairable },
@@ -4117,6 +4239,15 @@ bool btd_adapter_get_discoverable(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_get_limited(struct btd_adapter *adapter)
+{
+	if ((adapter->current_settings & MGMT_SETTING_DISCOVERABLE) &&
+			adapter->limited)
+		return true;
+
+	return false;
+}
+
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter)
 {
 	if (!adapter)
diff --git a/src/adapter.h b/src/adapter.h
index e619a5be9..1ddf26576 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -75,6 +75,7 @@ bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
 bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 bool btd_adapter_get_discoverable(struct btd_adapter *adapter);
+bool btd_adapter_get_limited(struct btd_adapter *adapter);
 
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter);
 
diff --git a/src/advertising.c b/src/advertising.c
index 0af9f02d6..3dba1465d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -625,7 +625,9 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 	if (client->type == AD_TYPE_PERIPHERAL) {
 		flags = MGMT_ADV_FLAG_CONNECTABLE;
 
-		if (btd_adapter_get_discoverable(client->manager->adapter))
+		if (btd_adapter_get_limited(client->manager->adapter))
+			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
+		else if (btd_adapter_get_discoverable(client->manager->adapter))
 			flags |= MGMT_ADV_FLAG_DISCOV;
 	}
 
-- 
2.14.3

