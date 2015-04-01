Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v8 03/10] core/advertising: Parse ServiceUUIDs
Date: Wed,  1 Apr 2015 14:09:55 -0700
Message-Id: <1427922602-6253-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
References: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the ServiceUUIDs property of the LEAdvertisement1 object.
---
 src/advertising.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 275e2d7..9867e1e 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -166,6 +166,45 @@ static bool parse_advertising_type(GDBusProxy *proxy, uint8_t *type)
 	return false;
 }
 
+static bool parse_advertising_service_uuids(GDBusProxy *proxy,
+					struct bt_ad *data)
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
+	bt_ad_clear_service_uuid(data);
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
+		if (!bt_ad_add_service_uuid(data, &uuid))
+			goto fail;
+
+		dbus_message_iter_next(&ariter);
+	}
+
+	return true;
+
+fail:
+	bt_ad_clear_service_uuid(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -178,7 +217,12 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
-	/* TODO: parse the remaining properties into a shared structure */
+	if (!parse_advertising_service_uuids(ad->proxy, ad->data)) {
+		error("Property \"ServiceUUIDs\" failed to parse");
+		return false;
+	}
+
+	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
 
-- 
2.2.0.rc0.207.ga3a616c

