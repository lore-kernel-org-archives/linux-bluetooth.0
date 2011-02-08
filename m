Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/5] Put all gatttool global options in a unique struct
Date: Tue,  8 Feb 2011 12:32:12 -0300
Message-Id: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |  186 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 108 insertions(+), 78 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..c612309 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -46,32 +46,56 @@
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_value = NULL;
-static gchar *opt_sec_level = "low";
-static uuid_t *opt_uuid = NULL;
-static int opt_start = 0x0001;
-static int opt_end = 0xffff;
-static int opt_handle = -1;
-static int opt_mtu = 0;
-static int opt_psm = 0x1f;
-static gboolean opt_primary = FALSE;
-static gboolean opt_characteristics = FALSE;
-static gboolean opt_char_read = FALSE;
-static gboolean opt_listen = FALSE;
-static gboolean opt_char_desc = FALSE;
-static gboolean opt_le = FALSE;
-static gboolean opt_char_write = FALSE;
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
+static struct main_opts {
+	gchar *src;
+	gchar *dst;
+	gchar *value;
+	gchar *sec_level;
+	uuid_t *uuid;
+	int start;
+	int end;
+	int handle;
+	int mtu;
+	int psm;
+	gboolean primary;
+	gboolean char_disc;
+	gboolean char_read;
+	gboolean listen;
+	gboolean char_desc;
+	gboolean le;
+	gboolean char_write;
+} main_opts;
+
 struct characteristic_data {
 	GAttrib *attrib;
 	uint16_t start;
 	uint16_t end;
 };
 
