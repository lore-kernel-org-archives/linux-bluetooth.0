Return-Path: <cyrus@holtmann.org>
Subject: Re: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20090309174644.GA4340@jh-x301>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
	 <1236608040.16880.1580.camel@cookie.hadess.net>
	 <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
	 <1236612318.16880.1656.camel@cookie.hadess.net>
	 <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com>
	 <1236618579.32264.23.camel@cookie.hadess.net>
	 <20090309174644.GA4340@jh-x301>
Content-Type: multipart/mixed; boundary="=-fPWYTaSsnxrsqhp7M035"
Date: Fri, 13 Mar 2009 15:37:53 +0000
Message-Id: <1236958673.32264.5799.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-fPWYTaSsnxrsqhp7M035
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2009-03-09 at 15:04 -0300, Johan Hedberg wrote:
<snip>
> 2. Have the new function start like:
> {
>         sdp_data_t *d;
> 
>         d = sdp_data_alloc_with_length(dtd, value, len);
>         if (!d)
>                 return -1;

FWIW, I just copied the coding style from the function 5 lines above it.

Patches attached.

--=-fPWYTaSsnxrsqhp7M035
Content-Disposition: attachment; filename="0001-Fix-sdp_copy_record-truncating-strings-with-NULLs.patch"
Content-Type: text/x-patch; name="0001-Fix-sdp_copy_record-truncating-strings-with-NULLs.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 3922bbb56cc5e3a8602c578a793db6aee5537e94 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 13 Mar 2009 15:27:33 +0000
Subject: [PATCH] Fix sdp_copy_record truncating strings with NULLs

When a record's attribute contains embed NULLs in the string,
sdp_data_alloc() falls back to doing an strlen() on the
string, instead of taking its existing length into account.
---
 lib/sdp.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 896c5eb..18e6450 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -97,6 +97,8 @@ static uint128_t bluetooth_base_uuid = {
 #define SDP_MAX_ATTR_LEN 65535
 
 static sdp_data_t *sdp_copy_seq(sdp_data_t *data);
+static int sdp_attr_add_new_with_length(sdp_record_t *rec,
+	uint16_t attr, uint8_t dtd, const void *value, uint32_t len);
 
 /* Message structure. */
 struct tupla {
@@ -1381,7 +1383,7 @@ static void sdp_copy_pattern(void *value, void *udata)
 	sdp_pattern_add_uuid(rec, uuid);
 }
 
-static void *sdp_data_value(sdp_data_t *data)
+static void *sdp_data_value(sdp_data_t *data, uint32_t *len)
 {
 	void *val = NULL;
 
@@ -1435,6 +1437,8 @@ static void *sdp_data_value(sdp_data_t *data)
 	case SDP_URL_STR32:
 	case SDP_TEXT_STR32:
 		val = data->val.str;
+		if (len)
+			*len = data->unitSize - 1;
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
@@ -1457,7 +1461,7 @@ static sdp_data_t *sdp_copy_seq(sdp_data_t *data)
 		sdp_data_t *datatmp;
 		void *value;
 
-		value = sdp_data_value(tmp);
+		value = sdp_data_value(tmp, NULL);
 		datatmp = sdp_data_alloc_with_length(tmp->dtd, value,
 					tmp->unitSize);
 
@@ -1477,10 +1481,15 @@ static void sdp_copy_attrlist(void *value, void *udata)
 	sdp_data_t *data = value;
 	sdp_record_t *rec = udata;
 	void *val;
+	uint32_t len = 0;
 
-	val = sdp_data_value(data);
+	val = sdp_data_value(data, &len);
 
-	sdp_attr_add_new(rec, data->attrId, data->dtd, val);
+	if (!len)
+		sdp_attr_add_new(rec, data->attrId, data->dtd, val);
+	else
+		sdp_attr_add_new_with_length(rec, data->attrId,
+			data->dtd, val, len);
 }
 
 sdp_record_t *sdp_copy_record(sdp_record_t *rec)
@@ -2068,6 +2077,19 @@ int sdp_attr_add_new(sdp_record_t *rec, uint16_t attr, uint8_t dtd,
 	return -1;
 }
 
+static int sdp_attr_add_new_with_length(sdp_record_t *rec,
+	uint16_t attr, uint8_t dtd, const void *value, uint32_t len)
+{
+	sdp_data_t *d;
+	
+	d = sdp_data_alloc_with_length(dtd, value, len);
+	if (!d)
+		return -1;
+
+	sdp_attr_replace(rec, attr, d);
+	return 0;
+}
+
 /*
  * Set the information attributes of the service
  * pointed to by rec. The attributes are
-- 
1.6.0.6


--=-fPWYTaSsnxrsqhp7M035
Content-Disposition: attachment; filename="0002-Don-t-truncate-strings-with-embedded-NULLs.patch"
Content-Type: text/x-patch; name="0002-Don-t-truncate-strings-with-embedded-NULLs.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b974124d58e2cf382b1c258c94c2fd92258cb25f Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 13 Mar 2009 15:30:21 +0000
Subject: [PATCH] Don't truncate strings with embedded NULLs

Instead, replace the NULLs by spaces so we don't lose data
when converting a device's SDP record to XML.
---
 common/sdp-xml.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/sdp-xml.c b/common/sdp-xml.c
index 0403dcd..608de76 100644
--- a/common/sdp-xml.c
+++ b/common/sdp-xml.c
@@ -239,9 +239,8 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		hex = 0;
 
 		for (i = 0; i < length; i++) {
-			if (value->val.str[i] == '\0')
-				break;
-			if (!isprint(value->val.str[i])) {
+			if (!isprint(value->val.str[i]) &&
+					value->val.str[i] != '\0') {
 				hex = 1;
 				break;
 			}
@@ -304,7 +303,9 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 					strBuf[j++] = 'o';
 					strBuf[j++] = 't';
 				}
-				else {
+				else if (value->val.str[i] == '\0') {
+					strBuf[j++] = ' ';
+				} else {
 					strBuf[j++] = value->val.str[i];
 				}
 			}
-- 
1.6.0.6


--=-fPWYTaSsnxrsqhp7M035
Content-Disposition: attachment; filename="0003-Port-CUPS-discovery-to-BlueZ-4.x.patch"
Content-Type: text/x-patch; name="0003-Port-CUPS-discovery-to-BlueZ-4.x.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 783aa6f8de6f17a611f8b74288bd1617a9630d77 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 13 Mar 2009 15:34:57 +0000
Subject: [PATCH] Port CUPS discovery to BlueZ 4.x

Adapt CUPS printer discovery to the BlueZ 4.x API.
---
 cups/main.c |  437 ++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 256 insertions(+), 181 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index d8b899e..9b102c8 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -33,6 +33,7 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/socket.h>
+#include <glib.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -42,8 +43,6 @@
 
 #include "cups.h"
 
-#define PRINTER_SERVICE_CLASS_NAME "printer"
-
 struct cups_device {
 	char *bdaddr;
 	char *name;
@@ -53,53 +52,87 @@ struct cups_device {
 static GSList *device_list = NULL;
 static GMainLoop *loop = NULL;
 static DBusConnection *conn = NULL;
+static gboolean doing_disco = FALSE;
 
 #define ATTRID_1284ID 0x0300
 
-static sdp_record_t *sdp_xml_parse_record(const char *data, int size)
-{
-	return NULL;
-}
+struct context_data {
+	gboolean found;
+	char *id;
+};
 
-static char *parse_xml_sdp(const char *xml)
+static void element_start(GMarkupParseContext *context,
+		const gchar *element_name, const gchar **attribute_names,
+		const gchar **attribute_values, gpointer user_data, GError **err)
 {
-	sdp_record_t *sdp_record;
-	sdp_list_t *l;
-	char *str = NULL;
+	struct context_data *ctx_data = user_data;
 
-	sdp_record = sdp_xml_parse_record(xml, strlen(xml));
-	if (sdp_record == NULL)
-		return NULL;
+	if (!strcmp(element_name, "record"))
+		return;
 
-	for (l = sdp_record->attrlist; l != NULL; l = l->next) {
-		sdp_data_t *data;
+	if (!strcmp(element_name, "attribute")) {
+		int i;
+		for (i = 0; attribute_names[i]; i++) {
+			if (!strcmp(attribute_names[i], "id")) {
+				if (strtol(attribute_values[i], 0, 0) == ATTRID_1284ID)
+					ctx_data->found = TRUE;
+				break;
+			}
+		}
+		return;
+	}
 
-		data = (sdp_data_t *) l->data;
-		if (data->attrId != ATTRID_1284ID)
-			continue;
-		/* Ignore the length, it's null terminated */
-		str = g_strdup(data->val.str + 2);
-		break;
+	if (ctx_data->found  && !strcmp(element_name, "text")) {
+		int i;
+		for (i = 0; attribute_names[i]; i++) {
+			if (!strcmp(attribute_names[i], "value")) {
+				ctx_data->id = g_strdup(attribute_values[i] + 2);
+				ctx_data->found = FALSE;
+			}
+		}
 	}
-	sdp_record_free(sdp_record);
+}
+
+static GMarkupParser parser = {
+	element_start, NULL, NULL, NULL, NULL
+};
 
-	return str;
+static char *sdp_xml_parse_record(const char *data)
+{
+	GMarkupParseContext *ctx;
+	struct context_data ctx_data;
+	int size;
+
+	size = strlen(data);
+	ctx_data.found = FALSE;
+	ctx_data.id = NULL;
+	ctx = g_markup_parse_context_new(&parser, 0, &ctx_data, NULL);
+
+	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
+		g_markup_parse_context_free(ctx);
+		g_free(ctx_data.id);
+		return NULL;
+	}
+
+	g_markup_parse_context_free(ctx);
+
+	return ctx_data.id;
 }
 
