Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 07/15] GATT server: parse characteristics
Date: Wed, 16 Mar 2011 21:00:31 -0400
Message-Id: <1300323639-13296-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |  208 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 208 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index b746449..728c2ab 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <errno.h>
 
 #include <gdbus.h>
@@ -35,12 +36,36 @@
 #include "adapter.h"
 #include "error.h"
 #include "log.h"
+#include "att.h"
 
 #define GATT_PROFILE_INTERFACE "org.bluez.GattProfile"
 
 static DBusConnection *connection = NULL;
 static const char *any_path = NULL;
 
+struct gatt_descriptor {
+	uint16_t type;
+	union {
+		uint16_t ext_props;
+		uint16_t client_cfg;
+		uint16_t server_cfg;
+		gchar *description;
+		struct {
+			uint8_t format;
+			int8_t exponent;
+			uint16_t unit;
+			uint8_t namespace;
+			uint16_t description;
+		} presentation;
+	} data;
+};
+
+struct gatt_characteristic {
+	uint8_t props;
+	bt_uuid_t value_uuid;
+	GSList *descriptors;
+};
+
 struct gatt_service {
 	gboolean primary;
 	bt_uuid_t uuid;
@@ -93,6 +118,159 @@ static void parse_service(const gchar **attribute_names,
 	*services = g_slist_prepend(*services, svc);
 }
 
+static int string2uint16(uint16_t *dst, const char *src)
+{
+	int length = strlen(src);
+	char *endptr = NULL;
+
+	if (length != 4 && length != 6)
+		return -EINVAL;
+
+	*dst = strtoul(src, &endptr, 16);
+	if (endptr == NULL || *endptr != '\0')
+		return -EINVAL;
+
+	return 0;
+}
+
+static void parse_characteristic(const gchar **attribute_names,
+						const gchar **attribute_values,
+						struct gatt_service *cur_svc)
+{
+	struct gatt_characteristic *chr;
+	const gchar *uuid = NULL, *props = NULL;
+	uint16_t u16 = 0x00;
+	bt_uuid_t value_uuid;
+	int i;
+
+	for (i = 0; attribute_names[i]; i++) {
+		if (g_strcmp0(attribute_names[i], "uuid") == 0)
+			uuid = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "properties") == 0)
+			props = attribute_values[i];
+		else
+			error("Invalid XML attribute: %s", attribute_names[i]);
+	}
+
+	if (uuid == NULL) {
+		error("Missing UUID for characteristic");
+		return;
+	}
+
+	if (bt_string_to_uuid(&value_uuid, uuid) < 0) {
+		error("Invalid UUID: %s", uuid);
+		return;
+	}
+
+	if (props != NULL && (string2uint16(&u16, props) < 0 || u16 > 0xff)) {
+		error("Invalid properties: %s", props);
+		return;
+	}
+
+	chr = g_new0(struct gatt_characteristic, 1);
+	chr->props = u16;
+	memcpy(&chr->value_uuid, &value_uuid, sizeof(chr->value_uuid));
+
+	DBG("New characteristic with UUID %s, properties 0x%02x", uuid,
+								chr->props);
+
+	cur_svc->chars = g_slist_prepend(cur_svc->chars, chr);
+}
+
+static void parse_descriptor(const gchar **attribute_names,
+				const gchar **attribute_values, uint16_t type,
+				struct gatt_service *cur_svc)
+{
+	struct gatt_characteristic *cur_chr;
+	struct gatt_descriptor dsc;
+	const gchar *fmt = NULL, *exp = NULL, *unit = NULL, *ns = NULL;
+	const gchar *desc = NULL, *value = NULL;
+	int i;
+
+	for (i = 0; attribute_names[i]; i++) {
+		if (g_strcmp0(attribute_names[i], "format") == 0)
+			fmt = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "exponent") == 0)
+			exp = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "unit") == 0)
+			unit = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "namespace") == 0)
+			ns = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "description") == 0)
+			desc = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "value") == 0)
+			value = attribute_values[i];
+		else
+			error("Invalid XML attribute: %s", attribute_names[i]);
+	}
+
+	if (type == GATT_CHARAC_FMT_UUID && (!fmt || !unit || !ns || !desc)) {
+		error("Missing fields for presentation format");
+		return;
+	}
+
+	if (type == GATT_CHARAC_USER_DESC_UUID && value == NULL) {
+		error("Missing characteristic user description value");
+		return;
+	}
+
+	dsc.type = type;
+
+	if (type == GATT_CHARAC_USER_DESC_UUID)
+		dsc.data.description = g_strdup(value);
+	else if (type == GATT_CHARAC_FMT_UUID) {
+		uint16_t u16;
+
+		if (string2uint16(&u16, fmt) < 0 || u16 > UCHAR_MAX) {
+			error("Invalid format: %s", fmt);
+			return;
+		} else
+			dsc.data.presentation.format = u16;
+
+		/* Exponent is a signed decimal value and is optional for some
+		 * formats. */
+		if (exp) {
+			char *endptr = NULL;
+			long val = strtol(exp, &endptr, 10);
+
+			if (endptr == NULL || *endptr != '\0' ||
+					val < SCHAR_MIN || val > SCHAR_MAX) {
+				error("Invalid exponent: %s", exp);
+				return;
+			} else
+				dsc.data.presentation.exponent = val;
+		} else
+			dsc.data.presentation.exponent = 0;
+
+		if (string2uint16(&u16, unit) < 0) {
+			error("Invalid unit: %s", unit);
+			return;
+		} else
+			dsc.data.presentation.unit = u16;
+
+		if (string2uint16(&u16, ns) < 0 || u16 > UCHAR_MAX) {
+			error("Invalid namespace: %s", ns);
+			return;
+		} else
+			dsc.data.presentation.namespace = u16;
+
+		if (string2uint16(&u16, desc) < 0) {
+			error("Invalid description: %s", desc);
+			return;
+		} else
+			dsc.data.presentation.description = u16;
+	}
+
+	DBG("New %s descriptor",
+		type == GATT_CHARAC_USER_DESC_UUID ? "user description" :
+		type == GATT_CHARAC_FMT_UUID ? "presentation format" :
+		"unknown");
+
+	cur_chr = cur_svc->chars->data;
+	cur_chr->descriptors = g_slist_prepend(cur_chr->descriptors,
+						g_memdup(&dsc, sizeof(dsc)));
+}
+
 static void parse_include(const gchar **attribute_names,
 						const gchar **attribute_values,
 						struct gatt_service *cur_svc)
