Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v6 09/13] core/advertising: Parse ManufacturerSpecificData
Date: Thu, 26 Mar 2015 15:08:39 -0700
Message-Id: <1427407723-27232-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
References: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ManufacturerSpecificData property of the LEAdvertisement1
---
 src/advertising.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index b373740..5646e68 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -242,6 +242,57 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_manufacturer_data(GDBusProxy *proxy,
+						struct advertising_data *data)
+{
+	DBusMessageIter iter, entries;
+
+	if (!g_dbus_proxy_get_property(proxy, "ManufacturerData", &iter))
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
+		DBG("Adding ManufacturerData for %04x", manuf_id);
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
@@ -264,6 +315,11 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_manufacturer_data(ad->proxy, ad->data)) {
+		error("Property \"ManufacturerData\" failed to parse");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
-- 
2.2.0.rc0.207.ga3a616c

