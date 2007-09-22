Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sat, 22 Sep 2007 23:55:21 +0100
Message-Id: <1190501721.7150.264.camel@pmac.infradead.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Fix bluez-gnome crash on input CreateDevice
	failure
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

When we try to add an input device which already exists, the
bluetooth-properties applet crashes with a dbus error.

This gives a slightly nicer failure mode...

diff --git a/properties/input.c b/properties/input.c
index 7a024ae..4142df5 100644
--- a/properties/input.c
+++ b/properties/input.c
@@ -56,10 +58,11 @@ static void proxy_callback(DBusGProxy *proxy,
 	const char *path, *busname;
 	const char *adapter = NULL, *address = NULL, *name = NULL;
 	gchar *text;
+	GError *error = NULL;
 
 	g_object_set_data(G_OBJECT(notebook), "call", NULL);
 
-	dbus_g_proxy_end_call(proxy, call, NULL,
+	dbus_g_proxy_end_call(proxy, call, &error,
 				G_TYPE_STRING, &path, G_TYPE_INVALID);
 
 	button = g_object_get_data(G_OBJECT(notebook), "cancel");
@@ -68,6 +71,15 @@ static void proxy_callback(DBusGProxy *proxy,
 	button = g_object_get_data(G_OBJECT(notebook), "close");
 	gtk_widget_set_sensitive(button, TRUE);
 
+	if (error) {
+		label = g_object_get_data(G_OBJECT(notebook), "label");
+		text = g_strdup_printf("<b>%s: %s</b>",
+				       _("Connection failed"), error->message);
+		gtk_label_set_markup(GTK_LABEL(label), text);
+		g_free(text);
+		return;
+	}
+
 	busname = dbus_g_proxy_get_bus_name(proxy);
 
 	client = dbus_g_proxy_new_for_name(connection, busname,


-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
