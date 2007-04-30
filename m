Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 30 Apr 2007 21:38:18 +0200
References: <1177946201.5443.59.camel@hammer.suse.cz>
In-Reply-To: <1177946201.5443.59.camel@hammer.suse.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qWkNG7igX6vn/Gi"
Message-Id: <200704302138.18170.dgollub@suse.de>
Subject: Re: [Bluez-devel] bluez-gnome: No GUI way to switch from "off" mode
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_qWkNG7igX6vn/Gi
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 30 April 2007 17:16:41 Stanislav Brabec wrote:
> Hallo.
>
> I am just curious, whether no chance to enable Bluetooth from the GNOME
> Bluetooth is deliberate or not. I guess, that it is not deliberate.
Not quite sure if this was intended or not ... attachted is the suggested 
change by Stanislav.

best regards,
Daniel

--Boundary-00=_qWkNG7igX6vn/Gi
Content-Type: text/x-diff; charset="iso-8859-2";
	name="bluez-gnome_modeoff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-gnome_modeoff.diff"

? properties/.deps
? properties/Makefile
? properties/Makefile.in
? properties/bluetooth-properties
? properties/bluetooth-properties.desktop
Index: properties/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/main.c,v
retrieving revision 1.33
diff -u -p -r1.33 main.c
--- properties/main.c	26 Feb 2007 10:46:50 -0000	1.33
+++ properties/main.c	30 Apr 2007 19:37:59 -0000
@@ -757,6 +757,7 @@ struct adapter_data {
 	char *path;
 	int attached;
 	GtkWidget *child;
+	GtkWidget *button_off;
 	GtkWidget *button_connect;
 	GtkWidget *button_visible;
 	GtkWidget *timeout_label;
@@ -817,6 +818,9 @@ static void mode_callback(GtkWidget *but
 	} else if (button == adapter->button_visible) {
 		sensitive = TRUE;
 		mode = "discoverable";
+	} else if (button == adapter->button_off) {
+		sensitive = FALSE;
+		mode = "off";
 	} else
 		return;
 
@@ -981,14 +985,26 @@ static void create_adapter(struct adapte
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
 	button = gtk_radio_button_new_with_label(group,
-					_("Other devices can connect"));
+					_("Off. No devices can connect"));
 
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
 
 	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "off"))
-		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
+		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
+
+	adapter->button_off = button;
+
+	g_signal_connect(G_OBJECT(button), "toggled",
+					G_CALLBACK(mode_callback), adapter);
+
+	button = gtk_radio_button_new_with_label(group,
+					_("Other devices can connect"));
+
+	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
+
+	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
 
 	if (mode && !strcmp(mode, "connectable"))
 		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
@@ -1005,9 +1021,6 @@ static void create_adapter(struct adapte
 
 	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
 
-	if (mode && !strcmp(mode, "off"))
-		gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
-
 	if (mode && !strcmp(mode, "discoverable"))
 		gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
 
@@ -1125,15 +1138,14 @@ static void mode_changed(DBusGProxy *obj
 	if (list && list->data) {
 		struct adapter_data *adapter = list->data;
 		GtkWidget *button = NULL;
-		gboolean sensitive;
+		gboolean sensitive = TRUE;
 
 		if (!adapter->attached)
 			return;
 
-		sensitive = strcmp(mode, "off") ? TRUE : FALSE;
-
 		gtk_widget_set_sensitive(GTK_WIDGET(adapter->button_connect), sensitive);
 		gtk_widget_set_sensitive(GTK_WIDGET(adapter->button_visible), sensitive);
+		gtk_widget_set_sensitive(GTK_WIDGET(adapter->button_off), sensitive);
 
 		if (!strcmp(mode, "connectable")) {
 			sensitive = FALSE;
@@ -1141,6 +1153,9 @@ static void mode_changed(DBusGProxy *obj
 		} else if (!strcmp(mode, "discoverable")) {
 			sensitive = TRUE;
 			button = adapter->button_visible;
+		} else if (!strcmp(mode, "off")) {
+			sensitive = FALSE;
+			button = adapter->button_off;
 		}
 
 		gtk_widget_set_sensitive(GTK_WIDGET(adapter->timeout_label), sensitive);

--Boundary-00=_qWkNG7igX6vn/Gi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_qWkNG7igX6vn/Gi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_qWkNG7igX6vn/Gi--
