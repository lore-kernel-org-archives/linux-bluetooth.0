Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/8] attrib-server: Remove global database list
Date: Tue, 27 Dec 2011 15:33:17 +0100
Message-Id: <1324996399-20245-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1324996399-20245-6-git-send-email-sancane@gmail.com>
References: <1324996399-20245-1-git-send-email-sancane@gmail.com>
 <1324996399-20245-2-git-send-email-sancane@gmail.com>
 <1324996399-20245-3-git-send-email-sancane@gmail.com>
 <1324996399-20245-4-git-send-email-sancane@gmail.com>
 <1324996399-20245-5-git-send-email-sancane@gmail.com>
 <1324996399-20245-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each server use its own databa list to manage handlers so all
operations should managed separately by each GATT server instead
of using a global handler list.
---
 src/attrib-server.c |   67 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index d987d76..219c7c9 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -52,7 +52,6 @@
 
 #include "attrib-server.h"
 
-static GSList *database = NULL;
 static GSList *servers = NULL;
 
 struct gatt_server {
@@ -419,7 +418,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	struct att_data_list *adl;
 	struct attribute *a;
 	struct group_elem *cur, *old = NULL;
-	GSList *l, *groups;
+	GSList *l, *groups, *database;
 	uint16_t length, last_handle, last_size = 0;
 	uint8_t status;
 	int i;
@@ -439,6 +438,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
 
 	last_handle = end;
+	database = channel->server->database;
 	for (l = database, groups = NULL, cur = NULL; l; l = l->next) {
 
 		a = l->data;
@@ -530,7 +530,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
-	GSList *l, *types;
+	GSList *l, *types, *database;
 	struct attribute *a;
 	uint16_t num, length;
 	uint8_t status;
@@ -540,6 +540,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ, start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
+	database = channel->server->database;
 	for (l = database, length = 0, types = NULL; l; l = l->next) {
 
 		a = l->data;
@@ -606,11 +607,12 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 	return length;
 }
 
-static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
+static int find_info(struct gatt_channel *channel, uint16_t start, uint16_t end,
+							uint8_t *pdu, int len)
 {
 	struct attribute *a;
 	struct att_data_list *adl;
-	GSList *l, *info;
+	GSList *l, *info, *database;
 	uint8_t format, last_type = BT_UUID_UNSPEC;
 	uint16_t length, num;
 	int i;
@@ -619,6 +621,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
+	database = channel->server->database;
 	for (l = database, info = NULL, num = 0; l; l = l->next) {
 		a = l->data;
 
@@ -678,12 +681,13 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	return length;
 }
 
-static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-			const uint8_t *value, int vlen, uint8_t *opdu, int mtu)
+static int find_by_type(struct gatt_channel *channel, uint16_t start,
+			uint16_t end, bt_uuid_t *uuid, const uint8_t *value,
+					int vlen, uint8_t *opdu, int mtu)
 {
 	struct attribute *a;
 	struct att_range *range;
-	GSList *l, *matches;
+	GSList *l, *matches, *database;
 	int len;
 
 	if (start > end || start == 0x0000)
@@ -691,6 +695,7 @@ static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 					ATT_ECODE_INVALID_HANDLE, opdu, mtu);
 
 	/* Searching first requested handle number */
+	database = channel->server->database;
 	for (l = database, matches = NULL, range = NULL; l; l = l->next) {
 		a = l->data;
 
@@ -743,7 +748,8 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->server->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_REQ, handle,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -780,7 +786,8 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->server->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -822,7 +829,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	GSList *l;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->server->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle,
 				ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -950,7 +958,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = find_info(start, end, opdu, channel->mtu);
+		length = find_info(channel, start, end, opdu, channel->mtu);
 		break;
 	case ATT_OP_WRITE_REQ:
 		length = dec_write_req(ipdu, len, &start, value, &vlen);
@@ -976,7 +984,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = find_by_type(start, end, &uuid, value, vlen,
+		length = find_by_type(channel, start, end, &uuid, value, vlen,
 							opdu, channel->mtu);
 		break;
 	case ATT_OP_HANDLE_CNF:
@@ -1253,8 +1261,6 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 	server = l->data;
 	servers = g_slist_remove(servers, server);
 	gatt_server_free(server);
-
-	g_slist_free_full(database, attrib_free);
 }
 
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
@@ -1277,12 +1283,19 @@ void attrib_free_sdp(uint32_t sdp_handle)
 
 uint16_t attrib_db_find_avail(uint16_t nitems)
 {
+	struct gatt_server *server;
 	uint16_t handle;
 	GSList *l;
 
+	DBG("Deprecated function!");
+
 	g_assert(nitems > 0);
 
-	for (l = database, handle = 0; l; l = l->next) {
+	server = get_default_gatt_server();
+	if (server == NULL)
+		return 0;
+
+	for (l = server->database, handle = 0; l; l = l->next) {
 		struct attribute *a = l->data;
 
 		if (handle && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
@@ -1321,13 +1334,21 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr)
 {
+	struct gatt_server *server;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
 
+	DBG("Deprecated function!");
+
+	server = get_default_gatt_server();
+	if (server == NULL)
+		return -ENOENT;
+
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+								handle_cmp);
 	if (!l)
 		return -ENOENT;
 
@@ -1351,18 +1372,26 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 
 int attrib_db_del(uint16_t handle)
 {
+	struct gatt_server *server;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
 
+	DBG("Deprecated function!");
+
+	server = get_default_gatt_server();
+	if (server == NULL)
+		return -ENOENT;
+
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+								handle_cmp);
 	if (!l)
 		return -ENOENT;
 
 	a = l->data;
-	database = g_slist_remove(database, a);
+	server->database = g_slist_remove(server->database, a);
 	g_free(a->data);
 	g_free(a);
 
-- 
1.7.8.1

