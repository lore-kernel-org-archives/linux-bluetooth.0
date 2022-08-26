Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5373FECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 10:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbiHZKPX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbiHZKPQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 06:15:16 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851A18E01
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 03:15:12 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7C1AA100007
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 10:15:10 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] adapter: Implement PowerState property
Date:   Fri, 26 Aug 2022 12:15:09 +0200
Message-Id: <20220826101509.124704-1-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This property should allow any program to show whether an adapter is in
the process of being turned on.

As turning on an adapter isn't instantaneous, it's important that the UI
reflects the transitional state of the adapter's power, and doesn't
assume the device is already turned on but not yet working, or still off
despite having requested for it to be turned on, in both cases making
the UI feel unresponsive.

This can also not be implemented in front-ends directly as, then,
the status of an adapter wouldn't be reflected correctly in the Settings
window if it's turned on in the system menu. Implementing it in the
front-ends would also preclude from having feedback about the state of
the adapter when bluetoothd is the one powering up the adapter after the
rfkill was unblocked.

See https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/121
and the original https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/5773
---
 client/main.c       |  1 +
 doc/adapter-api.txt | 14 ++++++++
 src/adapter.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 19139d15b..ddd97c23c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -981,6 +981,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(adapter->proxy, "Alias");
 	print_property(adapter->proxy, "Class");
 	print_property(adapter->proxy, "Powered");
+	print_property(adapter->proxy, "PowerState");
 	print_property(adapter->proxy, "Discoverable");
 	print_property(adapter->proxy, "DiscoverableTimeout");
 	print_property(adapter->proxy, "Pairable");
diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 48466ab75..5bdb9c34e 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -269,6 +269,20 @@ Properties	string Address [readonly]
 			restart or unplugging of the adapter it will reset
 			back to false.
 
+		string PowerState [readonly]
+
+			The power state of an adapter.
+
+			The power state will show whether the adapter is
+			turning off, or turning on, as well as being on
+			or off.
+
+			Possible values:
+				"on" - powered on
+				"off" - powered off
+				"turning-on" - transitioning from "off" to "on"
+				"turning-off" - transitioning from "on" to "off"
+
 		boolean Discoverable [readwrite]
 
 			Switch an adapter to discoverable or non-discoverable
diff --git a/src/adapter.c b/src/adapter.c
index b453e86a0..0cfac60c6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -239,6 +239,12 @@ struct btd_adapter_pin_cb_iter {
 	/* When the iterator reaches the end, it is NULL and attempt is 0 */
 };
 
+enum {
+	ADAPTER_POWER_STATE_TARGET_NONE = 0,
+	ADAPTER_POWER_STATE_TARGET_OFF,
+	ADAPTER_POWER_STATE_TARGET_ON
+};
+
 struct btd_adapter {
 	int ref_count;
 
@@ -252,6 +258,7 @@ struct btd_adapter {
 	char *short_name;		/* controller short name */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t pending_settings;	/* pending controller settings */
+	uint32_t power_state_target;	/* the target power state */
 	uint32_t current_settings;	/* current controller settings */
 
 	char *path;			/* adapter object path */
@@ -579,6 +586,8 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 	if (changed_mask & MGMT_SETTING_POWERED) {
 	        g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Powered");
+	        g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "PowerState");
 
 		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			adapter_start(adapter);
@@ -618,6 +627,16 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 	}
 }
 
+static void reset_power_state_target(struct btd_adapter *adapter, uint8_t value)
+{
+	if ((value &&
+	     adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON) ||
+	    (!value &&
+	     adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_OFF)) {
+		adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
+	}
+}
+
 static void new_settings_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -635,6 +654,9 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 	if (settings == adapter->current_settings)
 		return;
 
+	if ((adapter->current_settings ^ settings) & MGMT_SETTING_POWERED)
+		reset_power_state_target(adapter, settings & MGMT_SETTING_POWERED ? 0x01 : 0x00);
+
 	DBG("Settings: 0x%08x", settings);
 
 	settings_changed(adapter, settings);
