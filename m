Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-JO2OP8DjGYdDhrHnE+Tt"
Date: Tue, 24 Jul 2007 17:31:30 +0100
Message-Id: <1185294690.3641.145.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] wizard fixes
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


--=-JO2OP8DjGYdDhrHnE+Tt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Some small fixes for the wizard.

- Search on all the adapters, rather than just the first one
- Clean up the user-visible strings
- Translate the "Device" column

We should probably use the device selector when it's closer to ready.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-JO2OP8DjGYdDhrHnE+Tt
Content-Disposition: attachment; filename=bluez-gnome-wizard-fixes.patch
Content-Type: text/x-patch; name=bluez-gnome-wizard-fixes.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/wizard/main.c b/wizard/main.c
index 9175512..1d686c3 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -112,12 +112,12 @@ static void cancel_callback(GtkWidget *assistant, gpointer data)
 static void prepare_callback(GtkWidget *assistant, GtkWidget *page, gpointer data)
 {
 	if (page == page_search) {
-		bluetooth_client_discover_devices(client, "/org/bluez/hci0");
+		bluetooth_client_discover_devices(client, NULL);
 		return;
 	}
 
 	if (page == page_pairing) {
-		bluetooth_client_cancel_discovery(client, "/org/bluez/hci0");
+		bluetooth_client_cancel_discovery(client, NULL);
 
 		bluetooth_client_register_passkey_agent(client,
 					"/org/bluez/applet", address,
@@ -242,7 +242,7 @@ static void create_type(GtkWidget *assistant)
 
 	vbox = create_vbox(assistant, GTK_ASSISTANT_PAGE_CONTENT,
 				_("Device type"),
-				_("Select type of device you wanna setup"));
+				_("Select the type of device you want to setup"));
 
 	button = gtk_radio_button_new_with_label(group, _("Mouse"));
 
@@ -389,7 +389,7 @@ static void create_search(GtkWidget *assistant)
 
 	vbox = create_vbox(assistant, GTK_ASSISTANT_PAGE_CONTENT,
 				_("Device search"),
-				_("Select device you wanna setup"));
+				_("Select the device you want to setup"));
 
 	scrolled = gtk_scrolled_window_new(NULL, NULL);
 
@@ -411,7 +411,7 @@ static void create_search(GtkWidget *assistant)
 
 	column = gtk_tree_view_column_new();
 
-	gtk_tree_view_column_set_title(column, "Device");
+	gtk_tree_view_column_set_title(column, _("Device"));
 
 	renderer = gtk_cell_renderer_pixbuf_new();
 	gtk_tree_view_column_set_spacing(column, 4);
@@ -434,7 +434,7 @@ static void create_search(GtkWidget *assistant)
 					"Type", gtk_cell_renderer_text_new(),
 						type_to_text, NULL, NULL);
 
-	model = bluetooth_client_get_model_for_adapter(client, "/org/bluez/hci0");
+	model = bluetooth_client_get_model_for_adapter(client, NULL);
 
 	gtk_tree_view_set_model(GTK_TREE_VIEW(tree), model);
 

--=-JO2OP8DjGYdDhrHnE+Tt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-JO2OP8DjGYdDhrHnE+Tt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-JO2OP8DjGYdDhrHnE+Tt--