-static char *device_get_ieee1284_id(const char *adapter, const char *bdaddr)
+static char *device_get_ieee1284_id(const char *adapter, const char *device)
 {
-	guint service_handle;
 	DBusMessage *message, *reply;
-	DBusMessageIter iter, reply_iter, iter_array;
+	DBusMessageIter iter, reply_iter;
+	DBusMessageIter reply_iter_entry;
 	const char *hcr_print = "00001126-0000-1000-8000-00805f9b34fb";
-	char *xml, *id;
+	const char *xml;
+	char *id;
 
 	/* Look for the service handle of the HCRP service */
-	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter",
-						"GetRemoteServiceHandles");
+	message = dbus_message_new_method_call("org.bluez", device,
+						"org.bluez.Device",
+						"DiscoverServices");
 	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_print);
 
 	reply = dbus_connection_send_with_reply_and_block(conn,
@@ -111,40 +144,41 @@ static char *device_get_ieee1284_id(const char *adapter, const char *bdaddr)
 		return NULL;
 
 	dbus_message_iter_init(reply, &reply_iter);
+
 	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
 		dbus_message_unref(reply);
-		return NULL;
-	}
-
-	/* Hopefully we only get one handle, or take a punt */
-	dbus_message_iter_recurse(&reply_iter, &iter_array);
-	while (dbus_message_iter_get_arg_type(&iter_array) == DBUS_TYPE_UINT32) {
-		dbus_message_iter_get_basic(&iter_array, &service_handle);
-		dbus_message_iter_next(&iter_array);
+		return FALSE;
 	}
 
