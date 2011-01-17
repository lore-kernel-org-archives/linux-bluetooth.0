Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/2] Move common code from Discover all Characteristics to GATT library
Date: Mon, 17 Jan 2011 15:37:49 -0400
Message-Id: <1295293069-29637-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1295293069-29637-1-git-send-email-bruna.moreira@openbossa.org>
References: <1295293069-29637-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The attribute client (attrib/client.c) and gatttool share similar code
to parse the PDU coming from server. This commit moves this common code
to attrib/gatt.c, and simplifies the callbacks implemented by the
clients. The client callbacks are now called just once and get a GSList
of characteristics, instead of the raw PDU.
---
 attrib/att.h      |    7 +++
 attrib/client.c   |   67 +++++++-------------------------
 attrib/gatt.c     |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 attrib/gatt.h     |    2 +-
 attrib/gatttool.c |   59 +++++-----------------------
 5 files changed, 140 insertions(+), 106 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 08feeec..a1e0b62 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -143,6 +143,13 @@ struct att_primary {
 	uint16_t end;
 };
 
+struct att_char {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	uint16_t handle;
+	uint8_t properties;
+	uint16_t value_handle;
+};
+
 /* These functions do byte conversion */
 static inline uint8_t att_get_u8(const void *ptr)
 {
diff --git a/attrib/client.c b/attrib/client.c
index 7f72348..767d1c1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -85,7 +85,7 @@ struct characteristic {
 	uint16_t handle;
 	uint16_t end;
 	uint8_t perm;
-	uuid_t type;
+	char type[MAX_LEN_UUID_STR + 1];
 	char *name;
 	char *desc;
 	struct format *format;
@@ -199,7 +199,7 @@ static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	uuid = bt_uuid2string(&chr->type);
+	uuid = g_strdup(chr->type);
 	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
 	g_free(uuid);
 
@@ -544,19 +544,12 @@ static char *characteristic_list_to_string(GSList *chars)
 
 	for (l = chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
-		uuid_t *uuid128;
 		char chr_str[64];
-		char uuidstr[MAX_LEN_UUID_STR];
 
 		memset(chr_str, 0, sizeof(chr_str));
 
-		uuid128 = sdp_uuid_to_uuid128(&chr->type);
-		sdp_uuid2strn(uuid128, uuidstr, MAX_LEN_UUID_STR);
-
-		bt_free(uuid128);
-
 		snprintf(chr_str, sizeof(chr_str), "%04X#%02X#%04X#%s ",
-				chr->handle, chr->perm, chr->end, uuidstr);
+				chr->handle, chr->perm, chr->end, chr->type);
 
 		characteristics = g_string_append(characteristics, chr_str);
 	}
@@ -607,13 +600,12 @@ static GSList *string_to_characteristic_list(struct primary *prim,
 
 	for (i = 0; chars[i]; i++) {
 		struct characteristic *chr;
-		char uuidstr[MAX_LEN_UUID_STR + 1];
 		int ret;
 
 		chr = g_new0(struct characteristic, 1);
 
 		ret = sscanf(chars[i], "%04hX#%02hhX#%04hX#%s", &chr->handle,
-				&chr->perm, &chr->end, uuidstr);
+				&chr->perm, &chr->end, chr->type);
 		if (ret < 4) {
 			g_free(chr);
 			continue;
@@ -623,8 +615,6 @@ static GSList *string_to_characteristic_list(struct primary *prim,
 		chr->path = g_strdup_printf("%s/characteristic%04x",
 						prim->path, chr->handle);
 
-		bt_string2uuid(&chr->type, uuidstr);
-
 		l = g_slist_append(l, chr);
 	}
 
@@ -861,54 +851,37 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	gatt_read_char(gatt->attrib, chr->handle, update_char_value, qvalue);
 }
 
-static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct query_data *current = user_data;
 	struct primary *prim = current->prim;
 	struct att_primary *att = prim->att;
 	struct gatt_service *gatt = prim->gatt;
-	struct att_data_list *list;
-	uint16_t last, *previous_end = NULL;
-	int i;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND)
-		goto done;
+	uint16_t *previous_end = NULL;
+	GSList *l;
 
 	if (status != 0) {
 		DBG("Discover all characteristics failed: %s",
 						att_ecode2str(status));
-
 		goto fail;
 	}
 
-	DBG("Read by Type Response received");
-
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		goto fail;
-
-	for (i = 0, last = 0; i < list->num; i++) {
-		uint8_t *decl = list->data[i];
+	for (l = characteristics; l; l = l->next) {
+		struct att_char *current_chr = l->data;
 		struct characteristic *chr;
 
 		chr = g_new0(struct characteristic, 1);
 		chr->prim = prim;
-		chr->perm = decl[2];
-		chr->handle = att_get_u16(&decl[3]);
+		chr->perm = current_chr->properties;
+		chr->handle = current_chr->value_handle;
 		chr->path = g_strdup_printf("%s/characteristic%04x",
 						prim->path, chr->handle);
-		if (list->len == 7) {
-			sdp_uuid16_create(&chr->type,
-					att_get_u16(&decl[5]));
-		} else
-			sdp_uuid128_create(&chr->type, &decl[5]);
+		strncpy(chr->type, current_chr->uuid, sizeof(chr->type));
 
-		if (previous_end) {
-			*previous_end = att_get_u16(decl);
-		}
+		if (previous_end)
+			*previous_end = current_chr->handle;
 
-		last = chr->handle;
 		previous_end = &chr->end;
 
 		prim->chars = g_slist_append(prim->chars, chr);
@@ -917,18 +890,6 @@ static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (previous_end)
 		*previous_end = att->end;
 
-	att_data_list_free(list);
-
-	if (last >= att->end)
-		goto done;
-
-	/* Fetch remaining characteristics for the CURRENT primary service */
-	gatt_discover_char(gatt->attrib, last + 1, att->end,
-						char_discovered_cb, current);
-
-	return;
-
-done:
 	store_characteristics(gatt, prim);
 	register_characteristics(prim);
 
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 79d8b9d..5d7887e 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -39,6 +39,15 @@ struct discover_primary {
 	void *user_data;
 };
 
+struct discover_char {
+	GAttrib *attrib;
+	uuid_t uuid;
+	uint16_t end;
+	GSList *characteristics;
+	gatt_cb_t cb;
+	void *user_data;
+};
+
 static void discover_primary_free(struct discover_primary *dp)
 {
 	g_slist_free(dp->primaries);
@@ -46,6 +55,14 @@ static void discover_primary_free(struct discover_primary *dp)
 	g_free(dp);
 }
 
+static void discover_char_free(struct discover_char *dc)
+{
+	g_slist_foreach(dc->characteristics, (GFunc) g_free, NULL);
+	g_slist_free(dc->characteristics);
+	g_attrib_unref(dc->attrib);
+	g_free(dc);
+}
+
 static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 					uuid_t *uuid, uint8_t *pdu, size_t len)
 {
@@ -222,15 +239,103 @@ guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, cb, dp, NULL);
 }
 
+static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
+							gpointer user_data)
+{
+	struct discover_char *dc = user_data;
+	struct att_data_list *list;
+	unsigned int i, err;
+	uint8_t opdu[ATT_DEFAULT_MTU];
+	guint16 oplen;
+	uuid_t uuid;
+	uint16_t last = 0;
+
+	if (status) {
+		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		goto done;
+	}
+
+	list = dec_read_by_type_resp(ipdu, iplen);
+	if (list == NULL) {
+		err = ATT_ECODE_IO;
+		goto done;
+	}
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value = list->data[i];
+		struct att_char *chars;
+		uuid_t u128, u16;
+
+		last = att_get_u16(value);
+
+		if (list->len == 7) {
+			sdp_uuid16_create(&u16, att_get_u16(&value[5]));
+			sdp_uuid16_to_uuid128(&u128, &u16);
+		} else
+			sdp_uuid128_create(&u128, &value[5]);
+
+		chars = g_try_new0(struct att_char, 1);
+		if (!chars) {
+			err = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
+		}
+
+		chars->handle = last;
+		chars->properties = value[2];
+		chars->value_handle = att_get_u16(&value[3]);
+		sdp_uuid2strn(&u128, chars->uuid, sizeof(chars->uuid));
+		dc->characteristics = g_slist_append(dc->characteristics,
+									chars);
+	}
+
+	att_data_list_free(list);
+	err = 0;
+
+	if (last != 0) {
+		sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+
+		oplen = enc_read_by_type_req(last + 1, dc->end, &uuid, opdu,
+								sizeof(opdu));
+
+		if (oplen == 0)
+			return;
+
+		g_attrib_send(dc->attrib, 0, opdu[0], opdu, oplen,
+						char_discovered_cb, dc, NULL);
+
+		return;
+	}
+
+done:
+	dc->cb(dc->characteristics, err, dc->user_data);
+	discover_char_free(dc);
+}
+
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
+					gatt_cb_t func, gpointer user_data)
 {
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	struct discover_char *dc;
+	guint16 plen;
 	uuid_t uuid;
 
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
-	return gatt_read_char_by_uuid(attrib, start, end, &uuid, func,
-							user_data);
+	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
+	if (plen == 0)
+		return 0;
+
+	dc = g_try_new0(struct discover_char, 1);
+	if (dc == NULL)
+		return 0;
+
+	dc->attrib = g_attrib_ref(attrib);
+	dc->cb = func;
+	dc->user_data = user_data;
+	dc->end = end;
+
+	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, char_discovered_cb,
+								dc, NULL);
 }
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 0bdac77..9f69646 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -30,7 +30,7 @@ guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
+					gatt_cb_t func, gpointer user_data);
 
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index ad0216b..8e8ed8e 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -245,73 +245,34 @@ static gboolean primary(gpointer user_data)
 	return FALSE;
 }
 
