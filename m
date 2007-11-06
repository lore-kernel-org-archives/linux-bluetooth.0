Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-c4BcCqvriZ7ue1zrHkCF"
Date: Tue, 06 Nov 2007 16:18:45 +0000
Message-Id: <1194365925.15726.19.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] allow the chooser widget to show search as an
	afterthought
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


--=-c4BcCqvriZ7ue1zrHkCF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

The current device selection widget doesn't allow to show the search
button after the widget has been created, which is a bit of a pain.

The attached patch shows the search button by default in the test
application and fixes the above problem.

Cheers

--=-c4BcCqvriZ7ue1zrHkCF
Content-Disposition: attachment;
	filename=bluez-gnome-allow-showing-search.patch
Content-Type: text/x-patch; name=bluez-gnome-allow-showing-search.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.9
diff -u -p -r1.9 bluetooth-device-selection.c
--- bluetooth-device-selection.c	9 Aug 2007 08:35:19 -0000	1.9
+++ bluetooth-device-selection.c	6 Nov 2007 16:16:12 -0000
@@ -313,11 +313,12 @@ bluetooth_device_selection_init(Bluetoot
 	g_signal_connect (G_OBJECT(priv->search_button), "clicked",
 			  G_CALLBACK(search_button_clicked), self);
 	gtk_box_pack_start (GTK_BOX(box), hbox, FALSE, FALSE, 0);
-	if (priv->show_search == TRUE)
-		gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
-				    FALSE, FALSE, 0);
+	gtk_widget_show_all (GTK_WIDGET (self));
 
-	gtk_widget_show_all (scrolled);
+	gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
+			    FALSE, FALSE, 0);
+	if (priv->show_search)
+		gtk_widget_show (priv->search_button);
 
 	bluetooth_device_selection_start_discovery (self);
 }
Index: test-deviceselection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-deviceselection.c,v
retrieving revision 1.2
diff -u -p -r1.2 test-deviceselection.c
--- test-deviceselection.c	25 Jul 2007 18:01:44 -0000	1.2
+++ test-deviceselection.c	6 Nov 2007 16:16:12 -0000
@@ -61,12 +61,14 @@ int main(int argc, char **argv)
 	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
 
 	selector = bluetooth_device_selection_new("Select a device to setup");
+	gtk_widget_show(selector);
+	g_object_set(selector, "show-search", TRUE, NULL);
 	g_signal_connect(selector, "selected-device-changed",
 			 G_CALLBACK(select_device_changed), dialog);
 	g_signal_connect(selector, "notify::device-selected",
 			 G_CALLBACK(device_selected_cb), dialog);
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
-	gtk_widget_show_all(dialog);
+	gtk_widget_show(dialog);
 
 	response = gtk_dialog_run(GTK_DIALOG(dialog));
 

--=-c4BcCqvriZ7ue1zrHkCF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-c4BcCqvriZ7ue1zrHkCF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-c4BcCqvriZ7ue1zrHkCF--
