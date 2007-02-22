Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-uL7HMv3Frq16eUfsZmd8"
Date: Thu, 22 Feb 2007 23:31:33 +0000
Message-Id: <1172187093.10673.17.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Another bluez-gnome patch
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


--=-uL7HMv3Frq16eUfsZmd8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Here's an updated patch for the bluez-gnome applet and properties:
- Use HAL to determine the device class, if HAL is available
- Fix translation of scanning mode changes (modes weren't translated at
all, and the string used could only be used in English)
- Don't show the notification bubble when switching the bluetooth device
on/off, and we're only showing the icon if a device is present. The icon
appearing/disappearing should be enough
- Fix excessive markup in the properties labels

Marcel, could you merge those patches?

Once you've accepted this patch, my next step is to implement the
software enable/disable for laptops in the applet (that would use HAL as
well).

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-uL7HMv3Frq16eUfsZmd8
Content-Disposition: attachment;
	filename=bluez-gnome-setup-class-with-hal-3.patch
Content-Type: text/x-patch; name=bluez-gnome-setup-class-with-hal-3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: configure.in
===================================================================
RCS file: /cvsroot/bluez/gnome/configure.in,v
retrieving revision 1.32
diff -u -p -u -p -r1.32 configure.in
--- configure.in	7 Feb 2007 11:35:30 -0000	1.32
+++ configure.in	22 Feb 2007 23:25:53 -0000
@@ -61,6 +61,12 @@ PKG_CHECK_MODULES(NOTIFY, libnotify >= 0
 AC_SUBST(NOTIFY_CFLAGS)
 AC_SUBST(NOTIFY_LIBS)
 
+PKG_CHECK_MODULES(HAL, hal >= 0.5.8, [
+	AC_DEFINE(HAVE_HAL, 1, [Define to 1 if you have HAL support.])
+], AC_MSG_RESULT(no))
+AC_SUBST(HAL_CFLAGS)
+AC_SUBST(HAL_LIBS)
+
 PKG_CHECK_MODULES(OPENOBEX, libopenobex-glib >= 1.4, dummy=yes, dummy=no)
 AC_SUBST(OPENOBEX_CFLAGS)
 AC_SUBST(OPENOBEX_LIBS)
Index: applet/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/Makefile.am,v
retrieving revision 1.14
diff -u -p -u -p -r1.14 Makefile.am
--- applet/Makefile.am	27 Oct 2006 18:20:34 -0000	1.14
+++ applet/Makefile.am	22 Feb 2007 23:25:54 -0000
@@ -3,9 +3,9 @@ bin_PROGRAMS = bluetooth-applet
 
 bluetooth_applet_SOURCES = main.c
 
-bluetooth_applet_LDADD = @NOTIFY_LIBS@ @GTK_LIBS@ @GCONF_LIBS@ @DBUS_LIBS@ $(top_builddir)/compat/libcompat.a
+bluetooth_applet_LDADD = @NOTIFY_LIBS@ @GTK_LIBS@ @GCONF_LIBS@ @DBUS_LIBS@ @HAL_LIBS@ $(top_builddir)/compat/libcompat.a
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GCONF_CFLAGS@ @GTK_CFLAGS@ @NOTIFY_CFLAGS@
+AM_CFLAGS = @DBUS_CFLAGS@ @GCONF_CFLAGS@ @GTK_CFLAGS@ @NOTIFY_CFLAGS@ @HAL_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/compat
 
Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.50
diff -u -p -u -p -r1.50 main.c
--- applet/main.c	11 Feb 2007 21:36:18 -0000	1.50
+++ applet/main.c	22 Feb 2007 23:25:54 -0000
@@ -31,6 +31,11 @@
 #include <string.h>
 
 #include <dbus/dbus-glib.h>
+#ifdef HAVE_HAL
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib-lowlevel.h>
+#include <hal/libhal.h>
+#endif
 
 #include <gconf/gconf-client.h>
 
@@ -46,6 +51,12 @@
 #include "gtkstatusicon.h"
 #endif
 
+/* Scanning modes, used by mode_changed(), copied from hcid.h in bluez-utils */
+#define MODE_OFF                "off"
+#define MODE_CONNECTABLE        "connectable"
+#define MODE_DISCOVERABLE       "discoverable"
+#define MODE_UNKNOWN            "unknown"
+
 #define PASSKEY_AGENT_PATH	"/org/bluez/passkey"
 #define AUTH_AGENT_PATH		"/org/bluez/auth"
 
@@ -874,10 +885,26 @@ static void mode_changed(DBusGProxy *obj
 	const char *adapter = NULL;
 	gchar *text;
 
+	if (icon_policy == ICON_POLICY_PRESENT) {
+		if (g_str_equal (mode, "off"))
+			return;
+		if (g_str_equal (mode, "connectable"))
+			return;
+	}
+
 	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
 				G_TYPE_STRING, &adapter, G_TYPE_INVALID);
 
-	text = g_strdup_printf(_("Switched device into\n%s mode"), mode);
+	if (g_str_equal (mode, MODE_OFF)) {
+		text = g_strdup_printf(_("Switched device into\noff mode"));
+	} else if (g_str_equal (mode, MODE_CONNECTABLE)) {
+		text = g_strdup_printf(_("Switched device into\nconnectable mode"));
+	} else if (g_str_equal (mode, MODE_DISCOVERABLE)) {
+		text = g_strdup_printf(_("Switched device into\ndiscoverable mode"));
+	} else {
+		/* MODE_UNKNOWN */
+		text = g_strdup_printf(_("Switched device into\nunknown mode"));
+	}
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
 							text, 3000, NULL);
