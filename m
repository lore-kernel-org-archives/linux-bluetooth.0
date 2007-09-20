Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-hNlXQkw1ieTezNZEQ82Z"
Date: Thu, 20 Sep 2007 15:37:59 +0100
Message-Id: <1190299079.10494.71.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] bluez-gnome: Disable class drop-down when hal is used
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


--=-hNlXQkw1ieTezNZEQ82Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Currently, the class drop-down might be used to override the automatic
class selection when HAL is being used. The simple fix is to not allow
the user to change the adapter's class if HAL is used.

Patch attached.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-hNlXQkw1ieTezNZEQ82Z
Content-Disposition: attachment;
	filename=bluez-gnome-0.14-disable-class-selection-with-hal.patch
Content-Type: text/x-patch;
	name=bluez-gnome-0.14-disable-class-selection-with-hal.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

? .deps
? Makefile
? Makefile.in
? bluetooth-manager.schemas
? bluetooth-properties
? bluetooth-properties.desktop
? foo
Index: adapter.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/adapter.c,v
retrieving revision 1.17
diff -u -p -r1.17 adapter.c
--- adapter.c	29 Aug 2007 15:41:49 -0000	1.17
+++ adapter.c	20 Sep 2007 14:09:27 -0000
@@ -26,6 +26,8 @@
 #include <config.h>
 #endif
 
+#include <gconf/gconf-client.h>
+
 #include <dbus/dbus-glib.h>
 
 #include <glib/gi18n.h>
@@ -509,6 +511,21 @@ GtkWidget *create_tree(GtkTreeModel *mod
 	return tree;
 }
 
+static void gconf_callback(GConfClient *client, guint cnxn_id,
+					GConfEntry *entry, gpointer user_data)
+{
+	GConfValue *value;
+
+	if (g_ascii_strcasecmp(entry->key, PREF_USE_HAL) != 0)
+		return;
+
+	value = gconf_entry_get_value(entry);
+	if (value == NULL)
+		return;
+
+	gtk_widget_set_sensitive(GTK_WIDGET(user_data), !gconf_value_get_bool(value));
+}
+
 static void create_adapter(struct adapter_data *adapter)
 {
 	DBusGProxy *object;
@@ -530,8 +547,10 @@ static void create_adapter(struct adapte
 	GtkTreeModel *model;
 	GtkTreeSelection *selection;
 	GSList *group = NULL;
+	GConfClient *gconf;
 	gdouble value;
 	gint index;
+	gboolean use_hal;
 
 	object = dbus_g_proxy_new_for_name(connection, "org.bluez",
 					adapter->path, "org.bluez.Adapter");
@@ -726,6 +745,16 @@ static void create_adapter(struct adapte
 	g_signal_connect(G_OBJECT(combobox), "changed",
 					G_CALLBACK(class_callback), adapter);
 
+	/* Monitor the use_hal preference */
+	gconf = gconf_client_get_default();
+	use_hal = gconf_client_get_bool(gconf, PREF_USE_HAL, NULL);
+	gtk_widget_set_sensitive(combobox, !use_hal);
+
+	gconf_client_add_dir(gconf, PREF_DIR, GCONF_CLIENT_PRELOAD_NONE, NULL);
+	gconf_client_notify_add(gconf, PREF_DIR,
+					gconf_callback, combobox, NULL, NULL);
+	g_object_unref(gconf);
+
 	vbox = gtk_vbox_new(FALSE, 6);
 	gtk_box_pack_start(GTK_BOX(mainbox), vbox, TRUE, TRUE, 0);
 
Index: general.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/general.c,v
retrieving revision 1.2
diff -u -p -r1.2 general.c
--- general.c	29 Jul 2007 11:28:48 -0000	1.2
+++ general.c	20 Sep 2007 14:09:27 -0000
@@ -32,6 +32,7 @@
 
 #include <gtk/gtk.h>
 
+#include "general.h"
 #include "client.h"
 
 typedef enum {
@@ -42,11 +43,6 @@ typedef enum {
 
 static int icon_policy = ICON_POLICY_PRESENT;
 
-#define PREF_DIR		"/apps/bluetooth-manager"
-#define PREF_USE_HAL		PREF_DIR "/use_hal"
-#define PREF_ICON_POLICY	PREF_DIR "/icon_policy"
-#define PREF_AUTO_AUTHORIZE	PREF_DIR "/auto_authorize"
-
 static GConfEnumStringPair icon_policy_enum_map [] = {
 	{ ICON_POLICY_NEVER,	"never"		},
 	{ ICON_POLICY_ALWAYS,	"always"	},
Index: general.h
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/general.h,v
retrieving revision 1.1
diff -u -p -r1.1 general.h
--- general.h	29 Jul 2007 11:11:03 -0000	1.1
+++ general.h	20 Sep 2007 14:09:27 -0000
@@ -22,6 +22,11 @@
  *
  */
 
+#define PREF_DIR		"/apps/bluetooth-manager"
+#define PREF_USE_HAL		PREF_DIR "/use_hal"
+#define PREF_ICON_POLICY	PREF_DIR "/icon_policy"
+#define PREF_AUTO_AUTHORIZE	PREF_DIR "/auto_authorize"
+
 GtkWidget *create_label(const gchar *str);
 GtkWidget *create_general(void);
 void setup_general(void);

--=-hNlXQkw1ieTezNZEQ82Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-hNlXQkw1ieTezNZEQ82Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-hNlXQkw1ieTezNZEQ82Z--
