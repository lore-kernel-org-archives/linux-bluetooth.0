Return-Path: <cyrus@holtmann.org>
From: Felipe Balbi <me@felipebalbi.com>
To: bluez-devel@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>, Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] properties: add radio button to turn bluetooth off
Date: Fri,  4 Jul 2008 02:02:33 +0300
Message-Id: <1215126153-29245-1-git-send-email-me@felipebalbi.com>
List-ID: <bluez-devel.lists.sourceforge.net>

There was no widget to turn bluetooth off. This patch
adds it.

There's actually another missing piece which would be
autosuspend support for hci_usb.c, without it hci_usb
will still be one of the biggest system wake-up source.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 properties/adapter.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/properties/adapter.c b/properties/adapter.c
index 7311068..843188f 100644
--- a/properties/adapter.c
+++ b/properties/adapter.c
@@ -66,6 +66,7 @@ struct adapter_data {
 	char *path;
 	int attached;
 	GtkWidget *child;
+	GtkWidget *button_on;
 	GtkWidget *button_connect;
 	GtkWidget *button_visible;
 	GtkWidget *button_limited;
@@ -125,10 +126,15 @@ static void mode_callback(GtkWidget *button, gpointer user_data)
 	DBusGProxy *object;
 	gboolean sensitive;
 
-	if (gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(button)) == FALSE)
+	if (gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(button)) == FALSE &&
+			button != adapter->button_on)
 		return;
 
-	if (button == adapter->button_connect) {
+	if (button == adapter->button_on) {
+		mode = gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(button))
+			? "on" : "off";
+		sensitive = FALSE;
+	} else if (button == adapter->button_connect) {
 		sensitive = FALSE;
 		mode = "connectable";
 	} else if (button == adapter->button_visible) {
@@ -585,6 +591,15 @@ static void create_adapter(struct adapter_data *adapter)
 	label = create_label(_("Mode of operation"));
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
 
+	button = gtk_check_button_new_with_label(_("Bluetooth on"));
+	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), 1);
+	gtk_box_pack_start(GTK_BOX(vbox), button, FALSE, FALSE, 0);
+
+	adapter->button_on = button;
+
+	g_signal_connect(G_OBJECT(button), "toggled",
+					G_CALLBACK(mode_callback), adapter);
+
 	button = gtk_radio_button_new_with_label(group,
 					_("Other devices can connect"));
 	group = gtk_radio_button_get_group(GTK_RADIO_BUTTON(button));
-- 
1.5.6.1.204.g699135
