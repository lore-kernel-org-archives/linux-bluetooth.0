Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 12/18] Clean up the primary service DBus registration
Date: Tue, 21 Dec 2010 19:26:34 -0200
Message-Id: <1292966800-6264-13-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now, that much of this funcionality was moved to the core, we can go
straight to the registration of DBus interfaces.
---
 attrib/client.c |  223 ++++++++-----------------------------------------------
 1 files changed, 32 insertions(+), 191 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 9fcaaf8..0eadf1e 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -73,10 +73,8 @@ struct format {
 
 struct primary {
 	struct gatt_service *gatt;
+	struct att_primary *att;
 	char *path;
-	uuid_t uuid;
-	uint16_t start;
-	uint16_t end;
 	GSList *chars;
 	GSList *watchers;
 };
@@ -583,21 +581,6 @@ static GDBusMethodTable char_methods[] = {
 	{ }
 };
 
-static void register_primary(struct gatt_service *gatt)
-{
-	GSList *l;
-
-	for (l = gatt->primary; l; l = l->next) {
-		struct primary *prim = l->data;
-		g_dbus_register_interface(connection, prim->path,
-				CHAR_INTERFACE, prim_methods,
-				NULL, NULL, prim, NULL);
-		DBG("Registered: %s", prim->path);
-
-		btd_device_add_service(gatt->dev, prim->path);
-	}
-}
-
 static char *characteristic_list_to_string(GSList *chars)
 {
 	GString *characteristics;
@@ -631,10 +614,11 @@ static void store_characteristics(struct gatt_service *gatt,
 							struct primary *prim)
 {
 	char *characteristics;
+	struct att_primary *att = prim->att;
 
 	characteristics = characteristic_list_to_string(prim->chars);
 
-	write_device_characteristics(&gatt->sba, &gatt->dba, prim->start,
+	write_device_characteristics(&gatt->sba, &gatt->dba, att->start,
 							characteristics);
 
 	g_free(characteristics);
@@ -698,6 +682,7 @@ static GSList *string_to_characteristic_list(struct primary *prim,
 static void load_characteristics(gpointer data, gpointer user_data)
 {
 	struct primary *prim = data;
+	struct att_primary *att = prim->att;
 	struct gatt_service *gatt = user_data;
 	GSList *chrs_list;
 	char *str;
@@ -707,7 +692,7 @@ static void load_characteristics(gpointer data, gpointer user_data)
 		return;
 	}
 
-	str = read_device_characteristics(&gatt->sba, &gatt->dba, prim->start);
+	str = read_device_characteristics(&gatt->sba, &gatt->dba, att->start);
 	if (str == NULL)
 		return;
 
@@ -905,6 +890,7 @@ static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct query_data *current = user_data;
 	struct primary *prim = current->prim;
+	struct att_primary *att = prim->att;
 	struct gatt_service *gatt = prim->gatt;
 	struct att_data_list *list;
 	uint16_t last, *previous_end = NULL;
@@ -953,15 +939,15 @@ static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	if (previous_end)
-		*previous_end = prim->end;
+		*previous_end = att->end;
 
 	att_data_list_free(list);
 
-	if (last >= prim->end)
+	if (last >= att->end)
 		goto done;
 
 	/* Fetch remaining characteristics for the CURRENT primary service */
-	gatt_discover_char(gatt->attrib, last + 1, prim->end,
+	gatt_discover_char(gatt->attrib, last + 1, att->end,
 						char_discovered_cb, current);
 
 	return;
@@ -977,188 +963,43 @@ fail:
 	g_free(current);
 }
 
-static void *attr_data_from_string(const char *str)
-{
-	uint8_t *data;
-	int size, i;
-	char tmp[3];
-
-	size = strlen(str) / 2;
-	data = g_try_malloc0(size);
-	if (data == NULL)
-		return NULL;
-
-	tmp[2] = '\0';
-	for (i = 0; i < size; i++) {
-		memcpy(tmp, str + (i * 2), 2);
-		data[i] = (uint8_t) strtol(tmp, NULL, 16);
-	}
-
-	return data;
-}
-
-static int find_primary(gconstpointer a, gconstpointer b)
-{
-	const struct primary *primary = a;
-	uint16_t handle = GPOINTER_TO_UINT(b);
-
-	if (handle < primary->start)
-		return -1;
-
-	if (handle > primary->end)
-		return -1;
-
-	return 0;
-}
-
-static int find_characteristic(gconstpointer a, gconstpointer b)
+static void discover_all_char(gpointer data, gpointer user_data)
 {
-	const struct characteristic *chr = a;
-	uint16_t handle = GPOINTER_TO_UINT(b);
-
-	if (handle < chr->handle)
-		return -1;
+	struct query_data *qchr;
+	struct gatt_service *gatt = user_data;
+	struct primary *prim = data;
+	struct att_primary *att = prim->att;
 
-	if (handle > chr->end)
-		return -1;
+	qchr = g_new0(struct query_data, 1);
+	qchr->prim = prim;
 
-	return 0;
+	gatt->attrib = g_attrib_ref(gatt->attrib);
+	gatt_discover_char(gatt->attrib, att->start, att->end,
+						char_discovered_cb, qchr);
 }
 
-static void load_attribute_data(char *key, char *value, void *data)
+static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 {
-	struct gatt_service *gatt = data;
-	struct characteristic *chr;
-	struct primary *primary;
-	char addr[18], dst[18];
-	uint16_t handle;
-	uuid_t uuid;
 	GSList *l;
-	guint h;
-
-	if (sscanf(key, "%17s#%04hX", addr, &handle) < 2)
-		return;
-
-	ba2str(&gatt->dba, dst);
-
-	if (strcmp(addr, dst) != 0)
-		return;
-
-	h = handle;
-
-	l = g_slist_find_custom(gatt->primary, GUINT_TO_POINTER(h),
-								find_primary);
-	if (!l)
-		return;
-
-	primary = l->data;
-
-	l = g_slist_find_custom(primary->chars, GUINT_TO_POINTER(h),
-							find_characteristic);
-	if (!l)
-		return;
-
-	chr = l->data;
-
-	/* value[] contains "<UUID>#<data>", but bt_string2uuid() expects a
-	 * string containing only the UUID. To avoid creating a new buffer,
-	 * "truncate" the string in place before calling bt_string2uuid(). */
-	value[MAX_LEN_UUID_STR - 1] = '\0';
-	if (bt_string2uuid(&uuid, value) < 0)
-		return;
-
-	/* Fill the characteristic field according to the attribute type. */
-	if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0)
-		chr->desc = attr_data_from_string(value + MAX_LEN_UUID_STR);
-	else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0)
-		chr->format = attr_data_from_string(value + MAX_LEN_UUID_STR);
-}
-
-static GSList *string_to_primary_list(struct gatt_service *gatt,
-							const char *str)
-{
-	GSList *l = NULL;
-	char **services;
-	int i;
-
-	if (str == NULL)
-		return NULL;
 
-	services = g_strsplit(str, " ", 0);
-	if (services == NULL)
-		return NULL;
-
-	for (i = 0; services[i]; i++) {
+	for (l = primaries; l; l = l->next) {
+		struct att_primary *att = l->data;
 		struct primary *prim;
-		char uuidstr[MAX_LEN_UUID_STR + 1];
-		int ret;
 
 		prim = g_new0(struct primary, 1);
+		prim->att = att;
 		prim->gatt = gatt;
-
-		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->start,
-							&prim->end, uuidstr);
-
-		if (ret < 3) {
-			g_free(prim);
-			continue;
-		}
-
 		prim->path = g_strdup_printf("%s/service%04x", gatt->path,
-								prim->start);
-
-		bt_string2uuid(&prim->uuid, uuidstr);
-
-		l = g_slist_append(l, prim);
-	}
+								att->start);
 
-	g_strfreev(services);
-
-	return l;
-}
-
-static gboolean load_primary_services(struct gatt_service *gatt)
-{
-	GSList *primary_list;
-	char *str;
+		g_dbus_register_interface(connection, prim->path,
+				CHAR_INTERFACE, prim_methods,
+				NULL, NULL, prim, NULL);
+		DBG("Registered: %s", prim->path);
 
-	if (gatt->primary) {
-		DBG("Services already loaded");
-		return FALSE;
+		gatt->primary = g_slist_append(gatt->primary, prim);
+		load_characteristics(prim, gatt);
 	}
-
-	str = read_device_services(&gatt->sba, &gatt->dba);
-	if (str == NULL)
-		return FALSE;
-
-	primary_list = string_to_primary_list(gatt, str);
-
-	free(str);
-
-	if (primary_list == NULL)
-		return FALSE;
-
-	gatt->primary = primary_list;
-	register_primary(gatt);
-
-	g_slist_foreach(gatt->primary, load_characteristics, gatt);
-	read_device_attributes(&gatt->sba, load_attribute_data, gatt);
-
-	return TRUE;
-}
-
-static void discover_all_char(gpointer data, gpointer user_data)
-{
-	struct query_data *qchr;
-	struct gatt_service *gatt = user_data;
-	struct primary *prim = data;
-
-	qchr = g_new0(struct query_data, 1);
-	qchr->prim = prim;
-
-	gatt->attrib = g_attrib_ref(gatt->attrib);
-	gatt_discover_char(gatt->attrib, prim->start, prim->end,
-						char_discovered_cb, qchr);
 }
 
 int attrib_client_register(struct btd_device *device, int psm)
@@ -1166,6 +1007,7 @@ int attrib_client_register(struct btd_device *device, int psm)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
 	struct gatt_service *gatt;
+	GSList *primaries = btd_device_get_primaries(device);
 	bdaddr_t sba, dba;
 
 	adapter_get_address(adapter, &sba);
@@ -1179,8 +1021,7 @@ int attrib_client_register(struct btd_device *device, int psm)
 	bacpy(&gatt->dba, &dba);
 	gatt->psm = psm;
 
-	if (load_primary_services(gatt))
-		DBG("Primary services loaded");
+	register_primaries(gatt, primaries);
 
 	/* FIXME: just to avoid breaking the build */
 	if (FALSE)
-- 
1.7.3.4

