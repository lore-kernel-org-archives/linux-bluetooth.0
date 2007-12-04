Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196701498.12292.133.camel@violet>
References: <1196677470.3227.192.camel@cookie.hadess.net>
	<1196699212.12292.115.camel@violet>
	<1196699566.3227.215.camel@cookie.hadess.net>
	<1196701498.12292.133.camel@violet>
Content-Type: multipart/mixed; boundary="=-1R0uerjz4BVmISn3S4NE"
Date: Tue, 04 Dec 2007 14:03:42 +0000
Message-Id: <1196777022.3227.245.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [patch] Use buttons in notification popups
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


--=-1R0uerjz4BVmISn3S4NE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2007-12-03 at 18:04 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > As reported here:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=407551
> > > > 
> > > > notification-daemon kind of sucks and doesn't allow for long messages
> > > > (it will clip the messages, see those screenshots:
> > > > https://bugzilla.redhat.com/attachment.cgi?id=274901
> > > > https://bugzilla.redhat.com/attachment.cgi?id=274911
> > > > )
> > > > 
> > > > Attached patch removes the extra lines, and adds a button to the popup
> > > > instead. It looks better, and still pops up the dialogues as expected.
> > > 
> > > look good to me. Any special requirements on the version of libnotify to
> > > make this work?
> > 
> > I don't think so, but this seems to work on any recent version of
> > libnotify I've seen. And it's the same API you've used (just the
> > "action" is different).
> 
> I gonna double check, but otherwise the patch is fine and committed.
> 
> About the _(action). I don't think we should do the translation this
> way. Lets translate the string where there actually are an not mask them
> with N(). It confuses me, but you are a better expert in this area.

Attached patch fixes that.

Cheers

--=-1R0uerjz4BVmISn3S4NE
Content-Disposition: attachment; filename=bluez-gnome-remove-gettext-noop.patch
Content-Type: text/x-patch; name=bluez-gnome-remove-gettext-noop.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.88
diff -u -p -r1.88 main.c
--- main.c	3 Dec 2007 17:03:31 -0000	1.88
+++ main.c	4 Dec 2007 14:02:19 -0000
@@ -686,7 +686,7 @@ static void show_notification(const gcha
 	notify_notification_add_action(notify, "default", "action",
 						callback, NULL, NULL);
 	if (action != NULL)
-		notify_notification_add_action(notify, "button", _(action),
+		notify_notification_add_action(notify, "button", action,
 					       callback, NULL, NULL);
 
 	notify_notification_show(notify, NULL);
@@ -792,7 +792,7 @@ static gboolean passkey_agent_request(Pa
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-					line, N_("Enter passkey"), 0,
+					line, _("Enter passkey"), 0,
 					G_CALLBACK(notification_closed));
 
 	g_free(line);
@@ -832,7 +832,7 @@ static gboolean passkey_agent_confirm(Pa
 	g_free(device);
 
 	show_notification(adapter ? adapter : _("Bluetooth device"),
-					line, N_("Confirm pairing"), 0,
+					line, _("Confirm pairing"), 0,
 					G_CALLBACK(notification_closed));
 
 	g_free (line);

--=-1R0uerjz4BVmISn3S4NE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--=-1R0uerjz4BVmISn3S4NE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-1R0uerjz4BVmISn3S4NE--
