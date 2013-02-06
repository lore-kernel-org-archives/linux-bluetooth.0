Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/8] obexd: Read MAP client SDP attributes
Date: Wed,  6 Feb 2013 15:45:17 +0100
Message-Id: <1360161922-6585-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Parse SDP attributes mas_instance_id and supported_message_types from
the transport's service attributes as soon as a connection is
established.
---
 lib/sdp.h          |  2 ++
 obexd/client/map.c | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index a81e857..c3a0261 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -294,6 +294,8 @@ extern "C" {
 #define SDP_ATTR_SUPPORTED_FUNCTIONS		0x0312
 #define SDP_ATTR_TOTAL_IMAGING_DATA_CAPACITY	0x0313
 #define SDP_ATTR_SUPPORTED_REPOSITORIES		0x0314
+#define SDP_ATTR_MAS_INSTANCE_ID		0x0315
+#define SDP_ATTR_SUPPORTED_MESSAGE_TYPES	0x0316
 
 #define SDP_ATTR_SPECIFICATION_ID		0x0200
 #define SDP_ATTR_VENDOR_ID			0x0201
diff --git a/obexd/client/map.c b/obexd/client/map.c
index ea5681a..463d905 100644
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
@@ -93,6 +95,8 @@ struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
 	GHashTable *messages;
+	int16_t mas_instance_id;
+	uint8_t supported_message_types;
 };
 
 #define MAP_MSG_FLAG_PRIORITY	0x01
@@ -1538,6 +1542,30 @@ static void map_free(void *data)
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
@@ -1545,8 +1573,6 @@ static int map_probe(struct obc_session *session)
 
 	path = obc_session_get_path(session);
 
-	DBG("%s", path);
-
 	map = g_try_new0(struct map_data, 1);
 	if (!map)
 		return -ENOMEM;
@@ -1555,6 +1581,10 @@ static int map_probe(struct obc_session *session)
 	map->messages = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
 								map_msg_remove);
 
+	parse_service_record(map);
+
+	DBG("%s, instance id %d", path, map->mas_instance_id);
+
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
 					NULL, NULL, map, map_free)) {
 		map_free(map);
@@ -1579,6 +1609,7 @@ static struct obc_driver map = {
 	.uuid = MAS_UUID,
 	.target = OBEX_MAS_UUID,
 	.target_len = OBEX_MAS_UUID_LEN,
+	.force_service_lookup = TRUE,
 	.probe = map_probe,
 	.remove = map_remove
 };
-- 
1.8.1.2

