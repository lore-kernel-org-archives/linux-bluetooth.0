Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v9 04/12] core/advertising: Parse SolicitUUIDs
Date: Thu,  2 Apr 2015 11:59:20 -0700
Message-Id: <1428001168-32822-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the SolicitUUIDs property of the LEAdvertisement1 object.
---
 src/advertising.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 9867e1e..d736ea9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -205,6 +205,45 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_solicit_uuids(GDBusProxy *proxy,
+							struct bt_ad *data)
+{
+	DBusMessageIter iter, ariter;
+
+	if (!g_dbus_proxy_get_property(proxy, "SolicitUUIDs", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &ariter);
+
+	bt_ad_clear_solicit_uuid(data);
+
+	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
+		const char *uuid_str;
+		bt_uuid_t uuid;
+
+		dbus_message_iter_get_basic(&ariter, &uuid_str);
+
+		DBG("Adding SolicitUUID: %s", uuid_str);
+
+		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
+			goto fail;
+
+		if (!bt_ad_add_solicit_uuid(data, &uuid))
+			goto fail;
+
+		dbus_message_iter_next(&ariter);
+	}
+
+	return true;
+
+fail:
+	bt_ad_clear_solicit_uuid(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -222,6 +261,11 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_solicit_uuids(ad->proxy, ad->data)) {
+		error("Property \"SolicitUUIDs\" failed to parse");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
-- 
2.2.0.rc0.207.ga3a616c

