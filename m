Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-cc00fr6WN1btlEtlVb/b"
Date: Tue, 12 Jun 2007 18:16:59 +0100
Message-Id: <1181668619.31424.28.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] More bluez-gnome patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-cc00fr6WN1btlEtlVb/b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here goes,

This updated monster patch:
- Default to use_hal = FALSE, only enable it if it's available and
support is compiled in
- Remember the old operating mode in the adapter struct
- Only show notification popups if we're not showing the icon only when
a device is present (the icon appearing/disappearing is enough to see
that the device is connected/disconnected)
- Make all the strings more translator friendly
- Split the adapter_setup to avoid HAL round-trips getting the
formfactor multiple times
- Simplify the GConf callbacks
- Don't translate command-line warnings
- Misc UI changes (mostly frame and borders sizes)

Marcel, could you review ASAP so I can carry on doing some UI work (or
simply give me CVS access with your instructions on commits).

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-cc00fr6WN1btlEtlVb/b
Content-Disposition: attachment; filename=bluez-gnome-misc-fixes.patch
Content-Type: text/x-patch; name=bluez-gnome-misc-fixes.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.60
diff -u -p -r1.60 main.c
--- applet/main.c	7 Jun 2007 10:19:28 -0000	1.60
+++ applet/main.c	12 Jun 2007 17:07:28 -0000
@@ -59,7 +59,15 @@ static int volatile registered_auth	= 0;
 
 static DBusGConnection *conn;
 
