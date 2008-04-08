Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1207446435.26353.1.camel@californication>
References: <1207446435.26353.1.camel@californication>
Content-Type: multipart/mixed; boundary="=-MWe2Ygrw2M1dbZmYL3Of"
Date: Tue, 08 Apr 2008 17:28:57 +0100
Message-Id: <1207672137.3396.52.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-gnome-0.26
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


--=-MWe2Ygrw2M1dbZmYL3Of
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2008-04-06 at 03:47 +0200, Marcel Holtmann wrote:
> Hi Folks,
> 
> this is the twenty-sixth release of the gnome package for BlueZ. It
> contains a new version of the sendto application and translation
> updates.
> 
> The sources can be found at http://www.bluez.org/download.html

Another patch. This one gives you a better error message when you have a
Palm device, as well as changing the "ETA" message to match that of
Nautilus.

Cheers

--=-MWe2Ygrw2M1dbZmYL3Of
Content-Disposition: attachment; filename=bluez-gnome-sendto-palm.patch
Content-Type: text/x-patch; name=bluez-gnome-sendto-palm.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: sendto/dialog.h
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/dialog.h,v
retrieving revision 1.2
diff -u -p -u -p -r1.2 dialog.h
--- sendto/dialog.h	5 Apr 2008 23:59:11 -0000	1.2
+++ sendto/dialog.h	8 Apr 2008 15:53:07 -0000
@@ -21,5 +21,7 @@
  *
  */
 
+#include <glib.h>
+
 gchar *show_browse_dialog(void);
 gchar **show_select_dialog(void);
Index: sendto/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/main.c,v
retrieving revision 1.27
diff -u -p -u -p -r1.27 main.c
--- sendto/main.c	6 Apr 2008 01:26:23 -0000	1.27
+++ sendto/main.c	8 Apr 2008 15:53:08 -0000
@@ -78,6 +78,13 @@ static void response_callback(GtkWidget 
 	gtk_main_quit();
 }
 
+static gboolean is_palm_device(const gchar *bdaddr)
+{
+	return (g_str_has_prefix(bdaddr, "00:04:6B")
+		|| g_str_has_prefix(bdaddr, "00:07:E0")
+		|| g_str_has_prefix(bdaddr, "00:0E:20"));
+}
+
 static void create_window(void)
 {
 	GtkWidget *vbox;
@@ -260,15 +267,15 @@ static void transfer_progress(DBusGProxy
 	remaining_time = (total_size - current_sent) / transfer_rate;
 
 	if (remaining_time >= 3600)
-		time = g_strdup_printf(_("ETA %d:%02d:%02d"),
+		time = g_strdup_printf(_("%d:%02d:%02d Remaining"),
 					remaining_time / 3600,
 					(remaining_time % 3600) / 60,
 					(remaining_time % 3600) % 60);
 	else
-		time = g_strdup_printf(_("ETA %d:%02d"),
+		time = g_strdup_printf(_("%d:%02d Remaining"),
 				remaining_time / 60, remaining_time % 60);
 
-	if (transfer_rate >= 1000)
+	if (transfer_rate >= 3000)
 		rate = g_strdup_printf(_("%d KB/s"), transfer_rate / 1000);
 	else
 		rate = g_strdup_printf(_("%d B/s"), transfer_rate);
@@ -312,6 +319,29 @@ static void session_connected(DBusGProxy
 	send_file(proxy);
 }
 
+static gchar *get_error_message(GError *error)
+{
+	char *message;
+
+	if (error != NULL) {
+		const gchar *error_name;
+
+		if (error && error->code == DBUS_GERROR_REMOTE_EXCEPTION)
+			error_name = dbus_g_error_get_name(error);
+		else
+			error_name = NULL;
+
+		if (error_name && !strcmp(error_name, "org.openobex.Error.ConnectionAttemptFailed") && is_palm_device(option_device)) {
+			message = g_strdup (_("Make sure that remote device is on and that it accepts Bluetooth connections."));
+		} else {
+			message = g_strdup(error->message);
+		}
+	} else
+		message = g_strdup(_("An unknown error occured"));
+
+	return message;
+}
+
 static void create_notify(DBusGProxy *proxy,
 				DBusGProxyCall *call, void *user_data)
 {
@@ -323,12 +353,9 @@ static void create_notify(DBusGProxy *pr
 						G_TYPE_INVALID) == FALSE) {
 		gchar *text, *message;
 
-		if (error != NULL) {
-			message = g_strdup(error->message);
+		message = get_error_message(error);
+		if (error != NULL)
 			g_error_free(error);
-		} else
-			message = g_strdup(_("An unknown error occured"));
-
 		text = g_strdup_printf("<span foreground=\"red\">%s</span>",
 								message);
 		gtk_label_set_markup(GTK_LABEL(label_status), text);

--=-MWe2Ygrw2M1dbZmYL3Of
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-MWe2Ygrw2M1dbZmYL3Of
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-MWe2Ygrw2M1dbZmYL3Of--
