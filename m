Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v10 06/12] core/advertising: Parse ServiceData
Date: Fri,  3 Apr 2015 15:02:06 -0700
Message-Id: <1428098532-5257-7-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428098532-5257-1-git-send-email-jamuraa@chromium.org>
References: <1428098532-5257-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ServiceData property of LEAdvertisement1
---
 src/advertising.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 8d6c13e..74b9cbd 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -296,6 +296,61 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_service_data(GDBusProxy *proxy,
+							struct bt_ad *data)
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
+	bt_ad_clear_service_data(data);
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
+		if (!bt_ad_add_service_data(data, &uuid, service_data, len))
+			goto fail;
+
+		dbus_message_iter_next(&entries);
+	}
+
+	return true;
+
+fail:
+	bt_ad_clear_service_data(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -323,6 +378,11 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_service_data(ad->proxy, ad->data)) {
+		error("Property \"ServiceData\" failed to parse");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
-- 
2.2.0.rc0.207.ga3a616c

