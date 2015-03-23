Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v4 12/15] advertising-manager: Parse SolicitUUIDs
Date: Mon, 23 Mar 2015 08:11:04 -0700
Message-Id: <1427123467-13445-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
References: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the SolicitUUIDs property of the LEAdvertisement1 object.
---
 src/advertising-manager.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index bf447cd..08cc4e4 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -206,6 +206,44 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_solicit_uuids(GDBusProxy *proxy,
+					struct advertising_data *data)
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
+	advertising_data_clear_solicit_uuid(data);
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
+		advertising_data_add_solicit_uuid(data, &uuid);
+
+		dbus_message_iter_next(&ariter);
+	}
+
+	return true;
+
+fail:
+	advertising_data_clear_solicit_uuid(data);
+	return false;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
 	DBG("Refreshing advertisement: %s", ad->path);
@@ -226,6 +264,11 @@ static bool parse_advertisement(struct advertisement *ad)
 		return false;
 	}
 
+	if (!parse_advertising_solicit_uuids(ad->proxy, ad->data)) {
+		error("Property \"SolicitUUIDs\" failed to parse correctly");
+		return false;
+	}
+
 	/* TODO: parse the rest of the properties */
 
 	refresh_advertisement(ad);
-- 
2.2.0.rc0.207.ga3a616c

