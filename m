Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 11/12] advertising-manager: Parse ServiceData
Date: Thu, 12 Mar 2015 10:11:58 -0700
Message-Id: <1426180319-16509-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ServiceData property of LEAdvertisement1
---
 src/advertising-manager.c   | 60 +++++++++++++++++++++++++++++++++++++++++++++
 tools/advertisement-example |  7 ++++++
 2 files changed, 67 insertions(+)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index cb76482..73fab4e 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -302,6 +302,61 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_service_data(GDBusProxy *proxy,
+						struct advertising_data *data)
+{
+	DBusMessageIter iter, entries;
+
+	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &entries);
+
+	advertising_data_clear_manufacturer_data(data);
+
+	while (dbus_message_iter_get_arg_type(&entries)
+						== DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		const char *uuid_str;
+		bt_uuid_t uuid;
+		uint8_t *service_data;
+		int len;
+
+		dbus_message_iter_recurse(&entries, &entry);
+		dbus_message_iter_get_basic(&entry, &uuid_str);
+
+		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
+			goto fail;
+
+		dbus_message_iter_next(&entry);
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_fixed_array(&value, &service_data, &len);
+
+		DBG("Adding ServiceData for %s", uuid_str);
+
+		advertising_data_add_service_data(data, &uuid,
+							service_data, len);
+
+		dbus_message_iter_next(&entries);
+	}
+
+	return true;
+
+fail:
+	advertising_data_clear_manufacturer_data(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -333,6 +388,11 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_service_data(ad->proxy, ad->data)) {
+		error("Property \"ServiceData\" failed to parse correctly");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
diff --git a/tools/advertisement-example b/tools/advertisement-example
index 96554dd..7846f1d 100644
--- a/tools/advertisement-example
+++ b/tools/advertisement-example
@@ -88,6 +88,11 @@ class Advertisement(dbus.service.Object):
             self.manufacturer_specific_data = dict()
         self.manufacturer_specific_data[manuf_code] = data
 
+    def add_service_data(self, uuid, data):
+        if not self.service_data:
+            self.service_data = dict()
+        self.service_data[uuid] = data
+
     @dbus.service.method(DBUS_PROP_IFACE,
                          in_signature='s',
                          out_signature='a{sv}')
@@ -115,6 +120,8 @@ class TestAdvertisement(Advertisement):
         self.add_service_uuid('0000180D-0000-1000-8000-00805F9B34FB')
         self.add_service_uuid('0000180F-0000-1000-8000-00805F9B34FB')
         self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
+        self.add_service_data('00009999-0000-1000-8000-00805F9B34FB',
+                              [0x00, 0x01, 0x02, 0x03, 0x04])
 
 
 def register_ad_cb():
-- 
2.2.0.rc0.207.ga3a616c

