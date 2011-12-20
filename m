Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/8] attrib-server: Register GATT SDP record per each adapter
Date: Tue, 20 Dec 2011 16:57:55 +0100
Message-Id: <1324396681-27276-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1324396681-27276-2-git-send-email-sancane@gmail.com>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
 <1324396681-27276-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each adapter has its own SDP registry wich will be managed
separately. Furthermore, this patch makes a wrapper over
attrib_create_sdp function using the default adapter in order
to keep backward compatibility with the gatt server interface
until the api is finally updated.
---
 src/attrib-server.c |  207 +++++++++++++++++++++++++++++----------------------
 1 files changed, 119 insertions(+), 88 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 24778e5..68e8524 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -59,6 +59,8 @@ struct gatt_adapter {
 	struct btd_adapter *adapter;
 	GIOChannel *l2cap_io;
 	GIOChannel *le_io;
+	uint32_t gatt_sdp_handle;
+	uint32_t gap_sdp_handle;
 };
 
 struct gatt_channel {
@@ -80,8 +82,6 @@ struct group_elem {
 
 static GIOChannel *le_io = NULL;
 static GSList *clients = NULL;
-static uint32_t gatt_sdp_handle = 0;
-static uint32_t gap_sdp_handle = 0;
 
 /* GAP attribute handles */
 static uint16_t name_handle = 0x0000;
@@ -112,6 +112,12 @@ static void gatt_adapter_free(struct gatt_adapter *gadapter)
 		g_io_channel_shutdown(gadapter->le_io, FALSE, NULL);
 	}
 
+	if (gadapter->gatt_sdp_handle > 0)
+		remove_record_from_server(gadapter->gatt_sdp_handle);
+
+	if (gadapter->gap_sdp_handle > 0)
+		remove_record_from_server(gadapter->gap_sdp_handle);
+
 	if (gadapter->adapter != NULL)
 		btd_adapter_unref(gadapter->adapter);
 
@@ -129,6 +135,27 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static struct gatt_adapter *get_default_gatt_adapter(void)
+{
+	struct btd_adapter *adapter;
+	GSList *l;
+
+	adapter = manager_get_default_adapter();
+	if (adapter == NULL) {
+		error("Can't get default adapter");
+		return NULL;
+	}
+
+	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
+	if (l == NULL) {
+		error("Not GATT server initialized on adapter %s",
+						adapter_get_path(adapter));
+		return NULL;
+	}
+
+	return l->data;
+}
+
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
@@ -200,6 +227,82 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 	return attrib1->handle - attrib2->handle;
 }
 
+static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
+{
+	struct attribute *attrib;
+	guint h = start;
+	GSList *l;
+
+	if (end == NULL)
+		return NULL;
+
+	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	if (!l)
+		return NULL;
+
+	attrib = l->data;
+
+	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0)
+		return NULL;
+
+	*end = start;
+
+	for (l = l->next; l; l = l->next) {
+		struct attribute *a = l->data;
+
+		if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
+			break;
+
+		*end = a->handle;
+	}
+
+	return attrib;
+}
+
+static uint32_t attrib_create_sdp_new(struct gatt_adapter *gadapter,
+					uint16_t handle, const char *name)
+{
+	sdp_record_t *record;
+	struct attribute *a;
+	uint16_t end = 0;
+	uuid_t svc, gap_uuid;
+	bdaddr_t addr;
+
+	a = find_primary_range(handle, &end);
+
+	if (a == NULL)
+		return 0;
+
+	if (a->len == 2)
+		sdp_uuid16_create(&svc, att_get_u16(a->data));
+	else if (a->len == 16)
+		sdp_uuid128_create(&svc, a->data);
+	else
+		return 0;
+
+	record = server_record_new(&svc, handle, end);
+	if (record == NULL)
+		return 0;
+
+	if (name != NULL)
+		sdp_set_info_attr(record, name, "BlueZ", NULL);
+
+	sdp_uuid16_create(&gap_uuid, GENERIC_ACCESS_PROFILE_ID);
+	if (sdp_uuid_cmp(&svc, &gap_uuid) == 0) {
+		sdp_set_url_attr(record, "http://www.bluez.org/",
+				"http://www.bluez.org/",
+				"http://www.bluez.org/");
+	}
+
+	adapter_get_address(gadapter->adapter, &addr);
+	if (add_record_to_server(&addr, record) == 0)
+		return record->handle;
+
+	sdp_record_free(record);
+	return 0;
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
@@ -556,39 +659,6 @@ static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	return len;
 }
 
