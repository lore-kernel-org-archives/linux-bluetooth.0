Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] obexd: Read SDP attributes when instantiating MAP session
Date: Tue,  9 Apr 2013 13:54:06 +0200
Message-Id: <1365508448-13171-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Parse the SDP attributes mas_instance_id and supported_message_types from
the transport's service attributes as soon as a connection is established.
---
 obexd/client/map.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 25aedb7..b39eaa5 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -39,6 +39,8 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "sdp.h"
+#include "sdp_lib.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -94,6 +96,8 @@ struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
 	GHashTable *messages;
+	int16_t mas_instance_id;
+	uint8_t supported_message_types;
 };
 
 #define MAP_MSG_FLAG_PRIORITY	0x01
@@ -1731,6 +1735,30 @@ static void map_free(void *data)
 	g_free(map);
 }
 
+static void parse_service_record(struct map_data *map)
+{
+	sdp_data_t *data;
+	const sdp_record_t *rec = obc_session_get_service_record(map->session);
+
+	if (!rec)
+		return;
+
+	/* MAS instance id */
+	map->mas_instance_id = -1;
+	data = sdp_data_get(rec, SDP_ATTR_MAS_INSTANCE_ID);
+	if (data != NULL)
+		map->mas_instance_id = data->val.uint8;
+	else
+		DBG("Failed to read MAS instance id");
+
+	/* Supported Message Types */
+	data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_MESSAGE_TYPES);
+	if (data != NULL)
+		map->supported_message_types = data->val.uint8;
+	else
+		DBG("Failed to read supported message types");
+}
+
 static int map_probe(struct obc_session *session)
 {
 	struct map_data *map;
@@ -1738,8 +1766,6 @@ static int map_probe(struct obc_session *session)
 
 	path = obc_session_get_path(session);
 
-	DBG("%s", path);
-
 	map = g_try_new0(struct map_data, 1);
 	if (!map)
 		return -ENOMEM;
@@ -1748,6 +1774,10 @@ static int map_probe(struct obc_session *session)
 	map->messages = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
 								map_msg_remove);
 
+	parse_service_record(map);
+
+	DBG("%s, instance id %d", path, map->mas_instance_id);
+
 	set_notification_registration(map, TRUE);
 
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
-- 
1.8.2.1

