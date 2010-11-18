Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 6/6] Implement Discover Primary Service by Service UUID in the gatttool
Date: Thu, 18 Nov 2010 16:07:34 -0200
Message-Id: <1290103654-26788-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290017386-23969-6-git-send-email-claudio.takahasi@openbossa.org>
References: <1290017386-23969-6-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement only the first interaction of the discovery procedure. If the
response doesn't fit in the MTU, "start" and "end" options can be used
to discover the handles ranges of the remaining primary service instances.
UUID16 and UUID128 are supported in the uuid option.

Usage example:
$gatttool -i hcix -b xx:xx:xx:xx:xx:xx --uuid=1801 --primary
---
 Makefile.am       |    3 +-
 attrib/gatttool.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 03a9bf2..5f96975 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -178,7 +178,8 @@ if ATTRIBPLUGIN
 bin_PROGRAMS += attrib/gatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-			  attrib/gattrib.c btio/btio.c
+			  attrib/gattrib.c btio/btio.c \
+			  src/glib-helper.h src/glib-helper.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
 
 builtin_modules += attrib
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1a74edd..e961431 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -41,6 +41,7 @@
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
+#include "glib-helper.h"
 #include "gatt.h"
 
 /* Minimum MTU for L2CAP connections over BR/EDR */
@@ -50,6 +51,7 @@ static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
 static gchar *opt_sec_level = "low";
+static uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
@@ -144,7 +146,7 @@ static GIOChannel *do_connect(gboolean le)
 	return chan;
 }
 
-static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void primary_all_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	GAttrib *attrib = user_data;
@@ -200,9 +202,9 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	 * Read by Group Type Request until Error Response is received and
 	 * the Error Code is set to Attribute Not Found.
 	 */
-	gatt_discover_primary(attrib, end + 1, opt_end, NULL, primary_cb,
-								attrib);
 
+	gatt_discover_primary(attrib, end + 1, opt_end, NULL, primary_all_cb,
+								attrib);
 	return;
 
 done:
@@ -210,6 +212,36 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
+static void primary_by_uuid_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	GSList *ranges, *l;
+
+	if (status != 0) {
+		g_printerr("Discover primary services by UUID failed: %s\n",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	ranges = dec_find_by_type_resp(pdu, plen);
+	if (ranges == NULL) {
+		g_printerr("Protocol error!\n");
+		goto done;
+	}
+
+	for (l = ranges; l; l = l->next) {
+		struct att_range *range = l->data;
+		g_print("Starting handle: %04x Ending handle: %04x\n",
+						range->start, range->end);
+	}
+
+	g_slist_foreach(ranges, (GFunc) g_free, NULL);
+	g_slist_free(ranges);
+
+done:
+	g_main_loop_quit(event_loop);
+}
+
 static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	GAttrib *attrib = user_data;
@@ -260,8 +292,12 @@ static gboolean primary(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_discover_primary(attrib, opt_start, opt_end, NULL, primary_cb,
-								attrib);
+	if (opt_uuid)
+		gatt_discover_primary(attrib, opt_start, opt_end, opt_uuid,
+						primary_by_uuid_cb, attrib);
+	else
+		gatt_discover_primary(attrib, opt_start, opt_end, NULL,
+						primary_all_cb, attrib);
 
 	return FALSE;
 }
@@ -486,11 +522,29 @@ static gboolean characteristics_desc(gpointer user_data)
 	return FALSE;
 }
 
+static gboolean parse_uuid(const char *key, const char *value,
+				gpointer user_data, GError **error)
+{
+	if (!value)
+		return FALSE;
+
+	opt_uuid = g_try_malloc(sizeof(uuid_t));
+	if (opt_uuid == NULL)
+		return FALSE;
+
+	if (bt_string2uuid(opt_uuid, value) < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
 static GOptionEntry primary_char_options[] = {
 	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
 		"Starting handle(optional)", "0x0001" },
 	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
 		"Ending handle(optional)", "0xffff" },
+	{ "uuid", 'u', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
+		parse_uuid, "UUID16 or UUID128(optional)", "0x1801"},
 	{ NULL },
 };
 
@@ -621,6 +675,7 @@ done:
 	g_option_context_free(context);
 	g_free(opt_src);
 	g_free(opt_dst);
+	g_free(opt_uuid);
 
 	if (got_error)
 		exit(EXIT_FAILURE);
-- 
1.7.3.2

