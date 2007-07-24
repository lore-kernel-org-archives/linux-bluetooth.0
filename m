Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-fwsXees9SXqgoiP1GY7u"
Date: Tue, 24 Jul 2007 16:55:46 +0100
Message-Id: <1185292546.3641.121.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] bluez-gnome avoid popping up the notification
	in more cases
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


--=-fwsXees9SXqgoiP1GY7u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Another case in which we shouldn't popup the notification.

And a missing empty line.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-fwsXees9SXqgoiP1GY7u
Content-Disposition: attachment;
	filename=bluez-gnome-avoid-popups-in-more-cases.patch
Content-Type: text/x-patch; name=bluez-gnome-avoid-popups-in-more-cases.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.67
diff -u -p -r1.67 main.c
--- applet/main.c	24 Jul 2007 15:19:33 -0000	1.67
+++ applet/main.c	24 Jul 2007 15:53:33 -0000
@@ -1115,6 +1115,11 @@ static void mode_changed(DBusGProxy *obj
 			return;
 		}
 		if (g_str_equal(adapter->old_mode, "off")
+		    && g_str_equal(mode, "connectable")) {
+			set_new_mode(adapter, mode);
+			return;
+		}
+		if (g_str_equal(adapter->old_mode, "off")
 				&& g_str_equal(mode, "connectable")) {
 			set_new_mode(adapter, mode);
 			return;
@@ -1229,6 +1234,7 @@ static char *get_form_factor(void)
 
 	return formfactor;
 }
+
 static void adapter_setup(gpointer data, gpointer user_data)
 {
 	struct adapter_data *adapter = data;

--=-fwsXees9SXqgoiP1GY7u
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-fwsXees9SXqgoiP1GY7u
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-fwsXees9SXqgoiP1GY7u--
