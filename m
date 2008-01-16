Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-F1CSDHBsSgERYNsGX0D/"
Date: Wed, 16 Jan 2008 12:55:27 +0000
Message-Id: <1200488127.26259.23.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Add more supported HAL classes
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


--=-F1CSDHBsSgERYNsGX0D/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Server and handheld are both supported minor classes for HAL and hcid,
so we should handle them appropriately.

Simple patch attached.

Cheers

--=-F1CSDHBsSgERYNsGX0D/
Content-Disposition: attachment; filename=bluez-gnome-add-more-classes.patch
Content-Type: text/x-patch; name=bluez-gnome-add-more-classes.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.95
diff -u -p -r1.95 main.c
--- applet/main.c	22 Dec 2007 00:09:15 -0000	1.95
+++ applet/main.c	16 Jan 2008 12:54:30 -0000
@@ -1271,7 +1271,10 @@ static char *get_form_factor(void)
 	libhal_ctx_shutdown(ctx, NULL);
 	libhal_ctx_free(ctx);
 
-	if (strcmp(formfactor, "laptop") && strcmp(formfactor, "desktop")) {
+	if (strcmp(formfactor, "laptop")
+	    && strcmp(formfactor, "desktop")
+	    && strcmp (formfactor, "server")
+	    && strcmp (formfactor, "handheld")) {
 		/* We don't know anything else */
 		g_free(formfactor);
 		formfactor = g_strdup("uncategorized");
Index: properties/adapter.c
===================================================================
RCS file: /cvsroot/bluez/gnome/properties/adapter.c,v
retrieving revision 1.17
diff -u -p -r1.17 adapter.c
--- properties/adapter.c	29 Aug 2007 15:41:49 -0000	1.17
+++ properties/adapter.c	16 Jan 2008 12:54:31 -0000
@@ -227,6 +227,12 @@ static void class_callback(GtkWidget *co
 	case 2:
 		minor = "laptop";
 		break;
+	case 3:
+		minor = "server";
+		break;
+	case 4:
+		minor = "handheld";
+		break;
 	default:
 		return;
 	}
@@ -705,6 +711,10 @@ static void create_adapter(struct adapte
 						_("Desktop workstation"));
 	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox),
 						_("Laptop computer"));
+	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox),
+						_("Server"));
+	gtk_combo_box_append_text(GTK_COMBO_BOX(combobox),
+						_("Handheld"));
 	gtk_box_pack_start(GTK_BOX(vbox), combobox, FALSE, FALSE, 0);
 
 	if (major && minor && g_ascii_strcasecmp(major, "computer") == 0) {
@@ -714,6 +724,10 @@ static void create_adapter(struct adapte
 			index = 1;
 		else if (g_ascii_strcasecmp(minor, "laptop") == 0)
 			index = 2;
+		else if (g_ascii_strcasecmp(minor, "server") == 0)
+			index = 3;
+		else if (g_ascii_strcasecmp(minor, "handheld") == 0)
+			index = 4;
 		else
 			index = -1;
 

--=-F1CSDHBsSgERYNsGX0D/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-F1CSDHBsSgERYNsGX0D/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-F1CSDHBsSgERYNsGX0D/--
