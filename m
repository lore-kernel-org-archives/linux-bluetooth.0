Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/advertising: Fix crash when passing invalid dictionary
Date: Thu, 17 Nov 2016 16:12:00 +0200
Message-Id: <1479391920-31828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We expect dict entries to have a{sv} format but the code don't check if
the entries really encode the variant which may lead to a crash in
dbus_message_iter_recurse.
---
 src/advertising.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index ef84e45..e7840bf 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -298,6 +298,10 @@ static bool parse_advertising_manufacturer_data(GDBusProxy *proxy,
 		dbus_message_iter_get_basic(&entry, &manuf_id);
 
 		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto fail;
+
 		dbus_message_iter_recurse(&entry, &value);
 
 		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
@@ -356,6 +360,10 @@ static bool parse_advertising_service_data(GDBusProxy *proxy,
 			goto fail;
 
 		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto fail;
+
 		dbus_message_iter_recurse(&entry, &value);
 
 		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
-- 
2.7.4