@@ -135,6 +313,16 @@ static void element_start(GMarkupParseContext *ctx, const gchar *element_name,
 		if (cur_svc == NULL)
 			error("XML tag \"%s\" must be inside a service",
 								element_name);
+		else if (g_strcmp0(element_name, "characteristic") == 0)
+			parse_characteristic(attribute_names, attribute_values,
+								cur_svc);
+		else if (g_strcmp0(element_name, "presentation") == 0)
+			parse_descriptor(attribute_names, attribute_values,
+						GATT_CHARAC_FMT_UUID, cur_svc);
+		else if (g_strcmp0(element_name, "user-description") == 0)
+			parse_descriptor(attribute_names, attribute_values,
+						GATT_CHARAC_USER_DESC_UUID,
+						cur_svc);
 		else if (g_strcmp0(element_name, "include") == 0)
 			parse_include(attribute_names, attribute_values,
 								cur_svc);
@@ -185,6 +373,26 @@ static void resolve_includes(gpointer data, gpointer user_data)
 static void free_services(gpointer data, gpointer user_data)
 {
 	struct gatt_service *svc = data;
+	GSList *cl;
+
+	for (cl = svc->chars; cl; cl = cl->next) {
+		struct gatt_characteristic *chr = cl->data;
+		GSList *dl;
+
+		for (dl = chr->descriptors; dl; dl = dl->next) {
+			struct gatt_descriptor *dsc = dl->data;
+
+			if (dsc->type == GATT_CHARAC_USER_DESC_UUID)
+				g_free(dsc->data.description);
+
+			g_free(dsc);
+		}
+
+		g_slist_free(chr->descriptors);
+		g_free(chr);
+	}
+
+	g_slist_free(svc->chars);
 
 	g_free(svc->id);
 	g_slist_free(svc->includes);
-- 
1.7.0.4

