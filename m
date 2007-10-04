Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-zyMEYY5MGDPu0Qev7aNJ"
Date: Thu, 04 Oct 2007 16:27:35 +0100
Message-Id: <1191511655.3479.13.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Possible infinite loop in inotify code
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


--=-zyMEYY5MGDPu0Qev7aNJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Uli mentioned a possible infinite loop in some circumstances:
https://bugzilla.redhat.com/show_bug.cgi?id=235307

Although I wasn't able to reproduce the bug, the attached patch looks
technically correct.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-zyMEYY5MGDPu0Qev7aNJ
Content-Disposition: attachment;
	filename=bluez-utils-better-inotify-error.patch
Content-Type: text/x-patch; name=bluez-utils-better-inotify-error.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

? .deps
? .libs
? Makefile
? Makefile.in
? bluez-utils-better-inotify-error.patch
? test_textfile
Index: notify-inotify.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/notify-inotify.c,v
retrieving revision 1.8
diff -u -p -r1.8 notify-inotify.c
--- notify-inotify.c	16 Feb 2007 20:18:37 -0000	1.8
+++ notify-inotify.c	4 Oct 2007 15:23:55 -0000
@@ -60,14 +60,21 @@ static gboolean io_event(GIOChannel *cha
 	memset(buf, 0, sizeof(buf));
 
 	err = g_io_channel_read(chan, (gchar *) buf, sizeof(buf) - 1, &len);
-	if (err == G_IO_ERROR_AGAIN)
+	if (err == G_IO_STATUS_AGAIN) {
 		return TRUE;
+	} else if (err != G_IO_STATUS_NORMAL) {
+		error("Error reading from channel: No error given");
+		return FALSE;
+	}
 
 	while (len >= sizeof(struct inotify_event)) {
 		struct inotify_event *evt = (struct inotify_event *) ptr;
 
-		if (evt->wd != wd || !callback)
+		if (evt->wd != wd || !callback) {
+			len -= sizeof(struct inotify_event) + evt->len;
+			ptr += sizeof(struct inotify_event) + evt->len;
 			continue;
+		}
 
 		if (evt->mask & (IN_CREATE | IN_MOVED_TO))
 			callback(NOTIFY_CREATE, evt->name, NULL);

--=-zyMEYY5MGDPu0Qev7aNJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-zyMEYY5MGDPu0Qev7aNJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-zyMEYY5MGDPu0Qev7aNJ--
