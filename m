Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Xw1LakYWH4Vlq0hW+CSW"
Date: Thu, 26 Jul 2007 11:08:59 +0100
Message-Id: <1185444539.3641.278.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Fix sensitivity in the wizard
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


--=-Xw1LakYWH4Vlq0hW+CSW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

- Go to the device selection page
- Select a device (next button is sensitive)
- Unselect device (using Ctrl+Click) button stays sensitive

I also switched to using the signal instead of the property, removes a
bit of code.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-Xw1LakYWH4Vlq0hW+CSW
Content-Disposition: attachment;
	filename=bluez-gnome-fix-selection-sensitivity.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-selection-sensitivity.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/wizard/main.c,v
retrieving revision 1.18
diff -u -p -r1.18 main.c
--- main.c	26 Jul 2007 08:05:40 -0000	1.18
+++ main.c	26 Jul 2007 10:06:21 -0000
@@ -294,13 +294,10 @@ static void create_type(GtkWidget *assis
 	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
 }
 
-static void select_callback(GObject *object,
-				GParamSpec *spec, gpointer user_data)
+static void select_callback(BluetoothDeviceSelection *sel,
+				gchar *selected, gpointer user_data)
 {
 	GtkAssistant *assistant = user_data;
-	gchar *selected;
-
-	g_object_get(object, "device-selected", &selected, NULL);
 
 	if (selected != NULL) {
 		g_free(address);
@@ -309,9 +306,7 @@ static void select_callback(GObject *obj
 
 		gtk_assistant_set_page_complete(assistant, page_search, TRUE);
 	} else
-		gtk_assistant_set_page_complete(assistant, page_search, TRUE);
-
-	g_free(selected);
+		gtk_assistant_set_page_complete(assistant, page_search, FALSE);
 }
 
 static void create_search(GtkWidget *assistant)
@@ -325,7 +320,7 @@ static void create_search(GtkWidget *ass
 
 	selector = bluetooth_device_selection_new(NULL);
 
-	g_signal_connect(selector, "notify::device-selected",
+	g_signal_connect(selector, "selected-device-changed",
 				G_CALLBACK(select_callback), assistant);
 
 	gtk_container_add(GTK_CONTAINER(vbox), selector);

--=-Xw1LakYWH4Vlq0hW+CSW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-Xw1LakYWH4Vlq0hW+CSW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Xw1LakYWH4Vlq0hW+CSW--
