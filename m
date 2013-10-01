Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 12/14] android: Handle mgmt changed events
Date: Tue,  1 Oct 2013 18:03:17 +0300
Message-Id: <1380639799-25790-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add code handling changing adapter settings.
---
 android/main.c |  154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/android/main.c b/android/main.c
index 29389d5..3af1b96 100644
--- a/android/main.c
+++ b/android/main.c
@@ -167,6 +167,159 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 	DBG("status %u", status);
 }
 
+static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct bt_adapter *adapter = user_data;
+	const struct mgmt_cp_set_local_name *rp = param;
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of local name changed parameters");
+		return;
+	}
+
+	if (adapter != default_adapter) {
+		error("Wrong adapter %p", adapter);
+		return;
+	}
+
+	if (!g_strcmp0(adapter->short_name, (const char *) rp->short_name) &&
+			!g_strcmp0(adapter->name, (const char *) rp->name))
+		return;
+
+	DBG("name: %s short name: %s", rp->name, rp->short_name);
+
+	g_free(adapter->name);
+	adapter->name = g_strdup((const char *) rp->name);
+
+	g_free(adapter->short_name);
+	adapter->short_name = g_strdup((const char *) rp->short_name);
+
+	/* TODO Update services if needed */
+}
+
+static void settings_changed_connectable(struct bt_adapter *adapter)
+{
+	/* TODO */
+}
+
+static void settings_changed_discoverable(struct bt_adapter *adapter)
+{
+	/* TODO */
+}
+
+static void settings_changed(struct bt_adapter *adapter, uint32_t settings)
+{
+	uint32_t changed_mask;
+
+	changed_mask = adapter->current_settings ^ settings;
+
+	adapter->current_settings = settings;
+
+	DBG("0x%08x", changed_mask);
+
+	if (changed_mask & MGMT_SETTING_POWERED) {
+		info("Powered");
+
+		if (adapter->current_settings & MGMT_SETTING_POWERED)
+			adapter_start(adapter);
+		else
+			adapter_stop(adapter);
+	}
+
+	/* Seems not needed for Android */
+	if (changed_mask & MGMT_SETTING_PAIRABLE)
+		DBG("Pairable");
+
+	/*
+	 * There are only 2 scan modes:
+	 * CONNECTABLE and CONNECTABLE_DISCOVERABLE
+	 */
+	if (changed_mask & MGMT_SETTING_CONNECTABLE) {
+		DBG("Connectable");
+
+		settings_changed_connectable(adapter);
+	}
+
+	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
+		DBG("Discoverable");
+
+		settings_changed_discoverable(adapter);
+	}
+}
+
+static void new_settings_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct bt_adapter *adapter = user_data;
+	uint32_t settings;
+
+	if (length < sizeof(settings)) {
+		error("Wrong size of new settings parameters");
+		return;
+	}
+
+	if (adapter != default_adapter) {
+		error("Wrong adapter %p", adapter);
+		return;
+	}
+
+	settings = bt_get_le32(param);
+
+	DBG("settings: 0x%8.8x -> 0x%8.8x", adapter->current_settings,
+								settings);
+
+	if (settings == adapter->current_settings)
+		return;
+
+	settings_changed(adapter, settings);
+}
+
+static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct bt_adapter *adapter = user_data;
+	const struct mgmt_cod *rp = param;
+	uint32_t dev_class;
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of class of device changed parameters");
+		return;
+	}
+
+	if (adapter != default_adapter) {
+		error("Wrong adapter %p", adapter);
+		return;
+	}
+
+	dev_class = rp->val[0] | (rp->val[1] << 8) | (rp->val[2] << 16);
+
+	if (dev_class == adapter->dev_class)
+		return;
+
+	DBG("Class: 0x%06x", dev_class);
+
+	adapter->dev_class = dev_class;
+
+	/* TODO: Inform prop change: Class */
+
+	/* TODO: Gatt attrib set*/
+}
+
+static void register_mgmt_handlers(struct bt_adapter *adapter)
+{
+	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->dev_id,
+					new_settings_callback, adapter, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
+			adapter->dev_id, mgmt_dev_class_changed_event,
+			adapter, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
+			adapter->dev_id, mgmt_local_name_changed_event,
+			adapter, NULL);
+}
+
 static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
@@ -228,6 +381,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	default_adapter->current_settings = btohs(rp->current_settings);
 
 	/* TODO: Register all event notification handlers */
+	register_mgmt_handlers(default_adapter);
 
 	if (default_adapter->current_settings & MGMT_SETTING_POWERED)
 		adapter_start(default_adapter);
-- 
1.7.10.4

