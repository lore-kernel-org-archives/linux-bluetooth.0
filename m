Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/8] attrib-server: Set database uuids as a double linked list
Date: Wed, 25 Jan 2012 11:03:07 +0100
Message-Id: <1327485790-26249-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1327485790-26249-5-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
 <1327485790-26249-2-git-send-email-sancane@gmail.com>
 <1327485790-26249-3-git-send-email-sancane@gmail.com>
 <1327485790-26249-4-git-send-email-sancane@gmail.com>
 <1327485790-26249-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

16-bit UUIDs are allocated at the begining of the database list and
128-bit ones are grouped at the end. Replacing the list type with a double
linked one enables us to look for available handles in the 128-bit group
efficiently.
---
 src/attrib-server.c |   75 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2b50fe4..3f72ff8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -60,7 +60,7 @@ struct gatt_server {
 	GIOChannel *le_io;
 	uint32_t gatt_sdp_handle;
 	uint32_t gap_sdp_handle;
-	GSList *database;
+	GList *database;
 	GSList *clients;
 	uint16_t name_handle;
 	uint16_t appearance_handle;
@@ -114,7 +114,7 @@ static void channel_free(struct gatt_channel *channel)
 
 static void gatt_server_free(struct gatt_server *server)
 {
-	g_slist_free_full(server->database, attrib_free);
+	g_list_free_full(server->database, attrib_free);
 
 	if (server->l2cap_io != NULL) {
 		g_io_channel_unref(server->l2cap_io);
@@ -254,12 +254,12 @@ static struct attribute *find_primary_range(struct gatt_server *server,
 {
 	struct attribute *attrib;
 	guint h = start;
-	GSList *l;
+	GList *l;
 
 	if (end == NULL)
 		return NULL;
 
-	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+	l = g_list_find_custom(server->database, GUINT_TO_POINTER(h),
 								handle_cmp);
 	if (!l)
 		return NULL;
@@ -336,7 +336,7 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
 
 	DBG("handle=0x%04x", handle);
 
-	if (g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+	if (g_list_find_custom(server->database, GUINT_TO_POINTER(h),
 								handle_cmp))
 		return NULL;
 
@@ -348,7 +348,7 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
 	a->read_reqs = read_reqs;
 	a->write_reqs = write_reqs;
 
-	server->database = g_slist_insert_sorted(server->database, a,
+	server->database = g_list_insert_sorted(server->database, a,
 								attribute_cmp);
 
 	return a;
@@ -395,7 +395,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	struct att_data_list *adl;
 	struct attribute *a;
 	struct group_elem *cur, *old = NULL;
-	GSList *l, *groups, *database;
+	GSList *l, *groups;
+	GList *dl, *database;
 	uint16_t length, last_handle, last_size = 0;
 	uint8_t status;
 	int i;
@@ -416,9 +417,9 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	last_handle = end;
 	database = channel->server->database;
-	for (l = database, groups = NULL, cur = NULL; l; l = l->next) {
+	for (dl = database, groups = NULL, cur = NULL; dl; dl = dl->next) {
 
-		a = l->data;
+		a = dl->data;
 
 		if (a->handle < start)
 			continue;
@@ -472,7 +473,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, start,
 					ATT_ECODE_ATTR_NOT_FOUND, pdu, len);
 
-	if (l == NULL)
+	if (dl == NULL)
 		cur->end = a->handle;
 	else
 		cur->end = last_handle;
@@ -507,7 +508,8 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
-	GSList *l, *types, *database;
+	GSList *l, *types;
+	GList *dl, *database;
 	struct attribute *a;
 	uint16_t num, length;
 	uint8_t status;
@@ -518,9 +520,9 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
 	database = channel->server->database;
-	for (l = database, length = 0, types = NULL; l; l = l->next) {
+	for (dl = database, length = 0, types = NULL; dl; dl = dl->next) {
 
-		a = l->data;
+		a = dl->data;
 
 		if (a->handle < start)
 			continue;
@@ -589,7 +591,8 @@ static int find_info(struct gatt_channel *channel, uint16_t start, uint16_t end,
 {
 	struct attribute *a;
 	struct att_data_list *adl;
-	GSList *l, *info, *database;
+	GSList *l, *info;
+	GList *dl, *database;
 	uint8_t format, last_type = BT_UUID_UNSPEC;
 	uint16_t length, num;
 	int i;
@@ -599,8 +602,8 @@ static int find_info(struct gatt_channel *channel, uint16_t start, uint16_t end,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
 	database = channel->server->database;
-	for (l = database, info = NULL, num = 0; l; l = l->next) {
-		a = l->data;
+	for (dl = database, info = NULL, num = 0; dl; dl = dl->next) {
+		a = dl->data;
 
 		if (a->handle < start)
 			continue;
@@ -664,7 +667,8 @@ static int find_by_type(struct gatt_channel *channel, uint16_t start,
 {
 	struct attribute *a;
 	struct att_range *range;
-	GSList *l, *matches, *database;
+	GSList *matches;
+	GList *dl, *database;
 	int len;
 
 	if (start > end || start == 0x0000)
@@ -673,8 +677,8 @@ static int find_by_type(struct gatt_channel *channel, uint16_t start,
 
 	/* Searching first requested handle number */
 	database = channel->server->database;
-	for (l = database, matches = NULL, range = NULL; l; l = l->next) {
-		a = l->data;
+	for (dl = database, matches = NULL, range = NULL; dl; dl = dl->next) {
+		a = dl->data;
 
 		if (a->handle < start)
 			continue;
@@ -721,11 +725,11 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 {
 	struct attribute *a;
 	uint8_t status;
-	GSList *l;
+	GList *l;
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(channel->server->database,
+	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_REQ, handle,
@@ -759,11 +763,11 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 {
 	struct attribute *a;
 	uint8_t status;
-	GSList *l;
+	GList *l;
 	uint16_t cccval;
 	guint h = handle;
 
-	l = g_slist_find_custom(channel->server->database,
+	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
@@ -803,10 +807,10 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 {
 	struct attribute *a;
 	uint8_t status;
-	GSList *l;
+	GList *l;
 	guint h = handle;
 
-	l = g_slist_find_custom(channel->server->database,
+	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle,
@@ -1275,6 +1279,7 @@ static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
 	struct gatt_server *server;
 	uint16_t handle;
 	GSList *l;
+	GList *dl;
 
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
 	if (l == NULL)
@@ -1284,8 +1289,8 @@ static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
 	if (server->database == NULL)
 		return 0x0001;
 
-	for (l = server->database, handle = 0x0001; l; l = l->next) {
-		struct attribute *a = l->data;
+	for (dl = server->database, handle = 0x0001; dl; dl = dl->next) {
+		struct attribute *a = dl->data;
 
 		if ((bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0) &&
@@ -1357,6 +1362,7 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 	struct gatt_server *server;
 	struct attribute *a;
 	GSList *l;
+	GList *dl;
 	guint h = handle;
 
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
@@ -1367,12 +1373,12 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+	dl = g_list_find_custom(server->database, GUINT_TO_POINTER(h),
 								handle_cmp);
-	if (!l)
+	if (dl == NULL)
 		return -ENOENT;
 
-	a = l->data;
+	a = dl->data;
 
 	a->data = g_try_realloc(a->data, len);
 	if (a->data == NULL)
@@ -1395,6 +1401,7 @@ int attrib_db_del(struct btd_adapter *adapter, uint16_t handle)
 	struct gatt_server *server;
 	struct attribute *a;
 	GSList *l;
+	GList *dl;
 	guint h = handle;
 
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
@@ -1405,13 +1412,13 @@ int attrib_db_del(struct btd_adapter *adapter, uint16_t handle)
 
 	DBG("handle=0x%04x", handle);
 
-	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+	dl = g_list_find_custom(server->database, GUINT_TO_POINTER(h),
 								handle_cmp);
-	if (!l)
+	if (dl == NULL)
 		return -ENOENT;
 
-	a = l->data;
-	server->database = g_slist_remove(server->database, a);
+	a = dl->data;
+	server->database = g_list_remove(server->database, a);
 	g_free(a->data);
 	g_free(a);
 
-- 
1.7.8.4