@@ -643,6 +665,7 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 struct set_mode_data {
 	struct btd_adapter *adapter;
 	uint32_t setting;
+	uint8_t value;
 };
 
 static void set_mode_complete(uint8_t status, uint16_t length,
@@ -655,6 +678,8 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 		btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
 						mgmt_errstr(status), status);
 		adapter->pending_settings &= ~data->setting;
+		if (data->setting & MGMT_SETTING_POWERED)
+			reset_power_state_target(adapter, data->value);
 		return;
 	}
 
@@ -692,6 +717,11 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	switch (opcode) {
 	case MGMT_OP_SET_POWERED:
 		setting = MGMT_SETTING_POWERED;
+		adapter->power_state_target = mode ?
+			ADAPTER_POWER_STATE_TARGET_ON :
+			ADAPTER_POWER_STATE_TARGET_OFF;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
 		setting = MGMT_SETTING_CONNECTABLE;
@@ -712,6 +742,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	data = g_new0(struct set_mode_data, 1);
 	data->adapter = adapter;
 	data->setting = setting;
+	data->value = mode;
 
 	if (mgmt_send(adapter->mgmt, opcode,
 				adapter->dev_id, sizeof(cp), &cp,
@@ -719,8 +750,13 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 		adapter->pending_settings |= setting;
 		return true;
 	}
-
 	g_free(data);
+	if (setting == MGMT_SETTING_POWERED) {
+		/* cancel the earlier setting */
+		adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
+	}
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -2898,6 +2934,7 @@ struct property_set_data {
 	struct btd_adapter *adapter;
 	uint32_t setting;
 	GDBusPendingPropertySet id;
+	uint8_t value;
 };
 
 static void property_set_mode_complete(uint8_t status, uint16_t length,
@@ -2923,6 +2960,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 							mgmt_errstr(status));
 
 		adapter->pending_settings &= ~data->setting;
+		if (data->setting & MGMT_SETTING_POWERED)
+			reset_power_state_target(adapter, data->value);
 		return;
 	}
 
@@ -3046,6 +3085,16 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	data->adapter = adapter;
 	data->setting = setting;
 	data->id = id;
+	data->setting = setting;
+	data->value = mode;
+
+	if (setting == MGMT_SETTING_POWERED) {
+		adapter->power_state_target = mode ?
+			ADAPTER_POWER_STATE_TARGET_ON :
+			ADAPTER_POWER_STATE_TARGET_OFF;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
+	}
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
 			property_set_mode_complete, data, g_free) > 0) {
@@ -3054,6 +3103,12 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	}
 
 	g_free(data);
+	if (setting == MGMT_SETTING_POWERED) {
+		/* cancel the earlier setting */
+		adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
+	}
 
 failed:
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
@@ -3085,6 +3140,29 @@ static void property_set_powered(const GDBusPropertyTable *property,
 	property_set_mode(adapter, MGMT_SETTING_POWERED, iter, id);
 }
 
+static gboolean property_get_power_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *str;
+
+	if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_NONE) {
+		if (adapter->current_settings & MGMT_SETTING_POWERED)
+			str = "on";
+		else
+			str = "off";
+	} else {
+		if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON)
+			str = "turning-on";
+		else
+			str = "turning-off";
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
 static gboolean property_get_discoverable(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -3723,6 +3801,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
 	{ "Powered", "b", property_get_powered, property_set_powered },
+	{ "PowerState", "s", property_get_power_state },
 	{ "Discoverable", "b", property_get_discoverable,
 					property_set_discoverable },
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,
@@ -5529,6 +5608,8 @@ static void adapter_start(struct btd_adapter *adapter)
 {
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
 
 	DBG("adapter %s has been enabled", adapter->path);
 
@@ -7272,6 +7353,8 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "PowerState");
 
 	DBG("adapter %s has been disabled", adapter->path);
 }
-- 
2.37.2

