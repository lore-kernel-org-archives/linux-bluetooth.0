Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 10/12] advertising-manager: Parse ManufacturerSpecificData
Date: Thu, 12 Mar 2015 10:11:57 -0700
Message-Id: <1426180319-16509-11-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ManufacturerSpecificData property of the LEAdvertisement1
---
 src/advertising-manager.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tools/advertisement-example |  1 +
 2 files changed, 59 insertions(+)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index e7c24c6..cb76482 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -250,6 +250,58 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_manufacturer_data(GDBusProxy *proxy,
+						struct advertising_data *data)
+{
+	DBusMessageIter iter, entries;
+
+	if (!g_dbus_proxy_get_property(proxy, "ManufacturerSpecificData",
+									&iter))
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
+		uint16_t manuf_id;
+		uint8_t *manuf_data;
+		int len;
+
+		dbus_message_iter_recurse(&entries, &entry);
+		dbus_message_iter_get_basic(&entry, &manuf_id);
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
+		dbus_message_iter_get_fixed_array(&value, &manuf_data, &len);
+
+		DBG("Adding ManufactuerSpecificData for %04x", manuf_id);
+
+		advertising_data_add_manufacturer_data(data, manuf_id,
+							manuf_data, len);
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
@@ -275,6 +327,12 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_manufacturer_data(ad->proxy, ad->data)) {
+		error("Property \"ManufactuerSpecificData\" failed to parse"
+								" correctly");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
diff --git a/tools/advertisement-example b/tools/advertisement-example
index 2227009..96554dd 100644
--- a/tools/advertisement-example
+++ b/tools/advertisement-example
@@ -114,6 +114,7 @@ class TestAdvertisement(Advertisement):
         Advertisement.__init__(self, bus, index, 'broadcast')
         self.add_service_uuid('0000180D-0000-1000-8000-00805F9B34FB')
         self.add_service_uuid('0000180F-0000-1000-8000-00805F9B34FB')
+        self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
 
 
 def register_ad_cb():
-- 
2.2.0.rc0.207.ga3a616c

