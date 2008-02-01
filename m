Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201626238.6218.17.camel@violet>
References: <1201228119.2389.20.camel@cookie.hadess.net>
	<1201278912.2389.39.camel@cookie.hadess.net>
	<1201626238.6218.17.camel@violet>
Content-Type: multipart/mixed; boundary="=-SP5i/l0oHcl9s/GKLV4f"
Date: Fri, 01 Feb 2008 12:50:14 +0000
Message-Id: <1201870214.2389.324.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make device selection look better
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


--=-SP5i/l0oHcl9s/GKLV4f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, 2008-01-29 at 18:03 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > Here's a patch to make the device selection widget look better, from the
> > > bug http://bugzilla.gnome.org/show_bug.cgi?id=505222
> > > 
> > > Before:
> > > http://bugzilla.gnome.org/attachment.cgi?id=103695&action=view
> > > After:
> > > http://bugzilla.gnome.org/attachment.cgi?id=103696&action=view
> > 
> > Updated patch with some fixes:
> > http://bugzilla.gnome.org/show_bug.cgi?id=505222#c18
> 
> patch has been applied. Please check bluetooth-applet and make sure its
> usage of the device selector is correct and HIG compliant.

Patch attached.

--=-SP5i/l0oHcl9s/GKLV4f
Content-Disposition: attachment; filename=bluez-gnome-fix-browse-dialogue.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-browse-dialogue.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.96
diff -u -p -r1.96 main.c
--- main.c	16 Jan 2008 15:41:03 -0000	1.96
+++ main.c	1 Feb 2008 12:49:50 -0000
@@ -1620,9 +1620,11 @@ static void browse_callback(GObject *wid
 
 	gtk_window_set_default_size(GTK_WINDOW(dialog), 450, 360);
 
-	gtk_container_set_border_width(GTK_CONTAINER(dialog), 6);
+	gtk_container_set_border_width (GTK_CONTAINER (dialog), 5);
+	gtk_box_set_spacing (GTK_BOX (GTK_DIALOG (dialog)->vbox), 2);
 
 	selector = bluetooth_device_selection_new(_("Select device to browse"));
+	gtk_container_set_border_width(GTK_CONTAINER(selector), 5);
 
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
 

--=-SP5i/l0oHcl9s/GKLV4f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-SP5i/l0oHcl9s/GKLV4f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-SP5i/l0oHcl9s/GKLV4f--
