Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190487435.5133.66.camel@aeonflux.holtmann.net>
References: <1190483342.7150.224.camel@pmac.infradead.org>
	<1190487435.5133.66.camel@aeonflux.holtmann.net>
Date: Sun, 23 Sep 2007 00:10:59 +0100
Message-Id: <1190502659.7150.268.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Claudio Takahasi <cktakahasi@gmail.com>
Subject: Re: [Bluez-devel] [PATCH] Attempt bonding with keyboards.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sat, 2007-09-22 at 20:57 +0200, Marcel Holtmann wrote:
> I think it should be part of the UI and it should create the pairing
> before connecting the input device.

In the meantime, this would at least let the user initiate bonding
'manually' through the GUI, without having to use hcitool.

diff --git a/properties/adapter.c b/properties/adapter.c
index b9109cb..17b3aba 100644
--- a/properties/adapter.c
+++ b/properties/adapter.c
@@ -71,7 +71,7 @@ struct adapter_data {
 	GtkWidget *timeout_scale;
 	GtkWidget *entry;
 	GtkWidget *combo;
-	GtkWidget *button_delete;
+	GtkWidget *button_bonding;
 	GtkWidget *button_trusted;
 	GtkWidget *button_disconnect;
 	GtkTreeSelection *selection;
@@ -248,7 +248,11 @@ static void update_buttons(struct adapter_data *adapter, gboolean bonded,
 		gtk_button_set_label(GTK_BUTTON(adapter->button_trusted),
 							_("Remove _Trust"));
 
-	gtk_widget_set_sensitive(adapter->button_delete, bonded);
+	gtk_widget_set_sensitive(adapter->button_bonding, 1);
+	if (bonded)
+		gtk_button_set_label(GTK_BUTTON(adapter->button_bonding), _("Delete _Bonding"));
+	else
+		gtk_button_set_label(GTK_BUTTON(adapter->button_bonding), _("Create _Bonding"));
 
 	gtk_widget_set_sensitive(adapter->button_disconnect, connected);
 }
@@ -270,10 +274,13 @@ static void select_callback(GtkTreeSelection *selection, gpointer user_data)
 
 	update_buttons(adapter, bonded, trusted, connected);
 
-	if (selected == TRUE)
+	if (selected == TRUE) {
 		gtk_widget_show(adapter->button_trusted);
-	else
+		gtk_widget_show(adapter->button_bonding);
+	} else {
 		gtk_widget_hide(adapter->button_trusted);
+		gtk_widget_hide(adapter->button_bonding);
+	}
 }
 
 static void row_callback(GtkTreeModel *model, GtkTreePath  *path,
@@ -293,21 +300,28 @@ static void row_callback(GtkTreeModel *model, GtkTreePath  *path,
 	update_buttons(adapter, bonded, trusted, connected);
 }
 
-static void delete_callback(GtkWidget *button, gpointer user_data)
+static void bonding_callback(GtkWidget *button, gpointer user_data)
 {
 	struct adapter_data *adapter = user_data;
 	GtkTreeModel *model;
 	GtkTreeIter iter;
 	gchar *address;
+	gboolean bonded;
 
 	if (gtk_tree_selection_get_selected(adapter->selection,
 						&model, &iter) == FALSE)
 		return;
 
-	gtk_tree_model_get(model, &iter, COLUMN_ADDRESS, &address, -1);
+	gtk_tree_model_get(model, &iter, COLUMN_ADDRESS, &address, 
+			   COLUMN_BONDED, &bonded, -1);
 
-	if (show_confirm_dialog() == TRUE)
-		bluetooth_client_remove_bonding(client, adapter->path, address);
+	if (bonded) {
+		if (show_confirm_dialog() == TRUE)
+			bluetooth_client_remove_bonding(client, adapter->path, address);
+	} else {
+		bluetooth_client_create_bonding(client, adapter->path, address);
+	}
+		
 
 	g_free(address);
 }
@@ -762,14 +776,14 @@ static void create_adapter(struct adapter_data *adapter)
 	gtk_box_set_homogeneous(GTK_BOX(buttonbox), FALSE);
 	gtk_box_pack_start(GTK_BOX(vbox), buttonbox, FALSE, FALSE, 0);
 
-	button = gtk_button_new_from_stock(GTK_STOCK_DELETE);
-	gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
+	button = gtk_button_new_with_mnemonic(NULL);
+	gtk_widget_set_no_show_all(button, TRUE);
 	gtk_container_add(GTK_CONTAINER(buttonbox), button);
 
 	g_signal_connect(G_OBJECT(button), "clicked",
-				G_CALLBACK(delete_callback), adapter);
+				G_CALLBACK(bonding_callback), adapter);
 
-	adapter->button_delete = button;
+	adapter->button_bonding = button;
 
 	button = gtk_button_new_with_mnemonic(NULL);
 	gtk_widget_set_no_show_all(button, TRUE);

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
