Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602170645o1875b413h641fb4f7af364613@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7530_28874379.1140187532560"
Subject: [Bluez-devel] [DBUS PATCH] main loop bug fix - remove watches
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 17 Feb 2006 12:45:32 -0200

------=_Part_7530_28874379.1140187532560
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,


Here is the patch to fix the problem I told you in the last e-mail.
The g_io_remove_watch was wrong and I fixed some leaks too.

Now we can handle the D-Bus Disconnect signal properly.

Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_7530_28874379.1140187532560
Content-Type: text/x-patch; name=watches01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejsfk2ju
Content-Disposition: attachment; filename="watches01.patch"

--- bluez-utils-cvs.orig/common/glib-ectomy.c	2006-02-16 09:17:41.000000000 -0200
+++ bluez-utils-cvs-watches/common/glib-ectomy.c	2006-02-17 09:20:15.000000000 -0200
@@ -92,7 +92,7 @@
 {
 	struct watch *w, *p;
 
-	for (p = &watch_head, w = watch_head.next; w; w = w->next)
+	for (p = &watch_head, w = watch_head.next; w; p = w, w = w->next)
 		if (w->id == id) {
 			p->next = w->next;
 			free (w);
@@ -181,5 +181,12 @@
 
 void g_main_loop_quit(GMainLoop *loop)
 {
+	struct watch *w;
+
 	loop->bail = 1;
+
+	for (w = watch_head.next; w; w = w->next) {
+		watch_head.next = w->next;
+		free (w);
+	}
 }
--- bluez-utils-cvs.orig/hcid/security.c	2006-02-16 09:17:41.000000000 -0200
+++ bluez-utils-cvs-watches/hcid/security.c	2006-02-17 09:26:03.000000000 -0200
@@ -51,7 +51,12 @@
 #include "hcid.h"
 #include "lib.h"
 
-static GIOChannel *io_chan[HCI_MAX_DEV];
+struct g_io_info {
+	GIOChannel	*channel;
+	int		watch_id;
+};
+static struct g_io_info io_data[HCI_MAX_DEV];
+
 
 static int pairing;
 
@@ -701,7 +706,7 @@
 
 void start_security_manager(int hdev)
 {
-	GIOChannel *chan = io_chan[hdev];
+	GIOChannel *chan = io_data[hdev].channel;
 	struct hci_dev_info *di;
 	struct hci_filter flt;
 	read_stored_link_key_cp cp;
@@ -761,10 +766,10 @@
 	}
 
 	chan = g_io_channel_unix_new(dev);
-	g_io_add_watch(chan, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
-			io_security_event, (void *) di);
+	io_data[hdev].watch_id = g_io_add_watch(chan, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+						io_security_event, (void *) di);
 
-	io_chan[hdev] = chan;
+	io_data[hdev].channel = chan;
 
 	if (hci_test_bit(HCI_RAW, &di->flags))
 		return;
@@ -778,7 +783,7 @@
 
 void stop_security_manager(int hdev)
 {
-	GIOChannel *chan = io_chan[hdev];
+	GIOChannel *chan = io_data[hdev].channel;
 
 	if (!chan)
 		return;
@@ -789,7 +794,9 @@
 	   loop to call us right back with G_IO_NVAL set, at which
 	   point we will see it and clean things up */
 	close(g_io_channel_unix_get_fd(chan));
-	io_chan[hdev] = NULL;
+	g_io_remove_watch(io_data[hdev].watch_id);
+	io_data[hdev].watch_id = -1;
+	io_data[hdev].channel = NULL;
 }
 
 void init_security_data(void)
--- bluez-utils-cvs.orig/hcid/main.c	2006-02-16 09:17:41.000000000 -0200
+++ bluez-utils-cvs-watches/hcid/main.c	2006-02-17 07:06:38.000000000 -0200
@@ -666,6 +666,7 @@
 	set_title("processing events");
 
 	ctl_io = g_io_channel_unix_new(hcid.sock);
+
 	g_io_add_watch(ctl_io, G_IO_IN, io_stack_event, NULL);
 
 	/* Start event processor */


------=_Part_7530_28874379.1140187532560--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
