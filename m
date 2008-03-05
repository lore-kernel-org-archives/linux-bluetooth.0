Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-2oBwnddPIy9w75ICfBC9"
Date: Wed, 05 Mar 2008 21:58:41 +0000
Message-Id: <1204754321.2640.79.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Set "filter" property correctly
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


--=-2oBwnddPIy9w75ICfBC9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

- Set the default property to "phones" in the test application
- Fix setting filter properties in the device selection widget

Cheers

--=-2oBwnddPIy9w75ICfBC9
Content-Disposition: attachment; filename=bluez-gnome-set-filter-property.patch
Content-Type: text/x-patch; name=bluez-gnome-set-filter-property.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.17
diff -u -p -u -p -r1.17 bluetooth-device-selection.c
--- bluetooth-device-selection.c	12 Feb 2008 17:26:57 -0000	1.17
+++ bluetooth-device-selection.c	5 Mar 2008 21:56:29 -0000
@@ -656,7 +656,7 @@ bluetooth_device_selection_set_property 
 		break;
 	case PROP_DEVICE_TYPE_FILTER:
 		priv->device_type_filter = g_value_get_int (value);
-		gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter);
+		gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter >> 1);
 		break;
 	case PROP_DEVICE_CATEGORY_FILTER:
 		priv->device_category_filter = g_value_get_int (value);
Index: test-deviceselection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-deviceselection.c,v
retrieving revision 1.6
diff -u -p -u -p -r1.6 test-deviceselection.c
--- test-deviceselection.c	2 Feb 2008 04:09:39 -0000	1.6
+++ test-deviceselection.c	5 Mar 2008 21:56:29 -0000
@@ -29,6 +29,7 @@
 #include <gtk/gtk.h>
 
 #include "bluetooth-device-selection.h"
+#include "client.h"
 
 static void device_selected_cb(GObject *object,
 			       GParamSpec *spec, gpointer user_data)
@@ -78,7 +79,10 @@ int main(int argc, char **argv)
 	selector = bluetooth_device_selection_new("Select a Device to Setup");
 	gtk_container_set_border_width(GTK_CONTAINER(selector), 5);
 	gtk_widget_show(selector);
-	g_object_set(selector, "show-search", TRUE, NULL);
+	g_object_set(selector,
+		     "show-search", TRUE,
+		     "device-type-filter", BLUETOOTH_TYPE_PHONE,
+		     NULL);
 	g_signal_connect(selector, "selected-device-changed",
 			 G_CALLBACK(select_device_changed), dialog);
 	g_signal_connect(selector, "notify::device-selected",

--=-2oBwnddPIy9w75ICfBC9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-2oBwnddPIy9w75ICfBC9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-2oBwnddPIy9w75ICfBC9--
