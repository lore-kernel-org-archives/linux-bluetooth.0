Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-mWaZoB0Ym9kMW9Tw970r"
Date: Wed, 30 Apr 2008 09:42:39 +0200
Message-Id: <1209541359.31036.35.camel@pancake>
Mime-Version: 1.0
Subject: [Bluez-devel] bluez-gnome and OBEX DBus names
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


--=-mWaZoB0Ym9kMW9Tw970r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm running bluez-gnome 0.26 and obex-data-server 0.3 from Gentoo. My
Bluetooth setup is running fine, with the exception of OBEX reception.
When I start the bluetooth-applet from a shell, I get the warning
"Bluetooth OBEX start failed: Invalid path". A bit of dbus-monitoring
shows that this error comes from the OBEX server:

method call sender=:1.96 -> dest=org.openobex
path=/org/openobex/server1; interface=org.openobex.Server; member=Start
   string ""
   boolean true
   boolean true

error sender=:1.94 -> dest=:1.96
error_name=org.openobex.Error.InvalidArguments reply_serial=16
   string "Invalid path"

A look in ods-server.c shows that it's testing for the first parameter
of the method call to be an existing directory, but the bluetooth-applet
is passing an empty string.. and this is because the applet uses
g_get_user_special_dir(G_USER_DIRECTORY_PUBLIC_SHARE) and
g_get_user_special_dir(G_USER_DIRECTORY_DOWNLOAD) to retrieve the
directory names.

So, I now have one suggestion - see the attached patch, two small error
checks to make debugging this _much_ easier - and one question:

how is the average user (yes, there are such things now ;-) expected to
know how to set these *!$%& directories? I needed 20 minutes of glib
source diving to find the relevant code - why doesn't Gnome, e.g., set
this automatically?

Thanks, Yours, Florian
-- 
0666 - Filemode of the Beast

--=-mWaZoB0Ym9kMW9Tw970r
Content-Disposition: attachment; filename=bluez-gnome-0.26-patch
Content-Type: text/x-patch; name=bluez-gnome-0.26-patch; charset=utf8
Content-Transfer-Encoding: 7bit

diff -ur applet-old/obex.c applet/obex.c
--- applet-old/obex.c	2008-04-30 09:29:57.000000000 +0200
+++ applet/obex.c	2008-04-30 09:30:28.000000000 +0200
@@ -139,6 +139,9 @@
 
 	dir = g_get_user_special_dir(G_USER_DIRECTORY_DOWNLOAD);
 
+	if (!dir)
+		g_printerr("Warning: G_USER_DIRECTORY_DOWNLOAD not set - check ~/.config/user-dirs.dirs!");
+
 	dbus_g_proxy_begin_call(opp_server, "Start",
 				start_opp_notify, NULL, NULL,
 				G_TYPE_STRING, dir,
@@ -206,6 +209,9 @@
 
 	dir = g_get_user_special_dir(G_USER_DIRECTORY_PUBLIC_SHARE);
 
+	if (!dir)
+		g_printerr("Warning: G_USER_DIRECTORY_PUBLIC_SHARE not set - check ~/.config/user-dirs.dirs!");
+
 	dbus_g_proxy_begin_call(ftp_server, "Start",
 				start_ftp_notify, NULL, NULL,
 				G_TYPE_STRING, dir,

--=-mWaZoB0Ym9kMW9Tw970r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-mWaZoB0Ym9kMW9Tw970r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-mWaZoB0Ym9kMW9Tw970r--
