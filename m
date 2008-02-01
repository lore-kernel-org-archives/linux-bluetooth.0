Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-aYI9EM/1dLdtj00VleE5"
Date: Fri, 01 Feb 2008 17:44:46 +0000
Message-Id: <1201887887.2389.346.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Split agents
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


--=-aYI9EM/1dLdtj00VleE5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

First draft patch to split the agents away from the main program. Seems
to work fine for me.

This is mostly moving functions around though.

Cheers

--=-aYI9EM/1dLdtj00VleE5
Content-Disposition: attachment; filename=bluez-gnome-split-agents.patch
Content-Type: text/x-patch; name=bluez-gnome-split-agents.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/Makefile.am,v
retrieving revision 1.21
diff -u -p -r1.21 Makefile.am
--- Makefile.am	28 Jul 2007 23:57:16 -0000	1.21
+++ Makefile.am	1 Feb 2008 17:40:38 -0000
@@ -1,7 +1,7 @@
 
 bin_PROGRAMS = bluetooth-applet
 
-bluetooth_applet_SOURCES = main.c
+bluetooth_applet_SOURCES = main.c main.h agents.c agents.h
 
 bluetooth_applet_LDADD = \
 		@NOTIFY_LIBS@ @GCONF_LIBS@ \
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.98
diff -u -p -r1.98 main.c
--- main.c	1 Feb 2008 15:54:58 -0000	1.98
+++ main.c	1 Feb 2008 17:40:38 -0000
@@ -47,16 +47,14 @@
 
 #include "bluetooth-instance.h"
 #include "bluetooth-device-selection.h"
+#include "agents.h"
+#include "main.h"
 
-static gboolean singleton = FALSE;
-
-#define PASSKEY_AGENT_PATH	"/org/bluez/passkey"
-#define AUTH_AGENT_PATH		"/org/bluez/auth"
+/* Shared variables */
+DBusGConnection *conn = NULL;
+GtkStatusIcon *statusicon = NULL;
 
-static int volatile registered_passkey	= 0;
-static int volatile registered_auth	= 0;
-
-static DBusGConnection *conn;
+static gboolean singleton = FALSE;
 
 #ifdef HAVE_HAL
 static gboolean use_hal = FALSE;
