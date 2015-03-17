Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v2 12/14] advertising-manager: Parse ManufacturerSpecificData
Date: Tue, 17 Mar 2015 16:49:59 -0700
Message-Id: <1426636201-30057-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
References: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ManufacturerSpecificData property of the LEAdvertisement1
---
 src/advertising-manager.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index 993ab4b..eaa8d3d 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -218,6 +218,58 @@ fail:
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
@@ -243,6 +295,12 @@ static bool parse_advertisement(struct advertisement *ad)
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
-- 
2.2.0.rc0.207.ga3a616c

