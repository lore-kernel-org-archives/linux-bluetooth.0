Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1172502119.4742.13.camel@bnocera.surrey.redhat.com>
References: <1172500627.4742.10.camel@bnocera.surrey.redhat.com>
	<1172502119.4742.13.camel@bnocera.surrey.redhat.com>
Content-Type: multipart/mixed; boundary="=-xgGudZScJDGB9xEiepj3"
Date: Mon, 26 Feb 2007 16:36:32 +0000
Message-Id: <1172507792.4742.22.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] More bluez-gnome patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-xgGudZScJDGB9xEiepj3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-02-26 at 15:01 +0000, Bastien Nocera wrote:
> On Mon, 2007-02-26 at 14:37 +0000, Bastien Nocera wrote:
> > Heya,
> > 
> > It's i18n this time. More UI fixes to get decent translatable strings
> > for translators (they don't like markup and extraneous linefeeds in the
> > translations, and even less sentences created by concatenating 2 bits of
> > a sentence).
> > 
> > I removed linefeeds from g_printerr, as they should already be added by
> 
> I was wrong there. g_printerr just prints to stderr, I re-added the
> linefeeds, but removed them from the translations, as they are debug
> information, not end-user messages.
> 
> > the glib code. I also added the properties dialogue to be translated.
> 
> Fixed the coding style (ie. removed spaces before braces).

Updated patch attached, it does all the above, plus:
- Use the GConfEntry in GConf "changed" callbacks, and clean up some of
that code
- Remember the old adapter mode when it changes, so that we can say "set
to non-discoverable" when changing from discoverable to connectable.
- Don't use "== TRUE", as TRUE is defined as !FALSE, so TRUE isn't
defined as a particular value.

Cheers

--=-xgGudZScJDGB9xEiepj3
Content-Disposition: attachment;
	filename*0=bluez-gnome-i18n-fixes+gconf-cleanups+popup-text-changes.patc;
	filename*1=h
Content-Type: text/x-patch;
	name=bluez-gnome-i18n-fixes+gconf-cleanups+popup-text-changes.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.55