-	dbus_message_unref(reply);
+	dbus_message_iter_recurse(&reply_iter, &reply_iter_entry);
 
-	/* Now get the XML for the HCRP service record */
-	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter",
-						"GetRemoteServiceRecordAsXML");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_UINT32, &service_handle);
+	/* Hopefully we only get one handle, or take a punt */
+	while (dbus_message_iter_get_arg_type(&reply_iter_entry) == DBUS_TYPE_DICT_ENTRY) {
+		guint32 key;
+		DBusMessageIter dict_entry;
 
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
 
-	dbus_message_unref(message);
+		/* Key ? */
+		dbus_message_iter_get_basic(&dict_entry, &key);
+		if (!key) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
 
-	if (!reply)
-		return NULL;
+		/* Try to get the value */
+		if (!dbus_message_iter_next(&dict_entry)) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
 
-	dbus_message_iter_init(reply, &reply_iter);
-	dbus_message_iter_get_basic(&reply_iter, &xml);
+		dbus_message_iter_get_basic(&dict_entry, &xml);
 
-	id = parse_xml_sdp(xml);
+		id = sdp_xml_parse_record(xml);
+		if (id != NULL)
+			break;
+		dbus_message_iter_next(&reply_iter_entry);
+	}
 
 	dbus_message_unref(reply);
 
