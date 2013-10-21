Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 2/6] android: Handle mgmt changed events
Date: Mon, 21 Oct 2013 14:28:33 +0300
Message-Id: <1382354917-8632-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add code handling changing adapter settings.
---
 android/adapter.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 4009f4d..cae3187 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -69,6 +69,134 @@ failed:
 	adapter->ready(NULL, err);
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
+	if (!g_strcmp0(adapter->name, (const char *) rp->name))
+		return;
+
+	DBG("name: %s", rp->name);
+
+	g_free(adapter->name);
+	adapter->name = g_strdup((const char *) rp->name);
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
+		/*
+		if (adapter->current_settings & MGMT_SETTING_POWERED)
+			start_adapter()
+		else
+			stop_adapter()
+		*/
+	}
+
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
+	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, 0,
+			new_settings_callback, adapter, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
+			0, mgmt_dev_class_changed_event,
+			adapter, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
+			0, mgmt_local_name_changed_event,
+			adapter, NULL);
+}
+
 static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
@@ -128,6 +256,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	adapter->current_settings = btohs(rp->current_settings);
 
 	/* TODO: Register all event notification handlers */
+	register_mgmt_handlers(adapter);
 
 	load_link_keys(adapter, NULL);
 
-- 
1.7.10.4