@@ -78,8 +76,6 @@ typedef enum {
 
 static int icon_policy = ICON_POLICY_PRESENT;
 
-static gboolean auto_authorize = FALSE;
-
 #define PREF_DIR		"/apps/bluetooth-manager"
 #define PREF_USE_HAL		PREF_DIR "/use_hal"
 #define PREF_ICON_POLICY	PREF_DIR "/icon_policy"
@@ -87,565 +83,16 @@ static gboolean auto_authorize = FALSE;
 
 static GConfClient* gconf;
 
-static GtkStatusIcon *statusicon = NULL;
-
 static GtkWidget *menuitem_browse = NULL;
 
-typedef enum {
-	AGENT_ERROR_REJECT
-} AgentError;
-
-#define AGENT_ERROR (agent_error_quark())
-
-#define AGENT_ERROR_TYPE (agent_error_get_type()) 
-
-static GQuark agent_error_quark(void)
-{
-	static GQuark quark = 0;
-	if (!quark)
-		quark = g_quark_from_static_string("agent");
-
-	return quark;
-}
-
-#define ENUM_ENTRY(NAME, DESC) { NAME, "" #NAME "", DESC }
-
-static GType agent_error_get_type(void)
-{
-	static GType etype = 0;
-	if (etype == 0) {
-		static const GEnumValue values[] = {
-			ENUM_ENTRY(AGENT_ERROR_REJECT, "Rejected"),
-			{ 0, 0, 0 }
-		};
-
-		etype = g_enum_register_static("agent", values);
-	}
-
-	return etype;
-}
-
-static GList *input_list = NULL;
-
-struct input_data {
-	char *path;
-	char *address;
-	char *service;
-	char *uuid;
-	DBusGMethodInvocation *context;
-	GtkWidget *dialog;
-	GtkWidget *button;
-	GtkWidget *entry;
-};
-
-static gint input_compare(gconstpointer a, gconstpointer b)
-{
-	struct input_data *a_data = (struct input_data *) a;
-	struct input_data *b_data = (struct input_data *) b;
-
-	return strcmp(a_data->address, b_data->address);
-}
-
-static void input_free(struct input_data *input)
-{
-	gtk_widget_destroy(input->dialog);
-
-	input_list = g_list_remove(input_list, input);
-
-	g_free(input->uuid);
-	g_free(input->service);
-	g_free(input->address);
-	g_free(input->path);
-	g_free(input);
-
-	if (g_list_length(input_list) == 0)
-		gtk_status_icon_set_blinking(statusicon, FALSE);
-}
-
-static void passkey_callback(GtkWidget *dialog,
-				gint response, gpointer user_data)
-{
-	struct input_data *input = user_data;
-
-	if (response == GTK_RESPONSE_ACCEPT) {
-		const char *passkey;
-		passkey = gtk_entry_get_text(GTK_ENTRY(input->entry));
-		dbus_g_method_return(input->context, passkey);
-	} else {
-		GError *error;
-		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
-						"Pairing request rejected");
-		dbus_g_method_return_error(input->context, error);
-	}
-
-	input_free(input);
-}
-
-static void confirm_callback(GtkWidget *dialog,
-				gint response, gpointer user_data)
-{
-	struct input_data *input = user_data;
-
-	if (response != GTK_RESPONSE_YES) {
-		GError *error;
-		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
-					"Confirmation request rejected");
-		dbus_g_method_return_error(input->context, error);
-	} else
-		dbus_g_method_return(input->context);
-
-	input_free(input);
-}
-
-static void set_trusted(struct input_data *input)
-{
-	DBusGProxy *object;
-	gboolean active;
-
-	active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(input->button));
-	if (active == FALSE)
-		return;
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-					input->path, "org.bluez.Adapter");
-
-	dbus_g_proxy_call(object, "SetTrusted", NULL,
-				G_TYPE_STRING, input->address, G_TYPE_INVALID,
-								G_TYPE_INVALID);
-}
-
-static void auth_callback(GtkWidget *dialog,
-				gint response, gpointer user_data)
-{
-	struct input_data *input = user_data;
-
-	if (response == GTK_RESPONSE_YES) {
-		set_trusted(input);
-		dbus_g_method_return(input->context);
-	} else {
-		GError *error;
-		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
-					"Authorization request rejected");
-		dbus_g_method_return_error(input->context, error);
-	}
-
-	input_free(input);
-}
-
-static void changed_callback(GtkWidget *editable, gpointer user_data)
-{
-	struct input_data *input = user_data;
-	const gchar *text;
-
-	text = gtk_entry_get_text(GTK_ENTRY(input->entry));
-
-	gtk_widget_set_sensitive(input->button, strlen(text) ? TRUE : FALSE);
-}
-
-static void toggled_callback(GtkWidget *button, gpointer user_data)
-{
-	struct input_data *input = user_data;
-	gboolean mode;
-
-	mode = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(button));
-
-	gtk_entry_set_visibility(GTK_ENTRY(input->entry), mode);
-}
-
-static void passkey_dialog(const char *path, const char *address,
-			const gchar *device, DBusGMethodInvocation *context)
-{
-	GtkWidget *dialog;
-	GtkWidget *button;
-	GtkWidget *image;
-	GtkWidget *label;
-	GtkWidget *entry;
-	GtkWidget *table;
-	GtkWidget *vbox;
-	struct input_data *input;
-	gchar *markup;
-
-	input = g_try_malloc0(sizeof(*input));
-	if (!input)
-		return;
-
-	input->path = g_strdup(path);
-	input->address = g_strdup(address);
-
-	input->context = context;
-
-	dialog = gtk_dialog_new();
-
-	gtk_window_set_title(GTK_WINDOW(dialog), _("Authentication request"));
-
-	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
-
-	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
-
-	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
-
-	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
-
-	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
-
-	input->dialog = dialog;
-
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-				GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT);
-
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-					GTK_STOCK_OK, GTK_RESPONSE_ACCEPT);
-
-	gtk_widget_grab_default(button);
-
-	gtk_widget_set_sensitive(button, FALSE);
-
-	input->button = button;
-
-	table = gtk_table_new(5, 2, FALSE);
-
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
-	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
-
-	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
-
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
-
-	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
-							GTK_ICON_SIZE_DIALOG);
-
-	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
-
-	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
-						GTK_SHRINK, GTK_FILL, 0, 0);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-
-	label = gtk_label_new(_("Pairing request for device:"));
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	label = gtk_label_new(NULL);
-
-	markup = g_strdup_printf("<b>%s</b>", device);
-	gtk_label_set_markup(GTK_LABEL(label), markup);
-	g_free(markup);
-
-	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
-
-	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-
-	label = gtk_label_new(_("Enter passkey for authentication:"));
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	entry = gtk_entry_new();
-
-	gtk_entry_set_max_length(GTK_ENTRY(entry), 16);
-
-	gtk_entry_set_activates_default(GTK_ENTRY(entry), TRUE);
-
-	gtk_entry_set_visibility(GTK_ENTRY(entry), FALSE);
-
-	input->entry = entry;
-
-	g_signal_connect(G_OBJECT(entry), "changed",
-				G_CALLBACK(changed_callback), input);
-
-	gtk_container_add(GTK_CONTAINER(vbox), entry);
-
-	button = gtk_check_button_new_with_label(_("Show input"));
-
-	g_signal_connect(G_OBJECT(button), "toggled",
-				G_CALLBACK(toggled_callback), input);
-
-	gtk_container_add(GTK_CONTAINER(vbox), button);
-
-	input_list = g_list_append(input_list, input);
-
-	g_signal_connect(G_OBJECT(dialog), "response",
-				G_CALLBACK(passkey_callback), input);
-
-	gtk_status_icon_set_blinking(statusicon, TRUE);
-}
-
-static void confirm_dialog(const char *path, const char *address,
-				const char *value, const gchar *device,
-					DBusGMethodInvocation *context)
-{
-	GtkWidget *dialog;
-	GtkWidget *button;
-	GtkWidget *image;
-	GtkWidget *label;
-	GtkWidget *table;
-	GtkWidget *vbox;
-	gchar *markup;
-	struct input_data *input;
-
-	input = g_try_malloc0(sizeof(*input));
-	if (!input)
-		return;
-
-	input->path = g_strdup(path);
-	input->address = g_strdup(address);
-
-	input->context = context;
-
-	dialog = gtk_dialog_new();
-
-	gtk_window_set_title(GTK_WINDOW(dialog), _("Confirmation request"));
-
-	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
-
-	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
-
-	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
-
-	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
-
-	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
-
-	input->dialog = dialog;
-
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-					GTK_STOCK_NO, GTK_RESPONSE_NO);
- 
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-					GTK_STOCK_YES, GTK_RESPONSE_YES);
-
-	table = gtk_table_new(5, 2, FALSE);
-
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
-	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
-
-	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
-
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
-
-	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
-							GTK_ICON_SIZE_DIALOG);
-
-	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
-
-	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
-						GTK_SHRINK, GTK_FILL, 0, 0);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-	label = gtk_label_new(_("Pairing request for device:"));
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	label = gtk_label_new(NULL);
-
-	markup = g_strdup_printf("<b>%s</b>", device);
-	gtk_label_set_markup(GTK_LABEL(label), markup);
-	g_free(markup);
-
-	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
-
-	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-
-	label = gtk_label_new(_("Confirm value for authentication:"));
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	label = gtk_label_new(NULL);
-
-	markup = g_strdup_printf("<b>%s</b>\n", value);
-
-	gtk_label_set_markup(GTK_LABEL(label), markup);
-
-	g_free(markup);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	input_list = g_list_append(input_list, input);
-
-	g_signal_connect(G_OBJECT(dialog), "response",
-				G_CALLBACK(confirm_callback), input);
-
-	gtk_status_icon_set_blinking(statusicon, TRUE);
-}
-
-static void auth_dialog(const char *path, const char *address,
-		const char *service, const char *uuid, const gchar *device,
-		const gchar *profile, DBusGMethodInvocation *context)
-{
-	GtkWidget *dialog;
-	GtkWidget *button;
-	GtkWidget *image;
-	GtkWidget *label;
-	GtkWidget *table;
-	GtkWidget *vbox;
-	gchar *markup, *text;
-	struct input_data *input;
-
-	input = g_try_malloc0(sizeof(*input));
-	if (!input)
-		return;
-
-	input->path = g_strdup(path);
-	input->address = g_strdup(address);
-	input->service = g_strdup(service);
-	input->uuid = g_strdup(uuid);
-
-	input->context = context;
-
-	dialog = gtk_dialog_new();
-
-	gtk_window_set_title(GTK_WINDOW(dialog), _("Authorization request"));
-
-	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
-
-	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
-
-	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
-
-	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
-
-	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
-
-	input->dialog = dialog;
-
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-					GTK_STOCK_NO, GTK_RESPONSE_NO);
- 
-	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
-					GTK_STOCK_YES, GTK_RESPONSE_YES);
-
-	table = gtk_table_new(5, 2, FALSE);
-
-	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
-	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
-
-	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
-
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
-
-	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
-							GTK_ICON_SIZE_DIALOG);
-
-	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
-
-	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
-						GTK_SHRINK, GTK_FILL, 0, 0);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-
-	label = gtk_label_new(_("Authorization request for device:"));
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 0, 1,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	label = gtk_label_new(NULL);
-
-	markup = g_strdup_printf("<b>%s</b>", device);
-	gtk_label_set_markup(GTK_LABEL(label), markup);
-	g_free(markup);
-
-	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
-
-	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
-				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
-
-	label = gtk_label_new(NULL);
-
-	/* translators: Whether to grant access to a particular service
-	 * to the device mentioned */
-	markup = g_strdup_printf("<i>%s</i>", profile);
-	text = g_strdup_printf(_("Grant access to %s?"), markup);
-	g_free(markup);
-
-	markup = g_strdup_printf("%s\n", text);
-	gtk_label_set_markup(GTK_LABEL(label), markup);
-	g_free(markup);
-
-	g_free(text);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-
-	gtk_container_add(GTK_CONTAINER(vbox), label);
-
-	button = gtk_check_button_new_with_label(_("Always grant access"));
-
-	input->button = button;
-
-	gtk_container_add(GTK_CONTAINER(vbox), button);
-
-	input_list = g_list_append(input_list, input);
-
-	g_signal_connect(G_OBJECT(dialog), "response",
-				G_CALLBACK(auth_callback), input);
-
-	gtk_status_icon_set_blinking(statusicon, TRUE);
-}
-
-static void show_dialog(gpointer data, gpointer user_data)
-{
-	struct input_data *input = data;
-
-	gtk_widget_show_all(input->dialog);
-
-	gtk_window_present(GTK_WINDOW(input->dialog));
-}
-
 static NotifyNotification *notify = NULL;
 
 static void notify_action(NotifyNotification *notify,
 					gchar *action, gpointer user_data)
 {
 }