+static void options_init(void)
+{
+	main_opts.src = NULL;
+	main_opts.dst = NULL;
+	main_opts.value = NULL;
+	main_opts.sec_level = "low";
+	main_opts.uuid = NULL;
+	main_opts.start = 0x0001;
+	main_opts.end = 0xffff;
+	main_opts.handle = -1;
+	main_opts.mtu = 0;
+	main_opts.psm = 0x1f;
+	main_opts.primary = FALSE;
+	main_opts.char_disc = FALSE;
+	main_opts.char_read = FALSE;
+	main_opts.listen = FALSE;
+	main_opts.char_desc = FALSE;
+	main_opts.le = FALSE;
+	main_opts.char_write = FALSE;
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	if (err) {
@@ -90,31 +114,31 @@ static GIOChannel *do_connect(gboolean le)
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
+	if (main_opts.mtu != 0 && main_opts.mtu < ATT_MIN_MTU_L2CAP) {
 		g_printerr("MTU cannot be smaller than %d\n",
 							ATT_MIN_MTU_L2CAP);
 		return NULL;
 	}
 
 	/* Remote device */
-	if (opt_dst == NULL) {
+	if (main_opts.dst == NULL) {
 		g_printerr("Remote Bluetooth address required\n");
 		return NULL;
 	}
-	str2ba(opt_dst, &dba);
+	str2ba(main_opts.dst, &dba);
 
 	/* Local adapter */
-	if (opt_src != NULL) {
-		if (!strncmp(opt_src, "hci", 3))
-			hci_devba(atoi(opt_src + 3), &sba);
+	if (main_opts.src != NULL) {
+		if (!strncmp(main_opts.src, "hci", 3))
+			hci_devba(atoi(main_opts.src + 3), &sba);
 		else
-			str2ba(opt_src, &sba);
+			str2ba(main_opts.src, &sba);
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
-	if (strcmp(opt_sec_level, "medium") == 0)
+	if (strcmp(main_opts.sec_level, "medium") == 0)
 		sec_level = BT_IO_SEC_MEDIUM;
-	else if (strcmp(opt_sec_level, "high") == 0)
+	else if (strcmp(main_opts.sec_level, "high") == 0)
 		sec_level = BT_IO_SEC_HIGH;
 	else
 		sec_level = BT_IO_SEC_LOW;
@@ -124,15 +148,15 @@ static GIOChannel *do_connect(gboolean le)
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_OMTU, main_opts.mtu,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	else
 		chan = bt_io_connect(BT_IO_L2CAP, connect_cb, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
-				BT_IO_OPT_PSM, opt_psm,
-				BT_IO_OPT_OMTU, opt_mtu,
+				BT_IO_OPT_PSM, main_opts.psm,
+				BT_IO_OPT_OMTU, main_opts.mtu,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
@@ -236,9 +260,9 @@ static gboolean primary(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	if (opt_uuid)
-		gatt_discover_primary(attrib, opt_uuid, primary_by_uuid_cb,
-									NULL);
+	if (main_opts.uuid)
+		gatt_discover_primary(attrib, main_opts.uuid,
+						primary_by_uuid_cb, NULL);
 	else
 		gatt_discover_primary(attrib, NULL, primary_all_cb, NULL);
 
@@ -272,7 +296,8 @@ static gboolean characteristics(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_discover_char(attrib, opt_start, opt_end, char_discovered_cb, NULL);
+	gatt_discover_char(attrib, main_opts.start, main_opts.end,
+						char_discovered_cb, NULL);
 
 	return FALSE;
 }
@@ -298,7 +323,7 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	g_print("\n");
 
 done:
-	if (opt_listen == FALSE)
+	if (main_opts.listen == FALSE)
 		g_main_loop_quit(event_loop);
 }
 
@@ -310,7 +335,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	int i;
 
 	if (status == ATT_ECODE_ATTR_NOT_FOUND &&
-					char_data->start != opt_start)
+					char_data->start != main_opts.start)
 		goto done;
 
 	if (status != 0) {
@@ -339,7 +364,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	att_data_list_free(list);
 
 	gatt_read_char_by_uuid(char_data->attrib, char_data->start,
-					char_data->end, opt_uuid,
+					char_data->end, main_opts.uuid,
 					char_read_by_uuid_cb,
 					char_data);
 
@@ -353,27 +378,28 @@ static gboolean characteristics_read(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	if (opt_uuid != NULL) {
+	if (main_opts.uuid != NULL) {
 		struct characteristic_data *char_data;
 
 		char_data = g_new(struct characteristic_data, 1);
 		char_data->attrib = attrib;
-		char_data->start = opt_start;
-		char_data->end = opt_end;
+		char_data->start = main_opts.start;
+		char_data->end = main_opts.end;
 
-		gatt_read_char_by_uuid(attrib, opt_start, opt_end, opt_uuid,
-						char_read_by_uuid_cb, char_data);
+		gatt_read_char_by_uuid(attrib, main_opts.start, main_opts.end,
+					main_opts.uuid, char_read_by_uuid_cb,
+					char_data);
 
 		return FALSE;
 	}
 
-	if (opt_handle <= 0) {
+	if (main_opts.handle <= 0) {
 		g_printerr("A valid handle is required\n");
 		g_main_loop_quit(event_loop);
 		return FALSE;
 	}
 
-	gatt_read_char(attrib, opt_handle, char_read_cb, attrib);
+	gatt_read_char(attrib, main_opts.handle, char_read_cb, attrib);
 
 	return FALSE;
 }
@@ -411,23 +437,24 @@ static gboolean characteristics_write(gpointer user_data)
 	uint8_t *value;
 	size_t len;
 
-	if (opt_handle <= 0) {
+	if (main_opts.handle <= 0) {
 		g_printerr("A valid handle is required\n");
 		goto error;
 	}
 
-	if (opt_value == NULL || opt_value[0] == '\0') {
+	if (main_opts.value == NULL || main_opts.value[0] == '\0') {
 		g_printerr("A value is required\n");
 		goto error;
 	}
 
-	len = attr_data_from_string(opt_value, &value);
+	len = attr_data_from_string(main_opts.value, &value);
 	if (len == 0) {
 		g_printerr("Invalid value\n");
 		goto error;
 	}
 
-	gatt_write_cmd(attrib, opt_handle, value, len, mainloop_quit, value);
+	gatt_write_cmd(attrib, main_opts.handle, value, len, mainloop_quit,
+									value);
 
 	return FALSE;
 
@@ -474,7 +501,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	att_data_list_free(list);
 
 done:
-	if (opt_listen == FALSE)
+	if (main_opts.listen == FALSE)
 		g_main_loop_quit(event_loop);
 }
 
@@ -482,7 +509,8 @@ static gboolean characteristics_desc(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_find_info(attrib, opt_start, opt_end, char_desc_cb, NULL);
+	gatt_find_info(attrib, main_opts.start, main_opts.end,
+							char_desc_cb, NULL);
 
 	return FALSE;
 }
@@ -493,20 +521,20 @@ static gboolean parse_uuid(const char *key, const char *value,
 	if (!value)
 		return FALSE;
 
-	opt_uuid = g_try_malloc(sizeof(uuid_t));
-	if (opt_uuid == NULL)
+	main_opts.uuid = g_try_malloc(sizeof(uuid_t));
+	if (main_opts.uuid == NULL)
 		return FALSE;
 
-	if (bt_string2uuid(opt_uuid, value) < 0)
+	if (bt_string2uuid(main_opts.uuid, value) < 0)
 		return FALSE;
 
 	return TRUE;
 }
 
 static GOptionEntry primary_char_options[] = {
-	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
+	{ "start", 's' , 0, G_OPTION_ARG_INT, &main_opts.start,
 		"Starting handle(optional)", "0x0001" },
-	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
+	{ "end", 'e' , 0, G_OPTION_ARG_INT, &main_opts.end,
 		"Ending handle(optional)", "0xffff" },
 	{ "uuid", 'u', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
 		parse_uuid, "UUID16 or UUID128(optional)", "0x1801"},
@@ -514,42 +542,42 @@ static GOptionEntry primary_char_options[] = {
 };
 
 static GOptionEntry char_rw_options[] = {
-	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &opt_handle,
+	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &main_opts.handle,
 		"Read/Write characteristic by handle(required)", "0x0001" },
-	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
+	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &main_opts.value,
 		"Write characteristic value (required for write operation)",
 		"0x0001" },
 	{NULL},
 };
 
 static GOptionEntry gatt_options[] = {
-	{ "primary", 0, 0, G_OPTION_ARG_NONE, &opt_primary,
+	{ "primary", 0, 0, G_OPTION_ARG_NONE, &main_opts.primary,
 		"Primary Service Discovery", NULL },
-	{ "characteristics", 0, 0, G_OPTION_ARG_NONE, &opt_characteristics,
+	{ "characteristics", 0, 0, G_OPTION_ARG_NONE, &main_opts.char_disc,
 		"Characteristics Discovery", NULL },
-	{ "char-read", 0, 0, G_OPTION_ARG_NONE, &opt_char_read,
+	{ "char-read", 0, 0, G_OPTION_ARG_NONE, &main_opts.char_read,
 		"Characteristics Value/Descriptor Read", NULL },
-	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
+	{ "char-write", 0, 0, G_OPTION_ARG_NONE, &main_opts.char_write,
 		"Characteristics Value Write", NULL },
-	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
+	{ "char-desc", 0, 0, G_OPTION_ARG_NONE, &main_opts.char_desc,
 		"Characteristics Descriptor Discovery", NULL },
-	{ "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
+	{ "listen", 0, 0, G_OPTION_ARG_NONE, &main_opts.listen,
 		"Listen for notifications and indications", NULL },
-	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
+	{ "le", 0, 0, G_OPTION_ARG_NONE, &main_opts.le,
 		"Use Bluetooth Low Energy transport", NULL },
 	{ NULL },
 };
 
 static GOptionEntry options[] = {
-	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &opt_src,
+	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &main_opts.src,
 		"Specify local adapter interface", "hciX" },
-	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
+	{ "device", 'b', 0, G_OPTION_ARG_STRING, &main_opts.dst,
 		"Specify remote Bluetooth address", "MAC" },
-	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &opt_mtu,
+	{ "mtu", 'm', 0, G_OPTION_ARG_INT, &main_opts.mtu,
 		"Specify the MTU size", "MTU" },
-	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
+	{ "psm", 'p', 0, G_OPTION_ARG_INT, &main_opts.psm,
 		"Specify the PSM for GATT/ATT over BR/EDR", "PSM" },
-	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &opt_sec_level,
+	{ "sec-level", 'l', 0, G_OPTION_ARG_STRING, &main_opts.sec_level,
 		"Set security level. Default: low", "[low | medium | high]"},
 	{ NULL },
 };
@@ -563,6 +591,8 @@ int main(int argc, char *argv[])
 	GIOChannel *chan;
 	GSourceFunc callback;
 
+	options_init();
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -594,15 +624,15 @@ int main(int argc, char *argv[])
 		g_error_free(gerr);
 	}
 
-	if (opt_primary)
+	if (main_opts.primary)
 		callback = primary;
-	else if (opt_characteristics)
+	else if (main_opts.char_disc)
 		callback = characteristics;
-	else if (opt_char_read)
+	else if (main_opts.char_read)
 		callback = characteristics_read;
-	else if (opt_char_write)
+	else if (main_opts.char_write)
 		callback = characteristics_write;
-	else if (opt_char_desc)
+	else if (main_opts.char_desc)
 		callback = characteristics_desc;
 	else {
 		gchar *help = g_option_context_get_help(context, TRUE, NULL);
@@ -612,7 +642,7 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	chan = do_connect(opt_le);
+	chan = do_connect(main_opts.le);
 	if (chan == NULL) {
 		got_error = TRUE;
 		goto done;
@@ -622,7 +652,7 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	if (opt_listen)
+	if (main_opts.listen)
 		g_idle_add(listen_start, attrib);
 
 	g_idle_add(callback, attrib);
@@ -638,9 +668,9 @@ int main(int argc, char *argv[])
 
 done:
 	g_option_context_free(context);
-	g_free(opt_src);
-	g_free(opt_dst);
-	g_free(opt_uuid);
+	g_free(main_opts.src);
+	g_free(main_opts.dst);
+	g_free(main_opts.uuid);
 
 	if (got_error)
 		exit(EXIT_FAILURE);
-- 
1.7.1