diff -u -p -r1.55 main.c
--- applet/main.c	25 Feb 2007 18:44:17 -0000	1.55
+++ applet/main.c	26 Feb 2007 16:30:52 -0000
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
@@ -1071,42 +1101,55 @@ static void bonding_removed(DBusGProxy *
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
-	else if (g_str_equal (mode, "discoverable") == TRUE)
-		text = g_strdup_printf(_("Device has been made discoverable"));
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
@@ -1114,6 +1157,7 @@ static void adapter_free(gpointer data, 
 	adapter_list = g_list_remove(adapter_list, adapter);
 
 	g_free(adapter->path);
+	g_free(adapter->old_mode);
 	g_free(adapter);
 }
 
@@ -1186,7 +1230,7 @@ static void adapter_setup(gpointer data,
 
 	if (strcmp(formfactor, "laptop") && strcmp(formfactor, "desktop")) {
 		/* We don't know anything else */
-		formfactor = g_strdup ("uncategorized");
+		formfactor = g_strdup("uncategorized");
 	}
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
@@ -1202,7 +1246,7 @@ static void adapter_setup(gpointer data,
 	dbus_g_proxy_call(object, "SetMinorClass", NULL,
 		G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
 
-	g_free (formfactor);
+	g_free(formfactor);
 }
 #endif
 
@@ -1211,6 +1255,7 @@ static void add_adapter(const char *path
 	GList *list;
 	DBusGProxy *object;
 	struct adapter_data *adapter;
+	const char *old_mode;
 
 	list = g_list_find_custom(adapter_list, path, adapter_compare);
 	if (list && list->data) {
@@ -1241,7 +1286,7 @@ static void add_adapter(const char *path
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "ModeChanged",
-				G_CALLBACK(mode_changed), NULL, NULL);
+				G_CALLBACK(mode_changed), adapter, NULL);
 
 	dbus_g_proxy_add_signal(object, "BondingCreated",
 					G_TYPE_STRING, G_TYPE_INVALID);
@@ -1254,6 +1299,13 @@ static void add_adapter(const char *path
 
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
@@ -1412,7 +1464,7 @@ static void settings_callback(GObject *w
 	const char *command = "bluetooth-properties";
 
 	if (!g_spawn_command_line_async(command, NULL))
-		g_printerr(_("Couldn't execute command: %s\n"), command);
+		g_printerr("Couldn't execute command: %s\n", command);
 }
 
 static void activate_callback(GObject *widget, gpointer user_data)
@@ -1465,27 +1517,34 @@ static GConfEnumStringPair icon_policy_e
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
+		use_hal = gconf_value_get_bool (value);
+
 		if (use_hal == TRUE)
 			g_list_foreach(adapter_list, adapter_setup, NULL);
-#endif
+
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
@@ -1498,10 +1557,12 @@ static void gconf_callback(GConfClient *
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
@@ -1521,7 +1582,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr("Connecting to system bus failed: %s",
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);
@@ -1529,7 +1590,9 @@ int main(int argc, char *argv[])
 
 	gconf = gconf_client_get_default();
 
+#ifdef HAVE_HAL
 	use_hal = gconf_client_get_bool(gconf, PREF_USE_HAL, NULL);
+#endif
 
 	str = gconf_client_get_string(gconf, PREF_ICON_POLICY, NULL);
 	if (str) {
Index: po/POTFILES.in
===================================================================
RCS file: /cvsroot/bluez/gnome/po/POTFILES.in,v
retrieving revision 1.2
diff -u -p -r1.2 POTFILES.in
--- po/POTFILES.in	20 Aug 2006 01:40:44 -0000	1.2
+++ po/POTFILES.in	26 Feb 2007 16:30:52 -0000
@@ -1,2 +1,3 @@
 applet/main.c
+properties/main.c
 wizard/main.c
Index: properties/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/main.c,v
retrieving revision 1.33
diff -u -p -r1.33 main.c
--- properties/main.c	26 Feb 2007 10:46:50 -0000	1.33
+++ properties/main.c	26 Feb 2007 16:30:52 -0000
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
@@ -397,7 +406,7 @@ static void show_properties(const gchar 
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
-	label = create_label(_("\nDescription"));
+	label = create_label(_("Description"));
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
@@ -932,6 +941,7 @@ static void create_adapter(struct adapte
 	const guint32 timeout;
 
 	GtkWidget *vbox;
+	GtkWidget *vbox1;
 	GtkWidget *label;
 	GtkWidget *button;
 	GtkWidget *scale;
@@ -959,7 +969,7 @@ static void create_adapter(struct adapte
 	dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
 				G_TYPE_STRING, &minor, G_TYPE_INVALID);
 
-	vbox = gtk_vbox_new(FALSE, 6);
+	vbox = gtk_vbox_new(FALSE, 24);
 
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
 
@@ -976,16 +986,19 @@ static void create_adapter(struct adapte
 
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
@@ -1003,7 +1016,7 @@ static void create_adapter(struct adapte
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "off"))
 		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
@@ -1020,7 +1033,7 @@ static void create_adapter(struct adapte
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	adapter->timeout_label = label;
 
@@ -1043,7 +1056,7 @@ static void create_adapter(struct adapte
 
 	gtk_range_set_update_policy(GTK_RANGE(scale), GTK_UPDATE_DISCONTINUOUS);
 
-	gtk_box_pack_start(GTK_BOX(vbox), scale, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), scale, FALSE, FALSE, 0);
 
 	adapter->timeout_scale = scale;
 
@@ -1058,9 +1071,12 @@ static void create_adapter(struct adapte
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
 
@@ -1069,7 +1085,7 @@ static void create_adapter(struct adapte
 	if (name != NULL)
 		gtk_entry_set_text(GTK_ENTRY(entry), name);
 
-	gtk_box_pack_start(GTK_BOX(vbox), entry, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), entry, FALSE, FALSE, 0);
 
 	adapter->entry = entry;
 
@@ -1079,9 +1095,12 @@ static void create_adapter(struct adapte
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
 
@@ -1103,7 +1122,7 @@ static void create_adapter(struct adapte
 	} else
 		gtk_widget_set_sensitive(GTK_WIDGET(combobox), FALSE);
 
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), combobox, FALSE, FALSE, 0);
 
 	adapter->combo = combobox;
 
@@ -1589,42 +1608,40 @@ static DBusGProxy *setup_dbus(void)
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
 
@@ -1642,7 +1659,7 @@ int main(int argc, char *argv[])
 
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
retrieving revision 1.23
diff -u -p -r1.23 main.c
--- proximity/main.c	11 Feb 2007 21:36:19 -0000	1.23
+++ proximity/main.c	26 Feb 2007 16:30:52 -0000
@@ -514,7 +514,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr("Connecting to system bus failed: %s\n",
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);

--=-xgGudZScJDGB9xEiepj3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-xgGudZScJDGB9xEiepj3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-xgGudZScJDGB9xEiepj3--
