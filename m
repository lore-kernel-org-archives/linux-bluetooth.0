Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-x0QJY/3n7+FKzu6gBMWy"
Date: Mon, 20 Aug 2007 13:17:10 +0100
Message-Id: <1187612230.26239.79.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Better startup under KDE
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


--=-x0QJY/3n7+FKzu6gBMWy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This patch comes from a KDE user via:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=247284

This makes the bluetooth applet startup after the panel, and disable
startup notification (as it doesn't support it).

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-x0QJY/3n7+FKzu6gBMWy
Content-Disposition: attachment;
	filename=bluez-gnome-applet-better-kde-startup.patch
Content-Type: text/x-patch; name=bluez-gnome-applet-better-kde-startup.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: applet/bluetooth-applet.desktop.in
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/bluetooth-applet.desktop.in,v
retrieving revision 1.1
diff -u -p -r1.1 bluetooth-applet.desktop.in
--- applet/bluetooth-applet.desktop.in	3 Apr 2007 08:09:01 -0000	1.1
+++ applet/bluetooth-applet.desktop.in	20 Aug 2007 12:15:12 -0000
@@ -8,3 +8,5 @@ Terminal=false
 Type=Application
 Categories=
 OnlyShowIn=GNOME;
+StartupNotify=false
+X-KDE-autostart-after=panel

--=-x0QJY/3n7+FKzu6gBMWy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-x0QJY/3n7+FKzu6gBMWy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-x0QJY/3n7+FKzu6gBMWy--
