Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] Better buttons in adapter properties
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wi3idaFDI4YrJT2qcQk8"
Date: Tue, 14 Oct 2008 18:02:36 +0100
Message-Id: <1224003756.5268.371.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-wi3idaFDI4YrJT2qcQk8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Before:
http://img369.imageshack.us/my.php?image=screenshotbluetoothprefoa6.png
After:
http://img233.imageshack.us/my.php?image=screenshotbluetoothprefby0.png

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=465398 (No labels in
buttons)
http://bugzilla.gnome.org/show_bug.cgi?id=505606 (trust toggle button
appears/disappears)
And the discussion that were recently made on the list about having a
shorter dialogue for EeePCs.

--=-wi3idaFDI4YrJT2qcQk8
Content-Disposition: attachment; filename="0001-Fixes-for-adapter-specific-buttons.patch"
Content-Type: text/x-patch; name="0001-Fixes-for-adapter-specific-buttons.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a394c15d8d1f904bbd4399aa2b7baf8db40d5b4c Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 14 Oct 2008 16:08:23 +0100
Subject: [PATCH] Fixes for adapter specific buttons

- Add labels to the adapter buttons, otherwise people
wonder what each one is for.

- Always show the buttons, just make sure they're
disabled if no devices is selected.

- Remove the difference in look for the extra buttons
---
 properties/adapter.c |   43 +++++++++++++------------------------------
 1 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/properties/adapter.c b/properties/adapter.c
index 7ace35b..9de10e7 100644
--- a/properties/adapter.c
+++ b/properties/adapter.c
@@ -246,15 +246,8 @@ static void select_callback(GtkTreeSelection *selection, gpointer user_data)
 
 	update_buttons(adapter, paired, trusted, connected);
 