@@ -161,8 +195,12 @@ static void add_device_to_list(const char *name, const char *bdaddr, const char
 		device = (struct cups_device *) l->data;
 
 		if (strcmp(device->bdaddr, bdaddr) == 0) {
-			g_free(device->name);
-			device->name = g_strdup(name);
+			if (device->name != name) {
+				g_free(device->name);
+				device->name = g_strdup(name);
+			}
+			g_free(device->id);
+			device->id = g_strdup(id);
 			return;
 		}
 	}
@@ -176,25 +214,12 @@ static void add_device_to_list(const char *name, const char *bdaddr, const char
 	device_list = g_slist_prepend(device_list, device);
 }
 
-static char *escape_name(const char *str, char orig, char dest)
-{
-	char *ret, *s;
-
-	ret = g_strdup(str);
-	while ((s = strchr(ret, orig)) != NULL)
-		s[0] = dest;
-	return ret;
-}
-
 static void print_printer_details(const char *name, const char *bdaddr, const char *id)
 {
 	char *uri, *escaped;
-	guint len;
 
-	escaped = escape_name(name, '\"', '\'');
-	len = strlen("bluetooth://") + 12 + 1;
-	uri = g_malloc(len);
-	snprintf(uri, len, "bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
+	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
+	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
 		 bdaddr[0], bdaddr[1],
 		 bdaddr[3], bdaddr[4],
 		 bdaddr[6], bdaddr[7],
@@ -205,53 +230,78 @@ static void print_printer_details(const char *name, const char *bdaddr, const ch
 	if (id != NULL)
 		printf(" \"%s\"\n", id);
 	else
-		printf ("\n");
+		printf("\n");
 	g_free(escaped);
 	g_free(uri);
 }
 
-static gboolean device_is_printer(const char *adapter, const char *bdaddr)
+static gboolean parse_device_properties(DBusMessageIter *reply_iter, char **name, char **bdaddr)
 {
-	char *class;
-	DBusMessage *message, *reply;
-	DBusMessageIter iter, reply_iter;
+	guint32 class = 0;
+	DBusMessageIter reply_iter_entry;
 
-	message = dbus_message_new_method_call("org.bluez", adapter,
-					       "org.bluez.Adapter",
-					       "GetRemoteMinorClass");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
+		return FALSE;
 
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+	dbus_message_iter_recurse(reply_iter, &reply_iter_entry);
 
-	dbus_message_unref(message);
+	while (dbus_message_iter_get_arg_type(&reply_iter_entry) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter dict_entry, iter_dict_val;
 
-	if (!reply)
-		return FALSE;
+		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
 
-	dbus_message_iter_init(reply, &reply_iter);
-	dbus_message_iter_get_basic(&reply_iter, &class);
+		/* Key == Class ? */
+		dbus_message_iter_get_basic(&dict_entry, &key);
+		if (!key) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
 
-	if (class != NULL && strcmp(class, PRINTER_SERVICE_CLASS_NAME) == 0) {
-		dbus_message_unref(reply);
-		return TRUE;
+		if (strcmp(key, "Class") != 0 &&
+				strcmp(key, "Alias") != 0 &&
+				strcmp(key, "Address") != 0) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+
+		/* Try to get the value */
+		if (!dbus_message_iter_next(&dict_entry)) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+		dbus_message_iter_recurse(&dict_entry, &iter_dict_val);
+		if (strcmp(key, "Class") == 0) {
+			dbus_message_iter_get_basic(&iter_dict_val, &class);
+		} else {
+			const char *value;
+			dbus_message_iter_get_basic(&iter_dict_val, &value);
+			if (strcmp(key, "Alias") == 0) {
+				*name = g_strdup(value);
+			} else if (bdaddr) {
+				*bdaddr = g_strdup(value);
+			}
+		}
+		dbus_message_iter_next(&reply_iter_entry);
 	}
 
+	if (class == 0)
+		return FALSE;
+	if (((class & 0x1f00) >> 8) == 0x06 && (class & 0x80))
+		return TRUE;
+
 	return FALSE;
 }
 
-static char *device_get_name(const char *adapter, const char *bdaddr)
+static gboolean device_is_printer(const char *adapter, const char *device_path, char **name, char **bdaddr)
 {
 	DBusMessage *message, *reply;
-	DBusMessageIter iter, reply_iter;
-	char *name;
+	DBusMessageIter reply_iter;
+	gboolean retval;
 
-	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter",
-						"GetRemoteName");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+	message = dbus_message_new_method_call("org.bluez", device_path,
+					       "org.bluez.Device",
+					       "GetProperties");
 
 	reply = dbus_connection_send_with_reply_and_block(conn,
 							message, -1, NULL);
@@ -259,56 +309,78 @@ static char *device_get_name(const char *adapter, const char *bdaddr)
 	dbus_message_unref(message);
 
 	if (!reply)
-		return NULL;
+		return FALSE;
 
 	dbus_message_iter_init(reply, &reply_iter);
-	dbus_message_iter_get_basic(&reply_iter, &name);
 
-	name = g_strdup(name);
+	retval = parse_device_properties(&reply_iter, name, bdaddr);
+
 	dbus_message_unref(reply);
 
-	return name;
+	return retval;
 }
 
-static void remote_device_found(const char *adapter, const char *bdaddr, guint class, int rssi)
+static void remote_device_found(const char *adapter, const char *bdaddr, const char *name)
 {
-	uint8_t major_index = (class >> 8) & 0x1F;
-	uint8_t minor_index;
-	uint8_t shift_minor = 0;
-	gboolean found = FALSE;
-	char *name, *id;
-
-	/* Check if we have a printer
-	 * From hcid/dbus-adapter.c minor_class_str() */
-	if (major_index != 6)
-		return;
+	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessageIter iter;
+	char *object_path = NULL;
+	char *id;
 
-	minor_index = (class >> 4) & 0x0F;
-	while (shift_minor < 4) {
-		if (((minor_index >> shift_minor) & 0x01) == 0x01) {
-			if (shift_minor == 3) {
-				found = TRUE;
-				break;
-			}
-		}
-		shift_minor++;
+	adapter_reply = NULL;
+
+	if (adapter == NULL) {
+		message = dbus_message_new_method_call("org.bluez", "/",
+						       "org.bluez.Manager",
+						       "DefaultAdapter");
+
+		adapter_reply = dbus_connection_send_with_reply_and_block(conn,
+								  message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (dbus_message_get_args(adapter_reply, NULL, DBUS_TYPE_OBJECT_PATH, &adapter, DBUS_TYPE_INVALID) == FALSE)
+			return;
 	}
 
-	if (!found)
-		return;
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					       "org.bluez.Adapter",
+					       "FindDevice");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	if (adapter_reply != NULL)
+		dbus_message_unref(adapter_reply);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply) {
+		message = dbus_message_new_method_call("org.bluez", adapter,
+						       "org.bluez.Adapter",
+						       "CreateDevice");
+		dbus_message_iter_init_append(message, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
 
-	name = device_get_name(adapter, bdaddr);
-	id = device_get_ieee1284_id(adapter, bdaddr);
+		reply = dbus_connection_send_with_reply_and_block(conn,
+								  message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!reply)
+			return;
+	} else {
+		if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE)
+			return;
+	}
+
+	id = device_get_ieee1284_id(adapter, object_path);
 	add_device_to_list(name, bdaddr, id);
-	g_free(name);
 	g_free(id);
 }
 
-static void remote_name_updated(const char *bdaddr, const char *name)
-{
-	add_device_to_list(name, bdaddr, NULL);
-}
-
 static void discovery_completed(void)
 {
 	GSList *l;
@@ -317,7 +389,10 @@ static void discovery_completed(void)
 		struct cups_device *device = (struct cups_device *) l->data;
 
 		if (device->name == NULL)
-			device->name = escape_name(device->bdaddr, ':', '-');
+			device->name = g_strdelimit(g_strdup(device->bdaddr), ":", '-');
+		/* Give another try to getting an ID for the device */
+		if (device->id == NULL)
+			remote_device_found(NULL, device->bdaddr, device->name);
 		print_printer_details(device->name, device->bdaddr, device->id);
 		g_free(device->name);
 		g_free(device->bdaddr);
@@ -356,7 +431,7 @@ static gboolean list_known_printers(const char *adapter)
 
 	message = dbus_message_new_method_call ("org.bluez", adapter,
 						"org.bluez.Adapter",
-						"ListRemoteDevices");
+						"ListDevices");
 	if (message == NULL)
 		return FALSE;
 
@@ -376,18 +451,21 @@ static gboolean list_known_printers(const char *adapter)
 	}
 
 	dbus_message_iter_recurse(&reply_iter, &iter_array);
-	while (dbus_message_iter_get_arg_type(&iter_array) == DBUS_TYPE_STRING) {
-		char *bdaddr;
+	while (dbus_message_iter_get_arg_type(&iter_array) == DBUS_TYPE_OBJECT_PATH) {
+		const char *object_path;
+		char *name = NULL;
+		char *bdaddr = NULL;
 
-		dbus_message_iter_get_basic(&iter_array, &bdaddr);
-		if (device_is_printer(adapter, bdaddr)) {
-			char *name, *id;
-			name = device_get_name(adapter, bdaddr);
-			id = device_get_ieee1284_id(adapter, bdaddr);
+		dbus_message_iter_get_basic(&iter_array, &object_path);
+		if (device_is_printer(adapter, object_path, &name, &bdaddr)) {
+			char *id;
+
+			id = device_get_ieee1284_id(adapter, object_path);
 			add_device_to_list(name, bdaddr, id);
-			g_free(name);
 			g_free(id);
 		}
+		g_free(name);
+		g_free(bdaddr);
 		dbus_message_iter_next(&iter_array);
 	}
 
@@ -398,32 +476,22 @@ static gboolean list_known_printers(const char *adapter)
 
 static DBusHandlerResult filter_func(DBusConnection *connection, DBusMessage *message, void *user_data)
 {
-	const char *adapter;
-
 	if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"RemoteDeviceFound")) {
-		char *bdaddr;
-		guint class;
-		int rssi;
+						"DeviceFound")) {
+		const char *adapter, *bdaddr;
+		char *name;
+		DBusMessageIter iter;
 
-		dbus_message_get_args(message, NULL,
-					DBUS_TYPE_STRING, &bdaddr,
-					DBUS_TYPE_UINT32, &class,
-					DBUS_TYPE_INT32, &rssi,
-					DBUS_TYPE_INVALID);
-		adapter = dbus_message_get_path(message);
-		remote_device_found(adapter, bdaddr, class, rssi);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
-							"RemoteNameUpdated")) {
-		char *bdaddr, *name;
+		dbus_message_iter_init(message, &iter);
+		dbus_message_iter_get_basic(&iter, &bdaddr);
+		dbus_message_iter_next(&iter);
 
-		dbus_message_get_args(message, NULL,
-					DBUS_TYPE_STRING, &bdaddr,
-					DBUS_TYPE_STRING, &name,
-					DBUS_TYPE_INVALID);
-		remote_name_updated(bdaddr, name);
+		adapter = dbus_message_get_path(message);
+		if (parse_device_properties(&iter, &name, NULL))
+			remote_device_found(adapter, bdaddr, name);
+		g_free (name);
 	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"RemoteDeviceDisappeared")) {
+						"DeviceDisappeared")) {
 		char *bdaddr;
 
 		dbus_message_get_args(message, NULL,
@@ -431,8 +499,21 @@ static DBusHandlerResult filter_func(DBusConnection *connection, DBusMessage *me
 					DBUS_TYPE_INVALID);
 		remote_device_disappeared(bdaddr);
 	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"DiscoveryCompleted")) {
-		discovery_completed();
+						"PropertyChanged")) {
+		DBusMessageIter iter, value_iter;
+		const char *name;
+		gboolean discovering;
+
+		dbus_message_iter_init(message, &iter);
+		dbus_message_iter_get_basic(&iter, &name);
+		dbus_message_iter_next(&iter);
+		dbus_message_iter_recurse(&iter, &value_iter);
+		dbus_message_iter_get_basic(&value_iter, &discovering);
+
+		if (discovering == FALSE && doing_disco) {
+			doing_disco = FALSE;
+			discovery_completed();
+		}
 	}
 
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -452,7 +533,6 @@ static gboolean list_printers(void)
 	DBusMessage *reply, *message;
 	DBusMessageIter reply_iter;
 	char *adapter, *match;
