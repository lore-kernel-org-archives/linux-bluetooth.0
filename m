Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] obexd: Register MAP notification handler
Date: Mon, 25 Feb 2013 09:36:09 +0100
Message-Id: <1361781370-19061-8-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1361781370-19061-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1361781370-19061-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/map.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 5b69978..f6596e2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -41,6 +41,7 @@
 #include "driver.h"
 #include "sdp.h"
 #include "sdp_lib.h"
+#include "map-dispatcher.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -98,6 +99,7 @@ struct map_data {
 	GHashTable *messages;
 	int16_t mas_instance_id;
 	uint8_t supported_message_types;
+	gboolean mns_acquired;
 };
 
 #define MAP_MSG_FLAG_PRIORITY	0x01
@@ -1711,6 +1713,12 @@ fail:
 	return reply;
 }
 
+static void map_handle_notification(struct map_event *event)
+{
+	DBG("event: type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
+				event->type, event->handle, event->folder,
+					event->old_folder, event->msg_type);
+}
 
 static DBusMessage *map_register_notifications(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
@@ -1730,9 +1738,22 @@ static DBusMessage *map_register_notifications(DBusConnection *connection,
 					ERROR_INTERFACE ".InvalidArguments",
 					NULL);
 
+	if (map->mns_acquired == status)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".InvalidArguments",
+					NULL);
+
 	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_NOTIFICATIONSTATUS,
 							status ? 0x01 : 0x00);
 
+	if (status) {
+		map->mns_acquired = TRUE;
+		map_acquire_mns(map->mas_instance_id, &map_handle_notification);
+	} else {
+		map->mns_acquired = FALSE;
+		map_release_mns(map->mas_instance_id);
+	}
+
 	return set_notification_registration(map, message, apparam);
 }
 
@@ -1784,6 +1805,9 @@ static void map_free(void *data)
 {
 	struct map_data *map = data;
 
+	if (map->mns_acquired)
+		map_release_mns(map->mas_instance_id);
+
 	obc_session_unref(map->session);
 	g_hash_table_unref(map->messages);
 	g_free(map);
-- 
1.8.1.4

