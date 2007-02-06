Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-zwQTgCda0+I5zK0yaCJg"
Date: Tue, 06 Feb 2007 16:53:22 +0000
Message-Id: <1170780802.13023.28.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [Fwd: Re:  Removing features]
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


--=-zwQTgCda0+I5zK0yaCJg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Re-sending at Marcel's request.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-zwQTgCda0+I5zK0yaCJg
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Bluez-devel] Removing features
Content-Type: message/rfc822

Subject: Re: [Bluez-devel] Removing features
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1166970770.15485.17.camel@violet>
References: <1166912168.22566.11.camel@randel.hadess.net>
	<1166968557.15485.14.camel@violet>
	<1166969536.3223.4.camel@randel.hadess.net>
	<1166970770.15485.17.camel@violet>
Content-Type: multipart/mixed; boundary="=-8SaIaOcAzoqi7raWfNPK"
Message-Id: <1166973356.3223.13.camel@randel.hadess.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Date: Sun, 24 Dec 2006 15:17:53 +0000


--=-8SaIaOcAzoqi7raWfNPK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Marcel,

On Sun, 2006-12-24 at 15:32 +0100, Marcel Holtmann wrote:
> Hi Bastien,
<snip>
> > Did you want to make HAL a hard dependency, or should it be optional as
> > now?
> > 
> > I'll finish that up now.
> 
> do we need something? I thought they are D-Bus calls only.

Yep, libhal. Reimplementing the query functions, etc. would be a PITA.
See attached patch.

> > > The other thing is that this doesn't really belong into bluetooth-applet
> > > and should be moved directly into hcid. However this might give some
> > > crazy dependency chain.
> > 
> > I don't think such a policy should be in hcid, but rather in the desktop
> > bits. (Currently, the bluetooth daemons are started a long time before
> > HAL is, at least in Fedora, and Matthew Garrett's HAL bits need the
> > bluetooth daemon running, so, yeah, crazy deps).
> 
> In general you are right, but tell that to the Bluetooth specification.
> The class of device is really a per adapter thing and not a per user
> thing unless we can assign specific hardware only to one particular
> user.

I understand that. But hcid can be run on other types of Linux devices,
which wouldn't have HAL available, or need more flexibility than what
the bluez GNOME applets and properties might allow. As the properties
and applet are integrated together, it makes sense to have them rely on
each other.

As for the Bluetooth specs saying there can only be one class per
adapter, I don't see how that's different from the properties allowing
different users to set a different visible name for the adapter. Similar
problem to users having different power preferences with
gnome-power-manager, or network settings with NetworkManager. This is
something to revisit when ConsoleKit reaches maturity.

I hope you like the attached patch.

Cheers (and merry Christmas ;)

-- 
Bastien Nocera <hadess@hadess.net>

--=-8SaIaOcAzoqi7raWfNPK
Content-Disposition: attachment;
	filename=bluez-gnome-setup-class-with-hal-2.patch
Content-Type: text/x-patch; name=bluez-gnome-setup-class-with-hal-2.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