-	guint len;
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (conn == NULL)
@@ -486,7 +566,7 @@ static gboolean list_printers(void)
 	}
 
 	dbus_message_iter_init(reply, &reply_iter);
-	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_STRING) {
+	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_OBJECT_PATH) {
 		dbus_message_unref(reply);
 		dbus_connection_unref(conn);
 		return FALSE;
@@ -508,19 +588,17 @@ static gboolean list_printers(void)
 	"sender='org.bluez',"			\
 	"path='%s'"
 
-	len = strlen(MATCH_FORMAT) - 2 + strlen(adapter) + 1;
-	match = g_malloc(len);
-	snprintf(match, len, "type='signal',"
-				"interface='org.bluez.Adapter',"
-				"sender='org.bluez',"
-				"path='%s'",
-				adapter);
+	match = g_strdup_printf(MATCH_FORMAT, adapter);
 	dbus_bus_add_match(conn, match, &error);
 	g_free(match);
 
+	/* Add the the recent devices */
+	list_known_printers(adapter);
+
+	doing_disco = TRUE;
 	message = dbus_message_new_method_call("org.bluez", adapter,
 					"org.bluez.Adapter",
-					"DiscoverDevicesWithoutNameResolving");
+					"StartDiscovery");
 
 	if (!dbus_connection_send_with_reply(conn, message, NULL, -1)) {
 		dbus_message_unref(message);
@@ -530,9 +608,6 @@ static gboolean list_printers(void)
 	}
 	dbus_message_unref(message);
 
-	/* Also add the the recent devices */
-	g_timeout_add(0, (GSourceFunc) list_known_printers, adapter);
-
 	loop = g_main_loop_new(NULL, TRUE);
 	g_main_loop_run(loop);
 
-- 
1.6.0.6


--=-fPWYTaSsnxrsqhp7M035--