@@ -935,6 +962,79 @@ static int attached_adapters(void)
 	return count;
 }
 
+#ifdef HAVE_HAL
+static void
+class_setup (struct adapter_data *adapter)
+{
+	DBusError error;
+	LibHalContext *ctx;
+	DBusConnection *c;
+	DBusGProxy *object;
+	char *formfactor;
+	gboolean bail = FALSE;
+
+	c = dbus_g_connection_get_connection (conn);
+	if (!c)
+		return;
+
+	ctx = libhal_ctx_new ();
+	if (ctx == NULL)
+		return;
+
+	if (!libhal_ctx_set_dbus_connection (ctx, c)) {
+		libhal_ctx_free (ctx);
+		return;
+	}
+
+	dbus_error_init (&error);
+	libhal_ctx_init (ctx, &error);
+	if (dbus_error_is_set (&error)) {
+		g_warning ("Couldn't get the system D-Bus: %s", error.message);
+		dbus_error_free (&error);
+		libhal_ctx_free (ctx);
+		return;
+	}
+
+	formfactor = libhal_device_get_property_string (ctx,
+						        "/org/freedesktop/Hal/devices/computer",
+						        "system.formfactor", &error);
+	if (dbus_error_is_set (&error)) {
+		g_warning ("Couldn't get the form factor: %s", error.message);
+		dbus_error_free (&error);
+		bail = TRUE;
+	}
+
+	if (!formfactor)
+		bail = TRUE;
+
+	libhal_ctx_shutdown (ctx, NULL);
+	libhal_ctx_free (ctx);
+	if (bail)
+		return;
+
+	if (strcmp (formfactor, "laptop") &&
+	    strcmp (formfactor, "desktop")) {
+		/* We don't know anything else */
+		formfactor = g_strdup ("uncategorized");
+	}
+
+	/* Done with HAL, now act on the formfactor */
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+			adapter->path, "org.bluez.Adapter");
+	if (!object) {
+		g_free (formfactor);
+		return;
+	}
+
+	dbus_g_proxy_call(object, "SetMajorClass", NULL,
+			G_TYPE_STRING, "computer", G_TYPE_INVALID, G_TYPE_INVALID);
+	dbus_g_proxy_call(object, "SetMinorClass", NULL,
+			G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
+
+	g_free (formfactor);
+}
+#endif
+
 static void add_adapter(const char *path)
 {
 	GList *list;
@@ -956,6 +1056,10 @@ static void add_adapter(const char *path
 	adapter->path = g_strdup(path);
 	adapter->attached = 1;
 
+#ifdef HAVE_HAL
+	class_setup (adapter);
+#endif
+
 	adapter_list = g_list_append(adapter_list, adapter);
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
Index: properties/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/Makefile.am,v
retrieving revision 1.6
diff -u -p -u -p -r1.6 Makefile.am
--- properties/Makefile.am	24 Nov 2006 20:26:39 -0000	1.6
+++ properties/Makefile.am	22 Feb 2007 23:25:54 -0000
@@ -3,10 +3,10 @@ bin_PROGRAMS = bluetooth-properties
 
 bluetooth_properties_SOURCES = main.c
 
-bluetooth_properties_LDADD = @GTK_LIBS@ @GCONF_LIBS@ @DBUS_LIBS@ \
+bluetooth_properties_LDADD = @GTK_LIBS@ @GCONF_LIBS@ @DBUS_LIBS@ @HAL_LIBS@ \
 				$(top_builddir)/common/libcommon.a
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GCONF_CFLAGS@ @GTK_CFLAGS@
+AM_CFLAGS = @DBUS_CFLAGS@ @GCONF_CFLAGS@ @GTK_CFLAGS@ @HAL_CFLAGS@
 
 desktopdir = $(datadir)/applications
 
Index: properties/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/main.c,v
retrieving revision 1.29
diff -u -p -u -p -r1.29 main.c
--- properties/main.c	11 Feb 2007 21:36:19 -0000	1.29
+++ properties/main.c	22 Feb 2007 23:25:54 -0000
@@ -31,6 +31,11 @@
 #include <string.h>
 
 #include <dbus/dbus-glib.h>
+#ifdef HAVE_HAL
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib-lowlevel.h>
+#include <libhal.h>
+#endif
 
 #include <gconf/gconf-client.h>
 
@@ -75,6 +80,19 @@ static GtkWidget *device_tree;
 
 static GtkListStore *service_store;
 
+#ifdef HAVE_HAL
+static gboolean has_hal = FALSE;
+#endif /* HAVE_HAL */
+
+static void set_bold_label (GtkWidget *label, const char *txt)
+{
+	char *tmp;
+
+	tmp = g_strdup_printf ("<b>%s</b>", txt);
+	gtk_label_set_markup(GTK_LABEL(label), tmp);
+	g_free (tmp);
+}
+
 static void update_icon_policy(GtkWidget *button)
 {
 	GtkWidget *widget;
@@ -163,7 +181,7 @@ static void create_general(void)
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>Authorization requests</b>"));
+	set_bold_label (label, _("Authorization requests"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -185,7 +203,7 @@ static void create_general(void)
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>\nNotification area</b>"));
+	set_bold_label (label, _("Notification area"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -343,7 +361,7 @@ static void show_properties(const gchar 
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>Service path</b>"));
+	set_bold_label (label, _("Service Path"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -361,7 +379,7 @@ static void show_properties(const gchar 
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("\n<b>Description</b>"));
+	set_bold_label (label, _("Description"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -430,7 +448,7 @@ static void create_services(void)
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>Available services</b>"));
+	set_bold_label (label, _("Available services"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -578,7 +596,7 @@ static void create_devices(void)
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>Trusted devices</b>"));
+	set_bold_label (label, _("Trusted devices"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -905,10 +923,55 @@ static void class_callback(GtkWidget *co
 			G_TYPE_STRING, minor, G_TYPE_INVALID, G_TYPE_INVALID);
 }
 
+static void create_adapter_class(struct adapter_data *adapter,
+		GtkWidget *vbox, const char *minor, const char *major)
+{
+	GtkWidget *label;
+	GtkWidget *combobox;
+	gint index;
+
+	label = gtk_label_new(NULL);
+
+	set_bold_label(label, _("Class of device"));
+
+	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
+
+	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
+
+	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+
+	combobox = gtk_combo_box_new_text();
+
+	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Unspecified"));
+	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Desktop workstation"));
+	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Laptop computer"));
+
+	if (major && minor && !strcmp(major, "computer")) {
+		if (!strcmp(minor, "uncategorized"))
+			index = 0;
+		else if (!strcmp(minor, "desktop"))
+			index = 1;
+		else if (!strcmp(minor, "laptop"))
+			index = 2;
+		else
+			index = -1;
+
+		gtk_combo_box_set_active(GTK_COMBO_BOX(combobox), index);
+	} else
+		gtk_widget_set_sensitive(GTK_WIDGET(combobox), FALSE);
+
+	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
+
+	adapter->combo = combobox;
+
+	g_signal_connect(G_OBJECT(combobox), "changed",
+					G_CALLBACK(class_callback), adapter);
+}
+
 static void create_adapter(struct adapter_data *adapter)
 {
 	DBusGProxy *object;
-	const char *name = NULL, *mode = NULL, *major = NULL, *minor = NULL;
+	const char *name = NULL, *mode = NULL;
 	const guint32 timeout;
 
 	GtkWidget *vbox;
@@ -916,10 +979,8 @@ static void create_adapter(struct adapte
 	GtkWidget *button;
 	GtkWidget *scale;
 	GtkWidget *entry;
-	GtkWidget *combobox;
 	GSList *group = NULL;
 	gdouble value;
-	gint index;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
@@ -933,12 +994,6 @@ static void create_adapter(struct adapte
 	dbus_g_proxy_call(object, "GetName", NULL, G_TYPE_INVALID,
 				G_TYPE_STRING, &name, G_TYPE_INVALID);
 
-	dbus_g_proxy_call(object, "GetMajorClass", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &major, G_TYPE_INVALID);
-
-	dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
-				G_TYPE_STRING, &minor, G_TYPE_INVALID);
-
 	vbox = gtk_vbox_new(FALSE, 6);
 
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
@@ -958,7 +1013,7 @@ static void create_adapter(struct adapte
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("<b>Mode of operation</b>"));
+	set_bold_label (label, _("Mode of operation"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -1046,7 +1101,7 @@ static void create_adapter(struct adapte
 
 	label = gtk_label_new(NULL);
 
-	gtk_label_set_markup(GTK_LABEL(label), _("\n<b>Adapter name</b>"));
+	set_bold_label (label, _("Adapter name"));
 
 	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
 
@@ -1071,42 +1126,17 @@ static void create_adapter(struct adapte
 	g_signal_connect(G_OBJECT(entry), "focus-out-event",
 					G_CALLBACK(focus_callback), adapter);
 
-	label = gtk_label_new(NULL);
-
-	gtk_label_set_markup(GTK_LABEL(label), _("\n<b>Class of device</b>"));
-
-	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
-
-	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
-
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
-
-	combobox = gtk_combo_box_new_text();
-
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Unspecified"));
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Desktop workstation"));
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Laptop computer"));
-
-	if (major && minor && !strcmp(major, "computer")) {
-		if (!strcmp(minor, "uncategorized"))
-			index = 0;
-		else if (!strcmp(minor, "desktop"))
-			index = 1;
-		else if (!strcmp(minor, "laptop"))
-			index = 2;
-		else
-			index = -1;
-
-		gtk_combo_box_set_active(GTK_COMBO_BOX(combobox), index);
-	} else
-		gtk_widget_set_sensitive(GTK_WIDGET(combobox), FALSE);
 
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
+	if (!has_hal) {
+		const char *major, *minor;
+		dbus_g_proxy_call(object, "GetMajorClass", NULL, G_TYPE_INVALID,
+				  G_TYPE_STRING, &major, G_TYPE_INVALID);
 
-	adapter->combo = combobox;
+		dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
+				  G_TYPE_STRING, &minor, G_TYPE_INVALID);
 
-	g_signal_connect(G_OBJECT(combobox), "changed",
-					G_CALLBACK(class_callback), adapter);
+		create_adapter_class (adapter, vbox, minor, major);
+	}
 
 	gtk_widget_show_all(vbox);
 }
@@ -1215,6 +1245,11 @@ static void minor_changed(DBusGProxy *ob
 	GList *list;
 	const char *path;
 
+#ifdef HAVE_HAL
+	if (has_hal)
+		return;
+#endif /* HAVE_HAL */
+
 	path = dbus_g_proxy_get_path(object);
 
 	list = g_list_find_custom(adapter_list, path, adapter_compare);
@@ -1584,6 +1619,40 @@ static DBusGProxy *setup_dbus(void)
 	return object;
 }
 
+#ifdef HAVE_HAL
+static void setup_hal(void)
+{
+	DBusError error;
+	LibHalContext *ctx;
+	DBusConnection *c;
+
+	c = dbus_g_connection_get_connection (conn);
+	if (!c)
+		return;
+
+	ctx = libhal_ctx_new ();
+	if (ctx == NULL)
+		return;
+
+	if (!libhal_ctx_set_dbus_connection (ctx, c)) {
+		libhal_ctx_free (ctx);
+		return;
+	}
+
+	dbus_error_init (&error);
+	if (libhal_ctx_init (ctx, &error))
+		has_hal = TRUE;
+
+	if (dbus_error_is_set (&error)) {
+		g_warning ("Couldn't connect to HAL: %s", error.message);
+		dbus_error_free (&error);
+		has_hal = FALSE;
+	}
+
+	libhal_ctx_free (ctx);
+}
+#endif /* HAVE_HAL */
+
 static void gconf_callback(GConfClient *client, guint cnxn_id,
 					GConfEntry *entry, gpointer user_data)
 {
@@ -1653,6 +1722,7 @@ int main(int argc, char *argv[])
 	notebook = gtk_notebook_new();
 
 	service = setup_dbus();
+	setup_hal ();
 
 	manager = setup_manager();
 


--=-uL7HMv3Frq16eUfsZmd8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-uL7HMv3Frq16eUfsZmd8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-uL7HMv3Frq16eUfsZmd8--
