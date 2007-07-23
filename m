Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-/5bkms0+Hj7mgRJKYv8z"
Date: Tue, 24 Jul 2007 00:29:13 +0100
Message-Id: <1185233353.3641.82.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] 2 more patches for bluez-gnome
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


--=-/5bkms0+Hj7mgRJKYv8z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

The descriptions of each patch are in the patches, thanks git.

I'd like to start exporting some bits of the API, especially the
widgets. Marcel, when can I get some commit rights, so I can commit all
of this tedious UI code more quickly? :)

Stress-tested in front of an audience at GUADEC 2007.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-/5bkms0+Hj7mgRJKYv8z
Content-Disposition: attachment; filename=0001-Misc-bluez-gnome-fixes.patch
Content-Type: application/mbox; name=0001-Misc-bluez-gnome-fixes.patch
Content-Transfer-Encoding: 7bit

>>From 5ec31b9b78eb0fa31ccd59a146356547d02c58e8 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@snoogens.fab.redhat.com>
Date: Sat, 23 Jun 2007 03:15:46 +0100
Subject: [PATCH] Misc bluez-gnome fixes
* Default to use_hal = FALSE, only enable it if it's available and
  support is compiled in
* Remember the old operating mode in the adapter struct
* Only show notification popups if we're not showing the icon only when
  a device is present (the icon appearing/disappearing is enough to see
  that the device is connected/disconnected)
* Split the adapter_setup to avoid HAL round-trips getting the
  formfactor multiple times
* Don't use '\n' at the beginning of translatable strings (and associated
  necessary UI changes, tested with the dialogue calls in main())
* Link all the programs to gthread (just sendto was missing the linking)
* Avoid warnings on startup about g_thread_init not having been called,
  with newer glib versions
---
 applet/main.c     |  196 +++++++++++++++++++++++++++++++++++------------------
 configure.in      |    2 +-
 properties/main.c |   71 +++++++++++++-------
 proximity/main.c  |    2 +
 sendto/main.c     |    3 +
 wizard/main.c     |    2 +
 6 files changed, 185 insertions(+), 91 deletions(-)

