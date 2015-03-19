Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v3 11/15] advertising-manager: Parse ServiceUUIDs
Date: Thu, 19 Mar 2015 10:34:33 -0700
Message-Id: <1426786477-27229-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
References: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ServiceUUIDs property of the LEAdvertisement1 object.
---
 src/advertising-manager.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index e0259e4..18d0bf3 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -168,6 +168,44 @@ static bool parse_advertising_type(GDBusProxy *proxy, uint8_t *type)
 	return false;
 }
 
+static bool parse_advertising_service_uuids(GDBusProxy *proxy,
+					struct advertising_data *data)
+{
+	DBusMessageIter iter, ariter;
+
+	if (!g_dbus_proxy_get_property(proxy, "ServiceUUIDs", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &ariter);
+
+	advertising_data_clear_service_uuid(data);
+
+	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
+		const char *uuid_str;
+		bt_uuid_t uuid;
+
+		dbus_message_iter_get_basic(&ariter, &uuid_str);
+
+		DBG("Adding ServiceUUID: %s", uuid_str);
+
+		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
+			goto fail;
+
+		advertising_data_add_service_uuid(data, &uuid);
+
+		dbus_message_iter_next(&ariter);
+	}
+
+	return true;
+
+fail:
+	advertising_data_clear_service_uuid(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -183,7 +221,12 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
-	/* TODO: parse the remaining properties into a shared structure */
+	if (!parse_advertising_service_uuids(ad->proxy, ad->data)) {
+		error("Property \"ServiceUUIDs\" failed to parse correctly");
+		return false;
+	}
+
+	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
 
-- 
2.2.0.rc0.207.ga3a616c