-static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
-{
-	struct attribute *attrib;
-	guint h = start;
-	GSList *l;
-
-	if (end == NULL)
-		return NULL;
-
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
-	if (!l)
-		return NULL;
-
-	attrib = l->data;
-
-	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0)
-		return NULL;
-
-	*end = start;
-
-	for (l = l->next; l; l = l->next) {
-		struct attribute *a = l->data;
-
-		if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
-				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
-			break;
-
-		*end = a->handle;
-	}
-
-	return attrib;
-}
-
 static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 							uint8_t *pdu, int len)
 {
@@ -983,7 +1053,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
-static gboolean register_core_services(void)
+static gboolean register_core_services(struct gatt_adapter *gadapter)
 {
 	uint8_t atval[256];
 	bt_uuid_t uuid;
@@ -1020,10 +1090,11 @@ static gboolean register_core_services(void)
 	att_put_u16(appearance, &atval[0]);
 	attrib_db_add(appearance_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
-	gap_sdp_handle = attrib_create_sdp(0x0001, "Generic Access Profile");
-	if (gap_sdp_handle == 0) {
+	gadapter->gap_sdp_handle = attrib_create_sdp_new(gadapter, 0x0001,
+						"Generic Access Profile");
+	if (gadapter->gap_sdp_handle == 0) {
 		error("Failed to register GAP service record");
-		goto failed;
+		return FALSE;
 	}
 
 	/* GATT service: primary service definition */
@@ -1031,20 +1102,14 @@ static gboolean register_core_services(void)
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
 	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
-	gatt_sdp_handle = attrib_create_sdp(0x0010,
+	gadapter->gatt_sdp_handle = attrib_create_sdp_new(gadapter, 0x0010,
 						"Generic Attribute Profile");
-	if (gatt_sdp_handle == 0) {
+	if (gadapter->gatt_sdp_handle == 0) {
 		error("Failed to register GATT service record");
-		goto failed;
+		return FALSE;
 	}
 
 	return TRUE;
-
-failed:
-	if (gap_sdp_handle)
-		remove_record_from_server(gap_sdp_handle);
-
-	return FALSE;
 }
 
 int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
@@ -1075,7 +1140,7 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 		return -1;
 	}
 
-	if (!register_core_services()) {
+	if (!register_core_services(gadapter)) {
 		gatt_adapter_free(gadapter);
 		return -1;
 	}
@@ -1116,53 +1181,19 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter)
 	g_slist_free_full(database, attrib_free);
 
 	g_slist_free_full(clients, (GDestroyNotify) channel_free);
-
-	if (gatt_sdp_handle)
-		remove_record_from_server(gatt_sdp_handle);
-
-	if (gap_sdp_handle)
-		remove_record_from_server(gap_sdp_handle);
 }
 
 uint32_t attrib_create_sdp(uint16_t handle, const char *name)
 {
-	sdp_record_t *record;
-	struct attribute *a;
-	uint16_t end = 0;
-	uuid_t svc, gap_uuid;
+	struct gatt_adapter *gadapter;
 
-	a = find_primary_range(handle, &end);
+	DBG("Deprecated function!");
 
-	if (a == NULL)
+	gadapter = get_default_gatt_adapter();
+	if (gadapter == NULL)
 		return 0;
 
-	if (a->len == 2)
-		sdp_uuid16_create(&svc, att_get_u16(a->data));
-	else if (a->len == 16)
-		sdp_uuid128_create(&svc, a->data);
-	else
-		return 0;
-
-	record = server_record_new(&svc, handle, end);
-	if (record == NULL)
-		return 0;
-
-	if (name)
-		sdp_set_info_attr(record, name, "BlueZ", NULL);
-
-	sdp_uuid16_create(&gap_uuid, GENERIC_ACCESS_PROFILE_ID);
-	if (sdp_uuid_cmp(&svc, &gap_uuid) == 0) {
-		sdp_set_url_attr(record, "http://www.bluez.org/",
-				"http://www.bluez.org/",
-				"http://www.bluez.org/");
-	}
-
-	if (add_record_to_server(BDADDR_ANY, record) < 0)
-		sdp_record_free(record);
-	else
-		return record->handle;
-
-	return 0;
+	return attrib_create_sdp_new(gadapter, handle, name);
 }
 
 void attrib_free_sdp(uint32_t sdp_handle)
-- 
1.7.8

