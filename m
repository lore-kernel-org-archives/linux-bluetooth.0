Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] core/advertising: Fix not parsing data properly
Date: Thu, 11 Aug 2016 15:14:46 +0300
Message-Id: <1470917692-8878-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Dictionary entries should contain their value component as variant
container which requires dbus_message_iter_recurse to access.

Note: This will break the application that were using this API up to
now, but since this was experimental it should still be possible to fix
it without having to bump the interface revision.
---
 src/advertising.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d2019de..e5cd31c 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -288,7 +288,7 @@ static bool parse_advertising_manufacturer_data(GDBusProxy *proxy,
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter value, entry;
+		DBusMessageIter value, entry, array;
 		uint16_t manuf_id;
 		uint8_t *manuf_data;
 		int len;
@@ -297,15 +297,17 @@ static bool parse_advertising_manufacturer_data(GDBusProxy *proxy,
 		dbus_message_iter_get_basic(&entry, &manuf_id);
 
 		dbus_message_iter_next(&entry);
-		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_ARRAY)
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
 			goto fail;
 
-		dbus_message_iter_recurse(&entry, &value);
+		dbus_message_iter_recurse(&value, &array);
 
-		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
 			goto fail;
 
-		dbus_message_iter_get_fixed_array(&value, &manuf_data, &len);
+		dbus_message_iter_get_fixed_array(&array, &manuf_data, &len);
 
 		DBG("Adding ManufacturerData for %04x", manuf_id);
 
@@ -340,7 +342,7 @@ static bool parse_advertising_service_data(GDBusProxy *proxy,
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter value, entry;
+		DBusMessageIter value, entry, array;
 		const char *uuid_str;
 		bt_uuid_t uuid;
 		uint8_t *service_data;
@@ -353,15 +355,17 @@ static bool parse_advertising_service_data(GDBusProxy *proxy,
 			goto fail;
 
 		dbus_message_iter_next(&entry);
-		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_ARRAY)
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
 			goto fail;
 
-		dbus_message_iter_recurse(&entry, &value);
+		dbus_message_iter_recurse(&value, &array);
 
-		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
 			goto fail;
 
-		dbus_message_iter_get_fixed_array(&value, &service_data, &len);
+		dbus_message_iter_get_fixed_array(&array, &service_data, &len);
 
 		DBG("Adding ServiceData for %s", uuid_str);
 
-- 
2.7.4

