Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/8] attrib-server: Add attributes in adapter database
Date: Tue, 27 Dec 2011 15:33:14 +0100
Message-Id: <1324996399-20245-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1324996399-20245-3-git-send-email-sancane@gmail.com>
References: <1324996399-20245-1-git-send-email-sancane@gmail.com>
 <1324996399-20245-2-git-send-email-sancane@gmail.com>
 <1324996399-20245-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each server has its own database so the global database list
will be removed. This patch makes a wrapper over attrib_db_add
function to get the default GATT server in order to add
attributes in the default adapter, int his way we keep backward
compatibility with the gatt server interface until the api is
updated.
---
 src/attrib-server.c |   95 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 88d6033..2e3e6f2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -61,6 +61,7 @@ struct gatt_server {
 	GIOChannel *le_io;
 	uint32_t gatt_sdp_handle;
 	uint32_t gap_sdp_handle;
+	GSList *database;
 };
 
 struct gatt_channel {
@@ -100,8 +101,18 @@ static bt_uuid_t ccc_uuid = {
 			.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
 };
 
+static void attrib_free(void *data)
+{
+	struct attribute *a = data;
+
+	g_free(a->data);
+	g_free(a);
+}
+
 static void gatt_server_free(struct gatt_server *server)
 {
+	g_slist_free_full(server->database, attrib_free);
+
 	if (server->l2cap_io != NULL) {
 		g_io_channel_unref(server->l2cap_io);
 		g_io_channel_shutdown(server->l2cap_io, FALSE, NULL);
@@ -227,7 +238,8 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 	return attrib1->handle - attrib2->handle;
 }
 
-static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
+static struct attribute *find_primary_range(struct gatt_server *server,
+						uint16_t start, uint16_t *end)
 {
 	struct attribute *attrib;
 	guint h = start;
@@ -236,7 +248,8 @@ static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 	if (end == NULL)
 		return NULL;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+								handle_cmp);
 	if (!l)
 		return NULL;
 
@@ -269,7 +282,7 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 	uuid_t svc, gap_uuid;
 	bdaddr_t addr;
 
-	a = find_primary_range(handle, &end);
+	a = find_primary_range(server, handle, &end);
 
 	if (a == NULL)
 		return 0;
@@ -303,6 +316,33 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 	return 0;
 }
 
+static struct attribute *attrib_db_add_new(struct gatt_server *server,
+				uint16_t handle, bt_uuid_t *uuid, int read_reqs,
+				int write_reqs, const uint8_t *value, int len)
+{
+	struct attribute *a;
+	guint h = handle;
+
+	DBG("handle=0x%04x", handle);
+
+	if (g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
+								handle_cmp))
+		return NULL;
+
+	a = g_new0(struct attribute, 1);
+	a->len = len;
+	a->data = g_memdup(value, len);
+	a->handle = handle;
+	a->uuid = *uuid;
+	a->read_reqs = read_reqs;
+	a->write_reqs = write_reqs;
+
+	server->database = g_slist_insert_sorted(server->database, a,
+								attribute_cmp);
+
+	return a;
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
@@ -794,14 +834,6 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
-static void attrib_free(void *data)
-{
-	struct attribute *a = data;
-
-	g_free(a->data);
-	g_free(a);
-}
-
 static void channel_free(struct gatt_channel *channel)
 {
 	g_attrib_unref(channel->attrib);
@@ -1062,7 +1094,8 @@ static gboolean register_core_services(struct gatt_server *server)
 	/* GAP service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add_new(server, 0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	/* GAP service: device name characteristic */
 	name_handle = 0x0006;
@@ -1070,12 +1103,13 @@ static gboolean register_core_services(struct gatt_server *server)
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(name_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
-	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add_new(server, 0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* GAP service: device name attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	attrib_db_add(name_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-								NULL, 0);
+	attrib_db_add_new(server, name_handle, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, NULL, 0);
 
 	/* GAP service: device appearance characteristic */
 	appearance_handle = 0x0008;
@@ -1083,13 +1117,14 @@ static gboolean register_core_services(struct gatt_server *server)
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(appearance_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
-	attrib_db_add(0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add_new(server, 0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 5);
 
 	/* GAP service: device appearance attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	att_put_u16(appearance, &atval[0]);
-	attrib_db_add(appearance_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-								atval, 2);
+	attrib_db_add_new(server, appearance_handle, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 2);
 	server->gap_sdp_handle = attrib_create_sdp_new(server, 0x0001,
 						"Generic Access Profile");
 	if (server->gap_sdp_handle == 0) {
@@ -1100,7 +1135,8 @@ static gboolean register_core_services(struct gatt_server *server)
 	/* GATT service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add_new(server, 0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 2);
 
 	server->gatt_sdp_handle = attrib_create_sdp_new(server, 0x0010,
 						"Generic Attribute Profile");
@@ -1232,25 +1268,16 @@ uint16_t attrib_db_find_avail(uint16_t nitems)
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len)
 {
-	struct attribute *a;
-	guint h = handle;
+	struct gatt_server *server;
 
-	DBG("handle=0x%04x", handle);
+	DBG("Deprecated function!");
 
-	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
+	server = get_default_gatt_server();
+	if (server == NULL)
 		return NULL;
 
-	a = g_new0(struct attribute, 1);
-	a->len = len;
-	a->data = g_memdup(value, len);
-	a->handle = handle;
-	a->uuid = *uuid;
-	a->read_reqs = read_reqs;
-	a->write_reqs = write_reqs;
-
-	database = g_slist_insert_sorted(database, a, attribute_cmp);
-
-	return a;
+	return attrib_db_add_new(server, handle, uuid, read_reqs, write_reqs,
+								value, len);
 }
 
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
-- 
1.7.8.1