-static void char_discovered_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
-	struct characteristic_data *char_data = user_data;
-	struct att_data_list *list;
-	uint16_t last = char_data->start;
-	int i;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND)
-		goto done;
+	GSList *l;
 
-	if (status != 0) {
+	if (status) {
 		g_printerr("Discover all characteristics failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
 
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		return;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value = list->data[i];
-		char uuidstr[MAX_LEN_UUID_STR];
-		uuid_t uuid;
+	for (l = characteristics; l; l = l->next) {
+		struct att_char *chars = l->data;
 
-		last = att_get_u16(value);
-
-		g_print("handle = 0x%04x, char properties = 0x%02x, "
-			"char value handle = 0x%04x, ", last, value[2],
-			att_get_u16(&value[3]));
-
-		if (list->len == 7)
-			sdp_uuid16_create(&uuid, att_get_u16(&value[5]));
-		else
-			sdp_uuid128_create(&uuid, value + 5);
-
-		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		g_print("uuid = %s\n", uuidstr);
+		g_print("handle = 0x%04x, char properties = 0x%02x, char value "
+			"handle = 0x%04x, uuid = %s\n", chars->handle,
+			chars->properties, chars->value_handle, chars->uuid);
 	}
 
-	att_data_list_free(list);
-
-	/* Fetch remaining characteristics for the CURRENT primary service */
-	gatt_discover_char(char_data->attrib, last + 1, char_data->end,
-						char_discovered_cb, char_data);
-
-	return;
-
 done:
-	g_free(char_data);
-	if (opt_listen == FALSE)
-		g_main_loop_quit(event_loop);
+	g_main_loop_quit(event_loop);
 }
 
 static gboolean characteristics(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
-	struct characteristic_data *char_data;
-
-	char_data = g_new(struct characteristic_data, 1);
-	char_data->attrib = attrib;
-	char_data->start = opt_start;
-	char_data->end = opt_end;
 
-	gatt_discover_char(attrib, opt_start, opt_end, char_discovered_cb,
-								char_data);
+	gatt_discover_char(attrib, opt_start, opt_end, char_discovered_cb, NULL);
 
 	return FALSE;
 }
-- 
1.7.0.4

