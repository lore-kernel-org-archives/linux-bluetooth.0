Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] obexd: Read service attributes when instantiating MAP session
Date: Fri, 12 Apr 2013 11:29:06 +0200
Message-Id: <1365758946-8682-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Parse the service attributes mas_instance_id and supported_message_types
from the transport's service attributes as soon as a connection is
established.
---
 obexd/client/map.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 3188a08..1fe103f 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -40,6 +40,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "sdp.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -95,6 +96,8 @@ struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
 	GHashTable *messages;
+	int16_t mas_instance_id;
+	uint8_t supported_message_types;
 };
 
 #define MAP_MSG_FLAG_PRIORITY	0x01
@@ -1729,6 +1732,28 @@ static void map_free(void *data)
 	g_free(map);
 }
 
+static void parse_service_record(struct map_data *map)
+{
+	const void *data;
+
+	/* MAS instance id */
+	map->mas_instance_id = -1;
+	data = obc_session_get_attribute(map->session,
+						SDP_ATTR_MAS_INSTANCE_ID);
+	if (data != NULL)
+		map->mas_instance_id = *(uint8_t *)data;
+	else
+		DBG("Failed to read MAS instance id");
+
+	/* Supported Message Types */
+	data = obc_session_get_attribute(map->session,
+					SDP_ATTR_SUPPORTED_MESSAGE_TYPES);
+	if (data != NULL)
+		map->supported_message_types = *(uint8_t *)data;
+	else
+		DBG("Failed to read supported message types");
+}
+
 static int map_probe(struct obc_session *session)
 {
 	struct map_data *map;
@@ -1736,8 +1761,6 @@ static int map_probe(struct obc_session *session)
 
 	path = obc_session_get_path(session);
 
-	DBG("%s", path);
-
 	map = g_try_new0(struct map_data, 1);
 	if (!map)
 		return -ENOMEM;
@@ -1746,6 +1769,10 @@ static int map_probe(struct obc_session *session)
 	map->messages = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
 								map_msg_remove);
 
+	parse_service_record(map);
+
+	DBG("%s, instance id %d", path, map->mas_instance_id);
+
 	set_notification_registration(map, true);
 
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
-- 
1.8.2.1