-
-static void show_notification(const gchar *summary, const gchar *message,
-			      const gchar *action, gint timeout, GCallback handler)
+void show_notification(const gchar *summary, const gchar *message,
+		       const gchar *action, gint timeout, GCallback handler)
 {
 	NotifyActionCallback callback;
 	GdkScreen *screen;
@@ -683,7 +130,7 @@ static void show_notification(const gcha
 	notify_notification_show(notify, NULL);
 }
 
-static void close_notification(void)
+void close_notification(void)
 {
 	if (notify) {
 		g_signal_handlers_destroy(notify);
@@ -692,378 +139,6 @@ static void close_notification(void)
 	}
 }
 
-typedef struct {
-	GObject parent;
-} PasskeyAgent;
-
-typedef struct {
-	GObjectClass parent;
-} PasskeyAgentClass;
-
-static GObjectClass *passkey_agent_parent;
-
-G_DEFINE_TYPE(PasskeyAgent, passkey_agent, G_TYPE_OBJECT)
-
-#define PASSKEY_AGENT_OBJECT_TYPE (passkey_agent_get_type())
-
-#define PASSKEY_AGENT(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
-				PASSKEY_AGENT_OBJECT_TYPE, PasskeyAgent))
-
-static void passkey_agent_finalize(GObject *obj)
-{
-	passkey_agent_parent->finalize(obj);
-}
-
-static void passkey_agent_init(PasskeyAgent *obj)
-{
-}
-
-static void passkey_agent_class_init(PasskeyAgentClass *klass)
-{
-	GObjectClass *gobject_class;
-
-	passkey_agent_parent = g_type_class_peek_parent(klass);
-
-	gobject_class = G_OBJECT_CLASS(klass);
-	gobject_class->finalize = passkey_agent_finalize;
-}
-
-static PasskeyAgent *passkey_agent_new(const char *path)
-{
-	PasskeyAgent *agent;
-
-	agent = g_object_new(PASSKEY_AGENT_OBJECT_TYPE, NULL);
-
-	dbus_g_connection_register_g_object(conn, path, G_OBJECT(agent));
-
-	return agent;
-}
-
-static void notification_closed(GObject *object, gpointer user_data)
-{
-	g_list_foreach(input_list, show_dialog, NULL);
-
-	gtk_status_icon_set_blinking(statusicon, FALSE);
-}
-
-static gboolean passkey_agent_request(PasskeyAgent *agent,
-				const char *path, const char *address,
-					DBusGMethodInvocation *context)
-{
-	DBusGProxy *object;
-	const char *adapter = NULL, *name = NULL;
-	gchar *device, *line;
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-						path, "org.bluez.Adapter");
-
-	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
-
-	dbus_g_proxy_call(object, "GetRemoteName", NULL,
-				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_STRING, &name, G_TYPE_INVALID);
-
-	if (name) {
-		if (g_strrstr(name, address))
-			device = g_strdup(name);
-		else
-			device = g_strdup_printf("%s (%s)", name, address);
-	} else
-		device = g_strdup(address);
-
-	passkey_dialog(path, address, device, context);
-
-	/* translators: this is a popup telling you a particular device
-	 * has asked for pairing */
-	line = g_strdup_printf(_("Pairing request for '%s'"), device);
-	g_free(device);
-
-	show_notification(adapter ? adapter : _("Bluetooth device"),
-					line, _("Enter passkey"), 0,
-					G_CALLBACK(notification_closed));
-
-	g_free(line);
-
-	return TRUE;
-}
-
-static gboolean passkey_agent_confirm(PasskeyAgent *agent,
-			const char *path, const char *address,
-			const char *value, DBusGMethodInvocation *context)
-{
-	DBusGProxy *object;
-	const char *adapter = NULL, *name = NULL;
-	gchar *device, *line;
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-						path, "org.bluez.Adapter");
-
-	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
-
-	dbus_g_proxy_call(object, "GetRemoteName", NULL,
-				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_STRING, &name, G_TYPE_INVALID);
-
-	if (name) {
-		if (g_strrstr(name, address))
-			device = g_strdup(name);
-		else
-			device = g_strdup_printf("%s (%s)", name, address);
-	} else
-		device = g_strdup(address);
-
-	confirm_dialog(path, address, value, device, context);
-
-	line = g_strdup_printf(_("Pairing request for '%s'"), device);
-	g_free(device);
-
-	show_notification(adapter ? adapter : _("Bluetooth device"),
-					line, _("Confirm pairing"), 0,
-					G_CALLBACK(notification_closed));
-
-	g_free (line);
-
-	return TRUE;
-}
-
-static gboolean passkey_agent_cancel(PasskeyAgent *agent,
-			const char *path, const char *address, GError **error)
-{
-	GList *list;
-	GError *result;
-	struct input_data *input;
-
-	input = g_try_malloc0(sizeof(*input));
-	if (!input)
-		return FALSE;
-
-	input->path = g_strdup(path);
-	input->address = g_strdup(address);
-
-	list = g_list_find_custom(input_list, input, input_compare);
-
-	g_free(input->address);
-	g_free(input->path);
-	g_free(input);
-
-	if (!list || !list->data)
-		return FALSE;
-
-	input = list->data;
-
-	close_notification();
-
-	result = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
-						"Agent callback canceled");
-
-	dbus_g_method_return_error(input->context, result);
-
-	input_free(input);
-
-	return TRUE;
-}
-
-static gboolean passkey_agent_release(PasskeyAgent *agent, GError **error)
-{
-	registered_passkey = 0;
-
-	return TRUE;
-}
-
-#include "passkey-agent-glue.h"
-
-typedef struct {
-	GObject parent;
-} AuthAgent;
-
-typedef struct {
-	GObjectClass parent;
-} AuthAgentClass;
-
-static GObjectClass *auth_agent_parent;
-
-G_DEFINE_TYPE(AuthAgent, auth_agent, G_TYPE_OBJECT)
-
-#define AUTH_AGENT_OBJECT_TYPE (auth_agent_get_type())
-
-#define AUTH_AGENT(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
-				AUTH_AGENT_OBJECT_TYPE, AuthAgent))
-
-static void auth_agent_finalize(GObject *obj)
-{
-	auth_agent_parent->finalize(obj);
-}
-
-static void auth_agent_init(AuthAgent *obj)
-{
-}
-
-static void auth_agent_class_init(AuthAgentClass *klass)
-{
-	GObjectClass *gobject_class;
-
-	auth_agent_parent = g_type_class_peek_parent(klass);
-
-	gobject_class = G_OBJECT_CLASS(klass);
-	gobject_class->finalize = auth_agent_finalize;
-}
-
-static AuthAgent *auth_agent_new(const char *path)
-{
-	AuthAgent *agent;
-
-	agent = g_object_new(AUTH_AGENT_OBJECT_TYPE, NULL);
-
-	dbus_g_connection_register_g_object(conn, path, G_OBJECT(agent));
-
-	return agent;
-}
-
-static gboolean auth_agent_authorize(PasskeyAgent *agent,
-		const char *path, const char *address, const char *service,
-			const char *uuid, DBusGMethodInvocation *context)
-{
-	DBusGProxy *object;
-	const char *adapter = NULL, *name = NULL;
-	gchar *device, *profile, *line;
-
-	if (auto_authorize == TRUE) {
-		dbus_g_method_return(context);
-		return TRUE;
-	}
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-						path, "org.bluez.Adapter");
-
-	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
-
-	dbus_g_proxy_call(object, "GetRemoteName", NULL,
-				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_STRING, &name, G_TYPE_INVALID);
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-						service, "org.bluez.Service");
-
-	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &profile, G_TYPE_INVALID);
-
-	if (name) {
-		if (g_strrstr(name, address))
-			device = g_strdup(name);
-		else
-			device = g_strdup_printf("%s (%s)", name, address);
-	} else
-		device = g_strdup(address);
-
-	auth_dialog(path, address, service, uuid, device, profile, context);
-
-	line = g_strdup_printf(_("Authorization request for %s"), device);
-	g_free(device);
-
-	show_notification(adapter ? adapter : _("Bluetooth device"),
-					line, _("Check authorization"), 0,
-					G_CALLBACK(notification_closed));
-
-	g_free(line);
-
-	return TRUE;
-}
-
-static gboolean auth_agent_cancel(PasskeyAgent *agent,
-		const char *path, const char *address, const char *service,
-			const char *uuid, DBusGMethodInvocation *context)
-{
-	GList *list;
-	GError *result;
-	struct input_data *input;
-
-	input = g_try_malloc0(sizeof(*input));
-	if (!input)
-		return FALSE;
-
-	input->path = g_strdup(path);
-	input->address = g_strdup(address);
-	input->service = g_strdup(service);
-	input->uuid = g_strdup(uuid);
-
-	list = g_list_find_custom(input_list, input, input_compare);
-
-	g_free(input->uuid);
-	g_free(input->service);
-	g_free(input->address);
-	g_free(input->path);
-	g_free(input);
-
-	if (!list || !list->data)
-		return FALSE;
-
-	input = list->data;
-
-	close_notification();
-
-	result = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
-						"Agent callback canceled");
-
-	dbus_g_method_return_error(input->context, result);
-
-	input_free(input);
-
-	return TRUE;
-}
-
-static gboolean auth_agent_release(PasskeyAgent *agent, GError **error)
-{
-	registered_auth = 0;
-
-	return TRUE;
-}
-
-#include "auth-agent-glue.h"
-
-static int register_agents(void)
-{
-	DBusGProxy *object;
-	GError *error = NULL;
-
-	if (registered_passkey && registered_auth)
-		return 0;
-
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
-					"/org/bluez", "org.bluez.Security");
-
-	if (!registered_passkey) {
-
-		dbus_g_proxy_call(object, "RegisterDefaultPasskeyAgent",
-				&error, G_TYPE_STRING, PASSKEY_AGENT_PATH,
-					G_TYPE_INVALID, G_TYPE_INVALID);
-
-		if (error != NULL) {
-			g_error_free(error);
-			return -1;
-		}
-
-		registered_passkey = 1;
-	}
-
-	if (!registered_auth) {
-		dbus_g_proxy_call(object, "RegisterDefaultAuthorizationAgent",
-				&error,	G_TYPE_STRING, AUTH_AGENT_PATH,
-					G_TYPE_INVALID, G_TYPE_INVALID);
-
-		if (error != NULL) {
-			g_error_free(error);
-			return -1;
-		}
-
-		registered_auth = 1;
-	}
-
-	return 0;
-}
-
 static void bonding_created(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
@@ -1436,8 +511,7 @@ static void name_owner_changed(DBusGProx
 			const char *prev, const char *new, gpointer user_data)
 {
 	if (!strcmp(name, "org.bluez") && *new == '\0') {
-		registered_passkey = 0;
-		registered_auth = 0;
+		unregister_agents();
 
 		g_list_foreach(adapter_list, adapter_disable, NULL);
 
@@ -1462,7 +536,6 @@ static gboolean obexftp_available(void)
 static int setup_dbus(void)
 {
 	DBusGProxy *object;
-	void *agent;
 
 	object = dbus_g_proxy_new_for_name(conn, DBUS_SERVICE_DBUS,
 					DBUS_PATH_DBUS, DBUS_INTERFACE_DBUS);
@@ -1473,18 +546,7 @@ static int setup_dbus(void)
 	dbus_g_proxy_connect_signal(object, "NameOwnerChanged",
 				G_CALLBACK(name_owner_changed), NULL, NULL);
 
-	dbus_g_object_type_install_info(PASSKEY_AGENT_OBJECT_TYPE,
-					&dbus_glib_passkey_agent_object_info);
-
-	dbus_g_object_type_install_info(AUTH_AGENT_OBJECT_TYPE,
-					&dbus_glib_auth_agent_object_info);
-
-	dbus_g_error_domain_register(AGENT_ERROR, "org.bluez.Error",
-							AGENT_ERROR_TYPE);
-
-	agent = passkey_agent_new(PASSKEY_AGENT_PATH);
-
-	agent = auth_agent_new(AUTH_AGENT_PATH);
+	setup_agent_dbus();
 
 	return 0;
 }
@@ -1655,11 +717,7 @@ static void wizard_callback(GObject *wid
 
 static void activate_callback(GObject *widget, gpointer user_data)
 {
-	close_notification();
-
-	g_list_foreach(input_list, show_dialog, NULL);
-
-	gtk_status_icon_set_blinking(statusicon, FALSE);
+	flush_input();
 }
 
 static void popup_callback(GObject *widget, guint button,
@@ -1784,7 +842,7 @@ static void gconf_callback(GConfClient *
 	}
 
 	if (strcmp(entry->key, PREF_AUTO_AUTHORIZE) == 0)
-		auto_authorize = gconf_value_get_bool(value);
+		set_auto_authorize (gconf_value_get_bool(value));
 }
 
 static GOptionEntry options[] = {
@@ -1843,8 +901,8 @@ int main(int argc, char *argv[])
 		g_free(str);
 	}
 
-	auto_authorize = gconf_client_get_bool(gconf,
-					PREF_AUTO_AUTHORIZE, NULL);
+	set_auto_authorize (gconf_client_get_bool(gconf,
+						  PREF_AUTO_AUTHORIZE, NULL));
 
 	gconf_client_add_dir(gconf, PREF_DIR, GCONF_CLIENT_PRELOAD_NONE, NULL);
 
@@ -1872,17 +930,13 @@ int main(int argc, char *argv[])
 
 	register_agents();
 
-	//passkey_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "Test", NULL);
-	//confirm_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "123456", "Test", NULL);
-	//auth_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "/org/bluez/echo", "", "Test", "Echo service", NULL);
-
 	gtk_main();
 
 	gtk_widget_destroy(menu);
 
 	g_object_unref(gconf);
 
-	close_notification();
+	flush_input();
 
 	g_list_foreach(adapter_list, adapter_free, NULL);
 
--- /dev/null	2008-01-24 17:45:36.352009045 +0000
+++ main.h	2008-02-01 17:33:58.000000000 +0000
@@ -0,0 +1,4 @@
+void show_notification(const gchar *summary, const gchar *message,
+		       const gchar *action, gint timeout, GCallback handler);
+void close_notification(void);
+
--- /dev/null	2008-01-24 17:45:36.352009045 +0000
+++ agents.c	2008-02-01 17:40:23.000000000 +0000
@@ -0,0 +1,1013 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007  Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <dbus/dbus-glib.h>
+
+#include <glib/gi18n.h>
+
+#include <gtk/gtk.h>
+
+#include "agents.h"
+#include "main.h"
+
+extern GtkStatusIcon *statusicon;
+extern DBusGConnection *conn;
+
+#define PASSKEY_AGENT_PATH	"/org/bluez/passkey"
+#define AUTH_AGENT_PATH		"/org/bluez/auth"
+
+static int volatile registered_passkey	= 0;
+static int volatile registered_auth	= 0;
+
+static gboolean auto_authorize = FALSE;
+
+typedef enum {
+	AGENT_ERROR_REJECT
+} AgentError;
+
+#define AGENT_ERROR (agent_error_quark())
+
+#define AGENT_ERROR_TYPE (agent_error_get_type()) 
+
+static GQuark agent_error_quark(void)
+{
+	static GQuark quark = 0;
+	if (!quark)
+		quark = g_quark_from_static_string("agent");
+
+	return quark;
+}
+
+#define ENUM_ENTRY(NAME, DESC) { NAME, "" #NAME "", DESC }
+
+static GType agent_error_get_type(void)
+{
+	static GType etype = 0;
+	if (etype == 0) {
+		static const GEnumValue values[] = {
+			ENUM_ENTRY(AGENT_ERROR_REJECT, "Rejected"),
+			{ 0, 0, 0 }
+		};
+
+		etype = g_enum_register_static("agent", values);
+	}
+
+	return etype;
+}
+
+static GList *input_list = NULL;
+
+struct input_data {
+	char *path;
+	char *address;
+	char *service;
+	char *uuid;
+	DBusGMethodInvocation *context;
+	GtkWidget *dialog;
+	GtkWidget *button;
+	GtkWidget *entry;
+};
+
+static gint input_compare(gconstpointer a, gconstpointer b)
+{
+	struct input_data *a_data = (struct input_data *) a;
+	struct input_data *b_data = (struct input_data *) b;
+
+	return strcmp(a_data->address, b_data->address);
+}
+
+static void input_free(struct input_data *input)
+{
+	gtk_widget_destroy(input->dialog);
+
+	input_list = g_list_remove(input_list, input);
+
+	g_free(input->uuid);
+	g_free(input->service);
+	g_free(input->address);
+	g_free(input->path);
+	g_free(input);
+
+	if (g_list_length(input_list) == 0)
+		gtk_status_icon_set_blinking(statusicon, FALSE);
+}
+
+static void passkey_callback(GtkWidget *dialog,
+				gint response, gpointer user_data)
+{
+	struct input_data *input = user_data;
+
+	if (response == GTK_RESPONSE_ACCEPT) {
+		const char *passkey;
+		passkey = gtk_entry_get_text(GTK_ENTRY(input->entry));
+		dbus_g_method_return(input->context, passkey);
+	} else {
+		GError *error;
+		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
+						"Pairing request rejected");
+		dbus_g_method_return_error(input->context, error);
+	}
+
+	input_free(input);
+}
+
+static void confirm_callback(GtkWidget *dialog,
+				gint response, gpointer user_data)
+{
+	struct input_data *input = user_data;
+
+	if (response != GTK_RESPONSE_YES) {
+		GError *error;
+		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
+					"Confirmation request rejected");
+		dbus_g_method_return_error(input->context, error);
+	} else
+		dbus_g_method_return(input->context);
+
+	input_free(input);
+}
+
+static void set_trusted(struct input_data *input)
+{
+	DBusGProxy *object;
+	gboolean active;
+
+	active = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(input->button));
+	if (active == FALSE)
+		return;
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+					input->path, "org.bluez.Adapter");
+
+	dbus_g_proxy_call(object, "SetTrusted", NULL,
+				G_TYPE_STRING, input->address, G_TYPE_INVALID,
+								G_TYPE_INVALID);
+}
+
+static void auth_callback(GtkWidget *dialog,
+				gint response, gpointer user_data)
+{
+	struct input_data *input = user_data;
+
+	if (response == GTK_RESPONSE_YES) {
+		set_trusted(input);
+		dbus_g_method_return(input->context);
+	} else {
+		GError *error;
+		error = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
+					"Authorization request rejected");
+		dbus_g_method_return_error(input->context, error);
+	}
+
+	input_free(input);
+}
+
+static void changed_callback(GtkWidget *editable, gpointer user_data)
+{
+	struct input_data *input = user_data;
+	const gchar *text;
+
+	text = gtk_entry_get_text(GTK_ENTRY(input->entry));
+
+	gtk_widget_set_sensitive(input->button, strlen(text) ? TRUE : FALSE);
+}
+
+static void toggled_callback(GtkWidget *button, gpointer user_data)
+{
+	struct input_data *input = user_data;
+	gboolean mode;
+
+	mode = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(button));
+
+	gtk_entry_set_visibility(GTK_ENTRY(input->entry), mode);
+}
+
+static void passkey_dialog(const char *path, const char *address,
+			const gchar *device, DBusGMethodInvocation *context)
+{
+	GtkWidget *dialog;
+	GtkWidget *button;
+	GtkWidget *image;
+	GtkWidget *label;
+	GtkWidget *entry;
+	GtkWidget *table;
+	GtkWidget *vbox;
+	struct input_data *input;
+	gchar *markup;
+
+	input = g_try_malloc0(sizeof(*input));
+	if (!input)
+		return;
+
+	input->path = g_strdup(path);
+	input->address = g_strdup(address);
+
+	input->context = context;
+
+	dialog = gtk_dialog_new();
+
+	gtk_window_set_title(GTK_WINDOW(dialog), _("Authentication request"));
+
+	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
+
+	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
+
+	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
+
+	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
+
+	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
+
+	input->dialog = dialog;
+
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+				GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT);
+
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+					GTK_STOCK_OK, GTK_RESPONSE_ACCEPT);
+
+	gtk_widget_grab_default(button);
+
+	gtk_widget_set_sensitive(button, FALSE);
+
+	input->button = button;
+
+	table = gtk_table_new(5, 2, FALSE);
+
+	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
+
+	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
+
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
+
+	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
+							GTK_ICON_SIZE_DIALOG);
+
+	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
+
+	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
+						GTK_SHRINK, GTK_FILL, 0, 0);
+
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Pairing request for device:"));
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	label = gtk_label_new(NULL);
+
+	markup = g_strdup_printf("<b>%s</b>", device);
+	gtk_label_set_markup(GTK_LABEL(label), markup);
+	g_free(markup);
+
+	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
+
+	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Enter passkey for authentication:"));
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	entry = gtk_entry_new();
+
+	gtk_entry_set_max_length(GTK_ENTRY(entry), 16);
+
+	gtk_entry_set_activates_default(GTK_ENTRY(entry), TRUE);
+
+	gtk_entry_set_visibility(GTK_ENTRY(entry), FALSE);
+
+	input->entry = entry;
+
+	g_signal_connect(G_OBJECT(entry), "changed",
+				G_CALLBACK(changed_callback), input);
+
+	gtk_container_add(GTK_CONTAINER(vbox), entry);
+
+	button = gtk_check_button_new_with_label(_("Show input"));
+
+	g_signal_connect(G_OBJECT(button), "toggled",
+				G_CALLBACK(toggled_callback), input);
+
+	gtk_container_add(GTK_CONTAINER(vbox), button);
+
+	input_list = g_list_append(input_list, input);
+
+	g_signal_connect(G_OBJECT(dialog), "response",
+				G_CALLBACK(passkey_callback), input);
+
+	gtk_status_icon_set_blinking(statusicon, TRUE);
+}
+
+static void confirm_dialog(const char *path, const char *address,
+				const char *value, const gchar *device,
+					DBusGMethodInvocation *context)
+{
+	GtkWidget *dialog;
+	GtkWidget *button;
+	GtkWidget *image;
+	GtkWidget *label;
+	GtkWidget *table;
+	GtkWidget *vbox;
+	gchar *markup;
+	struct input_data *input;
+
+	input = g_try_malloc0(sizeof(*input));
+	if (!input)
+		return;
+
+	input->path = g_strdup(path);
+	input->address = g_strdup(address);
+
+	input->context = context;
+
+	dialog = gtk_dialog_new();
+
+	gtk_window_set_title(GTK_WINDOW(dialog), _("Confirmation request"));
+
+	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
+
+	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
+
+	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
+
+	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
+
+	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
+
+	input->dialog = dialog;
+
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+					GTK_STOCK_NO, GTK_RESPONSE_NO);
+ 
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+					GTK_STOCK_YES, GTK_RESPONSE_YES);
+
+	table = gtk_table_new(5, 2, FALSE);
+
+	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
+
+	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
+
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
+
+	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
+							GTK_ICON_SIZE_DIALOG);
+
+	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
+
+	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
+						GTK_SHRINK, GTK_FILL, 0, 0);
+
+	vbox = gtk_vbox_new(FALSE, 6);
+	label = gtk_label_new(_("Pairing request for device:"));
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 0, 1,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	label = gtk_label_new(NULL);
+
+	markup = g_strdup_printf("<b>%s</b>", device);
+	gtk_label_set_markup(GTK_LABEL(label), markup);
+	g_free(markup);
+
+	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
+
+	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Confirm value for authentication:"));
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	label = gtk_label_new(NULL);
+
+	markup = g_strdup_printf("<b>%s</b>\n", value);
+
+	gtk_label_set_markup(GTK_LABEL(label), markup);
+
+	g_free(markup);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	input_list = g_list_append(input_list, input);
+
+	g_signal_connect(G_OBJECT(dialog), "response",
+				G_CALLBACK(confirm_callback), input);
+
+	gtk_status_icon_set_blinking(statusicon, TRUE);
+}
+
+static void auth_dialog(const char *path, const char *address,
+		const char *service, const char *uuid, const gchar *device,
+		const gchar *profile, DBusGMethodInvocation *context)
+{
+	GtkWidget *dialog;
+	GtkWidget *button;
+	GtkWidget *image;
+	GtkWidget *label;
+	GtkWidget *table;
+	GtkWidget *vbox;
+	gchar *markup, *text;
+	struct input_data *input;
+
+	input = g_try_malloc0(sizeof(*input));
+	if (!input)
+		return;
+
+	input->path = g_strdup(path);
+	input->address = g_strdup(address);
+	input->service = g_strdup(service);
+	input->uuid = g_strdup(uuid);
+
+	input->context = context;
+
+	dialog = gtk_dialog_new();
+
+	gtk_window_set_title(GTK_WINDOW(dialog), _("Authorization request"));
+
+	gtk_window_set_resizable(GTK_WINDOW(dialog), FALSE);
+
+	gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
+
+	gtk_window_set_keep_above(GTK_WINDOW(dialog), TRUE);
+
+	gtk_window_set_urgency_hint(GTK_WINDOW(dialog), TRUE);
+
+	gtk_dialog_set_has_separator(GTK_DIALOG(dialog), FALSE);
+
+	input->dialog = dialog;
+
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+					GTK_STOCK_NO, GTK_RESPONSE_NO);
+ 
+	button = gtk_dialog_add_button(GTK_DIALOG(dialog),
+					GTK_STOCK_YES, GTK_RESPONSE_YES);
+
+	table = gtk_table_new(5, 2, FALSE);
+
+	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_col_spacings(GTK_TABLE(table), 20);
+
+	gtk_container_set_border_width(GTK_CONTAINER(table), 12);
+
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), table);
+
+	image = gtk_image_new_from_icon_name(GTK_STOCK_DIALOG_AUTHENTICATION,
+							GTK_ICON_SIZE_DIALOG);
+
+	gtk_misc_set_alignment(GTK_MISC(image), 0.0, 0.0);
+
+	gtk_table_attach(GTK_TABLE(table), image, 0, 1, 0, 5,
+						GTK_SHRINK, GTK_FILL, 0, 0);
+
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = gtk_label_new(_("Authorization request for device:"));
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_table_attach(GTK_TABLE(table), label, 1, 2, 0, 1,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	label = gtk_label_new(NULL);
+
+	markup = g_strdup_printf("<b>%s</b>", device);
+	gtk_label_set_markup(GTK_LABEL(label), markup);
+	g_free(markup);
+
+	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
+
+	gtk_label_set_selectable(GTK_LABEL(label), TRUE);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_widget_set_size_request(GTK_WIDGET(label), 280, -1);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	gtk_table_attach(GTK_TABLE(table), vbox, 1, 2, 2, 3,
+				GTK_EXPAND | GTK_FILL, GTK_SHRINK, 0, 0);
+
+	label = gtk_label_new(NULL);
+
+	/* translators: Whether to grant access to a particular service
+	 * to the device mentioned */
+	markup = g_strdup_printf("<i>%s</i>", profile);
+	text = g_strdup_printf(_("Grant access to %s?"), markup);
+	g_free(markup);
+
+	markup = g_strdup_printf("%s\n", text);
+	gtk_label_set_markup(GTK_LABEL(label), markup);
+	g_free(markup);
+
+	g_free(text);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
+
+	gtk_container_add(GTK_CONTAINER(vbox), label);
+
+	button = gtk_check_button_new_with_label(_("Always grant access"));
+
+	input->button = button;
+
+	gtk_container_add(GTK_CONTAINER(vbox), button);
+
+	input_list = g_list_append(input_list, input);
+
+	g_signal_connect(G_OBJECT(dialog), "response",
+				G_CALLBACK(auth_callback), input);
+
+	gtk_status_icon_set_blinking(statusicon, TRUE);
+}
+
+static void show_dialog(gpointer data, gpointer user_data)
+{
+	struct input_data *input = data;
+
+	gtk_widget_show_all(input->dialog);
+
+	gtk_window_present(GTK_WINDOW(input->dialog));
+}
+
+typedef struct {
+	GObject parent;
+} PasskeyAgent;
+
+typedef struct {
+	GObjectClass parent;
+} PasskeyAgentClass;
+
+static GObjectClass *passkey_agent_parent;
+
+G_DEFINE_TYPE(PasskeyAgent, passkey_agent, G_TYPE_OBJECT)
+
+#define PASSKEY_AGENT_OBJECT_TYPE (passkey_agent_get_type())
+
+#define PASSKEY_AGENT(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
+				PASSKEY_AGENT_OBJECT_TYPE, PasskeyAgent))
+
+static void passkey_agent_finalize(GObject *obj)
+{
+	passkey_agent_parent->finalize(obj);
+}
+
+static void passkey_agent_init(PasskeyAgent *obj)
+{
+}
+
+static void passkey_agent_class_init(PasskeyAgentClass *klass)
+{
+	GObjectClass *gobject_class;
+
+	passkey_agent_parent = g_type_class_peek_parent(klass);
+
+	gobject_class = G_OBJECT_CLASS(klass);
+	gobject_class->finalize = passkey_agent_finalize;
+}
+
+static PasskeyAgent *passkey_agent_new(const char *path)
+{
+	PasskeyAgent *agent;
+
+	agent = g_object_new(PASSKEY_AGENT_OBJECT_TYPE, NULL);
+
+	dbus_g_connection_register_g_object(conn, path, G_OBJECT(agent));
+
+	return agent;
+}
+
+static void notification_closed(GObject *object, gpointer user_data)
+{
+	g_list_foreach(input_list, show_dialog, NULL);
+
+	gtk_status_icon_set_blinking(statusicon, FALSE);
+}
+
+static gboolean passkey_agent_request(PasskeyAgent *agent,
+				const char *path, const char *address,
+					DBusGMethodInvocation *context)
+{
+	DBusGProxy *object;
+	const char *adapter = NULL, *name = NULL;
+	gchar *device, *line;
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+						path, "org.bluez.Adapter");
+
+	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
+
+	dbus_g_proxy_call(object, "GetRemoteName", NULL,
+				G_TYPE_STRING, address, G_TYPE_INVALID,
+				G_TYPE_STRING, &name, G_TYPE_INVALID);
+
+	if (name) {
+		if (g_strrstr(name, address))
+			device = g_strdup(name);
+		else
+			device = g_strdup_printf("%s (%s)", name, address);
+	} else
+		device = g_strdup(address);
+
+	passkey_dialog(path, address, device, context);
+
+	/* translators: this is a popup telling you a particular device
+	 * has asked for pairing */
+	line = g_strdup_printf(_("Pairing request for '%s'"), device);
+	g_free(device);
+
+	show_notification(adapter ? adapter : _("Bluetooth device"),
+					line, _("Enter passkey"), 0,
+					G_CALLBACK(notification_closed));
+
+	g_free(line);
+
+	return TRUE;
+}
+
+static gboolean passkey_agent_confirm(PasskeyAgent *agent,
+			const char *path, const char *address,
+			const char *value, DBusGMethodInvocation *context)
+{
+	DBusGProxy *object;
+	const char *adapter = NULL, *name = NULL;
+	gchar *device, *line;
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+						path, "org.bluez.Adapter");
+
+	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
+
+	dbus_g_proxy_call(object, "GetRemoteName", NULL,
+				G_TYPE_STRING, address, G_TYPE_INVALID,
+				G_TYPE_STRING, &name, G_TYPE_INVALID);
+
+	if (name) {
+		if (g_strrstr(name, address))
+			device = g_strdup(name);
+		else
+			device = g_strdup_printf("%s (%s)", name, address);
+	} else
+		device = g_strdup(address);
+
+	confirm_dialog(path, address, value, device, context);
+
+	line = g_strdup_printf(_("Pairing request for '%s'"), device);
+	g_free(device);
+
+	show_notification(adapter ? adapter : _("Bluetooth device"),
+					line, _("Confirm pairing"), 0,
+					G_CALLBACK(notification_closed));
+
+	g_free (line);
+
+	return TRUE;
+}
+
+static gboolean passkey_agent_cancel(PasskeyAgent *agent,
+			const char *path, const char *address, GError **error)
+{
+	GList *list;
+	GError *result;
+	struct input_data *input;
+
+	input = g_try_malloc0(sizeof(*input));
+	if (!input)
+		return FALSE;
+
+	input->path = g_strdup(path);
+	input->address = g_strdup(address);
+
+	list = g_list_find_custom(input_list, input, input_compare);
+
+	g_free(input->address);
+	g_free(input->path);
+	g_free(input);
+
+	if (!list || !list->data)
+		return FALSE;
+
+	input = list->data;
+
+	close_notification();
+
+	result = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
+						"Agent callback canceled");
+
+	dbus_g_method_return_error(input->context, result);
+
+	input_free(input);
+
+	return TRUE;
+}
+
+static gboolean passkey_agent_release(PasskeyAgent *agent, GError **error)
+{
+	registered_passkey = 0;
+
+	return TRUE;
+}
+
+#include "passkey-agent-glue.h"
+
+typedef struct {
+	GObject parent;
+} AuthAgent;
+
+typedef struct {
+	GObjectClass parent;
+} AuthAgentClass;
+
+static GObjectClass *auth_agent_parent;
+
+G_DEFINE_TYPE(AuthAgent, auth_agent, G_TYPE_OBJECT)
+
+#define AUTH_AGENT_OBJECT_TYPE (auth_agent_get_type())
+
+#define AUTH_AGENT(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
+				AUTH_AGENT_OBJECT_TYPE, AuthAgent))
+
+static void auth_agent_finalize(GObject *obj)
+{
+	auth_agent_parent->finalize(obj);
+}
+
+static void auth_agent_init(AuthAgent *obj)
+{
+}
+
+static void auth_agent_class_init(AuthAgentClass *klass)
+{
+	GObjectClass *gobject_class;
+
+	auth_agent_parent = g_type_class_peek_parent(klass);
+
+	gobject_class = G_OBJECT_CLASS(klass);
+	gobject_class->finalize = auth_agent_finalize;
+}
+
+static AuthAgent *auth_agent_new(const char *path)
+{
+	AuthAgent *agent;
+
+	agent = g_object_new(AUTH_AGENT_OBJECT_TYPE, NULL);
+
+	dbus_g_connection_register_g_object(conn, path, G_OBJECT(agent));
+
+	return agent;
+}
+
+static gboolean auth_agent_authorize(PasskeyAgent *agent,
+		const char *path, const char *address, const char *service,
+			const char *uuid, DBusGMethodInvocation *context)
+{
+	DBusGProxy *object;
+	const char *adapter = NULL, *name = NULL;
+	gchar *device, *profile, *line;
+
+	if (auto_authorize == TRUE) {
+		dbus_g_method_return(context);
+		return TRUE;
+	}
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+						path, "org.bluez.Adapter");
+
+	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
+
+	dbus_g_proxy_call(object, "GetRemoteName", NULL,
+				G_TYPE_STRING, address, G_TYPE_INVALID,
+				G_TYPE_STRING, &name, G_TYPE_INVALID);
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+						service, "org.bluez.Service");
+
+	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &profile, G_TYPE_INVALID);
+
+	if (name) {
+		if (g_strrstr(name, address))
+			device = g_strdup(name);
+		else
+			device = g_strdup_printf("%s (%s)", name, address);
+	} else
+		device = g_strdup(address);
+
+	auth_dialog(path, address, service, uuid, device, profile, context);
+
+	line = g_strdup_printf(_("Authorization request for %s"), device);
+	g_free(device);
+
+	show_notification(adapter ? adapter : _("Bluetooth device"),
+					line, _("Check authorization"), 0,
+					G_CALLBACK(notification_closed));
+
+	g_free(line);
+
+	return TRUE;
+}
+
+static gboolean auth_agent_cancel(PasskeyAgent *agent,
+		const char *path, const char *address, const char *service,
+			const char *uuid, DBusGMethodInvocation *context)
+{
+	GList *list;
+	GError *result;
+	struct input_data *input;
+
+	input = g_try_malloc0(sizeof(*input));
+	if (!input)
+		return FALSE;
+
+	input->path = g_strdup(path);
+	input->address = g_strdup(address);
+	input->service = g_strdup(service);
+	input->uuid = g_strdup(uuid);
+
+	list = g_list_find_custom(input_list, input, input_compare);
+
+	g_free(input->uuid);
+	g_free(input->service);
+	g_free(input->address);
+	g_free(input->path);
+	g_free(input);
+
+	if (!list || !list->data)
+		return FALSE;
+
+	input = list->data;
+
+	close_notification();
+
+	result = g_error_new(AGENT_ERROR, AGENT_ERROR_REJECT,
+						"Agent callback canceled");
+
+	dbus_g_method_return_error(input->context, result);
+
+	input_free(input);
+
+	return TRUE;
+}
+
+static gboolean auth_agent_release(PasskeyAgent *agent, GError **error)
+{
+	registered_auth = 0;
+
+	return TRUE;
+}
+
+#include "auth-agent-glue.h"
+
+int register_agents(void)
+{
+	DBusGProxy *object;
+	GError *error = NULL;
+
+	if (registered_passkey && registered_auth)
+		return 0;
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+					"/org/bluez", "org.bluez.Security");
+
+	if (!registered_passkey) {
+
+		dbus_g_proxy_call(object, "RegisterDefaultPasskeyAgent",
+				&error, G_TYPE_STRING, PASSKEY_AGENT_PATH,
+					G_TYPE_INVALID, G_TYPE_INVALID);
+
+		if (error != NULL) {
+			g_error_free(error);
+			return -1;
+		}
+
+		registered_passkey = 1;
+	}
+
+	if (!registered_auth) {
+		dbus_g_proxy_call(object, "RegisterDefaultAuthorizationAgent",
+				&error,	G_TYPE_STRING, AUTH_AGENT_PATH,
+					G_TYPE_INVALID, G_TYPE_INVALID);
+
+		if (error != NULL) {
+			g_error_free(error);
+			return -1;
+		}
+
+		registered_auth = 1;
+	}
+
+	/* To test a particular type of authorization or pairing question */
+	//passkey_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "Test", NULL);
+	//confirm_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "123456", "Test", NULL);
+	//auth_dialog("/org/bluez/hci0", "00:11:22:33:44:55", "/org/bluez/echo", "", "Test", "Echo service", NULL);
+
+	return 0;
+}
+
+void unregister_agents(void)
+{
+	registered_passkey = 0;
+	registered_auth = 0;
+}
+
+void flush_input(void)
+{
+	close_notification();
+
+	g_list_foreach(input_list, show_dialog, NULL);
+
+	gtk_status_icon_set_blinking(statusicon, FALSE);
+}
+
+void setup_agent_dbus(void)
+{
+	void *agent;
+
+	dbus_g_object_type_install_info(PASSKEY_AGENT_OBJECT_TYPE,
+					&dbus_glib_passkey_agent_object_info);
+
+	dbus_g_object_type_install_info(AUTH_AGENT_OBJECT_TYPE,
+					&dbus_glib_auth_agent_object_info);
+
+	dbus_g_error_domain_register(AGENT_ERROR, "org.bluez.Error",
+							AGENT_ERROR_TYPE);
+
+	agent = passkey_agent_new(PASSKEY_AGENT_PATH);
+
+	agent = auth_agent_new(AUTH_AGENT_PATH);
+}
+void set_auto_authorize(gboolean value)
+{
+	auto_authorize = value;
+}
+
--- /dev/null	2008-01-24 17:45:36.352009045 +0000
+++ agents.h	2008-02-01 17:25:58.000000000 +0000
@@ -0,0 +1,29 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007  Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int register_agents(void);
+void unregister_agents(void);
+void flush_input(void);
+void setup_agent_dbus(void);
+void set_auto_authorize(gboolean auto_authorize);

--=-aYI9EM/1dLdtj00VleE5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-aYI9EM/1dLdtj00VleE5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-aYI9EM/1dLdtj00VleE5--
