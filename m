Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 05/11] Cleanup of primary service structs
Date: Tue, 12 Jul 2011 17:28:35 -0300
Message-Id: <1310502521-462-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get rid of local structure to store all GATT primary services of a
given device. "primary" struct has been renamed to "gatt_service"
to avoid misinterpretation or confusion with "att_primary".
---
 attrib/client.c |  332 ++++++++++++++++++++++++-------------------------------
 attrib/client.h |    2 +-
 src/device.c    |    2 +-
 3 files changed, 146 insertions(+), 190 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 98e25c7..482aff1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -53,15 +53,6 @@
 
 #define CHAR_INTERFACE "org.bluez.Characteristic"
 
-struct gatt_service {
-	struct btd_device *dev;
-	DBusConnection *conn;
-	GSList *primary;
-	GAttrib *attrib;
-	int psm;
-	gboolean listen;
-};
-
 struct format {
 	guint8 format;
 	guint8 exponent;
@@ -70,16 +61,20 @@ struct format {
 	guint16 desc;
 } __attribute__ ((packed));
 
-struct primary {
-	struct gatt_service *gatt;
-	struct att_primary *att;
+struct gatt_service {
+	struct btd_device *dev;
+	struct att_primary *prim;
+	DBusConnection *conn;
+	GAttrib *attrib;
+	int psm;
 	char *path;
 	GSList *chars;
 	GSList *watchers;
+	gboolean listen;
 };
 
 struct characteristic {
-	struct primary *prim;
+	struct gatt_service *gatt;
 	char *path;
 	uint16_t handle;
 	uint16_t end;
@@ -93,7 +88,7 @@ struct characteristic {
 };
 
 struct query_data {
-	struct primary *prim;
+	struct gatt_service *gatt;
 	struct characteristic *chr;
 	DBusMessage *msg;
 	uint16_t handle;
@@ -103,7 +98,7 @@ struct watcher {
 	guint id;
 	char *name;
 	char *path;
-	struct primary *prim;
+	struct gatt_service *gatt;
 };
 
 static GSList *gatt_services = NULL;
@@ -129,26 +124,11 @@ static void watcher_free(void *user_data)
 	g_free(watcher);
 }
 
-static void primary_free(void *user_data)
+static void gatt_service_free(struct gatt_service *gatt)
 {
-	struct primary *prim = user_data;
-	GSList *l;
-
-	for (l = prim->watchers; l; l = l->next) {
-		struct watcher *watcher = l->data;
-		g_dbus_remove_watch(prim->gatt->conn, watcher->id);
-	}
-
-	g_slist_free_full(prim->chars, characteristic_free);
-	g_free(prim->path);
-	g_free(prim);
-}
-
-static void gatt_service_free(void *user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	g_slist_free_full(gatt->primary, primary_free);
+	g_slist_free_full(gatt->watchers, watcher_free);
+	g_slist_free_full(gatt->chars, characteristic_free);
+	g_free(gatt->path);
 	g_attrib_unref(gatt->attrib);
 	btd_device_unref(gatt->dev);
 	dbus_connection_unref(gatt->conn);
@@ -166,14 +146,6 @@ static void gatt_get_address(struct gatt_service *gatt,
 	device_get_address(device, dba);
 }
 
-static int gatt_dev_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct gatt_service *gatt = a;
-	const struct btd_device *dev = b;
-
-	return gatt->dev != dev;
-}
-
 static int characteristic_handle_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *chr = a;
@@ -229,12 +201,11 @@ static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	struct watcher *watcher = user_data;
-	struct primary *prim = watcher->prim;
-	struct gatt_service *gatt = prim->gatt;
+	struct gatt_service *gatt = watcher->gatt;
 
-	DBG("%s watcher %s exited", prim->path, watcher->name);
+	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
-	prim->watchers = g_slist_remove(prim->watchers, watcher);
+	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
 
 	g_attrib_unref(gatt->attrib);
 }
@@ -256,7 +227,7 @@ static void update_watchers(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
 	struct characteristic *chr = user_data;
-	DBusConnection *conn = w->prim->gatt->conn;
+	DBusConnection *conn = w->gatt->conn;
 	DBusMessage *msg;
 
 	msg = dbus_message_new_method_call(w->name, w->path,
@@ -277,8 +248,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 {
 	struct gatt_service *gatt = user_data;
 	struct characteristic *chr;
-	struct primary *prim;
-	GSList *lprim, *lchr;
+	GSList *l;
 	uint8_t opdu[ATT_MAX_MTU];
 	guint handle;
 	uint16_t olen;
@@ -291,17 +261,12 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 
 	handle = att_get_u16(&pdu[1]);
 
-	for (lprim = gatt->primary, prim = NULL, chr = NULL; lprim;
-						lprim = lprim->next) {
-		prim = lprim->data;
+	l = g_slist_find_custom(gatt->chars, GUINT_TO_POINTER(handle),
+						characteristic_handle_cmp);
+	if (!l)
+		return;
 
-		lchr = g_slist_find_custom(prim->chars,
-			GUINT_TO_POINTER(handle), characteristic_handle_cmp);
-		if (lchr) {
-			chr = lchr->data;
-			break;
-		}
-	}
+	chr = l->data;
 
 	if (chr == NULL) {
 		DBG("Attribute handle 0x%02x not found", handle);
@@ -317,7 +282,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 		if (characteristic_set_value(chr, &pdu[3], len - 3) < 0)
 			DBG("Can't change Characteristic 0x%02x", handle);
 
-		g_slist_foreach(prim->watchers, update_watchers, chr);
+		g_slist_foreach(gatt->watchers, update_watchers, chr);
 		break;
 	}
 }
@@ -415,7 +380,7 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct primary *prim = data;
+	struct gatt_service *gatt = data;
 	struct watcher *watcher;
 	GError *gerr = NULL;
 	char *path;
@@ -424,7 +389,7 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (l2cap_connect(prim->gatt, &gerr, TRUE) < 0) {
+	if (l2cap_connect(gatt, &gerr, TRUE) < 0) {
 		DBusMessage *reply = btd_error_failed(msg, gerr->message);
 		g_error_free(gerr);
 		return reply;
@@ -432,12 +397,12 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 
 	watcher = g_new0(struct watcher, 1);
 	watcher->name = g_strdup(sender);
-	watcher->prim = prim;
+	watcher->gatt = gatt;
 	watcher->path = g_strdup(path);
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 							watcher, watcher_free);
 
-	prim->watchers = g_slist_append(prim->watchers, watcher);
+	gatt->watchers = g_slist_append(gatt->watchers, watcher);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -446,7 +411,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
-	struct primary *prim = data;
+	struct gatt_service *gatt = data;
 	struct watcher *watcher, *match;
 	GSList *l;
 	char *path;
@@ -458,14 +423,14 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	match = g_new0(struct watcher, 1);
 	match->name = g_strdup(sender);
 	match->path = g_strdup(path);
-	l = g_slist_find_custom(prim->watchers, match, watcher_cmp);
+	l = g_slist_find_custom(gatt->watchers, match, watcher_cmp);
 	watcher_free(match);
 	if (!l)
 		return btd_error_not_authorized(msg);
 
 	watcher = l->data;
 	g_dbus_remove_watch(conn, watcher->id);
-	prim->watchers = g_slist_remove(prim->watchers, watcher);
+	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
 	watcher_free(watcher);
 
 	return dbus_message_new_method_return(msg);
@@ -474,7 +439,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 			DBusMessageIter *iter, struct characteristic *chr)
 {
-	struct gatt_service *gatt = chr->prim->gatt;
+	struct gatt_service *gatt = chr->gatt;
 	DBusMessageIter sub;
 	GError *gerr = NULL;
 	uint8_t *value;
@@ -576,36 +541,34 @@ static char *characteristic_list_to_string(GSList *chars)
 	return g_string_free(characteristics, FALSE);
 }
 
-static void store_characteristics(struct gatt_service *gatt,
-							struct primary *prim)
+static void store_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
+						uint16_t start, GSList *chars)
 {
 	char *characteristics;
-	struct att_primary *att = prim->att;
-	bdaddr_t sba, dba;
-
-	characteristics = characteristic_list_to_string(prim->chars);
 
-	gatt_get_address(gatt, &sba, &dba);
+	characteristics = characteristic_list_to_string(chars);
 
-	write_device_characteristics(&sba, &dba, att->start, characteristics);
+	write_device_characteristics(sba, dba, start, characteristics);
 
 	g_free(characteristics);
 }
 
-static void register_characteristics(struct primary *prim)
+static void register_characteristic(gpointer data, gpointer user_data)
 {
-	GSList *lc;
-
-	for (lc = prim->chars; lc; lc = lc->next) {
-		struct characteristic *chr = lc->data;
-		g_dbus_register_interface(prim->gatt->conn, chr->path,
-				CHAR_INTERFACE, char_methods,
-				NULL, NULL, chr, NULL);
-		DBG("Registered: %s", chr->path);
-	}
+	struct characteristic *chr = data;
+	DBusConnection *conn = chr->gatt->conn;
+	const char *gatt_path = user_data;
+
+	chr->path = g_strdup_printf("%s/characteristic%04x", gatt_path,
+								chr->handle);
+
+	g_dbus_register_interface(conn, chr->path, CHAR_INTERFACE,
+					char_methods, NULL, NULL, chr, NULL);
+
+	DBG("Registered: %s", chr->path);
 }
 
-static GSList *string_to_characteristic_list(struct primary *prim,
+static GSList *string_to_characteristic_list(struct gatt_service *gatt,
 							const char *str)
 {
 	GSList *l = NULL;
@@ -632,10 +595,7 @@ static GSList *string_to_characteristic_list(struct primary *prim,
 			continue;
 		}
 
-		chr->prim = prim;
-		chr->path = g_strdup_printf("%s/characteristic%04x",
-						prim->path, chr->handle);
-
+		chr->gatt = gatt;
 		l = g_slist_append(l, chr);
 	}
 
@@ -644,37 +604,23 @@ static GSList *string_to_characteristic_list(struct primary *prim,
 	return l;
 }
 
-static void load_characteristics(gpointer data, gpointer user_data)
+static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 {
-	struct primary *prim = data;
-	struct att_primary *att = prim->att;
-	struct gatt_service *gatt = user_data;
-	bdaddr_t sba, dba;
 	GSList *chrs_list;
+	bdaddr_t sba, dba;
 	char *str;
 
-	if (prim->chars) {
-		DBG("Characteristics already loaded");
-		return;
-	}
-
 	gatt_get_address(gatt, &sba, &dba);
 
-	str = read_device_characteristics(&sba, &dba, att->start);
+	str = read_device_characteristics(&sba, &dba, start);
 	if (str == NULL)
-		return;
+		return NULL;
 
-	chrs_list = string_to_characteristic_list(prim, str);
+	chrs_list = string_to_characteristic_list(gatt, str);
 
 	free(str);
 
-	if (chrs_list == NULL)
-		return;
-
-	prim->chars = chrs_list;
-	register_characteristics(prim);
-
-	return;
+	return chrs_list;
 }
 
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
@@ -706,7 +652,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct query_data *current = user_data;
-	struct gatt_service *gatt = current->prim->gatt;
+	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
 
 	if (status == 0) {
@@ -740,7 +686,7 @@ static void update_char_format(guint8 status, const guint8 *pdu, guint16 len,
 								gpointer user_data)
 {
 	struct query_data *current = user_data;
-	struct gatt_service *gatt = current->prim->gatt;
+	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
 
 	if (status != 0)
@@ -766,7 +712,7 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
 	struct query_data *current = user_data;
-	struct gatt_service *gatt = current->prim->gatt;
+	struct gatt_service *gatt = current->gatt;
 	struct characteristic *chr = current->chr;
 
 	if (status == 0)
@@ -800,7 +746,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct query_data *current = user_data;
-	struct gatt_service *gatt = current->prim->gatt;
+	struct gatt_service *gatt = current->gatt;
 	struct att_data_list *list;
 	guint8 format;
 	int i;
@@ -832,7 +778,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			continue;
 		}
 		qfmt = g_new0(struct query_data, 1);
-		qfmt->prim = current->prim;
+		qfmt->gatt = current->gatt;
 		qfmt->chr = current->chr;
 		qfmt->handle = handle;
 
@@ -858,11 +804,10 @@ static void update_all_chars(gpointer data, gpointer user_data)
 {
 	struct query_data *qdesc, *qvalue;
 	struct characteristic *chr = data;
-	struct primary *prim = user_data;
-	struct gatt_service *gatt = prim->gatt;
+	struct gatt_service *gatt = user_data;
 
 	qdesc = g_new0(struct query_data, 1);
-	qdesc->prim = prim;
+	qdesc->gatt = gatt;
 	qdesc->chr = chr;
 
 	gatt->attrib = g_attrib_ref(gatt->attrib);
@@ -870,7 +815,7 @@ static void update_all_chars(gpointer data, gpointer user_data)
 									qdesc);
 
 	qvalue = g_new0(struct query_data, 1);
-	qvalue->prim = prim;
+	qvalue->gatt = gatt;
 	qvalue->chr = chr;
 
 	gatt->attrib = g_attrib_ref(gatt->attrib);
@@ -883,11 +828,11 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	DBusMessage *reply;
 	DBusMessageIter iter, array_iter;
 	struct query_data *current = user_data;
-	struct primary *prim = current->prim;
-	struct att_primary *att = prim->att;
-	struct gatt_service *gatt = prim->gatt;
+	struct gatt_service *gatt = current->gatt;
+	struct att_primary *prim = gatt->prim;
 	uint16_t *previous_end = NULL;
 	GSList *l;
+	bdaddr_t sba, dba;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -903,17 +848,15 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 		guint handle = current_chr->value_handle;
 		GSList *lchr;
 
-		lchr = g_slist_find_custom(prim->chars,
+		lchr = g_slist_find_custom(gatt->chars,
 			GUINT_TO_POINTER(handle), characteristic_handle_cmp);
 		if (lchr)
 			continue;
 
 		chr = g_new0(struct characteristic, 1);
-		chr->prim = prim;
+		chr->gatt = gatt;
 		chr->perm = current_chr->properties;
 		chr->handle = current_chr->value_handle;
-		chr->path = g_strdup_printf("%s/characteristic%04x",
-						prim->path, chr->handle);
 		strncpy(chr->type, current_chr->uuid, sizeof(chr->type));
 
 		if (previous_end)
@@ -921,14 +864,16 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 		previous_end = &chr->end;
 
-		prim->chars = g_slist_append(prim->chars, chr);
+		gatt->chars = g_slist_append(gatt->chars, chr);
 	}
 
 	if (previous_end)
-		*previous_end = att->end;
+		*previous_end = prim->end;
+
+	gatt_get_address(gatt, &sba, &dba);
+	store_characteristics(&sba, &dba, prim->start, gatt->chars);
 
-	store_characteristics(gatt, prim);
-	register_characteristics(prim);
+	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
 	reply = dbus_message_new_method_return(current->msg);
 
@@ -937,7 +882,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
 
-	for (l = prim->chars; l; l = l->next) {
+	for (l = gatt->chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
 
 		dbus_message_iter_append_basic(&array_iter,
@@ -946,7 +891,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	dbus_message_iter_close_container(&iter, &array_iter);
 
-	g_slist_foreach(prim->chars, update_all_chars, prim);
+	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
 fail:
 	g_dbus_send_message(gatt->conn, reply);
@@ -957,23 +902,22 @@ fail:
 static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	struct primary *prim = data;
-	struct att_primary *att = prim->att;
-	struct gatt_service *gatt = prim->gatt;
+	struct gatt_service *gatt = data;
+	struct att_primary *prim = gatt->prim;
 	struct query_data *qchr;
 	GError *gerr = NULL;
 
-	if (l2cap_connect(prim->gatt, &gerr, FALSE) < 0) {
+	if (l2cap_connect(gatt, &gerr, FALSE) < 0) {
 		DBusMessage *reply = btd_error_failed(msg, gerr->message);
 		g_error_free(gerr);
 		return reply;
 	}
 
 	qchr = g_new0(struct query_data, 1);
-	qchr->prim = prim;
+	qchr->gatt = gatt;
 	qchr->msg = dbus_message_ref(msg);
 
-	gatt_discover_char(gatt->attrib, att->start, att->end, NULL,
+	gatt_discover_char(gatt->attrib, prim->start, prim->end, NULL,
 						char_discovered_cb, qchr);
 
 	return NULL;
@@ -982,7 +926,7 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	struct primary *prim = data;
+	struct gatt_service *gatt = data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
@@ -1002,16 +946,16 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	chars = g_new0(char *, g_slist_length(prim->chars) + 1);
+	chars = g_new0(char *, g_slist_length(gatt->chars) + 1);
 
-	for (i = 0, l = prim->chars; l; l = l->next, i++) {
+	for (i = 0, l = gatt->chars; l; l = l->next, i++) {
 		struct characteristic *chr = l->data;
 		chars[i] = chr->path;
 	}
 
 	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
 								&chars, i);
-	uuid = prim->att->uuid;
+	uuid = gatt->prim->uuid;
 	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
 
 	g_free(chars);
@@ -1032,80 +976,92 @@ static GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
-static struct primary *primary_register(struct gatt_service *gatt,
-						struct att_primary *prim)
+static struct gatt_service *primary_register(DBusConnection *conn,
+						struct btd_device *device,
+						struct att_primary *prim,
+						int psm)
 {
-	struct btd_device *device = gatt->dev;
+	struct gatt_service *gatt;
 	const char *device_path;
-	struct primary *data;
 
 	device_path = device_get_path(device);
 
-	data = g_new0(struct primary, 1);
-	data->att = prim;
-	data->gatt = gatt;
-	data->path = g_strdup_printf("%s/service%04x", device_path,
+	gatt = g_new0(struct gatt_service, 1);
+	gatt->dev = btd_device_ref(device);
+	gatt->prim = prim;
+	gatt->psm = psm;
+	gatt->listen = FALSE;
+	gatt->conn = dbus_connection_ref(conn);
+	gatt->path = g_strdup_printf("%s/service%04x", device_path,
 								prim->start);
 
-	g_dbus_register_interface(gatt->conn, data->path,
+	g_dbus_register_interface(gatt->conn, gatt->path,
 					CHAR_INTERFACE, prim_methods,
-					NULL, NULL, data, NULL);
-
-	load_characteristics(data, gatt);
+					NULL, NULL, gatt, NULL);
+	gatt->chars = load_characteristics(gatt, prim->start);
+	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
-	return data;
+	return gatt;
 }
 
 GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries)
 {
-	struct gatt_service *gatt;
-	GSList *l;
-
-	gatt = g_new0(struct gatt_service, 1);
-	gatt->dev = btd_device_ref(device);
-	gatt->conn = dbus_connection_ref(connection);
-	gatt->listen = FALSE;
-	gatt->psm = psm;
+	GSList *l, *services;
 
-	for (l = primaries; l; l = l->next) {
+	for (l = primaries, services = NULL; l; l = l->next) {
 		struct att_primary *prim = l->data;
-		struct primary *data;
+		struct gatt_service *gatt;
+
+		gatt = primary_register(connection, device, prim, psm);
 
-		data = primary_register(gatt, prim);
-		gatt->primary = g_slist_append(gatt->primary, data);
+		DBG("Registered: %s", gatt->path);
 
-		DBG("Registered: %s", data->path);
+		services = g_slist_append(services, g_strdup(gatt->path));
+		gatt_services = g_slist_append(gatt_services, gatt);
 	}
 
-	gatt_services = g_slist_append(gatt_services, gatt);
+	return services;
+}
+
+static void primary_unregister(struct gatt_service *gatt)
+{
+	GSList *l;
 
-	return gatt_services;
+	for (l = gatt->chars; l; l = l->next) {
+		struct characteristic *chr = l->data;
+		g_dbus_unregister_interface(gatt->conn, chr->path,
+							CHAR_INTERFACE);
+	}
+
+	g_dbus_unregister_interface(gatt->conn, gatt->path, CHAR_INTERFACE);
 }
 
-void attrib_client_unregister(struct btd_device *device)
+static int path_cmp(gconstpointer data, gconstpointer user_data)
 {
-	struct gatt_service *gatt;
-	GSList *l, *lp, *lc;
+	const char *path = data;
+	const char *gatt_path = user_data;
 
-	l = g_slist_find_custom(gatt_services, device, gatt_dev_cmp);
-	if (!l)
-		return;
+	return g_strcmp0(path, gatt_path);
+}
+
+void attrib_client_unregister(GSList *services)
+{
+	GSList *l, *left;
 
-	gatt = l->data;
-	gatt_services = g_slist_remove(gatt_services, gatt);
+	for (l = gatt_services, left = NULL; l; l = l->next) {
+		struct gatt_service *gatt = l->data;
 
-	for (lp = gatt->primary; lp; lp = lp->next) {
-		struct primary *prim = lp->data;
-		for (lc = prim->chars; lc; lc = lc->next) {
-			struct characteristic *chr = lc->data;
-			g_dbus_unregister_interface(gatt->conn, chr->path,
-								CHAR_INTERFACE);
+		if (!g_slist_find_custom(services, gatt->path, path_cmp)) {
+			left = g_slist_append(left, gatt);
+			continue;
 		}
-		g_dbus_unregister_interface(gatt->conn, prim->path,
-								CHAR_INTERFACE);
+
+		primary_unregister(gatt);
+		gatt_service_free(gatt);
 	}
 
-	gatt_service_free(gatt);
+	g_slist_free(gatt_services);
+	gatt_services = left;
 }
diff --git a/attrib/client.h b/attrib/client.h
index b29797c..948f030 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -25,4 +25,4 @@
 GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries);
-void attrib_client_unregister(struct btd_device *device);
+void attrib_client_unregister(GSList *services);
diff --git a/src/device.c b/src/device.c
index 4d17082..9342d19 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1037,7 +1037,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	g_slist_free(device->drivers);
 	device->drivers = NULL;
 
-	attrib_client_unregister(device);
+	attrib_client_unregister(device->services);
 
 	btd_device_unref(device);
 }
-- 
1.7.6

