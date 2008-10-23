Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix incorrect device name in the wizard
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-WBdOM2P0GQ+Gc7LwVBjo"
Date: Thu, 23 Oct 2008 22:40:58 +0100
Message-Id: <1224798058.2895.209.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-WBdOM2P0GQ+Gc7LwVBjo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When the device is selected in the list before its name is resolved,
the device name in the checks as well as the final page of the wizard
will be wrong.

Attached patch should fix that.

--=-WBdOM2P0GQ+Gc7LwVBjo
Content-Disposition: attachment; filename="0001-Fix-incorrect-device-name-in-the-wizard.patch"
Content-Type: text/x-patch; name="0001-Fix-incorrect-device-name-in-the-wizard.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 3ee1953501e1a64aba62405d63fde893a6a609ba Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 23 Oct 2008 22:30:11 +0100
Subject: [PATCH] Fix incorrect device name in the wizard

When the device is selected in the list before its name is resolved,
the device name in the checks as well as the final page of the wizard
will be wrong.
---
 wizard/main.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index b1b944b..6f0b035 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -193,7 +193,28 @@ static void prepare_callback(GtkWidget *assistant,
 		bluetooth_client_stop_discovery(client);
 
 	if (page == page_setup) {
-		gchar *text, *markup;
+		GtkTreeModel *model;
+		GtkTreeIter iter;
+		gchar *text, *markup, *address, *name;
+		guint type;
+
+		/* Get the info about the device now,
+		 * we can't get here without a valid selection */
+		if (gtk_tree_selection_get_selected(search_selection, &model, &iter) == FALSE)
+			g_assert_not_reached();
+
+		gtk_tree_model_get(model, &iter,
+				BLUETOOTH_COLUMN_ADDRESS, &address,
+				BLUETOOTH_COLUMN_ALIAS, &name,
+				BLUETOOTH_COLUMN_TYPE, &type, -1);
+
+		g_free(target_address);
+		target_address = address;
+
+		g_free(target_name);
+		target_name = name;
+
+		target_type = type;
 
 		text = g_strdup_printf(_("Connecting to %s now ..."),
 								target_name);
@@ -353,30 +374,17 @@ static void select_callback(GtkTreeSelection *selection, gpointer user_data)
 	GtkAssistant *assistant = user_data;
 	GtkTreeModel *model;
 	GtkTreeIter iter;
-	gboolean selected;
 	gboolean paired = FALSE;
-	gchar *address, *name;
-	guint type;
+	gboolean selected;
 
 	selected = gtk_tree_selection_get_selected(selection, &model, &iter);
 
 	if (selected == TRUE) {
 		gtk_tree_model_get(model, &iter,
-				BLUETOOTH_COLUMN_PAIRED, &paired,
-				BLUETOOTH_COLUMN_ADDRESS, &address,
-				BLUETOOTH_COLUMN_ALIAS, &name,
-				BLUETOOTH_COLUMN_TYPE, &type, -1);
+				BLUETOOTH_COLUMN_PAIRED, &paired, -1);
 
 		if (paired == TRUE)
 			selected = FALSE;
-
-		g_free(target_address);
-		target_address = address;
-
-		g_free(target_name);
-		target_name = name;
-
-		target_type = type;
 	}
 
 	gtk_assistant_set_page_complete(assistant, page_search, selected);
-- 
1.6.0.3


--=-WBdOM2P0GQ+Gc7LwVBjo--