-	if (selected == TRUE) {
-		gtk_widget_show(adapter->button_disconnect);
-		gtk_widget_show(adapter->button_trusted);
-		gtk_widget_show(adapter->button_delete);
-	} else {
-		gtk_widget_hide(adapter->button_disconnect);
-		gtk_widget_hide(adapter->button_trusted);
-		gtk_widget_hide(adapter->button_delete);
-	}
+	gtk_widget_set_sensitive(adapter->button_trusted, selected);
+	gtk_widget_set_sensitive(adapter->button_delete, selected);
 }
 
 static void row_callback(GtkTreeModel *model, GtkTreePath  *path,
@@ -646,61 +639,51 @@ static void create_adapter(struct adapter_data *adapter)
 	gtk_box_set_homogeneous(GTK_BOX(buttonbox), FALSE);
 	gtk_box_pack_start(GTK_BOX(vbox), buttonbox, FALSE, FALSE, 0);
 
-	button = gtk_button_new();
+	button = gtk_button_new_with_label(_("Setup new device..."));
 	image = gtk_image_new_from_stock(GTK_STOCK_ADD,
 						GTK_ICON_SIZE_BUTTON);
-	gtk_container_add(GTK_CONTAINER(button), image);
-	gtk_container_set_border_width(GTK_CONTAINER(button), 0);
+	gtk_button_set_image(GTK_BUTTON(button), image);
 	gtk_box_pack_start(GTK_BOX(buttonbox), button, FALSE, FALSE, 0);
 
 	g_signal_connect(G_OBJECT(button), "clicked",
 				G_CALLBACK(wizard_callback), adapter);
 
-	button = gtk_button_new();
-	gtk_button_set_relief(GTK_BUTTON(button), GTK_RELIEF_NONE);
+	button = gtk_button_new_with_label(_("Disconnect"));
 	image = gtk_image_new_from_stock(GTK_STOCK_DISCONNECT,
 						GTK_ICON_SIZE_BUTTON);
-	gtk_container_add(GTK_CONTAINER(button), image);
-	gtk_container_set_border_width(GTK_CONTAINER(button), 0);
-	gtk_widget_set_no_show_all(button, TRUE);
-	gtk_widget_show(image);
+	gtk_button_set_image(GTK_BUTTON(button), image);
 	gtk_box_pack_end(GTK_BOX(buttonbox), button, FALSE, FALSE, 0);
 	gtk_button_box_set_child_secondary(GTK_BUTTON_BOX(buttonbox),
 								button, TRUE);
+	gtk_widget_set_sensitive(button, FALSE);
 
 	g_signal_connect(G_OBJECT(button), "clicked",
 				G_CALLBACK(disconnect_callback), adapter);
 
 	adapter->button_disconnect = button;
 
-	button = gtk_button_new();
-	gtk_button_set_relief(GTK_BUTTON(button), GTK_RELIEF_NONE);
+	button = gtk_button_new_with_label(_("Add to Trusted"));
 	image = gtk_image_new_from_stock(GTK_STOCK_ABOUT,
 						GTK_ICON_SIZE_BUTTON);
-	gtk_container_add(GTK_CONTAINER(button), image);
-	gtk_container_set_border_width(GTK_CONTAINER(button), 0);
-	gtk_widget_set_no_show_all(button, TRUE);
-	gtk_widget_show(image);
+	gtk_button_set_image(GTK_BUTTON(button), image);
 	gtk_box_pack_end(GTK_BOX(buttonbox), button, FALSE, FALSE, 0);
 	gtk_button_box_set_child_secondary(GTK_BUTTON_BOX(buttonbox),
 								button, TRUE);
+	gtk_widget_set_sensitive(button, FALSE);
 
 	g_signal_connect(G_OBJECT(button), "clicked",
 				G_CALLBACK(trusted_callback), adapter);
 
 	adapter->button_trusted = button;
 
-	button = gtk_button_new();
-	gtk_button_set_relief(GTK_BUTTON(button), GTK_RELIEF_NONE);
+	button = gtk_button_new_with_label(_("Delete"));
 	image = gtk_image_new_from_stock(GTK_STOCK_DELETE,
 						GTK_ICON_SIZE_BUTTON);
-	gtk_container_add(GTK_CONTAINER(button), image);
-	gtk_container_set_border_width(GTK_CONTAINER(button), 0);
-	gtk_widget_set_no_show_all(button, TRUE);
-	gtk_widget_show(image);
+	gtk_button_set_image(GTK_BUTTON(button), image);
 	gtk_box_pack_end(GTK_BOX(buttonbox), button, FALSE, FALSE, 0);
 	gtk_button_box_set_child_secondary(GTK_BUTTON_BOX(buttonbox),
 								button, TRUE);
+	gtk_widget_set_sensitive(button, FALSE);
 
 	g_signal_connect(G_OBJECT(button), "clicked",
 				G_CALLBACK(delete_callback), adapter);
-- 
1.5.5.2


--=-wi3idaFDI4YrJT2qcQk8
Content-Disposition: attachment; filename="0002-Move-the-adapter-button-list-to-the-side.patch"
Content-Type: text/x-patch; name="0002-Move-the-adapter-button-list-to-the-side.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 161b2023faa95b6d777c3cbaac902365548babf3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 14 Oct 2008 17:37:51 +0100
Subject: [PATCH] Move the adapter button list to the side

This makes the dialogue wider, rather than tall, which is
useful for computers with small displays.
---
 properties/adapter.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/properties/adapter.c b/properties/adapter.c
index 9de10e7..0174716 100644
--- a/properties/adapter.c
+++ b/properties/adapter.c
@@ -437,6 +437,7 @@ static void create_adapter(struct adapter_data *adapter)
 
 	GtkWidget *mainbox;
 	GtkWidget *vbox;
+	GtkWidget *table;
 	GtkWidget *label;
 	GtkWidget *image;
 	GtkWidget *button;
@@ -602,18 +603,20 @@ static void create_adapter(struct adapter_data *adapter)
 	g_signal_connect(G_OBJECT(entry), "focus-out-event",
 					G_CALLBACK(focus_callback), adapter);
 
-	vbox = gtk_vbox_new(FALSE, 6);
-	gtk_box_pack_start(GTK_BOX(mainbox), vbox, TRUE, TRUE, 0);
+	table = gtk_table_new(2, 2, FALSE);
+	gtk_box_pack_start(GTK_BOX(mainbox), table, TRUE, TRUE, 0);
 
 	label = create_label(_("Known devices"));
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	gtk_table_attach(GTK_TABLE(table), label, 0, 2, 0, 1,
+			 GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 0, 6);
 
 	scrolled = gtk_scrolled_window_new(NULL, NULL);
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled),
 				GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
 	gtk_scrolled_window_set_shadow_type(GTK_SCROLLED_WINDOW(scrolled),
 							GTK_SHADOW_OUT);
