Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CFCC3DA6B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 11:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiHaLgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiHaLgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 07:36:52 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E6A927A
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 04:36:50 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A0F971C0012
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 11:36:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 2/6] adapter: Implement PowerState property
Date:   Wed, 31 Aug 2022 13:36:43 +0200
Message-Id: <20220831113647.85110-2-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831113647.85110-1-hadess@hadess.net>
References: <20220831113647.85110-1-hadess@hadess.net>
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
 src/adapter.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec76171b7..2e9e321e8 100644
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
 
@@ -253,6 +259,7 @@ struct btd_adapter {
 	bool blocked;			/* whether rfkill is enabled */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t pending_settings;	/* pending controller settings */
+	uint32_t power_state_target;	/* the target power state */
 	uint32_t current_settings;	/* current controller settings */
 
 	char *path;			/* adapter object path */
@@ -580,6 +587,8 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 	if (changed_mask & MGMT_SETTING_POWERED) {
 	        g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Powered");
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "PowerState");
 
 		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			adapter_start(adapter);
@@ -619,6 +628,16 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
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
@@ -636,6 +655,12 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 	if (settings == adapter->current_settings)
 		return;
 
+	if ((adapter->current_settings ^ settings) & MGMT_SETTING_POWERED) {
+		reset_power_state_target(adapter,
+					settings & MGMT_SETTING_POWERED ?
+					0x01 : 0x00);
+	}
+
 	DBG("Settings: 0x%08x", settings);
 
 	settings_changed(adapter, settings);
@@ -644,6 +669,7 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 struct set_mode_data {
 	struct btd_adapter *adapter;
 	uint32_t setting;
+	uint8_t value;
 };
 
 static void set_mode_complete(uint8_t status, uint16_t length,
@@ -658,6 +684,8 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 		if (status == MGMT_STATUS_RFKILLED)
 			adapter->blocked = true;
 		adapter->pending_settings &= ~data->setting;
+		if (data->setting & MGMT_SETTING_POWERED)
+			reset_power_state_target(adapter, data->value);
 		return;
 	}
 
@@ -695,6 +723,12 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	switch (opcode) {
 	case MGMT_OP_SET_POWERED:
 		setting = MGMT_SETTING_POWERED;
+		adapter->power_state_target = mode ?
+			ADAPTER_POWER_STATE_TARGET_ON :
+			ADAPTER_POWER_STATE_TARGET_OFF;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE,
+						"PowerState");
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
 		setting = MGMT_SETTING_CONNECTABLE;
@@ -715,6 +749,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	data = g_new0(struct set_mode_data, 1);
 	data->adapter = adapter;
 	data->setting = setting;
+	data->value = mode;
 
 	if (mgmt_send(adapter->mgmt, opcode,
 				adapter->dev_id, sizeof(cp), &cp,
@@ -722,8 +757,14 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 		adapter->pending_settings |= setting;
 		return true;
 	}
-
 	g_free(data);
+	if (setting == MGMT_SETTING_POWERED) {
+		/* cancel the earlier setting */
+		adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE,
+						"PowerState");
+	}
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -2901,6 +2942,7 @@ struct property_set_data {
 	struct btd_adapter *adapter;
 	uint32_t setting;
 	GDBusPendingPropertySet id;
+	uint8_t value;
 };
 
 static void property_set_mode_complete(uint8_t status, uint16_t length,
@@ -2928,6 +2970,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 							mgmt_errstr(status));
 
 		adapter->pending_settings &= ~data->setting;
+		if (data->setting & MGMT_SETTING_POWERED)
+			reset_power_state_target(adapter, data->value);
 		return;
 	}
 
@@ -3051,6 +3095,17 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
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
+						ADAPTER_INTERFACE,
+						"PowerState");
+	}
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
 			property_set_mode_complete, data, g_free) > 0) {
@@ -3059,6 +3114,13 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	}
 
 	g_free(data);
+	if (setting == MGMT_SETTING_POWERED) {
+		/* cancel the earlier setting */
+		adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE,
+						"PowerState");
+	}
 
 failed:
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
@@ -3090,6 +3152,33 @@ static void property_set_powered(const GDBusPropertyTable *property,
 	property_set_mode(adapter, MGMT_SETTING_POWERED, iter, id);
 }
 
+static gboolean property_get_power_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *str;
+
+	if (adapter->blocked) {
+		str = "off-blocked";
+	} else if (adapter->power_state_target ==
+			ADAPTER_POWER_STATE_TARGET_NONE) {
+		if (adapter->current_settings & MGMT_SETTING_POWERED)
+			str = "on";
+		else
+			str = "off";
+	} else {
+		if (adapter->power_state_target ==
+			ADAPTER_POWER_STATE_TARGET_ON)
+			str = "off-enabling";
+		else
+			str = "on-disabling";
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
@@ -3728,6 +3817,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
 	{ "Powered", "b", property_get_powered, property_set_powered },
+	{ "PowerState", "s", property_get_power_state, NULL, NULL,
+			     G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Discoverable", "b", property_get_discoverable,
 					property_set_discoverable },
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,
@@ -5534,6 +5625,9 @@ static void adapter_start(struct btd_adapter *adapter)
 {
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE,
+						"PowerState");
 
 	DBG("adapter %s has been enabled", adapter->path);
 
@@ -7277,6 +7371,9 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE,
+						"PowerState");
 
 	DBG("adapter %s has been disabled", adapter->path);
 }
@@ -7553,8 +7650,12 @@ int btd_cancel_authorization(guint id)
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
-	if (adapter->blocked)
+	if (adapter->blocked) {
 		adapter->blocked = false;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE,
+					"PowerState");
+	}
 
 	if (btd_adapter_get_powered(adapter))
 		return 0;
@@ -7566,8 +7667,12 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 
 int btd_adapter_set_blocked(struct btd_adapter *adapter)
 {
-	if (!adapter->blocked)
+	if (!adapter->blocked) {
 		adapter->blocked = true;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE,
+					"PowerState");
+	}
 	return 0;
 }
 
-- 
2.37.2