Index: configure.in
===================================================================
RCS file: /cvsroot/bluez/gnome/configure.in,v
retrieving revision 1.30
diff -u -p -u -p -r1.30 configure.in
--- configure.in	9 Nov 2006 16:53:04 -0000	1.30
+++ configure.in	24 Dec 2006 14:56:21 -0000
@@ -57,6 +57,12 @@ PKG_CHECK_MODULES(NOTIFY, libnotify >= 0
 AC_SUBST(NOTIFY_CFLAGS)
 AC_SUBST(NOTIFY_LIBS)
 
+PKG_CHECK_MODULES(HAL, hal >= 0.5.8, [
+	AC_DEFINE(HAVE_HAL, 1, [Define to 1 if you have HAL support.])
+], AC_MSG_RESULT(no))
+AC_SUBST(HAL_CFLAGS)
+AC_SUBST(HAL_LIBS)
+
 PKG_CHECK_MODULES(OPENOBEX, libopenobex-glib >= 1.4, dummy=yes, AC_MSG_RESULT(no))
 AC_SUBST(OPENOBEX_CFLAGS)
 AC_SUBST(OPENOBEX_LIBS)
Index: applet/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/Makefile.am,v
retrieving revision 1.14
diff -u -p -u -p -r1.14 Makefile.am
--- applet/Makefile.am	27 Oct 2006 18:20:34 -0000	1.14
+++ applet/Makefile.am	24 Dec 2006 14:56:21 -0000
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
retrieving revision 1.49
diff -u -p -u -p -r1.49 main.c
--- applet/main.c	18 Nov 2006 20:01:35 -0000	1.49
+++ applet/main.c	24 Dec 2006 14:56:21 -0000
@@ -31,6 +31,11 @@
 #include <string.h>
 
 #include <dbus/dbus-glib.h>
+#ifdef HAVE_HAL
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib-lowlevel.h>
+#include <hal/libhal.h>
+#endif
 
 #include <gconf/gconf-client.h>
 
@@ -935,6 +940,79 @@ static int attached_adapters(void)
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
@@ -956,6 +1034,10 @@ static void add_adapter(const char *path
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
+++ properties/Makefile.am	24 Dec 2006 14:56:21 -0000
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
retrieving revision 1.24
diff -u -p -u -p -r1.24 main.c
--- properties/main.c	24 Nov 2006 20:26:39 -0000	1.24
+++ properties/main.c	24 Dec 2006 14:56:22 -0000
@@ -31,6 +31,11 @@
 #include <string.h>
 
 #include <dbus/dbus-glib.h>
+#ifdef HAVE_HAL
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib-lowlevel.h>
+#include <libhal.h>
+#endif
 
 #include <gconf/gconf-client.h>
 
@@ -75,6 +80,10 @@ static GtkWidget *device_tree;
 
 static GtkListStore *service_store;
 
+#ifdef HAVE_HAL
+static gboolean has_hal = FALSE;
+#endif /* HAVE_HAL */
+
 static void update_icon_policy(GtkWidget *button)
 {
 	GtkWidget *widget;
@@ -905,10 +914,55 @@ static void class_callback(GtkWidget *co
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
+	gtk_label_set_markup(GTK_LABEL(label), _("\n<b>Class of device</b>"));
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
@@ -916,10 +970,8 @@ static void create_adapter(struct adapte
 	GtkWidget *button;
 	GtkWidget *scale;
 	GtkWidget *entry;
-	GtkWidget *combobox;
 	GSList *group = NULL;
 	gdouble value;
-	gint index;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
@@ -933,12 +985,6 @@ static void create_adapter(struct adapte
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
@@ -1071,42 +1117,17 @@ static void create_adapter(struct adapte
 	g_signal_connect(G_OBJECT(entry), "focus-out-event",
 					G_CALLBACK(focus_callback), adapter);
 
-	label = gtk_label_new(NULL);
-
-	gtk_label_set_markup(GTK_LABEL(label), _("\n<b>Class of device</b>"));
 
-	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
+	if (!has_hal) {
+		const char *major, *minor;
+		dbus_g_proxy_call(object, "GetMajorClass", NULL, G_TYPE_INVALID,
+				  G_TYPE_STRING, &major, G_TYPE_INVALID);
 
-	gtk_misc_set_alignment(GTK_MISC(label), 0, 0);
-
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
-
-	combobox = gtk_combo_box_new_text();
-
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Unspecified"));
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Desktop workstation"));
-	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox), _("Laptop computer"));
+		dbus_g_proxy_call(object, "GetMinorClass", NULL, G_TYPE_INVALID,
+				  G_TYPE_STRING, &minor, G_TYPE_INVALID);
 
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
-
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
-
-	adapter->combo = combobox;
-
-	g_signal_connect(G_OBJECT(combobox), "changed",
-					G_CALLBACK(class_callback), adapter);
+		create_adapter_class (adapter, vbox, minor, major);
+	}
 
 	gtk_widget_show_all(vbox);
 }
@@ -1215,6 +1236,11 @@ static void minor_changed(DBusGProxy *ob
 	GList *list;
 	const char *path;
 
+#ifdef HAVE_HAL
+	if (has_hal)
+		return;
+#endif /* HAVE_HAL */
+
 	path = dbus_g_proxy_get_path(object);
 
 	list = g_list_find_custom(adapter_list, path, adapter_compare);
@@ -1569,6 +1595,40 @@ static DBusGProxy *setup_dbus(void)
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
@@ -1638,6 +1698,7 @@ int main(int argc, char *argv[])
 	notebook = gtk_notebook_new();
 
 	service = setup_dbus();
+	setup_hal ();
 
 	manager = setup_manager();
 

--=-8SaIaOcAzoqi7raWfNPK--

--=-zwQTgCda0+I5zK0yaCJg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-zwQTgCda0+I5zK0yaCJg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-zwQTgCda0+I5zK0yaCJg--
