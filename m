Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-5RMeusiD05geDcKVFCmL"
Date: Sun, 06 Jul 2008 16:06:18 +0100
Message-Id: <1215356778.13854.4.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Input setup crash fix, and crash bug report
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


--=-5RMeusiD05geDcKVFCmL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Using current CVS of bluez-{libs,utils,gnome}, and trying to pair an
input device will crash.

First, we never check whether the service is running, so the manager is
never set in input.c. The attached patch fixes that.

Later on, we pass garbage to dbus_g_proxy_new_for_name() when the call
to CreateSecureDevice fails. I've added a check for the retval, but it
obviously doesn't fix the problem.

Any ideas why it would say:
** (bluetooth-properties:16409): WARNING **: dbus_g_proxy_end_call()
failed in proxy_callback: Authentication failed (CreateBonding)

I get the pairing prompt on my computer, and it usually crashes when I
have to enter the PIN on my phone.

Cheers

--=-5RMeusiD05geDcKVFCmL
Content-Disposition: attachment; filename=bluez-gnome-input-no-crash.patch
Content-Type: text/x-patch; name=bluez-gnome-input-no-crash.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: input.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/input.c,v
retrieving revision 1.13
diff -u -p -r1.13 input.c
--- input.c	2 Feb 2008 04:09:43 -0000	1.13
+++ input.c	6 Jul 2008 15:01:15 -0000
@@ -49,6 +49,7 @@ static GtkWidget *button_remove;
 static void proxy_callback(DBusGProxy *proxy,
 				DBusGProxyCall *call, void *user_data)
 {
+	GError *error = NULL;
 	GtkWidget *notebook = user_data;
 	GtkWidget *button;
 	GtkWidget *label;
@@ -59,8 +60,12 @@ static void proxy_callback(DBusGProxy *p
 
 	g_object_set_data(G_OBJECT(notebook), "call", NULL);
 
-	dbus_g_proxy_end_call(proxy, call, NULL,
-				G_TYPE_STRING, &path, G_TYPE_INVALID);
+	if (dbus_g_proxy_end_call(proxy, call, &error,
+				G_TYPE_STRING, &path, G_TYPE_INVALID) == FALSE) {
+		g_warning ("dbus_g_proxy_end_call() failed in proxy_callback: %s", error->message);
+		g_error_free (error);
+		return;
+	}
 
 	button = g_object_get_data(G_OBJECT(notebook), "cancel");
 	gtk_widget_hide(button);
Index: service.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/service.c,v
retrieving revision 1.14
diff -u -p -r1.14 service.c
--- service.c	25 Jun 2008 20:38:06 -0000	1.14
+++ service.c	6 Jul 2008 15:01:15 -0000
@@ -316,6 +316,9 @@ done:
 	gtk_list_store_insert_with_values(service_store, &service->iter, -1,
 			COLUMN_PATH, path, COLUMN_IDENT, identifier, -1);
 
+	dbus_g_proxy_call(object, "IsRunning", NULL, G_TYPE_INVALID,
+			  G_TYPE_BOOLEAN, &running, G_TYPE_INVALID);
+
 	if (running == TRUE)
 		service_started(object, service);
 }

--=-5RMeusiD05geDcKVFCmL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--=-5RMeusiD05geDcKVFCmL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-5RMeusiD05geDcKVFCmL--