-static gboolean use_hal = TRUE;
+static gboolean use_hal = FALSE;
+
+static GList *adapter_list = NULL;
+
+struct adapter_data {
+	char *path;
+	int attached;
+	char *old_mode;
+};
 
 typedef enum {
 	ICON_POLICY_NEVER,
@@ -231,7 +239,9 @@ static void passkey_dialog(const char *p
 	GtkWidget *label;
 	GtkWidget *entry;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	struct input_data *input;
+	gchar *text;
 
 	input = g_try_malloc0(sizeof(*input));
 	if (!input)
@@ -289,14 +299,22 @@ static void passkey_dialog(const char *p
 	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
 						GTK_SHRINK, GTK_FILL, 0, 0);
 
+	vbox = gtk_vbox_new(FALSE, 6);
+
 	label = gtk_label_new(_("Pairing request for device:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 0, 1,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
-	label = gtk_label_new(device);
+	label = gtk_label_new(NULL);
+
+	text = g_strdup_printf("<b>%s</b>", device);
+	gtk_label_set_markup(GTK_LABEL(label), text);
+	g_free(text);
 
 	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
 
@@ -306,14 +324,17 @@ static void passkey_dialog(const char *p
 
 	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 1, 2,
-			GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 0, 4);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	vbox = gtk_vbox_new(FALSE, 6);
 
-	label = gtk_label_new(_("\nEnter passkey for authentication:"));
+	label = gtk_label_new(_("Enter passkey for authentication:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 2, 3,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	entry = gtk_entry_new();
@@ -329,16 +350,14 @@ static void passkey_dialog(const char *p
 	g_signal_connect(G_OBJECT(entry), "changed",
 				G_CALLBACK(changed_callback), input);
 
-	gtk_table_attach(GTK_TABLE(table), entry, 1, 2, 3, 4,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+	gtk_container_add(GTK_CONTAINER(vbox), entry);
 
 	button = gtk_check_button_new_with_label(_("Show input"));
 
 	g_signal_connect(G_OBJECT(button), "toggled",
 				G_CALLBACK(toggled_callback), input);
 
-	gtk_table_attach(GTK_TABLE(table), button, 1, 2, 4, 5,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+	gtk_container_add(GTK_CONTAINER(vbox), button);
 
 	input_list = g_list_append(input_list, input);
 
@@ -357,6 +376,7 @@ static void confirm_dialog(const char *p
 	GtkWidget *image;
 	GtkWidget *label;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	gchar *markup;
 	struct input_data *input;
 
@@ -393,9 +413,9 @@ static void confirm_dialog(const char *p
 	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
 					GTK_STOCK_YES, GTK_RESPONSE_YES);
 
-	table = gtk_table_new(4, 2, FALSE);
+	table = gtk_table_new(2, 2, FALSE);
 
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_row_spacings(GTK_TABLE(table), 16);
 	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
 
 	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
@@ -410,11 +430,14 @@ static void confirm_dialog(const char *p
 	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
 						GTK_SHRINK, GTK_FILL, 0, 0);
 
+	vbox = gtk_vbox_new(FALSE, 6);
 	label = gtk_label_new(_("Pairing request for device:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 0, 1,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	label = gtk_label_new(device);
@@ -427,14 +450,17 @@ static void confirm_dialog(const char *p
 
 	gtk_widget_set_size_request(GTK_WIDGET(label), 260, -1);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 1, 2,
-			GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 0, 4);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	vbox = gtk_vbox_new(FALSE, 6);
 
-	label = gtk_label_new(_("\nConfirm value for authentication:"));
+	label = gtk_label_new(_("Confirm value for authentication:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 2, 3,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	label = gtk_label_new(NULL);
@@ -447,8 +473,7 @@ static void confirm_dialog(const char *p
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 3, 4,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
 
 	input_list = g_list_append(input_list, input);
 
@@ -467,7 +492,7 @@ static void auth_dialog(const char *path
 	GtkWidget *image;
 	GtkWidget *label;
 	GtkWidget *table;
-	gchar *markup;
+	gchar *markup, *text;
 	struct input_data *input;
 
 	input = g_try_malloc0(sizeof(*input));
@@ -544,8 +569,11 @@ static void auth_dialog(const char *path
 
 	label = gtk_label_new(NULL);
 
-	markup = g_strdup_printf("\n<b>%s %s?</b>\n",
-					_("Grant access to"), profile);
+	/* translators: Whether to grant access to a particular service
+	 * to the device mentioned */
+	text = g_strdup_printf(_("Grant access to %s?"), profile);
+	markup = g_strdup_printf("<b>%s</b>\n", text);
+	g_free(text);
 
 	gtk_label_set_markup(GTK_LABEL(label), markup);
 
@@ -696,7 +724,7 @@ static gboolean passkey_agent_request(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text;
+	gchar *device, *text, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -718,9 +746,11 @@ static gboolean passkey_agent_request(Pa
 
 	passkey_dialog(path, address, device, context);
 
-	text = g_strdup_printf(_("Pairing request for %s\n\n"
-			"Click to open passkey entry dialog"), device);
-
+	/* translators: this is a popup telling you a particular device
+	 * has asked for pairing */
+	line = g_strdup_printf(_("Pairing request for '%s'"), device);
+	text = g_strconcat(line, "\n\n", _("Click to open passkey entry dialog"), NULL);
+	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -737,7 +767,7 @@ static gboolean passkey_agent_confirm(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text;
+	gchar *device, *text, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -759,9 +789,9 @@ static gboolean passkey_agent_confirm(Pa
 
 	confirm_dialog(path, address, value, device, context);
 
-	text = g_strdup_printf(_("Pairing request for %s\n\n"
-			"Click to open confirmation dialog"), device);
-
+	line = g_strdup_printf(_("Pairing request for '%s'"), device);
+	text = g_strconcat(line, "\n\n", _("Click to open confirmation dialog"), NULL);
+	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -871,7 +901,7 @@ static gboolean auth_agent_authorize(Pas
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *profile, *text;
+	gchar *device, *profile, *text, *line;
 
 	if (auto_authorize == TRUE) {
 		dbus_g_method_return(context);
@@ -904,9 +934,9 @@ static gboolean auth_agent_authorize(Pas
 
 	auth_dialog(path, address, service, uuid, device, profile, context);
 
-	text = g_strdup_printf(_("Authorization request for %s\n\n"
-			"Click to open authorization dialog"), device);
-
+	line = g_strdup_printf(_("Authorization request for %s"), device);
+	text = g_strconcat(line, "\n\n", _("Click to open authorization dialog"), NULL);
+	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -1071,46 +1101,59 @@ static void bonding_removed(DBusGProxy *
 	g_free(text);
 }
 
+static void
+set_new_mode (struct adapter_data *adapter, const char *mode)
+{
+	g_free (adapter->old_mode);
+	adapter->old_mode = g_strdup (mode);
+}
+
 static void mode_changed(DBusGProxy *object,
 				const char *mode, gpointer user_data)
 {
-	const char *adapter = NULL;
-	gchar *text;
+	struct adapter_data *adapter = (struct adapter_data *) user_data;
+	const char *adapter_name = NULL;
+	const char *text;
 
 	if (icon_policy == ICON_POLICY_PRESENT) {
-		if (g_str_equal(mode, "off") == TRUE)
+		if (g_str_equal(mode, "off") == TRUE) {
+			set_new_mode(adapter, mode);
+			return;
+		}
+		if (g_str_equal(adapter->old_mode, "off")
+		    && g_str_equal(mode, "connectable")) {
+			set_new_mode(adapter, mode);
 			return;
+		}
 	}
 
-	if (g_str_equal(mode, "off") == TRUE)
-		text = g_strdup_printf(_("Device has been switched off"));
-	else if (g_str_equal(mode, "connectable") == TRUE)
-		text = g_strdup_printf(_("Device has been made connectable"));
-	else if (g_str_equal(mode, "discoverable") == TRUE)
-		text = g_strdup_printf(_("Device has been made discoverable"));
-	else if (g_str_equal(mode, "limited") == TRUE)
-		text = g_strdup_printf(_("Device has been made limited discoverable"));
-	else if (g_str_equal(mode, "pairing") == TRUE)
-		text = g_strdup_printf(_("Device has been switched into pairing mode"));
-	else
+	if (g_str_equal(mode, "off") != FALSE) {
+		text = N_("Device has been switched off");
+	} else if (g_str_equal(mode, "connectable") != FALSE
+		   && g_str_equal(adapter->old_mode, "discoverable") != FALSE) {
+		text = N_("Device has been made non-discoverable");
+	} else if (g_str_equal(mode, "connectable") != FALSE) {
+		text = N_("Device has been made connectable");
+	} else if (g_str_equal (mode, "discoverable") != FALSE) {
+		text = N_("Device has been made discoverable");
+	} else if (g_str_equal(mode, "limited") != FALSE) {
+		text = N_("Device has been made limited discoverable");
+	} else if (g_str_equal(mode, "pairing") != FALSE) {
+		text = N_("Device has been switched into pairing mode");
+	} else {
+		set_new_mode(adapter, mode);
 		return;
+	}
 
 	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
+				G_TYPE_STRING, &adapter_name, G_TYPE_INVALID);
 
-	show_notification(adapter ? adapter : _("Bluetooth device"),
-							text, 3000, NULL);
+	show_notification(adapter_name ? adapter_name : _("Bluetooth device"),
+							_(text), 3000, NULL);
 
-	g_free(text);
+	set_new_mode(adapter, mode);
 }
 
-static GList *adapter_list = NULL;
-
-struct adapter_data {
-	char *path;
-	int attached;
-};
-
 static void adapter_free(gpointer data, gpointer user_data)
 {
 	struct adapter_data *adapter = data;
@@ -1118,6 +1161,7 @@ static void adapter_free(gpointer data, 
 	adapter_list = g_list_remove(adapter_list, adapter);
 
 	g_free(adapter->path);
+	g_free(adapter->old_mode);
 	g_free(adapter);
 }
 
@@ -1155,27 +1199,25 @@ static int attached_adapters(void)
 }
 
 #ifdef HAVE_HAL
-static void adapter_setup(gpointer data, gpointer user_data)
+static char *get_form_factor(void)
 {
-	struct adapter_data *adapter = data;
 	LibHalContext *ctx;
-	DBusGProxy *object;
 	char *formfactor;
 
 	ctx = libhal_ctx_new();
 	if (ctx == NULL)
-		return;
+		return NULL;
 
 	if (libhal_ctx_set_dbus_connection(ctx,
 			dbus_g_connection_get_connection(conn)) == FALSE) {
 		libhal_ctx_free(ctx);
-		return;
+		return NULL;
 	}
 
 	if (libhal_ctx_init(ctx, NULL) == FALSE) {
 		g_warning("Unable to init HAL context");
 		libhal_ctx_free(ctx);
-		return;
+		return NULL;
 	}
 
 	formfactor = libhal_device_get_property_string(ctx,
@@ -1185,12 +1227,21 @@ static void adapter_setup(gpointer data,
 	libhal_ctx_shutdown(ctx, NULL);
 	libhal_ctx_free(ctx);
 
+	return formfactor;
+}
+
+static void adapter_setup(gpointer data, gpointer user_data)
+{
+	struct adapter_data *adapter = data;
+	const char *formfactor = user_data;
+	DBusGProxy *object;
+
 	if (formfactor == NULL)
 		return;
 
 	if (strcmp(formfactor, "laptop") && strcmp(formfactor, "desktop")) {
 		/* We don't know anything else */
-		formfactor = g_strdup ("uncategorized");
+		formfactor = g_strdup("uncategorized");
 	}
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
@@ -1206,7 +1257,7 @@ static void adapter_setup(gpointer data,
 	dbus_g_proxy_call(object, "SetMinorClass", NULL,
 		G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
 
-	g_free (formfactor);
+	g_free(formfactor);
 }
 #endif
 
@@ -1215,6 +1266,7 @@ static void add_adapter(const char *path
 	GList *list;
 	DBusGProxy *object;
 	struct adapter_data *adapter;
+	const char *old_mode;
 
 	list = g_list_find_custom(adapter_list, path, adapter_compare);
 	if (list && list->data) {
@@ -1234,8 +1286,13 @@ static void add_adapter(const char *path
 	adapter_list = g_list_append(adapter_list, adapter);
 
 #ifdef HAVE_HAL
-	if (use_hal == TRUE)
-		adapter_setup(adapter, NULL);
+	if (use_hal == TRUE) {
+		char *formfactor;
+
+		formfactor = get_form_factor();
+		adapter_setup(adapter, formfactor);
+		g_free(formfactor);
+	}
 #endif
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
@@ -1245,7 +1302,7 @@ static void add_adapter(const char *path
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "ModeChanged",
-				G_CALLBACK(mode_changed), NULL, NULL);
+				G_CALLBACK(mode_changed), adapter, NULL);
 
 	dbus_g_proxy_add_signal(object, "BondingCreated",
 					G_TYPE_STRING, G_TYPE_INVALID);
@@ -1258,6 +1315,13 @@ static void add_adapter(const char *path
 
 	dbus_g_proxy_connect_signal(object, "BondingRemoved",
 				G_CALLBACK(bonding_removed), NULL, NULL);
+
+	old_mode = NULL;
+	dbus_g_proxy_call(object, "GetMode", NULL,
+			  G_TYPE_INVALID, G_TYPE_STRING,
+			  &old_mode, G_TYPE_INVALID);
+	if (old_mode != NULL)
+		set_new_mode(adapter, old_mode);
 }
 
 static void adapter_added(DBusGProxy *object,
@@ -1419,7 +1483,7 @@ static void settings_callback(GObject *w
 	const char *command = "bluetooth-properties";
 
 	if (!g_spawn_command_line_async(command, NULL))
-		g_printerr(_("Couldn't execute command: %s\n"), command);
+		g_printerr("Couldn't execute command: %s\n", command);
 }
 
 #if 0
@@ -1488,27 +1566,38 @@ static GConfEnumStringPair icon_policy_e
 static void gconf_callback(GConfClient *client, guint cnxn_id,
 					GConfEntry *entry, gpointer user_data)
 {
-	if (gconf_entry_get_value(entry) == NULL)
+	GConfValue *value;
+
+	value = gconf_entry_get_value(entry);
+	if (value == NULL)
 		return;
 
 	if (strcmp(entry->key, PREF_USE_HAL) == 0) {
-		use_hal = gconf_client_get_bool(client, entry->key, NULL);
-
 #ifdef HAVE_HAL
-		if (use_hal == TRUE)
-			g_list_foreach(adapter_list, adapter_setup, NULL);
-#endif
+		use_hal = gconf_value_get_bool (value);
+
+		if (use_hal == TRUE) {
+			char *formfactor;
+
+			formfactor = get_form_factor();
+			g_list_foreach(adapter_list, adapter_setup, formfactor);
+			g_free(formfactor);
+		}
+		return;
+#else
+		use_hal = FALSE;
+		return;
+#endif /* HAVE_HAL */
 	}
 
 	if (strcmp(entry->key, PREF_ICON_POLICY) == 0) {
 		gboolean visible;
-		char *str;
+		const char *str;
 
-		str = gconf_client_get_string(client, entry->key, NULL);
+		str = gconf_value_get_string (value);
 		if (str) {
 			gconf_string_to_enum(icon_policy_enum_map,
 							str, &icon_policy);
-			g_free(str);
 		}
 
 		visible = gtk_status_icon_get_visible(statusicon);
@@ -1521,10 +1610,12 @@ static void gconf_callback(GConfClient *
 			visible = attached_adapters() > 0 ? TRUE : FALSE;
 
 		gtk_status_icon_set_visible(statusicon, visible);
+
+		return;
 	}
 
 	if (strcmp(entry->key, PREF_AUTO_AUTHORIZE) == 0)
-		auto_authorize = gconf_client_get_bool(client, entry->key, NULL);
+		auto_authorize = gconf_value_get_bool (value);
 }
 
 int main(int argc, char *argv[])
@@ -1544,7 +1635,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr("Connecting to system bus failed: %s",
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);
@@ -1552,7 +1643,9 @@ int main(int argc, char *argv[])
 
 	gconf = gconf_client_get_default();
 
+#ifdef HAVE_HAL
 	use_hal = gconf_client_get_bool(gconf, PREF_USE_HAL, NULL);
+#endif
 
 	str = gconf_client_get_string(gconf, PREF_ICON_POLICY, NULL);
 	if (str) {
Index: properties/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/main.c,v
retrieving revision 1.35
diff -u -p -r1.35 main.c
--- properties/main.c	7 Jun 2007 11:26:17 -0000	1.35
+++ properties/main.c	12 Jun 2007 17:07:29 -0000
@@ -186,12 +186,12 @@ static GtkWidget *create_label(const gch
 
 static void create_general(void)
 {
-	GtkWidget *vbox;
+	GtkWidget *vbox, *vbox1;
 	GtkWidget *label;
 	GSList *group = NULL;
 	gboolean value;
 
-	vbox = gtk_vbox_new(FALSE, 6);
+	vbox = gtk_vbox_new(FALSE, 24);
 
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
 
@@ -199,9 +199,12 @@ static void create_general(void)
 
 	gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(notebook), vbox, _("General"));
 
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
+
 	label = create_label(_("Authorization requests"));
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	button_autoauth = gtk_check_button_new_with_label(
 			_("Automatically authorize incoming requests"));
@@ -210,15 +213,18 @@ static void create_general(void)
 
 	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_autoauth), value);
 
-	gtk_box_pack_start(GTK_BOX(vbox), button_autoauth, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button_autoauth, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button_autoauth), "toggled",
 					G_CALLBACK(autoauth_callback), NULL);
 
 #ifdef HAVE_HAL
-	label = create_label(_("\nHardware database"));
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	label = create_label(_("Hardware database"));
+
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	button_usehal = gtk_check_button_new_with_label(
 				_("Select class of device automatically"));
@@ -227,22 +233,25 @@ static void create_general(void)
 
 	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_usehal), value);
 
-	gtk_box_pack_start(GTK_BOX(vbox), button_usehal, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button_usehal, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button_usehal), "toggled",
 					G_CALLBACK(usehal_callback), NULL);
 #endif
 
-	label = create_label(_("\nNotification area"));
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	label = create_label(_("Notification area"));
+
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	button_never = gtk_radio_button_new_with_label(group,
 						_("Never display icon"));
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button_never));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button_never, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button_never, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button_never), "toggled",
 					G_CALLBACK(policy_callback), NULL);
@@ -252,7 +261,7 @@ static void create_general(void)
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button_present));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button_present, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button_present, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button_present), "toggled",
 					G_CALLBACK(policy_callback), NULL);
@@ -262,7 +271,7 @@ static void create_general(void)
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button_always));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button_always, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button_always, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button_always), "toggled",
 					G_CALLBACK(policy_callback), NULL);
@@ -398,7 +407,7 @@ static void show_properties(const gchar 
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
-	label = create_label(_("\nDescription"));
+	label = create_label(_("Description"));
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
@@ -938,6 +947,7 @@ static void create_adapter(struct adapte
 	const gchar **array = NULL;
 
 	GtkWidget *vbox;
+	GtkWidget *vbox1;
 	GtkWidget *label;
 	GtkWidget *button;
 	GtkWidget *scale;
@@ -978,7 +988,7 @@ static void create_adapter(struct adapte
 	dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
 				G_TYPE_STRING, &minor, G_TYPE_INVALID);
 
-	vbox = gtk_vbox_new(FALSE, 6);
+	vbox = gtk_vbox_new(FALSE, 24);
 
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
 
@@ -995,16 +1005,19 @@ static void create_adapter(struct adapte
 
 	adapter->child = vbox;
 
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
+
 	label = create_label(_("Mode of operation"));
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	button = gtk_radio_button_new_with_label(group,
 					_("Other devices can connect"));
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "off"))
 		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
@@ -1022,7 +1035,7 @@ static void create_adapter(struct adapte
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "off"))
 		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
@@ -1060,7 +1073,7 @@ static void create_adapter(struct adapte
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	adapter->timeout_label = label;
 
@@ -1083,7 +1096,7 @@ static void create_adapter(struct adapte
 
 	gtk_range_set_update_policy(GTK_RANGE(scale), GTK_UPDATE_DISCONTINUOUS);
 
-	gtk_box_pack_start(GTK_BOX(vbox), scale, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), scale, FALSE, FALSE, 0);
 
 	adapter->timeout_scale = scale;
 
@@ -1103,9 +1116,12 @@ static void create_adapter(struct adapte
 		gtk_widget_set_sensitive(GTK_WIDGET(scale), FALSE);
 	}
 
-	label = create_label(_("\nAdapter name"));
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	label = create_label(_("Adapter name"));
+
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	entry = gtk_entry_new();
 
@@ -1114,7 +1130,7 @@ static void create_adapter(struct adapte
 	if (name != NULL)
 		gtk_entry_set_text(GTK_ENTRY(entry), name);
 
-	gtk_box_pack_start(GTK_BOX(vbox), entry, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), entry, FALSE, FALSE, 0);
 
 	adapter->entry = entry;
 
@@ -1124,9 +1140,12 @@ static void create_adapter(struct adapte
 	g_signal_connect(G_OBJECT(entry), "focus-out-event",
 					G_CALLBACK(focus_callback), adapter);
 
-	label = create_label(_("\nClass of device"));
+	vbox1 = gtk_vbox_new(FALSE, 6);
+	gtk_box_pack_start(GTK_BOX(vbox), vbox1, FALSE, FALSE, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	label = create_label(_("Class of device"));
+
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	combobox = gtk_combo_box_new_text();
 
@@ -1148,7 +1167,7 @@ static void create_adapter(struct adapte
 	} else
 		gtk_widget_set_sensitive(GTK_WIDGET(combobox), FALSE);
 
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), combobox, FALSE, FALSE, 0);
 
 	adapter->combo = combobox;
 
@@ -1641,42 +1660,40 @@ static DBusGProxy *setup_dbus(void)
 static void gconf_callback(GConfClient *client, guint cnxn_id,
 					GConfEntry *entry, gpointer user_data)
 {
-	if (gconf_entry_get_value(entry) == NULL)
+	GConfValue *value;
+
+	value = gconf_entry_get_value(entry);
+	if (value == NULL)
 		return;
 
 	if (strcmp(entry->key, PREF_USE_HAL) == 0) {
-		gboolean value;
-
-		value = gconf_client_get_bool(client, entry->key, NULL);
-
 		if (!button_usehal)
 			return;
 
-		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_usehal), value);
+		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_usehal),
+					     gconf_value_get_bool(value));
+		return;
 	}
 
 	if (strcmp(entry->key, PREF_ICON_POLICY) == 0) {
-		char *str;
+		const char *str;
 
-		str = gconf_client_get_string(client, entry->key, NULL);
+		str = gconf_value_get_string(value);
 		if (str) {
 			gconf_string_to_enum(icon_policy_enum_map,
 							str, &icon_policy);
-			g_free(str);
 		}
 
 		update_icon_policy(NULL);
+		return;
 	}
 
 	if (strcmp(entry->key, PREF_AUTO_AUTHORIZE) == 0) {
-		gboolean value;
-
-		value = gconf_client_get_bool(client, entry->key, NULL);
-
 		if (!button_autoauth)
 			return;
 
-		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_autoauth), value);
+		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button_autoauth),
+					     gconf_value_get_bool(value));
 	}
 }
 
@@ -1694,7 +1711,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr("Connecting to system bus failed: %s\n",
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);
Index: proximity/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/proximity/main.c,v
retrieving revision 1.24
diff -u -p -r1.24 main.c
--- proximity/main.c	8 May 2007 17:11:51 -0000	1.24
+++ proximity/main.c	12 Jun 2007 17:07:30 -0000
@@ -518,7 +518,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr("Connecting to system bus failed: %s\n",
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);

--=-cc00fr6WN1btlEtlVb/b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-cc00fr6WN1btlEtlVb/b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-cc00fr6WN1btlEtlVb/b--
