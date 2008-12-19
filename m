Return-Path: <cyrus@holtmann.org>
Subject: [bluez-gnome/proximity] replace g_timeout_add with
 g_timeout_add_seconds
From: Baptiste Mille-Mathias <baptiste.millemathias@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-DFMKjFnivVcqwmYa+7KF"
Date: Fri, 19 Dec 2008 12:27:12 +0100
Message-Id: <1229686032.6392.4.camel@oak>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-DFMKjFnivVcqwmYa+7KF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Please find attached a patch to replace the usage of g_timeout_add with
g_timeout_add_seconds in the proximity application in bluez-gnome.
g_timeout_add_seconds does less wake up, ans so saves a little bit of
power.

Could someone review it and commit it?

thanks a lot.

Cheers.

-- 
Baptiste Mille-Mathias <baptiste.millemathias@gmail.com>

--=-DFMKjFnivVcqwmYa+7KF
Content-Disposition: attachment; filename="bluez-gnome_565084.diff"
Content-Type: text/x-patch; name="bluez-gnome_565084.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/proximity/main.c b/proximity/main.c
index d295be5..71e9128 100644
--- a/proximity/main.c
+++ b/proximity/main.c
@@ -80,7 +80,7 @@ static void clicked_callback(GtkWidget *button, gpointer user_data)
 	if (error != NULL) {
 		gtk_statusbar_push(GTK_STATUSBAR(statusbar), 0,
 							error->message);
-		g_timeout_add(3000, message_remove, NULL);
+		g_timeout_add_seconds(3, message_remove, NULL);
 		g_error_free(error);
 	}
 }
@@ -100,7 +100,7 @@ static void cancel_callback(GtkWidget *button, gpointer user_data)
 	if (error != NULL) {
 		gtk_statusbar_push(GTK_STATUSBAR(statusbar), 0,
 							error->message);
-		g_timeout_add(3000, message_remove, NULL);
+		g_timeout_add_seconds(3, message_remove, NULL);
 		g_error_free(error);
 	}
 }
@@ -127,7 +127,7 @@ static void periodic_callback(GtkWidget *widget, gpointer user_data)
 		if (error != NULL) {
 			gtk_statusbar_push(GTK_STATUSBAR(statusbar), 0,
 							error->message);
-			g_timeout_add(3000, message_remove, NULL);
+			g_timeout_add_seconds(3, message_remove, NULL);
 			g_error_free(error);
 
 			gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(widget),
@@ -140,7 +140,7 @@ static void periodic_callback(GtkWidget *widget, gpointer user_data)
 		if (error != NULL) {
 			gtk_statusbar_push(GTK_STATUSBAR(statusbar), 0,
 							error->message);
-			g_timeout_add(3000, message_remove, NULL);
+			g_timeout_add_seconds(3, message_remove, NULL);
 			g_error_free(error);
 
 			gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(widget),

--=-DFMKjFnivVcqwmYa+7KF--

