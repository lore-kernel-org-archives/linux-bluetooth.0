Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 08/11] attrib-server: Remove global database list
Date: Fri, 16 Dec 2011 17:09:56 +0100
Message-Id: <1324051799-21439-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-8-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
 <1324051799-21439-6-git-send-email-sancane@gmail.com>
 <1324051799-21439-7-git-send-email-sancane@gmail.com>
 <1324051799-21439-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each adapter use its own databa list to manage handlers so all
operations should managed in adapters instead of using a global
handler list.
---
 src/attrib-server.c |   68 ++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index ad2dfd5..61bb05b 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -52,9 +52,6 @@
 
 #include "attrib-server.h"
 
-static GSList *database = NULL;
-
-
 struct group_elem {
 	uint16_t handle;
 	uint16_t end;
@@ -425,7 +422,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	struct att_data_list *adl;
 	struct attribute *a;
 	struct group_elem *cur, *old = NULL;
-	GSList *l, *groups;
+	GSList *l, *groups, *database;
 	uint16_t length, last_handle, last_size = 0;
 	uint8_t status;
 	int i;
@@ -444,6 +441,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, 0x0000,
 					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
 
+	database = channel->gatt_adapter->database;
 	last_handle = end;
 	for (l = database, groups = NULL, cur = NULL; l; l = l->next) {
 
@@ -536,7 +534,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
-	GSList *l, *types;
+	GSList *l, *types, *database;
 	struct attribute *a;
 	uint16_t num, length;
 	uint8_t status;
@@ -546,6 +544,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ, start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
+	database = channel->gatt_adapter->database;
 	for (l = database, length = 0, types = NULL; l; l = l->next) {
 
 		a = l->data;
@@ -612,11 +611,12 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
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
@@ -625,6 +625,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
+	database = channel->gatt_adapter->database;
 	for (l = database, info = NULL, num = 0; l; l = l->next) {
 		a = l->data;
 
@@ -684,12 +685,13 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	return length;
 }
 
-static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-			const uint8_t *value, int vlen, uint8_t *opdu, int mtu)
+static int find_by_type(struct gatt_channel *channel, uint16_t start,
+			uint16_t end, bt_uuid_t *uuid, const uint8_t *value,
+			int vlen, uint8_t *opdu, int mtu)
 {
 	struct attribute *a;
 	struct att_range *range;
-	GSList *l, *matches;
+	GSList *l, *matches, *database;
 	int len;
 
 	if (start > end || start == 0x0000)
@@ -697,6 +699,7 @@ static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 					ATT_ECODE_INVALID_HANDLE, opdu, mtu);
 
 	/* Searching first requested handle number */
+	database = channel->gatt_adapter->database;
 	for (l = database, matches = NULL, range = NULL; l; l = l->next) {
 		a = l->data;
 
@@ -749,7 +752,8 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->gatt_adapter->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_REQ, handle,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -786,7 +790,8 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->gatt_adapter->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -828,7 +833,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	GSList *l;
 	guint h = handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(channel->gatt_adapter->database,
+					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle,
 				ATT_ECODE_INVALID_HANDLE, pdu, len);
@@ -965,7 +971,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = find_info(start, end, opdu, channel->mtu);
+		length = find_info(channel, start, end, opdu, channel->mtu);
 		break;
 	case ATT_OP_WRITE_REQ:
 		length = dec_write_req(ipdu, len, &start, value, &vlen);
@@ -991,7 +997,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = find_by_type(start, end, &uuid, value, vlen,
+		length = find_by_type(channel, start, end, &uuid, value, vlen,
 							opdu, channel->mtu);
 		break;
 	case ATT_OP_HANDLE_CNF:
@@ -1286,7 +1292,6 @@ int attrib_server_init(void)
 void attrib_server_exit(void)
 {
 	btd_unregister_adapter_driver(&attrib_adapter_driver);
-	g_slist_free_full(database, attrib_free);
 }
 
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
@@ -1309,12 +1314,19 @@ void attrib_free_sdp(uint32_t sdp_handle)
 
 uint16_t attrib_db_find_avail(uint16_t nitems)
 {
+	struct gatt_adapter *gatt_adapter;
 	uint16_t handle;
 	GSList *l;
 
+	DBG("Deprecated function");
+
 	g_assert(nitems > 0);
 
-	for (l = database, handle = 0; l; l = l->next) {
+	gatt_adapter = get_default_gatt_adapter();
+	if (gatt_adapter == NULL)
+		return 0;
+
+	for (l = gatt_adapter->database, handle = 0; l; l = l->next) {
 		struct attribute *a = l->data;
 
 		if (handle && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
@@ -1353,13 +1365,21 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr)
 {
+	struct gatt_adapter *gatt_adapter;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
 
+	DBG("Deprecated function!");
+
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	gatt_adapter = get_default_gatt_adapter();
+	if (gatt_adapter == NULL)
+		return -ENOENT;
+
+	l = g_slist_find_custom(gatt_adapter->database, GUINT_TO_POINTER(h),
+								handle_cmp);
 	if (!l)
 		return -ENOENT;
 
@@ -1383,18 +1403,26 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 
 int attrib_db_del(uint16_t handle)
 {
+	struct gatt_adapter *gatt_adapter;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
 
+	DBG("Deprecated function!");
+
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	gatt_adapter = get_default_gatt_adapter();
+	if (gatt_adapter == NULL)
+		return -ENOENT;
+
+	l = g_slist_find_custom(gatt_adapter->database, GUINT_TO_POINTER(h),
+								handle_cmp);
 	if (!l)
 		return -ENOENT;
 
 	a = l->data;
-	database = g_slist_remove(database, a);
+	gatt_adapter->database = g_slist_remove(gatt_adapter->database, a);
 	g_free(a->data);
 	g_free(a);
 
-- 
1.7.8

