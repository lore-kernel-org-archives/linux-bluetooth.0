Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-q9v7ndQ1M8ZChfjiR1o5"
Date: Sat, 23 Dec 2006 22:16:08 +0000
Message-Id: <1166912168.22566.11.camel@randel.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Removing features
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


--=-q9v7ndQ1M8ZChfjiR1o5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

I was taking a look at the properties and applet in the bluez-gnome
tree, and thought that some things could be changed to make it more
GNOME-ish.

I've attached an obviously unfinished patch that would remove the
"Adapter class" combobox from the properties capplet, and have the
applet setup the class depending on the "system.formfactor" property
given out by HAL[1].

If this sort of thing would accepted into the tree, I have some more
patches lined up (including finishing up this one).

Cheers

[1]: See the output of "hal-device | grep formfactor" to check your
machine
-- 
Bastien Nocera <hadess@hadess.net>

--=-q9v7ndQ1M8ZChfjiR1o5
Content-Disposition: attachment;
	filename=bluez-gnome-setup-class-with-hal.patch
Content-Type: text/x-patch; name=bluez-gnome-setup-class-with-hal.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: configure.in
===================================================================
RCS file: /cvsroot/bluez/gnome/configure.in,v
retrieving revision 1.30
diff -u -p -u -p -r1.30 configure.in
--- configure.in	9 Nov 2006 16:53:04 -0000	1.30
+++ configure.in	23 Dec 2006 22:07:13 -0000
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
Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.49
diff -u -p -u -p -r1.49 main.c
--- applet/main.c	18 Nov 2006 20:01:35 -0000	1.49
+++ applet/main.c	23 Dec 2006 22:07:13 -0000
@@ -935,6 +935,15 @@ static int attached_adapters(void)
 	return count;
 }
 
+#ifdef HAVE_HAL
+static void
+class_setup (struct adapter_data *adapter)
+{
+	//FIXME
+	g_message ("setup the class from the system.formfactor");
+}
+#endif
+
 static void add_adapter(const char *path)
 {
 	GList *list;
@@ -956,6 +965,10 @@ static void add_adapter(const char *path
 	adapter->path = g_strdup(path);
 	adapter->attached = 1;
 
+#ifdef HAVE_HAL
+	class_setup (adapter);
+#endif
+
 	adapter_list = g_list_append(adapter_list, adapter);
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
Index: properties/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/main.c,v
retrieving revision 1.24
diff -u -p -u -p -r1.24 main.c
--- properties/main.c	24 Nov 2006 20:26:39 -0000	1.24
+++ properties/main.c	23 Dec 2006 22:07:13 -0000
@@ -875,6 +875,7 @@ static gboolean focus_callback(GtkWidget
 	return FALSE;
 }
 
+#ifndef HAVE_HAL
 static void class_callback(GtkWidget *combobox, gpointer user_data)
 {
 	struct adapter_data *adapter = user_data;
@@ -905,6 +906,53 @@ static void class_callback(GtkWidget *co
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
+#endif /* !HAVE_HAL */
+
 static void create_adapter(struct adapter_data *adapter)
 {
 	DBusGProxy *object;
@@ -916,10 +964,8 @@ static void create_adapter(struct adapte
 	GtkWidget *button;
 	GtkWidget *scale;
 	GtkWidget *entry;
-	GtkWidget *combobox;
 	GSList *group = NULL;
 	gdouble value;
-	gint index;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
@@ -1071,42 +1117,9 @@ static void create_adapter(struct adapte
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
-
-	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
-
-	adapter->combo = combobox;
-
-	g_signal_connect(G_OBJECT(combobox), "changed",
-					G_CALLBACK(class_callback), adapter);
+#ifndef HAVE_HAL
+	create_adapter_class (adapter, vbox, minor, major);
+#endif /* !HAVE_HAL */
 
 	gtk_widget_show_all(vbox);
 }

--=-q9v7ndQ1M8ZChfjiR1o5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-q9v7ndQ1M8ZChfjiR1o5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-q9v7ndQ1M8ZChfjiR1o5--