diff --git a/applet/main.c b/applet/main.c
index 9227088..8131308 100644
--- a/applet/main.c
+++ b/applet/main.c
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
@@ -231,7 +239,9 @@ static void passkey_dialog(const char *path, const char *address,
 	GtkWidget *label;
 	GtkWidget *entry;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	struct input_data *input;
+	gchar *text;
 
 	input = g_try_malloc0(sizeof(*input));
 	if (!input)
@@ -289,14 +299,22 @@ static void passkey_dialog(const char *path, const char *address,
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
 
@@ -306,14 +324,17 @@ static void passkey_dialog(const char *path, const char *address,
 
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
@@ -329,16 +350,14 @@ static void passkey_dialog(const char *path, const char *address,
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
 
@@ -357,6 +376,7 @@ static void confirm_dialog(const char *path, const char *address,
 	GtkWidget *image;
 	GtkWidget *label;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	gchar *markup;
 	struct input_data *input;
 
@@ -393,9 +413,9 @@ static void confirm_dialog(const char *path, const char *address,
 	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
 					GTK_STOCK_YES, GTK_RESPONSE_YES);
 
-	table = gtk_table_new(4, 2, FALSE);
+	table = gtk_table_new(2, 2, FALSE);
 
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_row_spacings(GTK_TABLE(table), 16);
 	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
 
 	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
@@ -410,11 +430,14 @@ static void confirm_dialog(const char *path, const char *address,
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
@@ -427,14 +450,17 @@ static void confirm_dialog(const char *path, const char *address,
 
 	gtk_widget_set_size_request(GTK_WIDGET(label), 260, -1);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 1, 2,
-			GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 0, 4);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
 
-	label = gtk_label_new(_("\nConfirm value for authentication:"));
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Confirm value for authentication:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 2, 3,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	label = gtk_label_new(NULL);
@@ -447,8 +473,7 @@ static void confirm_dialog(const char *path, const char *address,
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 3, 4,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
 
 	input_list = g_list_append(input_list, input);
 
@@ -1079,46 +1104,59 @@ static void bonding_removed(DBusGProxy *object,
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
@@ -1126,6 +1164,7 @@ static void adapter_free(gpointer data, gpointer user_data)
 	adapter_list = g_list_remove(adapter_list, adapter);
 
 	g_free(adapter->path);
+	g_free(adapter->old_mode);
 	g_free(adapter);
 }
 
@@ -1163,27 +1202,25 @@ static int attached_adapters(void)
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
@@ -1193,6 +1230,14 @@ static void adapter_setup(gpointer data, gpointer user_data)
 	libhal_ctx_shutdown(ctx, NULL);
 	libhal_ctx_free(ctx);
 
+	return formfactor;
+}
+static void adapter_setup(gpointer data, gpointer user_data)
+{
+	struct adapter_data *adapter = data;
+	const char *formfactor = user_data;
+	DBusGProxy *object;
+
 	if (formfactor == NULL)
 		return;
 
@@ -1203,18 +1248,14 @@ static void adapter_setup(gpointer data, gpointer user_data)
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
-	if (!object) {
-		g_free(formfactor);
+	if (!object)
 		return;
-	}
 
 	dbus_g_proxy_call(object, "SetMajorClass", NULL,
 		G_TYPE_STRING, "computer", G_TYPE_INVALID, G_TYPE_INVALID);
 
 	dbus_g_proxy_call(object, "SetMinorClass", NULL,
 		G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
-
-	g_free(formfactor);
 }
 #endif
 
@@ -1223,6 +1264,7 @@ static void add_adapter(const char *path)
 	GList *list;
 	DBusGProxy *object;
 	struct adapter_data *adapter;
+	const char *old_mode;
 
 	list = g_list_find_custom(adapter_list, path, adapter_compare);
 	if (list && list->data) {
@@ -1242,8 +1284,13 @@ static void add_adapter(const char *path)
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
@@ -1253,7 +1300,7 @@ static void add_adapter(const char *path)
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "ModeChanged",
-				G_CALLBACK(mode_changed), NULL, NULL);
+				G_CALLBACK(mode_changed), adapter, NULL);
 
 	dbus_g_proxy_add_signal(object, "BondingCreated",
 					G_TYPE_STRING, G_TYPE_INVALID);
@@ -1266,6 +1313,13 @@ static void add_adapter(const char *path)
 
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
@@ -1503,12 +1557,18 @@ static void gconf_callback(GConfClient *client, guint cnxn_id,
 		return;
 
 	if (strcmp(entry->key, PREF_USE_HAL) == 0) {
+#ifdef HAVE_HAL
 		use_hal = gconf_value_get_bool(value);
 
-#ifdef HAVE_HAL
-		if (use_hal == TRUE)
-			g_list_foreach(adapter_list, adapter_setup, NULL);
+		if (use_hal == TRUE) {
+			gchar *formfactor;
+
+			formfactor = get_form_factor();
+			g_list_foreach(adapter_list, adapter_setup, formfactor);
+			g_free(formfactor);
+		}
 #endif
+		return;
 	}
 
 	if (strcmp(entry->key, PREF_ICON_POLICY) == 0) {
@@ -1516,9 +1576,10 @@ static void gconf_callback(GConfClient *client, guint cnxn_id,
 		const char *str;
 
 		str = gconf_value_get_string(value);
-		if (str)
-			gconf_string_to_enum(icon_policy_enum_map,
-							str, &icon_policy);
+		if (!str)
+			return;
+		gconf_string_to_enum(icon_policy_enum_map,
+				     str, &icon_policy);
 
 		visible = gtk_status_icon_get_visible(statusicon);
 
@@ -1530,6 +1591,7 @@ static void gconf_callback(GConfClient *client, guint cnxn_id,
 			visible = attached_adapters() > 0 ? TRUE : FALSE;
 
 		gtk_status_icon_set_visible(statusicon, visible);
+		return;
 	}
 
 	if (strcmp(entry->key, PREF_AUTO_AUTHORIZE) == 0)
@@ -1545,6 +1607,8 @@ int main(int argc, char *argv[])
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
+	g_thread_init(NULL);
+
 	gtk_init(&argc, &argv);
 
 #ifdef HAVE_LIBNOTIFY
@@ -1561,7 +1625,9 @@ int main(int argc, char *argv[])
 
 	gconf = gconf_client_get_default();
 
+#ifdef HAVE_HAL
 	use_hal = gconf_client_get_bool(gconf, PREF_USE_HAL, NULL);
+#endif
 
 	str = gconf_client_get_string(gconf, PREF_ICON_POLICY, NULL);
 	if (str) {
diff --git a/configure.in b/configure.in
index da36897..a434097 100644
--- a/configure.in
+++ b/configure.in
@@ -45,7 +45,7 @@ PKG_CHECK_MODULES(HAL, hal >= 0.5.8, [
 AC_SUBST(HAL_CFLAGS)
 AC_SUBST(HAL_LIBS)
 
-PKG_CHECK_MODULES(GTK, gtk+-2.0 >= 2.6, dummy=yes, AC_MSG_ERROR(gtk+ >= 2.6 is required))
+PKG_CHECK_MODULES(GTK, gtk+-2.0 >= 2.6 gthread-2.0, dummy=yes, AC_MSG_ERROR(gtk+ >= 2.6 is required))
 AC_SUBST(GTK_CFLAGS)
 AC_SUBST(GTK_LIBS)
 
diff --git a/properties/main.c b/properties/main.c
index 586acd8..938bcd7 100644
--- a/properties/main.c
+++ b/properties/main.c
@@ -186,12 +186,12 @@ static GtkWidget *create_label(const gchar *str)
 
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
@@ -398,7 +407,7 @@ static void show_properties(const gchar *path, const gchar *description)
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
-	label = create_label(_("\nDescription"));
+	label = create_label(_("Description"));
 
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
@@ -938,6 +947,7 @@ static void create_adapter(struct adapter_data *adapter)
 	const gchar **array = NULL;
 
 	GtkWidget *vbox;
+	GtkWidget *vbox1;
 	GtkWidget *label;
 	GtkWidget *button;
 	GtkWidget *scale;
@@ -978,7 +988,7 @@ static void create_adapter(struct adapter_data *adapter)
 	dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
 				G_TYPE_STRING, &minor, G_TYPE_INVALID);
 
-	vbox = gtk_vbox_new(FALSE, 6);
+	vbox = gtk_vbox_new(FALSE, 24);
 
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
 
@@ -995,16 +1005,19 @@ static void create_adapter(struct adapter_data *adapter)
 
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
@@ -1022,7 +1035,7 @@ static void create_adapter(struct adapter_data *adapter)
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
 
-	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "off"))
 		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
@@ -1060,7 +1073,7 @@ static void create_adapter(struct adapter_data *adapter)
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
 
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), label, FALSE, FALSE, 0);
 
 	adapter->timeout_label = label;
 
@@ -1083,7 +1096,7 @@ static void create_adapter(struct adapter_data *adapter)
 
 	gtk_range_set_update_policy(GTK_RANGE(scale), GTK_UPDATE_DISCONTINUOUS);
 
-	gtk_box_pack_start(GTK_BOX(vbox), scale, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), scale, FALSE, FALSE, 0);
 
 	adapter->timeout_scale = scale;
 
@@ -1103,9 +1116,12 @@ static void create_adapter(struct adapter_data *adapter)
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
 
@@ -1114,7 +1130,7 @@ static void create_adapter(struct adapter_data *adapter)
 	if (name != NULL)
 		gtk_entry_set_text(GTK_ENTRY(entry), name);
 
-	gtk_box_pack_start(GTK_BOX(vbox), entry, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), entry, FALSE, FALSE, 0);
 
 	adapter->entry = entry;
 
@@ -1124,9 +1140,12 @@ static void create_adapter(struct adapter_data *adapter)
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
 
@@ -1148,7 +1167,7 @@ static void create_adapter(struct adapter_data *adapter)
 	} else
 		gtk_widget_set_sensitive(GTK_WIDGET(combobox), FALSE);
 
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX(vbox1), combobox, FALSE, FALSE, 0);
 
 	adapter->combo = combobox;
 
@@ -1685,6 +1704,8 @@ int main(int argc, char *argv[])
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
+	g_thread_init(NULL);
+
 	gtk_init(&argc, &argv);
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
diff --git a/proximity/main.c b/proximity/main.c
index 4e6e096..f54502d 100644
--- a/proximity/main.c
+++ b/proximity/main.c
@@ -514,6 +514,8 @@ int main(int argc, char *argv[])
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
+	g_thread_init(NULL);
+
 	gtk_init(&argc, &argv);
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
diff --git a/sendto/main.c b/sendto/main.c
index baf4caa..0011abe 100644
--- a/sendto/main.c
+++ b/sendto/main.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <stdlib.h>
 
+#include <glib.h>
 #include <glib/gi18n.h>
 
 #include <gtk/gtk.h>
@@ -65,6 +66,8 @@ int main(int argc, char *argv[])
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
+	g_thread_init(NULL);
+
 	gtk_init(&argc, &argv);
 
 	client = bluetooth_client_new();
diff --git a/wizard/main.c b/wizard/main.c
index 2a8ffc0..9175512 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -540,6 +540,8 @@ int main(int argc, char *argv[])
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
+	g_thread_init(NULL);
+
 	gtk_init(&argc, &argv);
 
 	client = bluetooth_client_new();
-- 
1.5.2.2


--=-/5bkms0+Hj7mgRJKYv8z
Content-Disposition: attachment;
	filename=0002-Add-Browse-device.-menu-entry.patch
Content-Type: application/mbox; name=0002-Add-Browse-device.-menu-entry.patch
Content-Transfer-Encoding: 7bit

>>From a20df6227a9533e895b2ded9e77c7c93fe1d7ae3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@snoogens.fab.redhat.com>
Date: Sat, 23 Jun 2007 03:24:05 +0100
Subject: [PATCH] Add "Browse device..." menu entry
* Add a "Browse device..." menu entry
* Make menu entry unsensitive if obexftp isn't available in nautilus,
  or there's no active bluetooth device
* Move checking for an unknown formfactor to the HAL conversation function,
  not the actual setup
---
 applet/Makefile.am |    2 +-
 applet/main.c      |   71 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/applet/Makefile.am b/applet/Makefile.am
index 8eb0346..db34902 100644
--- a/applet/Makefile.am
+++ b/applet/Makefile.am
@@ -9,7 +9,7 @@ bluetooth_applet_LDADD = $(top_builddir)/compat/libcompat.a \
 nodist_bluetooth_applet_SOURCES = $(top_builddir)/common/passkey-agent-glue.h \
 					$(top_builddir)/common/auth-agent-glue.h
 
-AM_CFLAGS = @DBUS_CFLAGS@ @HAL_CFLAGS@ @GTK_CFLAGS@ @GCONF_CFLAGS@ @NOTIFY_CFLAGS@
+AM_CFLAGS = @DBUS_CFLAGS@ @HAL_CFLAGS@ @GTK_CFLAGS@ @GCONF_CFLAGS@ @NOTIFY_CFLAGS@ -DSYSCONFDIR=\"$(sysconfdir)\"
 
 INCLUDES = -I$(top_builddir)/common -I$(top_srcdir)/compat
 
diff --git a/applet/main.c b/applet/main.c
index 8131308..15e11e6 100644
--- a/applet/main.c
+++ b/applet/main.c
@@ -1230,8 +1230,15 @@ static char *get_form_factor(void)
 	libhal_ctx_shutdown(ctx, NULL);
 	libhal_ctx_free(ctx);
 
+	if (strcmp(formfactor, "laptop") && strcmp(formfactor, "desktop")) {
+		/* We don't know anything else */
+		g_free(formfactor);
+		formfactor = g_strdup("uncategorized");
+	}
+
 	return formfactor;
 }
+
 static void adapter_setup(gpointer data, gpointer user_data)
 {
 	struct adapter_data *adapter = data;
@@ -1241,11 +1248,6 @@ static void adapter_setup(gpointer data, gpointer user_data)
 	if (formfactor == NULL)
 		return;
 
-	if (strcmp(formfactor, "laptop") && strcmp(formfactor, "desktop")) {
-		/* We don't know anything else */
-		formfactor = g_strdup("uncategorized");
-	}
-
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
 	if (!object)
@@ -1398,6 +1400,49 @@ static void name_owner_changed(DBusGProxy *object, const char *name,
 	}
 }
 
+static gboolean obexftp_available(void)
+{
+	char *path;
+	gboolean retval = FALSE;
+
+	/* Look for nautilus in the PATH */
+	path = g_find_program_in_path("nautilus");
+	if (path == NULL)
+		return FALSE;
+	g_free(path);
+
+	/* Look for obex-module.conf in the system-wide dir
+	 * FIXME: should use modulesdir from gnome-vfs
+	 * http://bugzilla.gnome.org/show_bug.cgi?id=447202 */
+	path = g_build_filename(SYSCONFDIR, "gnome-vfs-2.0/modules", "obex-module.conf", NULL);
+	retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+	g_free(path);
+	if (retval != FALSE)
+		return TRUE;
+
+	/* Look in the home dir */
+	if (g_get_home_dir() != NULL) {
+		path = g_build_filename(g_get_home_dir(), ".gnome2", "vfs",
+					 "modules", "obex-module.conf", NULL);
+		retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+		g_free(path);
+		if (retval != FALSE)
+			return TRUE;
+	}
+
+	/* Look in the envvar defined dir */
+	if (g_getenv("GNOME_VFS_MODULE_CONFIG_PATH") != NULL) {
+		path = g_build_filename(g_getenv("GNOME_VFS_MODULE_CONFIG_PATH"),
+					"obex-module.conf", NULL);
+		retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+		g_free(path);
+		if (retval != FALSE)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static int setup_dbus(void)
 {
 	DBusGProxy *object;
@@ -1494,6 +1539,10 @@ static void wizard_callback(GObject *widget, gpointer user_data)
 }
 #endif
 
+static void browse_device_callback(GObject *widget, gpointer user_data)
+{
+}
+
 static void activate_callback(GObject *widget, gpointer user_data)
 {
 	close_notification();
@@ -1523,6 +1572,18 @@ static void popup_callback(GObject *widget, guint button,
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
+	item = gtk_separator_menu_item_new();
+	gtk_widget_show(item);
+	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
+
+	item = gtk_image_menu_item_new_with_label(_("Browse Device..."));
+	g_signal_connect(item, "activate",
+			 G_CALLBACK(browse_device_callback), NULL);
+	gtk_widget_show(item);
+	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
+
+	gtk_widget_set_sensitive (item, obexftp_available() && attached_adapters() > 0);
+
 #if 0
 	item = gtk_separator_menu_item_new();
 	gtk_widget_show(item);
-- 
1.5.2.2


--=-/5bkms0+Hj7mgRJKYv8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-/5bkms0+Hj7mgRJKYv8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-/5bkms0+Hj7mgRJKYv8z--