-	gtk_container_add(GTK_CONTAINER(vbox), scrolled);
+	gtk_table_attach(GTK_TABLE(table), scrolled, 0, 1, 1, 2,
+			 GTK_EXPAND | GTK_FILL, GTK_EXPAND | GTK_FILL, 6, 6);
 
 	model = bluetooth_client_get_device_filter_model(client,
 				adapter->proxy, device_filter, NULL, NULL);
@@ -632,12 +635,13 @@ static void create_adapter(struct adapter_data *adapter)
 
 	gtk_container_add(GTK_CONTAINER(scrolled), tree);
 
-	buttonbox = gtk_hbutton_box_new();
+	buttonbox = gtk_vbutton_box_new();
 	gtk_button_box_set_layout(GTK_BUTTON_BOX(buttonbox),
 						GTK_BUTTONBOX_START);
 	gtk_box_set_spacing(GTK_BOX(buttonbox), 6);
 	gtk_box_set_homogeneous(GTK_BOX(buttonbox), FALSE);
-	gtk_box_pack_start(GTK_BOX(vbox), buttonbox, FALSE, FALSE, 0);
+	gtk_table_attach(GTK_TABLE(table), buttonbox, 1, 2, 1, 2,
+			 GTK_FILL, GTK_FILL, 6, 6);
 
 	button = gtk_button_new_with_label(_("Setup new device..."));
 	image = gtk_image_new_from_stock(GTK_STOCK_ADD,
-- 
1.5.5.2


--=-wi3idaFDI4YrJT2qcQk8
Content-Disposition: attachment; filename="0003-Fix-trust-button.patch"
Content-Type: text/x-patch; name="0003-Fix-trust-button.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a99222b4c0b505f5a0fc2a564977bf3be71a6c86 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 14 Oct 2008 17:59:58 +0100
Subject: [PATCH] Fix trust button

The trust button toggles the trust for a device, so the label
should reflect the action to take when clicked. Changed the label
to "Trust"/"Distrust" to avoid the widgets moving about when
toggling the trust status.
---
 properties/adapter.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/properties/adapter.c b/properties/adapter.c
index 0174716..b744a20 100644
--- a/properties/adapter.c
+++ b/properties/adapter.c
@@ -216,6 +216,11 @@ static gboolean focus_callback(GtkWidget *editable,
 static void update_buttons(struct adapter_data *adapter, gboolean bonded,
 					gboolean trusted, gboolean connected)
 {
+	if (trusted) {
+		gtk_button_set_label(GTK_BUTTON(adapter->button_trusted), _("Distrust"));
+	} else {
+		gtk_button_set_label(GTK_BUTTON(adapter->button_trusted), _("Trust"));
+	}
 	gtk_widget_set_sensitive(adapter->button_delete, bonded);
 	gtk_widget_set_sensitive(adapter->button_disconnect, connected);
 }
@@ -666,7 +671,7 @@ static void create_adapter(struct adapter_data *adapter)
 
 	adapter->button_disconnect = button;
 
-	button = gtk_button_new_with_label(_("Add to Trusted"));
+	button = gtk_button_new_with_label(_("Trust"));
 	image = gtk_image_new_from_stock(GTK_STOCK_ABOUT,
 						GTK_ICON_SIZE_BUTTON);
 	gtk_button_set_image(GTK_BUTTON(button), image);
-- 
1.5.5.2


--=-wi3idaFDI4YrJT2qcQk8--

