Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Wlix6RXuTS/AM+9mm127"
Date: Mon, 26 Feb 2007 14:37:07 +0000
Message-Id: <1172500627.4742.10.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] More bluez-gnome patches
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


--=-Wlix6RXuTS/AM+9mm127
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

It's i18n this time. More UI fixes to get decent translatable strings
for translators (they don't like markup and extraneous linefeeds in the
translations, and even less sentences created by concatenating 2 bits of
a sentence).

I removed linefeeds from g_printerr, as they should already be added by
the glib code. I also added the properties dialogue to be translated.

Cheers

--=-Wlix6RXuTS/AM+9mm127
Content-Disposition: attachment; filename=bluez-gnome-i18n-fixes.patch
Content-Type: text/x-patch; name=bluez-gnome-i18n-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.55
diff -u -p -r1.55 main.c
--- applet/main.c	25 Feb 2007 18:44:17 -0000	1.55
+++ applet/main.c	26 Feb 2007 14:35:41 -0000
@@ -231,7 +231,9 @@ static void passkey_dialog(const char *p
 	GtkWidget *label;
 	GtkWidget *entry;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	struct input_data *input;
+	gchar *text;
 
 	input = g_try_malloc0(sizeof(*input));
 	if (!input)
@@ -289,14 +291,22 @@ static void passkey_dialog(const char *p
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
+	text = g_strdup_printf ("<b>%s</b>", device);
+	gtk_label_set_markup(GTK_LABEL(label), text);
+	g_free(text);
 
 	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
 
@@ -306,14 +316,17 @@ static void passkey_dialog(const char *p
 
 	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 1, 2,
-			GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 0, 4);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
 
-	label = gtk_label_new(_("\nEnter passkey for authentication:"));
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Enter passkey for authentication:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 2, 3,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	entry = gtk_entry_new();
@@ -329,16 +342,14 @@ static void passkey_dialog(const char *p
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
 
@@ -357,6 +368,7 @@ static void confirm_dialog(const char *p
 	GtkWidget *image;
 	GtkWidget *label;
 	GtkWidget *table;
+	GtkWidget *vbox;
 	gchar *markup;
 	struct input_data *input;
 
@@ -393,9 +405,9 @@ static void confirm_dialog(const char *p
 	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
 					GTK_STOCK_YES, GTK_RESPONSE_YES);
 
-	table = gtk_table_new(4, 2, FALSE);
+	table = gtk_table_new(2, 2, FALSE);
 
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_row_spacings(GTK_TABLE(table), 16);
 	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
 
 	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
@@ -410,11 +422,14 @@ static void confirm_dialog(const char *p
 	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
 						GTK_SHRINK, GTK_FILL, 0, 0);
 
+	vbox = gtk_vbox_new (FALSE, 6);
 	label = gtk_label_new(_("Pairing request for device:"));
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 0, 1,
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
 				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
 
 	label = gtk_label_new(device);
@@ -427,14 +442,17 @@ static void confirm_dialog(const char *p
 
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
@@ -447,8 +465,7 @@ static void confirm_dialog(const char *p
 
 	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
 
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 3, 4,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+	gtk_container_add(GTK_CONTAINER(vbox), label);
 
 	input_list = g_list_append(input_list, input);
 
@@ -467,7 +484,7 @@ static void auth_dialog(const char *path
 	GtkWidget *image;
 	GtkWidget *label;
 	GtkWidget *table;
-	gchar *markup;
+	gchar *markup, *text;
 	struct input_data *input;
 
 	input = g_try_malloc0(sizeof(*input));
@@ -544,8 +561,11 @@ static void auth_dialog(const char *path
 
 	label = gtk_label_new(NULL);
 
-	markup = g_strdup_printf("\n<b>%s %s?</b>\n",
-					_("Grant access to"), profile);
+	/* translators: Whether to grant access to a particular service
+	 * to the device mentioned */
+	text = g_strdup_printf (_("Grant access to %s?"), profile);
+	markup = g_strdup_printf("<b>%s</b>\n", text);
+	g_free (text);
 
 	gtk_label_set_markup(GTK_LABEL(label), markup);
 
@@ -696,7 +716,7 @@ static gboolean passkey_agent_request(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text;
+	gchar *device, *text, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -718,9 +738,11 @@ static gboolean passkey_agent_request(Pa
 
 	passkey_dialog(path, address, device, context);
 
-	text = g_strdup_printf(_("Pairing request for %s\n\n"
-			"Click to open passkey entry dialog"), device);
-
+	/* translators: this is a popup telling you a particular device
+	 * has asked for pairing */
+	line = g_strdup_printf (_("Pairing request for '%s'"), device);
+	text = g_strconcat (line, "\n\n", _("Click to open passkey entry dialog"), NULL);
+	g_free (line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -737,7 +759,7 @@ static gboolean passkey_agent_confirm(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text;
+	gchar *device, *text, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -759,9 +781,9 @@ static gboolean passkey_agent_confirm(Pa
 
 	confirm_dialog(path, address, value, device, context);
 
-	text = g_strdup_printf(_("Pairing request for %s\n\n"
-			"Click to open confirmation dialog"), device);
-
+	line = g_strdup_printf (_("Pairing request for '%s'"), device);
+	text = g_strconcat (line, "\n\n", _("Click to open confirmation dialog"), NULL);
+	g_free (line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -871,7 +893,7 @@ static gboolean auth_agent_authorize(Pas
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *profile, *text;
+	gchar *device, *profile, *text, *line;
 
 	if (auto_authorize == TRUE) {
 		dbus_g_method_return(context);
@@ -904,9 +926,9 @@ static gboolean auth_agent_authorize(Pas
 
 	auth_dialog(path, address, service, uuid, device, profile, context);
 
-	text = g_strdup_printf(_("Authorization request for %s\n\n"
-			"Click to open authorization dialog"), device);
-
+	line = g_strdup_printf(_("Authorization request for %s"), device);
+	text = g_strconcat(line, "\n\n", _("Click to open authorization dialog"), NULL);
+	g_free (line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
@@ -1412,7 +1434,7 @@ static void settings_callback(GObject *w
 	const char *command = "bluetooth-properties";
 
 	if (!g_spawn_command_line_async(command, NULL))
-		g_printerr(_("Couldn't execute command: %s\n"), command);
+		g_printerr("Couldn't execute command: %s", command);
 }
 
 static void activate_callback(GObject *widget, gpointer user_data)
@@ -1521,7 +1543,7 @@ int main(int argc, char *argv[])
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
-		g_printerr(_("Connecting to system bus failed: %s\n"),
+		g_printerr(_("Connecting to system bus failed: %s"),
 							error->message);
 		g_error_free(error);
 		exit(EXIT_FAILURE);
Index: po/POTFILES.in
===================================================================
RCS file: /cvsroot/bluez/gnome/po/POTFILES.in,v
retrieving revision 1.2
diff -u -p -r1.2 POTFILES.in
--- po/POTFILES.in	20 Aug 2006 01:40:44 -0000	1.2
+++ po/POTFILES.in	26 Feb 2007 14:35:41 -0000
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
+++ properties/main.c	26 Feb 2007 14:35:41 -0000
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
 

--=-Wlix6RXuTS/AM+9mm127
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-Wlix6RXuTS/AM+9mm127
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Wlix6RXuTS/AM+9mm127--
