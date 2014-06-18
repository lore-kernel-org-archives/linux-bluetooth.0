Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] privacy: Add privacy support in adapter properties
Date: Wed, 18 Jun 2014 11:26:39 +0530
Message-id: <1403070999-12328-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds LE privacy support to adapter_properties and emits
signal on privacy settings changed.
---
 src/adapter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f5f8c8c..dacd30f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -479,6 +479,10 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 
 		trigger_pairable_timeout(adapter);
 	}
+
+	if (changed_mask & MGMT_SETTING_PRIVACY)
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Privacy");
 }
 
 static void new_settings_callback(uint16_t index, uint16_t length,
@@ -2171,6 +2175,14 @@ static gboolean property_get_modalias(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_privacy(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	return property_get_mode(adapter, MGMT_SETTING_PRIVACY, iter);
+}
+
 static int device_path_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
@@ -2238,6 +2250,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
+	{ "Privacy", "b", property_get_privacy },
 	{ }
 };
 
-- 
1.9.1

