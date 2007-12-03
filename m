Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-R85w2ytwWTOKF+mLqFX9"
Date: Mon, 03 Dec 2007 10:24:30 +0000
Message-Id: <1196677470.3227.192.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [patch] Use buttons in notification popups
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


--=-R85w2ytwWTOKF+mLqFX9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

As reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=407551

notification-daemon kind of sucks and doesn't allow for long messages
(it will clip the messages, see those screenshots:
https://bugzilla.redhat.com/attachment.cgi?id=274901
https://bugzilla.redhat.com/attachment.cgi?id=274911
)

Attached patch removes the extra lines, and adds a button to the popup
instead. It looks better, and still pops up the dialogues as expected.

Cheers

--=-R85w2ytwWTOKF+mLqFX9
Content-Disposition: attachment; filename=bluez-gnome-use-notify-button.patch
Content-Type: text/x-patch; name=bluez-gnome-use-notify-button.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.87
diff -u -p -r1.87 main.c
--- main.c	29 Aug 2007 20:42:18 -0000	1.87
+++ main.c	3 Dec 2007 10:20:18 -0000
@@ -653,7 +653,7 @@ static void notify_action(NotifyNotifica
 #endif
 
 static void show_notification(const gchar *summary, const gchar *message,
-					gint timeout, GCallback handler)
+			      const gchar *action, gint timeout, GCallback handler)
 {
 #ifdef HAVE_LIBNOTIFY
 	NotifyActionCallback callback;
@@ -685,6 +685,9 @@ static void show_notification(const gcha
 
 	notify_notification_add_action(notify, "default", "action",
 						callback, NULL, NULL);
+	if (action != NULL)
+		notify_notification_add_action(notify, "button", _(action),
+					       callback, NULL, NULL);
 
 	notify_notification_show(notify, NULL);
 #endif
@@ -761,7 +764,7 @@ static gboolean passkey_agent_request(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text, *line;
+	gchar *device, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -786,15 +789,12 @@ static gboolean passkey_agent_request(Pa
 	/* translators: this is a popup telling you a particular device
 	 * has asked for pairing */
 	line = g_strdup_printf(_("Pairing request for '%s'"), device);
-	text = g_strconcat(line, "\n\n",
-			_("Click to open passkey entry dialog"), NULL);
-	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-				text, 0, G_CALLBACK(notification_closed));
+				line, N_("Enter passkey"), 0, G_CALLBACK(notification_closed));
 
-	g_free(text);
+	g_free(line);
 
 	return TRUE;
 }
@@ -805,7 +805,7 @@ static gboolean passkey_agent_confirm(Pa
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *text, *line;
+	gchar *device, *line;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
 						path, "org.bluez.Adapter");
@@ -828,15 +828,12 @@ static gboolean passkey_agent_confirm(Pa
 	confirm_dialog(path, address, value, device, context);
 
 	line = g_strdup_printf(_("Pairing request for '%s'"), device);
-	text = g_strconcat(line, "\n\n",
-			_("Click to open confirmation dialog"), NULL);
-	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-				text, 0, G_CALLBACK(notification_closed));
+				line, N_("Confirm pairing"), 0, G_CALLBACK(notification_closed));
 
-	g_free(text);
+	g_free (line);
 
 	return TRUE;
 }
@@ -940,7 +937,7 @@ static gboolean auth_agent_authorize(Pas
 {
 	DBusGProxy *object;
 	const char *adapter = NULL, *name = NULL;
-	gchar *device, *profile, *text, *line;
+	gchar *device, *profile, *line;
 
 	if (auto_authorize == TRUE) {
 		dbus_g_method_return(context);
@@ -974,15 +971,12 @@ static gboolean auth_agent_authorize(Pas
 	auth_dialog(path, address, service, uuid, device, profile, context);
 
 	line = g_strdup_printf(_("Authorization request for %s"), device);
-	text = g_strconcat(line, "\n\n",
-			_("Click to open authorization dialog"), NULL);
-	g_free(line);
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-				text, 0, G_CALLBACK(notification_closed));
+				line, _("Check authorization"), 0, G_CALLBACK(notification_closed));
 
-	g_free(text);
+	g_free(line);
 
 	return TRUE;
 }
@@ -1105,7 +1099,7 @@ static void bonding_created(DBusGProxy *
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-							text, 6000, NULL);
+							text, NULL, 6000, NULL);
 
 	g_free(text);
 }
@@ -1136,7 +1130,7 @@ static void bonding_removed(DBusGProxy *
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-							text, 6000, NULL);
+							text, NULL, 6000, NULL);
 
 	g_free(text);
 }
@@ -1199,7 +1193,7 @@ static void mode_changed(DBusGProxy *obj
 				G_TYPE_STRING, &adapter_name, G_TYPE_INVALID);
 
 	show_notification(adapter_name ? adapter_name : _("Bluetooth device"),
-							_(text), 3000, NULL);
+							_(text), NULL, 3000, NULL);
 
 	set_new_mode(adapter, mode);
 }

--=-R85w2ytwWTOKF+mLqFX9
Content-Disposition: attachment; filename=pairing-notification.png
Content-Type: image/png; name=pairing-notification.png
Content-Transfer-Encoding: base64

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


--=-R85w2ytwWTOKF+mLqFX9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--=-R85w2ytwWTOKF+mLqFX9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-R85w2ytwWTOKF+mLqFX9--
